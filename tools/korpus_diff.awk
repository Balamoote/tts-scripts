#!/usr/bin/gawk -f
# Разбор diff для анализа омографов
# Использование: diff эталон.txt результат.txt | gawk -f korpus_diff.awk
# Конфигурация омографа задаётся в блоке CONFIG ниже

BEGIN {
    # ====== CONFIG: меняйте только здесь ======
    base = "все"           # неразмеченная форма (нижний регистр)
    forms[1] = "все́"      # размеченные формы (нижний регистр)
    forms[2] = "всё"
    form_count = 2
    # ==========================================

    # Генерируем все регистровые варианты в нижнем регистре для сравнения
    # (сравнивать будем после tolower)
    delete base_variants
    delete marked_variants
    
    # Варианты неразмеченной формы
    base_variants[base] = 1
    
    # Варианты размеченных форм
    for (i = 1; i <= form_count; i++) {
        marked_variants[forms[i]] = 1
    }

    unprocessed_file = base "_unproc.txt"
    errors_file = base "_errors.txt"
    
    # Цвета
    green = "\033[32m"
    yellow = "\033[93m"
    reset = "\033[0m"
    
    # Очищаем файлы
    printf "" > unprocessed_file
    close(unprocessed_file)
    printf "" > errors_file
    close(errors_file)
    
    unproc_count = 0
    errors_count = 0
}

# Пропускаем контекстные строки и служебные
/^ /  { next }
/^---/ { next }

# Заголовок блока diff
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
    
    # Формируем строку форм
    forms_str = ""
    for (i = 1; i <= form_count; i++) {
        forms_str = (i == 1 ? forms[i] : forms_str " " forms[i])
    }
    
    # Длины без цветов
    label1 = "Омограф:"
    label2 = "Пропуск:"
    label3 = "Ошибки:"
    max_label = length(label1)
    if (length(label2) > max_label) max_label = length(label2)
    if (length(label3) > max_label) max_label = length(label3)
    
    val1 = base
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

# Токенизация строки: возвращает массив токенов
function tokenize(line, tokens,   n, i) {
    n = patsplit(line, arr, /[а-яА-ЯёЁ\xcc\x81]+/)
    for (i = 1; i <= n; i++) {
        tokens[i] = tolower(arr[i])
    }
    return n
}

# Проверяет, является ли токен одним из вариантов омографа
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
        
        has_proc = 0  # есть пропуск
        has_err = 0   # есть ошибка
        
        # Проходим по токенам эталона
        for (j = 1; j <= ref_tok_count; j++) {
            # Пропускаем неразмеченные формы в эталоне
            if (!is_marked(ref_tokens[j])) continue
            
            # Если в работе на этой позиции нет токена — пропускаем
            if (j > work_tok_count) continue
            
            # Если в работе неразмеченная форма — пропуск
            if (is_base(work_tokens[j])) {
                has_proc = 1
            }
            # Если в работе размеченная, но другая — ошибка
            else if (is_marked(work_tokens[j])) {
                if (ref_tokens[j] != work_tokens[j]) {
                    has_err = 1
                }
            }
            # Если в работе что-то другое — пропускаем (не анализируем)
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
