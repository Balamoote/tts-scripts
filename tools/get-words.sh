#!/bin/bash
# Скрипт сбора новых слов и простановки ударений в именах собственных; генерирует списки-отчёты слов для ручной обработки
# Актуальная расшифровка ключей ниже в блоке case $key in.

# ручная обработка имён-омографов через дискретные скрипты работает только с установленным плагинами vim:
# 1) vim-ingo-library, брать тут https://github.com/inkarkat/vim-ingo-library
# 2) vim-PatternsOnText, брать тут https://github.com/inkarkat/vim-PatternsOnText

# Обязательно: после завершения обработки каждого файла нужно выполнить следующую последовательность команд:
# ./addname.sh -a (или ./addname.sh, затем ./add2lexx.sh, затем ./check-all.sh) - это внесёт изменения в базы

# Файлы-списки вида 01_nom_surlex_234.list имею имена, которые состоят из нескольких элементов:
# 1) 2 цифры в начале названия - порядковый номер. Предпочтительно обрабатывать их в этом порядке.
# 2) wrd - слово в нижнем регистре, кандидат на внесение в словарь ударений и/или лексики
# 3) nom - слово, встреченное с начальной буквой в верхнем регистре, возможно - имя собственное.
# 4) new - слово не найдено ни в одной базе удерений, возможный кандидат на включение либо в словарь лексики, либо в базы имён. 
# 5) sur - слова с Заглавной, которые были найдены в середине предложения, скорее всего имена
# 6) any - (от any - "любой"), слова с Заглавной, которые были найдены НЕ в середине предложения, могут быть именами
# 7) bas - слово содержится в базовом проверочном словаре unistress, не содержится в базе омографов
# 8) nam - слово содержится в базе имён, не омограф
# 9) lex - (от double quotes = двойные кавычки) слово обработано шаблоном с кавычками, т.е. срабатывание на начальную часть слова
# 99) перед суффиксом отчётов ".list" указано количество строк/слов в данном файле.

# После завершения работы на файлами *.list можно запустить скрипт обработки книги ./all-in-one.sh с ключом по вкусу или просто
# ./get-words.sh -gg book.fb2

# Имена собственные, являющиеся также омографами выделены для ручной обработки отдельно в виде набора скриптов в папке nomo-book.fb2

# Подробности см. в файлах README стандартной поставки (может быть устаревшим).

# При добавлении ключа -ld скрипт формирует частный словарь для обрабатываемой книги. Например:
# Команда ./get-words.sh -ld book.fb2 : обработает книгу и ДОПОЛНИТЕЛЬНО сформирует частный словарь book.fb2.lexx
# Команда ./get-words.sh -old book.fb2 : сформирует ТОЛЬКО частный словарь book.fb2.lexx
# При обработке больших списков имён, можно отключить часть операций ключом -bl
# При обработке очень больших файлов с текстом, можно использовать ключ -wo, чтобы только собрать слова, но не расставлять ударения.

# Книга должна быть в кодировке UTF-8
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 
# Для работы модуля дискретных скриптов обработки именных омографов в nomo-$book нужны следующие плагины vim
# 1) https://github.com/inkarkat/vim-PatternsOnText
# 2) https://github.com/inkarkat/vim-ingo-library (чтобы работал п. 1)
# модуль для ручной работы с омографами идентичен для скриптов get-words.sh (имена), yofik.sh (ёфикатор), momo.sh (омографы)
#set -e
export LC_COLLATE=C
gw_time0=$(date +%s.%N); gw_prev=$gw_time0;
key="$1"
book="$2"
suf=nam

aux="scriptaux"
sdb="scriptdb"

# Переменные обработаки текста по умолчанию
preview=1; nama=0; dixa=0;

printf '\e[32m%s \e[32;4;1m%s\e[0m\n' "Скрипт" "\"Имена\""

if [[ -f "$1" ]] && [[ -s "$1" ]]; then
  book=$1; 
  if [[ -d nomo-"$book" ]]; then
         key="-n"; printf '\e[33m%s \e[93m%s\e[0m\n' "Найдена директория nomo. Используем ключ:" "-n";
    else
         key="-gg"; printf '\e[33m%s \e[93m%s\e[0m\n' "Ключи не заданы, но книга указана. Директория nomo не найдена. Используем ключ:" "-gg"
  fi
