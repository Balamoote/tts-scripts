#!/bin/bash
#
# Скрипт для запуска тренировки модели омографов
#
# Использование:
#   ./train.sh                        # обучение с параметрами в этом файле
#   ./train.sh conf/x1111.conf        # обучение из конфига
#   ./train.sh conf/                  # пакетная обработка всех конфигов
#

ms2sec () { awk -vms=$duration 'BEGIN {
                   D=int(ms/86400); Dr=ms%86400; if(D) { D=D " д " } else { D="" };
                   H=int(Dr/3600);  Hr=Dr%3600;  if(H) { Hs=sprintf("%d", H) ":" } else { Hs="" };
                   M=int(Hr/60);    Mr=Hr%60;    if(M) { if(H) {Ms=sprintf("%02d", M) ":"} else {Ms=sprintf("%d", M) ":" } } else { Ms="" };
                   if(M>=1) {S=sprintf("%05.2f %s", Mr, ".") } else { S=sprintf("%.2f %s", Mr, "сек.") };
                   durhum=D Hs Ms S; printf("%s", durhum) }'; }

RPATH="../../"
source .train/bin/activate

# ============================================================
# ПАРАМЕТРЫ ПО УМОЛЧАНИЮ
# ============================================================

# Директория с конфигурациями
CONF_DIR="train/conf"

# Локальные словари
locdic=1
sdb="scriptdb"

# Общие настройки
EXPORT_SEMANTIC=0
SAVE_REPORT=0
REPORT_FILE="train/history.txt"
SEMANTIC_DIR="train/semantic"

# ============================================================
# ПАРАМЕТРЫ ОБУЧЕНИЯ (ПО УМОЛЧАНИЮ)
# ============================================================

GROUP="x1111"
WORD=""
MODE="word"
KORPUS_FILE="все1020_q.txt"
WINDOW=10
MIN_LENGTH=2
C=10.0
CONFIDENCE=0.95
ERROR_FILE=""
SEMANTIC_FILE=""
GRID_SEARCH=0
C_VALUES="0.5 1.0 2.0 5.0 10.0"
WINDOW_VALUES="5 8 10 12 15"

# ============================================================
# ФУНКЦИЯ: загрузка конфига
# ============================================================

load_config() {
    local CONF_FILE=$1
    
    if [ -f "$CONF_FILE" ]; then
        echo "Загрузка конфига: $CONF_FILE"
        source "$CONF_FILE"
    else
        echo "❌ Конфиг не найден: $CONF_FILE"
        exit 1
    fi
}

# ============================================================
# ФУНКЦИЯ: подготовка локальных словарей
# ============================================================

prepare_dictionaries() {
    if [[ $locdic != "1" ]]; then
        return
    fi
    
    bookstadir="tran-${KORPUS_FILE}.stat"
    
    if md5sum -c --status "$bookstadir"/train.md5 >/dev/null 2>&1; then
        locdicsize=$(cat "$bookstadir"/bookwords.list 2>/dev/null | wc -l)
        printf '\e[36mСловари \e[33m%s \e[36mготовы: \e[93m%s\e[0m словоформ\n' "$bookstadir" "$locdicsize"
        return
    fi
    
    echo "Создание локальных словарей для $KORPUS_FILE..."
    
    rm -rf "$bookstadir"
    mkdir "$bookstadir"
    cp "$KORPUS_FILE" "$bookstadir/text-book.txt"
    
    # Переменные алфавита
    RUUC="АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
    rulc="абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    unxc=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")
    
    # Список слов
    sed -r 's/^/ /g' "$bookstadir/text-book.txt" | grep -Eo "[$RUUC$rulc$unxc-]+" |\
      sed -r "s/[$unxc]+//g; s/^.*$/\L\0/g; s/ё/е/g; s/^.*$/_\0=/g" |\
      sort -u > "$bookstadir/bookwords.list"
    
    if command -v pigz >/dev/null 2>&1; then zipper="pigz"; else zipper="gzip"; fi
    
    # Создаем локальные словари
    for dic in dic_gl dic_prl dic_prq dic_rest dic_suw dic_prop; do
        grep -Ff "$bookstadir/bookwords.list" <(zcat $sdb/$dic.gz | sed -r "s/^([^ ]+)/_\1=/") |\
          sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir/$dic.gz"
    done
    
    grep -Ff "$bookstadir/bookwords.list" <(zcat $sdb/namebase.gz) | $zipper > "$bookstadir/namebase.gz"
    
    md5sum "$bookstadir/bookwords.list" $sdb/dic_*.gz "$bookstadir"/dic_*.gz \
           "$bookstadir/text-book.txt" "$KORPUS_FILE" > "$bookstadir/train.md5"
    
    locdicsize=$(wc -l < "$bookstadir/bookwords.list")
    echo "Готово: $locdicsize словоформ"
}

