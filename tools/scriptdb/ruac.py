# Оригинал пакета ruaccent тут: https://github.com/Den4ikAI/ruaccent
# Свежая версия данного скрипта тут: https://github.com/Balamoote/tts-scripts/tools/scriptdb/ruac.py

# Для более корректной работы, найдите файл ruaccent.py, поменяйте и дополните так:
# self_normalize_seq="[^a-zA-Z0-9\sа-яА-ЯёЁ—–.,!?:;\"'‘’(){}\[\]«»„“”\\\`_~@#$%^&*=/-]"
# self.normalize = re.compile(fr"{self_normalize_seq}")

# Пример запуска: python ruac.py -cuda book.txt > book_acc.txt

import gzip
import os
import re
import sys
import time
import unicodedata

import onnxruntime as ort  # нужен только для выставления уровня логов
from ruaccent import RUAccent

# Начало отсчета времени
start_time = time.time()

# Параметры ruaccent по умолчанию
use_dictionary = (
    True  # Использовать встроенный словарь однозначных ударений, выключается по -nodic
)
custom_dict = {}  # подгрузить пользовательский словарь однозначных ударений: -dic
device = "CUDA"  # CPU или CUDA
model_name = "turbo3.1"  # название модели
max_length = 1023  # размер чанка

# Параметры скрипта по умолчанию
show_status = 1  # вывод статуса при обработке файла (выключен для stdin), выключить: -nostat или -norep
final_report = 1  # вывод финального отчета, выключить: -norep
plused = 0  # 0 = ста́вить ударе́ния, 1 = ст+авить удар+ения, включить: -plus
save_accent = (
    1  # восстанавливать уже имеющиеся ударения из исходного текста, выключить: -nosave
)
see_no_error = 1  # скрыть дефектные результаты обработки в errata.txt; в конечной строке дефекты устраняются всегда, включить: -errors
onnx_log_lvl = 3  # Настройка лога onnx, может быть нужна, если используем CUDA

ort.set_default_logger_severity(onnx_log_lvl)

# ANSI escape codes для цветного вывода
GREEN = "\033[92m"
YELLOW = "\033[93m"
RESET = "\033[0m"

# Паттерны разделителей
pat_plus = re.compile("[^а-яА-ЯёЁ+\u0320\u0323\u0324\u032d\u0330]+")
pat_acc = re.compile("[^а-яА-ЯёЁ\u0301\u0320\u0323\u0324\u032d\u0330]+")

# Базовая предварительная чистка
# pre_clean = re.compile(r"<[^<>]+>|…")

# Паттетрны для convert_accent
patterns = {
    "apostrophe_to_plus": (
        re.compile(r"([аеёиоуыэюяАЕЁИОУЫЭЮЯ])'"),
        lambda m: f"+{m.group(1)}",
    ),
    "accent_to_plus": (
        re.compile(r"([аеёиоуыэюяАЕЁИОУЫЭЮЯ])\u0301"),
        lambda m: f"+{m.group(1)}",
    ),
    "plus_to_accent": (
        re.compile(r"\+([аеёиоуыэюяАЕЁИОУЫЭЮЯ])"),
        lambda m: f"{m.group(1)}\u0301",
    ),
}

pre_clearns = (
    (re.compile(r'<[^<>"]*("[^"<>]+")[^<>]*>'), lambda m: m.group(1)),
    (re.compile(r"…"), "..."),
    (re.compile(r"<[^<>]*>"), ""),
)


# Универсальная функция для преобразования ударений
def convert_accent(text, conversion_type):
    if conversion_type in patterns:
        pattern, replacement = patterns[conversion_type]
        return pattern.sub(replacement, text)

    return text


# Функция для загрузки custom_dict из файлов dic.gz со строками вида _слово=сло'во
def load_custom_dict(*file_paths):
    #   custom_dict = {}
    for file_path in file_paths:
        with gzip.open(file_path, "rt", encoding="utf-8") as f:
            for lin in f:
                lin = lin.strip()
                if "=" in lin:
                    wrd, accented_word = lin.split("=")
                    wrd = wrd.lstrip("_")
                    if sum(1 for c in wrd if c in "аеёиоуыэюяАЕЁИОУЫЭЮЯ") > 1:
                        custom_dict[wrd] = convert_accent(
                            accented_word, "apostrophe_to_plus"
                        )
    return custom_dict


# Функция patsplit для разделения строки на слова и сепараторы
def patsplit(string, seps_pattern):
    words = seps_pattern.split(string)
    seps = seps_pattern.findall(string)
    if words and len(words[0]) == 0:
        del words[0]

    #   print(words, len(words))
    #   print(seps, len(seps))
    return words, seps


# Функция для разбиения длинных строк
def split_long_line(lin):

    seps_priority = ("[^.][.!?] ", "; ", "... ", ": ", ", ", " ")

    if len(lin) <= max_length:
        return [lin]

    parts = []
    while len(lin) > max_length:
        split_pos = -1
        for punct in seps_priority:
            pos = lin.rfind(punct, 0, max_length)
            if pos != -1:
                split_pos = pos
                break

        if split_pos == -1:
            split_pos = max_length

        parts.append(lin[: split_pos + 1].strip())
        lin = lin[split_pos + 1 :].strip()

    if lin:
        parts.append(lin)

    return parts


def clean_word(wrd):
    word_cleaned = wrd.replace("ё", "е").replace("Ё", "Е").replace("+", "")
    word_cleaned = "".join(
        [
            char
            for char in unicodedata.normalize("NFD", word_cleaned)
            if unicodedata.category(char) != "Mn"
        ]
    )
    return word_cleaned


# Обработка аргументов командной строки
keys_list = []
if "-nodic" in sys.argv:
    keys_list.append("-nodic")
    use_dictionary = False