elif [[ -s "$2" ]]; then printf '\e[33m%s \e[93m%s\e[0m\n' "Обрабатывается книга:" "$book"
else printf '\e[33m%s \e[93m%s\e[0m\n' "Книга не задана или не существует. Использование:" "./get-words.sh [ключ] book.fb2"; exit 1; fi

wrkdir=nomo-"$book"
stadir=nomo-"$book".stat
backup="$book".$suf

# Установка редактора: vim или neovim
edi=$(sed -rn 's/^\s*editor\s*=\s*(vim|nvim)\s*$/\1/ p' $sdb/settings.ini)
if command -v pigz >/dev/null 2>&1; then zipper="pigz"; else zipper="gzip"; fi

# Установка корректировки ширины вывода превью в дискретных скриптах
termcor=$(sed -rn 's/^\s*termcorrection\s*=\s*([-0-9]*)\s*$/\1/ p' $sdb/settings.ini)

# Переменные алфавита и служебных
RUUC=АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
rulc=абвгдеёжзийклмнопрстуфхцчшщъыьэюя
RVUC=АЕЁИОУЫЭЮЯ
rvlc=аеёиоуыэюя
#unxe=X13456780Ъ # Составные части спецсимволов в gwt-текстах 
unxc=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")
unxs=$(printf "\xe2\x80\xa4\xe2\x80\xa7")
fkdt=$(printf "\xe2\x80\xa4")
qtsd=$(printf "\x22\x27")
inc=50   # Количество строк для для обработки файла за один проход для скриптов sed

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

# Обработка омографов производится в файле, который задан переменной obook
obook="$book" # омографы пишутся в $book, т.е. в результат после одного из других скриптов
#obook="$book".nam # омографы пишутся в $book.nam, т.е. в файл ДО работы скрипта ./get-words.sh

#if [[ ! -d $aux ]]; then mkdir $aux; fi

d2u

case $key in 
 -f) # удалить директорию nomo-book
  if [[ -d "$wrkdir" ]]; then rm -rf "nomo-$book"; printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" $wrkdir "удалена."; exit 1
  else printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директории" $wrkdir "не существует. Используйте другой ключ."; exit 1; fi ;;
 -n) # Собрать слова, директорию namo- не удалять (если хотим продолжить работу)
  nama=0; dixa=0; printf '\e[32m%s\e[0m\n' "Собрать слова. Ударения: словари выключены." ;;
 -gg) # Обработать имена, собрать слова, директорию namo- удалить и создать заново
  nama=1; dixa=0; if [[ -d "$wrkdir" ]]; then rm -rf "$wrkdir"; mkdir "$wrkdir";
  printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" $wrkdir "пересоздана. Собрать слова. Ударения: включён только namebase."; else mkdir "$wrkdir"; fi ;;
 -dixa) # Обработать все не-омографы, собрать слова, директорию namo- удалить и создать заново
  nama=0; dixa=1; if [[ -d "$wrkdir" ]]; then rm -rf "$wrkdir"; mkdir "$wrkdir";
  printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" $wrkdir "пересоздана. Собрать слова. Ударения: все словари включены."; else mkdir "$wrkdir"; fi ;;
 *) # Нечто другое
  printf '\e[32m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n' "Задайте ключ или книгу. Например:" "./get-words.sh -gg book.fb2" "или" "./get-words.fb2 book.fb2"; exit 0 ;;
esac

# Служебный список поисковых строк из базы имён
if [[ -s $aux/zstu.md5 ]] && md5sum -c --status $aux/zstu.md5 >/dev/null 2>&1; then
 printf '\e[36m%s \e[33m%-8s \e[32m%s \e[0m' "Файлы" $aux/zstu.md5 "OK!"; else chka=1; fi

if [[ -s $aux/zndb.md5 ]] && md5sum -c --status $aux/zndb.md5 >/dev/null 2>&1; then
 printf '\e[36m%s \e[33m%-8s \e[32m%s \e[0m' "Файлы" $aux/zndb.md5 "OK!"; else chka=1; fi

if [[ $chka -eq "1" ]]; then
 if ./check-all.sh fg; then printf '\e[32m%s\e[0m\n' "Проверка файлов завершена успешно…"
 else printf '\e[31;1m%s\e[0m \e[93m%s \e[31;1m%s\e[0m\n' "Выполнение скрипта" "./get-words.sh" "прервано! Исправьте ошибки в базах и повторите действие!"; exit 1; fi; fi