# ============================================================
# ФУНКЦИЯ: обучение
# ============================================================

run_training() {
    echo ""
    echo "============================================================"
    echo "ОБУЧЕНИЕ: $GROUP / ${WORD:-<группа>}"
    echo "============================================================"
    echo "Корпус:  $KORPUS_FILE"
    echo "Окно:    $WINDOW"
    echo "C:       $C"
    echo "Порог:   $CONFIDENCE"
    echo ""
    
    if [[ -n $WORD ]]; then SUFF="_$WORD"; else SUFF=""; fi
    
    TRAIN_FILE=$RPATH$KORPUS_FILE
    OUTPUT_FILE=$RPATH"scriptdb/xmd/xmods/$GROUP$SUFF.pkl.gz"
    
    # Подготовка словарей
    prepare_dictionaries
    
    # Grid Search
    if [ "$GRID_SEARCH" = "1" ]; then
        echo "=== GRID SEARCH ==="
        GS_DICT_OPT=""
        [[ $locdic == "1" && -d "$bookstadir" ]] && GS_DICT_OPT="--dict-dir $RPATH$bookstadir"
        
        (cd scriptdb/xmd && python3 grid_search.py \
            --group $GROUP \
            --train $TRAIN_FILE \
            --C $C_VALUES \
            --window $WINDOW_VALUES \
            $GS_DICT_OPT)
        
        return $?
    fi
    
    # Обычное обучение
    CMD="python3 train.py --group $GROUP"
    [[ -n $WORD ]] && CMD="$CMD --word $WORD"
    CMD="$CMD --mode $MODE --train $TRAIN_FILE --output $OUTPUT_FILE"
    CMD="$CMD --window $WINDOW --min-length $MIN_LENGTH --C $C --confidence $CONFIDENCE"
    [[ -n $SEMANTIC_FILE ]] && CMD="$CMD --semantic-file $RPATH$SEMANTIC_FILE"
    [[ $locdic == "1" && -d "$bookstadir" ]] && CMD="$CMD --dict-dir $RPATH$bookstadir"
    
    # Обработка ошибок
    if [ -n "$ERROR_FILE" ]; then
        (cd scriptdb/xmd && python3 parse_error_report.py \
            --report "$RPATH$ERROR_FILE" \
            --train "$TRAIN_FILE" \
            --homograph "${WORD:-$GROUP}")
    fi
    
    echo "Команда: cd scriptdb/xmd && $CMD"
    echo ""
    
    (cd scriptdb/xmd && $CMD)
    EXIT_CODE=$?
    
    # Экспорт семантики
    if [ "$EXPORT_SEMANTIC" = "1" ] && [ $EXIT_CODE -eq 0 ]; then
        mkdir -p "$SEMANTIC_DIR"
        (cd scriptdb/xmd && python3 export_semantic.py \
            --model "$OUTPUT_FILE" \
            --output "$RPATH$SEMANTIC_DIR/$GROUP$SUFF.txt")
    fi
    
    # Отчёт
    if [ "$SAVE_REPORT" = "1" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') | $GROUP | ${WORD:-group} | w=$WINDOW | c=$C | conf=$CONFIDENCE | $OUTPUT_FILE" >> "$REPORT_FILE"
    fi
    
    echo ""
    [ $EXIT_CODE -eq 0 ] && echo "✅ Успешно" || echo "❌ Ошибка: $EXIT_CODE"
    
    return $EXIT_CODE
}

# ============================================================
# ЗАПУСК
# ============================================================

if [ $# -gt 0 ]; then
    # Конфиг или директория
    CONF_PATH="$1"
    
    if [ -d "$CONF_PATH" ]; then
        # Все конфиги из директории
        for CONF_FILE in "$CONF_PATH"/*.conf; do
            [ -f "$CONF_FILE" ] || continue
            load_config "$CONF_FILE"
            run_training
        done
    elif [ -f "$CONF_PATH" ]; then
        # Один конфиг
        load_config "$CONF_PATH"
        run_training
    else
        echo "❌ Не найден: $CONF_PATH"
        exit 1
    fi
else
    # Без конфига — используем параметры по умолчанию
    run_training
fi

EXIT_CODE=$?
deactivate
exit $EXIT_CODE
