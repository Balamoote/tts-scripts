#!/usr/bin/env python3
"""
Модель для разрешения омографов на основе Logistic Regression.

Модель:
    - Обучается на признаках из FeatureExtractor
    - Использует Logistic Regression для классификации
    - Компактная (вектор весов + словарь признаков)
    - Быстрая (линейная модель)
    - Поддерживает вероятности для confidence score
"""

import pickle
import gzip
import sys
import warnings
from typing import Dict, List, Tuple, Optional, Any
from pathlib import Path
import numpy as np
from scipy.special import softmax
from scipy.sparse import csr_matrix
from sklearn.linear_model import LogisticRegression
from sklearn.feature_selection import SelectKBest, chi2
from collections import Counter

# Отключаем предупреждения sklearn
warnings.filterwarnings('ignore', category=FutureWarning)
warnings.filterwarnings('ignore', category=UserWarning)

from morph_dict import MorphDictionary
from features import FeatureExtractor
from parser import HomographParser


class HomographModel:
    """
    Модель для разрешения одного омографа.
    
    Использует Logistic Regression поверх признаков FeatureExtractor.
    """
    
    def __init__(self, homograph: str, num_meanings: int, 
                 window_size: int = 3, C: float = 1.0,
                 group_words: List[str] = None):
        """
        Инициализация модели.
        
        Args:
            homograph: базовая форма омографа
            num_meanings: количество значений (2 или 3)
            window_size: размер окна для признаков
            C: параметр регуляризации (меньше = сильнее регуляризация)
        """
        self.homograph = homograph
        self.num_meanings = num_meanings
        self.window_size = window_size
        self.C = C
        
        # Слова, для которых работает модель (если None — только homograph)
        self.group_words: List[str] = group_words if group_words else [homograph]
        self.is_group_model = len(self.group_words) > 1
        
        self.feature_extractor = FeatureExtractor(window_size=window_size)
        self.feature_names: List[str] = []
        self.feature_to_idx: Dict[str, int] = {}
        
        # Веса модели (для каждого класса)
        self.weights: Optional[np.ndarray] = None
        self.bias: Optional[np.ndarray] = None
        
        # Статистика обучения
        self.train_accuracy: float = 0.0
        self.n_samples: int = 0
        self.class_prior: Optional[np.ndarray] = None
        
        self.min_confidence = 0.90
        
        # Контексты, где модель ошибается — отказываемся от предсказания
        self.refuse_contexts: set = set()
        
        # Ударные формы для каждого значения
        self.accent_variants: Dict[int, str] = {}
        
    def _build_feature_matrix(self, features_list: List[Dict[str, float]]) -> csr_matrix:
        """
        Строит разреженную матрицу признаков из списка словарей.
        
        Args:
            features_list: список словарей признаков
            
        Returns:
            разреженная матрица признаков (n_samples x n_features)
        """
        n_samples = len(features_list)
        n_features = len(self.feature_names)
        
        rows = []
        cols = []
        data = []
        
        for i, features in enumerate(features_list):
            for feat_name, feat_value in features.items():
                if feat_name in self.feature_to_idx:
                    idx = self.feature_to_idx[feat_name]
                    rows.append(i)
                    cols.append(idx)
                    data.append(feat_value)
        
        X = csr_matrix((data, (rows, cols)), shape=(n_samples, n_features), dtype=np.float32)
        
        return X
    
    def _get_context_signature(self, tokens: List[str], homograph_pos: int) -> str:
        """
        Создает сигнатуру контекста для отказа от предсказания.
        
        Сигнатура включает ближайшие слова (лексический контекст),
        которые определяют ошибку модели.
        """
        # Берем 2 слова слева и 2 справа
        left = tokens[max(0, homograph_pos - 2):homograph_pos]
        right = tokens[homograph_pos + 1:min(len(tokens), homograph_pos + 3)]
        
        # Очищаем от |meaning_id, убираем ударения, ё→е, нижний регистр
        left_clean = []
        for w in left:
            if '|' in w:
                w = w.split('|')[0]
            w = self.feature_extractor.normalize_word(w)
            left_clean.append(w)
        
        right_clean = []
        for w in right:
            if '|' in w:
                w = w.split('|')[0]
            w = self.feature_extractor.normalize_word(w)
            right_clean.append(w)
        
        signature = ' '.join(left_clean) + ' __HOMO__ ' + ' '.join(right_clean)
        return signature
    
    def learn_refuse_contexts(self, parsed_data: List[Tuple[List[str], int, int]],
                              morph_dict: MorphDictionary) -> int:
        """
        Находит ошибки модели и запоминает их контексты для отказа.
        
        Args:
            parsed_data: размеченные данные
            morph_dict: морфологический словарь
            
        Returns:
            количество запомненных контекстов
        """
        self.refuse_contexts.clear()
        
        # Кэш по ключевым словам для быстрого поиска
        self.refuse_by_word: Dict[str, set] = {}
        
        # Извлекаем признаки для всех примеров батчем
        features_list = []
        labels = []
        tokens_list = []
        positions = []
        
        for tokens, pos, true_label in parsed_data:
            features = self.feature_extractor.extract_features(tokens, pos, morph_dict)
            features_list.append(features)
            labels.append(true_label)
            tokens_list.append(tokens)
            positions.append(pos)
        
        # Строим матрицу
        X = self._build_feature_matrix(features_list)
        
        # Предсказываем батчем
        predictions = self._predict_from_matrix(X)
        
        # Находим ошибки
        for i, (tokens, pos, true_label) in enumerate(parsed_data):
            if predictions[i] != true_label:
                signature = self._get_context_signature(tokens, pos)
                self.refuse_contexts.add(signature)
                
                # Кэшируем по словам контекста
                for j in range(max(0, pos - 2), min(len(tokens), pos + 3)):
                    if j == pos:
                        continue
                    w = tokens[j]
                    if '|' in w:
                        w = w.split('|')[0]
                    w = self.feature_extractor.normalize_word(w)
                    
                    if w not in self.refuse_by_word:
                        self.refuse_by_word[w] = set()
                    self.refuse_by_word[w].add(signature)
        
        return len(self.refuse_contexts)
    
    def _softmax(self, logits: np.ndarray) -> np.ndarray:
        """
        Вычисляет softmax для логитов.
        
        Args:
            logits: массив логитов (n_samples x n_classes)
            
        Returns:
            вероятности (n_samples x n_classes)
        """
        return softmax(logits, axis=1)
    
    def _logistic_regression_fit(self, X: csr_matrix, y: np.ndarray) -> Tuple[np.ndarray, np.ndarray]:
        """
        Обучает Logistic Regression через sklearn SGDClassifier.
        
        Args:
            X: разреженная матрица признаков (n_samples x n_features)
            y: метки классов (n_samples)
            
        Returns:
            (weights, bias) — веса и смещения
        """
        # Используем LogisticRegression с L1 регуляризацией
        clf = LogisticRegression(
            C=1.0,
            max_iter=1000,
            solver='liblinear',
            penalty='l1',
            random_state=42,
            n_jobs=-1
        )
        
        clf.fit(X, y)
        
        # Извлекаем веса
        weights = clf.coef_.copy()
        bias = clf.intercept_.copy()
        
        # Для бинарной классификации создаем веса для обоих классов
        if self.num_meanings == 2 and weights.shape[0] == 1:
            w1 = weights[0]
            b1 = bias[0]
            weights = np.vstack([-w1, w1])
            bias = np.array([-b1, b1])
        
        return weights, bias
    
    def train(self, parsed_data: List[Tuple[List[str], int, int]], 
              morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Обучает модель на размеченных данных.
        
        Args:
            parsed_data: список (tokens, homograph_pos, meaning_id)
            morph_dict: морфологический словарь
            
        Returns:
            словарь со статистикой обучения
        """
        print(f"Обучение модели для '{self.homograph}'...")
        print(f"Примеров: {len(parsed_data)}")
        
        # Обновляем частоты слов
        all_tokens = [tokens for tokens, _, _ in parsed_data]
        self.feature_extractor.update_frequencies(all_tokens)
        
        # Извлекаем признаки
        features_list = []
        labels = []
        
        print(f"Извлечение признаков для {len(parsed_data)} примеров...")
        for tokens, pos, meaning_id in parsed_data:
            features = self.feature_extractor.extract_features(tokens, pos, morph_dict)
            features_list.append(features)
            labels.append(meaning_id)
        
        # Строим словарь признаков
        self.feature_names = sorted(set().union(*[set(f.keys()) for f in features_list]))
        self.feature_to_idx = {name: idx for idx, name in enumerate(self.feature_names)}
        
        print(f"Признаков: {len(self.feature_names)}")
        
        # Строим матрицу признаков
        X = self._build_feature_matrix(features_list)
        y = np.array(labels)
        
        # Отбор признаков chi2 (если признаков > 50000)
        if X.shape[1] > 50000:
            print(f"Отбор признаков chi2: {X.shape[1]} -> 50000")
            selector = SelectKBest(chi2, k=50000)
            X = selector.fit_transform(X, y)
            
            # Обновляем feature_names и feature_to_idx
            selected_indices = selector.get_support(indices=True)
            self.feature_names = [self.feature_names[i] for i in selected_indices]
            self.feature_to_idx = {name: idx for idx, name in enumerate(self.feature_names)}
        
        # Отбор признаков отключен (LogisticRegression с L1 сам отберёт важные)
        
        # Сохраняем априорные вероятности классов
        class_counts = Counter(labels)
        self.class_prior = np.array([class_counts.get(i, 0) / len(labels) 
                                     for i in range(self.num_meanings)])
        
        # Обучаем модель
        self.weights, self.bias = self._logistic_regression_fit(X, y)
        
        # Вычисляем точность на обучении
        predictions = self._predict_from_matrix(X)
        self.train_accuracy = np.mean(predictions == y)
        self.n_samples = len(labels)
        
        # Частотные паттерны: глагол + значение омографа
        self.verb_homo_freq: Dict[str, Dict[int, int]] = {}
        
        for tokens, pos, meaning_id in parsed_data:
            # Находим глаголы в контексте
            for i, word in enumerate(tokens):
                if i == pos:
                    continue
                
                word_norm = self.feature_extractor.normalize_word(word)
                morphs = morph_dict.get_morphology(word_norm)
                
                for morph, base_form in morphs:
                    if morph.startswith('гл'):
                        if base_form not in self.verb_homo_freq:
                            self.verb_homo_freq[base_form] = {}
                        if meaning_id not in self.verb_homo_freq[base_form]:
                            self.verb_homo_freq[base_form][meaning_id] = 0
                        self.verb_homo_freq[base_form][meaning_id] += 1
                        break
        
        stats = {
            "n_samples": self.n_samples,
            "n_features": len(self.feature_names),
            "train_accuracy": self.train_accuracy,
            "class_prior": self.class_prior.tolist()
        }
        
        print(f"Точность на обучении: {self.train_accuracy:.3f}")
        print(f"Априорные вероятности: {self.class_prior}")
        
        return stats
    
    def _predict_from_matrix(self, X: csr_matrix) -> np.ndarray:
        """
        Предсказывает классы для матрицы признаков.
        
        Args:
            X: матрица признаков
            
        Returns:
            массив предсказанных классов
        """
        logits = X @ self.weights.T + self.bias
        return np.argmax(logits, axis=1)
    
    def _predict_proba_from_matrix(self, X: csr_matrix) -> np.ndarray:
        """
        Предсказывает вероятности для матрицы признаков.
        
        Args:
            X: матрица признаков
            
        Returns:
            матрица вероятностей (n_samples x n_classes)
        """
        logits = X @ self.weights.T + self.bias
        return self._softmax(logits)
    
    def predict(self, tokens: List[str], homograph_pos: int, 
                morph_dict: MorphDictionary) -> Dict[str, Any]:
        """
        Предсказывает значение омографа в предложении.
        
        Args:
            tokens: список токенов предложения
            homograph_pos: позиция омографа
            morph_dict: морфологический словарь
            
        Returns:
            словарь с результатами:
                - meaning_id: предсказанное значение
                - confidence: уверенность модели
                - probabilities: вероятности всех значений
                - is_confident: достаточно ли уверена модель
        """
        if self.weights is None:
            raise ValueError("Модель не обучена!")
        
        # Проверяем, не входит ли контекст в список отказа
        context_signature = self._get_context_signature(tokens, homograph_pos)
        if context_signature in self.refuse_contexts:
            return {
                "meaning_id": None,
                "confidence": 0.0,
                "probabilities": [],
                "is_confident": False,
                "prediction_made": False,
                "refused": True
            }
        
        # Нечёткое сравнение через кэш
        if hasattr(self, 'refuse_by_word'):
            current_words = set()
            
            for i in range(max(0, homograph_pos - 2), min(len(tokens), homograph_pos + 3)):
                if i == homograph_pos:
                    continue
                w = tokens[i]
                if '|' in w:
                    w = w.split('|')[0]
                w = self.feature_extractor.normalize_word(w)
                current_words.add(w)
            
            # Собираем кандидатов из кэша
            candidates = set()
            for w in current_words:
                if w in self.refuse_by_word:
                    candidates.update(self.refuse_by_word[w])
            
            # Проверяем кандидатов на похожесть
            for sig in candidates:
                parts = sig.split(' __HOMO__ ')
                left_words = set(parts[0].split()) if parts[0] else set()
                right_words = set(parts[1].split()) if len(parts) > 1 and parts[1] else set()
                refused_words = left_words | right_words
                
                overlap = len(current_words & refused_words)
                
                if overlap >= 2 and overlap / len(current_words) >= 0.7:
                    return {
                        "meaning_id": None,
                        "confidence": 0.0,
                        "probabilities": [],
                        "is_confident": False,
                        "prediction_made": False,
                        "refused": True
                    }
        
        # Извлекаем признаки
        features = self.feature_extractor.extract_features(tokens, homograph_pos, morph_dict)
        
        # Добавляем частотные паттерны глагол+омограф
        if hasattr(self, 'verb_homo_freq'):
            for i, word in enumerate(tokens):
                if i == homograph_pos:
                    continue
                
                word_norm = self.feature_extractor.normalize_word(word)
                morphs = morph_dict.get_morphology(word_norm)
                
                for morph, base_form in morphs:
                    if morph.startswith('гл') and base_form in self.verb_homo_freq:
                        # Частота этого глагола с каждым значением
                        for meaning_id in range(self.num_meanings):
                            count = self.verb_homo_freq[base_form].get(meaning_id, 0)
                            features[f'verb_homo_freq_{base_form}_{meaning_id}'] = float(count)
                        break
        
        # Строим вектор признаков
        X = self._build_feature_matrix([features])
        
        # Предсказываем
        probabilities = self._predict_proba_from_matrix(X)[0]
        meaning_id = int(np.argmax(probabilities))
        confidence = float(probabilities[meaning_id])
        
        # Если уверенность ниже порога — отказываемся от предсказания
        prediction_made = confidence >= self.min_confidence
        
        return {
            "meaning_id": meaning_id if prediction_made else None,
            "confidence": confidence,
            "probabilities": probabilities.tolist(),
            "is_confident": prediction_made,
            "prediction_made": prediction_made,
            "refused": False
        }
    
    def predict_batch(self, token_lists: List[List[str]], positions: List[int],
                     morph_dict: MorphDictionary) -> List[Dict[str, Any]]:
        """
        Предсказывает значения для батча предложений.
        
        Args:
            token_lists: список списков токенов
            positions: список позиций омографов
            morph_dict: морфологический словарь
            
        Returns:
            список словарей с результатами
        """
        results = []
        
        # Извлекаем признаки для всех предложений
        features_list = []
        for tokens, pos in zip(token_lists, positions):
            features = self.feature_extractor.extract_features(tokens, pos, morph_dict)
            features_list.append(features)
        
        # Строим матрицу
        X = self._build_feature_matrix(features_list)
        
        # Предсказываем
        probabilities = self._predict_proba_from_matrix(X)
        
        for i, probs in enumerate(probabilities):
            meaning_id = int(np.argmax(probs))
            confidence = float(probs[meaning_id])
            
            prediction_made = confidence >= self.min_confidence
            
            results.append({
                "meaning_id": meaning_id if prediction_made else None,
                "confidence": confidence,
                "probabilities": probs.tolist(),
                "is_confident": prediction_made,
                "prediction_made": prediction_made
            })
        
        return results
    
    def get_weights_for_class(self, meaning_id: int, top_n: int = 20) -> List[Tuple[str, float]]:
        """
        Возвращает наиболее важные признаки для класса.
        
        Args:
            meaning_id: идентификатор значения
            top_n: количество признаков
            
        Returns:
            список (имя_признака, вес)
        """
        if self.weights is None:
            return []
        
        weights = self.weights[meaning_id]
        indices = np.argsort(np.abs(weights))[::-1][:top_n]
        
        return [(self.feature_names[idx], weights[idx]) for idx in indices]
    
    def save(self, filepath: str):
        """
        Сохраняет модель в файл.
        
        Args:
            filepath: путь к файлу
        """
        Path(filepath).parent.mkdir(parents=True, exist_ok=True)
        
        # Компрессия: сохраняем только ненулевые веса
        nonzero_mask = np.any(self.weights != 0, axis=0)
        nonzero_indices = np.where(nonzero_mask)[0]
        
        compressed_weights = self.weights[:, nonzero_indices]
        compressed_feature_names = [self.feature_names[i] for i in nonzero_indices]
        compressed_feature_to_idx = {name: idx for idx, name in enumerate(compressed_feature_names)}
        
        print(f"Компрессия: {len(self.feature_names)} -> {len(compressed_feature_names)} признаков")
        
        data = {
            "homograph": self.homograph,
            "group_words": self.group_words,
            "is_group_model": self.is_group_model,
            "num_meanings": self.num_meanings,
            "window_size": self.window_size,
            "C": self.C,
            "feature_names": compressed_feature_names,
            "feature_to_idx": compressed_feature_to_idx,
            "weights": compressed_weights,
            "bias": self.bias,
            "train_accuracy": self.train_accuracy,
            "n_samples": self.n_samples,
            "class_prior": self.class_prior,
            "min_confidence": self.min_confidence,
            "refuse_contexts": self.refuse_contexts,
            "accent_variants": self.accent_variants
        }
        
        # Если путь не заканчивается на .gz — добавляем
        filepath = str(filepath)
        
        if not filepath.endswith('.gz'):
            filepath = filepath + '.gz'
        
        with gzip.open(filepath, 'wb') as f:
            pickle.dump(data, f, protocol=pickle.HIGHEST_PROTOCOL)
        
        file_size = Path(filepath).stat().st_size
        print(f"Модель сохранена в {filepath} ({file_size} байт)")
    
    def load(self, filepath: str):
        """
        Загружает модель из файла.
        
        Args:
            filepath: путь к файлу
        """
        filepath = str(filepath)
        
        if filepath.endswith('.gz'):
            with gzip.open(filepath, 'rb') as f:
                data = pickle.load(f)
        else:
            with open(filepath, 'rb') as f:
                data = pickle.load(f)
        
        self.homograph = data["homograph"]
        self.group_words = data.get("group_words", [self.homograph])
        self.is_group_model = data.get("is_group_model", False)
        self.num_meanings = data["num_meanings"]
        self.window_size = data.get("window_size", 3)
        self.C = data.get("C", 1.0)
        self.feature_names = data["feature_names"]
        self.feature_to_idx = data["feature_to_idx"]
        self.weights = data["weights"]
        self.bias = data["bias"]
        self.train_accuracy = data.get("train_accuracy", 0.0)
        self.n_samples = data.get("n_samples", 0)
        self.class_prior = data.get("class_prior")
        self.min_confidence = data.get("min_confidence", 0.7)
        self.refuse_contexts = data.get("refuse_contexts", set())
        self.accent_variants = data.get("accent_variants", {})
        
        # Восстанавливаем feature_extractor
        self.feature_extractor = FeatureExtractor(window_size=self.window_size)
        
        # Не печатаем в stdout — только в stderr для отладки
        # print(f"Модель загружена из {filepath}", file=sys.stderr)
    
    def get_stats(self) -> Dict[str, Any]:
        """
        Возвращает статистику модели.
        
        Returns:
            словарь со статистикой
        """
        return {
            "homograph": self.homograph,
            "num_meanings": self.num_meanings,
            "n_features": len(self.feature_names),
            "n_samples": self.n_samples,
            "train_accuracy": self.train_accuracy,
            "class_prior": self.class_prior.tolist() if self.class_prior is not None else None
        }
    
    def evaluate_with_thresholds(self, test_data: List[Tuple[List[str], int, int]],
                                 morph_dict: MorphDictionary,
                                 thresholds: List[float] = None) -> List[Dict[str, float]]:
        """
        Оценивает точность и покрытие при разных порогах уверенности.
        
        Args:
            test_data: список (tokens, homograph_pos, meaning_id)
            morph_dict: морфологический словарь
            thresholds: список порогов для оценки
            
        Returns:
            список с метриками для каждого порога
        """
        if thresholds is None:
            thresholds = [0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.99]
        
        results = []
        
        for threshold in thresholds:
            correct = 0
            total = 0
            predicted = 0
            
            for tokens, pos, true_label in test_data:
                prediction = self.predict(tokens, pos, morph_dict)
                total += 1
                
                if prediction['confidence'] >= threshold:
                    predicted += 1
                    if prediction['meaning_id'] == true_label:
                        correct += 1
            
            accuracy = correct / predicted if predicted > 0 else 0
            coverage = predicted / total if total > 0 else 0
            
            results.append({
                'threshold': threshold,
                'accuracy': accuracy,
                'coverage': coverage,
                'predicted': predicted,
                'total': total
            })
        
        return results


def main():
    """
    Тестовая функция для проверки модели.
    """
    print("=== Тестирование HomographModel ===\n")
    
    # Загружаем словари
    print("Загрузка словарей...")
    morph_dict = MorphDictionary("scriptdb")
    morph_dict.load_all()
    
    # Создаем парсер
    parser = HomographParser(
        homograph="замок",
        accent_variants={
            0: "замо́к",  # запор
            1: "за́мок"   # строение
        }
    )
    
    # Создаем размеченный корпус
    corpus = [
        "На двери висел большой замо́к.",
        "Мы посетили старинный за́мок.",
        "Открой замо́к ключом.",
        "Средневековый за́мок впечатляет.",
        "Ключ не подходил к замо́ку.",
        "Замок был построен в XIV веке.",
        "Сломанный замо́к валялся на земле.",
        "Этот за́мок является памятником архитектуры.",
        "Он вставил ключ в замо́к.",
        "Рыцарский за́мок стоял на холме.",
    ]
    
    print("Парсинг корпуса...")
    parsed_data, errors = parser.parse_corpus(corpus)
    print(f"Размечено: {len(parsed_data)} примеров")
    
    # Создаем и обучаем модель
    print("\nОбучение модели...")
    model = HomographModel(homograph="замок", num_meanings=2, window_size=3)
    stats = model.train(parsed_data, morph_dict)
    
    print(f"\nСтатистика:")
    for key, value in stats.items():
        print(f"  {key}: {value}")
    
    # Тестируем предсказание
    print("\nТестирование предсказаний:")
    test_sentences = [
        (["На", "двери", "висел", "большой", "замок"], 4),
        (["Мы", "посетили", "старинный", "замок"], 3),
    ]
    
    for tokens, pos in test_sentences:
        prediction = model.predict(tokens, pos, morph_dict)
        print(f"\nПредложение: {' '.join(tokens)}")
        print(f"Предсказанное значение: {prediction['meaning_id']}")
        print(f"Уверенность: {prediction['confidence']:.3f}")
        print(f"Вероятности: {prediction['probabilities']}")
    
    # Показываем важные признаки
    print("\nВажные признаки для значения 0 (запор):")
    for feature_name, weight in model.get_weights_for_class(0, top_n=10):
        print(f"  {feature_name}: {weight:.4f}")
    
    print("\nВажные признаки для значения 1 (строение):")
    for feature_name, weight in model.get_weights_for_class(1, top_n=10):
        print(f"  {feature_name}: {weight:.4f}")
    
    # Сохраняем модель
    print("\nСохранение модели...")
    model.save("model/zamok_test.pkl")
    
    # Загружаем модель
    print("\nЗагрузка модели...")
    model2 = HomographModel(homograph="", num_meanings=2)
    model2.load("model/zamok_test.pkl")
    
    # Проверяем предсказание загруженной модели
    prediction2 = model2.predict(["Открой", "замок", "ключом"], 1, morph_dict)
    print(f"\nПредсказание загруженной модели: {prediction2}")


if __name__ == "__main__":
    main()
