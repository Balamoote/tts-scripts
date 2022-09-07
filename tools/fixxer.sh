#!/bin/bash
# Скрипт для коррекции ошибок используемого движка
# Использование: ./fixxer book.fb2 или ./fixxer.sh -gtts book.fb2
# Поддерживаемые движки:
# 1) gtts: ключ -gtts -- ключ по умолчанию

#set -e
export LC_COLLATE=C
gw_time0=$(date +%s.%N); gw_prev=$gw_time0;
key="$1"
book="$2"
suf=fix
tts_engine="-gtts" # дефолтный tts движок
 stream_ed="sed"
#stream_ed="perl"

zip_result=1       # упаковать в zip результат обработки

aux="scriptaux"
sdb="scriptdb"

printf '\e[32m%s \e[32;4;1m%s\e[0m\n' "Скрипт" "\"Исправление ошибок tts-движка\""

if [[ -f "$1" && -s "$1" ]]; then
  book="$1"; key=$tts_engine;
  printf '\e[33m%s \e[93m%s\e[0m\n' "Ключи не заданы, но книга указана. Используем ключ по умолчанию:" $tts_engine
elif [[ -s "$2" ]]; then printf '\e[33m%s \e[93m%s\e[0m\n' "Обрабатывается книга:" "$book"
else printf '\e[33m%s \e[93m%s\e[0m\n' "Книга не задана или не существует. Использование:" "./fixxer.sh [ключ] book.fb2"; exit 1; fi

wrkdir=_fix-"$book"
stadir=_fix-"$book".stat
backup="$book".$suf

do_parallel=1     # включить GNU Parallel. ВНИМАНИЕ: подобрать параметры по реальной производительности
   par_gtts=1     # включить GNU Parallel для применения словаря коррекций gtts.
   pblock_a=500K  # awk: размер куска текста на 1 задачу: постфиксы K, M, G, T, P, k, m, g, t, p. "-1" = авто
   pblock_s=-1    # sed: размер куска текста на 1 задачу: постфиксы K, M, G, T, P, k, m, g, t, p. "-1" = авто
   pjobs=8        # задать макс. кол-во задач. 100% = кол-ву потоков (threads). 4 = 4 задачи. Подсказка: $ parallel --number-of-cores
   pload=200%     # макс загрузка отдельного процессора: вывод $ parallel --number-of-threads делённый на $ parallel --number-of-cores : 16/8 = 2 * 100% = 200%
   pmem=1G        # мин. память, перед началом следующей задачи, если памяти менее 50% от значения, завершить самую свежую задачу.
   pnice=0        # приоритет

   paraopts_sed="--jobs=$pjobs --load=$pload --block=$pblock_s --memfree $pmem --nice=$pnice --noswap --pipe-part -ka"


inc=50 # Количество строк для для обработки файла за один проход для скриптов sed

d2u () { if [[ -e "$backup" ]]; then printf '\e[36m%s \e[33m%s\e[0m\n' "Найден и восстановлен бэкап:" "$backup"; crlf=$(file $backup | grep -o "CRLF"; );
            if [[ -n $crlf ]]; then dos2unix "$backup" &>/dev/null; fi; cp "$backup" "$book";
        else crlf=$(file "$book" | grep -o "CRLF"); if [[ -n $crlf ]]; then dos2unix "$book" &>/dev/null; fi; cp "$book" "$backup"; fi; }

sedroll () { local lico=$(wc -l < "$1"); local i=0; local j=0; for i in $(seq 1 $inc $lico); do j=$(($i+$(($inc-1)))); sed -i -rf <(sed -n "$i,$j p" < "$1") "$2"; done; }

ms2sec () { awk -vms=$duration 'BEGIN {
                   D=int(ms/86400); Dr=ms%86400; if(D) { D=D " д " } else { D="" };
                   H=int(Dr/3600);  Hr=Dr%3600;  if(H) { Hs=sprintf("%d", H) ":" } else { Hs="" };
                   M=int(Hr/60);    Mr=Hr%60;    if(M) { if(H) {Ms=sprintf("%02d", M) ":"} else {Ms=sprintf("%d", M) ":" } } else { Ms="" };
                   if(M>=1) {S=sprintf("%05.2f %s", Mr, ".") } else { S=sprintf("%.2f %s", Mr, "сек.") };
                   durhum=D Hs Ms S; printf("%s", durhum) }'; }

