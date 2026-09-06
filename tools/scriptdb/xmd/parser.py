#!/usr/bin/env python3
"""
Парсер размеченного корпуса для омографов.

Принцип токенизации идентичен awk-модулю:
    - Слова состоят из букв (русских, латинских), цифр и знаков ударения
    - XML-теги и пунктуация являются разделителями
    - Ударения обозначаются комбинирующими диакритическими знаками

Формат разметки:
    - Базовая форма: "все", "Все", "ВСЕ" — неразмеченные
    - Форма с ё: "всё", "Всё", "ВСЁ" — размеченная (если ё несёт ударение)
    - Форма с ударением: "все́", "Все́", "ВСЕ́" — размеченная явно
"""

import re
from typing import List, Tuple, Dict, Optional, Set
from pathlib import Path


class Tokenizer:
    """
    Токенизатор, совместимый с awk-модулем.
    
    Использует те же шаблоны для разбиения текста на токены.
    """
    
    # Комбинирующие диакритические знаки для ударений
    _unxy = "\u0301\u0320\u0323\u0324\u032d\u0330"
    
    # Русские буквы
    _RUUC = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
    _rulc = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    
    # Латинские буквы
    _LAUC = "A-ZÀÁÂÃÄÅĀĂÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝ"
    _lalc = "a-zàáâãäåāăæçèéêëìíîïðñòóôõöøùúûüýß"
    
    def __init__(self):
        """Инициализация токенизатора."""
        
        # Паттерн для слова (как в awk)
        self.patword = re.compile(
            f"[{self._RUUC}{self._rulc}{self._unxy}0-9]+"
        )
        
        # Паттерн для разделителей
        self.patsep = re.compile(
            f"[^{self._RUUC}{self._rulc}{self._unxy}0-9]+"
        )
        
        # Паттерн для слова с дефисом (как hysnip в awk)
        self.pat_hyphen = re.compile(
            f"[{self._RUUC}{self._rulc}{self._unxy}]-[{self._RUUC}{self._rulc}{self._unxy}]"
        )
    
    def tokenize(self, text: str) -> Tuple[List[str], List[str]]:
        """
        Разбивает текст на токены и разделители.
        
        Args:
            text: строка текста
            
        Returns:
            (tokens, separators) — списки токенов и разделителей
        """
        tokens = []
        separators = []
        
        # Находим все слова и разделители
        pos = 0
        while pos < len(text):
            # Ищем следующее слово
            word_match = self.patword.search(text, pos)
            
            if not word_match:
                # Больше нет слов, оставшийся текст — разделитель
                if pos < len(text):
                    separators.append(text[pos:])
                break
            
            # Текст до слова — разделитель
            if word_match.start() > pos:
                separators.append(text[pos:word_match.start()])
            
            # Добавляем слово
            tokens.append(word_match.group())
            pos = word_match.end()
        
        return tokens, separators
    
    def split_line(self, line: str) -> int:
        """
        Разбивает строку на слова (как splitline в awk).
        
        Args:
            line: строка текста
            
        Returns:
            количество слов в строке
        """
        tokens, _ = self.tokenize(line)
        return len(tokens)
    
    def has_accent(self, word: str) -> bool:
        """
        Проверяет, содержит ли слово знак ударения.
        
        Args:
            word: словоформа
            
        Returns:
            True если есть ударение
        """
        return any(ch in self._unxy for ch in word)
    
    def has_yo(self, word: str) -> bool:
        """
        Проверяет, содержит ли слово букву ё.
        
        Args:
            word: словоформа
            
        Returns:
            True если есть буква ё
        """
        return 'ё' in word or 'Ё' in word
    
    def remove_accents(self, word: str) -> str:
        """
        Убирает знаки ударения из слова.
        
        Args:
            word: словоформа с ударением
            
        Returns:
            словоформа без ударения
        """
        return ''.join(ch for ch in word if ch not in self._unxy)
    
    def normalize_yo(self, word: str) -> str:
        """
        Нормализует букву ё (оставляет как есть, не заменяет на е).
        
        Args:
            word: словоформа
            
        Returns:
            нормализованная словоформа
        """
        return word


