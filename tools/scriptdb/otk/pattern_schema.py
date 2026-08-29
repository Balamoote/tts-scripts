"""Построение схем паттернов для омографов"""

import re
from .utils import clean_accents

class PatternSchemaBuilder:
    """Строит схемы паттернов на основе морфологии и контекста"""
    
    def __init__(self, morphology):
        self.morphology = morphology
    
    def build_schema(self, lines, li, ti, window_size=8):
        """Строит схему паттерна для вхождения (li, ti)
        
        Возвращает:
        - schema: строковая схема
        - lemma_set: множество лемм, участвующих в схеме
        """
        tokens = lines[li]
        if ti < 0 or ti >= len(tokens):
            return None, set()
        
        # Находим границы предложения
        sent_start = self._find_sentence_start(tokens, ti)
        sent_end = self._find_sentence_end(tokens, ti)
        
        # Ограничиваем окно
        left = max(sent_start, ti - window_size)
        right = min(sent_end, ti + window_size + 1)
        
        # Строим схему
        schema_parts = []
        lemma_set = set()
        
        for i in range(left, right):
            t = tokens[i]
            
            if t["type"] == "word":
                clean = clean_accents(t["text"])
                
                if i == ti:
                    # Целевое слово — омограф
                    schema_parts.append(f"<{clean}>")
                    lemma_set.add(clean)
                else:
                    morph_info = self.morphology.analyze(clean)
                    notation = self._get_notation_variants(morph_info, clean)
                    
                    # Для глаголов добавляем лемму в [знать] формат
                    if self._is_verb(morph_info):
                        lemmas = self._get_lemmas(morph_info)
                        if lemmas:
                            lemma_str = "[" + "/".join(sorted(lemmas)) + "]"
                            schema_parts.append(lemma_str)
                            lemma_set.update(lemmas)
                        else:
                            schema_parts.append(notation)
                    else:
                        schema_parts.append(notation)
            else:
                gap = t["text"].strip()
                if gap:
                    # Пропускаем знаки конца предложения
                    if any(ch in gap for ch in ".!?…"):
                        continue
                    # Проверяем союзы
                    if self._is_union(gap):
                        schema_parts.append(f"[{gap}]")
                    elif self._is_punctuation(gap):
                        schema_parts.append(gap)
                    else:
                        schema_parts.append(gap)
        
        schema = " ".join(schema_parts)
        return schema, lemma_set
    
    def find_matching_occurrences(self, lines, target_li, target_ti, word_index, word, window_size=8):
        """Находит все вхождения с такой же схемой паттерна"""
        # Строим схему для целевого вхождения
        target_schema, target_lemmas = self.build_schema(lines, target_li, target_ti, window_size)
        if not target_schema:
            return []
        
        matching = []
        
        # Проходим по всем вхождениям этого слова
        if word in word_index:
            for li, ti in word_index[word]:
                if li == target_li and ti == target_ti:
                    continue
                
                schema, lemmas = self.build_schema(lines, li, ti, window_size)
                # Ищем похожие схемы: совпадение по леммам глаголов
                # или по типам согласований
                if schema and self._schemas_similar(target_schema, schema):
                    matching.append((li, ti, schema))
        
        return matching
    
    def _schemas_similar(self, schema1, schema2):
        """Проверяет, похожи ли две схемы"""
        if not schema1 or not schema2:
            return False
        
        # Извлекаем леммы глаголов из схем
        lemmas1 = set(re.findall(r"\[([^\]]+)\]", schema1))
        lemmas2 = set(re.findall(r"\[([^\]]+)\]", schema2))
        
        # Извлекаем целевую позицию
        target1 = re.findall(r"<([^>]+)>", schema1)
        target2 = re.findall(r"<([^>]+)>", schema2)
        
        if not target1 or not target2:
            return False
        
        # Целевые слова должны совпадать
        if target1[0] != target2[0]:
            return False
        
        # Если есть общие леммы глаголов — схемы похожи
        if lemmas1 and lemmas2 and lemmas1 & lemmas2:
            return True
        
        # Если лемм нет, сравниваем по частям речи вокруг целевого слова
        # Упрощенно: сравниваем нотации без лемм
        simplified1 = re.sub(r"\[[^\]]+\]", "VERB", schema1)
        simplified2 = re.sub(r"\[[^\]]+\]", "VERB", schema2)
        
        # Сравниваем позиции целевого слова в схеме
        pos1 = simplified1.find("<")
        pos2 = simplified2.find("<")
        
        if pos1 == -1 or pos2 == -1:
            return False
        
        # Сравниваем левую часть (до целевого слова)
        left1 = simplified1[:pos1].split()
        left2 = simplified2[:pos2].split()
        
        # Сравниваем последние 2-3 элемента слева
        if left1 and left2:
            # Берем последние 2 элемента
            last1 = left1[-2:] if len(left1) >= 2 else left1
            last2 = left2[-2:] if len(left2) >= 2 else left2
            
            # Если последние элементы совпадают — похожи
            if last1 == last2:
                return True
        
        return False
    
    def _find_sentence_start(self, tokens, ti):
        """Находит начало предложения"""
        for i in range(ti - 1, -1, -1):
            t = tokens[i]
            if t["type"] == "gap":
                if any(ch in t["text"] for ch in ".!?…"):
                    # Возвращаем индекс ПОСЛЕ знака препинания
                    return i + 1
        return 0
    
    def _find_sentence_end(self, tokens, ti):
        """Находит конец предложения"""
        for i in range(ti + 1, len(tokens)):
            t = tokens[i]
            if t["type"] == "gap":
                if any(ch in t["text"] for ch in ".!?…"):
                    # Возвращаем индекс ДО знака препинания (не включаем его)
                    return i
        return len(tokens)
    
    def _get_notation_variants(self, morph_info, word):
        """Возвращает нотацию с вариантами"""
        variants = []
        for morph_func, lemma in morph_info:
            short = self.morphology.get_short_notation(morph_func)
            if short not in variants:
                variants.append(short)
        
        if not variants:
            return "?"
        if len(variants) == 1:
            return variants[0]
        return "(" + ",".join(variants) + ")"
    
    def _is_verb(self, morph_info):
        """Проверяет, является ли слово глаголом"""
        for morph_func, lemma in morph_info:
            if morph_func.startswith("гл"):
                return True
        return False
    
    def _get_lemmas(self, morph_info):
        """Извлекает леммы из морфологической информации"""
        lemmas = set()
        for morph_func, lemma in morph_info:
            if lemma and lemma != "?":
                lemmas.add(lemma)
        return lemmas
    
    def _is_union(self, gap):
        """Проверяет, является ли гэп союзом"""
        unions = {"и", "а", "но", "или", "либо", "что", "чтобы", "если", "когда", "пока", "хотя"}
        return gap.strip() in unions
    
    def _is_punctuation(self, gap):
        """Проверяет, является ли гэп знаком препинания"""
        return any(ch in gap for ch in ",;:()[]{}«»\"'")
