#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Модуль обработки текста через TreeTagger для получения морфологических признаков омографов.
Создает точную копию входного файла с добавлением тегов после омографов.

Использование:
    python treetagger_omo.py input.txt output.txt omo_list.gz [--debug]

Где:
    input.txt   - входной текстовый файл (книга)
    output.txt  - выходной файл с тегами после омографов
    omo_list.gz - gzip-сжатый список омографов (по одному слову на строку)
    --debug     - включить отладочный вывод
"""

import sys
import re
import gzip
import subprocess
import os
from pathlib import Path
from typing import List, Tuple, Dict, Set, Optional

# ===== Константы =====
RU_ALPHA = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
RU_ALPHA_UPPER = RU_ALPHA.upper()
ALL_ALPHA = RU_ALPHA + RU_ALPHA_UPPER
COMBINING_MARKS = '\u0301\u0320\u0323\u0324\u032d\u0330'  # ударения и служебные
SPECIAL_CHARS = '\u2024\u2027'  # fake dot и пауза

# Паттерн токенизации (должен совпадать с awk)
TOKEN_PATTERN = re.compile(
    f'[{RU_ALPHA}{RU_ALPHA_UPPER}{COMBINING_MARKS}0-9]+'
)

# Паттерн для удаления XML-тегов
XML_TAG_PATTERN = re.compile(r'<[^>]+>')

# Метки начала и конца строки для TreeTagger
LINE_START_MARKER = re.compile(r'ЪЬЪSTART(\d{8})ЪЬЪ')
LINE_END_MARKER = re.compile(r'ЪЬЪEND(\d{8})ЪЬЪ')

# Паттерн для нормализации разделителей (для TreeTagger)
SAFE_PUNCT = '.,:;\\-—–!?…'


def load_omographs(omo_file: str) -> Set[str]:
    """Загружает список омографов из gzip-файла."""
    omographs = set()
    
    with gzip.open(omo_file, 'rt', encoding='utf-8') as f:
        for line in f:
            word = line.strip()
            if word:
                normalized = normalize_word(word)
                omographs.add(normalized)
    
    return omographs


def normalize_word(word: str) -> str:
    """Нормализует слово: нижний регистр, ё -> е, без ударений."""
    word = word.lower().replace('ё', 'е')
    word = re.sub(f'[{COMBINING_MARKS}]', '', word)
    return word


def tokenize_line(line: str) -> Tuple[List[str], List[str]]:
    """Разбивает строку на токены и разделители."""
    tokens = []
    separators = []
    
    matches = list(TOKEN_PATTERN.finditer(line))
    
    if not matches:
        return [], [line]
    
    separators.append(line[:matches[0].start()])
    
    for i, match in enumerate(matches):
        tokens.append(match.group())
        
        if i < len(matches) - 1:
            separators.append(line[match.end():matches[i+1].start()])
        else:
            separators.append(line[match.end():])
    
    return tokens, separators


def line_has_omographs(tokens: List[str], omographs: Set[str]) -> bool:
    """Проверяет, содержит ли строка хотя бы один омограф."""
    for token in tokens:
        clean_token = re.sub(f'[{COMBINING_MARKS}{SPECIAL_CHARS}]', '', token)
        normalized = normalize_word(clean_token)
        
        if normalized in omographs:
            return True
    
    return False


def remove_xml_tags(line: str) -> str:
    """Удаляет XML-теги из строки для отправки в TreeTagger."""
    return XML_TAG_PATTERN.sub(' ', line)


def prepare_for_treetagger(tokens: List[str], separators: List[str]) -> str:
    """Подготавливает строку для отправки в TreeTagger."""
    result = []
    
    # Добавляем первый разделитель
    if separators and separators[0]:
        clean_sep = re.sub(r'[^\s' + SAFE_PUNCT + r']', ' ', separators[0])
        # Добавляем пробелы вокруг непробельных символов
        clean_sep = re.sub(r'([' + SAFE_PUNCT + r'])', r' \1 ', clean_sep)
        result.append(clean_sep)
    
    for i, token in enumerate(tokens):
        # Очищаем токен
        clean_token = re.sub(f'[{COMBINING_MARKS}{SPECIAL_CHARS}]', '', token)
        result.append(clean_token)
        
        # Добавляем разделитель после токена
        if i < len(separators) - 1:
            sep = separators[i + 1] if i + 1 < len(separators) else ''
            clean_sep = re.sub(r'[^\s' + SAFE_PUNCT + r']', ' ', sep)
            # Добавляем пробелы вокруг непробельных символов
            clean_sep = re.sub(r'([' + SAFE_PUNCT + r'])', r' \1 ', clean_sep)
            result.append(clean_sep)
    
    return ''.join(result)


def run_treetagger(text: str, treetagger_path: str = './rnn-tagger-russian.sh', 
                   debug: bool = False) -> str:
    """Запускает TreeTagger и возвращает результат."""
    # Определяем абсолютный путь к скрипту
    treetagger_abs = os.path.abspath(treetagger_path)
    
    # Определяем рабочую директорию (где лежит скрипт)
    treetagger_dir = os.path.dirname(treetagger_abs)
    
    # Имя скрипта
    treetagger_script = os.path.basename(treetagger_abs)
    
    # Команда запуска
    treetagger_cmd = [f'./{treetagger_script}']
    
    if debug:
        print(f"\n=== DEBUG: TreeTagger input ({len(text)} chars) ===", file=sys.stderr)
        print(text[:1000], file=sys.stderr)
        if len(text) > 1000:
            print(f"... (truncated, total {len(text)} chars)", file=sys.stderr)
        print("=== END DEBUG ===\n", file=sys.stderr)
    
    try:
        process = subprocess.Popen(
            treetagger_cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            encoding='utf-8',
            cwd=treetagger_dir  # Устанавливаем рабочую директорию
        )
        
        stdout, stderr = process.communicate(text)
        
        if debug:
            print(f"\n=== DEBUG: TreeTagger return code: {process.returncode} ===", file=sys.stderr)
            if stderr:
                print(f"STDERR: {stderr[:500]}", file=sys.stderr)
            print(f"\n=== DEBUG: TreeTagger output ({len(stdout)} chars) ===", file=sys.stderr)
            print(stdout[:1000], file=sys.stderr)
            if len(stdout) > 1000:
                print(f"... (truncated, total {len(stdout)} chars)", file=sys.stderr)
            print("=== END DEBUG ===\n", file=sys.stderr)
        
        if process.returncode != 0:
            print(f"TreeTagger error: {stderr}", file=sys.stderr)
            return ""
        
        return stdout
    except Exception as e:
        print(f"Error running TreeTagger: {e}", file=sys.stderr)
        return ""


def parse_treetagger_output(text: str, debug: bool = False) -> Dict[int, List[Tuple[str, str]]]:
    """Разбирает вывод TreeTagger и группирует по номерам строк.
    
    Логика:
    - Ищем START метку -> начинаем собирать токены для этой строки
    - Собираем все токены (игнорируя пустые строки)
    - Ищем END метку с тем же номером -> сохраняем собранные токены
    """
    result = {}
    current_line = None
    current_tokens = []
    
    lines = text.split('\n')
    
    if debug:
        print(f"\n=== DEBUG: Parsing {len(lines)} lines from TreeTagger ===", file=sys.stderr)
    
    for line_idx, line in enumerate(lines):
        if debug:
            print(f"  Line {line_idx}: '{line}'", file=sys.stderr)
        
        # Проверяем START метку
        start_match = LINE_START_MARKER.search(line)
        if start_match:
            line_num = int(start_match.group(1))
            current_line = line_num
            current_tokens = []
            if debug:
                print(f"  >>> START line {line_num}", file=sys.stderr)
            continue
        
        # Проверяем END метку
        end_match = LINE_END_MARKER.search(line)
        if end_match:
            line_num = int(end_match.group(1))
            if current_line == line_num and current_tokens:
                result[current_line] = current_tokens
                if debug:
                    print(f"  <<< END line {line_num}: saved {len(current_tokens)} tokens", file=sys.stderr)
            current_line = None
            current_tokens = []
            continue
        
        # Пропускаем пустые строки
        if not line.strip():
            if debug:
                print(f"  (empty line, skipping)", file=sys.stderr)
            continue
        
        # Пропускаем строки вне блока START/END
        if current_line is None:
            if debug:
                print(f"  (outside block, skipping)", file=sys.stderr)
            continue
        
        # Разбираем строку TreeTagger: токен \t тег \t лемма
        parts = line.split('\t')
        if len(parts) >= 2:
            token = parts[0]
            tag = parts[1]
            
            # Пропускаем служебные токены
            if LINE_START_MARKER.search(token) or LINE_END_MARKER.search(token):
                continue
            
            current_tokens.append((token, tag))
            if debug:
                print(f"    Token: '{token}' Tag: '{tag}'", file=sys.stderr)
    
    if debug:
        print(f"=== END DEBUG: Parsed {len(result)} lines ===\n", file=sys.stderr)
    
    return result


def is_russian_word(token: str) -> bool:
    """Проверяет, содержит ли токен кириллические буквы."""
    return bool(re.search(f'[{RU_ALPHA}{RU_ALPHA_UPPER}]', token))


def filter_words(tokens: List[str]) -> List[int]:
    """Возвращает индексы токенов, которые являются русскими словами."""
    return [i for i, token in enumerate(tokens) if is_russian_word(token)]


def filter_tt_words(tt_tokens: List[Tuple[str, str]]) -> List[int]:
    """Возвращает индексы токенов TreeTagger, которые являются русскими словами."""
    return [i for i, (token, _) in enumerate(tt_tokens) if is_russian_word(token)]


def rebuild_line(original_line: str, tokens: List[str], separators: List[str], 
                 tt_tokens: List[Tuple[str, str]], omographs: Set[str], 
                 tag_all: bool = False, context: int = 0) -> str:
    """Собирает строку обратно с тегами для омографов."""
    
    # Фильтруем только русские слова
    orig_word_indices = filter_words(tokens)
    tt_word_indices = filter_tt_words(tt_tokens)
    
    # Проверяем соответствие
    if len(orig_word_indices) != len(tt_word_indices):
        print(f"Error: word count mismatch: {len(orig_word_indices)} vs {len(tt_word_indices)}", 
              file=sys.stderr)
        print(f"  Original words: {[tokens[i] for i in orig_word_indices]}", file=sys.stderr)
        print(f"  TT words: {[tt_tokens[i][0] for i in tt_word_indices]}", file=sys.stderr)
        return original_line
    
    # Проверяем соответствие слов
    for orig_idx, tt_idx in zip(orig_word_indices, tt_word_indices):
        orig_word = tokens[orig_idx]
        tt_word = tt_tokens[tt_idx][0]
        
        orig_clean = normalize_word(re.sub(f'[{COMBINING_MARKS}{SPECIAL_CHARS}]', '', orig_word))
        tt_clean = normalize_word(tt_word)
        
        if orig_clean != tt_clean:
            print(f"Error: word mismatch: '{orig_word}' vs '{tt_word}'", file=sys.stderr)
            return original_line
    
    # Создаем теги для омографов (или всех токенов, если tag_all=True)
    tags = [''] * len(tokens)
    
    for orig_idx, tt_idx in zip(orig_word_indices, tt_word_indices):
        token = tokens[orig_idx]
        clean_token = re.sub(f'[{COMBINING_MARKS}{SPECIAL_CHARS}]', '', token)
        normalized = normalize_word(clean_token)
        
        if tag_all or normalized in omographs:
            tag = tt_tokens[tt_idx][1]
            tags[orig_idx] = f"<#@_{tag}_@#>"
    
    # Если задан контекст, добавляем теги для соседних токенов
    if context > 0 and not tag_all:
        context_tags = [''] * len(tokens)
        
        for i in range(len(tokens)):
            if tags[i]:  # Это омограф
                # Добавляем теги для соседних токенов в радиусе context
                for offset in range(1, context + 1):
                    # Токен слева
                    left_idx = i - offset
                    if left_idx >= 0 and left_idx in [idx for idx in orig_word_indices]:
                        # Находим соответствующий tt_idx
                        tt_idx = orig_word_indices.index(left_idx)
                        if tt_idx < len(tt_word_indices):
                            context_tags[left_idx] = f"<#@_{tt_tokens[tt_word_indices[tt_idx]][1]}_@#>"
                    
                    # Токен справа
                    right_idx = i + offset
                    if right_idx < len(tokens) and right_idx in [idx for idx in orig_word_indices]:
                        tt_idx = orig_word_indices.index(right_idx)
                        if tt_idx < len(tt_word_indices):
                            context_tags[right_idx] = f"<#@_{tt_tokens[tt_word_indices[tt_idx]][1]}_@#>"
        
        # Объединяем теги омографов и контекстные теги
        for i in range(len(tokens)):
            if not tags[i] and context_tags[i]:
                tags[i] = context_tags[i]
    
    # Собираем строку
    result = []
    
    # Добавляем первый разделитель
    if separators and separators[0]:
        result.append(separators[0])
    
    for i, token in enumerate(tokens):
        result.append(token)
        
        # Добавляем разделитель после токена
        if i < len(separators) - 1:
            sep = separators[i + 1]
            
            # Если есть тег, вставляем его в начало разделителя
            if tags[i]:
                result.append(tags[i])
            
            result.append(sep)
    
    return ''.join(result)


def process_file(input_file: str, output_file: str, omographs: Set[str], 
                 debug: bool = False, tag_all: bool = False, context_size: int = 0,
                 treetagger_path: str = './rnn-tagger-russian.sh'):
    """Обрабатывает файл целиком."""
    
    print(f"Reading input file {input_file}...", file=sys.stderr)
    
    original_lines = []
    lines_with_omo = {}
    
    with open(input_file, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            line = line.rstrip('\n')
            original_lines.append(line)
            
            # Удаляем XML-теги для анализа
            clean_line = remove_xml_tags(line)
            
            # Токенизируем
            tokens, separators = tokenize_line(clean_line)
            
            if debug:
                print(f"\nLine {line_num}: {clean_line[:100]}", file=sys.stderr)
                print(f"  Tokens: {tokens}", file=sys.stderr)
                print(f"  Separators: {separators}", file=sys.stderr)
            
            if not tokens:
                if debug:
                    print(f"  No tokens found", file=sys.stderr)
                continue
            
            # Проверяем наличие омографов
            if line_has_omographs(tokens, omographs):
                lines_with_omo[line_num] = (tokens, separators)
                if debug:
                    print(f"  Found omographs in line {line_num}", file=sys.stderr)
    
    print(f"Found {len(lines_with_omo)} lines with omographs", file=sys.stderr)
    
    if not lines_with_omo:
        print("No omographs found in text", file=sys.stderr)
        with open(input_file, 'r', encoding='utf-8') as f_in, \
             open(output_file, 'w', encoding='utf-8') as f_out:
            f_out.write(f_in.read())
        sys.exit(0)
    
    # Подготавливаем текст для TreeTagger
    print("Preparing text for TreeTagger...", file=sys.stderr)
    tt_input_parts = []
    
    for line_num in sorted(lines_with_omo.keys()):
        tokens, separators = lines_with_omo[line_num]
        
        prepared_line = prepare_for_treetagger(tokens, separators)
        
        # Добавляем две разные метки
        marker_start = f'ЪЬЪSTART{line_num:08d}ЪЬЪ '
        marker_end = f' ЪЬЪEND{line_num:08d}ЪЬЪ'
        tt_input_parts.append(marker_start + prepared_line + marker_end)
        
        if debug:
            print(f"\nPrepared line {line_num}: '{prepared_line}'", file=sys.stderr)
            print(f"With markers: '{marker_start + prepared_line + marker_end}'", file=sys.stderr)
    
    tt_input = '\n'.join(tt_input_parts) + '\n'
    
    if debug:
        print(f"\n=== Full TT input ({len(tt_input)} chars) ===", file=sys.stderr)
        print(tt_input, file=sys.stderr)
        print("=== End TT input ===\n", file=sys.stderr)
    
    # Запускаем TreeTagger
    print("Running TreeTagger...", file=sys.stderr)
    tt_output = run_treetagger(tt_input, treetagger_path=treetagger_path, debug=debug)
    
    if not tt_output:
        print("Error: TreeTagger returned empty output", file=sys.stderr)
        sys.exit(1)
    
    # Разбираем вывод TreeTagger
    print("Parsing TreeTagger output...", file=sys.stderr)
    tt_data = parse_treetagger_output(tt_output, debug=debug)
    
    print(f"Parsed {len(tt_data)} lines from TreeTagger", file=sys.stderr)
    
    if debug:
        print(f"\nParsed lines: {list(tt_data.keys())}", file=sys.stderr)
    
    # Создаем выходной файл
    print(f"Creating output file {output_file}...", file=sys.stderr)
    
    with open(output_file, 'w', encoding='utf-8') as f_out:
        for line_num, original_line in enumerate(original_lines, 1):
            if line_num in tt_data and line_num in lines_with_omo:
                tokens, separators = lines_with_omo[line_num]
                tt_tokens = tt_data[line_num]
                
                if debug:
                    print(f"\nRebuilding line {line_num}", file=sys.stderr)
                    print(f"  Original: {original_line}", file=sys.stderr)
                    print(f"  Tokens: {tokens}", file=sys.stderr)
                    print(f"  TT tokens: {tt_tokens}", file=sys.stderr)
                
                rebuilt = rebuild_line(original_line, tokens, separators, 
                                      tt_tokens, omographs, 
                                      tag_all=tag_all, context=context_size)
                
                if debug:
                    print(f"  Rebuilt: {rebuilt}", file=sys.stderr)
                
                f_out.write(rebuilt + '\n')
            else:
                f_out.write(original_line + '\n')
    
    print("Done!", file=sys.stderr)


def main():
    if len(sys.argv) < 4:
        print(__doc__, file=sys.stderr)
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    omo_file = sys.argv[3]
    
    # Путь к TreeTagger по умолчанию
    treetagger_path = './rnn-tagger-russian.sh'
    
    # Проверяем флаг пути к TreeTagger
    for i, arg in enumerate(sys.argv):
        if arg.startswith('--tt-path='):
            treetagger_path = arg.split('=')[1]
            sys.argv.remove(arg)
            break
    
    # Проверяем наличие флага отладки
    debug = '--debug' in sys.argv
    if debug:
        sys.argv.remove('--debug')
    
    # Проверяем флаг тегирования всех токенов
    tag_all = '--tag-all' in sys.argv
    if tag_all:
        sys.argv.remove('--tag-all')
    
    # Проверяем размер контекста
    context_size = 0
    for i, arg in enumerate(sys.argv):
        if arg.startswith('--context='):
            context_size = int(arg.split('=')[1])
            sys.argv.remove(arg)
            break
    
    # Проверяем файлы
    if not Path(input_file).exists():
        print(f"Error: input file '{input_file}' not found", file=sys.stderr)
        sys.exit(1)
    
    if not Path(omo_file).exists():
        print(f"Error: omograph list '{omo_file}' not found", file=sys.stderr)
        sys.exit(1)
    
    print(f"Loading omographs from {omo_file}...", file=sys.stderr)
    omographs = load_omographs(omo_file)
    print(f"Loaded {len(omographs)} omographs", file=sys.stderr)
    
    if debug:
        print("DEBUG MODE ENABLED", file=sys.stderr)
    if tag_all:
        print("TAG ALL TOKENS ENABLED", file=sys.stderr)
    if context_size > 0:
        print(f"CONTEXT SIZE: {context_size}", file=sys.stderr)
    print(f"TreeTagger path: {treetagger_path}", file=sys.stderr)
    
    # Обрабатываем файл
    process_file(input_file, output_file, omographs, debug=debug, 
                 tag_all=tag_all, context_size=context_size,
                 treetagger_path=treetagger_path)


if __name__ == '__main__':
    main()
