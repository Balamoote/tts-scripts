#!/bin/bash
# Скрипт ёфикации текста
# Делает "однозначную" ёфикацию. Ё-омографами занимается ./momo.sh
# Имеет смысл запускать только с ключом -gg, и обработать некоторые омографы вручную, остальное передав ./momo.sh
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 
# Ручная обработка ё-омографов через дискретные скрипты работает только с установленным плагинами vim:
# 1) vim-ingo-library, брать тут https://github.com/inkarkat/vim-ingo-library
# 2) vim-PatternsOnText, брать тут https://github.com/inkarkat/vim-PatternsOnText
#set -e
export LC_COLLATE=C
yo_time0=$(date +%s.%N)
key="$1"
book="$2"
bookwrkdir=jomo-"$book"
tmpdir=jot-"$book"
suf=yoy
backup="$book".$suf

aux="scriptaux"
sdb="scriptdb"

# Установка редактора: vim или neovim
edi=$(sed -rn 's/^\s*editor\s*=\s*(vim|nvim)\s*$/\1/ p' $sdb/settings.ini)

# Установка корректировки ширины вывода превью в дискретных скриптах
termcor=$(sed -rn 's/^\s*termcorrection\s*=\s*([-0-9]*)\s*$/\1/ p' $sdb/settings.ini)

# Переменные алфавита и служебных
RUUC=АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
rulc=абвгдеёжзийклмнопрстуфхцчшщъыьэюя
RVUC=АЕЁИОУЫЭЮЯ
rvlc=аеёиоуыэюя
unxc=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")
unxs=$(printf "\xe2\x80\xa4\xe2\x80\xa7")
inc=50	  # Количество строк для для обработки файла за один проход для скриптов sed

d2u () { if [[ -e "$backup" ]]; then printf '\e[36m%s \e[33m%s\e[0m\n' "Найден и восстановлен бэкап:" "$backup"; crlf=$(file $backup | grep -o "CRLF"; );
            if [[ -n $crlf ]]; then dos2unix "$backup" &>/dev/null; fi; cp "$backup" "$book";
        else crlf=$(file "$book" | grep -o "CRLF"); if [[ -n $crlf ]]; then dos2unix "$book" &>/dev/null; fi; cp "$book" "$backup"; fi; }
#sedroll () { local lico=$(wc -l < "$1"); local i=0; local j=0; for i in $(seq 1 $inc $lico); do j=$(($i+$(($inc-1))));	sed -i -rf <(sed -n "$i,$j p" < "$1") "$2"; done; }

if [[ -s "$1" ]]; then book=$1; backup="$book".$suf; key="-xp"; printf '\e[36m%s\e[0m\n' "Ключи не заданы, но книга указана. Используем ключ: -xp"
elif [[ -s "$2" ]] || [[ -s $backup ]]; then printf '\e[36m%s \e[93m%s\n' "Обрабатывается книга:" "$book"
else printf '\e[35m%s \e[93m%s\e[0m\n' "Книга не задана или не существует. Использование:" "./yofik.sh [ключ] book.fb2"; exit 1; fi

# Ёфикация омографов производится в файле, который задан переменной obook
obook="$book" # ё-омографы пишутся в $book, т.е. в основной файл книги в, возможно, в результат после одного из других скриптов
#obook="$book".yoy # ё-омографы пишутся в $book.yoy, т.е. в бэкап скрипта ./yofik.sh
#obook="$book".nam # ё-омографы пишутся в $book.nam, т.е. в бэкап скрипта ./lexxer.sh.

