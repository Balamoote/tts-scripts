#!/usr/bin/env python3
"""
Парсер отчёта об ошибках и добавление эталонных строк в обучающий корпус.

Формат отчёта об ошибках:
    <p>Эталонная строка=497852.txt</p>
    <p>Ошибочная строка=497852.txt</p>
    
    <p>Эталонная строка=497853.txt</p>
    <p>Ошибочная строка=497853.txt</p>
    ...

Использование:
    python3 parse_error_report.py --report errors.txt --train все1020_q.txt --homograph все --group x1111
"""

import argparse
import sys
from pathlib import Path
from typing import List, Tuple

sys.path.insert(0, str(Path(__file__).parent))

from parser import Tokenizer


def parse_report(report_file: str) -> List[Tuple[str, str]]:
    """
    Парсит файл отчёта об ошибках.
    
    Returns:
        список пар (эталонная, ошибочная)
    """
    pairs = []
    
    with open(report_file, 'r', encoding='utf-8') as f:
        lines = [line.strip() for line in f if line.strip()]
    
    # Строки идут парами: эталон, ошибка
    for i in range(0, len(lines) - 1, 2):
        correct = lines[i]
        wrong = lines[i + 1]
        pairs.append((correct, wrong))
    
    return pairs


def find_omograph_differences(correct: str, wrong: str, 
                              tokenizer: Tokenizer) -> bool:
    """
    Проверяет, есть ли различие в ударениях омографов.
    
    Returns:
        True, если строки различаются только ударениями
    """
    correct_tokens, correct_seps = tokenizer.tokenize(correct)
    wrong_tokens, wrong_seps = tokenizer.tokenize(wrong)
    
    if len(correct_tokens) != len(wrong_tokens):
        return False
    
    for i, (ct, wt) in enumerate(zip(correct_tokens, wrong_tokens)):
        # Нормализуем (убираем ударения, ё→е, нижний регистр)
        ct_clean = tokenizer.remove_accents(ct).replace('ё', 'е').lower()
        wt_clean = tokenizer.remove_accents(wt).replace('ё', 'е').lower()
        
        if ct_clean != wt_clean:
            # Слова различаются не только ударением
            return False
        
        # Если слова одинаковые, но ударения разные — это ошибка омографа
        if ct != wt:
            return True
    
    return False


def main():
    parser = argparse.ArgumentParser(description="Парсер отчёта об ошибках")
    parser.add_argument("--report", required=True, help="Файл отчёта об ошибках")
    parser.add_argument("--train", required=True, help="Обучающий корпус")
    parser.add_argument("--homograph", required=True, help="Базовая форма омографа")
    
    args = parser.parse_args()
    
    tokenizer = Tokenizer()
    pairs = parse_report(args.report)
    
    print(f"Найдено пар: {len(pairs)}")
    
    # Находим пары, где различие в ударениях омографа
    correct_lines = []
    for i, (correct, wrong) in enumerate(pairs, 1):
        if find_omograph_differences(correct, wrong, tokenizer):
            correct_lines.append(correct)
    
    print(f"Строк с ошибками омографа: {len(correct_lines)}")
    
    if not correct_lines:
        print("Нет ошибок для дообучения")
        return
    
    # Читаем существующий корпус
    train_path = Path(args.train)
    
    if not train_path.exists():
        print(f"Корпус не найден: {args.train}", file=sys.stderr)
        sys.exit(1)
    
    with open(train_path, 'r', encoding='utf-8') as f:
        existing_lines = set(line.strip() for line in f if line.strip())
    
    # Добавляем новые эталонные строки
    new_lines = []
    for line in correct_lines:
        if line not in existing_lines:
            new_lines.append(line)
    
    print(f"Новых строк для добавления: {len(new_lines)}")
    
    if new_lines:
        with open(train_path, 'a', encoding='utf-8') as f:
            for line in new_lines:
                f.write(line + '\n')
        print(f"Строки добавлены в {args.train}")
    else:
        print("Все строки уже в корпусе")
    
    # Показываем примеры
    print("\nПримеры добавленных строк:")
    for line in correct_lines[:5]:
        print(f"  {line}")


if __name__ == "__main__":
    main()
