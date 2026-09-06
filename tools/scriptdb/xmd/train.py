#!/usr/bin/env python3
"""
Обучение модели для разрешения омографов.

Использование:
    # Для всей группы
    python3 train.py --group x2016 --train data/x2016_train.txt --output model/x2016.pkl

    # Для конкретного слова из группы
    python3 train.py --group x2016 --word взмету --train data/x2016_train.txt --output model/vzmetu.pkl

    # С дополнительными параметрами
    python3 train.py --group x2016 --train data/x2016_train.txt --output model/x2016.pkl --window 10
"""

import argparse
import sys
from pathlib import Path
from collections import Counter
import numpy as np

from morph_dict import MorphDictionary
from parser import HomographParser
from model import HomographModel
from homograph_groups import HomographGroups

# Абсолютные пути
SCRIPT_DIR = Path(__file__).parent.resolve()
DICT_DIR = str(SCRIPT_DIR.parent)  # scriptdb/
MODELS_DIR = str(SCRIPT_DIR / "xmods")  # scriptdb/xmd/xmods/


def train_homograph(
    group_id: str, train_file: str, output_file: str, word: str = None, window_size: int = 10, mode: str = "group",
    min_length: int = 3, C: float = 1.0, confidence: float = 0.55, dict_dir: str = None,
    semantic_file: str = None
):
    """
    Обучает модель для группы омографов или конкретного слова.

    Args:
        group_id: идентификатор группы (например, x2016)
        train_file: путь к размеченному корпусу
        output_file: куда сохранить модель
        word: конкретное слово из группы (если None — первое слово группы)
        window_size: размер окна для признаков
    """
    print(f"{'='*60}")
    print(f"Обучение модели для группы: '{group_id}'")
    if word:
        print(f"Слово: '{word}'")
    print(f"{'='*60}\n")

    # Загружаем группы
    print("Загрузка групп омографов...")
    groups = HomographGroups(DICT_DIR)
    groups.load()

    # Получаем данные группы
    group_data = groups.get_group(group_id)
    if not group_data:
        print(f"Ошибка: группа '{group_id}' не найдена", file=sys.stderr)
        sys.exit(1)

    num_variants = groups.get_num_variants(group_id)
    words_in_group = groups.get_words_in_group(group_id)

    print(f"Группа: {group_id}")
    print(f"Вариантов: {num_variants}")
    print(f"Слов в группе: {len(words_in_group)}")

    # Определяем омограф и его ударные формы
    if mode == "word" and word:
        # Режим: обучаем на конкретном слове
        if word not in words_in_group:
            print(f"Ошибка: слово '{word}' не найдено в группе '{group_id}'", file=sys.stderr)
            sys.exit(1)
        homograph = word
        print(f"Режим: обучение на слове '{homograph}'")
    else:
        # Режим: обучаем на группе
        if word:
            # Указано конкретное слово как образец
            if word not in words_in_group:
                print(f"Ошибка: слово '{word}' не найдено в группе '{group_id}'", file=sys.stderr)
                sys.exit(1)
            homograph = word
            print(f"Режим: обучение на группе (образец: '{homograph}')")
        else:
            # Слово не указано — ищем размеченное слово в корпусе
            homograph = None
            print(f"Режим: обучение на группе, поиск размеченного слова в корпусе...")

            # Ищем первое размеченное слово из группы в корпусе
            from parser import Tokenizer

            tokenizer = Tokenizer()

            with open(train_file, "r", encoding="utf-8") as f:
                for line in f:
                    line = line.strip()
                    if not line:
                        continue

                    tokens, _ = tokenizer.tokenize(line)
                    for token in tokens:
                        # Проверяем, есть ли ударение или ё
                        if tokenizer.has_accent(token) or tokenizer.has_yo(token):
                            token_clean = tokenizer.remove_accents(token).lower().replace("ё", "е")
                            for w in words_in_group:
                                if w.lower().replace("ё", "е") == token_clean:
                                    homograph = w
                                    print(f"Найдено размеченное слово: '{homograph}'")
                                    break
                        if homograph:
                            break
                    if homograph:
                        break

            if not homograph:
                print(f"Ошибка: не найдено размеченное слово в корпусе", file=sys.stderr)
                sys.exit(1)

        print(f"Модель будет работать для {len(words_in_group)} слов группы")

    accent_variants = groups.get_accent_variants(group_id, homograph)

    print(f"\nОмограф: {homograph}")
    print(f"Ударные формы:")
    for variant_id, accented in accent_variants.items():
        print(f"  Вариант {variant_id}: {accented}")

    # Загружаем морфологический словарь
    print("\nЗагрузка морфологического словаря...")
    if dict_dir:
        from pathlib import Path as P
        morph_dict = MorphDictionary(str(P(dict_dir).resolve()))
    else:
        morph_dict = MorphDictionary(DICT_DIR)
    total_words = morph_dict.load_all()
    print(f"Загружено словоформ: {total_words}")

    # Создаем парсер
    print("\nПарсинг размеченного корпуса...")
    parser = HomographParser(homograph=homograph, accent_variants=accent_variants)
    parsed_data, errors = parser.parse_file(train_file)
    
    # Исключаем предложения короче min_length токенов
    before_filter = len(parsed_data)
    parsed_data = [(tokens, pos, label) for tokens, pos, label in parsed_data 
                   if len(tokens) >= min_length]
    filtered = before_filter - len(parsed_data)
    
    if filtered > 0:
        print(f"Исключено предложений короче {min_length} токенов: {filtered}")
    
    # Исключаем предложения, где омограф — единственное слово
    before_filter = len(parsed_data)
    parsed_data = [(tokens, pos, label) for tokens, pos, label in parsed_data 
                   if len(tokens) > 1]
    filtered = before_filter - len(parsed_data)
    
    if filtered > 0:
        print(f"Исключено одиночных омографов: {filtered}")

    print(f"Размечено примеров: {len(parsed_data)}")
    if errors:
        print(f"Строк с ошибками: {len(errors)}")
        for line_num, line in errors[:10]:
            print(f"  Строка {line_num}: {line.strip()}")
        if len(errors) > 10:
            print(f"  ... и ещё {len(errors) - 10} строк")

    if len(parsed_data) < 20:
        print("\nВНИМАНИЕ: Очень мало примеров для обучения!")
        print("Рекомендуется минимум 50-100 примеров.")

    # Статистика по классам
    class_counts = Counter(meaning_id for _, _, meaning_id in parsed_data)
    print("\nРаспределение по значениям:")
    for meaning_id, accented in accent_variants.items():
        count = class_counts.get(meaning_id, 0)
        print(f"  Значение {meaning_id} ({accented}): {count} примеров")

    # Обучаем модель
    print(f"\nОбучение модели (window={window_size})...")
    model = HomographModel(
        homograph=homograph,
        num_meanings=num_variants,
        window_size=window_size,
        group_words=words_in_group if mode == "group" else [homograph],
        C=C,
    )
    
    if semantic_file:
        model.feature_extractor.load_semantic_groups(semantic_file)
    
    model.accent_variants = accent_variants
    model.min_confidence = confidence

    stats = model.train(parsed_data, morph_dict)

    # Запоминаем контексты ошибок
    print(f"\nЗапоминание контекстов ошибок...")
    n_refuse = model.learn_refuse_contexts(parsed_data, morph_dict)
    print(f"Запомнено контекстов для отказа: {n_refuse}")
    stats["refuse_contexts"] = n_refuse

    # Оценка на всём корпусе
    print(f"\nОценка на всём корпусе ({len(parsed_data)} примеров)...")
    # Извлекаем признаки для всех примеров
    features_list = []
    labels = []

    for tokens, pos, true_label in parsed_data:
        features = model.feature_extractor.extract_features(tokens, pos, morph_dict)
        features_list.append(features)
        labels.append(true_label)

    # Строим матрицу
    X = model._build_feature_matrix(features_list)

    # Предсказываем батчем
    predictions = model._predict_from_matrix(X)
    probabilities = model._predict_proba_from_matrix(X)

    correct = 0
    total = len(labels)
    refused = 0
    predicted_total = 0

    for i, true_label in enumerate(labels):
        pred_label = predictions[i]
        confidence = float(np.max(probabilities[i]))

        if confidence < model.min_confidence:
            refused += 1
        else:
            predicted_total += 1
            if pred_label == true_label:
                correct += 1

    accuracy = correct / predicted_total if predicted_total > 0 else 0
    coverage = predicted_total / total if total > 0 else 0

    print(f"Точность (только предсказанные): {accuracy:.3f}")
    print(f"Покрытие: {coverage:.3f} ({predicted_total}/{total})")
    print(f"Отказов: {refused} ({refused/total:.1%})")

    stats["accuracy"] = accuracy
    stats["coverage"] = coverage
    stats["refused"] = refused

    # Сохраняем модель
    print(f"\nСохранение модели в {output_file}...")
    output_path = Path(output_file)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    model.save(output_file)

    # Итоговая статистика
    print(f"\n{'='*60}")
    print("ИТОГОВАЯ СТАТИСТИКА")
    print(f"{'='*60}")
    print(f"Группа: {group_id}")
    print(f"Омограф: {homograph}")
    print(f"Вариантов: {num_variants}")
    print(f"Примеров: {len(parsed_data)}")
    print(f"Признаков: {stats['n_features']}")
    print(f"Точность на обучении: {stats['train_accuracy']:.3f}")
    print(f"Точность (предсказанные): {accuracy:.3f}")
    print(f"Покрытие: {coverage:.3f}")
    print(f"Отказов: {refused} ({refused/total:.1%})")
    print(f"Файл модели: {output_file}")

    file_size = output_path.stat().st_size
    print(f"Размер модели: {file_size} байт")

    return model


