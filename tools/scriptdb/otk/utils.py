"""Вспомогательные функции"""

import unicodedata

def is_unaccented(text):
    return not any(unicodedata.combining(ch) for ch in text) and "ё" not in text.lower()

def clean_accents(text):
    return "".join(c for c in text if not unicodedata.combining(c))

def clean_multiple_accents(text):
    accent = "\u0301"
    while accent * 2 in text:
        text = text.replace(accent * 2, accent)
    return text

def insert_context_with_accents(widget, text, base_tag):
    """Вставляет текст в виджет, подсвечивая ударения"""
    i = 0
    while i < len(text):
        ch = text[i]
        if i + 1 < len(text) and unicodedata.combining(text[i + 1]):
            widget.insert("end", ch + text[i + 1], "accent")
            i += 2
        else:
            widget.insert("end", ch, base_tag)
            i += 1

