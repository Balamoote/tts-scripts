#!/usr/bin/env python3
"""
Анализ ошибок модели для выявления закономерностей.

Использование:
    python3 analyze_errors.py --model model/x1111.pkl --train все1020_q.txt --output error_analysis.txt
"""

import argparse
from collections import Counter, defaultdict
from morph_dict import MorphDictionary
from parser import HomographParser
from model import HomographModel


def analyze_errors(model: HomographModel, parsed_data: list, morph_dict: MorphDictionary,
                   output_file: str = None, max_errors: int = 50):
    """
    Анализирует ошибки модели.
    
    Args:
        model: обученная модель
        parsed_data: размеченные данные
        morph_dict: морфологический словарь
        output_file: файл для сохранения анализа
        max_errors: максимальное количество ошибок для анализа
    """
    
    errors = []
    correct = []
    
    # Разделяем на ошибки и правильные
    for tokens, pos, true_label in parsed_data:
        prediction = model.predict(tokens, pos, morph_dict)
        pred_label = prediction['meaning_id']
        
        if pred_label != true_label:
            errors.append({
                'tokens': tokens,
                'pos': pos,
                'true_label': true_label,
                'pred_label': pred_label,
                'confidence': prediction['confidence'],
                'probabilities': prediction['probabilities']
            })
        else:
            correct.append({
                'tokens': tokens,
                'pos': pos,
                'true_label': true_label,
                'pred_label': pred_label,
                'confidence': prediction['confidence'],
                'probabilities': prediction['probabilities']
            })
    
    print(f"Всего ошибок: {len(errors)} из {len(parsed_data)}")
    print(f"Точность: {len(correct) / len(parsed_data):.3f}")
    
    # Анализ контекста ошибок
    error_contexts = []
    for error in errors[:max_errors]:
        tokens = error['tokens']
        pos = error['pos']
        
        # Слова вокруг омографа
        left_words = tokens[max(0, pos-3):pos]
        right_words = tokens[pos+1:min(len(tokens), pos+4)]
        
        context = {
            'left': ' '.join(left_words),
            'right': ' '.join(right_words),
            'full': ' '.join(tokens),
            'true': error['true_label'],
            'pred': error['pred_label'],
            'confidence': error['confidence']
        }
        error_contexts.append(context)
    
    # Ищем частые паттерны
    left_counter = Counter()
    right_counter = Counter()
    verb_counter = Counter()
    adj_counter = Counter()
    prep_counter = Counter()
    
    for ctx in error_contexts:
        left_counter[ctx['left']] += 1
        right_counter[ctx['right']] += 1
        
        # Группируем по частям речи
        tokens = ctx['full'].split()
        true_pos = ctx['pos'] if 'pos' in ctx else None
        
        # Ищем глаголы, прилагательные, предлоги в ошибках
        for i, token in enumerate(tokens):
            word_clean = token.lower().replace('ё', 'е')
            word_clean = ''.join(ch for ch in word_clean if ch not in '\u0301\u0320\u0323\u0324\u032d\u0330')
            
            morphs = morph_dict.get_morphology(word_clean)
            
            for morph, base in morphs:
                if morph.startswith('гл'):
                    verb_counter[base] += 1
                    break
                if morph.startswith('прл') or morph.startswith('прч'):
                    adj_counter[base] += 1
                    break
                if morph.startswith('предл'):
                    prep_counter[base] += 1
                    break
    
    # Вывод анализа
    lines = []
    lines.append(f"=== Анализ ошибок модели '{model.homograph}' ===\n")
    lines.append(f"Всего ошибок: {len(errors)}")
    lines.append(f"Точность: {len(correct) / len(parsed_data):.3f}\n")
    
    lines.append("Частые левые контексты (3 слова до омографа):")
    for context, count in left_counter.most_common(20):
        lines.append(f"  [{count}x] {context}")
    
    lines.append("\nЧастые правые контексты (3 слова после омографа):")
    for context, count in right_counter.most_common(20):
        lines.append(f"  [{count}x] {context}")
    
    lines.append("\nЧастые глаголы в ошибочных примерах:")
    for verb, count in verb_counter.most_common(20):
        lines.append(f"  [{count}x] {verb}")
    
    lines.append("\nЧастые прилагательные в ошибочных примерах:")
    for adj, count in adj_counter.most_common(20):
        lines.append(f"  [{count}x] {adj}")
    
    lines.append("\nЧастые предлоги в ошибочных примерах:")
    for prep, count in prep_counter.most_common(20):
        lines.append(f"  [{count}x] {prep}")
    
    lines.append(f"\nПримеры ошибок (первые {max_errors}):")
    for i, ctx in enumerate(error_contexts[:max_errors], 1):
        lines.append(f"\n  {i}. Истинный: {ctx['true']}, Предсказан: {ctx['pred']}, Уверенность: {ctx['confidence']:.3f}")
        lines.append(f"     {ctx['full']}")
    
    # Выводим
    output = '\n'.join(lines)
    
    if output_file:
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(output)
        print(f"\nАнализ сохранён в {output_file}")
    else:
        print(output)
    
    return errors, correct


def main():
    parser = argparse.ArgumentParser(description="Анализ ошибок модели")
    parser.add_argument("--model", required=True, help="Путь к файлу модели")
    parser.add_argument("--train", required=True, help="Файл с размеченным корпусом")
    parser.add_argument("--meanings", required=True, help="Ударные формы через запятую")
    parser.add_argument("--output", help="Файл для сохранения анализа")
    parser.add_argument("--max-errors", type=int, default=50,
                       help="Максимальное количество ошибок для анализа")
    
    args = parser.parse_args()
    
    # Загружаем словарь
    morph_dict = MorphDictionary("scriptdb")
    morph_dict.load_all()
    
    # Загружаем модель
    model = HomographModel(homograph="", num_meanings=2)
    model.load(args.model)
    
    # Создаем парсер
    accent_variants = {}
    for i, acc in enumerate(args.meanings.split(',')):
        accent_variants[i] = acc.strip()
    
    parser = HomographParser(homograph=model.homograph, accent_variants=accent_variants)
    parsed_data, errors = parser.parse_file(args.train)
    
    # Анализируем ошибки
    analyze_errors(model, parsed_data, morph_dict, args.output, args.max_errors)


if __name__ == "__main__":
    main()
