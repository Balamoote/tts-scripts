#!/bin/bash
# Скрипт для внесений пользовательских изменений в TTS.lexx
# Пользователь может создать два файла в директории с этим скриптом и TTS.lexx :

# user_del.lexx - файл со строками, которые подлежат удалению из основного словаря
# формат строк: тот же, что и в основном словаре lexx. Это должна быть строка ПОЛНОСТЬЮ, а не её часть

# user_add.lexx - файл с добавляемыми строками
# формат строк: тот же, что и в основном lexx

# Настоятельно рекомендуется проверить новый словарь штатными инструментами:
# те есть выполнить последовательность команду:
# ./lexx2txt.sh TTS_user.lexx && ./check-lexx.sh или
# ./lexx2txt.sh TTS_user.lexx && ./check-lexx.sh -a (дольше на пару минут) 
# Если найдены ошибки, их нужно устранить и создать снова словарь командой
# ./txt2lexx.sh, которая создаст словарь ttsin.lexx

# Использование:
# Убедиться, что файлы TTS.lexx, user_del.lexx, user_add.lexx находятся в одной директории с ./userlexx.sh
# Пополнить пользовательские словари user_del.lexx и user_add.lexx, если это необходимо.
# Запустить ./userlexx.sh и получить на выходе TTS_user.lexx (искомый словарь с изменениями) и TTS_user.del (список того, что было удалено)

if [[ -s "user_del.lexx" ]]; then
    grep -Evf <(sed -r 's/^.*$/^\0$/g' user_del.lexx) TTS.lexx > TTS_user.lexx
    grep -Eof <(sed -r 's/^.*$/^\0$/g' user_del.lexx) TTS.lexx > TTS_user.del
    printf '\e[36m%s \e[33m%s \e[36m%s \e[33m%s\e[0m\n' "Из словаря" "TTS.lexx" "удалены строки пользовательского словаря" "user_del.lexx."
else
    printf '\e[93m%s \e[33m%s \e[93m%s\e[0m\n' "Пользовательский словарь" "user_del.lexx" "пуст или отсутствует."
fi

if [[ -s "user_add.lexx" ]]; then
    cat user_add.lexx >> TTS_user.lexx
    sort -u -o TTS_user.lexx TTS_user.lexx
    printf '\e[32m%s \e[33m%s \e[32m%s \e[33m%s\e[0m\n' "В словарь" "TTS.lexx" "добавлены строки пользовательского словаря" "user_add.lexx."
else
    printf '\e[93m%s \e[33m%s \e[93m%s\e[0m\n' "Пользовательский словарь" "user_add.lexx" "пуст или отсутствует." 
fi

