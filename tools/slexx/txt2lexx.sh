#!/bin/bash
# перевод текстовой версии словаря в формат lexx: проставление ударения на гласной
# Использование: ./txt2lexx.sh tts.txt ttsin.lexx или ./txt2lexx.sh tts.txt

if [[ ! -z "$1" ]]; then
	IN=$1	
else
	printf '\e[36m%s \e[33m%s\e[0m\n' "Используется входной файл по умолчанию:" "tts.txt"
	IN=tts.txt
fi
if [[ ! -z "$2" ]]; then
	OUT="$2"	
	printf '\e[36m%s \e[33m%s\e[0m\n' "Результат пишется в файл:" $OUT
else
	printf '\e[36m%s \e[33m%s\e[0m\n' "Результат пишется в файл по умолчанию:" "ttsin.lexx"
	OUT=ttsin.lexx
fi

sed -r "s/([аеёиоуыэюя])'/\1\xcc\x81/g" "$IN" > "$OUT"

printf '\e[93m%s \e[33m%s\e[0m\n' $(wc -l $OUT)