# Удалить старые отчёты 00 - 10
find . -type f -name "[01][0-9]_*\.list" -exec rm '{}'  \;

# Конвертация в UTF-8, если нужно
#vim -c "set nobomb | set fenc=utf8 | x" "$book"

#[[ -e "$book".omo ]] && rm "$book".omo
[[ -n $(ls [01][0-9]_*.list_* >/dev/null 2>&1) ]] && rm [01][0-9]_*.list_*

# Создать директорию статических файлов для текущей книги
 if md5sum -c --status $stadir/book.md5 >/dev/null 2>&1; then oldbook=1
    printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" $stadir "существует.";
 else
   newbook=1; rm -rf $stadir; mkdir $stadir;
   sed "/<binary/Q" "$book" |\
     sed -r "s/\xc2\xa0/ /g; s/\x09/ /g
            s=([АБВГДЕЁЖЗИЙКЛМНОПРСТУФЦЧШЩЪЫЬЭЮЯ])ХХ([АБВГДЕЁЖЗИЙКЛМНОПРСТУФЦЧШЩЪЫЬЭЮЯ])=\1хЪх\2=g
            s=(\S)\s+=\1 =g
            s=(<p>)\s+=\1=gI
            s=\s+(<\/p>)=\1=gI
            s=(\xcc\x81)+=\xcc\x81=g
            " > $stadir/text-book.txt
     sed -n '/<binary/,$p' "$book" > $stadir/binary-book.txt

     # Фикс римских цифр, записанных кириллицей
     latcyr=1
     while [ $latcyr != "0" ]
     do sed -ri "s=Х([CILMVX])=X\1=g
                 s=([CILMVX])Х=\1X=g
                 s=І([CILMVX])=I\1=g
                 s=([CILMVX])І=\1I=g
                 s=С([CILMVX])=C\1=g
                 s=([CILMVX])С=\1C=g
                 s=ХХ=XX=g
                 s=ІІ=II=g
                 " $stadir/text-book.txt

        latcyr=$(grep -e "[ХІС][CILMVX]" -e "[CILMVX][ХІС]" -e "ХХ" -e "ІІ" $stadir/text-book.txt | wc -l)
     done

     sed -ri "s=([АБВГДЕЁЖЗИЙКЛМНОПРСТУФЦЧШЩЪЫЬЭЮЯ])хЪх([АБВГДЕЁЖЗИЙКЛМНОПРСТУФЦЧШЩЪЫЬЭЮЯ])=\1ХХ\2=g" $stadir/text-book.txt

  md5sum $backup $stadir/text-book.txt $stadir/binary-book.txt > $stadir/book.md5;

  gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
  LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Чистка текста:" $duration "сек"
 fi;

# Создать локальные для книги словари для уменьшения используемой памяти << locdic
 # Список слов
 if [[ -s $stadir/bookwords.list ]] && md5sum -c --status $stadir/locdic.md5 >/dev/null 2>&1; then
	locdicsize=$(cat $stadir/bookwords.list | wc -l)
        printf '\e[36m%s \e[33m%s \e[36m%s \e[93m%s\e[0m\n' "Файлы в" $stadir/locdic.md5 "OK. Словоформ в локальных словарях:" $locdicsize;
 else
 sed -r 's/^/ /g' $stadir/text-book.txt | grep -Eo "[$RUUC$rulc$unxc-]+" |\
     sed -r "s/[$unxc]+//g;
             s/^.*$/\L\0/g;