case $key in 
	-f) # удалить директорию yomo-book
		if [[ -d "jomo-$book" ]]; then rm -rf "jomo-$book"; printf '\e[32m%s \e[93m%s \e[32m%s\e[0m\n' "Директория" $bookwrkdir "удалена."; exit 1
		else printf '\e[32m%s \e[93m%s \e[32m%s\e[0m\n' "Директории" "jomo-$book" "не существует. Используйте другой ключ."; exit 1; fi ;;
	-x) # Однозначные+дискретные скрипты БЕЗ превью; существующую директорию yomo- не удалять
		fixomo=1; preview=0; printf '\e[32m%s\e[0m\n' "Задания: однозначные омографы, дискретные скрипты." ;;
	-p) # Превью текста и дискретные скрипты; существующую директорию yomo- не удалять, однозначные НЕ заменять
		fixomo=0; preview=1; printf '\e[32m%s\e[0m\n' "Задания: превью текста, дискретные скрипты." ;;
	-px | -xp | -g) # Однозначные, превью и дискретные скрипты; существующую директорию yomo- не удалять
		fixomo=1; preview=1; printf '\e[32m%s\e[0m\n' "Задания: однозначные омографы, превью текста, дискретные скрипты." ;;
	-fpx | -fxp | -fg | -gg) # Однозначные омографы, превью и дискретные скрипты; существующую директорию yomo- удалить
		fixomo=1; preview=1; if [[ -d "jomo-$book" ]]; then rm -rf "jomo-$book"; printf '\e[32m%s \e[93m%s \e[32m%s\e[0m\n' "Директория" "jomo-$book" "удалена."; fi ;;
	-pf | -fp) # Превью текста и дискретные скрипты; существующую директорию yomo- удалить
		fixomo=1; preview=0; if [[ -d "jomo-$book" ]]; then rm -rf "jomo-$book"; printf '\e[32m%s \e[93m%s \e[32m%s\e[0m\n' "Директория" "jomo-$book" "удалена."; fi ;;
	-fx | -xf) # Однозначные+дискретные скрипты; существующую директорию yomo- удалить
		fixomo=0; preview=1; if [[ -d "jomo-$book" ]]; then rm -rf "jomo-$book"; printf '\e[32m%s \e[93m%s \e[32m%s\e[0m\n' "Директория" "jomo-$book" "удалена."; fi ;;
	*) # Нечто другое
		printf '\e[32m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n' "Задайте ключ или книгу. Например:" "./yofik.sh -xp book.fb2" "или" "./yofik.fb2 book.fb2" ; exit 0 ;;
esac

printf '\e[32m%s \e[32;4;1m%s\e[0m\n' "Скрипт" "\"Ёфикация\""
printf '\e[36m%s \e[93m%s\e[0m\n' "Строк в словаре однозначной ёфикации:" $(zgrep -c ^ $sdb/yodef.gz $sdb/yodhy.gz)
printf '\e[36m%s \e[93m%s \e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Строк в словаре:" $(zgrep -c ^ $sdb/yomo-uc.gz) "Ё-омографов и" $(zgrep -c ^ $sdb/yomo-lc.gz) "ё-омографов."
if [[ ! -d $aux ]]; then mkdir $aux; fi

if [[ -s $aux/zjofik.md5 ]] && md5sum -c --status $aux/zjofik.md5 >/dev/null 2>&1; then
	printf '\e[32m%s \e[33m%s \e[32m%s\e[0m\n' "Вспомогательные файлы ёфикатора в" "$aux/" ": OK";
else clxx=1; fi

if [[ $clxx -eq "1" ]]; then
	if ./check-all.sh -f; then printf '\e[32m%s\e[0m\n' "Проверка файлов завершена успешно…"
	else printf '\e[31;1m%s\e[0m \e[93m%s \e[31;1m%s\e[0m\n' "Выполнение скрипта" "./yofik.sh" "прервано! Исправьте ошибки в базах и повторите действие!"; exit 1; fi; fi

# Массив со списком обязательных файлов
pack="$sdb/yodef.gz $aux/yodef.pat.gz $sdb/yomo-lc.gz $aux/yomo-lc.pat.gz $sdb/yomo-uc.gz $aux/yomo-uc.pat.gz \
      $aux/yomo-cc.pat.gz $sdb/yolc.gz $sdb/yodef.awk $aux/yolc.pat.gz $aux/yodhy.gz"
read -a minpack <<< $pack

# Проверка не потерялось ли чего
for f in "${minpack[@]}"; do
	if [[ ! -s $f ]]; then
	if [[ -e $aux/zjofik.md5 ]]; then rm $aux/zjofik.md5; fi
	printf '\e[31;5;1m%s\e[0m \e[93m%s \e[31;5;1m%s\e[0m\n' "Отсутствует файл:" $f "Запустите еще раз или найдите потерянный файл."; exit 1; fi; done

if [[ -d $tmpdir ]]; then rm -rf $tmpdir/ && mkdir $tmpdir; else mkdir $tmpdir; fi; d2u;

