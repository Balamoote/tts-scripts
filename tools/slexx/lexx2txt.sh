#!/bin/bash
# перевести словарь в формате lexx в txt: замена ударных гласных на 2 символа
# https://github.com/Balamoote/gtts-dic 
# Использование: lexx2txt.sh tts.lexx tts.txt

if [[ ! -z "$1" ]]; then
	IN=$1	
else
	printf '\e[36m%s\e[0m\n' "Не задан входной файл словаря lexx!"
	printf '\e[36m%s \e[93m%s\e[0m\n' "Использование:" "./lexx2txt.txt tts.lexx [tts.txt]"
	exit 0
fi
if [[ ! -z "$2" ]]; then
	OUT=$2	
	printf '\e[36m%s \e[33m%s\e[0m\n' "Результат пишется в файл:" $OUT
else
	printf '\e[36m%s \e[33m%s\e[0m\n' "Результат пишется в файл по умолчанию:" "tts.txt"
	OUT=tts.txt
fi

sed -r "s/([аеёиоуыэюя])\xcc\x81/\1'/g" "$IN" > "$OUT"

printf '\e[93m%s \e[33m%s\e[0m\n' $(wc -l $OUT)
