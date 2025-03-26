#!/bin/bash
# Добавить новые слова в базы: основной и оверрайда
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 

#set -e
export LC_COLLATE=C
key="$1"

aux="scriptaux"
sdb="scriptdb"

# Функции

grp2namebase () { grep "g$" "$1" | grep "'" | grep -v \" | sed -r "s/''/'/g; s/=g//g" | gzip; }

grp2override () { grep "g$" "$1" | grep "'" |\
                  sed -r "s/''/'/g
                          s/^_.+=(.+)'(.*)=g$/_\1\2=\1'\2=g/g
                          s/(_[^=]*[аяеэиыоёуюь])[ьъ]/\1/g" | gzip; }

grp2lexx ()  { grep -v "^_" "$1" | grep "'" | grep -v "[=g]$" | sed -r "s/''/'/g"; }

grp2process  () { sed -r "s/''/'/g
                          s/([^_]=[^=]*[аяеэиыоёуюь'])ь/\1\\\xcc\\\xa3/g
                          s/([^_]=[^=]*[аяеэиыоёуюь'])ъ/\1\\\xcc\\\xa4/g
                          s/ъ=g/\\\xcc\\\xa4=g/g" <(zcat "$1") | sort -u | gzip > "$1.tmp"; mv -f "$1.tmp" "$1"; } 

# Если в файлах 00-02 строка имеет: (1) "_" в начале строки, (2) "'" (ударение), (3) "g" в конце строки (00 по умолчанию её НЕ имеет), то записать строку в namebase
grp2namebase 00_wrd_newdic_nl_*.list >> $sdb/namebase.gz
grp2namebase 01_nom_newsur_nl_*.list >> $sdb/namebase.gz
grp2namebase 02_nom_newany_nl_*.list >> $sdb/namebase.gz
# Если файлы 03-10 строка имеет "g" в конце строки, то записать в nameoverride (запись должна иметь служебный символ ИЛИ новое ударение ДО ударения по словарю lexx
#grp2override 03_nom_surlex_dq_*.list >> $sdb/nameoverride.gz
#grp2override 04_nom_surlex_si_*.list >> $sdb/nameoverride.gz
#grp2override 05_nom_anylex_dq_*.list >> $sdb/nameoverride.gz
#grp2override 06_nom_anylex_si_*.list >> $sdb/nameoverride.gz
#grp2override 07_nom_surbas_dq_*.list >> $sdb/nameoverride.gz
#grp2override 08_nom_surbas_si_*.list >> $sdb/nameoverride.gz
#grp2override 09_nom_anybas_dq_*.list >> $sdb/nameoverride.gz
#grp2override 10_nom_anybas_si_*.list >> $sdb/nameoverride.gz
# Если строка в 00-02 НЕ имеет "_" в начале строки, записать в файл "кандидатов в lexx" 
grp2lexx 00_wrd_newdic_nl*.list >> gw_wordsin2lexx.list
grp2lexx 01_nom_newsur_nl*.list >> gw_wordsin2lexx.list
grp2lexx 02_nom_newany_nl*.list >> gw_wordsin2lexx.list

# Обработать базы имён и заменить служебные символы
grp2process $sdb/namebase.gz
#grp2process $sdb/nameoverride.gz

sort -u -o gw_wordsin2lexx.list gw_wordsin2lexx.list

printf '\e[32m%s\e[0m\n' "Имена добавлены в базы."

if [ -s gw_wordsin2lexx.list ]; then
    printf '\e[32m%s \e[0;93m%s\n' "Строк для добавления в lexx:" $(wc -l < gw_wordsin2lexx.list)
    if [[ $key != "-a" ]]; then printf '\e[32m%s \e[93m%s\e[0m\n' "Запустите" "./add2lexx.sh"; fi
else
    printf '\e[33m%s\e[0m\n' "Строк для добавления в lexx не найдено."
    rm gw_wordsin2lexx.list
    key=""
fi

if [[ $key = "-a" ]]; then
    ./add2lexx.sh
    ./check-lexx.sh
fi