# Конвертация в UTF-8, если нужно
#vim -c "set nobomb | set fenc=utf8 | x" "$book"

sed "/<binary/Q" "$book" | sed -r "s/\xc2\xa0/ /g" > $tmpdir/text-book.txt
sed -n '/<binary/,$p' "$book" > $tmpdir/binary-book.txt

# Список слов всех, в нижнем регистре, затем в верхем и КАПСЫ

grep -Po "(?<=[^$RUUC$rulc$unxc])[$rulc$unxc]+"             $tmpdir/text-book.txt | grep -v "[$unxc]" | sed -r 's/^.+$/_\0=/g' | sort -u > $tmpdir/words-all-lc.pat

grep -Po "(?<=[^$RUUC$unxc])[$RUUC$unxc]+"                  $tmpdir/text-book.txt | grep -v "[$unxc]" | sed -r 's/^.+$/_\0=/g' | sort -u > $tmpdir/words-all-cc.pat

grep -Po "(?<=[^$RUUC$rulc$unxc])[$RUUC$unxc][$rulc$unxc]+" $tmpdir/text-book.txt | grep -v "[$unxc]" | sed -r 's/^.+$/_\0=/g' | sort -u > $tmpdir/words-all-uc.pat


if [[ $fixomo -eq "1" ]]; then # fimomochk 0
# Скрипт sed для однозначной ёфикации

yo_time1=$(date +%s.%N); duration=$( echo $yo_time1 - $yo_time0 | bc )
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Предварительная подготовка скриптов ёфикации заняла:" $duration "сек"

 awk -vindb="$sdb/" -vinax="$aux/" -f $sdb/yodef.awk $tmpdir/text-book.txt > $tmpdir/text-book.awk.txt
 mv $tmpdir/text-book.awk.txt $tmpdir/text-book.txt

yo_time2=$(date +%s.%N); duration=$( echo $yo_time2 - $yo_time1 | bc )
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Ёфикация однозначных случаев заняла:" $duration "сек"
## выключить все сканирующие строки, кроме "все"
#awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -f <(sed -r "/^#_#_#txtmppra/,/^#_#_#txtmpprb/ s/^/#/g; s/^#(.+)(#_#_# vsez !_#_!)$/\1\2/g" $sdb/main.awk) \
#   $tmpdir/text-book.txt > $tmpdir/text-book.awk.txt
#mv $tmpdir/text-book.awk.txt $tmpdir/text-book.txt

yo_time3=$(date +%s.%N); duration=$( echo $yo_time3 - $yo_time2 | bc )
#LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Ёфикация омографов заняла:" $duration "сек"

# Проверить наличие необработанных "все" и подключить пару "все/всё"
yop=$(grep -io "[^$unxc]\bвсе\b[^$unxc]" $tmpdir/text-book.txt| wc -l)
if [[ ! $yop -eq 0 ]]; then
	printf '\e[36m%s \e[93m%s\e[36m%s\e[0m\n' "Остаток Все́/Всё:" $yop ". Для дальнейшей обработки использовать ./momo.sh"; fi


# Возвращаем графику назад
cat $tmpdir/text-book.txt $tmpdir/binary-book.txt > "$book"

fi # fixomochk 1

