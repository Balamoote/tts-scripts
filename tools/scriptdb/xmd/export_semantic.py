#!/usr/bin/env python3
"""
Экспорт семантических групп из обученной модели для аудита.

Использование:
    python3 export_semantic.py --model model.pkl --output semantic_groups.txt
"""

import argparse
from model import HomographModel


def export_semantic_groups(model: HomographModel, output_file: str, 
                           top_n: int = 200):
    """
    Экспортирует семантические группы из модели.
    
    Группирует признаки по типам и значениям омографа.
    """
    lines = []
    lines.append(f"# Семантические группы для омографа '{model.homograph}'")
    lines.append(f"# Значений: {model.num_meanings}")
    lines.append(f"# Создано из модели: {model.n_samples} примеров\n")
    
    # Для каждого значения омографа
    for meaning_id in range(model.num_meanings):
        lines.append(f"# Значение {meaning_id}: {model.accent_variants.get(meaning_id, '?')}")
        
        # Получаем важные признаки для этого класса
        weights = model.get_weights_for_class(meaning_id, top_n=top_n)
        
        # Группируем по типам
        lexical_words = []
        verbs = []
        adjectives = []
        prepositions = []
        
        for feature_name, weight in weights:
            if weight <= 0:
                continue
            
            if feature_name.startswith('left_word_') or feature_name.startswith('right_word_'):
                word = feature_name.rsplit('_', 1)[-1]
                lexical_words.append((word, weight))
            elif feature_name.startswith('verb_homo_pair_'):
                verb = feature_name.replace('verb_homo_pair_', '')
                verbs.append((verb, weight))
            elif feature_name.startswith('pattern_adjective_'):
                adj = feature_name.replace('pattern_adjective_before_', '').replace('pattern_adjective_after_', '')
                adjectives.append((adj, weight))
            elif feature_name.startswith('pattern_preposition_'):
                prep = feature_name.replace('pattern_preposition_before_', '')
                prepositions.append((prep, weight))
        
        # Выводим группы
        if lexical_words:
            lines.append(f"\n# Лексические слова (вес):")
            for word, weight in lexical_words[:30]:
                lines.append(f"#   {word} ({weight:.3f})")
        
        if verbs:
            lines.append(f"\n# Глаголы (вес):")
            for verb, weight in verbs[:30]:
                lines.append(f"#   {verb} ({weight:.3f})")
        
        if adjectives:
            lines.append(f"\n# Прилагательные (вес):")
            for adj, weight in adjectives[:20]:
                lines.append(f"#   {adj} ({weight:.3f})")
        
        if prepositions:
            lines.append(f"\n# Предлоги (вес):")
            for prep, weight in prepositions[:20]:
                lines.append(f"#   {prep} ({weight:.3f})")
        
        lines.append("")
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    
    print(f"Семантические группы экспортированы в {output_file}")


def main():
    parser = argparse.ArgumentParser(description="Экспорт семантических групп")
    parser.add_argument("--model", required=True, help="Путь к файлу модели")
    parser.add_argument("--output", required=True, help="Файл для экспорта")
    parser.add_argument("--top-n", type=int, default=200, help="Количество признаков")
    
    args = parser.parse_args()
    
    model = HomographModel("", 2)
    model.load(args.model)
    
    export_semantic_groups(model, args.output, args.top_n)


if __name__ == "__main__":
    main()
