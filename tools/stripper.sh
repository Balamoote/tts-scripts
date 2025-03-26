#!/bin/bash
# Скрипт очистки файла книги от служебных символов, которые добавляются скриптами обработки, а также ударений в словах.
# Использование: ./stripper.sh book.fb2 [ключ] , где "ключ" может принимать следующие значения:
# -sa | --stripall удалить все служебные символы, а также все ударения, восстановить символ точки.
# -dc | --delcor удалить служебные символы и восстановить символ точки, ударение не трогать
# -w | --word удалить служебные символы и ударения в указанном слове, регистрозависимо! Бэкап НЕ делать.
# -wb | --wordb удалить служебные символы и ударения в указанном слове, регистрозависимо! Сделать бэкап.
# для ключей -w, --word, формат запуска: ./stripper.sh book.fb2 -w слово
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 

# Переменные алфавита и служебных
RUCl=АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя
RUUC=АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
rulc=абвгдеёжзийклмнопрстуфхцчшщъыьэюя
RVUC=АЕЁИОУЫЭЮЯ
rvlc=аеёиоуыэюя
unxs=$(printf "\xcc\x81")
unxc=$(printf "\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0\xe2\x80\xa7")
unxd=$(printf "\xe2\x80\xa4")
st="\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0\xe2\x80\xa4\xe2\x80\xa7"

aux="scriptaux"
sdb="scriptdb"

printf '\e[32m%s\e[0m\n' "Скрипт \"Очистка файла…\""

if [[ -s "$1" ]]; then book=$1; backup="$book".str;
	if [[ -n $2 ]]; then key=$2
	else printf '\e[36m%s\e[0m\n' "Ключ не задан."; exit 0; fi
else printf '\e[36m%s\e[0m\n' "Книга не задана."; exit 0; fi

case $key in 
	-sa | --stripall) # удалить все служебные символы, а также все ударения, восстановить символ точки.
		sset=$unxs$unxc; dobackup=1; printf '\e[36m%s\e[0m\n' "Удалить все служебные символы, а также все ударения, восстановить символ точки." ;;
	-dc | --delcor) # удалить служебные символы и восстановить символ точки, ударение не трогать
		sset=$unxc;  dobackup=1; printf '\e[36m%s\e[0m\n' "Удалить служебные символы и восстановить символ точки" ;;
	-sy | --stripyo) # удалить ударение на "ё".
		syo=1; dobackup=1; printf '\e[36m%s\e[0m\n' "Удалить ударения на букву ё." ;;
	-w | --word) # удалить служебные символы и ударения в указанном слове, регистрозависимо. Бэкап НЕ делать. Только 1 вариантов: Слова|СЛОВА|слова
		if [[ -n $3 ]]; then wrd=$3; dobackup=0; printf '\e[36m%s \e[93m%s\e[0m\n' "Очистить слово" $wrd ; else printf '\e[36m%s\e[0m\n' "Не задано слово для очистки."; fi ;;
	-wb | --wordb) # удалить служебные символы и ударения в указанном слове, регистрозависимо. Сделать бэкап.
		if [[ -n $3 ]]; then wrd=$3; dobackup=1; printf '\e[36m%s \e[93m%s\e[0m\n' "Очистить слово" $wrd ; else printf '\e[36m%s\e[0m\n' "Не задано слово для очистки."; fi ;;
	-wn | --wordnot) # удалить служебные символы и ударения везде, кроме всех вариантов омографа. Бэкап делать. Любой из вариантов: Слова|СЛОВА|слова
		if [[ -n $3 ]]; then somo=$3; indb="$sdb/"; dobackup=1; #printf '\e[36m%s \e[93m%s\e[0m\n' "Очистить слово" $wrd ;
	       		else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
	-xn | --groupnot) # удалить служебные символы и ударения везде, кроме всех вариантов омографа. Бэкап делать. Все омографы из группы.
		if [[ -n $3 ]]; then xomo=$3; indb="$sdb/"; dobackup=1; #printf '\e[36m%s \e[93m%s\e[0m\n' "Очистить слово" $wrd ;
	       		else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
	-na | --names) # удалить служебные символы и ударения во всех именах, кроме имён-омографов. Сделать бэкап.
		names=1; dobackup=1; printf '\e[36m%s\e[0m\n' "Очистить все имена…" ;;
	*) # левый ключ
		printf '\e[36m%s \e[93m%s\e[0m\n' "Задайте правильный ключ из:" "-sa, -ds, -w, -wb, --stripall, --delcor, --word,  --wordb"; exit 0 ;;
