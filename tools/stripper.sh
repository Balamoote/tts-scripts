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

keylist="-[sa|ds|w|wb|sn|so|xn|xo|na]"

printf '\e[32m%s\e[0m\n' "Скрипт \"Очистка файла…\""

 if [[ -s "$1" ]]; then book=$1; backup="$book".str;
   if [[ -n $2 ]]; then key=$2
     if [[ -d trip-"$book" ]]; then rm -rf trip-"$book"/ && mkdir trip-"$book"; else mkdir trip-"$book"; fi
   else printf '\e[36m%s %s\e[0m\n' "Ключ не задан. Возможные ключи:" "$keylist"; exit 0; fi
 else printf '\e[36m%s\e[0m\n' "Книга не задана."; exit 0; fi

 d2u () { if [[ -e "$backup" ]]; then printf '\e[36m%s \e[33m%s\e[0m\n' "Найден и восстановлен бэкап:" "$backup"; crlf=$(file $backup | grep -o "CRLF"; );
            if [[ -n $crlf ]]; then dos2unix "$backup" &>/dev/null; fi; cp "$backup" "$book";
          else crlf=$(file "$book" | grep -o "CRLF"); if [[ -n $crlf ]]; then dos2unix "$book" &>/dev/null; fi; cp "$book" "$backup"; fi; }

 b2t () { sed "/<binary/Q" "$book" | sed -r "s/\xc2\xa0/ /g" > trip-"$book"/text-book.txt
          sed -n '/<binary/,$p' "$book" > trip-"$book"/binary-book.txt; split_exist=1; }

case $key in 
  -sa) # удалить все служебные символы, а также все ударения, восстановить символ точки.
  	  d2u; b2t; sset=$unxs$unxc;
      printf '\e[36m%s\e[0m ' "Удалить все служебные символы, а также все ударения, восстановить символ точки."
      sed -ri "s=[$sset]+==g; s=[$unxd]=.=g" trip-"$book"/text-book.txt
      printf '\e[36m%s\e[0m\n' "Файл очищен." ;;
  -dc) # удалить служебные символы и восстановить символ точки, ударение не трогать
  	  d2u; b2t; sset=$unxc;
      printf '\e[36m%s\e[0m ' "Удалить служебные символы и восстановить символ точки"
      sed -ri "s=[$sset]+==g; s=[$unxd]=.=g" trip-"$book"/text-book.txt
      printf '\e[36m%s\e[0m\n' "Файл очищен." ;;
  -sy) # удалить ударение на "ё".
  	  d2u; b2t; syo=1; printf '\e[36m%s\e[0m ' "Удалить ударения на букву ё."
      sed -ri "s=([Ёё])\xcc\x81=\1=g" trip-"$book"/text-book.txt
      printf '\e[36m%s\e[0m\n' "Файл очищен." ;;
  -se) # "ё" -->>> "е".
  	  d2u; b2t; sye=1; printf '\e[36m%s\e[0m ' "Заменить ё на е."
      sed -ri "s=([Ёё])\xcc\x81=\1=g; s=Ё=Е=g; s=ё=е=g;" trip-"$book"/text-book.txt
      printf '\e[36m%s\e[0m\n' "Файл очищен." ;;
      
  -w) # удалить служебные символы и ударения в указанном слове, регистрозависимо. Бэкап НЕ делать. Только 1 вариантов: Слова|СЛОВА|слова
  	  if [[ -n $3 ]]; then
           b2t; wrd=$3; swch="ws"; printf '\e[36m%s \e[93m%s\e[0m ' "Очистить слово" $wrd
           awk -vsomo=$somo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Слово" $wrd "очищено."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для очистки."; fi ;;
  -wb) # удалить служебные символы и ударения в указанном слове, регистрозависимо. Сделать бэкап.
  	  if [[ -n $3 ]]; then
           d2u; b2t; wrd=$3; swch="ws"; printf '\e[36m%s \e[93m%s\e[0m\n' "Очистить слово" $wrd
           awk -vsomo=$somo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Слово" $wrd "очищено."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для очистки."; fi ;;
  -sn) # удалить служебные символы и ударения везде, кроме всех вариантов омографа. Бэкап делать. Любой из вариантов: Слова|СЛОВА|слова
      if [[ -n $3 ]]; then
           d2u; b2t; somo=$3; indb="$sdb/"; swch="sn"; printf '\e[36m%s \e[93m%s ...\e[0m ' "Очистить слово" $somo
           awk -vsomo=$somo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
           printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Всё, кроме слова" $somo ", очищено."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
  -so) # удалить служебные символы и ударения во всех вариантах омографа. Бэкап делать. Любой из вариантов: Слова|СЛОВА|слова...
      if [[ -n $3 ]]; then
           d2u; b2t; somo=$3; indb="$sdb/"; swch="so"; printf '\e[36m%s \e[93m%s ...\e[0m ' "Очистить слово" $somo
           awk -vsomo=$somo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
           printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Все́ варианты слова" $somo "очищены."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
  -xn) # удалить служебные символы и ударения везде, кроме всех вариантов омографа. Бэкап делать. Все омографы не из группы.
      if [[ -n $3 ]]; then
           d2u; b2t; xomo=$3; indb="$sdb/"; swch="xn"; printf '\e[36m%s \e[93m%s\e[0m ' "Очистить слово" $xomo
           awk -vxomo=$xomo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
           printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Всё, кроме группы" $xomo "очищено."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
  -xo) # удалить служебные символы и ударения во всех вариантах омографа. Бэкап делать. Все омографы из группы.
    	if [[ -n $3 ]]; then
           d2u; b2t; xomo=$3; indb="$sdb/"; swch="xo"; printf '\e[36m%s \e[93m%s\e[0m' "Очистить группу" $xomo ;
           awk -vxomo=$xomo -vindb=$indb -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
           printf '\e[36m. %s \e[93m%s\e[36m%s\e[0m\n' "Группа" $xomo ", очищена."
      else printf '\e[36m%s\e[0m\n' "Не задано слово для оставления в тексте."; fi ;;
  -na) # удалить служебные символы и ударения во всех именах, кроме имён-омографов. Сделать бэкап.
  	       d2u; b2t; swch="na"; printf '\e[36m%s\e[0m ' "Очистить все имена из namebase …"
           awk -vxomo=$xomo -vinax=$inax -vswch=$swch -f $sdb/awx/stripper.awk trip-"$book"/text-book.txt > trip-"$book"/text-book.txt.awk
           mv trip-"$book"/text-book.txt.awk trip-"$book"/text-book.txt
           printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Имена книги" $book ", кроме омографов, очищены." ;;
	*) # левый ключ
		printf '\e[36m%s \e[93m%s\e[0m\n' "Задайте правильный ключ из:" "$keylist"; exit 0 ;;
esac

if [[ $split_exist -eq 1 ]]; then
   cat trip-"$book"/text-book.txt trip-"$book"/binary-book.txt > "$book"
fi

# Удаляем временные файлы
rm -rf trip-"$book"

