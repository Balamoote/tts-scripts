#!/bin/bash
# Добавить новые шаблоны в tts.txt и отсортировать
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 

#set -e
export LC_COLLATE=C

w2l=gw_wordsin2lexx.list

if [[ -s "$w2l" ]]; then
    cat $w2l >> tts.txt
    sort -u -o tts.txt tts.txt
    printf '\e[36m%s \e[0;93m%s\e[0m\n' "В файл tts.txt добавлено строк:" "$(wc -l $w2l)"
    rm $w2l
else
    printf '\e[36m%s \e[33m%s \e[36m%s \e[93m%s\e[0m\n' "Файл" $w2l "не найден. Запустите" "./addnames.sh"
    exit
fi


