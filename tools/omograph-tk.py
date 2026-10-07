#!/usr/bin/env python3
"""
GUI-надстройка для управления скриптами замены омографов
Запуск: python3 omograph-tk.py
"""

import json
import os
import re
import subprocess
import time
import tkinter as tk
import tkinter.font as tkfont
import unicodedata
from pathlib import Path

import sys
sys.path.insert(0, str(Path(__file__).parent))

from scriptdb.otk.tokenizer import tokenize_line, detokenize_line, WORD_RE
from scriptdb.otk.utils import is_unaccented, clean_accents, clean_multiple_accents, insert_context_with_accents
from scriptdb.otk.scanner import build_word_index, scan_all_omographs
from scriptdb.otk import config as cfg
from scriptdb.otk.omo_db import load_omo_db
from scriptdb.otk.scripts_parser import load_scripts as parse_scripts
from scriptdb.otk.cache import OccurrenceCache
from scriptdb.otk.cache import update_cache_entry
from scriptdb.otk.cache import build_fill_queue
from scriptdb.otk.undo import UndoManager
from scriptdb.otk.undo import apply_undo_action, update_dirty_lines
from scriptdb.otk.context import compute_padding
from scriptdb.otk.morphology import MorphologyAnalyzer

try:
    import psutil
except ImportError:
    psutil = None
from tkinter import filedialog, messagebox, ttk

from scriptdb.otk.config import CONFIG_FILE, STATE_FILE, load_config

# Загружаем конфиг при импорте
load_config()