#            s/ё/е/g;
             s/^.*$/_\0=/g;
             s/^(.*)-(.*)$/\0\n\1=\n_\2/g
             s/^(.*)-(.*)$/\0\n\1=\n_\2/g
             s/^(.*)-(.*)$/\0\n\1=\n_\2/g" | sed -r "s/^_-/_/; s/-=$/=/" | sort -u > $stadir/bookwords.list
    locdicsize=$(cat $stadir/bookwords.list | wc -l )

 grep -Ff $stadir/bookwords.list <(zcat $aux/dic.pat.gz)           | $zipper > $stadir/dic.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/unistress-all.pat.gz) | $zipper > $stadir/unistress-all.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/malc.pat.gz)          | $zipper > $stadir/malc.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/yodef.pat.gz)         | $zipper > $stadir/yodef.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/yolc.pat.gz)          | $zipper > $stadir/yolc.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/yoyo.pat.gz)          | $zipper > $stadir/yoyo.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/yoyo_lc.pat.gz)       | $zipper > $stadir/yoyo_lc.pat.gz
 grep -Ff $stadir/bookwords.list <(zcat $aux/names-all.pat.gz)     | $zipper > $stadir/names-all.pat.gz

 grep -Ff $stadir/bookwords.list <(zcat $sdb/unistress.gz)         | $zipper > $stadir/unistress.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/unistrehy.gz)         | $zipper > $stadir/unistrehy.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/malc.gz)              | $zipper > $stadir/malc.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/yodef.gz)             | $zipper > $stadir/yodef.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/yodhy.gz)             | $zipper > $stadir/yodhy.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/yolc.gz)              | $zipper > $stadir/yolc.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/yoyo.gz)              | $zipper > $stadir/yoyo.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/yoyo_lc.gz)           | $zipper > $stadir/yoyo_lc.gz
 grep -Ff $stadir/bookwords.list <(zcat $sdb/namebase.gz)          | $zipper > $stadir/namebase.gz

    md5sum $stadir/bookwords.list $stadir/text-book.txt $stadir/dic.pat.gz $stadir/unistress-all.pat.gz $stadir/malc.pat.gz $stadir/yodef.pat.gz \
           $stadir/yolc.pat.gz $stadir/yoyo.pat.gz $stadir/yoyo_lc.pat.gz $stadir/names-all.pat.gz $stadir/unistress.gz $stadir/malc.gz \
           $stadir/yodef.gz $stadir/yodhy.gz $stadir/yolc.gz $stadir/yoyo.gz $stadir/yoyo_lc.gz $stadir/namebase.gz $stadir/unistrehy.gz \
           > $stadir/locdic.md5

    gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur; duration=$(ms2sec);
    LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s \e[36m%s \e[93m%s\e[0m\n' "Локальные словари:" $duration "Словоформ:" $locdicsize;
 fi;
# << Конец блока создания локальных словарей

# Список обычных слов (только с маленькой буквы) -- слова, отсутствующие в словарях лексики
 sed -r 's/^/ /g' $stadir/text-book.txt | grep -Po "(?<![$RUUC$rulc$unxc])[$rulc$unxc]+" | grep -Ev "[$unxc]" | sed -r "s/^.+$/_\0=/g" | \
  grep -Fvf <(zcat $stadir/dic.pat.gz $stadir/yoyo.pat.gz $stadir/yoyo_lc.pat.gz) |
      sort -u | sed -r "s/^_(.+)=$/_\1=\1/g" > 00_wrd_newlex.list

# Список обычных слов (только с маленькой буквы) -- слова, отсутствующие в словарях ударений
 sed -r 's/^/ /g' $stadir/text-book.txt | grep -Po "(?<![$RUUC$rulc$unxc])[$rulc$unxc]+" | grep -Ev "[$unxc]" | sed -r "s/^.+$/_\0=/g" | \
  grep -Fvf <(zcat $stadir/unistress-all.pat.gz $stadir/malc.pat.gz) | sort -u | sed -r "s/^_(.+)=$/_\1=\1/g" > 01_wrd_newbas.list

# Список слов с заглавной буквы НЕ в начале предложения
grep -Po "(?<=[A-Za-zА-Яа-яёЁ0-9,}):;$unxc$unxs])[ ’(«$qtsd–—-]+[$unxc]?[$RUUC][$rulc$unxc]+" $stadir/text-book.txt | grep -Ev "[$unxc]" | \
 sed -r "s/^[ ’(«\x22\x27–—-]+(.*)$/_\l\1=/g" | sort -u > $stadir/surcap-all.pat

# Фамилия после инициала -- добавляем
grep -Po "\b(?<=[$RUUC][$fkdt.])\s*[$RUUC$unxc][$rulc$unxc]+" $stadir/text-book.txt| grep -Ev "[$unxc]" | sed -r "s/^\s*(.*)$/_\l\1=/g" | \
 sort -u >> $stadir/surcap-all.pat

# Список всех слов с заглавной буквы, без учёта позиции
sed -r 's/^/ /g' $stadir/text-book.txt | grep -Po "(?<![$RUUC$rulc$unxc])[$RUUC$unxc][$rulc$unxc]+" | grep -Ev "[$unxc]" | sed -r "s/^.+$/_\l\0=/g" | \
 sort -u > $stadir/anycap-all.pat

# Отсеиваем уже известные имена в базах, а также омографы
grep -Fvf <(zcat $stadir/names-all.pat.gz) $stadir/anycap-all.pat > $stadir/anycap-raw.pat
grep -Fvf <(zcat $stadir/names-all.pat.gz) $stadir/surcap-all.pat > $stadir/surcap-raw.pat

# Выделяем из "списка всех" часть со словами в начале предложения и т.п.
grep -Fvf $stadir/surcap-raw.pat $stadir/anycap-raw.pat > $stadir/anycap-may.pat

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s, \e[0m' "Списки слов:" $duration "сек"

 awk -vindb="$sdb/" -vinax="$stadir" -vbook=$book -f $sdb/awx/gw_caplists.awk

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s, \e[0m' "Слов:" $duration "сек"

# Список возможных неизвестных имён
grep -Fvf <(zcat $stadir/unistress-all.pat.gz) $stadir/surcap-bas.pat | sed -r 's/^_(.*)=$/_\1=\1/g' > 02_nom_newsur.list
grep -Fvf <(zcat $stadir/unistress-all.pat.gz) $stadir/anycap-bas.pat | sed -r 's/^_(.*)=$/_\1=\1/g' > 03_nom_newany.list

 # Списки потенциальных имён, уже присутствующих в словере общей лексики
 grep -Ff <(zcat $stadir/unistress-all.pat.gz) $stadir/surcap-lex.pat > $stadir/04_nom_surlex.pat
 grep -Ff <(zcat $stadir/unistress-all.pat.gz) $stadir/anycap-lex.pat > $stadir/05_nom_anylex.pat
 uniz="$stadir/unistress.gz $stadir/yoyo.gz $stadir/yodef.gz"
 zgrep -Fhf $stadir/04_nom_surlex.pat $uniz > 04_nom_surlex.list
 zgrep -Fhf $stadir/05_nom_anylex.pat $uniz > 05_nom_anylex.list

# Некоторые выделяют ударения тэгами… по умолчанию выключено: лучше обработать руками
#s=(\w)<emphasis>([$RVUC$rvlc])<\/emphasis>=\1\2\xcc\x81=g
#s=<emphasis>([$RVUC$rvlc])<\/emphasis>(\w)=\1\xcc\x81\2=g
#s=(\w)<strong>([$RVUC$rvlc])<\/strong>=\1\2\xcc\x81=g
#s=<strong>([$RVUC$rvlc])<\/strong>(\w)=\1\xcc\x81\2=g

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Имён:" $duration "сек"

# Применяем словари ударений

if [[ $dixa -eq 1 ]]; then # Применить все словари
  printf '\e[36m%s\e[0m ' "Расстановка ударений во всех известных словах и именах …"
  awk -v indb="$sdb/" -v inax="$stadir" -f $sdb/unidef.awk "$stadir"/text-book.txt > "$wrkdir"/text-book.txt  ;
fi;
if [[ $nama -eq 1 ]]; then # Применить только словарь namebase
  printf '\e[36m%s\e[0m ' "Расстановка ударений только из словаря namebase …"
  awk -v indb="$sdb/" -v inax="$stadir" -f $sdb/namedef.awk "$stadir"/text-book.txt > "$wrkdir"/text-book.txt ;
fi;

gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); gw_prev=$gw_cur;
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "выполнена за" $duration "сек"

# Выводим отчет
printf '\e[32m%s \e[33m%s \e[32m%s \e[33m%s \e[32m%s\n' "Отчёты:" "00,01" "– новые слова," "02-05" "– имена:"
printf '\e[33m%s \e[93m%-6s \e[33m%s \e[93m%-6s \e[32m%s\e[0m\n' \
  "00_WRDs лексика:" $(wc -l < 00_wrd_newlex.list) "01_UNIs ударения:" $(wc -l < 01_wrd_newbas.list) "<== Новые слова"
printf '\e[33m%s \e[93m%-6s \e[33m%s \e[93m%-6s \e[32m%s\e[0m\n' \
  "02_SURs капсы  :" $(wc -l < 02_nom_newsur.list) "03_ANYs капсы   :" $(wc -l < 03_nom_newany.list) "<== Новые имена"
printf '\e[33m%s \e[93m%-6s \e[33m%s \e[93m%-6s \e[32m%s\e[0m\n' \
  "04_SURs лексика:" $(wc -l < 04_nom_surlex.list) "05_ANYs лексика :" $(wc -l < 05_nom_anylex.list) "<== Капсы в lex"

# Пишем кол-во слов в каждом из номерных файлов в их имя
for i in [01][0-9]_*.list; do nb=$(wc -l < $i); nu=$(echo $i | sed -r "s/^(.+)(\.list)$/\1_"$nb"\2/g" ); mv $i $nu; done

# --------------------- Блок формирования дискретных скриптов для омографов --------------------------------------
# Создаем папку для "именных" омографов для конкретной книги. Только, если ее еще нет.
if [[ $preview -eq 1 ]]; then
 printf '\e[36m%s \e[33m%s\e[0m\n' "Скрипты для обработки имён-омографов сохранены в" $wrkdir

 grep -Ff <(zcat $aux/mano-sm.pat.gz) $stadir/anycap-all.pat >  $wrkdir/mano-uc-all.pat
 grep -Ff <(zcat $aux/mano-sm.pat.gz) $stadir/surcap-all.pat >> $wrkdir/mano-uc-all.pat
 sort -u -o $wrkdir/mano-uc-all.pat $wrkdir/mano-uc-all.pat

 grep -Ff $wrkdir/mano-uc-all.pat <(zcat $sdb/mano-uc.gz) | sed -r "
  s/([АЕЁИОУЫЭЮЯаеёиоуыэюя])\x27/\1\xcc\x81/g
# s/\\\xcc\\\xa0/\xcc\xa0/g
# s/\\\xcc\\\xa3/\xcc\xa3/g
# s/\\\xcc\\\xa4/\xcc\xa4/g
# s/\\\xcc\\\xad/\xcc\xad/g
# s/\\\xcc\\\xb0/\xcc\xb0/g
  s/([_ ])(.)/\1\u\2/g
  s/[_=]//g;
        " | sort -u > $wrkdir/omo-luc.lst
 rm $wrkdir/mano-uc-all.pat
fi

# Возвращаем графику назад
cat $wrkdir/text-book.txt $stadir/binary-book.txt > "$book"

# Создать дискретные скрипты обработки омографов в nomo-$book
# Дискретные скрипты запускаются из директории nomo-$book по отдельности каждый.
# ВНИМАНИЕ: для этой операции необходимо иметь навыки работы в редакторе vim !!!
# Работает только при установленном плагине vim PatternsOnText (https://github.com/inkarkat/vim-PatternsOnText)

if [[ -s $wrkdir/omo-luc.lst ]]; then # Проверка найдены ли имена-омографы для ручной обработки. maomchk 0 

# Формируем дискретные скрипты пословно
printf '\e[32m%s' "Создание дискретных скриптов обработки имён-омографов:"
twd=$(tput cols)

touch $wrkdir/omo-lexx.txt

sed -r "s/\xe2\x80\xa4/./g; s/\xe2\x80\xa7//g" $stadir/text-book.txt | \
    awk -vobook=$obook -vtwd=$twd -vpreview=$preview -vtermcor=$termcor -veditor=$edi -vindb="$sdb/" -vbkwrkdir="$wrkdir/" -f $sdb/preview.awk

printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Найдено имён-омографов         :" $(ls -l $wrkdir/*.sh | wc -l) "шт."

 chmod +x $wrkdir/*.sh

else # Если не нашли имён-омографов для ручной обработки maomchk 1
 printf '\e[36m%s\e[0m\n' "Омографов для ручной обработки не найдено."
 rm -rf $wrkdir
fi # maomchk 2


gw_cur=$(date +%s.%N); duration=$( echo $gw_cur - $gw_prev | bc ); tot_dur=$( echo $gw_cur - $gw_time0 | bc )

LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Создание дискретных скриптов   :" $duration "сек"
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Общее время работы скрипта имён:" $tot_dur "сек"
printf '\e[32;4;1m%s\e[0m \e[32m%s \e[33m%s \e[32m%s \e[36m%s \e[33m%s\e[0m\n' "\"Имена:\"" "Обработка книги" "$book" "завершена." "Бэкап:" "$backup"

