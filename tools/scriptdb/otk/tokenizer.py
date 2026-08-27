"""Токенизация текста"""

import re
import unicodedata

WORD_RE = re.compile(r"[а-яёА-ЯЁ\u0300-\u036f]+")

def tokenize_line(line):
    tokens = []
    prev_end = 0
    for match in WORD_RE.finditer(line):
        start, end = match.span()
        if start > prev_end:
            tokens.append({"type": "gap", "text": line[prev_end:start]})
        word_text = match.group()
        clean = "".join(c for c in word_text if not unicodedata.combining(c)).replace("ё", "е").replace("Ё", "Е")
        tokens.append({"type": "word", "text": word_text, "clean": clean})
        prev_end = end
    if prev_end < len(line):
        tokens.append({"type": "gap", "text": line[prev_end:]})
    return tokens

def detokenize_line(tokens):
    return "".join(t["text"] for t in tokens)

