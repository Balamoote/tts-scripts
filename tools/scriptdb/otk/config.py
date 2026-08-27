"""Конфигурация и настройки по умолчанию"""

import json
from pathlib import Path

CONFIG_FILE = Path(__file__).parent.parent.parent / ".omograph_tk.json"
STATE_FILE = Path(__file__).parent.parent.parent / "scriptaux" / "omograph_state.json"
WORD_RE = None  # будет импортирован из tokenizer

DEFAULT_COLORS = {
    "bg_main": "#2D2D2D",
    "bg_text": "#000000",
    "fg_text": "#FFFFFF",
    "fg_scripts": "#FFFFFF",
    "fg_occurrences": "#FFFFFF",
    "bg_treeview": "#000000",
    "fg_treeview": "#FFFFFF",
    "bg_treeview_heading": "#2D2D2D",
    "bg_button": "#3D3D3D",
    "fg_button": "#FFFFFF",
    "bg_button_active": "#555555",
    "bg_entry": "#000000",
    "fg_entry": "#FFFFFF",
    "bg_om_highlight": "#FFD700",
    "fg_om_highlight": "#000000",
    "bg_sel_line": "#1E3A5F",
    "fg_accent": "#00FF00",
    "fg_heading_focus": "#00FF00",
    "fg_context_line": "#AAAAAA",
    "fg_context_current": "#FFFFFF",
    "fg_separator": "#CCCCCC",
    "bg_accented_row": "#3A3A3A",
    "fg_dir_label": "#FFFFFF",
    "fg_dirty_label": "#FFFF99",
    "fg_status_saved": "#00FF00",
    "fg_status_clean": "#FFFFFF",
    "scrollbar_bg": "#555555",
    "scrollbar_active": "#777777",
}

DEFAULT_FONTS = {
    "ui": ("TkDefaultFont", 10),
    "scripts": ("TkDefaultFont", 10),
    "occurrences": ("DejaVu Sans", 13),
    "context": ("DejaVu Sans", 16),
    "omograph": ("DejaVu Sans", 16),
    "variant_bar": ("TkDefaultFont", 12, "bold"),
}

DEFAULT_SETTINGS = {
    "context_length": 40,
    "context_factor": 1.15,
    "cache_size": 20,
    "auto_cache_size": 10,
    "auto_cache": False,
    "allow_context_edit": False,
    "font_scale": 1.0,
    "book_reader": "",
    "pattern_window_size": 8,
}

def load_config():
    if CONFIG_FILE.exists():
        try:
            with open(CONFIG_FILE, "r", encoding="utf-8") as f:
                config = json.load(f)
            fonts = config.get("fonts", {})
            for key, value in fonts.items():
                if key in DEFAULT_FONTS and isinstance(value, list):
                    DEFAULT_FONTS[key] = tuple(value)
            settings = config.get("settings", {})
            for key, value in settings.items():
                if key in DEFAULT_SETTINGS:
                    DEFAULT_SETTINGS[key] = value
            scale = DEFAULT_SETTINGS.get("font_scale", 1.0)
            if scale != 1.0:
                for key in DEFAULT_FONTS:
                    val = DEFAULT_FONTS[key]
                    if isinstance(val, tuple) and len(val) >= 2:
                        DEFAULT_FONTS[key] = (val[0], int(val[1] * scale)) + val[2:]
            colors = config.get("colors", {})
            for key, value in colors.items():
                if key in DEFAULT_COLORS:
                    DEFAULT_COLORS[key] = value
        except Exception:
            pass
