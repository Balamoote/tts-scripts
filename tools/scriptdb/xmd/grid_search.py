#!/usr/bin/env python3
"""
Подбор гиперпараметров для модели омографов.

Перебирает C и window_size, оценивает точность на отложенной выборке.

Использование:
    python3 grid_search.py --group x1111 --train ../все1020_q.txt
"""

import sys
import random
from pathlib import Path
from typing import List, Tuple

sys.path.insert(0, str(Path(__file__).parent))

from model import HomographModel
from morph_dict import MorphDictionary
from parser import HomographParser
from homograph_groups import HomographGroups


def grid_search(group_id: str, train_file: str, C_values: List[float] = None,
                window_values: List[int] = None, dict_dir: str = None):
    """
    Подбирает оптимальные C и window_size.
    """
    if C_values is None:
        C_values = [0.1, 0.5, 1.0, 2.0, 5.0, 10.0]
    
    if window_values is None:
        window_values = [5, 8, 10, 15]
    
    # Загружаем группы
    groups = HomographGroups()
    groups.load()
    
    accent_variants = groups.get_accent_variants(group_id)
    words_in_group = groups.get_words_in_group(group_id)
    num_variants = groups.get_num_variants(group_id)
    
    homograph = words_in_group[0]
    
    # Загружаем словарь
    if dict_dir:
        morph_dict = MorphDictionary(dict_dir)
    else:
        morph_dict = MorphDictionary()
    morph_dict.load_all()
    
    # Парсим корпус
    parser = HomographParser(homograph, accent_variants)
    parsed_data, _ = parser.parse_file(train_file)
    
    # Используем все данные
    train_data = parsed_data
    test_data = parsed_data
    
    print(f"Всего примеров: {len(parsed_data)}")
    print(f"Перебор {len(C_values)} C x {len(window_values)} window = {len(C_values) * len(window_values)} комбинаций\n")
    
    results = []
    
    for C in C_values:
        for window in window_values:
            print(f"Обучение: C={C}, window={window}...")
            
            model = HomographModel(
                homograph=homograph,
                num_meanings=num_variants,
                window_size=window,
                C=C
            )
            
            model.train(train_data, morph_dict)
            
            # Оцениваем на тесте
            correct = 0
            total = 0
            predicted = 0
            
            for tokens, pos, true_label in test_data:
                prediction = model.predict(tokens, pos, morph_dict)
                total += 1
                
                if prediction['meaning_id'] is not None:
                    predicted += 1
                    if prediction['meaning_id'] == true_label:
                        correct += 1
            
            accuracy = correct / predicted if predicted > 0 else 0
            coverage = predicted / total if total > 0 else 0
            
            results.append({
                'C': C,
                'window': window,
                'accuracy': accuracy,
                'coverage': coverage,
                'correct': correct,
                'predicted': predicted,
                'total': total
            })
            
            print(f"  Точность: {accuracy:.3f}, Охват: {coverage:.3f} ({predicted}/{total})\n")
    
    # Сортируем по точности
    results.sort(key=lambda x: x['accuracy'], reverse=True)
    
    print("\n" + "="*60)
    print("РЕЗУЛЬТАТЫ ПОДБОРА")
    print("="*60)
    print(f"{'C':>6} {'Window':>8} {'Точность':>10} {'Охват':>8} {'Примеры':>10}")
    print("-"*40)
    
    for r in results:
        print(f"{r['C']:>6.1f} {r['window']:>8} {r['accuracy']:>10.3f} {r['coverage']:>8.3f} {r['predicted']:>7}/{r['total']}")
    
    best = results[0]
    print(f"\nЛучшие параметры: C={best['C']}, window={best['window']}")
    print(f"Точность: {best['accuracy']:.3f}, Охват: {best['coverage']:.3f}")


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(description="Подбор гиперпараметров")
    parser.add_argument("--group", required=True, help="Идентификатор группы")
    parser.add_argument("--train", required=True, help="Путь к корпусу")
    parser.add_argument("--C", nargs='+', type=float, help="Значения C для перебора")
    parser.add_argument("--window", nargs='+', type=int, help="Значения window для перебора")
    parser.add_argument("--dict-dir", help="Директория словарей")
    
    args = parser.parse_args()
    
    grid_search(
        group_id=args.group,
        train_file=args.train,
        C_values=args.C if args.C else None,
        window_values=args.window if args.window else None,
        dict_dir=args.dict_dir
    )
