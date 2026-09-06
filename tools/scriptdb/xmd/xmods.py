#!/usr/bin/env python3
"""
Применение моделей омографов к тексту.

Использование:
    # Обработка файла
    python3 predict.py text.txt > text_acc.txt

    # Чтение из stdin
    cat text.txt | python3 predict.py > text_acc.txt

    # С опциями
    python3 predict.py --models-dir scriptdb/xmods text.txt > text_acc.txt
"""

import os
import re
import sys
import time
from pathlib import Path
from typing import Dict, List, Tuple

from morph_dict import MorphDictionary
from model import HomographModel
from parser import Tokenizer
# Паттерны разделителей (как в ruac.py)
pat_acc = re.compile(r"[^а-яА-ЯёЁ\u0301\u0320\u0323\u0324\u032d\u0330]+")


def patsplit(string: str, seps_pattern) -> Tuple[List[str], List[str]]:
    """Разделяет строку на слова и разделители (как в ruac.py)."""
    words = seps_pattern.split(string)
    seps = seps_pattern.findall(string)
    if words and len(words[0]) == 0:
        del words[0]
    return words, seps


def clean_word(wrd: str) -> str:
    """Очищает слово: ё→е, убирает ударения."""
    word_cleaned = wrd.replace("ё", "е").replace("Ё", "Е")
    word_cleaned = "".join(ch for ch in word_cleaned if ch not in "\u0301\u0320\u0323\u0324\u032d\u0330")
    return word_cleaned.lower()


def load_models(models_dir: str) -> Dict[str, HomographModel]:
    """
    Загружает все модели из директории.

    Returns:
        {базовая_форма: модель}
    """
    models = {}
    models_path = Path(models_dir)

    if not models_path.exists():
        print(f"Директория не найдена: {models_dir}", file=sys.stderr)
        return models

    for model_file in list(models_path.glob("*.pkl.gz")) + list(models_path.glob("*.pkl")):
        try:
            model = HomographModel(homograph="", num_meanings=2)
            model.load(model_file)
            models[model.homograph] = model
        except Exception as e:
            print(f"Ошибка загрузки {model_file}: {e}", file=sys.stderr)

    return models


def process_line(
    line: str, models: Dict[str, HomographModel], morph_dict: MorphDictionary, save_accent: bool = True
) -> str:
    """
    Обрабатывает одну строку текста.

    Args:
        line: строка текста
        models: словарь моделей {базовая_форма: модель}
        morph_dict: морфологический словарь
        save_accent: сохранять ли уже размеченные ударения

    Returns:
        обработанная строка
    """
    line = line.rstrip()
    
    # Обрезаем метаданные =NNN.txt для обработки, но сохраняем
    metadata = ""
    if '=' in line:
        parts = line.split('=', 1)
        line = parts[0]
        metadata = '=' + parts[1]

    # Токенизируем
    words_orig, seps_orig = patsplit(line, pat_acc)

    if not words_orig:
        return line

    # Создаём рабочую копию слов
    words_new = []

    for word_idx, word in enumerate(words_orig):
        # Нормализуем для поиска в моделях
        word_clean = clean_word(word)

        # Проверяем, есть ли модель для этого слова
        if word_clean in models:
            model = models[word_clean]

            # Проверяем, не размечено ли уже
            has_accent = any(ch in word for ch in "\u0301\u0320\u0323\u0324\u032d\u0330")
            has_yo = "ё" in word or "Ё" in word

            if save_accent and (has_accent or has_yo):
                # Уже размечено — не трогаем
                words_new.append(word)
                continue

            # Нормализуем окружение (убираем ударения из соседних слов)
            tokens_normalized = []
            for i, w in enumerate(words_orig):
                if i == word_idx:
                    tokens_normalized.append(w)
                else:
                    tokens_normalized.append(clean_word(w))

            # Предсказываем
            prediction = model.predict(tokens_normalized, word_idx, morph_dict)

            if prediction["meaning_id"] is not None and prediction["prediction_made"]:
                # Получаем ударную форму
                meaning_id = prediction["meaning_id"]
                if meaning_id in model.accent_variants:
                    accented_form = model.accent_variants[meaning_id]
                    # Сохраняем регистр
                    if word[0].isupper():
                        accented_form = accented_form.capitalize()
                    if word.isupper():
                        accented_form = accented_form.upper()
                    words_new.append(accented_form)
                else:
                    words_new.append(word)
            else:
                # Отказ от предсказания — оставляем как есть
                words_new.append(word)
        else:
            # Нет модели для этого слова
            words_new.append(word)

    # Как в ruac.py: sep + word для каждой пары
    if len(seps_orig) - len(words_new) == -1:
        seps_orig.insert(0, "")

    result = "".join([sep + word for sep, word in zip(seps_orig, words_new)])
    
    return result + metadata