esac

d2u () { if [[ -e "$backup" ]]; then printf '\e[36m%s \e[33m%s\e[0m\n' "Найден и восстановлен бэкап:" "$backup"; crlf=$(file $backup | grep -o "CRLF"; );
            if [[ -n $crlf ]]; then dos2unix "$backup" &>/dev/null; fi; cp "$backup" "$book";
        else crlf=$(file "$book" | grep -o "CRLF"); if [[ -n $crlf ]]; then dos2unix "$book" &>/dev/null; fi; cp "$book" "$backup"; fi; }

if [[ -d trip-"$book" ]]; then rm -rf trip-"$book"/ && mkdir trip-"$book"; else mkdir trip-"$book"; fi
if [[ $dobackup = "1" ]]; then d2u; fi

sed "/<binary/Q" "$book" | sed -r "s/\xc2\xa0/ /g" > trip-"$book"/text-book.txt
sed -n '/<binary/,$p' "$book" > trip-"$book"/binary-book.txt

if [[ -n $sset ]]; then
	sed -ri "s=[$sset]+==g" trip-"$book"/text-book.txt
	sed -ri "s=[$unxd]=.=g" trip-"$book"/text-book.txt
	printf '\e[36m%s\e[0m\n' "Файл очищен."
fi

if [[ -n $syo ]]; then
  sed -ri "s=([Ёё])\xcc\x81=\1=g" trip-"$book"/text-book.txt
	printf '\e[36m%s\e[0m\n' "Файл очищен."
fi

if [[ -n $wrd ]]; then
	seden=[$st]?$(echo $wrd | sed -r "s/./\0[$st]*/g")
	sed -ri "s=([^$RUCl])$seden([^$rulc])=\1$wrd\2=g" trip-"$book"/text-book.txt
	printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Слово" $wrd "очищено."
fi

if [[ -n $somo ]]; then
	awk -vsomo=$somo -vindb=$indb -f $sdb/awx/strip_not_omo.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
  mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
	printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Все, кроме слова" $somo ", очищено."
fi

if [[ -n $xomo ]]; then
	awk -vxomo=$xomo -vindb=$indb -f $sdb/awx/strip_not_omo.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
  mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
	printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Все, кроме группы" $xomo ", очищено."
fi

if [[ -n $names ]]; then
	readarray -t narr < <(grep -Po "(?<![$RUCl$unxs$unxc])[$RUUC][$RUCl$unxs$unxc]+" trip-"$book"/text-book.txt | sed -r "s/[^$RUCl]//g; s/^.+$/_\L\0=/g" | \
		grep -Ff <(zcat $aux/namebase.pat.gz) | sort -u | sed -r "s/[_=]//g; s/^./\u\0/g")

	for wrd in ${narr[@]}; do
		seden=[$st]?$(echo $wrd | sed -r "s/./\0[$st]?/g")
		sed -ri "s=([^$RUCl])$seden([^$rulc])=\1$wrd\2=g" trip-"$book"/text-book.txt
	done
	printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Имена книги" $book ", кроме омографов, очищены."
fi


cat trip-"$book"/text-book.txt trip-"$book"/binary-book.txt > "$book"

# Удаляем временные файлы
rm -rf trip-"$book"