# --------------------- Ё-омографы ----------------------------------------------------------------
# Список ё-омонимов yodirchk 0
if [[ ! -d $bookwrkdir ]]; then
	mkdir $bookwrkdir
	grep -Ff <(zcat $aux/yomo-lc.pat.gz) $tmpdir/words-all-lc.pat > $bookwrkdir/yo-omo-lc.pat
	grep -Ff <(zcat $aux/yomo-uc.pat.gz) $tmpdir/words-all-uc.pat > $bookwrkdir/yo-omo-uc.pat
  grep -Ff <(zcat $aux/yomo-cc.pat.gz) $tmpdir/words-all-cc.pat > $bookwrkdir/yo-omo-cc.pat

	zgrep -Ff $bookwrkdir/yo-omo-lc.pat $sdb/yomo-lc.gz                                                              > $bookwrkdir/yomo-luc.txt
  zcat $sdb/yomo-lc.gz $sdb/yomo-uc.gz |sed -r "s/([_ ])(.)/\1\u\2/g"    | grep -Ff $bookwrkdir/yo-omo-uc.pat >> $bookwrkdir/yomo-luc.txt
  zcat $sdb/yomo-lc.gz $sdb/yomo-uc.gz |sed -r "s/([$RUUC$rulc]+)/\U\0/g"| grep -Ff $bookwrkdir/yo-omo-cc.pat >> $bookwrkdir/yomo-luc.txt

    sed -r "
       s/^_(.+)=/\1/g
       s/\x27/\xcc\x81/g
       s/\\\xcc\\\xa0/\xcc\xa0/g
       s/\\\xcc\\\xa3/\xcc\xa3/g
       s/\\\xcc\\\xa4/\xcc\xa4/g
       s/\\\xcc\\\xad/\xcc\xad/g
       s/\\\xcc\\\xb0/\xcc\xb0/g
        " $bookwrkdir/yomo-luc.txt |sort -u > $bookwrkdir/omo-luc.lst
	rm $bookwrkdir/*.pat $bookwrkdir/*.txt

if [[ -s $bookwrkdir/omo-luc.lst ]]; then # Проверка найдены ли ё-омографы для ручной обработки yoomchk 0

# Создать дискретные скрипты ёфикации пословно в jomo-$book
# Дискретные скрипты запускаются из директории jomo-$book по отдельности каждый.
# ВНИМАНИЕ: для этой операции необходимо иметь навыки работы в редакторе vim !!!
# Работает только при установленном плагине vim PatternsOnText (https://github.com/inkarkat/vim-PatternsOnText)

# Формируем дискретные скрипты пословно
printf '\e[32m%s' "Создание дискретных скриптов обработки ё-омографов:"
twd=$(tput cols)

zgrep -Ff <(sed -r 's/^([^ ]+) .*/_\l\1=/g' $bookwrkdir/omo-luc.lst | sort -u) $sdb/uniomo.gz |\
            sed -r 's/_([^=]+)(=.+)$/\1=#\2/'| sed "s/\x27/\xcc\x81/" > $bookwrkdir/omo-lexx.txt
#zgrep -Ff <(grep -Fof <(zcat $aux/ttspat.$suf.gz) <(sed -r 's/^([^ ]+) .*/_\l\1=/g' $bookwrkdir/omo-luc.lst | sort -u)) $aux/tts0.$suf.gz |\
#       	sed -r 's/_([^"=]+)(\"=\"\s.+\")$/\1#\" \1\2/' | sed -r 's/_([^=]+)(=.+)$/\1=#\1\2/'| sed "s/\x27/\xcc\x81/" > $bookwrkdir/omo-lexx.txt

sed -r "s/\xe2\x80\xa4/./g; s/\xe2\x80\xa7//g" $tmpdir/text-book.txt | \
    awk -vobook=$obook -vtwd=$twd -vpreview=$preview -vtermcor=$termcor -veditor=$edi -vbkwrkdir="$bookwrkdir/" -vindb="$sdb/" -f $sdb/preview.awk

# Допечатываем превьюшку из текста книги для поискового слова
printf '\e[36m%s \e[093m%s\e[36m%s\e[0m\n' "Найдено ё-омографов:" $(ls -l $bookwrkdir/*.sh | wc -l)

chmod +x $bookwrkdir/*.sh
yo_time4=$(date +%s.%N); duration=$( echo $yo_time4 - $yo_time3 | bc )
LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Создание дискретных скриптов заняло:" $duration "сек"

else # Если не нашли ё-омографов для ручной обработки yoomchk 1
	printf '\e[36m%s\e[0m\n' "Ё-омографов для ручной обработки не найдено."
	rm -rf $bookwrkdir
fi; fi # yoomchk 2 yodirchk 2


# Удаляем временные файлы
rm -rf $tmpdir

yo_proc=$(date +%s.%N); tot_dur=$( echo $yo_proc - $yo_time0 | bc )

LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%.2f \e[36m%s\e[0m\n' "Общее время работы скрипта:" $tot_dur "сек"
printf '\e[32;4;1m%s\e[0m \e[36m%s \e[33m%s \e[36m%s \e[33m%s\e[0m\n' "\"Ёфикация:\"" "Обработка книги" "$book" "завершена. Бэкап:" "$backup"