class HomographParser:
    """
    Парсер размеченного корпуса для конкретного омографа.
    
    Разметка:
        - Базовая форма: "все", "Все", "ВСЕ" — неразмеченные
        - Форма с ё: "всё", "Всё", "ВСЁ" — значение 0 (если ё несёт ударение)
        - Форма с ударением: "все́", "Все́", "ВСЕ́" — значение 1
        - Другие ударения: "всé", "всè" — другие значения
    """
    
    def __init__(self, homograph: str, accent_variants: Dict[int, str]):
        """
        Инициализация парсера.
        
        Args:
            homograph: базовая форма омографа (например, "замок")
            accent_variants: словарь {meaning_id: ударная_форма}
                           например: {0: "замо́к", 1: "за́мок"}
        """
        self.homograph = homograph
        self.accent_variants = accent_variants
        self.tokenizer = Tokenizer()
        
        # Создаем обратный словарь: ударная форма -> meaning_id
        self.accent_to_meaning = {}
        for meaning_id, accented_form in accent_variants.items():
            self.accent_to_meaning[accented_form] = meaning_id
            # Также добавляем форму с заглавной буквы
            self.accent_to_meaning[accented_form.capitalize()] = meaning_id
            self.accent_to_meaning[accented_form.upper()] = meaning_id
        
        # Создаем парадигму омографа (все формы)
        self.paradigm = self._build_paradigm()
    
    def _build_paradigm(self) -> Set[str]:
        """
        Строит парадигму омографа: все формы с ударениями и без.
        
        Returns:
            множество всех форм омографа
        """
        paradigm = set()
        
        # Базовая форма
        paradigm.add(self.homograph)
        paradigm.add(self.homograph.capitalize())
        paradigm.add(self.homograph.upper())
        
        # Все ударные формы
        for accented_form in self.accent_variants.values():
            paradigm.add(accented_form)
            paradigm.add(accented_form.capitalize())
            paradigm.add(accented_form.upper())
        
        return paradigm
    
    def is_homograph_form(self, word: str) -> bool:
        """
        Проверяет, является ли слово формой омографа.
        
        Args:
            word: словоформа
            
        Returns:
            True если это форма омографа
        """
        # Убираем ударения для сравнения с базовой формой
        word_normalized = self.tokenizer.remove_accents(word).lower()
        homograph_normalized = self.homograph.lower()
        
        # Прямое сравнение
        if word_normalized == homograph_normalized:
            return True
        
        # Сравнение с заменой ё на е
        word_yo_normalized = word_normalized.replace('ё', 'е')
        homograph_yo_normalized = homograph_normalized.replace('ё', 'е')
        
        return word_yo_normalized == homograph_yo_normalized
    
    def get_meaning(self, word: str) -> Optional[int]:
        """
        Определяет значение омографа по ударной форме.
        
        Args:
            word: словоформа с ударением
            
        Returns:
            meaning_id или None, если значение не определено
        """
        # Проверяем точное совпадение с ударной формой
        if word in self.accent_to_meaning:
            return self.accent_to_meaning[word]
        
        # Проверяем без учета регистра
        word_lower = word.lower()
        for accented_form, meaning_id in self.accent_to_meaning.items():
            if accented_form.lower() == word_lower:
                return meaning_id
        
        # Проверяем с заменой ё на е и наоборот
        word_yo_lower = word_lower.replace('ё', 'е')
        for accented_form, meaning_id in self.accent_to_meaning.items():
            accented_yo_lower = accented_form.lower().replace('ё', 'е')
            if accented_yo_lower == word_yo_lower:
                # Проверяем, что у слова есть ударение или ё
                if self.tokenizer.has_accent(word) or self.tokenizer.has_yo(word):
                    return meaning_id
        
        # Проверяем по ударению
        if self.tokenizer.has_accent(word):
            word_no_accent = self.tokenizer.remove_accents(word).lower()
            homograph_lower = self.homograph.lower()
            
            if word_no_accent == homograph_lower:
                # Есть ударение, но не совпадает с известными вариантами
                return None
        
        # Проверяем букву ё
        if self.tokenizer.has_yo(word):
            # Проверяем, есть ли вариант с ё в accent_variants
            for accented_form, meaning_id in self.accent_to_meaning.items():
                if self.tokenizer.has_yo(accented_form):
                    if accented_form.lower() == word.lower():
                        return meaning_id
        
        return None
    
    def parse_line(self, line: str) -> Optional[Tuple[List[str], int, int, str]]:
        """
        Парсит строку с размеченным омографом.
        
        Args:
            line: строка текста с размеченным омографом
            
        Returns:
            (tokens, homograph_pos, meaning_id, separator) или None
        """
        # Обрезаем метаданные =NNN.txt
        if '=' in line:
            line = line.split('=')[0]
        
        # Токенизируем строку
        tokens, separators = self.tokenizer.tokenize(line)
        
        if not tokens:
            return None
        
        # Ищем омограф среди токенов
        for i, token in enumerate(tokens):
            if self.is_homograph_form(token):
                # Определяем значение
                meaning_id = self.get_meaning(token)
                
                if meaning_id is not None:
                    # Сохраняем информацию о форме в токене
                    # Добавляем маркер: базовая_форма|meaning_id
                    tokens[i] = f"{self.homograph}|{meaning_id}"
                    
                    # Возвращаем результат
                    separator = separators[i] if i < len(separators) else ""
                    return tokens, i, meaning_id, separator
        
        return None
    
    def parse_corpus(self, lines: List[str]) -> Tuple[List[Tuple[List[str], int, int]], List[Tuple[int, str]]]:
        """
        Парсит весь размеченный корпус.
        
        Args:
            lines: список строк с размеченными омографами
            
        Returns:
            (parsed_data, errors)
            parsed_data: список (tokens, homograph_pos, meaning_id)
            errors: список (line_number, line) с ошибками
        """
        parsed_data = []
        errors = []
        
        for line_num, line in enumerate(lines, 1):
            line = line.strip()
            if not line:
                continue
            
            result = self.parse_line(line)
            if result is not None:
                tokens, pos, meaning_id, _ = result
                parsed_data.append((tokens, pos, meaning_id))
            else:
                errors.append((line_num, line))
        
        return parsed_data, errors
    
    def parse_file(self, filepath: str) -> Tuple[List[Tuple[List[str], int, int]], List[Tuple[int, str]]]:
        """
        Парсит файл с размеченным корпусом.
        
        Args:
            filepath: путь к файлу
            
        Returns:
            (parsed_data, errors)
        """
        with open(filepath, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        return self.parse_corpus(lines)
    
    def annotate_text(self, text: str, predictions: List[int]) -> str:
        """
        Аннотирует текст, заменяя омографы на ударные формы.
        
        Args:
            text: исходный текст
            predictions: список предсказанных meaning_id для каждого омографа
            
        Returns:
            аннотированный текст
        """
        tokens, separators = self.tokenizer.tokenize(text)
        
        prediction_idx = 0
        result_parts = []
        
        for i, token in enumerate(tokens):
            if i > 0 and i - 1 < len(separators):
                result_parts.append(separators[i - 1])
            
            if self.is_homograph_form(token) and prediction_idx < len(predictions):
                meaning_id = predictions[prediction_idx]
                if meaning_id in self.accent_variants:
                    # Сохраняем регистр
                    accented = self.accent_variants[meaning_id]
                    if token[0].isupper():
                        accented = accented.capitalize()
                    if token.isupper():
                        accented = accented.upper()
                    
                    result_parts.append(accented)
                    prediction_idx += 1
                else:
                    result_parts.append(token)
            else:
                result_parts.append(token)
        
        # Добавляем последний разделитель
        if len(separators) > len(tokens) - 1:
            result_parts.append(separators[-1])
        
        return ''.join(result_parts)


def main():
    """
    Тестовая функция для проверки работы парсера.
    """
    print("=== Тестирование HomographParser ===\n")
    
    # Создаем парсер для омографа "замок"
    parser = HomographParser(
        homograph="замок",
        accent_variants={
            0: "замо́к",  # запор
            1: "за́мок"   # строение
        }
    )
    
    # Тестовый корпус
    corpus = [
        "На двери висел большой замо́к.",
        "Мы посетили старинный за́мок.",
        "Открой замо́к ключом.",
        "Средневековый за́мок впечатляет.",
        "Это не размеченный замок.",  # без ударения - ошибка
    ]
    
    print("Тестовый корпус:")
    for line in corpus:
        print(f"  {line}")
    
    print("\nПарсинг...")
    parsed_data, errors = parser.parse_corpus(corpus)
    
    print(f"\nРазмечено: {len(parsed_data)} примеров")
    print(f"Ошибок: {len(errors)}")
    
    print("\nРазмеченные примеры:")
    for tokens, pos, meaning_id in parsed_data:
        print(f"  Токены: {tokens}")
        print(f"  Омограф: {tokens[pos]} на позиции {pos}")
        print(f"  Значение: {meaning_id}")
        print()
    
    if errors:
        print("Ошибки:")
        for line_num, line in errors:
            print(f"  Строка {line_num}: {line}")
    
    # Тест аннотирования
    print("\nТест аннотирования:")
    text = "На двери висел большой замок. Мы посетили старинный замок."
    predictions = [0, 1]  # первое - запор, второе - строение
    
    annotated = parser.annotate_text(text, predictions)
    print(f"Исходный: {text}")
    print(f"Аннотированный: {annotated}")


if __name__ == "__main__":
    main()
