"""Поиск паттернов в контексте омографов"""

from .utils import clean_accents

class PatternFinder:
    """Ищет паттерны в контексте вхождений"""
    
    def __init__(self, morphology, window_size=8):
        self.morphology = morphology
        self.window_size = window_size
    
    def get_context_window(self, lines, li, ti, word_index=None):
        """Возвращает окно контекста вокруг токена (li, ti)
        
        Возвращает список токенов с их позициями в окне ±window_size,
        ограниченный границами предложения.
        """
        if li < 0 or li >= len(lines):
            return []
        
        tokens = lines[li]
        if ti < 0 or ti >= len(tokens):
            return []
        
        # Определяем границы предложения
        sentence_start = self._find_sentence_start(tokens, ti)
        sentence_end = self._find_sentence_end(tokens, ti)
        
        # Ограничиваем окно границами предложения
        left_bound = max(0, ti - self.window_size, sentence_start)
        right_bound = min(len(tokens), ti + self.window_size + 1, sentence_end)
        
        context = []
        for i in range(left_bound, right_bound):
            t = tokens[i]
            if t["type"] == "word":
                clean = clean_accents(t["text"])
                morph_info = self.morphology.analyze(clean) if self.morphology else []
                context.append({
                    "index": i,
                    "type": "word",
                    "text": t["text"],
                    "clean": clean,
                    "morph": morph_info,
                    "is_target": (i == ti),
                })
            else:
                # Гэп — знаки препинания, пробелы
                gap_text = t["text"]
                context.append({
                    "index": i,
                    "type": "gap",
                    "text": gap_text,
                    "has_sentence_end": self._has_sentence_end(gap_text),
                    "has_punctuation": self._has_punctuation(gap_text),
                })
        
        return context
    
    def _find_sentence_start(self, tokens, ti):
        """Находит начало предложения (индекс токена)"""
        for i in range(ti - 1, -1, -1):
            t = tokens[i]
            if t["type"] == "gap":
                if self._has_sentence_end(t["text"]):
                    return i + 1
        return 0
    
    def _find_sentence_end(self, tokens, ti):
        """Находит конец предложения (индекс токена + 1)"""
        for i in range(ti + 1, len(tokens)):
            t = tokens[i]
            if t["type"] == "gap":
                if self._has_sentence_end(t["text"]):
                    return i + 1
        return len(tokens)
    
    def _has_sentence_end(self, gap_text):
        """Проверяет, есть ли конец предложения в гэпе"""
        return any(ch in gap_text for ch in ".!?…")
    
    def _has_punctuation(self, gap_text):
        """Проверяет, есть ли знаки препинания в гэпе"""
        return any(ch in gap_text for ch in ",;:()[]{}«»\"'")
    
    def find_patterns(self, lines, li, ti, word_index=None):
        """Находит паттерны в контексте вокруг целевого токена (li, ti)
        
        Все паттерны строятся от целевого слова (омографа) и описывают
        его отношения с контекстом.
        """
        context = self.get_context_window(lines, li, ti, word_index)
        if not context:
            return []
        
        patterns = []
        
        # Находим целевое слово
        target = None
        for item in context:
            if item.get("is_target"):
                target = item
                break
        
        if not target:
            return []
        
        # Паттерн 1: Согласование падежей с целевым словом
        case_pattern = self._find_case_agreement(context, target)
        if case_pattern:
            patterns.append(case_pattern)
        
        # Паттерн 2: Согласование родов с целевым словом
        gender_pattern = self._find_gender_agreement(context, target)
        if gender_pattern:
            patterns.append(gender_pattern)
        
        # Паттерн 3: Лексические совпадения с целевым словом
        lexical_pattern = self._find_lexical_patterns(context, target)
        if lexical_pattern:
            patterns.extend(lexical_pattern)
        
        # Паттерн 4: Согласование по числу
        number_pattern = self._find_number_agreement(context, target)
        if number_pattern:
            patterns.append(number_pattern)
        
        # Паттерн 5: Согласование по времени (для глаголов)
        tense_pattern = self._find_tense_agreement(context, target)
        if tense_pattern:
            patterns.append(tense_pattern)
        
        return patterns

    def describe_patterns(self, lines, li, ti, word_index=None):
        """Генерирует текстовое описание паттернов для отображения"""
        context = self.get_context_window(lines, li, ti, word_index)
        if not context:
            return ""
        
        lines_out = []
        
        # Находим целевое слово
        target = None
        for item in context:
            if item.get("is_target"):
                target = item
                break
        
        if not target:
            return ""
        
        # Строка 1: Описание целевого токена
        target_desc = []
        for morph_func, lemma in target.get("morph", []):
            grammar = self.morphology.get_grammar(morph_func)
            target_desc.append(f"{morph_func} → {lemma}")
        
        if target_desc:
            lines_out.append(f"ЦЕЛЬ: {target['clean']} | {'; '.join(target_desc)}")
        else:
            lines_out.append(f"ЦЕЛЬ: {target['clean']} | нет морфологии")
        
        # Строки 2+: Описание паттернов
        patterns = self.find_patterns(lines, li, ti, word_index)
        
        for pattern in patterns:
            pattern_type = pattern["type"]
            
            if pattern_type == "case_agreement":
                cases = ", ".join(pattern.get("cases", []))
                lines_out.append(f"ПАТТЕРН: согласование падежей [{cases}]")
                # Описываем слова в паттерне
                for idx in pattern.get("match_indices", []):
                    for item in context:
                        if item["index"] == idx and item["type"] == "word":
                            morph_desc = []
                            for morph_func, lemma in item.get("morph", []):
                                morph_desc.append(morph_func)
                            lines_out.append(f"  {item['clean']}: {', '.join(morph_desc) if morph_desc else 'нет морфологии'}")
            
            elif pattern_type == "gender_agreement":
                genders = ", ".join(pattern.get("genders", []))
                lines_out.append(f"ПАТТЕРН: согласование родов [{genders}]")
                for idx in pattern.get("match_indices", []):
                    for item in context:
                        if item["index"] == idx and item["type"] == "word":
                            morph_desc = []
                            for morph_func, lemma in item.get("morph", []):
                                morph_desc.append(morph_func)
                            lines_out.append(f"  {item['clean']}: {', '.join(morph_desc) if morph_desc else 'нет морфологии'}")
            
            elif pattern_type == "number_agreement":
                numbers = ", ".join(pattern.get("numbers", []))
                lines_out.append(f"ПАТТЕРН: согласование чисел [{numbers}]")
                for idx in pattern.get("match_indices", []):
                    for item in context:
                        if item["index"] == idx and item["type"] == "word":
                            morph_desc = []
                            for morph_func, lemma in item.get("morph", []):
                                morph_desc.append(morph_func)
                            lines_out.append(f"  {item['clean']}: {', '.join(morph_desc) if morph_desc else 'нет морфологии'}")
            
            elif pattern_type == "tense_agreement":
                tenses = ", ".join(pattern.get("tenses", []))
                lines_out.append(f"ПАТТЕРН: согласование времен [{tenses}]")
                for idx in pattern.get("match_indices", []):
                    for item in context:
                        if item["index"] == idx and item["type"] == "word":
                            morph_desc = []
                            for morph_func, lemma in item.get("morph", []):
                                morph_desc.append(morph_func)
                            lines_out.append(f"  {item['clean']}: {', '.join(morph_desc) if morph_desc else 'нет морфологии'}")
            
            elif pattern_type == "lexical_context":
                lines_out.append(f"ПАТТЕРН: лексическое окружение [{pattern.get('word', '')}]")
                for idx in pattern.get("match_indices", []):
                    for item in context:
                        if item["index"] == idx and item["type"] == "word":
                            lines_out.append(f"  {item['clean']} (рядом с целевым)")
        
        # Описываем последовательность токенов с гэпами
        lines_out.append("---")
        sequence = []
        for item in context:
            if item["type"] == "word":
                if item.get("is_target"):
                    sequence.append(f"[{item['clean']}]")
                else:
                    sequence.append(item["clean"])
            else:
                gap = item["text"].strip()
                if gap:
                    sequence.append(gap)
        lines_out.append(" ".join(sequence))
        
        return "\n".join(lines_out)
    
    def _find_case_agreement(self, context, target):
        """Ищет согласование падежей между целевым словом и контекстом"""
        if not target.get("morph"):
            return None
        
        # Получаем падежи целевого слова
        target_cases = set()
        for morph_func, lemma in target["morph"]:
            grammar = self.morphology.get_grammar(morph_func)
            if grammar["case"]:
                target_cases.add(grammar["case"])
        
        if not target_cases:
            return None
        
        # Ищем слова в контексте с теми же падежами
        matches = []
        for item in context:
            if item.get("is_target") or item["type"] != "word":
                continue
            for morph_func, lemma in item.get("morph", []):
                grammar = self.morphology.get_grammar(morph_func)
                if grammar["case"] in target_cases:
                    matches.append(item["index"])
                    break
        
        if matches:
            return {
                "type": "case_agreement",
                "target_index": target["index"],
                "match_indices": matches,
                "cases": sorted(target_cases),
            }
        return None
    
    def _find_gender_agreement(self, context, target):
        """Ищет согласование родов"""
        if not target.get("morph"):
            return None
        
        target_genders = set()
        for morph_func, lemma in target["morph"]:
            grammar = self.morphology.get_grammar(morph_func)
            if grammar["gender"]:
                target_genders.add(grammar["gender"])
        
        if not target_genders:
            return None
        
        matches = []
        for item in context:
            if item.get("is_target") or item["type"] != "word":
                continue
            for morph_func, lemma in item.get("morph", []):
                grammar = self.morphology.get_grammar(morph_func)
                if grammar["gender"] in target_genders:
                    matches.append(item["index"])
                    break
        
        if matches:
            return {
                "type": "gender_agreement",
                "target_index": target["index"],
                "match_indices": matches,
                "genders": sorted(target_genders),
            }
        return None
    
    def _find_lexical_patterns(self, context, target):
        """Ищет лексические совпадения с целевым словом"""
        target_clean = target.get("clean", "")
        if not target_clean:
            return []
        
        word_counts = {}
        for item in context:
            if item["type"] == "word" and not item.get("is_target"):
                clean = item["clean"]
                if clean not in word_counts:
                    word_counts[clean] = []
                word_counts[clean].append(item["index"])
        
        patterns = []
        for word, indices in word_counts.items():
            # Лексический паттерн: слово встречается рядом с целевым
            # и имеет то же значение (лемму), что и целевое
            if len(indices) >= 1:
                patterns.append({
                    "type": "lexical_context",
                    "word": word,
                    "match_indices": indices,
                    "target_index": target["index"],
                    "target_word": target_clean,
                })
        
        return patterns
    
    def _find_number_agreement(self, context, target):
        """Ищет согласование по числу"""
        if not target.get("morph"):
            return None
        
        target_numbers = set()
        for morph_func, lemma in target["morph"]:
            grammar = self.morphology.get_grammar(morph_func)
            if grammar["number"]:
                target_numbers.add(grammar["number"])
        
        if not target_numbers:
            return None
        
        matches = []
        for item in context:
            if item.get("is_target") or item["type"] != "word":
                continue
            for morph_func, lemma in item.get("morph", []):
                grammar = self.morphology.get_grammar(morph_func)
                if grammar["number"] in target_numbers:
                    matches.append(item["index"])
                    break
        
        if matches:
            return {
                "type": "number_agreement",
                "target_index": target["index"],
                "match_indices": matches,
                "numbers": sorted(target_numbers),
            }
        return None
    
    def _find_tense_agreement(self, context, target):
        """Ищет согласование по времени (для глаголов)"""
        if not target.get("morph"):
            return None
        
        target_tenses = set()
        for morph_func, lemma in target["morph"]:
            grammar = self.morphology.get_grammar(morph_func)
            if grammar["tense"]:
                target_tenses.add(grammar["tense"])
        
        if not target_tenses:
            return None
        
        matches = []
        for item in context:
            if item.get("is_target") or item["type"] != "word":
                continue
            for morph_func, lemma in item.get("morph", []):
                grammar = self.morphology.get_grammar(morph_func)
                if grammar["tense"] in target_tenses:
                    matches.append(item["index"])
                    break
        
        if matches:
            return {
                "type": "tense_agreement",
                "target_index": target["index"],
                "match_indices": matches,
                "tenses": sorted(target_tenses),
            }
        return None