d2u # Создать или восстановить бэкап

case $key in 
 -gtts) # Применить словарь коррекция для gtts к тексту с уже проставленными ударениями
    gtts=1 ;; #if [[ -d "$wrkdir" ]]; then rm -rf "$wrkdir"; mkdir "$wrkdir"; else mkdir "$wrkdir"; fi ;;
 *) # Нечто другое
    printf '\e[32m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n' "Задайте ключ или книгу. Например:" "./fixer.sh -gtts book.fb2" "или" "./fixer.fb2 book.fb2"; exit 0 ;;
esac

# Создать директорию статических файлов для текущей книги
if md5sum -c --status "$stadir"/book.md5 >/dev/null 2>&1; then book_ok=1
else
  rm -rf "$stadir"; mkdir "$stadir";
  sed "/<binary/Q" "$book" > "$stadir"/text-book.txt
  sed -n '/<binary/,$p' "$book" > "$stadir"/binary-book.txt

 md5sum "$backup" "$stadir"/text-book.txt "$stadir"/binary-book.txt > "$stadir"/book.md5;

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Подготовка stat файлов:" $duration "сек"
fi;

# Применяем словари ударений
if [[ $gtts -eq 1 ]] && [[ $stream_ed == "sed" ]]; then # Применить словарь коррекциия gtts
 printf '\e[36m%s\e[0m ' "Коррекция ошибок движка gtts …"
 rexsed="slexx/gtts_auto.sed"

 if md5sum -c --status slexx/gtts.md5 >/dev/null 2>&1; then gtts_ok=1
 else
    sed -rf slexx/sed_args.sed slexx/gtts_ini.sed > slexx/gtts_auto.sed
    md5sum slexx/sed_args.sed slexx/gtts_ini.sed slexx/gtts_auto.sed > slexx/gtts.md5;
 fi;

 if [[ $do_parallel -eq 1 && $par_gtts -eq 1 ]]; then
    parallel --env $paraopts_sed "$stadir"/text-book.txt sed -rf $rexsed > "$stadir"/text-book.tmp
 else
    cp "$stadir"/text-book.txt "$stadir"/text-book.tmp
    sedroll $rexsed "$stadir"/text-book.tmp
 fi
fi;

#if [[ $gtts -eq 1 ]] && [[ $stream_ed == "perl" ]]; then # Применить словарь коррекциия gtts
#  printf '\e[36m%s\e[0m ' "Коррекция ошибок движка gtts …"
#  rexsed="slexx/gtts2.pl"
#  if [[ $do_parallel -eq 1 && $par_gtts -eq 1 ]]; then
#    parallel --env $paraopts_sed "$stadir"/text-book.txt sed -rf $rexsed > "$wrkdir"/text-book.txt
#  else
##   cp "$stadir"/text-book.txt "$wrkdir"/text-book.txt
#    perl $rexsed "$stadir"/text-book.txt > "$wrkdir"/text-book.txt
#  fi
#fi;

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "выполнена за" $duration "сек"

# Возвращаем графику назад
cat "$stadir"/text-book.tmp "$stadir"/binary-book.txt > "$book" && rm "$stadir"/text-book.tmp

if [[ $zip_result -eq 1 ]]; then # zip рузультат
  bookzip="$book"".zip"
  if [[ -f "$bookzip" ]]; then rm "$bookzip"; fi
  zip -o "$bookzip" "$book" >/dev/null 2>&1
fi;

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); tot_dur=$( echo $gw_cur - $gw_time0 | bc )

LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Общее время работы скрипта коррекции:" $tot_dur "сек"
printf '\e[32;4;1m%s\e[0m \e[32m%s \e[33m%s \e[32m%s \e[36m%s \e[33m%s\e[0m' "\"Fixxer:\"" "Книга" "$book" "обработана." "Бэкап:" "$backup"
if [[ -s "$bookzip" ]]; then printf ' \e[36m%s \e[33m%s\e[0m\n' "ZIP результата:" "$bookzip"; else echo ""; fi;

