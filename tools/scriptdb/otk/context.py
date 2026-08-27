"""Логика отображения контекста"""

from .utils import clean_accents

def compute_padding(context_widget, lines, li, ti, word, clean_accents_fn, font_obj):
    """Вычисляет паддинг для центрирования омографа"""
    tokens = lines[li]
    om_start = 0
    om_text = ""
    
    if ti is not None and 0 <= ti < len(tokens):
        pos = 0
        for tj in range(ti):
            pos += len(tokens[tj]["text"])
        om_start = pos
        om_text = tokens[ti]["text"]
    else:
        pos = 0
        for t in tokens:
            if t["type"] == "word" and t["clean"] == word:
                om_start = pos
                om_text = t["text"]
                break
            pos += len(t["text"])
    
    if not om_text:
        return om_start, om_text, "", 0, 0, 0
    
    context_widget.update_idletasks()
    space_w = font_obj.measure(" ")
    char_w = font_obj.measure("0")
    win_w = context_widget.winfo_width()
    if win_w < 100:
        win_w = 800
    
    half_screen_px = win_w // 2
    line_text = "".join(t["text"] for t in lines[li]).rstrip("\n\r")
    om_clean = clean_accents(om_text)
    num_prefix_px = font_obj.measure("N" * 5)
    prefix_px = font_obj.measure(clean_accents(line_text[:om_start]))
    om_px = font_obj.measure(om_clean)
    om_center_px = num_prefix_px + prefix_px + om_px // 2
    
    if om_center_px <= half_screen_px:
        padding_px = half_screen_px - om_center_px
        padding_chars = int(padding_px / space_w) if space_w > 0 else 0
        padding = " " * padding_chars
    else:
        padding = ""
        padding_chars = 0
    
    return om_start, om_text, padding, padding_chars, om_center_px, half_screen_px

