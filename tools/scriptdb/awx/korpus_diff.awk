#!/usr/bin/gawk -f
# Разбор diff для анализа омографов (PATCH-251: параметризация).
#
# Использование:
#   diff эталон.txt вывод.txt | gawk -v group=x1111 -v homo=все -f korpus_diff.awk
#   diff эталон.txt вывод.txt | gawk -v group=x4707 -f korpus_diff.awk
#
# Параметры (все опциональны):
#   -v group=ID    группа омографа (по умолчанию x1111);
#   -v homo=СЛОВО  конкретная словоформа группы (по умолчанию — вся группа);
#   -v automo=ПУТЬ путь к automo(.gz) (по умолчанию scriptdb/automo.gz);
#   -v stem=ИМЯ    префикс выходных файлов (по умолчанию homo или group).
#
# Значение омографа берётся из automo.gz/class.list.gz —
# те же данные, что использует analyze.py.

BEGIN {
    if (group == "") group = "x1111"
    if (automo == "") automo = "scriptdb/automo.gz"
    homo_base = (homo != "" ? normalize_form(homo) : "")

    # Читаем варианты группы из automo.
    cmd = (automo ~ /\.gz$/) ? ("zcat " automo) : ("cat " automo)
    form_count = 0
    while ((cmd | getline ln) > 0) {
        n = split(ln, f, /[ \t]+/)
        if (n < 4) continue
        if (f[1] != group) continue
        if (homo_base != "" && f[2] != homo_base) continue
        bv = tolower(normalize_form(f[2]))
        mv = tolower(accent_convert(f[4]))
        if (!(bv in base_variants)) base_variants[bv] = 1
        if (!(mv in marked_variants)) {
            marked_variants[mv] = 1
            form_count++
            forms[form_count] = mv
        }
    }
    close(cmd)

    # Имя выходных файлов.
    if (stem == "") {
        stem = (homo_base != "" ? homo_base : group)
    }
    unprocessed_file = stem "_unproc.txt"
    errors_file = stem "_errors.txt"

    # Цвета.
    green = "\033[32m"
    yellow = "\033[93m"
    reset = "\033[0m"

    printf "" > unprocessed_file
    close(unprocessed_file)
    printf "" > errors_file
    close(errors_file)

    unproc_count = 0
    errors_count = 0
}

/^ /  { next }
/^---/ { next }

/^[0-9]/ {
    process_block()
    delete ref_lines
    delete work_lines
    ref_count = 0
    work_count = 0
    next
}

/^</ {
    ref_lines[ref_count++] = substr($0, 3)
    next
}

/^>/ {
    work_lines[work_count++] = substr($0, 3)
    next
}

END {
    process_block()

    forms_str = ""
    for (i = 1; i <= form_count; i++) {
        forms_str = (i == 1 ? forms[i] : forms_str " " forms[i])
    }
    if (forms_str == "") forms_str = "(нет данных в automo)"

    label1 = "Омограф:"
    label2 = "Пропуск:"
    label3 = "Ошибки:"
    max_label = length(label1)
    if (length(label2) > max_label) max_label = length(label2)
    if (length(label3) > max_label) max_label = length(label3)

    val1 = (homo_base != "" ? homo_base : group)
    val2 = sprintf("%d", unproc_count)
    val3 = sprintf("%d", errors_count)
    max_val1 = length(val1)
    if (length(val2) > max_val1) max_val1 = length(val2)
    if (length(val3) > max_val1) max_val1 = length(val3)

    hdr1 = "Формы:"
    hdr2 = "Файл:"
    hdr3 = "Файл:"
    max_hdr = length(hdr1)
    if (length(hdr2) > max_hdr) max_hdr = length(hdr2)
    if (length(hdr3) > max_hdr) max_hdr = length(hdr3)

    col1_w = max_label
    col2_w = max_val1
    col3_w = max_hdr

    line1 = green label1 reset sprintf("%*s", col1_w - length(label1), "") " " \
            yellow val1 reset sprintf("%*s", col2_w - length(val1), "") " " \
            green hdr1 reset sprintf("%*s", col3_w - length(hdr1), "") " " \
            yellow forms_str reset
    print line1

    line2 = green label2 reset sprintf("%*s", col1_w - length(label2), "") " " \
            yellow val2 reset sprintf("%*s", col2_w - length(val2), "") " " \
            green hdr2 reset sprintf("%*s", col3_w - length(hdr2), "") " " \
            yellow unprocessed_file reset
    print line2

    line3 = green label3 reset sprintf("%*s", col1_w - length(label3), "") " " \
            yellow val3 reset sprintf("%*s", col2_w - length(val3), "") " " \
            green hdr3 reset sprintf("%*s", col3_w - length(hdr3), "") " " \
            yellow errors_file reset
    print line3
}

# Апостроф-ударение (automo) → комбинирующий U+0301.
function accent_convert(s,   r, i, ch) {
    r = ""
    for (i = 1; i <= length(s); i++) {
        ch = substr(s, i, 1)
        if (ch == "'") r = r "\314\201"
        else r = r ch
    }
    return r
}

# Нормализация базовой (неразмеченной) формы: убрать ударения, ё → е.
function normalize_form(s,   r) {
    r = s
    gsub(/[\314\200-\314\277]/, "", r)
    gsub(/ё/, "е", r)
    gsub(/Ё/, "е", r)
    return r
}

# Токенизация: слова с комбинирующими ударениями.
function tokenize(line, tokens,   n, i) {
    n = patsplit(line, arr, /[а-яА-ЯёЁ\314\200-\314\277]+/)
    for (i = 1; i <= n; i++) {
        tokens[i] = tolower(arr[i])
    }
    return n
}

function is_base(token) {
    return (token in base_variants)
}

function is_marked(token) {
    return (token in marked_variants)
}

function process_block(   n, i, ref_line, work_line, ref_tokens, work_tokens,
                          ref_tok_count, work_tok_count, j, has_proc, has_err) {
    n = (ref_count > work_count ? ref_count : work_count)
    for (i = 0; i < n; i++) {
        ref_line = (i < ref_count ? ref_lines[i] : "")
        work_line = (i < work_count ? work_lines[i] : "")

        if (ref_line == "" || work_line == "") continue

        delete ref_tokens
        delete work_tokens
        ref_tok_count = tokenize(ref_line, ref_tokens)
        work_tok_count = tokenize(work_line, work_tokens)

        has_proc = 0
        has_err = 0

        for (j = 1; j <= ref_tok_count; j++) {
            if (!is_marked(ref_tokens[j])) continue
            if (j > work_tok_count) continue
            if (is_base(work_tokens[j])) {
                has_proc = 1
            } else if (is_marked(work_tokens[j])) {
                if (ref_tokens[j] != work_tokens[j]) {
                    has_err = 1
                }
            }
        }

        if (has_proc) {
            print ref_line >> unprocessed_file
            print work_line >> unprocessed_file
            print "" >> unprocessed_file
            unproc_count++
        }
        if (has_err) {
            print ref_line >> errors_file
            print work_line >> errors_file
            print "" >> errors_file
            errors_count++
        }
    }
}