def main():
    parser = argparse.ArgumentParser(
        description="Обучение модели для разрешения омографов",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Примеры:
    # Для всей группы
    python3 train.py --group x2016 --train data/x2016_train.txt --output model/x2016.pkl
    
    # Для конкретного слова из группы
    python3 train.py --group x2016 --word взмету --train data/x2016_train.txt --output model/vzmetu.pkl
    
    # С дополнительными параметрами
    python3 train.py --group x2016 --train data/x2016_train.txt --output model/x2016.pkl --window 10
        """,
    )

    parser.add_argument("--group", required=True, help="Идентификатор группы (например, x2016)")
    parser.add_argument("--word", help="Конкретное слово из группы (для --mode word)")
    parser.add_argument(
        "--mode",
        choices=["group", "word"],
        default="group",
        help="Режим: group — модель для всей группы, word — для одного слова",
    )
    parser.add_argument("--train", required=True, help="Путь к размеченному корпусу")
    parser.add_argument("--output", required=True, help="Путь для сохранения модели")
    parser.add_argument("--window", type=int, default=10, help="Размер окна для признаков (по умолчанию: 10)")
    parser.add_argument("--min-length", type=int, default=3, help="Минимальная длина предложения в токенах (по умолчанию: 3)")
    parser.add_argument("--C", type=float, default=1.0, help="Параметр регуляризации (по умолчанию: 1.0)")
    parser.add_argument("--confidence", type=float, default=0.90, help="Порог уверенности (по умолчанию: 0.90)")
    parser.add_argument("--dict-dir", help="Директория с локальными словарями")
    parser.add_argument("--semantic-file", help="Файл с семантическими группами")

    args = parser.parse_args()

    train_homograph(
        group_id=args.group,
        train_file=args.train,
        output_file=args.output,
        word=args.word,
        window_size=args.window,
        mode=args.mode,
        min_length=args.min_length,
        C=args.C,
        confidence=args.confidence,
        dict_dir=args.dict_dir,
        semantic_file=args.semantic_file,
    )


if __name__ == "__main__":
    main()
