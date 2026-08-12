#!/usr/bin/env python3
"""
GUI-надстройка для управления скриптами замены омографов
Запуск: python3 omograph_gui.py
"""

import json
import os
import re
import subprocess
import tkinter as tk
import tkinter.font as tkfont
import unicodedata

try:
    import psutil
except ImportError:
    psutil = None
from pathlib import Path
from tkinter import filedialog, messagebox, ttk

CONFIG_FILE = Path("./.omograph_gui.json")
STATE_FILE = Path("./scriptaux/omograph_state.json")
WORD_RE = re.compile(r"[а-яёА-ЯЁ\u0300-\u036f]+")

DEFAULT_COLORS = {
    "bg_main": "#2D2D2D",
    "bg_text": "#000000",
    "fg_text": "#FFFFFF",
    "fg_scripts": "#FFFFFF",
    "fg_occurrences": "#FFFFFF",
    "bg_treeview": "#000000",
    "fg_treeview": "#FFFFFF",
    "bg_treeview_heading": "#2D2D2D",
    "bg_treeview_selected": "#1E3A5F",
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
    "fg_heading_focus": "#00FF00",
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
    "context_left": 40,
    "context_right": 50,
    "cache_size": 20,
    "auto_cache_size": 10,
    "auto_cache": False,
    "allow_context_edit": False,
    "font_scale": 1.0,
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


load_config()


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


class OmographManager:
    def __init__(self, root):
        self.root = root
        self.root.title("Менеджер омографов")
        self.root.geometry("1200x800")
        self.root.attributes("-zoomed", True)

        load_config()

        self.script_dir = Path.cwd()
        self.book_file = self.script_dir / "text-book.txt"  # fallback
        self.scripts_info = {}
        self._checked_words = set()
        self.lines = []
        self._dirty_lines = set()
        self._original_lines = {}
        self._tokenized = False
        self.current_occurrence = None
        self.current_occurrence_data = None
        self.current_word = None
        self.selected_variant = None
        self.occurrences = []
        self._occ_cache_dict = {}
        self._occ_cache_order = []
        self._occ_cache_size = DEFAULT_SETTINGS.get("cache_size", 20)
        self._undo_stack = []
        self._occ_sort_col = None
        self._tooltips = {}
        self._occ_font_obj = tk.font.Font(family=DEFAULT_FONTS["occurrences"][0], size=DEFAULT_FONTS["occurrences"][1])
        self._om_font_obj = tk.font.Font(family=DEFAULT_FONTS["omograph"][0], size=DEFAULT_FONTS["omograph"][1])
        self._context_font_obj = tk.font.Font(family=DEFAULT_FONTS["context"][0], size=DEFAULT_FONTS["context"][1])
        self._script_items_cache = None
        self._script_items_dirty = True
        self.create_widgets()
        self.bind_hotkeys()
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)
        self.root.after(100, self.initialize_working_directory)

    # ======================== ИНИЦИАЛИЗАЦИЯ ========================

    def initialize_working_directory(self):
        self._ensure_font_available()
        self.progress_var.set("Анализ данных ... ждите")
        self.root.update_idletasks()
        self.script_dir = self.get_working_directory()
        self.book_file = self.script_dir / "text-book.txt"
        if not self.book_file.exists():
            self.select_working_directory()
            return
        self.load_scripts()
        self._tokenize_book()
        self._scan_all_omographs()
        for word, info in self.scripts_info.items():
            if info.get("unaccented_count", 0) == 0:
                self._checked_words.add(word)
        self.filter_scripts()
        self.update_dir_label()
        self.progress_var.set("Готов к работе")

    def get_working_directory(self):
        if STATE_FILE.exists():
            try:
                with open(STATE_FILE, "r", encoding="utf-8") as f:
                    state = json.load(f)
                saved_dir = Path(state.get("working_directory", ""))
                if saved_dir.exists() and (saved_dir / "text-book.txt").exists():
                    return saved_dir
            except Exception:
                pass
        current_dir = Path.cwd()
        if (current_dir / "text-book.txt").exists():
            self.save_working_directory(current_dir)
            return current_dir
        return self.select_working_directory()

    def select_working_directory(self):
        initial_dir = Path.cwd()
        if STATE_FILE.exists():
            try:
                with open(STATE_FILE, "r", encoding="utf-8") as f:
                    state = json.load(f)
                saved_dir = Path(state.get("working_directory", ""))
                if saved_dir.exists():
                    initial_dir = saved_dir
            except Exception:
                pass
        dir_path = filedialog.askdirectory(
            title="Выберите директорию со скриптами и файлом text-book.txt",
            initialdir=initial_dir,
            mustexist=True,
        )
        if not dir_path:
            if not self.scripts_info:
                messagebox.showinfo("Выход", "Директория не выбрана.")
                self.root.quit()
            return self.script_dir
        selected_dir = Path(dir_path)
        book_file = selected_dir / "text-book.txt"
        if not book_file.exists():
            messagebox.showwarning("Ошибка", f"Файл text-book.txt не найден в {selected_dir}")
            return self.script_dir
        self.script_dir = selected_dir
        self.book_file = book_file
        self.save_working_directory(selected_dir)
        self.load_scripts()
        self._tokenize_book()
        self._scan_all_omographs()
        for word, info in self.scripts_info.items():
            if info.get("unaccented_count", 0) == 0:
                self._checked_words.add(word)
        self.filter_scripts()
        self.update_dir_label()
        messagebox.showinfo("Успех", f"Директория: {selected_dir}")
        return selected_dir

    def save_working_directory(self, directory):
        try:
            STATE_FILE.parent.mkdir(parents=True, exist_ok=True)
            state = {}
            if STATE_FILE.exists():
                with open(STATE_FILE, "r", encoding="utf-8") as f:
                    state = json.load(f)
            state["working_directory"] = str(directory.absolute())
            state["last_used"] = str(Path.cwd())
            with open(STATE_FILE, "w", encoding="utf-8") as f:
                json.dump(state, f, ensure_ascii=False, indent=2)
        except Exception as e:
            print(f"Ошибка сохранения состояния: {e}")

    def load_scripts(self):
        if not self.script_dir.exists():
            self.select_working_directory()
            return
        old_counts = {w: info.get("unaccented_count", 0) for w, info in self.scripts_info.items()}
        self.scripts_info.clear()
        target_file = None
        for script_file in self.script_dir.glob("*.sh"):
            if script_file.name == "stripper.sh":
                continue
            try:
                with open(script_file, "r", encoding="utf-8") as f:
                    content = f.read()
                info = {
                    "file": script_file,
                    "word": "",
                    "variants": [],
                    "unaccented_count": 0,
                    "auto_pattern": "",
                }
                for line in content.split("\n"):
                    if "Автошаблон:" in line:
                        m = re.search(r"Автошаблон:\s*(\S+)", line)
                        if m:
                            info["auto_pattern"] = m.group(1)
                    if "По умолчанию:" in line:
                        m = re.search(r"По умолчанию:\s*(\S+)", line)
                        if m:
                            info["default"] = m.group(1)
                    if "Всего найдено:" in line:
                        m = re.search(r"Всего найдено:\s*(\d+)", line)
                        if m:
                            info["total_found"] = int(m.group(1))
                    if "#" in line and "<=" in line and not line.strip().startswith("0)"):
                        m = re.search(r"#\s+(\S+)\s*<=\s*(\S+)", line)
                        if m:
                            info["variants"].append({"accented": m.group(1), "plain": m.group(2)})
                    # Извлекаем путь к целевому файлу из sed-строки
                    if "sed -ri" in line and target_file is None:
                        m = re.search(r"sed -ri.*?\.\./(\S+)", line)
                        if m:
                            target_file = self.script_dir.parent / m.group(1)
                if info["variants"]:
                    info["word"] = info["variants"][0]["plain"]
                    if "default" not in info:
                        info["default"] = info["variants"][0]["accented"]
                    self.scripts_info[info["word"]] = info
            except Exception as e:
                print(f"Ошибка парсинга {script_file}: {e}")
        if target_file and target_file.exists():
            self.book_file = target_file
        for w, count in old_counts.items():
            if w in self.scripts_info:
                self.scripts_info[w]["unaccented_count"] = count

    # ======================== ТОКЕНИЗАЦИЯ ========================

    def _tokenize_book(self):
        try:
            with open(self.book_file, "r", encoding="utf-8") as f:
                raw_lines = f.readlines()
            # Обрезаем до <binary (исключаем бинарные данные)
            cut = len(raw_lines)
            for i, line in enumerate(raw_lines):
                if re.search(r"<binary\s", line, re.IGNORECASE):
                    cut = i
                    break
            raw_lines = raw_lines[:cut]
            self.lines = [tokenize_line(line) for line in raw_lines]
            self._original_lines = {i: detokenize_line(tokens) for i, tokens in enumerate(self.lines)}
            self._build_word_index()
            self._tokenized = True
        except FileNotFoundError:
            self.lines = []
            self._tokenized = False

    def _build_word_index(self):
        self._word_index = {}
        for li, tokens in enumerate(self.lines):
            for ti, t in enumerate(tokens):
                if t["type"] == "word":
                    word = t["clean"]
                    if word not in self._word_index:
                        self._word_index[word] = []
                    self._word_index[word].append((li, ti))
    def _mark_dirty(self, li):
        self._script_items_dirty = True
        self._dirty_lines.add(li)
        cnt = len(self._dirty_lines)
        self.occ_counter_var.set(str(cnt) if cnt > 0 else "")
        if cnt > 0:
            self.dirty_status_var.set(f"⚠ Изменено строк: {cnt}")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_dirty_label"])
        else:
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_text"])
        self.progress_var.set(f"Изменено строк: {cnt} (💾 сохранить)")

    def _write_dirty_lines(self):
        if not self._tokenized or not self._dirty_lines:
            return
        try:
            with open(self.book_file, "r", encoding="utf-8") as f:
                raw_lines = f.readlines()
            for li in self._dirty_lines:
                if li < len(raw_lines):
                    raw_lines[li] = detokenize_line(self.lines[li])
            with open(self.book_file, "w", encoding="utf-8") as f:
                f.writelines(raw_lines)
            self._dirty_lines.clear()
            self.occ_counter_var.set("")
            self.dirty_status_var.set("✓ Сохранено")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_status_saved"])
            self.progress_var.set("✓ Сохранено")
        except Exception as e:
            messagebox.showerror("Ошибка", f"Не удалось записать файл: {e}")

    def _on_close(self):
        if self._dirty_lines:
            if messagebox.askyesno(
                "Сохранение",
                f"Есть несохранённые изменения ({len(self._dirty_lines)} строк).\nСохранить?",
            ):
                self._write_dirty_lines()
        self.root.destroy()

    # ======================== СКАНИРОВАНИЕ ========================

    def _scan_all_omographs(self):
        for info in self.scripts_info.values():
            info["unaccented_count"] = 0
        if not self._tokenized:
            return
        for tokens in self.lines:
            for t in tokens:
                if t["type"] == "word" and t["clean"] in self.scripts_info:
                    if self._is_unaccented(t["text"]):
                        self.scripts_info[t["clean"]]["unaccented_count"] += 1

    # ======================== ВСПОМОГАТЕЛЬНЫЕ ========================

    def _is_unaccented(self, text):
        return not any(unicodedata.combining(ch) for ch in text) and "ё" not in text.lower()

    def _clean_accents(self, text):
        return "".join(c for c in text if not unicodedata.combining(c))

    def _clean_multiple_accents(self, text):
        accent = "\u0301"
        while accent * 2 in text:
            text = text.replace(accent * 2, accent)
        return text

    # ======================== ЗАМЕНА ========================

    def _replace_token(self, li, ti, new_text):
        t = self.lines[li][ti]
        old_text = t["text"]
        old_clean = t["clean"]
        t["text"] = self._clean_multiple_accents(new_text)
        t["clean"] = self._clean_accents(new_text)
        self._undo_stack.append(("replace", li, ti, old_text, old_clean))

    def _clean_token(self, li, ti):
        t = self.lines[li][ti]
        old_text = t["text"]
        old_clean = t["clean"]
        t["text"] = self._clean_accents(t["text"])
        self._undo_stack.append(("clean", li, ti, old_text, old_clean))

    def replace_in_file(self, word, replacement):
        count = 0
        for li, tokens in enumerate(self.lines):
            for t in tokens:
                if t["type"] == "word" and t["clean"] == word:
                    if t["text"] != replacement:
                        t["text"] = replacement
                        self._mark_dirty(li)
                        count += 1
        if count > 0:
            self._scan_all_omographs()
        return count > 0

    def replace_selected_occurrence(self):
        if self.current_occurrence_data is None or not self.selected_variant:
            return
        li, ti = self.current_occurrence_data
        word = self.current_word
        old_idx = self.current_occurrence
        self._replace_token(li, ti, self.selected_variant)
        self._mark_dirty(li)
        if word in self.scripts_info:
            self.scripts_info[word]["unaccented_count"] = max(0, self.scripts_info[word].get("unaccented_count", 0) - 1)
        self._checked_words.add(word)
        self.progress_var.set("✓ Заменено вхождение")
        if not self.show_all_var.get():
            for item in self.occurrences_tree.get_children():
                tags = self.occurrences_tree.item(item, "tags")
                if tags and tags[0] and int(tags[0]) == old_idx:
                    self.occurrences_tree.delete(item)
                    break
            del self.occurrences[old_idx]
            for i, item in enumerate(self.occurrences_tree.get_children()):
                self.occurrences_tree.item(item, tags=(str(i), self.occurrences_tree.item(item, "tags")[1]))
            self._pending_advance_idx = old_idx
            self._occ_cache_key = None
            self._auto_advance_after_action(old_idx)
        else:
            for item in self.occurrences_tree.get_children():
                tags = self.occurrences_tree.item(item, "tags")
                if tags and tags[0] and int(tags[0]) == old_idx:
                    self.occurrences_tree.set(item, "omograph", self.selected_variant)
                    self.occurrences_tree.item(item, tags=(tags[0], "row_accented"))
                    self.occurrences_tree.selection_set(item)
                    self.occurrences_tree.see(item)
                    break
            if self.current_word:
                line_num, li, ti = self.occurrences[old_idx]
                self._ctx_li = -1
                self._ctx_ti = -1
                self.show_context_for_occurrence(line_num, self.current_word, ti)

    def clean_selected_occurrence(self):
        if self.current_occurrence_data is None:
            return
        li, ti = self.current_occurrence_data
        word = self.current_word
        old_idx = self.current_occurrence
        self._clean_token(li, ti)
        self._mark_dirty(li)
        if word in self.scripts_info:
            self.scripts_info[word]["unaccented_count"] = max(0, self.scripts_info[word].get("unaccented_count", 0) - 1)
        self._checked_words.add(word)
        self.progress_var.set("✓ Очищено вхождение")
        if not self.show_all_var.get():
            for item in self.occurrences_tree.get_children():
                tags = self.occurrences_tree.item(item, "tags")
                if tags and tags[0] and int(tags[0]) == old_idx:
                    self.occurrences_tree.delete(item)
                    break
            del self.occurrences[old_idx]
            for i, item in enumerate(self.occurrences_tree.get_children()):
                self.occurrences_tree.item(item, tags=(str(i), self.occurrences_tree.item(item, "tags")[1]))
            self._pending_advance_idx = old_idx
            self._occ_cache_key = None
            self._auto_advance_after_action(old_idx)
        else:
            for item in self.occurrences_tree.get_children():
                tags = self.occurrences_tree.item(item, "tags")
                if tags and tags[0] and int(tags[0]) == old_idx:
                    self.occurrences_tree.set(
                        item,
                        "omograph",
                        self._clean_accents(
                            self.lines[self.occurrences[old_idx][1]][self.occurrences[old_idx][2]]["text"]
                        ),
                    )
                    self.occurrences_tree.item(item, tags=(tags[0], "row_black"))
                    break
            if self.current_word:
                line_num, li, ti = self.occurrences[old_idx]
                self._ctx_li = -1
                self._ctx_ti = -1
                self.show_context_for_occurrence(line_num, self.current_word, ti)

    def clean_all_occurrences(self):
        if not self.current_word:
            return
        word = self.current_word
        for li, tokens in enumerate(self.lines):
            for t in tokens:
                if t["type"] == "word" and t["clean"] == word:
                    if not self._is_unaccented(t["text"]):
                        t["text"] = self._clean_accents(t["text"])
                        self._mark_dirty(li)
        self._scan_all_omographs()
        self.scripts_info[word]["unaccented_count"] = 0
        self._checked_words.add(word)
        self.progress_var.set(f"✓ Очищены все вхождения '{word}'")

    def replace_all_occurrences(self, silent=False):
        if not self.current_word or not self.selected_variant:
            if not silent:
                messagebox.showinfo("Информация", "Выберите вариант замены")
            return False
        word = self.current_word
        replacement = self.selected_variant
        if not silent:
            count = len(self.occurrences)
            if not messagebox.askyesno(
                "Подтверждение",
                f"Заменить ВСЕ видимые вхождения '{word}' → '{replacement}'?\nВсего: {count}",
            ):
                return False
        count = 0
        for line_num, li, ti in self.occurrences:
            self._replace_token(li, ti, replacement)
            self._mark_dirty(li)
            count += 1
        if count > 0:
            self._scan_all_omographs()
            self.scripts_info[word]["unaccented_count"] = 0
            self._checked_words.add(word)
            if not silent:
                self._navigate_script(1)
            return True
        return False

    # ======================== ЗАПОЛНЕНИЕ ВХОЖДЕНИЙ ========================

    def populate_occurrences(self, word):
        self.occurrences_tree.delete(*self.occurrences_tree.get_children())
        self.occurrences = []
        self._occ_sort_col = None
        self._update_occ_headings()
        show_all = self.show_all_var.get()

        cache_key = (word, show_all)
        if DEFAULT_SETTINGS.get("auto_cache", False) and cache_key in self._occ_cache_dict:
            batch, om_width, line_width = self._occ_cache_dict[cache_key]
            self.occurrences = [(b[0], b[1], b[2]) for b in batch]
            self._occ_cache = batch
            self._occ_cache_key = cache_key
            self._occ_batch = batch
            self._occ_batch_idx = 0
            self._occ_word = word
            self._occ_show_all = show_all
            self.occurrences_tree.column("line", width=int(line_width), stretch=False)
            self.occurrences_tree.column("omograph", width=om_width, stretch=False)
            self.occurrences_tree.unbind("<<TreeviewSelect>>")
            self._insert_occ_batch()
            return

        CONTEXT = DEFAULT_SETTINGS.get("context_length", 40)
        batch = []
        if hasattr(self, "_word_index") and word in self._word_index:
            for li, ti in self._word_index[word]:
                tokens = self.lines[li]
                t = tokens[ti]
                if not show_all and not self._is_unaccented(t["text"]):
                    continue
                line_str = detokenize_line(tokens).rstrip("\n\r")
                pos = 0
                for tj in range(ti):
                    pos += len(tokens[tj]["text"])
                om_start = pos
                om_end = pos + len(t["text"])
                ctx_start = max(0, om_start - CONTEXT)
                ctx_end = min(len(line_str), om_end + CONTEXT)
                prefix = line_str[ctx_start:om_start]
                om_text = line_str[om_start:om_end]
                suffix = line_str[om_end:ctx_end]
                if ctx_start > 0:
                    prefix = "…" + prefix
                if ctx_end < len(line_str):
                    suffix = suffix + "…"
                line_num = li + 1
                is_accented = not self._is_unaccented(t["text"])
                batch.append((line_num, li, ti, prefix, om_text, suffix, is_accented))

        self.occurrences = [(b[0], b[1], b[2]) for b in batch]
        self._occ_cache = batch
        self._occ_cache_key = (word, show_all)

        # Автоширина колонок с учётом шрифта occurrences
        occ_font_obj = self._occ_font_obj
        max_line = max(b[0] for b in batch) if batch else 1
        line_width = occ_font_obj.measure(str(max_line)) + 15
        self.occurrences_tree.column("line", width=int(line_width), stretch=False)
        max_om = max((b[4] for b in batch), key=lambda t: occ_font_obj.measure(t), default="")
        om_width = int(occ_font_obj.measure(max_om)) + 8 if max_om else 80
        self.occurrences_tree.column(
            "omograph",
            width=om_width,
            stretch=False,
        )

        self._occ_cache_dict[(word, show_all)] = (batch, om_width, line_width)
        if DEFAULT_SETTINGS.get("auto_cache", False):
            self._occ_cache_order.append((word, show_all))
            if len(self._occ_cache_order) > self._occ_cache_size:
                old_key = self._occ_cache_order.pop(0)
                if old_key in self._occ_cache_dict:
                    del self._occ_cache_dict[old_key]
        self.cache_label.config(text=f"Кэш: {len(self._occ_cache_dict)}/{self._occ_cache_size}")

        self._occ_batch = batch
        self._occ_batch_idx = 0
        self._occ_word = word
        self._occ_show_all = show_all
        self.occurrences_tree.unbind("<<TreeviewSelect>>")
        self._insert_occ_batch()

    def _insert_occ_batch(self):
        batch_size = 50
        batch = self._occ_batch
        start = self._occ_batch_idx
        end = min(start + batch_size, len(batch))
        for i in range(start, end):
            line_num, li, ti, prefix, om_text, suffix, is_accented = batch[i]
            row_tag = "row_accented" if is_accented else "row_black"
            self.occurrences_tree.insert(
                "",
                "end",
                values=(line_num, prefix, om_text, suffix),
                tags=(str(i), row_tag),
            )
        self._occ_batch_idx = end
        if end < len(batch):
            self.root.after(10, self._insert_occ_batch)
        else:
            self.occurrences_tree.bind("<<TreeviewSelect>>", self._on_occ_tree_select)
            self._checked_words.add(self._occ_word)
            self.progress_var.set(f"Найдено: {len(self.occurrences)}")
            if self.occurrences:
                self._select_occurrence(0)
            if hasattr(self, "_pending_advance_idx"):
                idx = self._pending_advance_idx
                del self._pending_advance_idx
                self._auto_advance_after_action(idx)

    # ======================== КОНТЕКСТ ========================

    def show_context_for_occurrence(self, line_num, word, ti=None):
        li = line_num - 1
        if getattr(self, "_ctx_li", -1) == li and getattr(self, "_ctx_ti", -1) == ti:
            return
        self._ctx_li = li
        self._ctx_ti = ti
        self.context_text.configure(state=tk.NORMAL)
        self.context_text.delete(1.0, tk.END)
        if li < 0 or li >= len(self.lines):
            if not DEFAULT_SETTINGS.get("allow_context_edit", False):
                self.context_text.configure(state=tk.DISABLED)
            return

        start_line = max(0, li - 2)
        end_line = min(len(self.lines), li + 3)

        tokens = self.lines[li]
        om_start = 0
        om_start_visual = 0
        om_text = ""
        if ti is not None and 0 <= ti < len(tokens):
            pos = 0
            for tj in range(ti):
                pos += len(tokens[tj]["text"])
                om_start_visual += len(self._clean_accents(tokens[tj]["text"]))
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
                om_start_visual += len(self._clean_accents(t["text"]))

        # Вычисляем паддинг до вставки
        if om_text:
            self.context_text.update_idletasks()
            font_obj = self._context_font_obj
            char_w = font_obj.measure("0")
            win_w = self.context_text.winfo_width()
            if win_w < 100:
                win_w = 800
            screen_chars = max(1, int(win_w / char_w))
            half_screen = screen_chars // 2

            om_char_pos = 5 + om_start_visual
            om_char_len = len(self._clean_accents(om_text))
            om_center_char = om_char_pos + om_char_len // 2

            if om_center_char <= half_screen:
                padding_chars = half_screen - om_center_char
            else:
                padding_chars = 0
            padding = " " * padding_chars
        else:
            padding = ""
            padding_chars = 0
            om_center_char = 0
            half_screen = 0

        # Вставляем строки один раз с паддингом
        for i in range(start_line, end_line):
            current_line_num = i + 1
            line_text_i = detokenize_line(self.lines[i]).rstrip("\n\r")
            tag = "current_line" if i == li else "context_line"

            self.context_text.insert(tk.END, f"{current_line_num:4d} ", "line_number")
            self.context_text.insert(tk.END, padding, tag)

            if i == li and om_text:
                om_end = om_start + len(om_text)
                self._insert_context_with_accents(line_text_i[:om_start], tag)
                self.context_text.insert(tk.END, om_text, "omograph")
                self._insert_context_with_accents(line_text_i[om_end:] + "\n", tag)
            else:
                self._insert_context_with_accents(line_text_i + "\n", tag)

        # Скролл только если омограф правее центра
        if not DEFAULT_SETTINGS.get("allow_context_edit", False):
            self.context_text.configure(state=tk.DISABLED)
        self.context_text.delete("end-2c", "end-1c")
        if om_text and om_center_char > half_screen:
            scroll_chars = om_center_char + padding_chars - half_screen
            self.context_text.xview_moveto(0.0)
            self.context_text.xview_scroll(scroll_chars, "units")

    def _copy_context_selection(self, event):
        try:
            sel = self.context_text.selection_get()
            self.root.clipboard_clear()
            self.root.clipboard_append(sel)
            self.progress_var.set("Выделенный текст скопирован")
        except tk.TclError:
            pass

    def _copy_auto_pattern(self, event):
        pattern = self.auto_pattern_var.get()
        if pattern and pattern != "нет":
            self.root.clipboard_clear()
            self.root.clipboard_append(pattern)
            self.progress_var.set("Номер шаблона скопирован в буфер")

    def _insert_context_with_accents(self, text, base_tag):
        """Вставляет текст в context_text, подсвечивая ударения зелёным."""
        i = 0
        while i < len(text):
            ch = text[i]
            if i + 1 < len(text) and unicodedata.combining(text[i + 1]):
                self.context_text.insert(tk.END, ch + text[i + 1], "accent")
                i += 2
            else:
                self.context_text.insert(tk.END, ch, base_tag)
                i += 1

    # ======================== ИНТЕРФЕЙС ========================

    def create_widgets(self):
        style = ttk.Style()
        ui_font = DEFAULT_FONTS["ui"]
        style.configure(".", font=ui_font)
        style.configure("TLabelframe.Label", font=(ui_font[0], ui_font[1], "bold"), padding=0)
        style.configure("Treeview", font=ui_font)
        style.configure(
            "Scripts.Treeview.Heading",
            font=(ui_font[0], ui_font[1], "bold"),
            background=DEFAULT_COLORS["bg_main"],
            foreground=DEFAULT_COLORS["fg_text"],
            borderwidth=0,
            relief="flat",
        )
        style.configure(
            "Occurrences.Treeview.Heading",
            font=(ui_font[0], ui_font[1], "bold"),
            background=DEFAULT_COLORS["bg_main"],
            foreground=DEFAULT_COLORS["fg_text"],
            borderwidth=0,
            relief="flat",
        )
        style.map(
            "Treeview",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )
        style.map(
            "Scripts.Treeview.Heading",
            background=[("active", DEFAULT_COLORS["bg_button_active"])],
            foreground=[("active", DEFAULT_COLORS["fg_text"])],
            relief=[("active", "raised")],
        )
        style.map(
            "Occurrences.Treeview.Heading",
            background=[("active", DEFAULT_COLORS["bg_button_active"])],
            foreground=[("active", DEFAULT_COLORS["fg_text"])],
            relief=[("active", "raised")],
        )
        style.configure("TButton", font=ui_font)
        style.configure("TCheckbutton", font=ui_font)
        style.configure("TLabel", font=ui_font)

        toolbar = ttk.Frame(self.root)
        toolbar.pack(fill=tk.X, padx=5, pady=5)

        ttk.Button(toolbar, text="⟳ Обновить", command=self.refresh_all).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Перечитать книгу и директорию скриптов\nCtrl+R")
        ttk.Button(toolbar, text="📁 Директория", command=self.change_directory).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Выбрать директорию скриптов\nCtrl+D")
        ttk.Button(toolbar, text="📖 Книга", command=self.open_book).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Открыть книгу в читалке\nb")
        ttk.Button(toolbar, text="🎯 Цель", command=self.change_target_file).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Сменить целевой файл\nCtrl+T")
        self.save_btn = ttk.Button(toolbar, text="💾 Сохранить", command=self._write_dirty_lines)
        self._add_tooltip(self.save_btn, "Сохранить изменения\nCtrl+S")
        self.save_btn.pack(side=tk.LEFT, padx=2)
        self.undo_btn = ttk.Button(toolbar, text="🔙 Назад", command=self._undo_last)
        self.undo_btn.pack(side=tk.LEFT, padx=(20, 2))
        self._add_tooltip(self.undo_btn, "Отменить последнее изменение\nu")
        ttk.Button(toolbar, text="💣 Отмена", command=self._undo_all).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Отменить все несохраненные изменения\nShift-U")
        ttk.Button(toolbar, text="📦 Наполнить", command=self._fill_cache).pack(side=tk.LEFT, padx=(20, 2))
        self._add_tooltip(toolbar.winfo_children()[-1], "Наполнить кэш списков вхождений\nF9")
        ttk.Button(toolbar, text="🗑 Очистить", command=self._clear_cache).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Очистить кэш списков вхождений\nF8")
        self.help_btn = ttk.Button(toolbar, text="?", width=3, command=self._show_help)
        self.help_btn.pack(side=tk.RIGHT, padx=2)
        self._add_tooltip(self.help_btn, "Справка\nF1")
        self.show_tips_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            toolbar,
            text="Tips",
            variable=self.show_tips_var,
        ).pack(side=tk.RIGHT, padx=(10, 2))
        self.status_label = ttk.Label(toolbar, text="", width=50, anchor="center")
        self.status_label.pack(side=tk.RIGHT, padx=(0, 10))

        # Основной контейнер: 2 колонки
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill=tk.BOTH, expand=True, padx=5, pady=(5, 0))
        main_frame.grid_columnconfigure(0, weight=0)
        main_frame.grid_columnconfigure(1, weight=1)
        main_frame.grid_rowconfigure(0, weight=1)

        # === ЛЕВАЯ КОЛОНКА ===
        left_col = ttk.Frame(main_frame)
        left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 5), pady=0)
        left_col.grid_rowconfigure(0, weight=1)

        left_frame = ttk.Frame(left_col)
        left_frame.grid(row=0, column=0, sticky="nsew", pady=(0, 0))

        left_header = ttk.Frame(left_frame)
        left_header.pack(fill=tk.X, padx=2, pady=0)
        self.search_var = tk.StringVar()
        self.search_var.trace("w", self.filter_scripts)
        style.configure("Search.TEntry", font=DEFAULT_FONTS["ui"])
        style.map(
            "Search.TEntry",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )
        self.search_entry = ttk.Entry(
            left_header,
            textvariable=self.search_var,
            style="Search.TEntry",
            font=DEFAULT_FONTS["ui"],
        )
        self.search_entry.pack(side=tk.LEFT, padx=0, fill=tk.X, expand=True)
        self.show_all_scripts_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            left_header,
            text="Все",
            variable=self.show_all_scripts_var,
            command=self.filter_scripts,
        ).pack(side=tk.RIGHT, padx=(2,0))
        refresh_btn = tk.Label(
            left_header,
            text="⟳",
            font=DEFAULT_FONTS["ui"],
            bg=DEFAULT_COLORS["bg_button"],
            fg=DEFAULT_COLORS["fg_text"],
            relief="raised",
            padx=4,
            cursor="hand2",
        )
        refresh_btn.pack(side=tk.RIGHT, padx=2)
        refresh_btn.bind("<Button-1>", lambda e: self._refresh_all_counts())

        style.configure(
            "Scripts.Treeview",
            font=DEFAULT_FONTS["scripts"],
            rowheight=int(DEFAULT_FONTS["scripts"][1] + 8),
            foreground=DEFAULT_COLORS["fg_scripts"],
        )
        style.map(
            "Scripts.Treeview",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )

        columns = ("word", "found")
        self.scripts_tree = ttk.Treeview(
            left_frame,
            columns=columns,
            show="headings",
            height=15,
            style="Scripts.Treeview",
        )
        self.scripts_tree.heading("word", text="Омограф", command=lambda: self._sort_scripts("word"))
        self.scripts_tree.heading("found", text="Стр", command=lambda: self._sort_scripts("found"))
        self.scripts_tree.column("word", minwidth=80, stretch=False)
        self.scripts_tree.column("found", width=52, minwidth=52, anchor="e", stretch=False)
        scripts_scroll = ttk.Scrollbar(left_frame, orient=tk.VERTICAL, command=self.scripts_tree.yview)
        self.scripts_tree.configure(yscrollcommand=scripts_scroll.set)
        self.scripts_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        scripts_scroll.pack(side=tk.RIGHT, fill=tk.Y)
        self.scripts_tree.bind("<<TreeviewSelect>>", self.on_script_select)
        self.scripts_tree.bind("<FocusIn>", self._on_tree_focus_in)
        self.scripts_tree.bind("<FocusOut>", self._on_tree_focus_out)

        # === ПРАВАЯ КОЛОНКА ===
        right_col = ttk.Frame(main_frame)
        right_col.grid(row=0, column=1, sticky="nsew")
        right_col.grid_rowconfigure(0, weight=1)
        right_col.grid_rowconfigure(1, weight=0)
        right_col.grid_rowconfigure(2, weight=0)
        right_col.grid_columnconfigure(0, weight=1)

        occ_frame = ttk.Frame(right_col)
        occ_frame.grid(row=0, column=0, sticky="nsew")
        occ_frame.grid_columnconfigure(0, weight=1)
        occ_frame.grid_rowconfigure(0, weight=1)
        occ_toolbar = ttk.Frame(occ_frame)
        occ_toolbar.pack(fill=tk.X, padx=2, pady=0)
        refresh_occ_btn = tk.Label(
            occ_toolbar,
            text="⟳",
            font=DEFAULT_FONTS["ui"],
            bg=DEFAULT_COLORS["bg_button"],
            fg=DEFAULT_COLORS["fg_text"],
            relief="raised",
            padx=4,
            cursor="hand2",
        )
        refresh_occ_btn.pack(side=tk.LEFT, padx=(0, 2))
        refresh_occ_btn.bind("<Button-1>", lambda e: self._refresh_occurrences())

        self.show_all_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            occ_toolbar,
            text="Все",
            variable=self.show_all_var,
            command=self._on_show_all_toggle,
        ).pack(side=tk.LEFT, padx=(0, 2))

        self.occ_variants_text = tk.Text(
            occ_toolbar,
            height=1,
            wrap=tk.NONE,
            font=DEFAULT_FONTS["variant_bar"],
            bg=DEFAULT_COLORS["bg_main"],
            fg=DEFAULT_COLORS["fg_text"],
            relief="flat",
            state="disabled",
        )
        self.occ_variants_text.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(2, 2))
        self.occ_variants_text.tag_configure("center", justify="center")
        self.occ_variants_text.tag_configure("accent", foreground=DEFAULT_COLORS["fg_accent"])

        self.occ_counter_var = tk.StringVar(value="")
        self.occ_counter_label = tk.Label(
            occ_toolbar,
            textvariable=self.occ_counter_var,
            font=DEFAULT_FONTS["ui"],
            fg=DEFAULT_COLORS["fg_dirty_label"],
            bg=DEFAULT_COLORS["bg_main"],
            width=5,
            anchor="e",
            relief="sunken",
            padx=3,
        )
        self.occ_counter_label.pack(side=tk.LEFT, padx=(2, 0))

        style.configure(
            "Occurrences.Treeview",
            font=DEFAULT_FONTS["occurrences"],
            rowheight=DEFAULT_FONTS["occurrences"][1] + 8,
            foreground=DEFAULT_COLORS["fg_occurrences"],
        )
        style.map(
            "Occurrences.Treeview",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )

        occ_columns = ("line", "prefix", "omograph", "suffix")
        self.occurrences_tree = ttk.Treeview(
            occ_frame,
            columns=occ_columns,
            show="headings",
            height=15,
            style="Occurrences.Treeview",
        )
        self.occurrences_tree.heading("line", text="Стр", command=self._sort_occurrences_by_line)
        self.occurrences_tree.heading("prefix", text="⟵ контекст", command=self._sort_occurrences_by_prefix)
        self.occurrences_tree.heading("omograph", text="Ом", command=self._sort_occurrences_by_line)
        self.occurrences_tree.heading("suffix", text="контекст ⟶", command=self._sort_occurrences_by_suffix)
        self.occurrences_tree.column("line", minwidth=30, width=40, anchor="e", stretch=False)
        self.occurrences_tree.column("prefix", width=300, anchor="e")
        self.occurrences_tree.column("omograph", width=80, anchor="center")
        self.occurrences_tree.column("suffix", width=300, anchor="w")

        self.occurrences_tree.tag_configure("row_black", background=DEFAULT_COLORS["bg_text"])
        self.occurrences_tree.tag_configure("row_accented", background=DEFAULT_COLORS["bg_accented_row"])
        self.occurrences_tree.tag_configure("selected", background=DEFAULT_COLORS["bg_sel_line"])

        occ_scroll = ttk.Scrollbar(occ_frame, orient=tk.VERTICAL, command=self.occurrences_tree.yview)
        self.occurrences_tree.configure(yscrollcommand=occ_scroll.set)
        self.occurrences_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        occ_scroll.pack(side=tk.RIGHT, fill=tk.Y)

        self.occurrences_tree.bind("<<TreeviewSelect>>", self._on_occ_tree_select)
        self.occurrences_tree.bind("<FocusIn>", self._on_tree_focus_in)
        self.occurrences_tree.bind("<FocusOut>", self._on_tree_focus_out)

        # Нижняя плашка: шаблон + варианты
        bottom_om_frame = ttk.Frame(right_col)
        bottom_om_frame.grid(row=1, column=0, sticky="ew", pady=(5, 0))

        self.auto_pattern_var = tk.StringVar(value="")
        self.auto_pattern_label = tk.Label(
            bottom_om_frame,
            textvariable=self.auto_pattern_var,
            font=DEFAULT_FONTS["ui"],
            fg=DEFAULT_COLORS["fg_dirty_label"],
            bg=DEFAULT_COLORS["bg_main"],
            width=5,
            anchor="center",
            relief="sunken",
            padx=3,
        )
        self.auto_pattern_label.pack(side=tk.LEFT, padx=(0, 2))
        self.auto_pattern_label.bind("<Button-3>", self._copy_auto_pattern)

        self.variants_text = tk.Text(
            bottom_om_frame,
            height=1,
            wrap=tk.NONE,
            font=DEFAULT_FONTS["variant_bar"],
            bg=DEFAULT_COLORS["bg_main"],
            fg=DEFAULT_COLORS["fg_text"],
            relief="sunken",
            state="disabled",
        )
        self.variants_text.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(2, 0))
        self.variants_text.tag_configure("accent", foreground=DEFAULT_COLORS["fg_accent"])

        context_frame = ttk.Frame(right_col)
        context_frame.grid(row=2, column=0, sticky="nsew", pady=(5, 0))
        context_frame.grid_columnconfigure(0, weight=1)
        context_frame.grid_rowconfigure(0, weight=1)
        cf = tkfont.Font(family=DEFAULT_FONTS["context"][0], size=DEFAULT_FONTS["context"][1])
        of_weight = (
            "bold" if len(DEFAULT_FONTS["omograph"]) > 2 and DEFAULT_FONTS["omograph"][2] == "bold" else "normal"
        )
        of = tkfont.Font(
            family=DEFAULT_FONTS["omograph"][0],
            size=DEFAULT_FONTS["omograph"][1],
            weight=of_weight,
        )
        max_linespace = max(cf.metrics()["linespace"], of.metrics()["linespace"])
        context_pixel_h = max_linespace * 5 + 18
        context_frame.config(height=context_pixel_h)
        context_frame.pack_propagate(False)

        context_height = 5
        self.context_text = tk.Text(
            context_frame,
            wrap=tk.NONE,
            bg=DEFAULT_COLORS["bg_text"],
            fg=DEFAULT_COLORS["fg_text"],
            insertbackground=DEFAULT_COLORS["fg_text"],
            font=DEFAULT_FONTS["context"],
            height=context_height,
            width=90,
            undo=False,
            maxundo=0,
            state=tk.DISABLED if not DEFAULT_SETTINGS.get("allow_context_edit", False) else tk.NORMAL,
        )

        ctx_scroll_x = ttk.Scrollbar(context_frame, orient=tk.HORIZONTAL, command=self.context_text.xview)
        self.context_text.configure(xscrollcommand=ctx_scroll_x.set)
        self.context_text.pack(side=tk.TOP, fill=tk.BOTH, expand=True, padx=0, pady=(0, 0))
        ctx_scroll_x.pack(side=tk.BOTTOM, fill=tk.X, padx=0, pady=(0, 0))
        self.context_text.bind("<Key>", lambda e: "break")
        self.context_text.bind("<Button-3>", self._copy_context_selection)
        self.context_text.bind("<q>", lambda e: self.context_text.xview_moveto(0.0))
        self.context_text.bind("<e>", lambda e: self.context_text.xview_moveto(1.0))
        self.context_text.bind("<a>", lambda e: self._scroll_context(-1))
        self.context_text.bind("<d>", lambda e: self._scroll_context(1))
        self.context_text.bind("<w>", lambda e: self._recenter_context())
        self.context_text.bind("<s>", lambda e: self._center_context_on_omograph())
        self.context_text.bind("<z>", lambda e: self._scroll_context_chars(-3))
        self.context_text.bind("<x>", lambda e: self._scroll_context_chars(3))
        self.context_text.bind("<Key-Cyrillic_shorti>", lambda e: self.context_text.xview_moveto(0.0))
        self.context_text.bind("<Key-Cyrillic_u>", lambda e: self.context_text.xview_moveto(1.0))
        self.context_text.bind("<Key-Cyrillic_ef>", lambda e: self._scroll_context(-1))
        self.context_text.bind("<Key-Cyrillic_ve>", lambda e: self._scroll_context(1))
        self.context_text.bind("<Key-Cyrillic_tse>", lambda e: self._recenter_context())
        self.context_text.bind("<Key-Cyrillic_yeru>", lambda e: self._center_context_on_omograph())
        self.context_text.bind("<Key-Cyrillic_ya>", lambda e: self._scroll_context_chars(-3))
        self.context_text.bind("<Key-Cyrillic_che>", lambda e: self._scroll_context_chars(3))
        self.context_text.bind("<MouseWheel>", self._on_mousewheel)
        self.context_text.bind("<Shift-MouseWheel>", self._on_mousewheel_horizontal)
        self.context_text.bind("<Button-4>", lambda e: self.context_text.xview_scroll(-3, "units"))
        self.context_text.bind("<Button-5>", lambda e: self.context_text.xview_scroll(3, "units"))

        self.mono_font = self._get_mono_font()
        for key in list(DEFAULT_FONTS.keys()):
            val = DEFAULT_FONTS[key]
            if isinstance(val, tuple) and len(val) > 0 and val[0] in ("DejaVu Sans Mono", "Courier"):
                DEFAULT_FONTS[key] = (self.mono_font,) + val[1:]

        self.context_text.tag_configure(
            "omograph",
            background=DEFAULT_COLORS["bg_om_highlight"],
            foreground=DEFAULT_COLORS["fg_om_highlight"],
            font=DEFAULT_FONTS["omograph"],
        )
        self.context_text.tag_configure("accent", foreground=DEFAULT_COLORS["fg_accent"])
        self.context_text.tag_configure("context_line", foreground=DEFAULT_COLORS["fg_context_line"])
        self.context_text.tag_configure("current_line", foreground=DEFAULT_COLORS["fg_context_current"])
        self.context_text.tag_configure("line_number", foreground=DEFAULT_COLORS["fg_context_line"])
        self.context_text.tag_configure("separator", foreground=DEFAULT_COLORS["fg_separator"])

        self.scripts_tree.bind("<Tab>", lambda e: self.occurrences_tree.focus_set() or "break")
        self.occurrences_tree.bind("<Tab>", lambda e: self.scripts_tree.focus_set() or "break")

        self.progress_var = tk.StringVar(value="Готов к работе")
        bottom_frame = ttk.Frame(self.root)
        bottom_frame.pack(fill=tk.X, padx=5, pady=5)
        ttk.Label(bottom_frame, textvariable=self.progress_var).pack(side=tk.LEFT)
        self.dir_label = tk.Label(
            bottom_frame,
            text="",
            font=DEFAULT_FONTS["ui"],
            fg=DEFAULT_COLORS["fg_dir_label"],
            bg=DEFAULT_COLORS["bg_main"],
        )
        self.dir_label.place(relx=0.45, rely=0.5, anchor="center")
        self.dirty_status_var = tk.StringVar(value="Изменений нет")
        self.dirty_status_label = ttk.Label(bottom_frame, textvariable=self.dirty_status_var)
        self.dirty_status_label.pack(side=tk.RIGHT)
        self.cache_label = ttk.Label(bottom_frame, text=f"Кэш: 0/{self._occ_cache_size}", width=14, anchor="center")
        self.cache_label.place(relx=0.75, rely=0.5, anchor="center")
        self.memory_label = ttk.Label(bottom_frame, text="Mem", width=10, anchor="center")
        self.memory_label.place(relx=0.83, rely=0.5, anchor="center")

    # ======================== ГОРЯЧИЕ КЛАВИШИ ========================

    def bind_hotkeys(self):
        self.root.bind("<F1>", lambda e: self._show_help())
        self.root.bind("<F2>", lambda e: self.scripts_tree.focus_set())
        self.root.bind("<F3>", lambda e: self.occurrences_tree.focus_set())
        self.root.bind("<F4>", lambda e: self._goto_current_script())
        self.root.bind("<F6>", lambda e: self.search_var.set(""))
        self.root.bind("<F7>", lambda e: self.search_entry.focus_set())
        self.root.bind("<F8>", lambda e: self._clear_cache())
        self.root.bind("<F9>", lambda e: self._fill_cache())
        self.root.bind("<f>", lambda e: self.search_entry.focus_set())
        self.root.bind("<Key-Cyrillic_a>", lambda e: self.search_entry.focus_set())
        self.root.bind("<h>", lambda e: self._toggle_show_all())
        self.root.bind("<Key-Cyrillic_er>", lambda e: self._toggle_show_all())
        self.root.bind("<g>", lambda e: self._toggle_show_all_scripts())
        self.root.bind("<Key-Cyrillic_pe>", lambda e: self._toggle_show_all_scripts())
        self.root.bind("<Control-r>", lambda e: self._refresh_all_counts())
        self.root.bind("<s>", lambda e: self._center_context_on_omograph())
        self.root.bind("<Key-Cyrillic_yeru>", lambda e: self._center_context_on_omograph())
        self.root.bind("<w>", lambda e: self._recenter_context())
        self.root.bind("<Key-Cyrillic_tse>", lambda e: self._recenter_context())
        self.root.bind("<a>", lambda e: self._scroll_context(-1))
        self.root.bind("<Key-Cyrillic_ef>", lambda e: self._scroll_context(-1))
        self.root.bind("<d>", lambda e: self._scroll_context(1))
        self.root.bind("<Key-Cyrillic_ve>", lambda e: self._scroll_context(1))
        self.root.bind("<q>", lambda e: self.context_text.xview_moveto(0.0))
        self.root.bind("<Key-Cyrillic_shorti>", lambda e: self.context_text.xview_moveto(0.0))
        self.root.bind("<e>", lambda e: self.context_text.xview_moveto(1.0))
        self.root.bind("<Key-Cyrillic_u>", lambda e: self.context_text.xview_moveto(1.0))
        self.root.bind("<i>", lambda e: self._refresh_all_counts())
        self.root.bind("<Key-Cyrillic_sha>", lambda e: self._refresh_all_counts())
        self.root.bind("<o>", lambda e: self._refresh_occurrences())
        self.root.bind("<Key-Cyrillic_shcha>", lambda e: self._refresh_occurrences())
        self.root.bind("<z>", lambda e: self._scroll_context_chars(-3))
        self.root.bind("<Key-Cyrillic_ya>", lambda e: self._scroll_context_chars(-3))
        self.root.bind("<x>", lambda e: self._scroll_context_chars(3))
        self.root.bind("<Key-Cyrillic_che>", lambda e: self._scroll_context_chars(3))
        self.root.bind("<u>", lambda e: self._undo_last())
        self.root.bind("<Key-Cyrillic_ghe>", lambda e: self._undo_last())
        self.root.bind("<U>", lambda e: self._undo_all())
        self.root.bind("<Key-Cyrillic_GHE>", lambda e: self._undo_all())
        self.root.bind("<Control-s>", lambda e: self._write_dirty_lines())
        self.root.bind("<Control-Key-Cyrillic_yeru>", lambda e: self._write_dirty_lines())
        self.root.bind("<Control-f>", lambda e: self.search_entry.focus_set())
        self.root.bind("<Control-Key-Cyrillic_a>", lambda e: self.search_entry.focus_set())
        for i in range(1, 9):
            # 1-9 — замена текущего (видимого)
            self.root.bind(str(i), lambda e, n=i: self._on_hotkey_variant(n, "selected"))
            self.root.bind(f"<KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "selected"))
            # Alt+1-9 — замена всех видимых
            self.root.bind(f"<Mod1-Key-{i}>", lambda e, n=i: self._on_hotkey_variant(n, "visible"))
            self.root.bind(f"<Mod1-KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "visible"))
            # Ctrl+1-9 — замена всех в файле
            self.root.bind(f"<Control-Key-{i}>", lambda e, n=i: self._on_hotkey_variant(n, "all"))
            self.root.bind(f"<Control-KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "all"))
        # 0 — очистить текущее (видимое)
        self.root.bind("0", lambda e: self._on_hotkey_clean("selected"))
        self.root.bind("<KP_0>", lambda e: self._on_hotkey_clean("selected"))
        # Alt+0 — очистить все видимые
        self.root.bind("<Mod1-Key-0>", lambda e: self._on_hotkey_clean("visible"))
        self.root.bind("<Mod1-KP_0>", lambda e: self._on_hotkey_clean("visible"))
        # Ctrl+0 — очистить все в файле
        self.root.bind("<Control-Key-0>", lambda e: self._on_hotkey_clean("all"))
        self.root.bind("<Control-KP_0>", lambda e: self._on_hotkey_clean("all"))
        self.root.bind("<Up>", lambda e: self._navigate_occurrence(-1))
        self.root.bind("<Down>", lambda e: self._navigate_occurrence(1))
        self.root.bind("<Left>", lambda e: self._navigate_script(-1))
        self.root.bind("<Right>", lambda e: self._navigate_script(1))
        self.root.bind("<space>", lambda e: self._apply_default_variant())
        self.root.bind("<Escape>", lambda e: self.skip_occurrence())
        self.root.bind("<n>", lambda e: self._sort_occurrences_by_line())
        self.root.bind("<Key-Cyrillic_te>", lambda e: self._sort_occurrences_by_line())
        self.root.bind("<comma>", lambda e: self._sort_occurrences_by_prefix())
        self.root.bind("<Key-Cyrillic_be>", lambda e: self._sort_occurrences_by_prefix())
        self.root.bind("<period>", lambda e: self._sort_occurrences_by_suffix())
        self.root.bind("<Key-Cyrillic_yu>", lambda e: self._sort_occurrences_by_suffix())
        self.root.bind("<Control-d>", lambda e: self.change_directory())
        self.root.bind("<Control-Key-Cyrillic_ve>", lambda e: self.change_directory())
        self.root.bind("<b>", lambda e: self.open_book())
        self.root.bind("<Key-Cyrillic_i>", lambda e: self.open_book())
        self.root.bind("<Control-t>", lambda e: self.change_target_file())
        self.root.bind("<Control-Key-Cyrillic_ie>", lambda e: self.change_target_file())

    def _on_hotkey_variant(self, variant_num, mode="selected"):
        if not self.current_word or self.current_word not in self.scripts_info:
            return
        info = self.scripts_info[self.current_word]
        if variant_num > len(info["variants"]):
            return
        variant_text = info["variants"][variant_num - 1]["accented"]
        self.selected_variant = variant_text
        if mode == "selected":
            if self.current_occurrence is not None:
                self.replace_selected_occurrence()
        elif mode == "visible":
            if self.replace_all_occurrences(silent=True):
                self.progress_var.set(f"✓ Alt+{variant_num}: заменены видимые '{self.current_word}'")
                items_before = self.scripts_tree.get_children()
                sel = self.scripts_tree.selection()
                idx_before = items_before.index(sel[0]) if sel else 0
                self.filter_scripts()
                items_after = self.scripts_tree.get_children()
                if items_after:
                    next_idx = min(idx_before, len(items_after) - 1)
                    self.scripts_tree.selection_set(items_after[next_idx])
                    self.scripts_tree.see(items_after[next_idx])
                    self.on_script_select(None)
        elif mode == "all":
            if self.replace_in_file(self.current_word, variant_text):
                self._scan_all_omographs()
                self.scripts_info[self.current_word]["unaccented_count"] = 0
                self._checked_words.add(self.current_word)
                self.progress_var.set(f"✓ Ctrl+{variant_num}: заменены ВСЕ в файле '{self.current_word}'")
                items_before = self.scripts_tree.get_children()
                sel = self.scripts_tree.selection()
                idx_before = items_before.index(sel[0]) if sel else 0
                self.filter_scripts()
                items_after = self.scripts_tree.get_children()
                if items_after:
                    next_idx = min(idx_before, len(items_after) - 1)
                    self.scripts_tree.selection_set(items_after[next_idx])
                    self.scripts_tree.see(items_after[next_idx])
                    self.on_script_select(None)

    def _on_hotkey_clean(self, mode="selected"):
        if not self.current_word:
            return
        if mode == "selected":
            if self.current_occurrence is not None:
                self.clean_selected_occurrence()
        elif mode == "visible":
            self.clean_all_occurrences()
            items_before = self.scripts_tree.get_children()
            sel = self.scripts_tree.selection()
            idx_before = items_before.index(sel[0]) if sel else 0
            self.filter_scripts()
            items_after = self.scripts_tree.get_children()
            if items_after:
                next_idx = min(idx_before, len(items_after) - 1)
                self.scripts_tree.selection_set(items_after[next_idx])
                self.scripts_tree.see(items_after[next_idx])
                self.on_script_select(None)
        elif mode == "all":
            word = self.current_word
            for li, tokens in enumerate(self.lines):
                for t in tokens:
                    if t["type"] == "word" and t["clean"] == word:
                        t["text"] = self._clean_accents(t["text"])
                        self._mark_dirty(li)
            self._scan_all_omographs()
            self.scripts_info[word]["unaccented_count"] = 0
            self._checked_words.add(word)
            self.progress_var.set(f"✓ Ctrl+0: очищены ВСЕ в файле '{word}'")
            items_before = self.scripts_tree.get_children()
            sel = self.scripts_tree.selection()
            idx_before = items_before.index(sel[0]) if sel else 0
            self.filter_scripts()
            items_after = self.scripts_tree.get_children()
            if items_after:
                next_idx = min(idx_before, len(items_after) - 1)
                self.scripts_tree.selection_set(items_after[next_idx])
                self.scripts_tree.see(items_after[next_idx])
                self.on_script_select(None)

    # ======================== НАВИГАЦИЯ ========================

    def _select_occurrence(self, idx):
        if idx < 0 or idx >= len(self.occurrences):
            return
        self.current_occurrence = idx
        line_num, li, ti = self.occurrences[idx]
        self.current_occurrence_data = (li, ti)

        for item in self.occurrences_tree.get_children():
            tags = self.occurrences_tree.item(item, "tags")
            if tags and tags[0] and int(tags[0]) == idx:
                if item not in self.occurrences_tree.selection():
                    self.occurrences_tree.selection_set(item)
                self.occurrences_tree.see(item)
                break

        if self.current_word:
            self.show_context_for_occurrence(line_num, self.current_word, ti)

    def _undo_last(self):
        self._script_items_dirty = True
        if not self._undo_stack:
            self.progress_var.set("Нечего отменять")
            return
        action, li, ti, old_text, old_clean = self._undo_stack.pop()
        t = self.lines[li][ti]
        t["text"] = old_text
        t["clean"] = old_clean
        if li in self._original_lines:
            current = detokenize_line(self.lines[li])
            if current == self._original_lines[li]:
                self._dirty_lines.discard(li)
            else:
                self._dirty_lines.add(li)
        else:
            self._dirty_lines.add(li)
        cnt = len(self._dirty_lines)
        self.occ_counter_var.set(str(cnt) if cnt > 0 else "")
        if cnt > 0:
            self.dirty_status_var.set(f"⚠ Изменено строк: {cnt}")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_dirty_label"])
        else:
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_status_clean"])
        self.progress_var.set(f"↩ Отменено: {old_text}")
        self._scan_all_omographs()
        self._update_cached_counts()
        for item in self.scripts_tree.get_children():
            if self.scripts_tree.item(item, "values")[0] == self.current_word:
                self.scripts_tree.set(item, "found", self.scripts_info[self.current_word].get("unaccented_count", 0))
                break
        self.update_status()
        if self.current_word:
            self.populate_occurrences(self.current_word)

    def _update_cached_counts(self):
        if self._script_items_cache is not None:
            self._script_items_cache = [
                (word, self.scripts_info[word].get("unaccented_count", 0))
                for word, _ in self._script_items_cache
            ]
        self._all_script_items = self._script_items_cache

    def _undo_all(self):
        if not self._undo_stack:
            self.progress_var.set("Нечего отменять")
            return
        cnt = len(self._undo_stack)
        if not messagebox.askyesno("Подтверждение", f"Отменить ВСЕ изменения\n({cnt} действий)?"):
            return
        while self._undo_stack:
            action, li, ti, old_text, old_clean = self._undo_stack.pop()
            t = self.lines[li][ti]
            t["text"] = old_text
            t["clean"] = old_clean
        self._dirty_lines.clear()
        self.dirty_status_var.set("Изменений нет")
        self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_text"])
        self.occ_counter_var.set("")
        self.progress_var.set("↩ Отменены все изменения")
        self._scan_all_omographs()
        self._update_cached_counts()
        self._script_items_dirty = True
        self.filter_scripts()
        if self.current_word:
            self.populate_occurrences(self.current_word)

    def _fill_cache(self):
        self.progress_var.set("Создание кэша списков вхождений ... ожидайте")
        self.root.update_idletasks()
        words = sorted(
            [w for w in self.scripts_info if self.scripts_info[w].get("unaccented_count", 0) > 0],
            key=lambda w: self.scripts_info[w].get("unaccented_count", 0),
            reverse=True,
        )
        limit = max(1, self._occ_cache_size - 10)
        auto_limit = DEFAULT_SETTINGS.get("auto_cache_size", 10)
        limit = min(limit, auto_limit) if auto_limit > 0 else limit
        for word in words[:limit]:
            self.populate_occurrences(word)
        self.progress_var.set(f"✓ Кэш заполнен ({len(self._occ_cache_dict)}/{self._occ_cache_size})")

    def _clear_cache(self):
        self._occ_cache_dict.clear()
        self._occ_cache_order.clear()
        self.cache_label.config(text=f"Кэш: 0/{self._occ_cache_size}")
        self.progress_var.set("✓ Кэш очищен")

    def _scroll_context(self, direction):
        current = self.context_text.xview()
        step = 0.1
        new_pos = max(0.0, min(1.0, current[0] + direction * step))
        self.context_text.xview_moveto(new_pos)

    def _scroll_context_chars(self, chars):
        """Плавный скролл на chars символов."""
        font_obj = tkfont.Font(family=DEFAULT_FONTS["context"][0], size=DEFAULT_FONTS["context"][1])
        char_width = font_obj.measure("X")
        total_width = font_obj.measure("X" * 1000)
        if total_width == 0:
            return
        current = self.context_text.xview()
        shift = (char_width * chars) / total_width
        new_pos = max(0.0, min(1.0, current[0] + shift))
        self.context_text.xview_moveto(new_pos)

    def _on_mousewheel(self, event):
        if event.state & 0x1:  # Shift
            self.context_text.xview_scroll(-event.delta // 30, "units")
        else:
            self.context_text.yview_scroll(-event.delta // 30, "units")

    def _on_mousewheel_horizontal(self, event):
        self.context_text.xview_scroll(-event.delta // 30, "units")

    def _center_context_on_omograph(self):
        if self.current_occurrence is None:
            return
        line_num, li, ti = self.occurrences[self.current_occurrence]
        line_text = detokenize_line(self.lines[li]).rstrip("\n\r")
        tokens = self.lines[li]
        pos = 0
        for t in tokens:
            if t["type"] == "word" and t["clean"] == self.current_word:
                om_start = pos
                break
            pos += len(t["text"])
        else:
            return
        total_len = len(line_text) + 150
        if total_len == 0:
            return
        fraction = om_start / total_len
        self.context_text.xview_moveto(max(0.0, min(1.0, fraction)))

    def _recenter_context(self):
        if self.current_occurrence is not None and self.current_word:
            line_num, li, ti = self.occurrences[self.current_occurrence]
            self._ctx_li = -1
            self._ctx_ti = -1
            self.show_context_for_occurrence(line_num, self.current_word, ti)

    def _sort_occurrences_by_line(self):
        self._occ_sort_col = None
        self._update_occ_headings()
        self._sort_occurrences_by_key(lambda x: x[0])

    def _sort_occurrences_by_prefix(self):
        self._occ_sort_col = "prefix"
        self._update_occ_headings()
        self._sort_occurrences_by_key(lambda x: self._words_reversed(x[3]))

    def _sort_occurrences_by_suffix(self):
        self._occ_sort_col = "suffix"
        self._update_occ_headings()
        self._sort_occurrences_by_key(lambda x: self._words(x[5]))

    def _words(self, text):
        words = WORD_RE.findall(text)
        return tuple(w.lower() for w in words) if words else ()

    def _words_reversed(self, text):
        words = WORD_RE.findall(text)
        return tuple(w.lower() for w in reversed(words)) if words else ()

    def _sort_occurrences_by_key(self, key_func):
        if not hasattr(self, "_occ_cache") or not self._occ_cache:
            return
        self._occ_cache.sort(key=key_func)
        self.occurrences = [(b[0], b[1], b[2]) for b in self._occ_cache]
        self.occurrences_tree.delete(*self.occurrences_tree.get_children())
        self._occ_batch = self._occ_cache
        self._occ_batch_idx = 0
        self.occurrences_tree.unbind("<<TreeviewSelect>>")
        self._insert_occ_batch()

    def _update_occ_headings(self):
        self.occurrences_tree.heading("prefix", text="⟵ контекст" if self._occ_sort_col != "prefix" else "⟵ 🍀 контекст 🍀")
        self.occurrences_tree.heading("suffix", text="контекст ⟶" if self._occ_sort_col != "suffix" else "🍀 контекст 🍀 ⟶")

    def _on_tree_focus_in(self, event):
        style = ttk.Style()
        if event.widget == self.scripts_tree:
            style.configure("Scripts.Treeview.Heading", foreground=DEFAULT_COLORS["fg_heading_focus"])
            style.configure("Occurrences.Treeview.Heading", foreground=DEFAULT_COLORS["fg_text"])
        else:
            style.configure("Occurrences.Treeview.Heading", foreground=DEFAULT_COLORS["fg_heading_focus"])
            style.configure("Scripts.Treeview.Heading", foreground=DEFAULT_COLORS["fg_text"])

    def _on_tree_focus_out(self, event):
        style = ttk.Style()
        style.configure("Scripts.Treeview.Heading", foreground=DEFAULT_COLORS["fg_text"])
        style.configure("Occurrences.Treeview.Heading", foreground=DEFAULT_COLORS["fg_text"])

    def _add_tooltip(self, widget, text):
        def enter(event):
            if not self.show_tips_var.get():
                return
            tip = tk.Toplevel(widget)
            tip.wm_overrideredirect(True)
            x = event.x_root + 10
            y = event.y_root + 10
            # Temporary label to measure width
            label = tk.Label(tip, text=text, font=DEFAULT_FONTS["ui"], padx=3, pady=1)
            width = label.winfo_reqwidth()
            label.destroy()
            screen_width = self.root.winfo_screenwidth()
            if x + width > screen_width:
                x = screen_width - width - 10
            tip.wm_geometry(f"+{x}+{y}")
            label = tk.Label(tip, text=text, background="#FFFFAA", relief="solid", borderwidth=1, font=DEFAULT_FONTS["ui"], padx=3, pady=1)
            label.pack()
            self._tooltips[widget] = tip
        def leave(event):
            tip = self._tooltips.pop(widget, None)
            if tip:
                tip.destroy()
        widget.bind("<Enter>", enter)
        widget.bind("<Leave>", leave)

    def _on_occ_tree_select(self, event):
        selection = self.occurrences_tree.selection()
        if selection:
            tags = self.occurrences_tree.item(selection[0], "tags")
            if tags and tags[0]:
                idx = int(tags[0])
                if 0 <= idx < len(self.occurrences):
                    self._select_occurrence(idx)

    def _navigate_occurrence(self, direction):
        if self.current_occurrence is None:
            if self.occurrences:
                self._select_occurrence(0)
            return
        new_idx = self.current_occurrence + direction
        if 0 <= new_idx < len(self.occurrences):
            self._select_occurrence(new_idx)

    def _navigate_script(self, direction):
        all_items = self.scripts_tree.get_children()
        if not all_items:
            return
        selection = self.scripts_tree.selection()
        if not selection:
            idx = 0
        else:
            idx = all_items.index(selection[0]) + direction
            if idx >= len(all_items):
                idx = 0
            elif idx < 0:
                idx = len(all_items) - 1
        next_item = all_items[idx]
        self.scripts_tree.selection_set(next_item)
        self.scripts_tree.see(next_item)
        self.on_script_select(None)

    def _auto_advance_after_action(self, completed_idx):
        if self.current_word and self.current_word in self.scripts_info:
            count = self.scripts_info[self.current_word].get("unaccented_count", 0)
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == self.current_word:
                    self.scripts_tree.set(item, "found", count)
                    break

        if not self.occurrences:
            if self.current_word:
                self._checked_words.add(self.current_word)
            # Запоминаем текущий индекс в полном списке
            prev_word = self.current_word
            prev_index = None
            if hasattr(self, "_all_script_items") and self._all_script_items:
                for i, (w, c) in enumerate(self._all_script_items):
                    if w == prev_word:
                        prev_index = i
                        break
            self.filter_scripts()
            items_after = self.scripts_tree.get_children()
            if items_after:
                # Ищем элемент с prev_word или следующий видимый
                target = None
                for item in items_after:
                    item_word = self.scripts_tree.item(item, "values")[0]
                    if item_word == prev_word:
                        target = item
                        break
                if target is None:
                    # Слово исчезло — берём следующий видимый после prev_index
                    if prev_index is not None and hasattr(self, "_all_script_items"):
                        for i in range(prev_index + 1, len(self._all_script_items)):
                            next_word = self._all_script_items[i][0]
                            for item in items_after:
                                if self.scripts_tree.item(item, "values")[0] == next_word:
                                    target = item
                                    break
                            if target:
                                break
                if target is None:
                    target = items_after[0]
                self.scripts_tree.selection_set(target)
                self.scripts_tree.see(target)
                self.on_script_select(None)
            return
        if self.occurrences:
            target_idx = completed_idx if completed_idx is not None else 0
            target_idx = min(target_idx, len(self.occurrences) - 1)
            self._select_occurrence(target_idx)

    def skip_occurrence(self):
        if self.current_occurrence is not None:
            self._auto_advance_after_action(self.current_occurrence)

    # ======================== ФИЛЬТРАЦИЯ ========================

    def filter_scripts(self, *args):
        search_term = self.search_var.get().lower()
        show_all = self.show_all_scripts_var.get()

        # Всегда перестраиваем полный список с актуальными счётчиками
        if not self._script_items_dirty and self._script_items_cache is not None:
            pass  # используем кэш
        else:
            self._rebuild_script_items()
            self._script_items_dirty = False

        self.scripts_tree.delete(*self.scripts_tree.get_children())
        visible_items = []
        for word, count in self._all_script_items:
            if search_term and search_term not in word.lower():
                continue
            if not show_all and count == 0 and word in self._checked_words:
                continue
            visible_items.append((word, count))

        self._insert_scripts_batch(visible_items, 0)

    def _insert_scripts_batch(self, items, start_idx):
        batch_size = 100
        end = min(start_idx + batch_size, len(items))
        for i in range(start_idx, end):
            word, count = items[i]
            self.scripts_tree.insert("", "end", values=(word, count))
        if end < len(items):
            self.root.after(10, lambda: self._insert_scripts_batch(items, end))
        else:
            self.scripts_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
            self.scripts_tree.master.winfo_children()[-1].pack(side=tk.RIGHT, fill=tk.Y)
            self.update_status()

    def _rebuild_script_items(self):
        if not self._script_items_dirty and self._script_items_cache is not None:
            self._all_script_items = self._script_items_cache
            return
        items = []
        for word, info in self.scripts_info.items():
            count = info.get("unaccented_count", 0)
            items.append((word, count))
        # Применяем текущую сортировку
        if hasattr(self, "_sort_col") and self._sort_col:
            if self._sort_col == "word":
                items.sort(
                    key=lambda x: x[0].lower(),
                    reverse=getattr(self, "_sort_reverse_word", False),
                )
            elif self._sort_col == "found":
                items.sort(
                    key=lambda x: int(x[1]),
                    reverse=getattr(self, "_sort_reverse_found", False),
                )
        else:
            items.sort(key=lambda x: x[0].lower())
        self._all_script_items = items
        self._script_items_cache = items
        self._script_items_dirty = False

    def _sort_scripts(self, col):
        # Первый клик — прямая, второй — обратная
        if getattr(self, "_sort_col", None) == col:
            # Повторный клик — переключаем
            if col == "word":
                self._sort_reverse_word = not getattr(self, "_sort_reverse_word", False)
            else:
                self._sort_reverse_found = not getattr(self, "_sort_reverse_found", False)
        else:
            # Первый клик — прямая сортировка
            self._sort_col = col
            if col == "word":
                self._sort_reverse_word = False
            else:
                self._sort_reverse_found = True
        self._script_items_dirty = True
        self._rebuild_script_items()
        self.filter_scripts()
        self.update_status()

    def update_status(self):
        total = len(self.scripts_info)
        shown = len(self.scripts_tree.get_children())
        total_occ = sum(info.get("unaccented_count", 0) for info in self.scripts_info.values())
        self.status_label.config(text=f"Омографов: {shown}/{total} | Вхождений: {total_occ}")

    def on_script_select(self, event):
        selection = self.scripts_tree.selection()
        if not selection:
            return
        word = self.scripts_tree.item(selection[0])["values"][0]
        self.current_word = word
        self.current_occurrence = None
        self.current_occurrence_data = None
        self.selected_variant = None
        self.update_variants_bar(word)
        self._update_memory_label()
        self.populate_occurrences(word)

    def _show_help(self):
        help_win = tk.Toplevel(self.root)
        help_win.title("Горячие клавиши")
        help_win.configure(bg=DEFAULT_COLORS["bg_main"])
        help_win.resizable(False, False)
        help_text = (
            "ЗАМЕНА ВХОЖДЕНИЙ:\n"
            "  1-3 — заменить выбранное    |  Alt+1-3 — все видимые    |  Ctrl+1-3 — все в файле\n"
            "  0 — очистить выбранное      |  Alt+0 — все видимые      |  Ctrl+0 — все в файле\n"
            "  Space — вариант по умолчанию |  Esc — пропустить вхождение\n"
            "\n"
            "НАВИГАЦИЯ:\n"
            "  ↑↓ — вхождения   |  ←→ — омографы  | f/F7 — поиск омографа\n"
            "  h — всё (вхожд.) |  g — всё (омографы)\n"
            "\n"
            "КОНТЕКСТ (окно внизу):\n"
            "  a/d — быстрый скролл   |  z/x — медленный скролл   |  q/e — начало/конец\n"
            "  w — центровка авто    |  s — центровка старая\n"
            "  NB: копирование выделенного мышью текста доступно\n"
            "       кликом правой кнопки мыши по выделенному тексту.\n"
            "       Скопировнный текст может быть не виден в системной истории буфера обмена!\n"
            "       Ctrl+C работает только при включенной опции allow_context_edit (см. конфиг)\n"
            "\n"
            "ПРОЧЕЕ:\n"
            "  u — отмена последнего изменения  |  Shift+U — отменить все изменения   |  Ctrl+S — сохранить\n"
            "  i — обновить список омографов  |  o — обновить список вхождений\n"
            "  F2/F3 — фокус омографы/вхождения  |  F4 — текущий омограф в списке\n"
            "  F6 — очистить поиск   |  Ctrl+F, f, F7 — окно поиска омографа   |  Ctrl+R — загрузить данные заново\n"
            "  F9 — заполнить автокэш (для быстроты)  |  F8 – очистить кэш\n"
            "  Ctrl+D — сменить директорию со скриптами  |  Ctrl+T — сменить целевой файл | b – открыть книгу в читалке\n"
            "\n"
            "  NB: все алфавитные клавиши повторены на кириллице"
        )
        lbl = tk.Label(
            help_win,
            text=help_text,
            font=DEFAULT_FONTS["ui"],
            bg=DEFAULT_COLORS["bg_main"],
            fg=DEFAULT_COLORS["fg_text"],
            justify="left",
            padx=15,
            pady=10,
        )
        lbl.pack()
        btn = ttk.Button(help_win, text="OK", command=help_win.destroy)
        btn.pack(pady=(0, 10))
        help_win.transient(self.root)
        help_win.grab_set()
        self.root.wait_window(help_win)

    def _apply_default_variant(self):
        if not self.current_word or self.current_word not in self.scripts_info:
            return
        info = self.scripts_info[self.current_word]
        if "default" in info:
            self.selected_variant = info["default"]
            self.replace_selected_occurrence()

    def _goto_current_script(self):
        if self.current_word:
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == self.current_word:
                    self.scripts_tree.selection_set(item)
                    self.scripts_tree.see(item)
                    break

    def _toggle_show_all(self):
        self.show_all_var.set(not self.show_all_var.get())
        self._on_show_all_toggle()

    def _toggle_show_all_scripts(self):
        self.show_all_scripts_var.set(not self.show_all_scripts_var.get())
        self.filter_scripts()

    def _on_show_all_toggle(self):
        if self.current_word:
            self.populate_occurrences(self.current_word)

    def _refresh_occurrences(self):
        if self.current_word:
            self._occ_cache_key = None
            self.populate_occurrences(self.current_word)

    def _refresh_all_counts(self):
        self.progress_var.set("Обновление...")
        self.root.update_idletasks()
        self._scan_all_omographs()
        for word, info in self.scripts_info.items():
            if info.get("unaccented_count", 0) == 0:
                self._checked_words.add(word)
        self.filter_scripts()
        self.progress_var.set("✓ Статус обновлён")

    # ======================== ИНФО И КНОПКИ ========================

    def _insert_with_accents_variant(self, text):
        i = 0
        while i < len(text):
            ch = text[i]
            if i + 1 < len(text) and unicodedata.combining(text[i + 1]):
                self.variants_text.insert(tk.END, ch + text[i + 1], "accent")
                i += 2
            else:
                self.variants_text.insert(tk.END, ch)
                i += 1

    def _update_occ_variants(self, info, word):
        self.occ_variants_text.config(state="normal")
        self.occ_variants_text.delete(1.0, tk.END)
        self.occ_variants_text.insert(tk.END, " ", "center")
        parts = []
        for i, v in enumerate(info["variants"], 1):
            parts.append((f"{i}: ", v["accented"]))
        parts.append(("0: ", word))
        for j, (label, text) in enumerate(parts):
            if j > 0:
                self.occ_variants_text.insert(tk.END, "          ")
            self.occ_variants_text.insert(tk.END, label)
            self._insert_with_accents_occ_variant(text)
        if "default" in info:
            self.occ_variants_text.insert(tk.END, "          По умолчанию: ")
            self._insert_with_accents_occ_variant(info["default"])
        self.occ_variants_text.insert(tk.END, " ", "center")
        self.occ_variants_text.tag_add("center", "1.0", "end")
        self.occ_variants_text.config(state="disabled")

    def _insert_with_accents_occ_variant(self, text):
        i = 0
        while i < len(text):
            ch = text[i]
            if i + 1 < len(text) and unicodedata.combining(text[i + 1]):
                self.occ_variants_text.insert(tk.END, ch + text[i + 1], "accent")
                i += 2
            else:
                self.occ_variants_text.insert(tk.END, ch)
                i += 1

    def update_variants_bar(self, word):
        if word not in self.scripts_info:
            return
        info = self.scripts_info[word]
        auto_pattern = info.get("auto_pattern", "")
        self.auto_pattern_var.set(auto_pattern if auto_pattern and auto_pattern != "нет" else "нет")
        if auto_pattern and auto_pattern != "нет":
            self.auto_pattern_label.configure(fg=DEFAULT_COLORS["fg_accent"])
        else:
            self.auto_pattern_label.configure(fg=DEFAULT_COLORS["fg_dirty_label"])

        # Обновляем полосу вариантов с зелёными ударениями
        self.variants_text.config(state="normal")
        self.variants_text.delete(1.0, tk.END)
        parts = []
        for i, v in enumerate(info["variants"], 1):
            parts.append((f"{i}: ", v["accented"]))
        parts.append(("0: ", word))
        # Вставляем варианты и default с выравниванием по центру
        self.variants_text.tag_configure("center", justify="center")
        self.variants_text.insert(tk.END, " ", "center")
        for j, (label, text) in enumerate(parts):
            if j > 0:
                self.variants_text.insert(tk.END, "          ")
            self.variants_text.insert(tk.END, label)
            self._insert_with_accents_variant(text)
        if "default" in info:
            self.variants_text.insert(tk.END, "          По умолчанию: ")
            self._insert_with_accents_variant(info["default"])
        self.variants_text.insert(tk.END, " ", "center")
        self.variants_text.tag_add("center", "1.0", "end")
        self.variants_text.config(state="disabled")
        # Дублируем в тулбар вхождений
        self._update_occ_variants(info, word)

    # ======================== ШРИФТЫ ========================

    def _get_mono_font(self):
        from tkinter import font

        return font.nametofont("TkFixedFont").actual()["family"]

    def _ensure_font_available(self):
        from tkinter import font

        if "DejaVu Sans Mono" not in set(font.families()):
            self.progress_var.set("⚠️ Установите шрифт DejaVu Sans Mono")
            self.mono_font = "Courier"

    # ======================== ПРОЧЕЕ ========================
    def _update_memory_label(self):
        import os

        import psutil
        try:
            process = psutil.Process(os.getpid())
            mem_mb = process.memory_info().rss / 1024 / 1024
            self.memory_label.config(text=f"{mem_mb:.1f} МБ")
        except ImportError:
            self.memory_label.config(text="psutil ✗")
        except Exception:
            self.memory_label.config(text="—")
 
    def update_dir_label(self):
        if hasattr(self, "dir_label"):
            name = self.script_dir.name if self.script_dir != Path.cwd() else "текущая"
            fname = self.book_file.name if self.book_file else ""
            backups = self._find_backups()
            backup_text = f" | {backups}" if backups else ""
            self.dir_label.config(text=f"📂 {name} | 📄 {fname}{backup_text}", fg=DEFAULT_COLORS["fg_dir_label"])

    def _find_backups(self):
        if not self.book_file or not self.book_file.exists():
            return ""
        base_suffixes = ["man", "nam", "yoy", "dix", "06"]
        compressions = ["", ".gz", ".zip", ".7z", ".zst"]
        found = []
        for base in base_suffixes:
            for comp in compressions:
                suf = f"{base}{comp}"
                backup = self.book_file.parent / f"{self.book_file.name}.{suf}"
                if backup.exists():
                    found.append(suf)
        return " | ".join(found)

    def refresh_all(self):
        self._clear_cache()
        self._undo_stack.clear()
        self._dirty_lines.clear()
        self.occ_counter_var.set("")
        self.dirty_status_var.set("Изменений нет")
        self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_text"])
        self.load_scripts()
        self._tokenize_book()
        self._build_word_index()
        self._scan_all_omographs()
        self.filter_scripts()

    def open_book(self):
        try:
            subprocess.Popen(["xdg-open", str(self.book_file)])
        except:
            pass

    def change_directory(self):
        if messagebox.askyesno("Подтверждение", "Сменить рабочую директорию?"):
            self._clear_cache()
            self._undo_stack.clear()
            self._dirty_lines.clear()
            self.occ_counter_var.set("")
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=DEFAULT_COLORS["fg_text"])
            self.progress_var.set("Смена директории...")
            self.root.update_idletasks()
            self.select_working_directory()
            self.refresh_all()

    def change_target_file(self):
        if messagebox.askyesno("Подтверждение", "Сменить целевой файл правок?"):
            file_path = filedialog.askopenfilename(
                title="Выберите целевой файл",
                initialdir=self.script_dir,
                filetypes=[("Text files", "*.txt *.fb2"), ("All files", "*.*")],
            )
            if file_path:
                self.book_file = Path(file_path)
                self._tokenize_book()
                self._scan_all_omographs()
                self.filter_scripts()
                self.update_dir_label()
                self.progress_var.set(f"✓ Целевой файл: {self.book_file.name}")


def main():
    root = tk.Tk()
    root.configure(bg=DEFAULT_COLORS["bg_main"])
    style = ttk.Style()
    style.theme_use("clam")

    # Базовые настройки
    style.configure(
        ".",
        background=DEFAULT_COLORS["bg_main"],
        foreground=DEFAULT_COLORS["fg_text"],
        fieldbackground=DEFAULT_COLORS["bg_text"],
    )
    style.configure("TFrame", background=DEFAULT_COLORS["bg_main"])
    style.configure("TLabelframe", background=DEFAULT_COLORS["bg_main"])

    # Метки
    style.configure("TLabel", background=DEFAULT_COLORS["bg_main"], foreground=DEFAULT_COLORS["fg_text"])
    style.configure("TLabelframe.Label", background=DEFAULT_COLORS["bg_main"], foreground=DEFAULT_COLORS["fg_text"])

    # Кнопки
    style.configure("TButton", background=DEFAULT_COLORS["bg_button"], foreground=DEFAULT_COLORS["fg_text"])
    style.map("TButton", background=[("active", DEFAULT_COLORS["bg_button_active"])])

    # Чекбоксы
    style.configure("TCheckbutton", background=DEFAULT_COLORS["bg_main"], foreground=DEFAULT_COLORS["fg_text"])
    style.map("TCheckbutton", background=[("active", DEFAULT_COLORS["bg_main"])], foreground=[("active", DEFAULT_COLORS["fg_text"])])

    # Таблицы
    style.configure(
        "Treeview",
        background=DEFAULT_COLORS["bg_text"],
        foreground=DEFAULT_COLORS["fg_text"],
        fieldbackground=DEFAULT_COLORS["bg_text"],
    )
    style.configure(
        "Treeview.Heading",
        background=DEFAULT_COLORS["bg_main"],
        foreground=DEFAULT_COLORS["fg_text"],
    )
    style.map(
        "Treeview",
        background=[("selected", DEFAULT_COLORS["bg_sel_line"])],
        foreground=[("selected", DEFAULT_COLORS["fg_text"])],
    )

    # Скроллбары
    style.configure(
        "TScrollbar",
        background=DEFAULT_COLORS["scrollbar_bg"],
        troughcolor=DEFAULT_COLORS["bg_main"],
        arrowcolor=DEFAULT_COLORS["fg_text"],
    )
    style.map("TScrollbar", background=[("active", DEFAULT_COLORS["scrollbar_active"])])

    app = OmographManager(root)

    # Восстановление прогресса
    progress_file = app.script_dir / "progress.json"
    if progress_file.exists():
        try:
            with open(progress_file, "r", encoding="utf-8") as f:
                progress = json.load(f)
            if progress.get("current_word"):
                for item in app.scripts_tree.get_children():
                    if app.scripts_tree.item(item)["values"][0] == progress["current_word"]:
                        app.scripts_tree.selection_set(item)
                        app.scripts_tree.see(item)
                        app.on_script_select(None)
                        break
        except Exception as e:
            print(f"Ошибка загрузки прогресса: {e}")

    root.mainloop()


if __name__ == "__main__":
    main()