if "-cust" in sys.argv:
    keys_list.append("-cust")
    cust_index = sys.argv.index("-cust") + 1
    if cust_index < len(sys.argv):
        custom_dict = load_custom_dict(sys.argv[cust_index])
if "-cuda" in sys.argv:
    keys_list.append("-cuda")
    device = "CUDA"
if "-cpu" in sys.argv:
    keys_list.append("-cpu")
    device = "CPU"
if "-plus" in sys.argv:
    keys_list.append("-plus")
    plused = 1
if "-nosave" in sys.argv:
    keys_list.append("-nosave")
    save_accent = 0
if "-errors" in sys.argv:
    keys_list.append("-errors")
    see_no_error = 0
if "-nostat" in sys.argv:
    keys_list.append("-nostat")
    show_status = 0
if "-norep" in sys.argv:
    keys_list.append("-norep")
    show_status = 0
    final_report = 0

# Удаление файла errata.txt перед началом обработки
errata_file_path = "errata.txt"
if os.path.exists(errata_file_path):
    os.remove(errata_file_path)

# Инициализация модели с custom_dict
if plused:
    line_pattern = pat_plus
    acc_seq = re.compile(r"\+")
else:
    line_pattern = pat_acc
    acc_seq = re.compile(r"\u0301")

accentizer = RUAccent()
accentizer.load(
    omograph_model_size=model_name,
    use_dictionary=use_dictionary,
    custom_dict=custom_dict,
    device=device,
    tiny_mode=False,
)

# Чтение текста из файла или stdin
if len(sys.argv) > 1 and sys.argv[-1] not in keys_list:
    filename = sys.argv[-1]
    with open(filename, "r", encoding="utf-8") as f:
        lines = f.readlines()
else:
    lines = sys.stdin.read().splitlines()
    show_status = 0

total_lines = len(lines)

# Обработка текста построчно
for line_num, line in enumerate(lines, start=1):
    line_in = line.rstrip()
    #   line_in = convert_accent(line_in, "plus_to_accent") # Оверкил
    if plused:
        line_in = convert_accent(line_in, "accent_to_plus").lstrip()
        words_orig, seps_orig = patsplit(line_in, pat_plus)
    else:
        words_orig, seps_orig = patsplit(line_in, pat_acc)
        line_in = convert_accent(line_in, "accent_to_plus").lstrip()
    # Чистка тэтов и замены…
    for patt, repl in pre_clearns:
        line_in = re.sub(patt, repl, line_in)

    chunks = split_long_line(line_in)

    # Отправляем текст на обработку
    proc_chunks = [accentizer.process_all(chunk) for chunk in chunks]

    # Собираем строку для повторного разбиения
    proc_line = " ".join(proc_chunks)

    # Преобразование акцентов обратно
    if not plused:
        proc_line = convert_accent(proc_line, "plus_to_accent")

    proc_words, proc_seps = patsplit(proc_line, line_pattern)

    # Корректировка длин массивов сепараторов и слов
    if len(seps_orig) - len(proc_words) == 1:
        proc_words.append("")
    if len(seps_orig) - len(proc_words) == -1:
        seps_orig.insert(0, "")

    # Устранение дефектных результатов обработки
    line_error = 0
    if clean_word(" ".join(words_orig)) != clean_word(" ".join(proc_words)):
        for i, word in enumerate(words_orig):
            line_error = 1
            clean_orig_word = clean_word(word)
            if i < len(proc_words):
                clean_proc_word = clean_word(proc_words[i])
            else:
                clean_proc_word = "[NOENTRY]"
                proc_words.append("")

            # Сравниваем очищенные слова
            if clean_orig_word != clean_proc_word:
                proc_words[i] = word

    # Восстановление исходных ударений из первичной строки и устранением ошибок обработки
    if save_accent:
        if any(acc_seq.search(word) for word in words_orig):
            for i, word in enumerate(words_orig):
                if acc_seq.search(word):
                    proc_words[i] = word

    final_line = "".join([sep + word for sep, word in zip(seps_orig, proc_words)])

    if line_error:
        with open(errata_file_path, "a", encoding="utf-8") as errata_file:
            errata_file.write(f"<line: {line_num}> {line}")
            if not see_no_error:
                errata_file.write(f"<out : {line_num}> {final_line}\n{'-' * 20}\n")

    # Вывод строки
    sys.stdout.write(final_line + "\n")

    # Статус обработки -- только при обработке файла, но не потока
    if show_status:
        elapsed_time = time.time() - start_time
        sys.stderr.write(
            f"\r{GREEN}Запуск:{RESET} {YELLOW}{time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(start_time))}{RESET} "
            f"{GREEN}Прошло:{RESET} {YELLOW}{int(elapsed_time // 3600):02}:{int((elapsed_time % 3600) // 60):02}:{int(elapsed_time % 60):02}{RESET} "
            f"{GREEN}Текущая строка:{RESET} {YELLOW}{line_num}{RESET} {GREEN}из{RESET} {YELLOW}{total_lines}{RESET} "
        )
        sys.stderr.flush()

# Финальная строка после завершения обработки
if final_report:
    elapsed_time = time.time() - start_time
    sys.stderr.write(
        f"\r"
        f"\r{GREEN}Запуск:{RESET} {YELLOW}{time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(start_time))}{RESET} "
        f"{GREEN}Обработка:{RESET} {YELLOW}{int(elapsed_time // 3600):02}:{int((elapsed_time % 3600) // 60):02}:{int(elapsed_time % 60):02}{RESET} "
        f"{GREEN}Всего строк:{RESET} {YELLOW}{line_num}{RESET}".ljust(80) + "\n"
    )
