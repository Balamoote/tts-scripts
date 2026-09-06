#!/usr/bin/env python3
"""
Загрузчик групп омографов из словарей.

Формат class.list.gz:
    группа<TAB>метка_варианта1_<TAB>метка_варианта2_...

Формат automo.gz:
    группа<TAB>базовая_форма<TAB>метка_варианта<TAB>размеченный_вариант

Пример:
    class.list: x2016   gl_ed1e_    sw_em_d_
    automo:    x2016 взмету gl_ed1e_ взмету'
               x2016 взмету sw_em_d_ взмё'ту
"""

import gzip
import sys
from pathlib import Path
from typing import Dict, List, Optional, Tuple


class HomographGroups:
    """
    Загружает и хранит группы омографов.

    Атрибуты:
        groups: {группа: {вариант: {слово: ударная_форма}}}
        group_labels: {группа: {метка: номер_варианта}}
    """

    def __init__(self, dict_dir: str = None):
        if dict_dir is None:
            self.dict_dir = Path(__file__).parent.parent
        else:
            self.dict_dir = Path(dict_dir)
        self.groups: Dict[str, Dict[int, Dict[str, str]]] = {}
        self.group_labels: Dict[str, Dict[str, int]] = {}

    def load(self) -> int:
        """
        Загружает class.list.gz и automo.gz.

        Returns:
            количество загруженных групп
        """
        # Загружаем class.list.gz (метки вариантов)
        self._load_class_list()

        # Загружаем automo.gz (слова с ударениями)
        self._load_automo()

        return len(self.groups)

    def _load_class_list(self):
        """Загружает метки вариантов для групп."""
        filepath = self.dict_dir / "class.list.gz"

        if not filepath.exists():
            raise FileNotFoundError(f"Файл не найден: {filepath}")

        with gzip.open(filepath, "rt", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                parts = line.split()
                if len(parts) < 3:
                    continue

                group = parts[0].strip()
                labels = [p.strip() for p in parts[1:] if p.strip()]

                # Создаем словарь меток
                self.group_labels[group] = {}
                for i, label in enumerate(labels):
                    self.group_labels[group][label] = i

    def _load_automo(self):
        """Загружает слова с ударениями для групп."""
        filepath = self.dict_dir / "automo.gz"

        if not filepath.exists():
            raise FileNotFoundError(f"Файл не найден: {filepath}")

        with gzip.open(filepath, "rt", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue

                parts = line.split()
                if len(parts) < 4:
                    continue

                group = parts[0].strip()
                word = parts[1].strip()
                label = parts[2].strip()
                accented_form = parts[3].strip()
                # 5-я колонка (если есть) — дополнительная метка, не нужна

                # Проверяем, что группа известна
                if group not in self.group_labels:
                    continue

                # Проверяем, что метка известна
                if label not in self.group_labels[group]:
                    continue

                # Получаем номер варианта
                variant_id = self.group_labels[group][label]

                # Создаем структуру
                if group not in self.groups:
                    self.groups[group] = {}

                if variant_id not in self.groups[group]:
                    self.groups[group][variant_id] = {}

                # Убираем апостроф (обозначение ударения) из формы
                # В automo.gz ударение обозначается апострофом после гласной
                # Например: "взмету'" — ударение на "у"
                # Нужно преобразовать в форму с комбинирующим ударением
                accented_clean = self._convert_accent(accented_form)

                self.groups[group][variant_id][word] = accented_clean

    def _convert_accent(self, accented_form: str) -> str:
        """
        Конвертирует апострофное ударение в комбинирующий диакритический знак.

        Пример: "взмету'" -> "взмету\u0301"
        """
        result = []
        for i, ch in enumerate(accented_form):
            if ch == "'":
                # Апостроф — заменяем предыдущую гласную на гласную с ударением
                if result:
                    prev_ch = result[-1]
                    result[-1] = prev_ch + "\u0301"
            else:
                result.append(ch)

        return "".join(result)

    def get_group(self, group: str) -> Optional[Dict[int, Dict[str, str]]]:
        """
        Возвращает группу омографов.

        Args:
            group: идентификатор группы

        Returns:
            {вариант: {слово: ударная_форма}}
        """
        return self.groups.get(group)

    def get_words_in_group(self, group: str) -> List[str]:
        """
        Возвращает все слова в группе.

        Args:
            group: идентификатор группы

        Returns:
            список базовых форм
        """
        group_data = self.groups.get(group)
        if not group_data:
            return []

        words = set()
        for variant in group_data.values():
            words.update(variant.keys())

        return sorted(words)

    def get_accent_variants(self, group: str, word: Optional[str] = None) -> Optional[Dict[int, str]]:
        """
        Возвращает ударные формы для слова в группе.

        Args:
            group: идентификатор группы
            word: базовая форма (если None — первое слово в группе)

        Returns:
            {вариант: ударная_форма}
        """
        group_data = self.groups.get(group)
        if not group_data:
            return None

        # Если слово не указано, берем первое
        if word is None:
            words = self.get_words_in_group(group)
            if not words:
                return None
            word = words[0]

        # Собираем варианты для слова
        variants = {}
        for variant_id, words_dict in group_data.items():
            if word in words_dict:
                variants[variant_id] = words_dict[word]

        return variants if variants else None

    def get_num_variants(self, group: str) -> int:
        """
        Возвращает количество вариантов в группе.

        Args:
            group: идентификатор группы

        Returns:
            количество вариантов (2 или 3)
        """
        group_data = self.groups.get(group)
        return len(group_data) if group_data else 0

    def list_groups(self) -> List[str]:
        """
        Возвращает список всех групп.

        Returns:
            список идентификаторов групп
        """
        return sorted(self.groups.keys())

    def get_group_info(self, group: str) -> Dict:
        """
        Возвращает информацию о группе.

        Args:
            group: идентификатор группы

        Returns:
            словарь с информацией
        """
        group_data = self.groups.get(group)
        if not group_data:
            return {}

        words = self.get_words_in_group(group)
        num_variants = len(group_data)

        info = {"group": group, "num_variants": num_variants, "words": words, "variants": {}}

        for variant_id, words_dict in group_data.items():
            info["variants"][variant_id] = words_dict

        return info


def main():
    """Тестовая функция."""
    print("=== Тестирование HomographGroups ===\n")

    groups = HomographGroups("scriptdb")
    count = groups.load()

    print(f"Загружено групп: {count}")
    print(f"Групп с метками: {len(groups.group_labels)}")

    # Показываем первые группы
    all_groups = groups.list_groups()
    print(f"\nПервые 10 групп:")
    for group in all_groups[:10]:
        info = groups.get_group_info(group)
        print(f"  {group}: {info['num_variants']} варианта, {len(info['words'])} слов(а)")
        print(f"    Слова: {', '.join(info['words'])}")

    # Тестируем группу x2016
    if "x2016" in groups.groups:
        print(f"\nГруппа x2016:")
        info = groups.get_group_info("x2016")
        print(f"  Вариантов: {info['num_variants']}")
        print(f"  Слова: {info['words']}")

        for variant_id, words_dict in info["variants"].items():
            print(f"  Вариант {variant_id}:")
            for word, accented in words_dict.items():
                print(f"    {word} -> {accented}")


if __name__ == "__main__":
    main()
