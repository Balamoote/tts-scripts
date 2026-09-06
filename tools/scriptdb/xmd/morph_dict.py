#!/usr/bin/env python3
"""
Модуль загрузки и обработки морфологических словарей.

Словари находятся в директории scriptdb/:
    dic_suw.gz  - существительные
    dic_gl.gz   - глагольные формы + деепричастия
    dic_prq.gz  - причастия отглагольные
    dic_prl.gz  - прилагательные
    dic_rest.gz - остальные части речи
    dic_prop.gz - имена собственные

Формат словаря (одна строка):
    словоформа<TAB>морфология<TAB>базовая_форма

Особенности:
    - 3-е поле может содержать '#' для объединения нескольких базовых форм
    - Морфология содержит полный набор грамматических признаков
"""

import gzip
import os
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple, Optional
from collections import defaultdict


class MorphDictionary:
    """
    Класс для работы с морфологическим словарём.

    Хранит:
        - word_forms: {словоформа: [(морфология, базовая_форма), ...]}
        - base_forms: {базовая_форма: {словоформа, ...}}
    """

    def __init__(self, dict_dir: str = None):
        """
        Инициализация словаря.

        Args:
            dict_dir: путь к директории со словарями (по умолчанию "scriptdb")
        """
        if dict_dir is None:
            self.dict_dir = Path(__file__).parent.parent
        else:
            self.dict_dir = Path(dict_dir)
        self.word_forms: Dict[str, List[Tuple[str, str]]] = defaultdict(list)
        self.base_forms: Dict[str, Set[str]] = defaultdict(set)
        self.loaded_files: List[str] = []

    def load_nouns(self) -> int:
        """
        Загружает словарь существительных (dic_suw.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_suw.gz")

    def load_verbs(self) -> int:
        """
        Загружает словарь глаголов и деепричастий (dic_gl.gz).
        Включает:
            - глагольные формы (гл_*)
            - деепричастия (дееп_*)

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_gl.gz")

    def load_verbs(self) -> int:
        """
        Загружает словарь глаголов (dic_gl.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_gl.gz")

    def load_participles(self) -> int:
        """
        Загружает словарь причастий (dic_prq.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_prq.gz")

    def load_adjectives(self) -> int:
        """
        Загружает словарь прилагательных и причастий (dic_prl.gz).
        Включает:
            - прилагательные (прл_*)
            - причастия (прч_*)

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_prl.gz")

    def load_adjectives(self) -> int:
        """
        Загружает словарь прилагательных (dic_prl.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_prl.gz")

    def load_rest(self) -> int:
        """
        Загружает словарь остальных частей речи (dic_rest.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_rest.gz")

    def load_proper_nouns(self) -> int:
        """
        Загружает словарь имён собственных (dic_prop.gz).

        Returns:
            количество загруженных словоформ
        """
        return self._load_file("dic_prop.gz")

    def load_all(self) -> int:
        """
        Загружает все словари.

        Returns:
            общее количество загруженных словоформ
        """
        total = 0
        total += self.load_nouns()
        total += self.load_verbs()
        total += self.load_participles()
        total += self.load_adjectives()
        total += self.load_rest()
        total += self.load_proper_nouns()
        return total
    

    def _load_file(self, filename: str) -> int:
        """
        Загружает один файл словаря.

        Args:
            filename: имя файла словаря

        Returns:
            количество загруженных словоформ
        """
        filepath = self.dict_dir / filename

        if not filepath.exists():
            raise FileNotFoundError(f"Словарь не найден: {filepath}")

        if filename in self.loaded_files:
            print(f"Предупреждение: файл {filename} уже загружен")
            return 0

        count = 0
        with gzip.open(filepath, "rt", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                parts = line.split()
                if len(parts) < 3:
                    continue

                word_form = parts[0]
                morphology = parts[1]
                base_form = parts[2]

                # Обрабатываем составные базовые формы
                if "#" in base_form:
                    # Разделяем на несколько базовых форм
                    for bf in base_form.split("#"):
                        bf = bf.strip()
                        if bf:
                            self._add_entry(word_form, morphology, bf)
                else:
                    self._add_entry(word_form, morphology, base_form)

                count += 1

        self.loaded_files.append(filename)
        print(f"Загружен {filename}: {count} словоформ", file=sys.stderr)
        return count

    def _add_entry(self, word_form: str, morphology: str, base_form: str):
        """
        Добавляет одну запись в словарь.

        Args:
            word_form: словоформа
            morphology: морфологические признаки
            base_form: базовая форма (лемма)
        """
        self.word_forms[word_form].append((morphology, base_form))
        self.base_forms[base_form].add(word_form)

    def get_morphology(self, word: str) -> List[Tuple[str, str]]:
        """
        Возвращает все морфологические интерпретации слова.

        Args:
            word: словоформа

        Returns:
            список пар (морфология, базовая_форма)
        """
        return self.word_forms.get(word, [])

    def get_base_forms(self, word: str) -> List[str]:
        """
        Возвращает все базовые формы для слова.

        Args:
            word: словоформа

        Returns:
            список базовых форм
        """
        return list(set(base_form for _, base_form in self.word_forms.get(word, [])))

    def get_word_forms(self, base_form: str) -> Set[str]:
        """
        Возвращает все словоформы для базовой формы.

        Args:
            base_form: базовая форма

        Returns:
            множество словоформ
        """
        return self.base_forms.get(base_form, set())

    def get_morph_tags(self, word: str) -> List[str]:
        """
        Возвращает только морфологические теги для слова.

        Args:
            word: словоформа

        Returns:
            список морфологических тегов
        """
        return [morph for morph, _ in self.word_forms.get(word, [])]

    def get_stats(self) -> Dict[str, int]:
        """
        Возвращает статистику словаря.

        Returns:
            словарь со статистикой
        """
        return {
            "total_word_forms": len(self.word_forms),
            "total_base_forms": len(self.base_forms),
            "loaded_files": len(self.loaded_files),
            "loaded_files_list": self.loaded_files.copy(),
        }

    def has_word(self, word: str) -> bool:
        """
        Проверяет наличие слова в словаре.

        Args:
            word: словоформа

        Returns:
            True если слово есть в словаре
        """
        return word in self.word_forms

    def get_morphology_by_pos(self, word: str, pos_prefix: str) -> List[Tuple[str, str]]:
        """
        Возвращает морфологию слова, отфильтрованную по части речи.

        Args:
            word: словоформа
            pos_prefix: префикс части речи (например, "сущ", "гл", "прл")

        Returns:
            список пар (морфология, базовая_форма) с нужной частью речи
        """
        all_morph = self.get_morphology(word)
        return [(morph, base) for morph, base in all_morph if morph.startswith(pos_prefix)]

    def save_binary(self, filepath: str):
        """
        Сохраняет словарь в бинарном формате для быстрой загрузки.

        Args:
            filepath: путь к файлу для сохранения
        """
        import pickle

        data = {"word_forms": dict(self.word_forms), "base_forms": {k: v for k, v in self.base_forms.items()}}
        with open(filepath, "wb") as f:
            pickle.dump(data, f, protocol=pickle.HIGHEST_PROTOCOL)
        print(f"Словарь сохранён в {filepath}", file=sys.stderr)

    def load_binary(self, filepath: str):
        """
        Загружает словарь из бинарного формата.

        Args:
            filepath: путь к файлу для загрузки
        """
        import pickle

        with open(filepath, "rb") as f:
            data = pickle.load(f)
        self.word_forms = defaultdict(list, data["word_forms"])
        self.base_forms = defaultdict(set, data["base_forms"])
        print(f"Словарь загружен из {filepath}", file=sys.stderr)


class NameAccentDictionary:
    """
    Класс для работы со словарем ударений имен собственных (namebase.gz).

    Формат файла:
        _слово=ударная_форма

    Пример:
        _аава=аа'ва
        _аавасакса=а'авасакса

    Словарь содержит только ударения, без морфологической информации.
    """

    def __init__(self, dict_dir: str = "scriptdb"):
        """
        Инициализация словаря ударений.

        Args:
            dict_dir: путь к директории со словарями
        """
        self.dict_dir = Path(dict_dir)
        self.accent_dict: Dict[str, str] = {}
        self.loaded = False

    def load(self) -> int:
        """
        Загружает словарь ударений (namebase.gz).

        Returns:
            количество загруженных записей
        """
        filepath = self.dict_dir / "namebase.gz"

        if not filepath.exists():
            raise FileNotFoundError(f"Словарь не найден: {filepath}")

        count = 0
        with gzip.open(filepath, "rt", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                # Формат: _слово=ударная_форма
                if "=" in line:
                    parts = line.split("=", 1)
                    if len(parts) == 2:
                        word = parts[0].lstrip("_")  # убираем ведущее подчеркивание
                        accented = parts[1]

                        # Сохраняем только если слово не пустое
                        if word:
                            self.accent_dict[word] = accented
                            count += 1

        self.loaded = True
        print(f"Загружен namebase.gz: {count} ударений")
        return count

    def get_accent(self, word: str) -> Optional[str]:
        """
        Возвращает ударную форму слова.

        Args:
            word: словоформа

        Returns:
            ударная форма или None, если слово не найдено
        """
        return self.accent_dict.get(word)

    def has_word(self, word: str) -> bool:
        """
        Проверяет наличие слова в словаре.

        Args:
            word: словоформа

        Returns:
            True если слово есть в словаре
        """
        return word in self.accent_dict

    def add_accent_to_word(self, word: str) -> str:
        """
        Добавляет ударение к слову, если оно есть в словаре.

        Args:
            word: словоформа без ударения

        Returns:
            слово с ударением или исходное слово, если ударение не найдено
        """
        accented = self.accent_dict.get(word)
        return accented if accented else word

    def get_stats(self) -> Dict[str, int]:
        """
        Возвращает статистику словаря.

        Returns:
            словарь со статистикой
        """
        return {"total_words": len(self.accent_dict), "loaded": self.loaded}

    def save_binary(self, filepath: str):
        """
        Сохраняет словарь в бинарном формате.

        Args:
            filepath: путь к файлу для сохранения
        """
        import pickle

        with open(filepath, "wb") as f:
            pickle.dump(self.accent_dict, f, protocol=pickle.HIGHEST_PROTOCOL)
        print(f"Словарь ударений сохранён в {filepath}")

    def load_binary(self, filepath: str):
        """
        Загружает словарь из бинарного формата.

        Args:
            filepath: путь к файлу для загрузки
        """
        import pickle

        with open(filepath, "rb") as f:
            self.accent_dict = pickle.load(f)
        self.loaded = True
        print(f"Словарь ударений загружен из {filepath}")


def main():
    """
    Тестовая функция для проверки работы модуля.
    """
    print("=== Тестирование MorphDictionary ===\n")

    # Создаём экземпляр словаря
    morph_dict = MorphDictionary("scriptdb")

    # Загружаем только существительные для теста
    print("Загрузка словаря существительных...")
    count = morph_dict.load_nouns()
    print(f"Загружено словоформ: {count}\n")

    # Тестируем получение морфологии
    test_words = ["замок", "замка", "замку", "мука", "муки"]

    print("Тестирование получения морфологии:")
    for word in test_words:
        morphs = morph_dict.get_morphology(word)
        if morphs:
            print(f"\nСлово: {word}")
            for morph, base in morphs:
                print(f"  Морфология: {morph}, Базовая форма: {base}")
        else:
            print(f"\nСлово: {word} - не найдено в словаре")

    # Статистика
    stats = morph_dict.get_stats()
    print(f"\n=== Статистика ===")
    print(f"Всего словоформ: {stats['total_word_forms']}")
    print(f"Всего базовых форм: {stats['total_base_forms']}")
    print(f"Загружено файлов: {stats['loaded_files']}")


if __name__ == "__main__":
    main()
