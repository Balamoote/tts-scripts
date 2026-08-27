"""Сканирование книги и построение индексов"""

from .utils import is_unaccented

def build_word_index(lines):
    """Строит индекс словоформ: word -> [(line_idx, token_idx), ...]"""
    word_index = {}
    for li, tokens in enumerate(lines):
        for ti, t in enumerate(tokens):
            if t["type"] == "word":
                word = t["clean"]
                if word not in word_index:
                    word_index[word] = []
                word_index[word].append((li, ti))
    return word_index

def scan_all_omographs(lines, scripts_info):
    """Пересчитывает счетчики для всех омографов"""
    for info in scripts_info.values():
        info["unaccented_count"] = 0
        info["total_count"] = 0
        info["marked_count"] = 0
    
    for tokens in lines:
        for t in tokens:
            if t["type"] == "word" and t["clean"] in scripts_info:
                scripts_info[t["clean"]]["total_count"] += 1
                if is_unaccented(t["text"]):
                    scripts_info[t["clean"]]["unaccented_count"] += 1
                else:
                    scripts_info[t["clean"]]["marked_count"] += 1