class OmographManager:
    def __init__(self, root):
        self.root = root
        self.root.title("Менеджер омографов")
        self.root.geometry("1200x800")
        self.root.attributes("-zoomed", True)
        self._undo_manager = UndoManager()
        self._operation_start_time = None
        self._insert_after_id = None
        self._current_batch_token = None

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
        self._occ_cache_manager = OccurrenceCache(max_size=cfg.DEFAULT_SETTINGS.get("cache_size", 20))
        self.OCCURRENCES_BATCH_SIZE = 50
        self.SCRIPTS_BATCH_SIZE = 100        
        self._occ_cache_size = cfg.DEFAULT_SETTINGS.get("cache_size", 20)
        self._occ_sort_col = None
        self._occ_geom_after_id = None
        self._occ_px_cache = {}
        self._px_warm_queue = None
        self._tooltips = {}
        self._occ_font_obj = tk.font.Font(family=cfg.DEFAULT_FONTS["occurrences"][0], size=cfg.DEFAULT_FONTS["occurrences"][1])
        self._om_font_obj = tk.font.Font(family=cfg.DEFAULT_FONTS["omograph"][0], size=cfg.DEFAULT_FONTS["omograph"][1])
        self._context_font_obj = tk.font.Font(family=cfg.DEFAULT_FONTS["context"][0], size=cfg.DEFAULT_FONTS["context"][1])
        self._script_items_cache = None
        self._script_items_dirty = True
        self._morphology = None  # инициализируется после выбора директории
        self.create_widgets()
        self.bind_hotkeys()
        self.root.protocol("WM_DELETE_WINDOW", self._on_close)
        self.root.after(100, self.initialize_working_directory)
        self._omo_db = {}

    # ======================== ИНИЦИАЛИЗАЦИЯ ========================

    def initialize_working_directory(self):
        self._start_operation()
        self._ensure_font_available()
        self.progress_var.set("Анализ данных ... ждите")
        self.root.update_idletasks()
        self.script_dir = self.get_working_directory()
        self.book_file = self.script_dir / "text-book.txt"
        if not self.book_file.exists():
            self.select_working_directory()
            return
        self._load_omo_db()
        self.load_scripts()
        self._load_morphology()
        self._tokenize_book()
        self._scan_all_omographs()
        self._add_omo_from_text()
        self._scan_all_omographs()
        for word, info in self.scripts_info.items():
            if info.get("unaccented_count", 0) == 0:
                self._checked_words.add(word)
        self._script_items_dirty = True
        self.filter_scripts()
        self.update_dir_label()
        self._update_progress_with_time("✓ Готов к работе")
        # Фоновый прогрев кэша ширин графем (font measure ~10 мс/вызов)
        self.root.after(300, self._warm_px_cache)

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
        self._start_operation()
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
        self._load_omo_db()
        self.load_scripts()
        self._load_morphology()
        self._tokenize_book()
        self._add_omo_from_text()
        self._scan_all_omographs()
        for word, info in self.scripts_info.items():
            if info.get("unaccented_count", 0) == 0:
                self._checked_words.add(word)
        self.filter_scripts()
        self.update_dir_label()
        elapsed = self._end_operation()
        messagebox.showinfo("Успех", f"Директория: {selected_dir}\nВремя: {elapsed}")
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

    def _load_omo_db(self):
        """Загружает базу омографов из mano-lc и mano-uc, дополняет варианты из uniomo."""
        app_dir = Path(__file__).parent
        self._omo_db = load_omo_db(app_dir, self.progress_var, self.root)

    def _load_morphology(self):
        """Загружает морфологические словари из директории mano-*.stat"""
        stat_dir = None
        # Ищем директорию mano-*.stat рядом с рабочей директорией
        for d in self.script_dir.parent.glob("mano-*.stat"):
            if d.is_dir():
                stat_dir = d
                break
        
        if stat_dir and stat_dir.exists():
            self._morphology = MorphologyAnalyzer(stat_dir)
            self._morphology.load()
            self.progress_var.set(f"✓ Морфология загружена из {stat_dir.name}")
        else:
            self._morphology = None
            self.progress_var.set("⚠ Морфология не найдена")

    def load_scripts(self):
        if not self.script_dir.exists():
            self.select_working_directory()
            return
        self.scripts_info, target_file = parse_scripts(self.script_dir)
        if target_file and target_file.exists():
            self.book_file = target_file

    def _add_omo_from_text(self):
        """Добавляет в scripts_info омографы из базы, которые найдены в книге, но не имеют скриптов."""
        if not hasattr(self, "_omo_db"):
            return
        added = 0
        for word, db_info in self._omo_db.items():
            if word in self.scripts_info:
                continue
            if word in getattr(self, "_word_index", {}):
                self.scripts_info[word] = {
                    "file": None,
                    "word": word,
                    "variants": db_info.get("variants", []),
                    "unaccented_count": 0,
                    "auto_pattern": db_info.get("auto_pattern", ""),
                    "total_count": 0,
                    "marked_count": 0,
                }
                if db_info.get("variants"):
                    self.scripts_info[word]["default"] = db_info["variants"][0]["accented"]
                added += 1

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
            self._word_index = build_word_index(self.lines)
            self._tokenized = True
            max_line = len(self.lines)
            self._max_line_width = int(self._occ_font_obj.measure(str(max_line))) + 8
        except FileNotFoundError:
            self.lines = []
            self._tokenized = False

    def _mark_dirty(self, li):
        self._script_items_dirty = True
        self._dirty_lines.add(li)
        cnt = len(self._dirty_lines)
        self.occ_counter_var.set(str(cnt) if cnt > 0 else "")
        if cnt > 0:
            self.dirty_status_var.set(f"⚠ Изменено строк: {cnt}")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_dirty_label"])
        else:
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_text"])
        self.progress_var.set(f"Изменено строк: {cnt} (💾 сохранить)")

    def _write_dirty_lines(self):
        if not self._tokenized or not self._dirty_lines:
            return
        self._start_operation()
        try:
            with open(self.book_file, "r", encoding="utf-8") as f:
                raw_lines = f.readlines()
            for li in self._dirty_lines:
                if li < len(raw_lines):
                    new_line = detokenize_line(self.lines[li])
                    # Сохраняем исходный символ новой строки
                    original_line = raw_lines[li]
                    # detokenize_line может уже содержать \n — не дублируем
                    if new_line.endswith("\r\n"):
                        pass  # уже есть
                    elif new_line.endswith("\n"):
                        pass  # уже есть
                    elif original_line.endswith("\r\n"):
                        new_line += "\r\n"
                    elif original_line.endswith("\n"):
                        new_line += "\n"
                    raw_lines[li] = new_line
            with open(self.book_file, "w", encoding="utf-8") as f:
                f.writelines(raw_lines)
            self._dirty_lines.clear()
            self.occ_counter_var.set("")
            self.dirty_status_var.set("✓ Сохранено")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_status_saved"])
            self._scan_all_omographs()
            self._script_items_dirty = True
            self.filter_scripts()
            self._update_progress_with_time("✓ Сохранено")
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
        if self._tokenized:
            scan_all_omographs(self.lines, self.scripts_info)

    # ======================== ВСПОМОГАТЕЛЬНЫЕ ========================

    def _is_unaccented(self, text):
        return is_unaccented(text)

    def _start_operation(self):
        """Запускает таймер операции"""
        self._operation_start_time = time.time()

    def _end_operation(self, message=""):
        """Завершает операцию и добавляет время выполнения к сообщению"""
        if self._operation_start_time is not None:
            elapsed = time.time() - self._operation_start_time
            elapsed_str = f"{elapsed:.3f}s"
            self._operation_start_time = None
            if message:
                return f"{message} ({elapsed_str})"
            return elapsed_str
        return message

    def _update_progress_with_time(self, message):
        """Обновляет progress_var с временем выполнения"""
        elapsed = self._end_operation(message)
        self.progress_var.set(elapsed)
        return elapsed

    def _clean_accents(self, text):
        return clean_accents(text)

    def _clean_multiple_accents(self, text):
        return clean_multiple_accents(text)

    # ======================== ЗАМЕНА ========================

    def _replace_token(self, li, ti, new_text):
        t = self.lines[li][ti]
        old_text = t["text"]
        old_clean = t["clean"]
        # Сохраняем регистр исходного токена
        new_text = self._apply_case(new_text, old_text)
        t["text"] = self._clean_multiple_accents(new_text)
        t["clean"] = self._clean_accents(new_text)
        self._undo_manager.add_action("replace", li, ti, old_text, old_clean)

    def _apply_case(self, new_text, original_text):
        """Применяет регистр оригинального токена к новому тексту"""
        if not new_text:
            return new_text
        
        # Убираем ударения для сравнения
        clean_new = self._clean_accents(new_text)
        clean_orig = self._clean_accents(original_text)
        
        if not clean_orig:
            return new_text
        
        # Если оригинал полностью в верхнем регистре
        if clean_orig.isupper():
            return new_text.upper()
        # Если оригинал начинается с заглавной
        elif clean_orig[0].isupper():
            # Меняем только первый непробельный символ на заглавный
            # но сохраняем комбинируемые символы
            i = 0
            result = []
            first_letter_changed = False
            for ch in new_text:
                if not first_letter_changed and not unicodedata.combining(ch) and ch.isalpha():
                    result.append(ch.upper())
                    first_letter_changed = True
                else:
                    result.append(ch)
            return "".join(result)
        # Иначе — нижний регистр
        else:
            i = 0
            result = []
            first_letter_changed = False
            for ch in new_text:
                if not first_letter_changed and not unicodedata.combining(ch) and ch.isalpha():
                    result.append(ch.lower())
                    first_letter_changed = True
                else:
                    result.append(ch)
            return "".join(result)

    def _clean_token(self, li, ti):
        t = self.lines[li][ti]
        old_text = t["text"]
        old_clean = t["clean"]
        t["text"] = self._clean_accents(t["text"])
        self._undo_manager.add_action("clean", li, ti, old_text, old_clean)

    def _update_occ_cache_entry(self, word, li, ti):
        line_w, prefix_w, om_w, suffix_w = self._occ_geometry(word)
        update_cache_entry(
            self._occ_cache_manager,
            word,
            li,
            ti,
            self.lines,
            detokenize_line,
            self._is_unaccented,
            cfg.DEFAULT_SETTINGS.get("context_length", 40),
            fit_prefix=self._make_prefix,
            fit_suffix=self._make_suffix,
            max_prefix_px=max(8, prefix_w - 8),
            max_suffix_px=max(8, suffix_w - 8),
        )

    def _redraw_occurrences_after_change(self, old_idx):
        word = self.current_word
        if not word:
            return
        self.populate_occurrences(word)
        if old_idx is not None and self.occurrences:
            new_idx = min(old_idx, len(self.occurrences) - 1)
            self._select_occurrence(new_idx)

    def replace_in_file(self, word, replacement):
        self._undo_manager.start_group()
        count = 0
        for li, tokens in enumerate(self.lines):
            for t in tokens:
                if t["type"] == "word" and t["clean"] == word:
                    if t["text"] != replacement:
                        ti = tokens.index(t)
                        self._replace_token(li, ti, replacement)
                        count += 1
        self._undo_manager.end_group()
        if count > 0:
            self._scan_all_omographs()
        return count > 0

    def replace_selected_occurrence(self):
        if self.current_occurrence_data is None or not self.selected_variant:
            return
        self._start_operation()
        li, ti = self.current_occurrence_data
        word = self.current_word
        old_idx = self.current_occurrence
        self._replace_token(li, ti, self.selected_variant)
        self._update_occ_cache_entry(word, li, ti)
        self._mark_dirty(li)
        if word in self.scripts_info:
            self.scripts_info[word]["unaccented_count"] = max(0, self.scripts_info[word].get("unaccented_count", 0) - 1)
            self.scripts_info[word]["marked_count"] = self.scripts_info[word].get("marked_count", 0) + 1
            # Обновляем счетчик в таблице омографов
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == word:
                    self.scripts_tree.set(item, "found", self.scripts_info[word]["unaccented_count"])
                    break
            # Обновляем общий счетчик
            self.update_status()
        self._checked_words.add(word)
        self._update_progress_with_time("✓ Заменено вхождение")
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
                    # Берем актуальное значение из памяти
                    actual_text = self.lines[li][ti]["text"]
                    self.occurrences_tree.set(item, "omograph", actual_text)
                    self.occurrences_tree.item(item, tags=(tags[0], "row_accented"))
                    self.occurrences_tree.selection_set(item)
                    self.occurrences_tree.see(item)
                    break
            if self.current_word:
                line_num, li, ti = self.occurrences[old_idx]
                self._ctx_li = -1
                self._ctx_ti = -1
                self.show_context_for_occurrence(line_num, self.current_word, ti)
        self.update_variants_bar(self.current_word)

    def clean_selected_occurrence(self):
        if self.current_occurrence_data is None:
            return
        self._start_operation()
        li, ti = self.current_occurrence_data
        word = self.current_word
        old_idx = self.current_occurrence
        self._clean_token(li, ti)
        self._update_occ_cache_entry(word, li, ti)
        self._mark_dirty(li)
        if word in self.scripts_info:
            self.scripts_info[word]["unaccented_count"] = self.scripts_info[word].get("unaccented_count", 0) + 1
            self.scripts_info[word]["marked_count"] = max(0, self.scripts_info[word].get("marked_count", 0) - 1)
            # Обновляем счетчик в таблице омографов
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == word:
                    self.scripts_tree.set(item, "found", self.scripts_info[word]["unaccented_count"])
                    break
            # Обновляем общий счетчик
            self.update_status()
        self._checked_words.add(word)
        self._update_progress_with_time("✓ Очищено вхождение")
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
        self.update_variants_bar(self.current_word)

    def clean_all_occurrences(self):
        if not self.current_word:
            return
        self._start_operation()
        word = self.current_word
        # Начинаем групповую операцию
        self._undo_manager.start_group()
        cleaned_count = 0
        for li, tokens in enumerate(self.lines):
            for t in tokens:
                if t["type"] == "word" and t["clean"] == word:
                    if not self._is_unaccented(t["text"]):
                        t["text"] = self._clean_accents(t["text"])
                        self._mark_dirty(li)
                        cleaned_count += 1
        # Завершаем групповую операцию
        self._undo_manager.end_group()
        self._scan_all_omographs()
        self.scripts_info[word]["unaccented_count"] = self.scripts_info[word].get("total_count", 0)
        self.scripts_info[word]["marked_count"] = 0
        # Обновляем счетчик в таблице омографов
        for item in self.scripts_tree.get_children():
            if self.scripts_tree.item(item, "values")[0] == word:
                self.scripts_tree.set(item, "found", self.scripts_info[word]["unaccented_count"])
                break
        self._checked_words.add(word)
        self._update_progress_with_time(f"✓ Очищены все вхождения '{word}'")

    def replace_all_occurrences(self, silent=False):
        if not self.current_word or not self.selected_variant:
            if not silent:
                messagebox.showinfo("Информация", "Выберите вариант замены")
            return False
        self._start_operation()
        word = self.current_word
        replacement = self.selected_variant
        if not silent:
            count = len(self.occurrences)
            if not messagebox.askyesno(
                "Подтверждение",
                f"Заменить ВСЕ видимые вхождения '{word}' → '{replacement}'?\nВсего: {count}",
            ):
                return False
        # Начинаем групповую операцию
        self._undo_manager.start_group()
        count = 0
        for line_num, li, ti in self.occurrences:
            self._replace_token(li, ti, replacement)
            self._mark_dirty(li)
            count += 1
        # Завершаем групповую операцию
        self._undo_manager.end_group()
        if count > 0:
            self._scan_all_omographs()
            self.scripts_info[word]["unaccented_count"] = 0
            self._checked_words.add(word)
            if not silent:
                self._navigate_script(1)
                self._update_progress_with_time(f"✓ Заменены все видимые '{word}'")
            else:
                self._update_progress_with_time(f"✓ Заменены все видимые '{word}'")
            return True
        return False

    # ======================== ЗАПОЛНЕНИЕ ВХОЖДЕНИЙ ========================

    # ---- Ширины текста -------------------------------------------------
    # В этой сборке Tk вызов font measure стоит ~10 мс, поэтому метрики
    # берутся один раз на графему и кэшируются: дальше всё считается
    # в Python и стоит микросекунды.

    _PX_WARM_BASE = (
        " абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
        "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "0123456789"
        ".,;:!?—–-()[]{}\"'«»…/*@#%+=<>|\\~`◊"
    )
    _PX_WARM_ACCENTS = "аеёиоуыэюяАЕЁИОУЫЭЮЯ"

    def _grapheme_px(self, g):
        """Ширина графемы; font measure вызывается один раз на графему."""
        cache = self._occ_px_cache
        w = cache.get(g)
        if w is None:
            w = self._occ_font_obj.measure(g)
            cache[g] = w
        return w

    def _text_px(self, s):
        """Верхняя оценка ширины строки (сумма ширин графем, без Tcl)."""
        if not s:
            return 0
        total = 0
        i = 0
        n = len(s)
        while i < n:
            j = i + 1
            while j < n and unicodedata.combining(s[j]):
                j += 1
            total += self._grapheme_px(s[i:j])
            i = j
        return total

    def _warm_px_cache(self, chunk=4):
        """Прогрев кэша ширин в фоне (по chunk графем за тик)."""
        queue = self._px_warm_queue
        if queue is None:
            items = list(self._PX_WARM_BASE)
            for ch in self._PX_WARM_ACCENTS:
                items.append(ch + "\u0301")
            queue = []
            seen = set()
            for g in items:
                if g in seen or g in self._occ_px_cache:
                    continue
                seen.add(g)
                queue.append(g)
            self._px_warm_queue = queue
        for _ in range(chunk):
            if not queue:
                self._px_warm_queue = None
                return
            g = queue.pop(0)
            if g not in self._occ_px_cache:
                self._occ_px_cache[g] = self._occ_font_obj.measure(g)
        self.root.after(1, self._warm_px_cache)

    # ---- Геометрия колонок списка вхождений ----------------------------

    def _occ_geometry(self, word):
        """Ширины колонок окна вхождений под текущий размер виджета.

        Возвращает (line_w, prefix_w, om_w, suffix_w). Считается ДО построения
        строк: префикс обрезается ровно по фактической ширине колонки.
        """
        self.occurrences_tree.update_idletasks()
        line_w = int(getattr(self, "_max_line_width", 80))
        om_w = int(self._text_px(word)) + 8
        total_width = self.occurrences_tree.winfo_width()
        scrollbar_width = 0
        for child in self.occurrences_tree.master.winfo_children():
            if isinstance(child, ttk.Scrollbar):
                scrollbar_width = child.winfo_width()
                break
        if scrollbar_width == 0:
            scrollbar_width = 20
        total_width = max(0, total_width - scrollbar_width + 10)
        available = max(0, total_width - line_w)
        rest = max(0, available - om_w)
        if rest < 120:
            # виджет ещё не разложен (или панель скрыта) — берём ширины
            # по context_length, чтобы контекст не пропадал
            approx = max(60, int(self._text_px("о"))
                         * int(max(10, cfg.DEFAULT_SETTINGS.get("context_length", 40))))
            return line_w, approx, om_w, approx
        # Доля ширины, отдаваемая левому контексту (остальное — суффиксу).
        share = cfg.DEFAULT_SETTINGS.get("prefix_share", 0.5)
        try:
            share = min(0.9, max(0.2, float(share)))
        except (TypeError, ValueError):
            share = 0.5
        prefix_w = int(rest * share)
        suffix_w = rest - prefix_w
        if prefix_w < 20:
            prefix_w = rest
            suffix_w = 0
        return line_w, prefix_w, om_w, suffix_w

    def _apply_occ_geometry(self, line_w, prefix_w, om_w, suffix_w):
        """Фиксирует ширины колонок окна вхождений."""
        # защита от повторного <Configure>, вызванного сменой ширин
        self._occ_geom_applying = True
        try:
            self.occurrences_tree.column("line", width=line_w, stretch=False)
            self.occurrences_tree.column("prefix", width=prefix_w, anchor="e", stretch=False)
            self.occurrences_tree.column("omograph", width=om_w, anchor="center", stretch=False)
            self.occurrences_tree.column("suffix", width=suffix_w, anchor="w", stretch=False)
        finally:
            self._occ_geom_applying = False

    def _tail_fit(self, s, max_px):
        """Самый длинный ХВОСТ строки, влезающий в max_px."""
        if not s or max_px <= 0:
            return ""
        total = 0
        i = len(s) - 1
        start = len(s)
        while i >= 0:
            j = i
            while j > 0 and unicodedata.combining(s[j]):
                j -= 1
            w = self._grapheme_px(s[j:i + 1])
            if total + w > max_px:
                break
            total += w
            start = j
            i = j - 1
        return s[start:]

    def _make_prefix(self, full_prefix, max_px, max_chars=None):
        """Правый остаток контекста, целиком влезающий в колонку.

        ttk.Treeview при переполнении ячейки рисует текст от ЛЕВОГО края и
        обрезает хвост (anchor='e' действует, только пока текст влезает),
        поэтому в ячейку обязан попадать именно правый конец префикса.
        По числу символов не режем (max_chars оставлен для совместимости
        вызовов): длину ограничивает только ширина колонки.
        """
        s = full_prefix
        tail = self._tail_fit(s, max_px)
        if len(tail) == len(s):
            return tail
        marker_px = self._grapheme_px("◊")
        room = max_px - marker_px
        if room <= 0:
            return "◊" if marker_px <= max_px else ""
        return "◊" + self._tail_fit(s, room)

    def _make_suffix(self, full_suffix, max_px=None):
        """Суффикс не подрезаем: колонка последняя.

        При переполнении ячейки ttk.Treeview рисует текст от ЛЕВОГО края и
        режет хвост уже по границе окна, поэтому правый контекст и без
        обрезки «заходит под границу»: ни ◊, ни резка по пикселям не нужны.
        """
        return full_suffix

    def _refit_cached_batch(self, word, prefix_w, suffix_w):
        """Пересобирает префиксы и суффиксы кэшированного списка под новую ширину."""
        cached = self._occ_cache_manager.get((word, True))
        if not cached:
            return None
        batch, om_w = cached[0], cached[1]
        max_prefix_px = max(8, prefix_w - 8)
        max_suffix_px = max(8, suffix_w - 8)
        max_chars = cfg.DEFAULT_SETTINGS.get("context_length", 40) or None
        new_batch = []
        for line_num, li, ti, _prefix, _om, _suffix, is_accented in batch:
            if not (0 <= li < len(self.lines)):
                continue
            tokens = self.lines[li]
            if not (0 <= ti < len(tokens)):
                continue
            line_str = detokenize_line(tokens).rstrip("\n\r")
            pos = 0
            for tj in range(ti):
                pos += len(tokens[tj]["text"])
            om_text = tokens[ti]["text"]
            om_end = pos + len(om_text)
            prefix = self._make_prefix(line_str[:pos], max_prefix_px, max_chars)
            suffix = self._make_suffix(line_str[om_end:], max_suffix_px)
            new_batch.append((line_num, li, ti, prefix, om_text, suffix, is_accented))
        self._occ_cache_manager.put((word, True), (new_batch, om_w, prefix_w, True))
        return (new_batch, om_w, prefix_w, True)

    def _reflow_occurrences(self):
        """Пересчёт ширин колонок после изменения размера окна вхождений."""
        self._occ_geom_after_id = None
        if not self.current_word:
            return
        line_w, prefix_w, om_w, suffix_w = self._occ_geometry(self.current_word)
        self._apply_occ_geometry(line_w, prefix_w, om_w, suffix_w)
        cached = self._occ_cache_manager.get((self.current_word, True))
        if not cached:
            return
        if len(cached) > 2 and cached[2] == prefix_w:
            return
        refit = self._refit_cached_batch(self.current_word, prefix_w, suffix_w)
        if not refit:
            return
        batch = refit[0]
        show_all = self.show_all_var.get()
        display_batch = batch if show_all else [b for b in batch if not b[6]]
        self._occ_cache = batch
        self.occurrences = [(b[0], b[1], b[2]) for b in display_batch]
        self.occurrences_tree.delete(*self.occurrences_tree.get_children())
        self._occ_batch = display_batch
        self._occ_batch_idx = 0
        self._occ_word = self.current_word
        self._occ_show_all = show_all
        self.occurrences_tree.unbind("<<TreeviewSelect>>")
        self._insert_occ_batch()

    def _on_occ_configure(self, event=None):
        """Реакция на изменение размера окна вхождений (с задержкой)."""
        if not self.current_word:
            return
        if getattr(self, "_occ_geom_applying", False):
            return
        if getattr(self, "_occ_geom_after_id", None) is not None:
            self.root.after_cancel(self._occ_geom_after_id)
        self._occ_geom_after_id = self.root.after(200, self._reflow_occurrences)

    def populate_occurrences(self, word):
        # Отменяем предыдущую операцию вставки, если она еще выполняется
        if self._insert_after_id is not None:
            self.root.after_cancel(self._insert_after_id)
            self._insert_after_id = None
        # Создаем уникальный токен для текущей операции
        self._current_batch_token = id(self)
        
        self.occurrences_tree.delete(*self.occurrences_tree.get_children())
        self.occurrences = []
        self._occ_sort_col = None
        self._update_occ_headings()
        # Геометрия колонок считается ДО построения строк: префикс обрезается
        # ровно по фактической ширине колонки (иначе Tk прячет его хвост).
        line_w, prefix_w, om_w, suffix_w = self._occ_geometry(word)
        self._apply_occ_geometry(line_w, prefix_w, om_w, suffix_w)
        max_prefix_px = max(8, prefix_w - 8)
        max_suffix_px = max(8, suffix_w - 8)
        max_chars = cfg.DEFAULT_SETTINGS.get("context_length", 40) or None
        show_all = self.show_all_var.get()

        cache_key = (word, True)
        cached = self._occ_cache_manager.get(cache_key)
        if cached and len(cached) > 2 and cached[2] != prefix_w:
            cached = self._refit_cached_batch(word, prefix_w, suffix_w)
        if cached:
            batch = cached[0]
            if show_all and len(cached) > 3 and not cached[3]:
                # список кэширован без контекста отфильтрованных строк —
                # досчитываем его целиком (пользователь включил «Все»)
                cached = self._refit_cached_batch(word, prefix_w, suffix_w)
                batch = cached[0]
            display_batch = batch if show_all else [b for b in batch if not b[6]]
            self.occurrences = [(b[0], b[1], b[2]) for b in display_batch]
            self._occ_cache = batch
            self._occ_cache_key = cache_key
            self._occ_batch = display_batch
            self._occ_batch_idx = 0
            self._occ_word = word
            self._occ_show_all = show_all
            self.occurrences_tree.unbind("<<TreeviewSelect>>")
            self._insert_occ_batch()
            return

        batch = []
        self.progress_var.set(f"Построение списка вхождений для '{word}' ...")
        self.root.update_idletasks()
        if hasattr(self, "_word_index") and word in self._word_index:
            for li, ti in self._word_index[word]:
                tokens = self.lines[li]
                t = tokens[ti]
                is_accented = not self._is_unaccented(t["text"])
                if is_accented and not show_all:
                    # строка не попадёт в список (режим «Все» выключен) —
                    # контекст не строим: это основная экономия времени
                    batch.append([li + 1, li, ti, None, t["text"], None, is_accented])
                    continue
                line_str = detokenize_line(tokens).rstrip("\n\r")
                pos = 0
                for tj in range(ti):
                    pos += len(tokens[tj]["text"])
                om_start = pos
                om_end = pos + len(t["text"])
                # Префикс: обрезаем слева, оставляя правую часть перед омографом
                prefix = self._make_prefix(line_str[:om_start], max_prefix_px, max_chars)
                om_text = line_str[om_start:om_end]
                # Суффикс: от омографа до конца строки, влезающий в колонку
                suffix = self._make_suffix(line_str[om_end:], max_suffix_px)
                batch.append([li + 1, li, ti, prefix, om_text, suffix, is_accented])

        display_batch = batch if show_all else [b for b in batch if not b[6]]
        batch_complete = all(b[3] is not None for b in batch)
        self.occurrences = [(b[0], b[1], b[2]) for b in display_batch]
        self._occ_cache = batch
        self._occ_cache_key = (word, True)

        # Ширины колонок выставлены выше (см. _apply_occ_geometry)
        self._occ_cache_manager.put((word, True), (batch, om_w, prefix_w, batch_complete))
        if cfg.DEFAULT_SETTINGS.get("auto_cache", False):
            pass  # auto_cache уже обработан в OccurrenceCache
        self.cache_label.config(text=f"Кэш: {len(self._occ_cache_manager)}/{self._occ_cache_size}")

        self._occ_batch = display_batch
        self._occ_batch_idx = 0
        self._occ_word = word
        self._occ_show_all = show_all
        self.occurrences_tree.unbind("<<TreeviewSelect>>")
        self._insert_occ_batch()

    def _insert_occ_batch(self):
        # Проверяем, что эта операция все еще актуальна
        if self._current_batch_token != id(self):
            return
        
        batch_size = self.OCCURRENCES_BATCH_SIZE
        batch = self._occ_batch
        start = self._occ_batch_idx
        end = min(start + batch_size, len(batch))
        
        # Проверяем, что batch все еще соответствует текущему слову
        if not hasattr(self, '_occ_word') or self._occ_word != self.current_word:
            return
        
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
            # Сохраняем ID для возможной отмены
            self._insert_after_id = self.root.after(10, self._insert_occ_batch)
        else:
            self._insert_after_id = None
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
            if not cfg.DEFAULT_SETTINGS.get("allow_context_edit", False):
                self.context_text.configure(state=tk.DISABLED)
            return

        start_line = max(0, li - 4)
        end_line = min(len(self.lines), li + 3)

        tokens = self.lines[li]
        font_obj = self._context_font_obj
        om_start, om_text, padding, padding_chars, om_center_px, half_screen_px = compute_padding(
            self.context_text, self.lines, li, ti, word, clean_accents, font_obj
        )
        
        # Вычисляем right_padding
        if om_text:
            char_w = font_obj.measure("0")
            win_w = self.context_text.winfo_width()
            if win_w < 100:
                win_w = 800
            screen_chars = max(1, int(win_w / char_w))
            right_padding = " " * (screen_chars // 2)
            space_w = font_obj.measure(" ")
        else:
            right_padding = ""
            space_w = 0

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
                self._insert_context_with_accents(line_text_i[om_end:] + right_padding + "\n", tag)
            else:
                self._insert_context_with_accents(line_text_i + "\n", tag)

        # Скролл только если омограф правее центра
        self.context_text.delete("end-2c", "end-1c")
        if not cfg.DEFAULT_SETTINGS.get("allow_context_edit", False):
            self.context_text.configure(state=tk.DISABLED)
        if om_text and om_center_px > half_screen_px:
            scroll_px = om_center_px + padding_chars * space_w - half_screen_px
            scroll_chars = int(scroll_px / char_w) if char_w > 0 else 0

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

    def _match_occurrence(self, b, term):
        if not term:
            return True
        _, _, _, prefix, om_text, suffix, _ = b
        prefix = prefix or ""
        suffix = suffix or ""
        if "@" in term:
            left, right = term.split("@", 1)
            left = left[1:] if left.startswith("<") else left
            right = right[1:] if right.startswith(">") else right
            return (re.search(left, prefix, re.IGNORECASE) if left else True) and \
                   (re.search(right, suffix, re.IGNORECASE) if right else True)
        if term.startswith("<"):
            return re.search(term[1:], prefix, re.IGNORECASE) is not None
        if term.startswith(">"):
            return re.search(term[1:], suffix, re.IGNORECASE) is not None
        text = prefix + " " + om_text + " " + suffix
        return re.search(term, text, re.IGNORECASE) is not None

    def _insert_context_with_accents(self, text, base_tag):
        """Вставляет текст в context_text, подсвечивая ударения зелёным."""
        insert_context_with_accents(self.context_text, text, base_tag)

    # ======================== ИНТЕРФЕЙС ========================

    def create_widgets(self):
        style = ttk.Style()
        ui_font = cfg.DEFAULT_FONTS["ui"]
        style.configure(".", font=ui_font)
        style.configure("TLabelframe.Label", font=(ui_font[0], ui_font[1], "bold"), padding=0)
        style.configure("Treeview", font=ui_font)
        style.configure(
            "Scripts.Treeview.Heading",
            font=(ui_font[0], ui_font[1], "bold"),
            background=cfg.DEFAULT_COLORS["bg_main"],
            foreground=cfg.DEFAULT_COLORS["fg_text"],
            borderwidth=0,
            relief="flat",
        )
        style.configure(
            "Occurrences.Treeview.Heading",
            font=(ui_font[0], ui_font[1], "bold"),
            background=cfg.DEFAULT_COLORS["bg_main"],
            foreground=cfg.DEFAULT_COLORS["fg_text"],
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
            background=[("active", cfg.DEFAULT_COLORS["bg_button_active"])],
            foreground=[("active", cfg.DEFAULT_COLORS["fg_text"])],
            relief=[("active", "raised")],
        )
        style.map(
            "Occurrences.Treeview.Heading",
            background=[("active", cfg.DEFAULT_COLORS["bg_button_active"])],
            foreground=[("active", cfg.DEFAULT_COLORS["fg_text"])],
            relief=[("active", "raised")],
        )
        style.configure("TButton", font=ui_font)
        style.configure("TCheckbutton", font=ui_font)
        style.configure("TLabel", font=ui_font)

        toolbar = ttk.Frame(self.root)
        toolbar.pack(fill=tk.X, padx=5, pady=5)

        ttk.Button(toolbar, text="⟳ Обновить", command=self.refresh_all).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Перечитать книгу и директорию скриптов\nF12")
        ttk.Button(toolbar, text="📁 Директория", command=self.change_directory).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Выбрать директорию скриптов\nCtrl+D")
        ttk.Button(toolbar, text="📖 Книга", command=self.open_book).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Открыть книгу в читалке\nb")
        ttk.Button(toolbar, text="🎯 Цель", command=self.change_target_file).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Сменить целевой файл\nCtrl+T")
        self.save_btn = ttk.Button(toolbar, text="💾 Сохранить", command=self._write_dirty_lines)
        self._add_tooltip(self.save_btn, "Сохранить изменения\nF6")
        self.save_btn.pack(side=tk.LEFT, padx=2)
        self.undo_btn = ttk.Button(toolbar, text="🔙 Назад", command=self._undo_last)
        self.undo_btn.pack(side=tk.LEFT, padx=(20, 2))
        self._add_tooltip(self.undo_btn, "Отменить последнее изменение\nu")
        ttk.Button(toolbar, text="💣 Отмена", command=self._undo_all).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Отменить все несохраненные изменения\nShift-U")
        ttk.Button(toolbar, text="📦 Наполнить", command=self._fill_cache).pack(side=tk.LEFT, padx=(20, 2))
        self._add_tooltip(toolbar.winfo_children()[-1], "Наполнить кэш списков вхождений\nF9")
        ttk.Button(toolbar, text="🗑 Очистить", command=self._clear_cache).pack(side=tk.LEFT, padx=2)
        self._add_tooltip(toolbar.winfo_children()[-1], "Очистить кэш списков вхождений\nShift-F9")
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
        left_col.grid(row=0, column=0, sticky="nsew", padx=(0, 0), pady=0)
        left_col.grid_rowconfigure(0, weight=1)

        left_frame = ttk.Frame(left_col)
        left_frame.grid(row=0, column=0, sticky="nsew", pady=(0, 0))

        left_header = ttk.Frame(left_frame)
        left_header.pack(fill=tk.X, padx=2, pady=0)
        self.search_var = tk.StringVar()
        self.search_var.trace("w", self.filter_scripts)
        style.configure("Search.TEntry", font=cfg.DEFAULT_FONTS["ui"], insertbackground=cfg.DEFAULT_COLORS["fg_text"])
        style.map(
            "Search.TEntry",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )
        self.search_entry = tk.Entry(
            left_header,
            textvariable=self.search_var,
            font=cfg.DEFAULT_FONTS["ui"],
            bg=cfg.DEFAULT_COLORS["bg_text"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            insertbackground=cfg.DEFAULT_COLORS["fg_text"],
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
            font=cfg.DEFAULT_FONTS["ui"],
            bg=cfg.DEFAULT_COLORS["bg_button"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            relief="raised",
            padx=4,
            cursor="hand2",
        )
        refresh_btn.pack(side=tk.RIGHT, padx=2)
        refresh_btn.bind("<Button-1>", lambda e: self._refresh_all_counts())

        style.configure(
            "Scripts.Treeview",
            font=cfg.DEFAULT_FONTS["scripts"],
            rowheight=int(cfg.DEFAULT_FONTS["scripts"][1] + 8),
            foreground=cfg.DEFAULT_COLORS["fg_scripts"],
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
        self.scripts_tree.heading("found", text="#", command=lambda: self._sort_scripts("found"))
        self.scripts_tree.column("word", minwidth=80, stretch=False)
        self.scripts_tree.column("found", width=60, minwidth=60, anchor="e", stretch=False)
        scripts_scroll = ttk.Scrollbar(left_frame, orient=tk.VERTICAL, command=self.scripts_tree.yview)
        self.scripts_tree.configure(yscrollcommand=scripts_scroll.set)
        self.scripts_tree.pack(side=tk.LEFT, fill=tk.Y, pady=(2, 0))
        scripts_scroll.pack(side=tk.RIGHT, fill=tk.Y, pady=(2, 0))
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
            font=cfg.DEFAULT_FONTS["ui"],
            bg=cfg.DEFAULT_COLORS["bg_button"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
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

        self.occ_search_var = tk.StringVar()
        self.occ_search_var.trace("w", self._filter_occurrences)
        self.occ_search_entry = tk.Entry(
            occ_toolbar,
            textvariable=self.occ_search_var,
            font=cfg.DEFAULT_FONTS["ui"],
            width=25,
            bg=cfg.DEFAULT_COLORS["bg_text"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            insertbackground=cfg.DEFAULT_COLORS["fg_text"],
        )
        self.occ_search_entry.pack(side=tk.LEFT, padx=(2, 2))

        self.occ_variants_text = tk.Text(
            occ_toolbar,
            height=1,
            wrap=tk.NONE,
            font=cfg.DEFAULT_FONTS["variant_bar"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            relief="flat",
            state="disabled",
        )
        self.occ_variants_text.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(2, 2))
        self.occ_variants_text.tag_configure("center", justify="center")
        self.occ_variants_text.tag_configure("accent", foreground=cfg.DEFAULT_COLORS["fg_accent"])

        self.occ_counter_var = tk.StringVar(value="")
        self.occ_counter_label = tk.Label(
            occ_toolbar,
            textvariable=self.occ_counter_var,
            font=cfg.DEFAULT_FONTS["ui"],
            fg=cfg.DEFAULT_COLORS["fg_dirty_label"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            width=5,
            anchor="e",
            relief="sunken",
            padx=3,
        )
        self.occ_counter_label.pack(side=tk.LEFT, padx=(2, 0))

        style.configure(
            "Occurrences.Treeview",
            background=cfg.DEFAULT_COLORS["bg_occurrences"],
            fieldbackground=cfg.DEFAULT_COLORS["bg_occurrences"],
            font=cfg.DEFAULT_FONTS["occurrences"],
            rowheight=cfg.DEFAULT_FONTS["occurrences"][1] + 8,
            foreground=cfg.DEFAULT_COLORS["fg_occurrences"],
        )
        style.map(
            "Occurrences.Treeview",
            highlightcolor=[("focus", "#FFFFFF")],
            highlightthickness=[("focus", 3)],
        )
        style.map(
            "Occurrences.Treeview",
            background=[("selected", cfg.DEFAULT_COLORS["bg_sel_line"])],
            foreground=[("selected", cfg.DEFAULT_COLORS["fg_sel_line"])],
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
        self.occurrences_tree.column("prefix", width=300, anchor="e", stretch=False)
        self.occurrences_tree.column("omograph", width=80, anchor="center", stretch=False)
        self.occurrences_tree.column("suffix", width=300, anchor="w", stretch=False)
        self.occurrences_tree.bind("<Configure>", self._on_occ_configure)

        self.occurrences_tree.tag_configure("row_black", background=cfg.DEFAULT_COLORS["bg_occurrences"])
        self.occurrences_tree.tag_configure("row_accented", background=cfg.DEFAULT_COLORS["bg_accented_row"])
        self.occurrences_tree.tag_configure(
            "selected",
            background=cfg.DEFAULT_COLORS["bg_sel_line"],
            foreground=cfg.DEFAULT_COLORS["fg_sel_line"],
        )

        occ_scroll = ttk.Scrollbar(occ_frame, orient=tk.VERTICAL, command=self.occurrences_tree.yview)
        self.occurrences_tree.configure(yscrollcommand=occ_scroll.set)
        self.occurrences_tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, pady=(2, 0))
        occ_scroll.pack(side=tk.RIGHT, fill=tk.Y, pady=(2, 0))

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
            font=cfg.DEFAULT_FONTS["ui"],
            fg=cfg.DEFAULT_COLORS["fg_dirty_label"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            width=6,
            anchor="center",
            relief="sunken",
            padx=3,
        )
        self.auto_pattern_label.pack(side=tk.LEFT, padx=(0, 2))
        self.auto_pattern_label.bind("<Button-3>", self._copy_auto_pattern)

        self.marked_pct_var = tk.StringVar(value="")
        self.marked_pct_label = tk.Label(
            bottom_om_frame,
            textvariable=self.marked_pct_var,
            font=cfg.DEFAULT_FONTS["ui"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            width=6,
            anchor="center",
            relief="sunken",
            padx=2,
        )
        self.marked_pct_label.pack(side=tk.LEFT, padx=(0, 2))

        self.total_count_var = tk.StringVar(value="")
        self.total_count_label = tk.Label(
            bottom_om_frame,
            textvariable=self.total_count_var,
            font=cfg.DEFAULT_FONTS["ui"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            width=6,
            anchor="center",
            relief="sunken",
            padx=2,
        )
        self.total_count_label.pack(side=tk.LEFT, padx=(0, 2))

        self.variants_text = tk.Text(
            bottom_om_frame,
            height=1,
            wrap=tk.NONE,
            font=cfg.DEFAULT_FONTS["variant_bar"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            relief="sunken",
            state="disabled",
        )
        self.variants_text.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(2, 0))
        self.variants_text.tag_configure("accent", foreground=cfg.DEFAULT_COLORS["fg_accent"])

        context_frame = ttk.Frame(right_col)
        context_frame.grid(row=2, column=0, sticky="nsew", pady=(5, 0))
        context_frame.grid_columnconfigure(0, weight=1)
        context_frame.grid_rowconfigure(0, weight=1)
        cf = tkfont.Font(family=cfg.DEFAULT_FONTS["context"][0], size=cfg.DEFAULT_FONTS["context"][1])
        of_weight = (
            "bold" if len(cfg.DEFAULT_FONTS["omograph"]) > 2 and cfg.DEFAULT_FONTS["omograph"][2] == "bold" else "normal"
        )
        of = tkfont.Font(
            family=cfg.DEFAULT_FONTS["omograph"][0],
            size=cfg.DEFAULT_FONTS["omograph"][1],
            weight=of_weight,
        )
        max_linespace = max(cf.metrics()["linespace"], of.metrics()["linespace"])
        # Учитываем spacing1 и spacing3 из context_text
        spacing1 = cfg.DEFAULT_SETTINGS.get("context_spacing1", 0)
        spacing3 = cfg.DEFAULT_SETTINGS.get("context_spacing3", 0)
        line_height = max_linespace + spacing1 + spacing3
        context_pixel_h = line_height * 7 + 18
        context_frame.config(height=context_pixel_h)
        context_frame.pack_propagate(False)

        context_height = 7
        self.context_text = tk.Text(
            context_frame,
            wrap=tk.NONE,
            bg=cfg.DEFAULT_COLORS["bg_text"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
            insertbackground=cfg.DEFAULT_COLORS["fg_text"],
            font=cfg.DEFAULT_FONTS["context"],
            height=context_height,
            width=90,
            undo=False,
            maxundo=0,
            takefocus=0,
            spacing1=cfg.DEFAULT_SETTINGS.get("context_spacing1", 0),
            spacing2=cfg.DEFAULT_SETTINGS.get("context_spacing2", 0),
            spacing3=cfg.DEFAULT_SETTINGS.get("context_spacing3", 0),
            state=tk.DISABLED if not cfg.DEFAULT_SETTINGS.get("allow_context_edit", False) else tk.NORMAL,
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
        self.context_text.bind("<z>", lambda e: self._scroll_context_chars(-3))
        self.context_text.bind("<x>", lambda e: self._scroll_context_chars(3))
        self.context_text.bind("<Key-Cyrillic_shorti>", lambda e: self.context_text.xview_moveto(0.0))
        self.context_text.bind("<Key-Cyrillic_u>", lambda e: self.context_text.xview_moveto(1.0))
        self.context_text.bind("<Key-Cyrillic_ef>", lambda e: self._scroll_context(-1))
        self.context_text.bind("<Key-Cyrillic_ve>", lambda e: self._scroll_context(1))
        self.context_text.bind("<Key-Cyrillic_tse>", lambda e: self._recenter_context())
        self.context_text.bind("<Key-Cyrillic_ya>", lambda e: self._scroll_context_chars(-3))
        self.context_text.bind("<Key-Cyrillic_che>", lambda e: self._scroll_context_chars(3))
        self.context_text.bind("<MouseWheel>", self._on_mousewheel)
        self.context_text.bind("<Shift-MouseWheel>", self._on_mousewheel_horizontal)
        self.context_text.bind("<Button-4>", lambda e: self.context_text.xview_scroll(-3, "units"))
        self.context_text.bind("<Button-5>", lambda e: self.context_text.xview_scroll(3, "units"))

        self.mono_font = self._get_mono_font()
        for key in list(cfg.DEFAULT_FONTS.keys()):
            val = cfg.DEFAULT_FONTS[key]
            if isinstance(val, tuple) and len(val) > 0 and val[0] in ("DejaVu Sans Mono", "Courier"):
                cfg.DEFAULT_FONTS[key] = (self.mono_font,) + val[1:]

        self.context_text.tag_configure(
            "omograph",
            background=cfg.DEFAULT_COLORS["bg_om_highlight"],
            foreground=cfg.DEFAULT_COLORS["fg_om_highlight"],
            font=cfg.DEFAULT_FONTS["omograph"],
        )
        self.context_text.tag_configure("accent", foreground=cfg.DEFAULT_COLORS["fg_accent"])
        self.context_text.tag_configure("context_line", foreground=cfg.DEFAULT_COLORS["fg_context_line"])
        self.context_text.tag_configure("current_line", foreground=cfg.DEFAULT_COLORS["fg_context_current"])
        self.context_text.tag_configure("line_number", foreground=cfg.DEFAULT_COLORS["fg_context_line"])
        self.context_text.tag_configure("separator", foreground=cfg.DEFAULT_COLORS["fg_separator"])

        self.scripts_tree.bind("<Tab>", lambda e: self.occurrences_tree.focus_set() or "break")
        self.occurrences_tree.bind("<Tab>", lambda e: self.scripts_tree.focus_set() or "break")

        self.progress_var = tk.StringVar(value="Готов к работе")
        bottom_frame = ttk.Frame(self.root)
        bottom_frame.pack(fill=tk.X, padx=5, pady=5)
        ttk.Label(bottom_frame, textvariable=self.progress_var).pack(side=tk.LEFT)
        self.dir_label = tk.Label(
            bottom_frame,
            text="",
            font=cfg.DEFAULT_FONTS["ui"],
            fg=cfg.DEFAULT_COLORS["fg_dir_label"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
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

    def _bind_hotkey(self, key, func):
        def wrapper(event):
            if self._is_edit_focus():
                return "break"
            return func(event)
        self.root.bind(key, wrapper)

    def _is_edit_focus(self):
        focused = self.root.focus_get()
        return focused in (getattr(self, "search_entry", None), getattr(self, "occ_search_entry", None))

    def bind_hotkeys(self):
        self.root.bind("<F1>", lambda e: self._show_help())
        self.root.bind("<F2>", lambda e: self.scripts_tree.focus_set())
        self.root.bind("<F3>", lambda e: self.occurrences_tree.focus_set())
        self.root.bind("<F4>", lambda e: self._goto_current_script())
        self.root.bind("<F5>", lambda e: self.search_entry.focus_set())
        self.root.bind("<F6>", lambda e: self._write_dirty_lines())
        self.root.bind("<F7>", lambda e: self.occ_search_entry.focus_set())
        self.root.bind("<F8>", lambda e: self.search_var.set("") or self.occ_search_var.set(""))
        self.root.bind("<F9>", lambda e: self._fill_cache())
        self.root.bind("<Shift-F9>", lambda e: self._clear_cache())
        self.root.bind("<F12>", lambda e: self._refresh_all_counts())
        self._bind_hotkey("<y>", lambda e: self._toggle_show_all())
        self._bind_hotkey("<Key-Cyrillic_en>", lambda e: self._toggle_show_all())
        self._bind_hotkey("<t>", lambda e: self._toggle_show_all_scripts())
        self._bind_hotkey("<Key-Cyrillic_ie>", lambda e: self._toggle_show_all_scripts())
        self._bind_hotkey("<w>", lambda e: self._recenter_context())
        self._bind_hotkey("<Key-Cyrillic_tse>", lambda e: self._recenter_context())
        self._bind_hotkey("<a>", lambda e: self._scroll_context(-1))
        self._bind_hotkey("<Key-Cyrillic_ef>", lambda e: self._scroll_context(-1))
        self._bind_hotkey("<d>", lambda e: self._scroll_context(1))
        self._bind_hotkey("<Key-Cyrillic_ve>", lambda e: self._scroll_context(1))
        self._bind_hotkey("<q>", lambda e: self.context_text.xview_moveto(0.0))
        self._bind_hotkey("<Key-Cyrillic_shorti>", lambda e: self.context_text.xview_moveto(0.0))
        self._bind_hotkey("<e>", lambda e: self.context_text.xview_moveto(1.0))
        self._bind_hotkey("<Key-Cyrillic_u>", lambda e: self.context_text.xview_moveto(1.0))
        self._bind_hotkey("<o>", lambda e: self._refresh_all_counts())
        self._bind_hotkey("<Key-Cyrillic_shcha>", lambda e: self._refresh_all_counts())
        self._bind_hotkey("<p>", lambda e: self._refresh_occurrences())
        self._bind_hotkey("<Key-Cyrillic_ze>", lambda e: self._refresh_occurrences())
        self._bind_hotkey("<z>", lambda e: self._scroll_context_chars(-3))
        self._bind_hotkey("<Key-Cyrillic_ya>", lambda e: self._scroll_context_chars(-3))
        self._bind_hotkey("<x>", lambda e: self._scroll_context_chars(3))
        self._bind_hotkey("<Key-Cyrillic_che>", lambda e: self._scroll_context_chars(3))
        self._bind_hotkey("<u>", lambda e: self._undo_last())
        self._bind_hotkey("<Key-Cyrillic_ghe>", lambda e: self._undo_last())
        self._bind_hotkey("<Control-u>", lambda e: self._undo_all())
        self._bind_hotkey("<Control-Key-Cyrillic_ghe>", lambda e: self._undo_all())
        self.root.bind("<Control-f>", lambda e: self.search_entry.focus_set())
        self.root.bind("<Control-Key-Cyrillic_a>", lambda e: self.search_entry.focus_set())
        for i in range(1, 9):
            # 1-9 — замена текущего (видимого)
            self._bind_hotkey(str(i), lambda e, n=i: self._on_hotkey_variant(n, "selected"))
            self._bind_hotkey(f"<KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "selected"))
            # Alt+1-9 — замена всех видимых
            self._bind_hotkey(f"<Mod1-Key-{i}>", lambda e, n=i: self._on_hotkey_variant(n, "visible"))
            self._bind_hotkey(f"<Mod1-KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "visible"))
            # Ctrl+1-9 — замена всех в файле
            self._bind_hotkey(f"<Control-Key-{i}>", lambda e, n=i: self._on_hotkey_variant(n, "all"))
            self._bind_hotkey(f"<Control-KP_{i}>", lambda e, n=i: self._on_hotkey_variant(n, "all"))
        # 0 — очистить текущее (видимое)
        self._bind_hotkey("0", lambda e: self._on_hotkey_clean("selected"))
        self.root.bind("<KP_0>", lambda e: self._on_hotkey_clean("selected"))
        # Alt+0 — очистить все видимые
        self.root.bind("<Mod1-Key-0>", lambda e: self._on_hotkey_clean("visible"))
        self.root.bind("<Mod1-KP_0>", lambda e: self._on_hotkey_clean("visible"))
        # Ctrl+0 — очистить все в файле
        self.root.bind("<Control-Key-0>", lambda e: self._on_hotkey_clean("all"))
        self.root.bind("<Control-KP_0>", lambda e: self._on_hotkey_clean("all"))
        self.root.bind("<Up>", lambda e: self._navigate_occurrence(-1))
        self.root.bind("<Down>", lambda e: self._navigate_occurrence(1))
        self.root.bind("<space>", lambda e: self._navigate_occurrence(1))
        self._bind_hotkey("<Left>", lambda e: self._navigate_script(-1))
        self._bind_hotkey("<Right>", lambda e: self._navigate_script(1))
        self._bind_hotkey("<equal>", lambda e: self._apply_default_variant())
        self._bind_hotkey("<h>", lambda e: self._occurrences_home())
        self._bind_hotkey("<Key-Cyrillic_er>", lambda e: self._occurrences_home())
        self._bind_hotkey("<l>", lambda e: self._occurrences_end())
        self._bind_hotkey("<Key-Cyrillic_de>", lambda e: self._occurrences_end())
        self._bind_hotkey("<j>", lambda e: self._occurrences_page_up())
        self._bind_hotkey("<Key-Cyrillic_o>", lambda e: self._occurrences_page_up())
        self._bind_hotkey("<k>", lambda e: self._occurrences_page_down())
        self._bind_hotkey("<Key-Cyrillic_el>", lambda e: self._occurrences_page_down())
        self._bind_hotkey("<n>", lambda e: self._sort_occurrences_by_line())
        self._bind_hotkey("<Key-Cyrillic_te>", lambda e: self._sort_occurrences_by_line())
        self._bind_hotkey("<comma>", lambda e: self._sort_occurrences_by_prefix())
        self._bind_hotkey("<Key-Cyrillic_be>", lambda e: self._sort_occurrences_by_prefix())
        self._bind_hotkey("<period>", lambda e: self._sort_occurrences_by_suffix())
        self._bind_hotkey("<Key-Cyrillic_yu>", lambda e: self._sort_occurrences_by_suffix())
        self._bind_hotkey("<Control-d>", lambda e: self.change_directory())
        self._bind_hotkey("<Control-Key-Cyrillic_ve>", lambda e: self.change_directory())
        self._bind_hotkey("<b>", lambda e: self.open_book())
        self._bind_hotkey("<Key-Cyrillic_i>", lambda e: self.open_book())
        self._bind_hotkey("<Control-t>", lambda e: self.change_target_file())
        self._bind_hotkey("<Control-Key-Cyrillic_ie>", lambda e: self.change_target_file())

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
            cleaned_count = 0
            for li, tokens in enumerate(self.lines):
                for t in tokens:
                    if t["type"] == "word" and t["clean"] == word:
                        t["text"] = self._clean_accents(t["text"])
                        self._mark_dirty(li)
                        cleaned_count += 1
            self._scan_all_omographs()
            self.scripts_info[word]["unaccented_count"] = self.scripts_info[word].get("total_count", 0)
            self.scripts_info[word]["marked_count"] = 0
            # Обновляем счетчик в таблице омографов
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == word:
                    self.scripts_tree.set(item, "found", self.scripts_info[word]["unaccented_count"])
                    break
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
        if not self._undo_manager:
            self.progress_var.set("Нечего отменять")
            return
        self._start_operation()
        old_idx = self.current_occurrence
        action_data = self._undo_manager.pop()
        result = apply_undo_action(action_data, self.lines, self._original_lines, self._dirty_lines)
        update_dirty_lines(self._dirty_lines, self._original_lines, self.lines, result[1])
        
        if result[0] == "group":
            group_actions = action_data[1]
            self._update_progress_with_time(f"↩ Отменена групповая операция ({len(group_actions)} вхождений)")
        else:
            action, li, ti, old_text, old_clean = action_data
            self._update_progress_with_time(f"↩ Отменено: {old_text}")
        cnt = len(self._dirty_lines)
        self.occ_counter_var.set(str(cnt) if cnt > 0 else "")
        if cnt > 0:
            self.dirty_status_var.set(f"⚠ Изменено строк: {cnt}")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_dirty_label"])
        else:
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_status_clean"])
        # Обновление счетчиков
        if result[0] == "group":
            self._scan_all_omographs()
        else:
            action = result[0]
            old_clean = result[2]
            li = action_data[1]
            ti = action_data[2]
            if action == "replace":
                # Была замена - возвращаем неразмеченное состояние
                if old_clean in self.scripts_info:
                    self.scripts_info[old_clean]["unaccented_count"] = self.scripts_info[old_clean].get("unaccented_count", 0) + 1
                    self.scripts_info[old_clean]["marked_count"] = max(0, self.scripts_info[old_clean].get("marked_count", 0) - 1)
            elif action == "clean":
                # Была очистка - возвращаем размеченное состояние
                if old_clean in self.scripts_info:
                    self.scripts_info[old_clean]["unaccented_count"] = max(0, self.scripts_info[old_clean].get("unaccented_count", 0) - 1)
                    self.scripts_info[old_clean]["marked_count"] = self.scripts_info[old_clean].get("marked_count", 0) + 1
        self._update_cached_counts()
        if self.current_word:
            for item in self.scripts_tree.get_children():
                if self.scripts_tree.item(item, "values")[0] == self.current_word:
                    self.scripts_tree.set(item, "found", self.scripts_info[self.current_word].get("unaccented_count", 0))
                    break
        self.update_status()
        undo_word = result[2] if result[0] != "group" else None
        if undo_word:
            self._update_occ_cache_entry(undo_word, action_data[1], action_data[2])
            if self.current_word == undo_word:
                self._redraw_occurrences_after_change(old_idx)

    def _update_cached_counts(self):
        if self._script_items_cache is not None:
            self._script_items_cache = [
                (word, self.scripts_info[word].get("unaccented_count", 0))
                for word, _ in self._script_items_cache
            ]
        self._all_script_items = self._script_items_cache

    def _undo_all(self):
        if not self._undo_manager:
            self.progress_var.set("Нечего отменять")
            return
        self._start_operation()
        cnt = len(self._undo_manager)
        if not messagebox.askyesno("Подтверждение", f"Отменить ВСЕ изменения\n({cnt} действий)?"):
            return
        # Запоминаем текущее слово для обновления occurrences
        current_word = self.current_word
        current_occurrence = self.current_occurrence
        # Собираем уникальные слова из undo_stack для точечной очистки кэша
        affected_words = set()
        for entry in self._undo_manager.undo_stack:
            if entry[0] == "group":
                # Групповая операция - обрабатываем все действия внутри
                group_actions = entry[1]
                for action, li, ti, old_text, old_clean in group_actions:
                    affected_words.add(old_clean)
                    if ti < len(self.lines[li]):
                        affected_words.add(self.lines[li][ti]["clean"])
            else:
                # Одиночная операция
                action, li, ti, old_text, old_clean = entry
                affected_words.add(old_clean)
                if ti < len(self.lines[li]):
                    affected_words.add(self.lines[li][ti]["clean"])
        while self._undo_manager:
            entry = self._undo_manager.pop()
            if entry[0] == "group":
                # Групповая операция - откатываем все действия
                group_actions = entry[1]
                for action, li, ti, old_text, old_clean in group_actions:
                    t = self.lines[li][ti]
                    t["text"] = old_text
                    t["clean"] = old_clean
            else:
                # Одиночная операция
                action, li, ti, old_text, old_clean = entry
                t = self.lines[li][ti]
                t["text"] = old_text
                t["clean"] = old_clean
        self._dirty_lines.clear()
        self.dirty_status_var.set("Изменений нет")
        self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_text"])
        self.occ_counter_var.set("")
        self._update_progress_with_time("↩ Отменены все изменения")
        self._scan_all_omographs()
        self._update_cached_counts()
        # Очищаем кэш только для затронутых слов
        for word in affected_words:
            cache_key = (word, True)
            self._occ_cache_manager.remove(cache_key)
        self.cache_label.config(text=f"Кэш: {len(self._occ_cache_manager)}/{self._occ_cache_size}")
        self._script_items_dirty = True
        self.filter_scripts()
        if current_word:
            self.current_word = current_word
            self.current_occurrence = current_occurrence
            self.populate_occurrences(current_word)
        self.update_status()

    def _fill_cache(self):
        self._start_operation()
        self._fill_cache_queue = build_fill_queue(
            self.scripts_info,
            self._occ_cache_size,
            cfg.DEFAULT_SETTINGS.get("auto_cache_size", 10),
        )
        self.progress_var.set("Создание кэша списков вхождений ... ожидайте")
        self._fill_cache_step()

    def _fill_cache_step(self):
        if not self._fill_cache_queue:
            self._update_progress_with_time(f"✓ Кэш заполнен ({len(self._occ_cache_manager)}/{self._occ_cache_size})")
            return
        word = self._fill_cache_queue.pop(0)
        self.progress_var.set(f"Кэширование: {word} ...")
        self.root.update_idletasks()
        self.populate_occurrences(word)
        self.root.after(10, self._fill_cache_step)

    def _clear_cache(self):
        self._start_operation()
        self._occ_cache_manager.clear()
        self.cache_label.config(text=f"Кэш: 0/{self._occ_cache_size}")
        self._update_progress_with_time("✓ Кэш очищен")

    def _scroll_context(self, direction):
        current = self.context_text.xview()
        step = 0.1
        new_pos = max(0.0, min(1.0, current[0] + direction * step))
        self.context_text.xview_moveto(new_pos)

    def _scroll_context_chars(self, chars):
        """Плавный скролл на chars символов."""
        font_obj = tkfont.Font(family=cfg.DEFAULT_FONTS["context"][0], size=cfg.DEFAULT_FONTS["context"][1])
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
        show_all = self.show_all_var.get()
        display_batch = self._occ_cache if show_all else [b for b in self._occ_cache if not b[6]]
        self.occurrences = [(b[0], b[1], b[2]) for b in display_batch]
        self.occurrences_tree.delete(*self.occurrences_tree.get_children())
        self._occ_batch = display_batch
        self._occ_batch_idx = 0
        self.occurrences_tree.unbind("<<TreeviewSelect>>")
        self._insert_occ_batch()

    def _update_occ_headings(self):
        self.occurrences_tree.heading("prefix", text="⟵ контекст" if self._occ_sort_col != "prefix" else "⟵ 🍀 контекст 🍀")
        self.occurrences_tree.heading("suffix", text="контекст ⟶" if self._occ_sort_col != "suffix" else "🍀 контекст 🍀 ⟶")

    def _on_tree_focus_in(self, event):
        style = ttk.Style()
        if event.widget == self.scripts_tree:
            style.configure("Scripts.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_heading_focus"])
            style.configure("Occurrences.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_text"])
        else:
            style.configure("Occurrences.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_heading_focus"])
            style.configure("Scripts.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_text"])

    def _on_tree_focus_out(self, event):
        style = ttk.Style()
        style.configure("Scripts.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_text"])
        style.configure("Occurrences.Treeview.Heading", foreground=cfg.DEFAULT_COLORS["fg_text"])

    def _add_tooltip(self, widget, text):
        def enter(event):
            if not self.show_tips_var.get():
                return
            tip = tk.Toplevel(widget)
            tip.wm_overrideredirect(True)
            x = event.x_root + 10
            y = event.y_root + 10
            # Temporary label to measure width
            label = tk.Label(tip, text=text, font=cfg.DEFAULT_FONTS["ui"], padx=3, pady=1)
            width = label.winfo_reqwidth()
            label.destroy()
            screen_width = self.root.winfo_screenwidth()
            if x + width > screen_width:
                x = screen_width - width - 10
            tip.wm_geometry(f"+{x}+{y}")
            label = tk.Label(tip, text=text, background="#FFFFAA", relief="solid", borderwidth=1, font=cfg.DEFAULT_FONTS["ui"], padx=3, pady=1)
            label.pack()
            self._tooltips[widget] = tip
        def leave(event):
            tip = self._tooltips.pop(widget, None)
            if tip:
                try:
                    tip.destroy()
                except tk.TclError:
                    pass
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

    def _occurrences_home(self):
        if self.occurrences:
            self._select_occurrence(0)

    def _occurrences_end(self):
        if self.occurrences:
            self._select_occurrence(len(self.occurrences) - 1)

    def _occurrences_page_down(self):
        if not self.occurrences:
            return
        row_height = cfg.DEFAULT_FONTS["occurrences"][1] + 8
        visible = max(1, self.occurrences_tree.winfo_height() // row_height)
        if visible == 0:
            return
        new_idx = min(len(self.occurrences) - 1, (self.current_occurrence or 0) + visible)
        self._select_occurrence(new_idx)

    def _occurrences_page_up(self):
        if not self.occurrences:
            return
        row_height = cfg.DEFAULT_FONTS["occurrences"][1] + 8
        visible = max(1, self.occurrences_tree.winfo_height() // row_height)
        if visible == 0:
            return
        new_idx = max(0, (self.current_occurrence or 0) - visible)
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
            if not show_all and self.scripts_info.get(word, {}).get("file") is None:
                continue
            if not show_all and count == 0:
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
        help_win.title("Справка")
        help_win.configure(bg=cfg.DEFAULT_COLORS["bg_main"])
        help_win.resizable(False, False)
        help_text = (
            "ФАЙЛЫ:\n"
            "  Первичным источником данных служит директории с дискретными скриптами, а не редактируемый файл.\n"
            "  Директории генерируются одним из скриптов momo.sh (mano-), lexxer.sh (nomo-), yofik.sh (yomo-).\n"
            "  Целевой файл для изменений показан в строке состояния внизу.\n"
            "\n"
            "ЗАМЕНА ВХОЖДЕНИЙ:\n"
            "  1-3 — заменить выбранное | Alt+1-3 — все видимые | Ctrl+1-3 — все в файле\n"
            "  0 — очистить выбранное | Alt+0 — все видимые | Ctrl+0 — все в файле\n"
            "  = — вариант по умолчанию | F6 — сохранить в целевой файл\n"
            "\n"
            "НАВИГАЦИЯ:\n"
            "  ↑↓ — вхождения | ←→ — омографы\n"
            "  F5 — поиск омографа | F7 — поиск вхождения | F8 – очистить поля поиска\n"
            "  F2/F3 — фокус омографы/вхождения | TAB – переключить фокус | F4 — текущий омограф в списке\n"
            "\n"
            "КОНТЕКСТ (окно внизу):\n"
            "  a/d — быстрый скролл | z/x — медленный скролл | q/e — начало/конец | w — центровка авто\n"
            "  NB: копирование выделенного мышью текста доступно кликом правой кнопки мыши по выделенному тексту.\n"
            "      Скопировнный текст может быть не виден в системной истории буфера обмена!\n"
            "      Ctrl+C работает только при включенной опции allow_context_edit (см. конфиг)\n"
            "\n"
            "ПРОЧЕЕ:\n"
            "  u — отмена последнего изменения | Shift+U — отменить все изменения\n"
            "  F8 — очистить окна поиска | F12 — загрузить данные заново из директории и файла\n"
            "  F9 — заполнить автокэш (для быстроты) | Shift-F9 – очистить кэш\n"
            "  Ctrl+D — сменить директорию со скриптами | Ctrl+T — сменить целевой файл | b – открыть книгу в читалке\n"
            "  Переключить видимость скрытых списков:\n"
            "      t – список омографов | y — список вхождений\n"
            "\n"
            "  NB: все алфавитные клавиши повторены на кириллице"
        )
        lbl = tk.Label(
            help_win,
            text=help_text,
            font=cfg.DEFAULT_FONTS["ui"],
            bg=cfg.DEFAULT_COLORS["bg_main"],
            fg=cfg.DEFAULT_COLORS["fg_text"],
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
            # Если есть текст поиска, применяем фильтр
            if self.occ_search_var.get():
                self._filter_occurrences()

    def _filter_occurrences(self, *args):
        if not self.current_word:
            return
        search_term = self.occ_search_var.get()
        if hasattr(self, "_occ_cache") and self._occ_cache:
            show_all = self.show_all_var.get()
            
            # Проверяем, является ли поиск числом (номер строки)
            is_line_search = search_term.isdigit()
            
            if is_line_search:
                line_num = int(search_term)
                self.occurrences = [(b[0], b[1], b[2]) for b in self._occ_cache
                                    if (show_all or not b[6]) and b[0] == line_num]
                self._occ_batch = [b for b in self._occ_cache
                                   if (show_all or not b[6]) and b[0] == line_num]
            else:
                self.occurrences = [(b[0], b[1], b[2]) for b in self._occ_cache
                                    if (show_all or not b[6]) and self._match_occurrence(b, search_term)]
                self._occ_batch = [b for b in self._occ_cache
                                   if (show_all or not b[6]) and self._match_occurrence(b, search_term)]
            
            self.occurrences_tree.delete(*self.occurrences_tree.get_children())
            self._occ_batch_idx = 0
            self.occurrences_tree.unbind("<<TreeviewSelect>>")
            self._insert_occ_batch()
            self.progress_var.set(f"Найдено: {len(self.occurrences)}")

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

    def _insert_with_accents_to(self, widget, text):
        i = 0
        while i < len(text):
            ch = text[i]
            if i + 1 < len(text) and unicodedata.combining(text[i + 1]):
                widget.insert(tk.END, ch + text[i + 1], "accent")
                i += 2
            else:
                widget.insert(tk.END, ch)
                i += 1

    def _insert_with_accents_variant(self, text):
        self._insert_with_accents_to(self.variants_text, text)

    def _insert_with_accents_occ_variant(self, text):
        self._insert_with_accents_to(self.occ_variants_text, text)

    def _update_occ_variants(self, info, word):
        self.occ_variants_text.config(state="normal")
        self.occ_variants_text.delete(1.0, tk.END)
        self.occ_variants_text.insert(tk.END, " ", "center")
        parts = []
        for i, v in enumerate(info["variants"], 1):
            variant_text = self._apply_case(v["accented"], word)
            parts.append((f"{i}: ", variant_text))
        parts.append(("0: ", word))
        for j, (label, text) in enumerate(parts):
            if j > 0:
                self.occ_variants_text.insert(tk.END, "          ")
            self.occ_variants_text.insert(tk.END, label)
            self._insert_with_accents_occ_variant(text)
        self.occ_variants_text.insert(tk.END, " ", "center")
        self.occ_variants_text.tag_add("center", "1.0", "end")
        self.occ_variants_text.config(state="disabled")

    def update_variants_bar(self, word):
        if word not in self.scripts_info:
            return
        info = self.scripts_info[word]
        auto_pattern = info.get("auto_pattern", "")
        self.auto_pattern_var.set(auto_pattern if auto_pattern and auto_pattern != "нет" else "нет")
        if auto_pattern and auto_pattern != "нет":
            self.auto_pattern_label.configure(fg=cfg.DEFAULT_COLORS["fg_accent"])
        else:
            self.auto_pattern_label.configure(fg=cfg.DEFAULT_COLORS["fg_dirty_label"])
        total = info.get("total_count", 0)
        marked = info.get("marked_count", 0)
        pct = (marked / total * 100) if total > 0 else 0
        self.marked_pct_var.set(f"{pct:.0f}%" if total > 0 else "—")
        self.total_count_var.set(str(total))

        # Обновляем полосу вариантов с зелёными ударениями
        self.variants_text.config(state="normal")
        self.variants_text.delete(1.0, tk.END)
        parts = []
        for i, v in enumerate(info["variants"], 1):
            variant_text = self._apply_case(v["accented"], word)
            parts.append((f"{i}: ", variant_text))
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
            self.variants_text.insert(tk.END, "          ❇ : ")
            default_text = self._apply_case(info["default"], word)
            self._insert_with_accents_variant(default_text)
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
        if psutil is None:
            self.memory_label.config(text="psutil ✗")
            return
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
            self.dir_label.config(text=f"📂 {name} | 📄 {fname}{backup_text}", fg=cfg.DEFAULT_COLORS["fg_dir_label"])

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
        self._start_operation()
        self._clear_cache()
        self._undo_manager.clear()
        self._dirty_lines.clear()
        self._script_items_dirty = True
        self._script_items_cache = None
        self.occ_counter_var.set("")
        self.dirty_status_var.set("Изменений нет")
        self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_text"])
        self.load_scripts()
        self._load_morphology()
        self._tokenize_book()
        self._word_index = build_word_index(self.lines)
        self._add_omo_from_text()
        self._scan_all_omographs()
        self.filter_scripts()
        self._update_progress_with_time("✓ Обновлено")

    def open_book(self):
        try:
            import sys
            reader = cfg.DEFAULT_SETTINGS.get("book_reader", "")
            if reader:
                subprocess.Popen([reader, str(self.book_file)])
                return
            if sys.platform == "win32":
                os.startfile(str(self.book_file))
            elif sys.platform == "darwin":
                subprocess.Popen(["open", str(self.book_file)])
            else:
                subprocess.Popen(["xdg-open", str(self.book_file)])
        except:
            pass

    def change_directory(self):
        if messagebox.askyesno("Подтверждение", "Сменить рабочую директорию?"):
            self._clear_cache()
            self._undo_manager.clear()
            self._dirty_lines.clear()
            self.occ_counter_var.set("")
            self.dirty_status_var.set("Изменений нет")
            self.dirty_status_label.configure(foreground=cfg.DEFAULT_COLORS["fg_text"])
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
                self._add_omo_from_text()
                self._scan_all_omographs()
                self.filter_scripts()
                self.update_dir_label()
                self.progress_var.set(f"✓ Целевой файл: {self.book_file.name}")


def main():
    root = tk.Tk()
    root.configure(bg=cfg.DEFAULT_COLORS["bg_main"])
    style = ttk.Style()
    style.theme_use("clam")

    # Базовые настройки
    style.configure(
        ".",
        background=cfg.DEFAULT_COLORS["bg_main"],
        foreground=cfg.DEFAULT_COLORS["fg_text"],
        fieldbackground=cfg.DEFAULT_COLORS["bg_text"],
    )
    style.configure("TFrame", background=cfg.DEFAULT_COLORS["bg_main"])
    style.configure("TLabelframe", background=cfg.DEFAULT_COLORS["bg_main"])

    # Метки
    style.configure("TLabel", background=cfg.DEFAULT_COLORS["bg_main"], foreground=cfg.DEFAULT_COLORS["fg_text"])
    style.configure("TLabelframe.Label", background=cfg.DEFAULT_COLORS["bg_main"], foreground=cfg.DEFAULT_COLORS["fg_text"])

    # Кнопки
    style.configure("TButton", background=cfg.DEFAULT_COLORS["bg_button"], foreground=cfg.DEFAULT_COLORS["fg_text"])
    style.map("TButton", background=[("active", cfg.DEFAULT_COLORS["bg_button_active"])])

    # Чекбоксы
    style.configure("TCheckbutton", background=cfg.DEFAULT_COLORS["bg_main"], foreground=cfg.DEFAULT_COLORS["fg_text"])
    style.map("TCheckbutton", background=[("active", cfg.DEFAULT_COLORS["bg_main"])], foreground=[("active", cfg.DEFAULT_COLORS["fg_text"])])

    # Таблицы
    style.configure(
        "Treeview",
        background=cfg.DEFAULT_COLORS["bg_text"],
        foreground=cfg.DEFAULT_COLORS["fg_text"],
        fieldbackground=cfg.DEFAULT_COLORS["bg_text"],
    )
    style.configure(
        "Treeview.Heading",
        background=cfg.DEFAULT_COLORS["bg_main"],
        foreground=cfg.DEFAULT_COLORS["fg_text"],
    )
    style.map(
        "Treeview",
        background=[("selected", cfg.DEFAULT_COLORS["bg_sel_line"])],
        foreground=[("selected", cfg.DEFAULT_COLORS["fg_sel_line"])],
    )

    # Скроллбары
    style.configure(
        "TScrollbar",
        background=cfg.DEFAULT_COLORS["scrollbar_bg"],
        troughcolor=cfg.DEFAULT_COLORS["bg_main"],
        arrowcolor=cfg.DEFAULT_COLORS["fg_text"],
    )
    style.map("TScrollbar", background=[("active", cfg.DEFAULT_COLORS["scrollbar_active"])])

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
