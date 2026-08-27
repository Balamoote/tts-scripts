"""Морфологический анализ на основе словарей mano-*.stat"""

import gzip
import unicodedata
from pathlib import Path

class MorphologyAnalyzer:
    """Загружает и анализирует морфологические словари"""
    
    DICT_FILES = [
        "dic_gl.gz",    # глаголы
        "dic_prl.gz",   # прилагательные
        "dic_prop.gz",  # имена собственные
        "dic_prq.gz",   # причастия
        "dic_rest.gz",  # остальные (наречия, местоимения, предлоги и т.д.)
        "dic_suw.gz",   # существительные
    ]
    
    def __init__(self, stat_dir):
        self.stat_dir = Path(stat_dir)
        self._index = {}  # лексема -> [(морф_функция, лемма), ...]
        self._loaded = False
    
    def load(self):
        """Загружает все словари в индекс"""
        if self._loaded:
            return
        
        for dict_file in self.DICT_FILES:
            dict_path = self.stat_dir / dict_file
            if not dict_path.exists():
                continue
            
            try:
                with gzip.open(dict_path, "rt", encoding="utf-8") as f:
                    for line in f:
                        line = line.strip()
                        if not line:
                            continue
                        parts = line.split()
                        if len(parts) < 2:
                            continue
                        
                        lexeme = parts[0]
                        morph_func = parts[1]
                        
                        # Лемма может быть одиночной или множественной через #
                        lemmas = []
                        if len(parts) >= 3:
                            lemmas = parts[2].split("#")
                        else:
                            lemmas = [lexeme]
                        
                        # 4-е поле (служебные метки) отбрасываем
                        
                        if lexeme not in self._index:
                            self._index[lexeme] = []
                        for lemma in lemmas:
                            self._index[lexeme].append((morph_func, lemma))
            except Exception as e:
                print(f"Ошибка чтения {dict_file}: {e}")
        
        self._loaded = True
    
    def analyze(self, word):
        """Возвращает список морфологических разборов для слова"""
        if not self._loaded:
            self.load()
        
        # Ищем слово в нижнем регистре
        word_lower = word.lower()
        if word_lower in self._index:
            return self._index[word_lower]
        
        # Ищем с заглавной буквы
        word_capitalized = word.capitalize()
        if word_capitalized in self._index:
            return self._index[word_capitalized]
        
        # Ищем в верхнем регистре
        word_upper = word.upper()
        if word_upper in self._index:
            return self._index[word_upper]
        
        # Ищем с заменой ё на е
        word_yo = word_lower.replace("ё", "е").replace("Ё", "Е")
        if word_yo in self._index:
            return self._index[word_yo]
        
        # Пробуем без ударений (если слово с ударением)
        word_clean = "".join(c for c in word if not unicodedata.combining(c))
        if word_clean != word:
            return self.analyze(word_clean)
        
        return []
    
    def get_morph_info(self, word):
        """Возвращает информацию о слове: список (морф_функция, лемма)"""
        return self.analyze(word)
    
    def get_part_of_speech(self, morph_func):
        """Извлекает часть речи из морфологической функции"""
        if morph_func.startswith("гл_"):
            return "глагол"
        elif morph_func.startswith("сущ_"):
            return "существительное"
        elif morph_func.startswith("прл_"):
            return "прилагательное"
        elif morph_func.startswith("прч_"):
            return "причастие"
        elif morph_func.startswith("дееп_"):
            return "деепричастие"
        elif morph_func.startswith("нар"):
            return "наречие"
        elif morph_func.startswith("мест_"):
            return "местоимение"
        elif morph_func.startswith("числ_"):
            return "числительное"
        elif morph_func.startswith("предл"):
            return "предлог"
        elif morph_func.startswith("союз"):
            return "союз"
        elif morph_func.startswith("част"):
            return "частица"
        elif morph_func.startswith("межд"):
            return "междометие"
        elif morph_func.startswith("имя_"):
            return "имя_собственное"
        elif morph_func.startswith("отч_"):
            return "отчество"
        elif morph_func.startswith("фам_"):
            return "фамилия"
        elif morph_func.startswith("гео_"):
            return "гео_название"
        elif morph_func.startswith("орг_"):
            return "организация"
        elif morph_func.startswith("предик"):
            return "предикатив"
        elif morph_func.startswith("ввод"):
            return "вводное"
        else:
            return "неизвестно"
    
    def get_grammar(self, morph_func):
        """Извлекает грамматические признаки из морфологической функции"""
        parts = morph_func.split("_")
        
        grammar = {
            "full": morph_func,
            "pos": self.get_part_of_speech(morph_func),
            "gender": None,
            "number": None,
            "case": None,
            "person": None,
            "tense": None,
            "animacy": None,
            "transitivity": None,
        }
        
        # Род
        if "муж" in parts:
            grammar["gender"] = "муж"
        elif "жен" in parts:
            grammar["gender"] = "жен"
        elif "ср" in parts:
            grammar["gender"] = "ср"
        elif "общ" in parts:
            grammar["gender"] = "общ"
        
        # Число
        if "мн" in parts:
            grammar["number"] = "мн"
        elif "ед" in parts:
            grammar["number"] = "ед"
        
        # Падеж
        for case in ("им", "род", "дат", "вин", "тв", "пр", "зват", "мест", "парт"):
            if case in parts:
                grammar["case"] = case
                break
        
        # Лицо
        for person in ("1е", "2е", "3е"):
            if person in parts:
                grammar["person"] = person
                break
        
        # Время
        for tense in ("наст", "прош", "буд"):
            if tense in parts:
                grammar["tense"] = tense
                break
        
        # Одушевленность
        if "одуш" in parts:
            grammar["animacy"] = "одуш"
        elif "неод" in parts:
            grammar["animacy"] = "неод"
        
        # Переходность
        if "перех" in parts:
            grammar["transitivity"] = "перех"
        elif "непер" in parts or "перне" in parts:
            grammar["transitivity"] = "непер"
        
        return grammar
