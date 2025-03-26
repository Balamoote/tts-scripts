# Деомографизатор
# Читает файл(ы) словаря с морфологической информацией и заменяет омографы согласно правилам

# Перенумеровать правила в vim:
# let @a=1|%s/"R\zs\d\+\ze"/\=''.(@a+setreg('a',@a+1))/g|%s/ R\[\zs\d\+\ze\]++; if(dbg){print "R\(\d\+\)"/\1/g|%s/{system(cmd); for (i=1; i<=\zs\d\+\ze;/\=''.(@a-1)/g
#
# NB: во всех функциях поле указывается относительно 0, 0 - это позиция поискового слова.
# если задана переменные indb при запуске, то искать словари в директории "indb/", иначе по месту запуска
# если задана переменные inax при запуске, то писать служебные файлы в директории "inax/", иначе по месту запуска (имеет смысл только для gawk>=5.2.1)
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts

@include "scriptdb/include.awk"

BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"

  #dbg = 0
   dbgstat = 0 # имя дебажного массива установить при вызове функции DO_DEBUG() в deomo.awk

   savefs = FS;
   FS = fsword;
} {
    num++;
    split($0,currline,"<@##@##@>");
    if ( morphy_on == "1" ) { bphy[num] = currline[2] };

    $0 = book[num] = currline[1];


 # Сканируем текст на омографы.
 #   Для сканирования 1 омографа:       ./momo.sh -sw book.fb2 замок
 #   Для сканирования группы омографов: ./momo.sh -sg book.fb2 x4707
#_#_#txtmppra

    for (i=1; i<=NF; i++) {                                                                                                                #_#_# foricycle !_#_!
        if($i in vse  && num!=o01    ) {vseT [tolower($i)]  = vseT [tolower($i)]  num " "; o01     = num}; # "все" (но не вСЕ,вСе,всЕ)   #_#_# vsez !_#_!
        if($i in almo && num!=o02[$i]) {omap [almo[$i]][$i] = omap [almo[$i]][$i] num " "; o02[$i] = num}; # омографы кроме "все"        #_#_# all_omos !_#_!
        if($i in eOMO && num!=o03[$i]) {omap["x0300"][$i]   = omap["x0300"][$i]   num " "; o03[$i] = num};                               #_#_# escomo !_#_!
        if($i in cOMO && num!=o04[$i]) {omap["x0301"][$i]   = omap["x0301"][$i]   num " "; o04[$i] = num};                               #_#_# escaps !_#_!
#       if(tolower($i)=="dummy"&& num!=o01[$i]) {omap [almo[$i]][$i] = omap [almo[$i]][$i] num " "; o01[$i] = num}; # отдельное слово    #_#_# single_word !_#_!
#       if(almo[$i]   =="dummy"&& num!=o01[$i]) {omap [almo[$i]][$i] = omap [almo[$i]][$i] num " "; o01[$i] = num}; # отдельная группа   #_#_# single_group !_#_!
  };                                                                                                                                       #_#_# foricycle !_#_!
#_#_#txtmpprb
}