def main():
    """Главная функция."""
    # Параметры
    from pathlib import Path as P

    script_dir = P(__file__).parent.resolve()
    models_dir = str(script_dir / "xmods")  # scriptdb/xmd/xmods/
    dict_dir = str(script_dir.parent)  # scriptdb/
    save_accent = True
    min_length = 3

    # Обработка аргументов
    args = sys.argv[1:]

    if "--models-dir" in args:
        idx = args.index("--models-dir")
        if idx + 1 < len(args):
            models_dir = args[idx + 1]
            args.pop(idx)
            args.pop(idx)

    if "--stat" in args:
        idx = args.index("--stat")
        if idx + 1 < len(args):
            # Вычисляем абсолютный путь относительно текущей директории
            from pathlib import Path as P

            dict_dir = str(P(args[idx + 1]).resolve())
            args.pop(idx)
            args.pop(idx)

    if "--nosave" in args:
        save_accent = False
        args.remove("--nosave")

    if "--min-length" in args:
        idx = args.index("--min-length")
        if idx + 1 < len(args):
            min_length = int(args[idx + 1])
            args.pop(idx)
            args.pop(idx)

    # Загружаем морфологический словарь (в stderr)
    print("Загрузка морфологического словаря...", file=sys.stderr)
    morph_dict = MorphDictionary(dict_dir)
    try:
        morph_dict.load_all()
    except FileNotFoundError:
        # Если не получилось — загружаем из основной директории
        print(f"Словари не найдены в {dict_dir}, загружаем из ..", file=sys.stderr)
        morph_dict = MorphDictionary("..")
        morph_dict.load_all()

    # Загружаем модели (в stderr)
    print("Загрузка моделей...", file=sys.stderr)
    models = load_models(models_dir)
    print(f"Загружено моделей: {len(models)}", file=sys.stderr)
    
    if not models:
        print("Нет моделей для обработки", file=sys.stderr)
        sys.exit(1)

    # Чтение текста
    if args:
        filename = args[0]
        with open(filename, "r", encoding="utf-8") as f:
            lines = f.readlines()
    else:
        lines = sys.stdin.read().splitlines()

    # Обработка
    start_time = time.time()
    total_lines = len(lines)

    for line_num, line in enumerate(lines, start=1):
        # Игнорируем метаданные для проверки длины
        line_check = line.split('=')[0] if '=' in line else line
        
        # Пропускаем слишком короткие предложения
        words_check, _ = patsplit(line_check, pat_acc)
        words_check = [w for w in words_check if w]
        if len(words_check) < min_length:
            # Выводим строку без изменений
            sys.stdout.write(line + "\n")
            continue

        result = process_line(line, models, morph_dict, save_accent)
        # Пишем только результат обработки
        sys.stdout.write(result + "\n")

        if line_num % 100 == 0:
            elapsed = time.time() - start_time
            sys.stderr.write(f"\rОбработано: {line_num}/{total_lines} ({elapsed:.1f} сек)")
            sys.stderr.flush()

    elapsed = time.time() - start_time
    sys.stderr.write(f"\rОбработано: {total_lines}/{total_lines} ({elapsed:.1f} сек)\n")


if __name__ == "__main__":
    main()
