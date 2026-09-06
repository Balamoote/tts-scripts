#!/usr/bin/env python3
"""
Загрузка семантических групп из txt файла для дообучения.

Формат файла:
    # Комментарии
    группа_слов: слово1, слово2, слово3
    глаголы: открыть, закрыть, сломать

Использование:
    python3 load_semantic.py --semantic semantic_groups.txt
"""

from typing import Dict, List, Set


def load_semantic_groups(filepath: str) -> Dict[str, Set[str]]:
    """
    Загружает семантические группы из txt файла.
    
    Returns:
        {группа: {слова}}
    """
    groups = {}
    
    with open(filepath, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            
            # Пропускаем пустые строки и комментарии
            if not line or line.startswith('#'):
                continue
            
            # Формат: группа: слово1, слово2, ...
            if ':' in line:
                parts = line.split(':', 1)
                group_name = parts[0].strip()
                words_str = parts[1].strip()
                
                # Разделяем слова запятыми или пробелами
                if ',' in words_str:
                    words = [w.strip() for w in words_str.split(',') if w.strip()]
                else:
                    words = [w.strip() for w in words_str.split() if w.strip()]
                
                if group_name not in groups:
                    groups[group_name] = set()
                groups[group_name].update(words)
    
    return groups


def add_semantic_features(features: Dict[str, float], tokens: List[str], 
                          homograph_pos: int, groups: Dict[str, Set[str]]) -> Dict[str, float]:
    """
    Добавляет семантические признаки на основе групп.
    
    Args:
        features: текущий словарь признаков
        tokens: список токенов
        homograph_pos: позиция омографа
        groups: семантические группы
        
    Returns:
        дополненный словарь признаков
    """
    start = max(0, homograph_pos - 10)
    end = min(len(tokens), homograph_pos + 11)
    
    for i in range(start, end):
        if i == homograph_pos:
            continue
        
        word = tokens[i].lower()
        word = ''.join(ch for ch in word if ch not in '\u0301\u0320\u0323\u0324\u032d\u0330')
        word = word.replace('ё', 'е')
        
        for group_name, words in groups.items():
            if word in words:
                features[f'semantic_{group_name}'] = 1.0
                features[f'semantic_word_{word}'] = 1.0
    
    return features


if __name__ == "__main__":
    groups = load_semantic_groups("semantic_groups.txt")
    print(f"Загружено групп: {len(groups)}")
    for group_name, words in groups.items():
        print(f"  {group_name}: {len(words)} слов")
