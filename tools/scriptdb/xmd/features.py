#!/usr/bin/env python3
"""
Модуль извлечения признаков для разрешения омографов.

Извлекает все возможные признаки из контекста:
    - Лексические (слова в окне)
    - Морфологические (из MorphDictionary)
    - Синтаксические паттерны
    - Частотные характеристики
    - Позиционные признаки
"""

from typing import Dict, List, Tuple, Set, Optional
from collections import Counter, defaultdict
from functools import lru_cache
from morph_dict import MorphDictionary
from load_semantic import load_semantic_groups, add_semantic_features


class FeatureExtractor:
    """
    Извлекает признаки из контекста омографа.
    
    Признаки:
        1. Лексические: слова слева и справа от омографа
        2. Морфологические: части речи, падежи, числа, роды и т.д.
        3. Синтаксические: предлоги, согласование, управление
        4. Позиционные: расстояние до начала/конца предложения
        5. Частотные: частота слова в корпусе
    """
    
    def __init__(self, window_size: int = 3):
        """
        Инициализация экстрактора признаков.
        
        Args:
            window_size: размер окна (сколько слов слева и справа анализировать)
        """
        self.window_size = window_size
        self.word_frequencies: Counter = Counter()
        
        # Основные грамматические категории для извлечения
        self.pos_categories = {
            'сущ': 'noun',
            'гл': 'verb',
            'прл': 'adj',
            'прч': 'participle',
            'дееп': 'gerund',
            'нар': 'adverb',
            'мест': 'pronoun',
            'числ': 'numeral',
            'предл': 'preposition',
            'союз': 'conjunction',
            'част': 'particle',
            'межд': 'interjection',
            'предик': 'predicative',
            'имя': 'name',
            'фам': 'surname',
            'отч': 'patronymic',
            'гео': 'geo',
            'орг': 'org'
        }
        
        # Падежи
        self.cases = ['им', 'род', 'дат', 'вин', 'тв', 'пр', 'мест', 'зват', 'парт', 'счет']
        
        # Числа
        self.numbers = ['ед', 'мн']
        
        # Рода
        self.genders = ['муж', 'жен', 'ср', 'общ']
        
        # Времена глаголов
        self.tenses = ['наст', 'прош', 'буд', 'инф']
        
        # Лица
        self.persons = ['1е', '2е', '3е']
        
        # Виды глаголов
        self.aspects = ['несов', 'сов', '2вид']
        
        # Переходность
        self.transitivity = ['перех', 'непер', 'перне']
        
        # Залоги
        self.voices = ['действ', 'страд', 'воз']
        
        # Символы ударений для нормализации
        self._unxy = "\u0301\u0320\u0323\u0324\u032d\u0330"
        
        # Кэш морфологии
        self._morph_cache: Dict[str, List[Tuple[str, str]]] = {}
        
        # Семантические группы (загружаются из txt)
        self.semantic_groups: Dict[str, Set[str]] = {}
        
    def load_semantic_groups(self, filepath: str):
        """
        Загружает семантические группы из txt файла.
        """
        self.semantic_groups = load_semantic_groups(filepath)
        print(f"Загружено семантических групп: {len(self.semantic_groups)}")
        
    def _get_morphology_cached(self, word: str, morph_dict: MorphDictionary) -> List[Tuple[str, str]]:
        """
        Возвращает морфологию из кэша или словаря.
        """
        if word in self._morph_cache:
            return self._morph_cache[word]
        
        morphs = morph_dict.get_morphology(word)
        self._morph_cache[word] = morphs
        return morphs
    
    def normalize_word(self, word: str) -> str:
        """
        Нормализует слово: убирает ударения и приводит к нижнему регистру.
        
        Args:
            word: словоформа с возможными ударениями
            
        Returns:
            нормализованная словоформа (без ударений, нижний регистр)
        """
        # Убираем ударения
        word = ''.join(ch for ch in word if ch not in self._unxy)
        # Заменяем ё на е
        word = word.replace('ё', 'е')
        # Приводим к нижнему регистру
        return word.lower()
    
    def _extract_homograph_form(self, word: str) -> Dict[str, float]:
        """
        Извлекает признаки формы самого омографа.
        
        Омограф НЕ нормализуется — сохраняем ударения, ё, регистр.
        
        Args:
            word: токен омографа (может быть с |meaning_id)
            
        Returns:
            словарь признаков
        """
        features = {}
        
        # Если токен содержит |meaning_id (из парсера) — убираем meaning_id
        if '|' in word:
            parts = word.split('|')
            word = parts[0]
            # НЕ добавляем homograph_meaning_X — модель должна учиться по контексту
        
        # Признаки формы
        features['homograph_is_upper'] = 1.0 if word.isupper() else 0.0
        features['homograph_is_capitalized'] = 1.0 if word[0].isupper() else 0.0
        
        return features
    
    def has_accent(self, word: str) -> bool:
        """
        Проверяет наличие ударения в слове.
        """
        return any(ch in self._unxy for ch in word)
    
    def has_yo(self, word: str) -> bool:
        """
        Проверяет наличие буквы ё в слове.
        """
        return 'ё' in word or 'Ё' in word
    
    def _extract_pos_features(self, tokens: List[str], homograph_pos: int,
                              morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает только части речи для слов в контексте.
        """
        features = {}
        
        # Глаголы после омографа (через предложные обороты)
        for i in range(homograph_pos + 1, min(len(tokens), homograph_pos + 6)):
            word_norm = self.normalize_word(tokens[i])
            word_morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base_form in word_morphs:
                if morph.startswith('гл'):
                    relative_dist = i - homograph_pos
                    features[f'verb_after_homo_{relative_dist}_{base_form}'] = 1.0
                    
                    if '_мн_' in morph:
                        features[f'verb_after_homo_{relative_dist}_plural'] = 1.0
                    if '_ед_' in morph:
                        features[f'verb_after_homo_{relative_dist}_singular'] = 1.0
                    break
        
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        for i in range(start, end):
            if i == homograph_pos:
                continue
            
            word = tokens[i]
            word_normalized = self.normalize_word(word)
            morphs = self._get_morphology_cached(word_normalized, morph_dict)
            
            relative_pos = i - homograph_pos
            
            if morphs:
                # Только первая морфология (самая вероятная)
                morph = morphs[0][0]
                pos = morph.split('_')[0]
                features[f'pos_{relative_pos}_{pos}'] = 1.0
            else:
                features[f'pos_{relative_pos}_unknown'] = 1.0
        
        return features
    
    def _extract_simple_syntactic(self, tokens: List[str], homograph_pos: int,
                                  morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает простые синтаксические паттерны.
        """
        features = {}
        
        # Предлог перед омографом
        if homograph_pos > 0:
            prev_word = self.normalize_word(tokens[homograph_pos - 1])
            prev_morphs = morph_dict.get_morphology(prev_word)
            
            if prev_morphs and prev_morphs[0][0].startswith('предл'):
                features[f'preposition_before_{prev_word}'] = 1.0
        
        # Глагол в контексте (первый найденный)
        for i, word in enumerate(tokens):
            if i == homograph_pos:
                continue
            
            word_normalized = self.normalize_word(word)
            word_morphs = morph_dict.get_morphology(word_normalized)
            
            if word_morphs and word_morphs[0][0].startswith('гл'):
                base_form = word_morphs[0][1]
                features[f'verb_in_context_{base_form}'] = 1.0
                break
        
        return features
    
    def extract_features(self, tokens: List[str], homograph_pos: int, 
                        morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает все признаки из контекста омографа.
        
        Args:
            tokens: список токенов предложения
            homograph_pos: позиция омографа в списке токенов
            morph_dict: морфологический словарь
            
        Returns:
            словарь признаков {имя_признака: значение}
        """
        features = {}
        
        # 1. Лексические признаки
        features.update(self._extract_lexical_features(tokens, homograph_pos, morph_dict))
        
        # 2. Признаки формы самого омографа (без нормализации)
        features.update(self._extract_homograph_form(tokens[homograph_pos]))
        
        # 3. Полные морфологические признаки омографа (нормализованные)
        features.update(self._extract_homograph_morphology(tokens[homograph_pos], morph_dict))
        
        # 4. Полные морфологические признаки контекста
        features.update(self._extract_context_morphology(tokens, homograph_pos, morph_dict))
        
        # 5. Полные синтаксические паттерны
        features.update(self._extract_syntactic_patterns(tokens, homograph_pos, morph_dict))
        
        # 6. Позиционные признаки
        features.update(self._extract_positional_features(tokens, homograph_pos))
        
        # 7. Частотные признаки
        features.update(self._extract_frequency_features(tokens, homograph_pos))
        
        # 8. Семантические признаки (если группы загружены)
        if self.semantic_groups:
            features = add_semantic_features(features, tokens, homograph_pos, self.semantic_groups)
        
        return features
    
    def _extract_lexical_features(self, tokens: List[str], homograph_pos: int, 
                                  morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает лексические признаки: слова в окне вокруг омографа.
        """
        features = {}
        
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        # Слова слева (только 3 ближайших слова с точным указанием)
        for i in range(homograph_pos - 1, start - 1, -1):
            distance = homograph_pos - i
            word = tokens[i].lower()
            # Только для близких слов добавляем точные словоформы
            if distance <= 3:
                features[f'left_word_{distance}_{word}'] = 1.0
            # Для дальних — только часть речи
            else:
                word_normalized = self.normalize_word(word)
                morphs = morph_dict.get_morphology(word_normalized)
                if morphs:
                    pos = morphs[0][0].split('_')[0]
                    features[f'left_{distance}_pos_{pos}'] = 1.0
        
        # Слова справа (только 3 ближайших слова с точным указанием)
        for i in range(homograph_pos + 1, end):
            distance = i - homograph_pos
            word = tokens[i].lower()
            # Только для близких слов добавляем точные словоформы
            if distance <= 3:
                features[f'right_word_{distance}_{word}'] = 1.0
            # Для дальних — только часть речи
            else:
                word_normalized = self.normalize_word(word)
                morphs = morph_dict.get_morphology(word_normalized)
                if morphs:
                    pos = morphs[0][0].split('_')[0]
                    features[f'right_{distance}_pos_{pos}'] = 1.0
        
        # Биграммы и триграммы
        if homograph_pos > 0:
            left_word = tokens[homograph_pos - 1].lower()
            right_word = tokens[homograph_pos].lower()
            # Убираем |meaning_id из омографа
            if '|' in right_word:
                right_word = right_word.split('|')[0]
            bigram_left = f"{left_word}_{right_word}"
            features[f'bigram_left_{bigram_left}'] = 1.0
        
        if homograph_pos < len(tokens) - 1:
            left_word = tokens[homograph_pos].lower()
            right_word = tokens[homograph_pos + 1].lower()
            # Убираем |meaning_id из омографа
            if '|' in left_word:
                left_word = left_word.split('|')[0]
            bigram_right = f"{left_word}_{right_word}"
            features[f'bigram_right_{bigram_right}'] = 1.0
        
        # Bag of words (все слова контекста)
        context_words = []
        for i in range(start, end):
            if i != homograph_pos:
                word = tokens[i].lower()
                # Убираем |meaning_id если есть
                if '|' in word:
                    word = word.split('|')[0]
                context_words.append(word)
        
        for word in context_words:
            features[f'context_bow_{word}'] = 1.0
        
        return features
    
    def _extract_homograph_morphology(self, word: str, morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает морфологические признаки самого омографа.
        """
        features = {}
        
        # Признаки формы омографа (без прямых указаний на ударение/ё)
        features['homograph_is_upper'] = 1.0 if word.isupper() else 0.0
        features['homograph_is_capitalized'] = 1.0 if word[0].isupper() else 0.0
        
        # Убираем |meaning_id если есть
        if '|' in word:
            word = word.split('|')[0]
        
        # Нормализуем слово
        word_normalized = self.normalize_word(word)
        
        morphs = morph_dict.get_morphology(word_normalized)
        
        if morphs:
            # Уникальные морфологии
            unique_morphs = set()
            for morph, base_form in morphs:
                unique_morphs.add(morph)
                features[f'homograph_morph_{morph}'] = 1.0
                features[f'homograph_base_{base_form}'] = 1.0
            
            # Количество возможных морфологий
            features['homograph_morph_count'] = float(len(unique_morphs))
            
            # Извлекаем грамматические категории
            for morph in unique_morphs:
                parts = morph.split('_')
                
                # Часть речи
                if parts:
                    pos = parts[0]
                    features[f'homograph_pos_{pos}'] = 1.0
                
                # Для глаголов: вид, время, лицо, наклонение
                if 'гл' in parts:
                    for aspect in ['несов', 'сов', '2вид']:
                        if aspect in parts:
                            features[f'homograph_aspect_{aspect}'] = 1.0
                    
                    for tense in ['наст', 'прош', 'буд']:
                        if tense in parts:
                            features[f'homograph_tense_{tense}'] = 1.0
                    
                    for person in ['1е', '2е', '3е']:
                        if person in parts:
                            features[f'homograph_person_{person}'] = 1.0
                    
                    for mood in ['пов', 'изъяв']:
                        if mood in parts:
                            features[f'homograph_mood_{mood}'] = 1.0
                    
                    for trans in ['перех', 'непер', 'перне']:
                        if trans in parts:
                            features[f'homograph_transitivity_{trans}'] = 1.0
                
                # Для существительных: склонение
                if 'сущ' in parts:
                    if 'нескл' in parts:
                        features['homograph_indeclinable'] = 1.0
                
                # Падеж
                for case in self.cases:
                    if case in parts:
                        features[f'homograph_case_{case}'] = 1.0
                
                # Число
                for num in self.numbers:
                    if num in parts:
                        features[f'homograph_number_{num}'] = 1.0
                
                # Род
                for gender in self.genders:
                    if gender in parts:
                        features[f'homograph_gender_{gender}'] = 1.0
                
                # Одушевленность
                if 'одуш' in parts:
                    features['homograph_animate'] = 1.0
                elif 'неод' in parts:
                    features['homograph_inanimate'] = 1.0
        else:
            features['homograph_not_in_dict'] = 1.0
        
        return features
    
    def _extract_context_morphology(self, tokens: List[str], homograph_pos: int, 
                                   morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает морфологические признаки слов в контексте.
        """
        features = {}
        
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        # Собираем статистику по контексту
        pos_counter = Counter()
        case_counter = Counter()
        number_counter = Counter()
        gender_counter = Counter()
        tense_counter = Counter()
        person_counter = Counter()
        aspect_counter = Counter()
        
        for i in range(start, end):
            if i == homograph_pos:
                continue
            
            word = tokens[i]
            # Нормализуем слово
            word_normalized = self.normalize_word(word)
            
            morphs = morph_dict.get_morphology(word_normalized)
            
            if not morphs:
                features[f'context_{i - homograph_pos}_unknown_morph'] = 1.0
                continue
            
            # Для каждого слова в контексте
            for morph, base_form in morphs:
                parts = morph.split('_')
                
                # Часть речи
                if parts:
                    pos = parts[0]
                    pos_counter[pos] += 1
                    
                    # Для каждого слова отдельно
                    relative_pos = i - homograph_pos
                    features[f'context_{relative_pos}_pos_{pos}'] = 1.0
                    
                    # Базовая форма слова в контексте
                    features[f'context_{relative_pos}_base_{base_form}'] = 1.0
                
                # Падеж
                for case in self.cases:
                    if case in parts:
                        case_counter[case] += 1
                        features[f'context_{i - homograph_pos}_case_{case}'] = 1.0
                
                # Число
                for num in self.numbers:
                    if num in parts:
                        number_counter[num] += 1
                
                # Род
                for gender in self.genders:
                    if gender in parts:
                        gender_counter[gender] += 1
                
                # Время (для глаголов)
                for tense in self.tenses:
                    if tense in parts:
                        tense_counter[tense] += 1
                
                # Лицо (для глаголов)
                for person in self.persons:
                    if person in parts:
                        person_counter[person] += 1
                
                # Вид (для глаголов)
                for aspect in self.aspects:
                    if aspect in parts:
                        aspect_counter[aspect] += 1
        
        # Добавляем агрегированную статистику
        for pos, count in pos_counter.items():
            features[f'context_pos_{pos}_count'] = float(count)
        
        for case, count in case_counter.items():
            features[f'context_case_{case}_count'] = float(count)
        
        for num, count in number_counter.items():
            features[f'context_number_{num}_count'] = float(count)
        
        for gender, count in gender_counter.items():
            features[f'context_gender_{gender}_count'] = float(count)
        
        for tense, count in tense_counter.items():
            features[f'context_tense_{tense}_count'] = float(count)
        
        for person, count in person_counter.items():
            features[f'context_person_{person}_count'] = float(count)
        
        for aspect, count in aspect_counter.items():
            features[f'context_aspect_{aspect}_count'] = float(count)
        
        # Доминирующие категории в контексте
        # Доминирующие категории (one-hot encoding)
        if pos_counter:
            dominant_pos = pos_counter.most_common(1)[0][0]
            features[f'context_dominant_pos_{dominant_pos}'] = 1.0
        
        if case_counter:
            dominant_case = case_counter.most_common(1)[0][0]
            features[f'context_dominant_case_{dominant_case}'] = 1.0
        
        return features
    
    def _extract_syntactic_patterns(self, tokens: List[str], homograph_pos: int,
                                   morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает синтаксические паттерны.
        """
        features = {}
        
        # Предложные обороты
        prep_phrases = self._extract_prepositional_phrases(tokens, homograph_pos, morph_dict)
        features.update(prep_phrases)
        
        # 0. Информация о глаголах-сказуемых (количество, позиция, вид)
        verbs_info = self._extract_verb_info(tokens, homograph_pos, morph_dict)
        features.update(verbs_info)
        
        # 1. Предлоги с падежами (расширенно)
        prep_info = self._extract_preposition_info(tokens, homograph_pos, morph_dict)
        features.update(prep_info)
        
        # 2. Согласование с прилагательными/причастиями (расширенно)
        agreement_info = self._extract_agreement_info(tokens, homograph_pos, morph_dict)
        features.update(agreement_info)
        
        # 3. Другие омографы в предложении
        homograph_info = self._extract_neighbor_homographs(tokens, homograph_pos, morph_dict)
        features.update(homograph_info)
        
        # 4. Универсальные признаки
        universal = self._extract_universal_features(tokens, homograph_pos, morph_dict)
        features.update(universal)
        
        # 1. Предлог перед омографом
        if homograph_pos > 0:
            prev_word = tokens[homograph_pos - 1]
            # Нормализуем слово
            prev_word_normalized = self.normalize_word(prev_word)
            prev_morphs = morph_dict.get_morphology(prev_word_normalized)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('предл'):
                    features[f'pattern_preposition_before_{prev_word.lower()}'] = 1.0
                    features[f'pattern_preposition_before_base_{base_form}'] = 1.0
                    
                    # Какой падеж требует предлог
                    if 'вин' in morph:
                        features['preposition_requires_accusative'] = 1.0
                    elif 'дат' in morph:
                        features['preposition_requires_dative'] = 1.0
                    elif 'род' in morph:
                        features['preposition_requires_genitive'] = 1.0
                    elif 'тв' in morph:
                        features['preposition_requires_instrumental'] = 1.0
                    elif 'пр' in morph:
                        features['preposition_requires_prepositional'] = 1.0
        
        # 2. Прилагательное или причастие перед омографом (согласование)
        if homograph_pos > 0:
            prev_word = tokens[homograph_pos - 1]
            # Нормализуем слово
            prev_word_normalized = self.normalize_word(prev_word)
            prev_morphs = morph_dict.get_morphology(prev_word_normalized)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('прл') or morph.startswith('прч'):
                    features[f'pattern_adjective_before_{prev_word.lower()}'] = 1.0
                    features[f'pattern_adjective_before_base_{base_form}'] = 1.0
                    
                    # Согласование
                    if '_ед_' in morph:
                        features['agreement_singular'] = 1.0
                    if '_мн_' in morph:
                        features['agreement_plural'] = 1.0
                    if '_муж_' in morph:
                        features['agreement_masculine'] = 1.0
                    if '_жен_' in morph:
                        features['agreement_feminine'] = 1.0
                    if '_ср_' in morph:
                        features['agreement_neuter'] = 1.0
        
        # 3. Прилагательное или причастие после омографа
        if homograph_pos < len(tokens) - 1:
            next_word = tokens[homograph_pos + 1]
            # Нормализуем слово
            next_word_normalized = self.normalize_word(next_word)
            next_morphs = morph_dict.get_morphology(next_word_normalized)
            
            for morph, base_form in next_morphs:
                if morph.startswith('прл') or morph.startswith('прч'):
                    features[f'pattern_adjective_after_{next_word.lower()}'] = 1.0
                    features[f'pattern_adjective_after_base_{base_form}'] = 1.0
        
        # 4. Глагол в предложении
        for i, word in enumerate(tokens):
            if i == homograph_pos:
                continue
            
            # Нормализуем слово
            word_normalized = self.normalize_word(word)
            word_morphs = morph_dict.get_morphology(word_normalized)
            for morph, base_form in word_morphs:
                if morph.startswith('гл'):
                    features[f'pattern_verb_in_sentence_{base_form}'] = 1.0
                    features[f'pattern_verb_position_{i - homograph_pos}'] = 1.0
                    
                    if i < homograph_pos:
                        features['verb_before_homograph'] = 1.0
                    else:
                        features['verb_after_homograph'] = 1.0
                    
                    # Переходность глагола
                    if 'перех' in morph:
                        features['governing_verb_transitive'] = 1.0
                    elif 'непер' in morph:
                        features['governing_verb_intransitive'] = 1.0
                    
                    break  # Берем только первый глагол
        
        # 5. Союз перед омографом
        if homograph_pos > 0:
            prev_word = tokens[homograph_pos - 1]
            # Нормализуем слово
            prev_word_normalized = self.normalize_word(prev_word)
            prev_morphs = morph_dict.get_morphology(prev_word_normalized)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('союз'):
                    features[f'pattern_conjunction_before_{prev_word.lower()}'] = 1.0
        
        # 6. Числительное перед омографом
        if homograph_pos > 0:
            prev_word = tokens[homograph_pos - 1]
            # Нормализуем слово
            prev_word_normalized = self.normalize_word(prev_word)
            prev_morphs = morph_dict.get_morphology(prev_word_normalized)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('числ'):
                    features[f'pattern_numeral_before_{prev_word.lower()}'] = 1.0
        
        return features
    
    def _extract_universal_features(self, tokens: List[str], homograph_pos: int,
                                    morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Универсальные признаки, не зависящие от конкретного омографа.
        """
        features = {}
        
        # 0. Определение: подлежащее или дополнение
        subject_object_info = self._extract_subject_object(tokens, homograph_pos, morph_dict)
        features.update(subject_object_info)
        
        # Вставные конструкции (проверяем наличие скобок или тире)
        parenthetical_info = self._extract_parenthetical_constructions(tokens, homograph_pos, morph_dict)
        features.update(parenthetical_info)
        
        # 1. Указательные местоимения рядом с омографом
        demonstratives = {'этот': 'near_masc', 'эта': 'near_fem', 'это': 'near_neut',
                         'эти': 'near_plur', 'тот': 'far_masc', 'та': 'far_fem',
                         'то': 'far_neut', 'те': 'far_plur'}
        
        start = max(0, homograph_pos - 3)
        end = min(len(tokens), homograph_pos + 4)
        
        for i in range(start, end):
            if i == homograph_pos:
                continue
            
            word_norm = self.normalize_word(tokens[i])
            if word_norm in demonstratives:
                rel_pos = i - homograph_pos
                features[f'demonstrative_{rel_pos}_{demonstratives[word_norm]}'] = 1.0
                features[f'demonstrative_{rel_pos}_{word_norm}'] = 1.0
        
        # 2. Отрицание «не» перед омографом
        if homograph_pos > 0:
            prev_norm = self.normalize_word(tokens[homograph_pos - 1])
            if prev_norm == 'не' or prev_norm == 'ни':
                features[f'negation_before_{prev_norm}'] = 1.0
        
        if homograph_pos > 1:
            prev2_norm = self.normalize_word(tokens[homograph_pos - 2])
            if prev2_norm == 'не':
                features['negation_2before'] = 1.0
        
        # 3. Союзы рядом с омографом (однородные члены)
        conjunctions = {'и': 'and', 'или': 'or', 'да': 'and', 'ни': 'nor'}
        
        # Союз после омографа
        for dist in range(1, 4):
            idx = homograph_pos + dist
            if idx >= len(tokens):
                break
            
            word_norm = self.normalize_word(tokens[idx])
            if word_norm in conjunctions:
                features[f'conj_after_{dist}_{conjunctions[word_norm]}'] = 1.0
                # Что после союза
                if idx + 1 < len(tokens):
                    next_norm = self.normalize_word(tokens[idx + 1])
                    next_morphs = self._get_morphology_cached(next_norm, morph_dict)
                    for morph, base_form in next_morphs:
                        if morph.startswith('сущ'):
                            features[f'conj_after_{dist}_noun_{base_form}'] = 1.0
                            break
                break
        
        # Союз перед омографом
        for dist in range(1, 4):
            idx = homograph_pos - dist
            if idx < 0:
                break
            
            word_norm = self.normalize_word(tokens[idx])
            if word_norm in conjunctions:
                features[f'conj_before_{dist}_{conjunctions[word_norm]}'] = 1.0
                break
        
        # 4. Притяжательная конструкция: омограф + существительное в род.п.
        if homograph_pos < len(tokens) - 1:
            next_norm = self.normalize_word(tokens[homograph_pos + 1])
            next_morphs = self._get_morphology_cached(next_norm, morph_dict)
            
            for morph, base_form in next_morphs:
                if morph.startswith('сущ') and '_род_' in f'_{morph}_':
                    features[f'genitive_after_{base_form}'] = 1.0
                    break
        
        # 5. Согласование с прилагательными перед омографом (род, число, падеж)
        if homograph_pos > 0:
            prev_norm = self.normalize_word(tokens[homograph_pos - 1])
            prev_morphs = self._get_morphology_cached(prev_norm, morph_dict)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('прл') or morph.startswith('прч'):
                    if '_ед_' in morph:
                        features['adj_before_singular'] = 1.0
                    if '_мн_' in morph:
                        features['adj_before_plural'] = 1.0
                    if '_муж_' in morph:
                        features['adj_before_masc'] = 1.0
                    if '_жен_' in morph:
                        features['adj_before_fem'] = 1.0
                    if '_ср_' in morph:
                        features['adj_before_neut'] = 1.0
                    
                    for case in self.cases:
                        if f'_{case}' in f'_{morph}':
                            features[f'adj_before_case_{case}'] = 1.0
                            break
                    
                    features[f'adj_before_{base_form}'] = 1.0
                    break
        
        # 5e. Омограф как ОПРЕДЕЛЕНИЕ перед существительным
        # Пример: «все́ здание», «все́ люди», «все́ средства»
        if homograph_pos < len(tokens) - 1:
            next_norm = self.normalize_word(tokens[homograph_pos + 1])
            next_morphs = self._get_morphology_cached(next_norm, morph_dict)
            
            for morph, base_form in next_morphs:
                if morph.startswith('сущ'):
                    # Число существительного
                    if '_ед_' in morph:
                        features['homo_as_def_noun_singular'] = 1.0
                    if '_мн_' in morph:
                        features['homo_as_def_noun_plural'] = 1.0
                    
                    # Род существительного
                    if '_муж_' in morph:
                        features['homo_as_def_noun_masc'] = 1.0
                    if '_жен_' in morph:
                        features['homo_as_def_noun_fem'] = 1.0
                    if '_ср_' in morph:
                        features['homo_as_def_noun_neut'] = 1.0
                    
                    # Падеж существительного
                    for case in self.cases:
                        if f'_{case}' in f'_{morph}':
                            features[f'homo_as_def_noun_case_{case}'] = 1.0
                            break
                    
                    # Согласование по числу: омограф + существительное
                    # «все́ здание» (ед.ч.) vs «все́ здания» (мн.ч.)
                    features[f'homo_def_{base_form}'] = 1.0
                    break
        
        # 5g. Омограф перед числом (арабские цифры или числительные)
        if homograph_pos < len(tokens) - 1:
            next_word = tokens[homograph_pos + 1]
            
            # Проверяем, является ли следующее слово числом
            import re
            is_digit = bool(re.match(r'^[0-9]+$', next_word))
            
            if is_digit:
                features['homo_before_digit'] = 1.0
                features[f'homo_before_digit_{next_word}'] = 1.0
            else:
                # Проверяем числительное через морфологию
                next_norm = self.normalize_word(next_word)
                next_morphs = self._get_morphology_cached(next_norm, morph_dict)
                
                for morph, base_form in next_morphs:
                    if morph.startswith('числ'):
                        features['homo_before_numeral'] = 1.0
                        features[f'homo_before_numeral_{base_form}'] = 1.0
                        break
        
        # 5f. Омограф + прилагательное + существительное (составное определение)
        # Пример: «все́ новые данные», «все́ важные дела»
        if homograph_pos < len(tokens) - 2:
            adj_norm = self.normalize_word(tokens[homograph_pos + 1])
            noun_norm = self.normalize_word(tokens[homograph_pos + 2])
            
            adj_morphs = self._get_morphology_cached(adj_norm, morph_dict)
            noun_morphs = self._get_morphology_cached(noun_norm, morph_dict)
            
            is_adj = any(m.startswith('прл') or m.startswith('прч') for m, _ in adj_morphs)
            is_noun = any(m.startswith('сущ') for m, _ in noun_morphs)
            
            if is_adj and is_noun:
                features[f'homo_def_adj_noun_{adj_norm}_{noun_norm}'] = 1.0
                
                # Число прилагательного
                for morph, base in adj_morphs:
                    if morph.startswith('прл') or morph.startswith('прч'):
                        if '_мн_' in morph:
                            features['homo_def_adj_noun_plural'] = 1.0
                        if '_ед_' in morph:
                            features['homo_def_adj_noun_singular'] = 1.0
                        break
        
        # 5a. Составные определения: наречие + прилагательное/причастие
        # Пример: «наиболее насущные», «очень важные», «крайне необходимые»
        if homograph_pos > 1:
            # Проверяем: наречие + прилагательное + омограф
            adv_norm = self.normalize_word(tokens[homograph_pos - 2])
            adj_norm = self.normalize_word(tokens[homograph_pos - 1])
            
            adv_morphs = self._get_morphology_cached(adv_norm, morph_dict)
            adj_morphs = self._get_morphology_cached(adj_norm, morph_dict)
            
            is_adverb = False
            for morph, base in adv_morphs:
                if morph.startswith('нар'):
                    is_adverb = True
                    break
            
            is_adjective = False
            adj_morph_info = None
            for morph, base in adj_morphs:
                if morph.startswith('прл') or morph.startswith('прч'):
                    is_adjective = True
                    adj_morph_info = (morph, base)
                    break
            
            if is_adverb and is_adjective:
                features[f'compound_def_{adv_norm}_{adj_norm}'] = 1.0
                
                if adj_morph_info:
                    morph, base_form = adj_morph_info
                    if '_мн_' in morph:
                        features['compound_def_plural'] = 1.0
                    if '_ед_' in morph:
                        features['compound_def_singular'] = 1.0
                    for case in self.cases:
                        if f'_{case}' in f'_{morph}':
                            features[f'compound_def_case_{case}'] = 1.0
                            break
        
        # 5b. Трёхсловные определения: наречие + наречие + прилагательное
        if homograph_pos > 2:
            adv2_norm = self.normalize_word(tokens[homograph_pos - 3])
            adv1_norm = self.normalize_word(tokens[homograph_pos - 2])
            adj_norm = self.normalize_word(tokens[homograph_pos - 1])
            
            adv2_morphs = self._get_morphology_cached(adv2_norm, morph_dict)
            adv1_morphs = self._get_morphology_cached(adv1_norm, morph_dict)
            adj_morphs = self._get_morphology_cached(adj_norm, morph_dict)
            
            is_adv2 = any(m.startswith('нар') for m, _ in adv2_morphs)
            is_adv1 = any(m.startswith('нар') for m, _ in adv1_morphs)
            is_adj = any(m.startswith('прл') or m.startswith('прч') for m, _ in adj_morphs)
            
            if is_adv2 and is_adv1 and is_adj:
                features[f'triple_def_{adv2_norm}_{adv1_norm}_{adj_norm}'] = 1.0
        
        # 5c. Причастный оборот перед омографом
        # Пример: «все задачи, наиболее насущные для Пруссии»
        # Проверяем: причастие + существительное в род.п. перед омографом
        if homograph_pos > 2:
            part_norm = self.normalize_word(tokens[homograph_pos - 2])
            gen_norm = self.normalize_word(tokens[homograph_pos - 1])
            
            part_morphs = self._get_morphology_cached(part_norm, morph_dict)
            gen_morphs = self._get_morphology_cached(gen_norm, morph_dict)
            
            is_participle = any(m.startswith('прч') for m, _ in part_morphs)
            is_genitive = any(m.startswith('сущ') and '_род_' in f'_{m}_' for m, _ in gen_morphs)
            
            if is_participle and is_genitive:
                features[f'participle_genitive_{part_norm}_{gen_norm}'] = 1.0
        
        # 5d. Прилагательное + причастие перед омографом
        if homograph_pos > 1:
            adj_norm = self.normalize_word(tokens[homograph_pos - 2])
            part_norm = self.normalize_word(tokens[homograph_pos - 1])
            
            adj_morphs = self._get_morphology_cached(adj_norm, morph_dict)
            part_morphs = self._get_morphology_cached(part_norm, morph_dict)
            
            is_adj = any(m.startswith('прл') for m, _ in adj_morphs)
            is_part = any(m.startswith('прч') for m, _ in part_morphs)
            
            if is_adj and is_part:
                features[f'adj_participle_{adj_norm}_{part_norm}'] = 1.0
        
        # 6. Количественные конструкции
        quantifiers = {'много', 'мало', 'несколько', 'сколько', 'столько', 'большинство', 'меньшинство'}
        
        for dist in range(1, 4):
            idx = homograph_pos - dist
            if idx < 0:
                break
            
            word_norm = self.normalize_word(tokens[idx])
            if word_norm in quantifiers:
                features[f'quantifier_{dist}_{word_norm}'] = 1.0
                break
        
        # 7. Пунктуация: запятая сразу после омографа
        if homograph_pos < len(tokens) - 1:
            # Проверяем, есть ли запятая в следующем разделителе
            # Поскольку у нас токены, а не разделители — проверяем по слову
            pass
        
        return features
    
    def _extract_parenthetical_constructions(self, tokens: List[str], homograph_pos: int,
                                             morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает информацию о вставных конструкциях.
        """
        features = {}
        
        # Вводные слова
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        found_parenthetical = []  # (rel_pos, base_form)
        
        for i in range(start, end):
            if i == homograph_pos:
                continue
            
            word_norm = self.normalize_word(tokens[i])
            word_morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            is_parenthetical = False
            parenthetical_base = None
            
            for morph, base_form in word_morphs:
                # Вводные слова: нар_ввод, нар_мест_ввод, и т.д.
                if morph.startswith('нар') and 'ввод' in morph:
                    is_parenthetical = True
                    parenthetical_base = base_form
                    break
                # Предикативы вводные
                if morph.startswith('предик') and 'ввод' in morph:
                    is_parenthetical = True
                    parenthetical_base = base_form
                    break
            
            if is_parenthetical:
                rel_pos = i - homograph_pos
                features[f'parenthetical_{rel_pos}_{parenthetical_base}'] = 1.0
                found_parenthetical.append((rel_pos, parenthetical_base))
        
        if found_parenthetical:
            # Ближайшее вводное слово
            nearest = min(found_parenthetical, key=lambda x: abs(x[0]))
            features[f'nearest_parenthetical_{nearest[1]}'] = 1.0
            
            # Количество вводных
            features['parenthetical_count'] = float(len(found_parenthetical))
        
        # Вводные конструкции между запятыми: вводное + частица
        # Проверяем соседние пары слов: вводное + частица
        for i in range(start, end - 1):
            if i == homograph_pos or i + 1 == homograph_pos:
                continue
            
            w1_norm = self.normalize_word(tokens[i])
            w2_norm = self.normalize_word(tokens[i + 1])
            
            w1_morphs = self._get_morphology_cached(w1_norm, morph_dict)
            w2_morphs = self._get_morphology_cached(w2_norm, morph_dict)
            
            # w1 — вводное, w2 — частица
            w1_is_intro = any(m.startswith('нар') and 'ввод' in m for m, _ in w1_morphs)
            w2_is_particle = any(m.startswith('част') for m, _ in w2_morphs)
            
            if w1_is_intro and w2_is_particle:
                rel_pos = i - homograph_pos
                features[f'parenthetical_particle_{rel_pos}_{w1_norm}_{w2_norm}'] = 1.0
            
            # w1 — частица, w2 — вводное
            w1_is_particle = any(m.startswith('част') for m, _ in w1_morphs)
            w2_is_intro = any(m.startswith('нар') and 'ввод' in m for m, _ in w2_morphs)
            
            if w1_is_particle and w2_is_intro:
                rel_pos = i - homograph_pos
                features[f'particle_parenthetical_{rel_pos}_{w1_norm}_{w2_norm}'] = 1.0
        
        # Проверяем, есть ли вводные между омографом и глаголом
        # Находим глагол
        verb_found = False
        for i in range(homograph_pos + 1, end):
            word_norm = self.normalize_word(tokens[i])
            word_morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base in word_morphs:
                if morph.startswith('гл'):
                    # Проверяем вводные между омографом и глаголом
                    for rel_pos, pword in found_parenthetical:
                        if 0 < rel_pos < (i - homograph_pos):
                            features[f'parenthetical_between_{pword}'] = 1.0
                    verb_found = True
                    break
            
            if verb_found:
                break
        
        return features
    
    def _extract_subject_object(self, tokens: List[str], homograph_pos: int,
                                morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Определяет, является ли омограф подлежащим или дополнением.
        """
        features = {}
        
        # Вводные слова (маркеры разрыва структуры)
        parentheticals = {'казалось', 'казаться', 'говорится', 'кстати', 'например', 
                         'конечно', 'возможно', 'вероятно', 'видимо', 'по-видимому',
                         'скажем', 'собственно', 'стало быть', 'значит', 'впрочем'}
        
        # Морфология омографа
        homo_norm = self.normalize_word(tokens[homograph_pos])
        homo_morphs = self._get_morphology_cached(homo_norm, morph_dict)
        
        homo_is_nominative = False
        homo_case = None
        
        for morph, base_form in homo_morphs:
            if morph.startswith('сущ') or morph.startswith('мест'):
                for case in self.cases:
                    if f'_{case}' in f'_{morph}':
                        homo_case = case
                        if case == 'им':
                            homo_is_nominative = True
                        break
                break
        
        # Глагол в предложении (первый)
        verb_pos = None
        verb_morph_info = None
        parenthetical_between = False
        
        for i, word in enumerate(tokens):
            if i == homograph_pos:
                continue
            
            word_norm = self.normalize_word(word)
            
            # Проверяем вводное слово
            if word_norm in parentheticals:
                if (i > homograph_pos and verb_pos is None) or \
                   (verb_pos is not None and homograph_pos < i < verb_pos):
                    parenthetical_between = True
                    features[f'parenthetical_{word_norm}'] = 1.0
            
            word_morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base_form in word_morphs:
                if morph.startswith('гл'):
                    verb_pos = i
                    verb_morph_info = (morph, base_form)
                    break
            
            if verb_pos:
                break
        
        if parenthetical_between:
            features['parenthetical_between_homo_verb'] = 1.0
        
        if verb_pos and verb_morph_info:
            verb_morph, verb_base = verb_morph_info
            
            # Омограф перед глаголом — вероятно подлежащее
            if homograph_pos < verb_pos:
                features['homo_before_verb'] = 1.0
                
                if parenthetical_between:
                    features['homo_before_verb_parenthetical'] = 1.0
                
                if homo_is_nominative:
                    features['homo_nominative_before_verb'] = 1.0
                
                # Согласование по числу
                if '_мн_' in verb_morph:
                    features['homo_subject_verb_plural'] = 1.0
                if '_ед_' in verb_morph:
                    features['homo_subject_verb_singular'] = 1.0
            
            # Омограф после глагола — вероятно дополнение
            elif homograph_pos > verb_pos:
                features['homo_after_verb'] = 1.0
                
                if homo_case and homo_case != 'им':
                    features[f'homo_object_case_{homo_case}'] = 1.0
                
                # Переходность глагола
                if 'перех' in verb_morph:
                    features['homo_object_transitive_verb'] = 1.0
                    # Прямое дополнение: переходный глагол + винительный падеж
                    if homo_case == 'вин':
                        features['homo_direct_object_transitive_vin'] = 1.0
                        features[f'homo_direct_object_vin_{verb_base}'] = 1.0
                    
                    # Прямое дополнение: переходный глагол + родительный (при отрицании)
                    if homo_case == 'род':
                        features['homo_direct_object_transitive_gen'] = 1.0
                    
                    features[f'homo_direct_object_{verb_base}'] = 1.0
                if 'непер' in verb_morph:
                    features['homo_object_intransitive_verb'] = 1.0
        
        # Предлог перед омографом → дополнение
        if homograph_pos > 0:
            prev_norm = self.normalize_word(tokens[homograph_pos - 1])
            prev_morphs = self._get_morphology_cached(prev_norm, morph_dict)
            
            for morph, base_form in prev_morphs:
                if morph.startswith('предл'):
                    features['homo_object_prepositional'] = 1.0
                    break
        
        return features
    
    def _extract_prepositional_phrases(self, tokens: List[str], homograph_pos: int,
                                       morph_dict: MorphDictionary) -> Dict[str, float]:
        """
        Извлекает предложные обороты: предлог + существительное/местоимение.
        
        Анализирует:
        - Обороты рядом с омографом (слева и справа)
        - Обороты между глаголом и омографом
        """
        features = {}
        
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        # Ищем все предложные обороты в окне
        for i in range(start, end - 1):
            if i == homograph_pos:
                continue
            
            # Проверяем: предлог + существительное
            word1_norm = self.normalize_word(tokens[i])
            word1_morphs = self._get_morphology_cached(word1_norm, morph_dict)
            
            is_preposition = False
            prep_base = None
            prep_case = None
            
            for morph, base_form in word1_morphs:
                if morph.startswith('предл'):
                    is_preposition = True
                    prep_base = base_form
                    
                    # Определяем падеж
                    for case in self.cases:
                        if f'_{case}' in f'_{morph}':
                            prep_case = case
                            break
                    break
            
            if not is_preposition:
                continue
            
            # Следующее слово после предлога
            for j in range(i + 1, min(i + 4, end)):
                if j == homograph_pos:
                    continue
                
                word2_norm = self.normalize_word(tokens[j])
                word2_morphs = self._get_morphology_cached(word2_norm, morph_dict)
                
                for morph2, base2 in word2_morphs:
                    if morph2.startswith('сущ') or morph2.startswith('мест'):
                        relative_pos = i - homograph_pos
                        
                        # Предложный оборот рядом с омографом
                        features[f'prep_phrase_{relative_pos}_{prep_base}_{base2}'] = 1.0
                        
                        if prep_case:
                            features[f'prep_phrase_{relative_pos}_{prep_base}_{prep_case}'] = 1.0
                        
                        # Конкретный оборот с падежом
                        features[f'prep_phrase_{relative_pos}_{prep_base}_{prep_case}_{base2}'] = 1.0
                        
                        break
                break
        
        # Обороты МЕЖДУ глаголом и омографом
        # Находим ближайший глагол слева
        nearest_verb_left = None
        for i in range(homograph_pos - 1, start - 1, -1):
            word_norm = self.normalize_word(tokens[i])
            word_morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base_form in word_morphs:
                if morph.startswith('гл'):
                    nearest_verb_left = i
                    break
            
            if nearest_verb_left:
                break
        
        if nearest_verb_left:
            # Ищем предложные обороты между глаголом и омографом
            for i in range(nearest_verb_left + 1, homograph_pos):
                word_norm = self.normalize_word(tokens[i])
                word_morphs = self._get_morphology_cached(word_norm, morph_dict)
                
                for morph, base_form in word_morphs:
                    if morph.startswith('предл'):
                        features[f'prep_between_verb_homo_{base_form}'] = 1.0
                        
                        for case in self.cases:
                            if f'_{case}' in f'_{morph}':
                                features[f'prep_between_verb_homo_{base_form}_{case}'] = 1.0
                                break
                        break
        
        return features
    
    def _extract_verb_info(self, tokens: List[str], homograph_pos: int,
                           morph_dict: MorphDictionary) -> Dict[str, float]:
        """Извлекает информацию о глаголах в предложении."""
        features = {}
        
        # Слова, которые не разрывают синтаксическую связь
        filler_pos = {'прл', 'прч', 'нар', 'предл', 'союз', 'част', 'мест', 'числ', 'ввод'}
        
        verbs = []
        for i, word in enumerate(tokens):
            if i == homograph_pos:
                continue
            
            word_norm = self.normalize_word(word)
            morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base_form in morphs:
                if morph.startswith('гл'):
                    relative_pos = i - homograph_pos
                    
                    # Проверяем, есть ли между глаголом и омографом «разрывающие» слова
                    breaks_connection = False
                    
                    if relative_pos < 0:
                        # Глагол слева — проверяем слова между ними
                        for j in range(i + 1, homograph_pos):
                            between_norm = self.normalize_word(tokens[j])
                            between_morphs = self._get_morphology_cached(between_norm, morph_dict)
                            
                            is_filler = False
                            for bm, bb in between_morphs:
                                pos_tag = bm.split('_')[0]
                                if pos_tag in filler_pos:
                                    is_filler = True
                                    break
                            
                            if not is_filler:
                                breaks_connection = True
                                break
                    else:
                        # Глагол справа — проверяем слова между ними
                        for j in range(homograph_pos + 1, i):
                            between_norm = self.normalize_word(tokens[j])
                            between_morphs = self._get_morphology_cached(between_norm, morph_dict)
                            
                            is_filler = False
                            for bm, bb in between_morphs:
                                pos_tag = bm.split('_')[0]
                                if pos_tag in filler_pos:
                                    is_filler = True
                                    break
                            
                            if not is_filler:
                                breaks_connection = True
                                break
                    
                    if not breaks_connection:
                        features[f'verb_direct_link_{base_form}'] = 1.0
                        features[f'verb_direct_link_dist_{relative_pos}'] = 1.0
                    
                    # Универсальное согласование по числу
                    if '_мн_' in morph:
                        features[f'verb_{relative_pos}_plural'] = 1.0
                    if '_ед_' in morph:
                        features[f'verb_{relative_pos}_singular'] = 1.0
                    
                    # Время глагола
                    for tense in ['наст', 'прош', 'буд']:
                        if f'_{tense}_' in f'_{morph}_' or morph.endswith(f'_{tense}'):
                            features[f'verb_{relative_pos}_{tense}'] = 1.0
                    
                    # Лицо (для настоящего/будущего)
                    for person in ['1е', '2е', '3е']:
                        if f'_{person}' in morph:
                            features[f'verb_{relative_pos}_{person}'] = 1.0
                    
                    verbs.append({
                        'pos': relative_pos,
                        'base': base_form,
                        'morph': morph
                    })
                    break  # Берем первую морфологию глагола
        
        if verbs:
            features['verb_count'] = float(len(verbs))
            
            # Ближайший глагол слева
            left_verbs = [v for v in verbs if v['pos'] < 0]
            if left_verbs:
                nearest_left = max(left_verbs, key=lambda v: v['pos'])
                features[f'nearest_verb_left_{nearest_left["base"]}'] = 1.0
                features[f'nearest_verb_left_dist_{abs(nearest_left["pos"])}'] = 1.0
                if 'перех' in nearest_left['morph']:
                    features['nearest_verb_left_transitive'] = 1.0
                if 'непер' in nearest_left['morph']:
                    features['nearest_verb_left_intransitive'] = 1.0
                
                # Управление: какой падеж требует глагол
                # Ищем существительное/местоимение рядом с глаголом
                verb_pos = nearest_left['pos'] + homograph_pos
                if verb_pos > 0:
                    before_verb = tokens[verb_pos - 1]
                    before_norm = self.normalize_word(before_verb)
                    before_morphs = self._get_morphology_cached(before_norm, morph_dict)
                    
                    for bm, bb in before_morphs:
                        if bm.startswith('сущ') or bm.startswith('мест'):
                            for case in self.cases:
                                if f'_{case}_' in f'_{bm}_' or bm.endswith(f'_{case}'):
                                    features[f'verb_left_governs_{case}'] = 1.0
                                    features[f'verb_{nearest_left["base"]}_governs_{case}'] = 1.0
                                    break
            
            # Ближайший глагол справа
            right_verbs = [v for v in verbs if v['pos'] > 0]
            if right_verbs:
                nearest_right = min(right_verbs, key=lambda v: v['pos'])
                features[f'nearest_verb_right_{nearest_right["base"]}'] = 1.0
                features[f'nearest_verb_right_dist_{nearest_right["pos"]}'] = 1.0
                
                # Управление: какой падеж требует глагол
                verb_pos = nearest_right['pos'] + homograph_pos
                if verb_pos < len(tokens) - 1:
                    after_verb = tokens[verb_pos + 1]
                    after_norm = self.normalize_word(after_verb)
                    after_morphs = self._get_morphology_cached(after_norm, morph_dict)
                    
                    for am, ab in after_morphs:
                        if am.startswith('сущ') or am.startswith('мест'):
                            for case in self.cases:
                                if f'_{case}_' in f'_{am}_' or am.endswith(f'_{case}'):
                                    features[f'verb_right_governs_{case}'] = 1.0
                                    features[f'verb_{nearest_right["base"]}_governs_{case}'] = 1.0
                                    break
        
        return features
    
    def _extract_preposition_info(self, tokens: List[str], homograph_pos: int,
                                  morph_dict: MorphDictionary) -> Dict[str, float]:
        """Извлекает информацию о предлогах с падежами."""
        features = {}
        
        # Все предлоги в окне
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        for i in range(start, end):
            if i == homograph_pos:
                continue
            
            word_norm = self.normalize_word(tokens[i])
            morphs = self._get_morphology_cached(word_norm, morph_dict)
            
            for morph, base_form in morphs:
                if morph.startswith('предл'):
                    relative_pos = i - homograph_pos
                    features[f'prep_{relative_pos}_{base_form}'] = 1.0
                    
                    # Падеж, который требует предлог
                    if 'вин' in morph:
                        features[f'prep_{relative_pos}_acc'] = 1.0
                    if 'дат' in morph:
                        features[f'prep_{relative_pos}_dat'] = 1.0
                    if 'род' in morph:
                        features[f'prep_{relative_pos}_gen'] = 1.0
                    if 'тв' in morph:
                        features[f'prep_{relative_pos}_ins'] = 1.0
                    if 'пр' in morph:
                        features[f'prep_{relative_pos}_prep'] = 1.0
        
        return features
    
    def _extract_agreement_info(self, tokens: List[str], homograph_pos: int,
                                morph_dict: MorphDictionary) -> Dict[str, float]:
        """Извлекает информацию о согласовании."""
        features = {}
        
        # Прилагательные/причастия слева и справа
        for direction in [-1, 1]:
            for dist in range(1, 4):
                idx = homograph_pos + direction * dist
                if idx < 0 or idx >= len(tokens):
                    break
                
                word_norm = self.normalize_word(tokens[idx])
                morphs = self._get_morphology_cached(word_norm, morph_dict)
                
                for morph, base_form in morphs:
                    if morph.startswith('прл') or morph.startswith('прч'):
                        features[f'agreement_{direction}_{dist}_{base_form}'] = 1.0
                        
                        # Грамматические категории
                        if '_ед_' in morph:
                            features[f'agreement_{direction}_{dist}_sing'] = 1.0
                        if '_мн_' in morph:
                            features[f'agreement_{direction}_{dist}_plur'] = 1.0
                        if '_муж_' in morph:
                            features[f'agreement_{direction}_{dist}_masc'] = 1.0
                        if '_жен_' in morph:
                            features[f'agreement_{direction}_{dist}_fem'] = 1.0
                        if '_ср_' in morph:
                            features[f'agreement_{direction}_{dist}_neut'] = 1.0
                        break
        
        return features
    
    def _extract_neighbor_homographs(self, tokens: List[str], homograph_pos: int,
                                     morph_dict: MorphDictionary) -> Dict[str, float]:
        """Ищет другие омографы (с ударениями) в предложении."""
        features = {}
        
        for i, word in enumerate(tokens):
            if i == homograph_pos:
                continue
            
            # Проверяем наличие ударения
            if self.has_accent(word):
                relative_pos = i - homograph_pos
                word_norm = self.normalize_word(word)
                features[f'neighbor_homograph_{relative_pos}_{word_norm}'] = 1.0
        
        return features
    
    def _extract_positional_features(self, tokens: List[str], homograph_pos: int) -> Dict[str, float]:
        """
        Извлекает позиционные признаки.
        """
        features = {}
        
        # Позиция в предложении
        features['position_in_sentence'] = float(homograph_pos)
        features['position_from_start'] = float(homograph_pos)
        features['position_from_end'] = float(len(tokens) - homograph_pos - 1)
        
        # Нормированная позиция
        if len(tokens) > 1:
            features['position_normalized'] = homograph_pos / (len(tokens) - 1)
        
        # В начале предложения
        if homograph_pos == 0:
            features['at_sentence_start'] = 1.0
        
        # В конце предложения
        if homograph_pos == len(tokens) - 1:
            features['at_sentence_end'] = 1.0
        
        # Длина предложения
        features['sentence_length'] = float(len(tokens))
        
        return features
    
    def _extract_frequency_features(self, tokens: List[str], homograph_pos: int) -> Dict[str, float]:
        """
        Извлекает частотные признаки.
        """
        features = {}
        
        # Частота омографа в корпусе
        homograph = tokens[homograph_pos].lower()
        # Убираем |meaning_id
        if '|' in homograph:
            homograph = homograph.split('|')[0]
        if homograph in self.word_frequencies:
            features['homograph_frequency'] = float(self.word_frequencies[homograph])
        
        # Частота слов в контексте
        start = max(0, homograph_pos - self.window_size)
        end = min(len(tokens), homograph_pos + self.window_size + 1)
        
        context_freqs = []
        for i in range(start, end):
            if i != homograph_pos:
                word = tokens[i].lower()
                freq = self.word_frequencies.get(word, 0)
                context_freqs.append(freq)
        
        if context_freqs:
            features['context_avg_frequency'] = float(sum(context_freqs) / len(context_freqs))
            features['context_max_frequency'] = float(max(context_freqs))
            features['context_min_frequency'] = float(min(context_freqs))
        
        return features
    
    def update_frequencies(self, corpus: List[List[str]]):
        """
        Обновляет частоты слов на основе корпуса.
        
        Args:
            corpus: список предложений (каждое - список токенов)
        """
        self.word_frequencies.clear()
        
        for tokens in corpus:
            for token in tokens:
                self.word_frequencies[token.lower()] += 1
    
    def get_feature_names(self, sample_features: List[Dict[str, float]]) -> List[str]:
        """
        Возвращает список всех имен признаков.
        
        Args:
            sample_features: список словарей признаков
            
        Returns:
            отсортированный список имен признаков
        """
        all_features = set()
        for features in sample_features:
            all_features.update(features.keys())
        return sorted(all_features)


def main():
    """
    Тестовая функция для проверки работы модуля.
    """
    print("=== Тестирование FeatureExtractor ===\n")
    
    # Загружаем словарь
    morph_dict = MorphDictionary("scriptdb")
    morph_dict.load_nouns()
    morph_dict.load_verbs()
    
    # Создаем экстрактор
    extractor = FeatureExtractor(window_size=3)
    
    # Тестовое предложение
    tokens = ["На", "двери", "висел", "большой", "замок"]
    homograph_pos = 4  # "замок"
    
    # Извлекаем признаки
    features = extractor.extract_features(tokens, homograph_pos, morph_dict)
    
    print(f"Извлечено признаков: {len(features)}")
    print("\nПервые 20 признаков:")
    for i, (key, value) in enumerate(sorted(features.items())[:20]):
        print(f"  {key}: {value}")
    
    print("\nВсе признаки:")
    for key, value in sorted(features.items()):
        print(f"  {key}: {value}")


if __name__ == "__main__":
    main()
