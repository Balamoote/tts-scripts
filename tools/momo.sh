#!/bin/bash
# Скрипт ручной обработки текста
# Создает в директории mano-"$book" дискретные скрипты для обработки каждого из найденных омографов.
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts
# Ручная обработка омографов через дискретные скрипты работает только с установленным плагинами vim:
# 1) vim-ingo-library, брать тут https://github.com/inkarkat/vim-ingo-library
# 2) vim-PatternsOnText, брать тут https://github.com/inkarkat/vim-PatternsOnText
#set -e
#source ~/.bashrc
# Ключи запуска: -[gg|ruac|sw|sg|se|x|xf|p|pf|f]. Например: ./momo.sh -gg book.fb2 или ./momo.fb2 book.fb2 или ./momo.fb2 -ruac book.fb2
#set -x
export LC_COLLATE=C
cdata=$(date)
printf '\e[32m%s \e[32;4;1m%s\e[0m \e[93m%s\e[0m\n' "Скрипт" "\"Ручные омографы\"" "$cdata"

mo_time0=$(date +%s.%N); mo_prev="$mo_time0"
key="$1"
book="$2"
somo="$3"
bookwrkdir=mano-"$book"
bookstadir=mano-"$book".stat
suf=man
backup="$book".$suf

aux="scriptaux"
sdb="scriptdb"

 vso="x1111"  # Использовать для "все" функцию x1111_f()
#vso="vsevso" # Использовать для "все" функцию xVSEVSO_F()

#repper="grep"
 repper="rg"

debug=1       # Если 1, то сделать отладку скриптов омографов: поиск искажений текста в "пастеризованных" версиях исходника и результата 
nocaps=0      # Если 1, то при debug=1 капсов в "пастеризованных" не будет
locdic=1      # Создавать локальные словари для каждой книги из фактически найденной лексики
sed_do=0      # 1 = постобработка sed, мелочи для выделения инициалов и пр. работает только для [gtts] + [ttslexx] + [словарь расшифровки условных обоззначений]
morphy_is=0   # 1 = SpaCy; 2 = Natasha; 3 = beta_1; 4 = RNNTagger; NOTE: только для исследовательских целей. На практике используем ruaccent.
  morphy_yo=0 # 1 = скрипт vsevso.awk (или x1111.awk) использует только данные SpaCy или Natasha; 0 = сторонняя модель только "подбирает хвосты"
  morphy_do=0 # 1 = некоторые скрипты могут использовать только данные SpaCy или Natasha; 0 = только "подбирает хвосты" (не сделано)
main_do=1     # 1 = включить основную обработку, для возможности ее выключения, для -ruac, например.
disc_do=1     # 1 = включить дискретные скрипты
fixomo=1      # 1 = включить скрипты awk разрешения неоднозначности омографов

# Сторонние пакеты проставления ударения: ИЛИ ruaccent ИЛИ silero-stress. Попытка включить оба выключит оба пакета.
 rust=0       # 1 = включить обработку ruaccent -- выставит ударения везде, где сможет. Уже проставленные ударения сохраняются
   ruac_opt="-cuda"  # опции для ruaccent, если CUDA нет, автоматически переключится на CPU, но будет жаловаться.
#  ruac_opt="-cpu"   # опции для ruaccent
#rust=0       # 2 = включить обработку silero-stress -- выставит ударения везде, где сможет. Уже проставленные ударения сохраняются

do_parallel=1     # включить GNU Parallel. ВНИМАНИЕ: подобрать параметры по реальной производительности
   pblock_a=500K  # awk: размер куска текста на 1 задачу: постфиксы K, M, G, T, P, k, m, g, t, p. "-1" = авто
   pblock_s=-1    # sed: размер куска текста на 1 задачу: постфиксы K, M, G, T, P, k, m, g, t, p. "-1" = авто
   pjobs=8        # задать макс. кол-во задач. 100% = кол-ву потоков (threads). 4 = 4 задачи. Подсказка: $ parallel --number-of-cores
   pload=200%     # макс загрузка отдельного процессора: вывод $ parallel --number-of-threads делённый на $ parallel --number-of-cores : 16/8 = 2 * 100% = 200%
   pmem=1G        # мин. память, перед началом следующей задачи, если памяти менее 50% от значения, завершить самую свежую задачу.
   pnice=0        # приоритет

   paraopts_awk="--jobs=$pjobs --load=$pload --block=$pblock_a --memfree $pmem --nice=$pnice --noswap --eta --bar --pipe-part -ka"
   paraopts_sed="--jobs=$pjobs --load=$pload --block=$pblock_s --memfree $pmem --nice=$pnice --noswap --pipe-part -ka"

# Установка редактора: vim или neovim
edi=$(sed -rn 's/^\s*editor\s*=\s*(vim|nvim)\s*$/\1/ p' $sdb/settings.ini)
if command -v pigz >/dev/null 2>&1; then zipper="pigz"; else zipper="gzip"; fi
usevenvra=$(sed -rn 's/^\s*usevenvra\s*=\s*(1)\s*$/\1/ p' $sdb/settings.ini)
usevenvsi=$(sed -rn 's/^\s*usevenvsi\s*=\s*(1)\s*$/\1/ p' $sdb/settings.ini)

# Установка корректировки ширины вывода превью в дискретных скриптах
termcor=$(sed -rn 's/^\s*termcorrection\s*=\s*([-0-9]*)\s*$/\1/ p' $sdb/settings.ini)

# Переменные алфавита и служебных
RUUC="АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"                              # верхний регистр
rulc="абвгдеёжзийклмнопрстуфхцчшщъыьэюя"                              # нижний нижний регистр
RVUC="АЕЁИОУЫЭЮЯ"                                                     # гласные в верхнем регистре
rvlc="аеёиоуыэюя"                                                     # гласные в нижнем регистре
RUCl=$RUUC$rulc                                                       # алфавит в обоих регистрах
unxc=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")     # комбинирующие ударение и служебные знаки (U+0301, U+0320, U+0323, U+0324, U+032D, U+0330)
unxn=$(printf "\xe2\x80\xa4\xe2\x80\xa7")                             # некомбинирующие служебные (U+2024, U+2027)
unxs=$(printf "\xcc\x81")                                             # ударение (U+0301)
unxz=$(printf "\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0\xe2\x80\xa7") # комбинирующие, кроме ударения + символ паузы
unxa=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0\xe2\x80\xa7\xe2\x80\xa4") # все служебные и ударение
fkdt=$(printf "\xe2\x80\xa4")                                         # fake dot графическая симуляция точки (U+2024)
qtsd=$(printf "\x22\x27")                                             # кавычки " и ' (U+0022, U+0027)

inc=50	  # Количество строк для для обработки файла за один проход для скриптов sed

d2u () { if [[ -e "$backup" ]]; then printf '\e[36m%s \e[33m%s\e[0m\n' "Восстановлен бэкап:" "$backup"; crlf=$(file "$backup" | grep -o "CRLF"; );
            if [[ -n $crlf ]]; then dos2unix "$backup" &>/dev/null; fi; cp "$backup" "$book";
        else crlf=$(file "$book" | grep -o "CRLF"); if [[ -n $crlf ]]; then dos2unix "$book" &>/dev/null; fi; cp "$book" "$backup"; printf '\n'; fi; }

sedroll () { local lico=$(wc -l < "$1"); local i=0; local j=0; for i in $(seq 1 $inc $lico); do j=$(($i+$(($inc-1))));	sed -i -rf <(sed -n "$i,$j p" < "$1") "$2"; done; }

ms2sec () { awk -vms=$duration 'BEGIN {
                   D=int(ms/86400); Dr=ms%86400; if(D) { D=D " д " } else { D="" };
                   H=int(Dr/3600);  Hr=Dr%3600;  if(H) { Hs=sprintf("%d", H) ":" } else { Hs="" };
                   M=int(Hr/60);    Mr=Hr%60;    if(M) { if(H) {Ms=sprintf("%02d", M) ":"} else {Ms=sprintf("%d", M) ":" } } else { Ms="" };
                   if(M>=1) {S=sprintf("%05.2f %s", Mr, ".") } else { S=sprintf("%.2f %s", Mr, "сек.") };
                   durhum=D Hs Ms S; printf("%s", durhum) }'; }

rm_wdir () { if [[ -d "$bookwrkdir" ]]; then rm -rf "$bookwrkdir"; dir_rm=$(printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" "$bookwrkdir" "создана.");
                                      else dir_rm=$(printf "\n") ; fi }

if [[ $somo == "все" ]] || [[ $key == "-se" ]]; then key="-sg"; somo="$vso"; fi # Заглушка для -se : == -sg book.fb2 x1111 / -sw book.fb2 все

if [[ -s "$1" ]]; then book="$1"; backup="$book".$suf; key="-gg"; printf '\e[33m%s \e[93m%s\e[0m\n' "Ключи не заданы, но книга указана. Используем ключ:" "-gg"
  elif [[ -e "$2" ]]; then printf '\e[36m%s \e[33m%s\e[0m ' "Обрабатывается книга:" "$book"
  else printf '\e[35m%s \e[93m%s\e[0m\n' "Книга не задана или не существует. Использование:" "./momo.sh [ключ] book.fb2"; exit 1; fi

d2u;

# Дискретные скрипты пишутся в файл, который задан переменной obook
# Эта переменная имеет смысл ТОЛЬКО, если заново создаются скрипты в mano-$book, т.е. перед запуском скрипта её нужно удалить вручную. Если нужно.
obook="$book" # омографы пишутся в $book, т.е. в основной файл книги
#obook="$book".man # омографы пишутся в $book.man, т.е. в бэкап скрипта ./momo.sh
#obook="$book".yoy # омографы пишутся в $book.yoy, т.е. в бэкап скрипта ./yofik.sh
#obook="$book".nam # омографы пишутся в $book.nam, т.е. в бэкап скрипта ./lexxer.sh.

case $key in 
	-gg   )	main_do=1; single=0; swrd=0; sgrp=0; vse=0; fixomo=1; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;
	-ruac ) main_do=0; single=0; swrd=0; sgrp=0; vse=0; fixomo=0; disc_do=0; preview=0; morphy=0; rust=1; locdic=0; blist=0; wlist=0; rm_wdir ;;
 	-sist ) main_do=0; single=0; swrd=0; sgrp=0; vse=0; fixomo=0; disc_do=0; preview=0; morphy=0; rust=2; locdic=0; blist=0; wlist=0; rm_wdir ;;
  -sw   )	main_do=1; single=1; swrd=1; sgrp=0; vse=0; fixomo=1; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;
	-sg   ) main_do=1; single=1; swrd=0; sgrp=1; vse=0; fixomo=1; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;
# -se   ) main_do=1; single=1; swrd=0; sgrp=0; vse=1; fixomo=1; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;
	-x    ) main_do=1; single=0; swrd=0; sgrp=0; vse=0; fixomo=1; disc_do=1; preview=0; morphy=0; rust=0; locdic=1; blist=0; wlist=0;         ;;
	-xf   )	main_do=1; single=0; swrd=0; sgrp=0; vse=0; fixomo=1; disc_do=1; preview=0; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;
	-p    ) main_do=1; single=0; swrd=0; sgrp=0; vse=0; fixomo=0; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0;         ;;
	-pf   ) main_do=1; single=0; swrd=0; sgrp=0; vse=0; fixomo=0; disc_do=1; preview=1; morphy=0; rust=0; locdic=1; blist=0; wlist=0; rm_wdir ;;

	-f    ) # удалить директорию mano-book
		if [[ -d "$bookwrkdir" ]]; then rm -rf "$bookwrkdir" printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директория" "$bookwrkdir" "удалена."; exit 1
		else printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Директории" "$bookwrkdir" "не существует. Используйте другой ключ."; exit 1; fi ;;
	*) printf '\e[32m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n' "Задайте ключ или книгу. Например:" "./momo.sh -gg book.fb2" "или" "./momo.fb2 book.fb2"; exit 0 ;;
esac

msg_fmt=$(eval echo "'\e[36mЗадача: \e[32m%s\e[0m\n'")
case $key in 
  -gg   )	printf "$msg_fmt" "Обработка омографов, создание дискретных скриптов с превью."; ;;
	-ruac ) printf "$msg_fmt" "Обработка всего текста только ruaccent. Существующие ударения сохранены."; ;;
 	-sist ) printf "$msg_fmt" "Обработка всего текста только silero-stress. Существующие ударения сохранены."; ;;
  -sw   )	printf "$msg_fmt" "Обработка единственного омографа ( $somo )";
                  if [[ -z somo ]]; then printf '\e[36m%s\e[0m\n' "Отдельный омограф не задан. Выход."; exit 1; fi ;;
  -sg   ) printf "$msg_fmt" "Обработка группы омографов ( $somo )";
                  if [[ -z somo ]]; then printf '\e[36m%s\e[0m\n' "Код группы омографов не задан. Выход."; exit 1; fi ;;
	-se   ) printf "$msg_fmt" "Обработка омографа ( все́/всё )"; ;;
	-x    ) printf "$msg_fmt" "Обработка омографов, создание дискретных скриптов без превью. Рабочая директория сохранена."; ;;
  -xf   )	printf "$msg_fmt" "Обработка омографов, создание дискретных скриптов без превью. (-gg 'без превью')"; ;;
	-p    ) printf "$msg_fmt" "Создание дискретных скриптов с превью. Рабочая директория сохранена. Обработка омографов выключена."; ;;
	-pf   ) printf "$msg_fmt" "Создание дискретных скриптов с превью. Обработка омографов выключена."; ;;

	*) exit 0 ;;
esac


if [[ ! -d "$bookwrkdir" ]]; then mkdir "$bookwrkdir"
else printf '\e[35m%s \e[93m%s \e[35m%s \e[93m%s\e[0m\n' "Директория для дискретных скриптов" "$bookwrkdir" "существует. Удалите ее или запустите скрипт с ключом" "-f"; exit 1; fi

if [[ -s $aux/zaomo.md5   ]] && md5sum -c --status $aux/zaomo.md5   >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zjofik.md5  ]] && md5sum -c --status $aux/zjofik.md5  >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zndb.md5    ]] && md5sum -c --status $aux/zndb.md5    >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zstu.md5    ]] && md5sum -c --status $aux/zstu.md5    >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zuni.md5    ]] && md5sum -c --status $aux/zuni.md5    >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zdic.md5    ]] && md5sum -c --status $aux/zdic.md5    >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/yodef.md5   ]] && md5sum -c --status $aux/yodef.md5   >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/zdix.md5    ]] && md5sum -c --status $aux/zdix.md5    >/dev/null 2>&1; then clxx=0; else clxx=1; fi
if [[ -s $aux/classes.md5 ]] && md5sum -c --status $aux/classes.md5 >/dev/null 2>&1; then clxx=0; else clxx=1; fi

if [[ $clxx -eq "1" ]]; then
	if ./check-all.sh ; then printf '\e[32m%s\e[0m\n' "Проверка файлов завершена успешно…";
    if [[ -d "$bookstadir" ]]; then rm -rf "$bookstadir"; fi;
	else printf '\e[1;31m%s \e[93m%s \e[1;31m%s\e[0m\n' "Выполнение скрипта" "./momo.sh" "прервано! Исправьте ошибки в базах и повторите действие!"; exit 1; fi; fi

printf '\e[36m%s \e[93m%s\e[36m%s \e[93m%s\e[0m ' "В словаре Омографов:" $(zgrep -c ^ $sdb/mano-uc.gz) ", омографов:" $(zgrep -c ^ $sdb/mano-lc.gz)

# Конвертация в UTF-8, если нужно
#$edi -c "set nobomb | set fenc=utf8 | x" "$book"

sed -r  "/^\s*<binary/Q" "$book" | sed -r "s/\xc2\xa0/ /g" > "$bookwrkdir"/text-book.txt
sed -rn '/^\s*<binary/,$p' "$book" > "$bookwrkdir"/binary-book.txt
cp "$bookwrkdir"/binary-book.txt "$bookwrkdir"/text-book.bas
#booklico=$(wc -l < "$bookwrkdir"/binary-book.txt)

# Замены однозначных
mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
if [[ $fixomo == "1" ]]; then

  # Морфологическая обработка
  if [[ $morphy == "1" ]] || [[ $locdic == "1" ]]; then
   # Создать директорию статических файлов для текущей книги
   if md5sum -c --status "$bookstadir"/book_backup.md5 >/dev/null 2>&1; then
      printf '\e[36m%s \e[33m%s \e[36m%s\e[0m ' "Директория статических файлов для текущей книги" "$bookstadir" "существует.";
      printf "$dir_rm\n"
   else rm -rf "$bookstadir"; fi;
   if [[ ! -d "$bookstadir" ]]; then mkdir "$bookstadir"; md5sum $backup > "$bookstadir"/book_backup.md5; fi;
  fi

  # ===== Обработка некондиционных фраз из $sdb/rawstuff.gz ===============================================
  # Получить номера строк файла, где найдены такие фразы
          eSCAN=$($repper -Fnf <(zcat $sdb/rawstuff.gz | sed -r "s/^.[^#]+# \"(.+)\"$/\1/g; s/ё/е/g; s/Ё/Е/g; s/[$unxc]+//g") \
                <(cat "$bookwrkdir"/text-book.txt | sed -r "s/ё/е/g; s/Ё/Е/g; s/[$unxc]+//g" ) | awk 'BEGIN{FS=":"}{a=a "_" $1}END{ print substr(a,2)}');
  
  # Получить номера строк, где найдены выделенные капсом ударения в омографах.
           eSCAP=$(grep -Fnf <(zcat $aux/mano-ca.pat.gz) "$bookwrkdir"/text-book.txt | awk 'BEGIN{FS=":"}{a=a "_" $1}END{ print substr(a,2)}');
  
    # Запустить скрипт только для групп x0300 и x0301
    if [[ -n $eSCAN ]] || [[ -n $eSCAP ]] ; then
      sed -r '/^#_#_#txtmppra/,/^#_#_#txtmpprb/ {
              s/^#(.+#_#_# escomo !_#_!)$/\1/g;
              s/^#(.+#_#_# escaps !_#_!)$/\1/g;
              s/^(.+#_#_# foricycle !_#_!)$/#\1/g;
              s/^(.+#_#_# all_omos !_#_!)$/#\1/g}' $sdb/main.awk > "$bookstadir/"main_esc.awk
  
      awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" \
          -vescan="$eSCAN" -vescap="$eSCAP" -vnoredix=1 -vvso="$vso" -f "$bookstadir/"main_esc.awk "$bookwrkdir"/text-book.txt > "$bookwrkdir"/text-book.bas
  
      mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
      LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Обработка словаря исключений:" $durhum
    fi # ====================================================================================================
  
  if [[ $morphy == "1" ]]; then
   # Создать копию текст книги и морфологией с помощью morphy << начало блока morphy
   
     if [[ $morphy_is == "1" ]]; then
   
       if [[ -s "$bookstadir"/text-book.scy ]] && md5sum -c --status "$bookstadir"/text.shy.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.shy.md5 "OK: файл с разметкой SpaCy уже создан.";
       else
          sed -r "s/[$unxc]+//g;
                  s/[$unxn]/./g;
                  s/([$RUUC])([$RUUC]+)/\1\L\2/g;
                  s/<[-a-zA-Z_/.,;:#?! ]+>//g" "$bookwrkdir"/text-book.txt | \
          python3 $sdb/pye/rulg_omo.py $sdb/omo_list.phy.gz > "$bookstadir"/text-book.scy
          #python3 $sdb/pye/rulg_all.py $sdb/omo_list.phy > "$bookstadir"/text-book.scy
      
          md5sum "$bookstadir"/text-book.scy "$bookwrkdir"/text-book.txt $sdb/pye/rulg_omo.py $sdb/pye/rulg_all.py > "$bookstadir"/text.shy.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по SpaCy:" $durhum
       fi;
    fi;
    if [[ $morphy_is == "2" ]]; then
   
       if [[ -s "$bookstadir"/text-book.nat ]] && md5sum -c --status "$bookstadir"/text.nhy.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.nhy.md5 "OK: файл с разметкой Natasha уже создан.";
       else
          sed -r "s/[$unxc]+//g;
                  s/[$unxn]/./g;
                  s/([$RUUC])([$RUUC]+)/\1\L\2/g;
                  s/<[-a-zA-Z_/.,;:#?! ]+>//g" "$bookwrkdir"/text-book.txt | \
          python3 $sdb/pye/natru_omo.py $sdb/omo_list.phy.gz > "$bookstadir"/text-book.nat
      
          md5sum "$bookstadir"/text-book.nat "$bookwrkdir"/text-book.txt $sdb/pye/natru_omo.py > "$bookstadir"/text.nhy.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по Natasha:" $durhum
       fi;
    fi;
    if [[ $morphy_is == "3" ]]; then
   
       if [[ -s "$bookstadir"/text-book.bet ]] && md5sum -c --status "$bookstadir"/text.bhy.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.bhy.md5 "OK: файл с разметкой Natasha уже создан.";
       else
          source work/beta_1/.venv/bin/activate
            sed -r "s/[$unxc]+//g;
                    s/[$unxn]/./g;
                    s/([$RUUC])([$RUUC]+)/\1\L\2/g;
                    s/<[-a-zA-Z_/.,;:#?! ]+>//g" "$bookwrkdir"/text-book.txt | \
            python3 work/beta_1/omorpher.py > "$bookstadir"/text-book.bet
          deactivate
      
          md5sum "$bookstadir"/text-book.nat "$bookwrkdir"/text-book.txt > "$bookstadir"/text.bhy.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по Natasha:" $durhum
       fi;
    fi;
    if [[ $morphy_is == "4" ]]; then
   
       if [[ -s "$bookstadir"/text-book.rnn ]] && md5sum -c --status "$bookstadir"/text.rhy.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.rhy.md5 "OK: файл с разметкой RNNTagger уже создан.";
       else
          source .venvra/bin/activate
            python3 work/RNNTagger/pye/rnntag.py "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.rnn scriptdb/omo-list.gz \
                   --tt-path=work/RNNTagger/rnn-tagger-russian.sh
          deactivate
      
          md5sum "$bookstadir"/text-book.rnn "$bookwrkdir"/text-book.txt > "$bookstadir"/text.rhy.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по Natasha:" $durhum
       fi;
    fi;
    if [[ $morphy_is == "5" ]]; then
   
       if [[ -s "$bookstadir"/text-book.mac ]] && md5sum -c --status "$bookstadir"/text.mcy.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.rhy.md5 "OK: файл с разметкой mawo-core уже создан.";
       else
          source .maco/bin/activate
            sed -r "s/[$unxc]+//g;
                    s/[$unxn]/./g;
                    s/([$RUUC])([$RUUC]+)/\1\L\2/g;
                    s/<[-a-zA-Z_/.,;:#?! ]+>//g" "$bookwrkdir"/text-book.txt | \
            python3 $sdb/pye/mawo_core.py $sdb/omo_list.phy.gz > "$bookstadir"/text-book.mac
          deactivate
      
      
          md5sum "$bookstadir"/text-book.mac "$bookwrkdir"/text-book.txt > "$bookstadir"/text.mcy.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по mawo-core:" $durhum
       fi;
    fi;
    if [[ $morphy_is == "6" ]]; then
   
       if [[ -s "$bookstadir"/text-book.tag ]] && md5sum -c --status "$bookstadir"/text.tag.md5 >/dev/null 2>&1; then
          printf '\e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Файлы в" "$bookstadir"/text.tag.md5 "OK: файл с разметкой DeepPavlov уже создан.";
       else
          source .dp/bin/activate
            sed -r "s/[$unxc]+//g;
                    s/[$unxn]/./g;
                    s/([$RUUC])([$RUUC]+)/\1\L\2/g;
                    s/<[-a-zA-Z_/.,;:#?! ]+>//g" "$bookwrkdir"/text-book.txt | \
            python3 $sdb/pye/dp_tag.py $sdb/omo_list.phy.gz > "$bookstadir"/text-book.tag
          deactivate
      
      
          md5sum "$bookstadir"/text-book.tag "$bookwrkdir"/text-book.txt > "$bookstadir"/text.tag.md5
          mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
          LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Создана копия книги с морфологией строк по DeepPavlov:" $durhum
       fi;
    fi;
  fi;
  # << Конец блока morphy

  # 
  case $morphy_is in
  
    1) if [[ -s "$bookstadir"/text-book.scy ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
         "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.scy > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
    2) if [[ -s "$bookstadir"/text-book.nat ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
         "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.nat > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
    3) if [[ -s "$bookstadir"/text-book.bet ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
         "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.bet > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
    4) if [[ -s "$bookstadir"/text-book.rnn ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
           "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.rnn > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
    5) if [[ -s "$bookstadir"/text-book.mac ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
           "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.mac > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
    6) if [[ -s "$bookstadir"/text-book.tag ]]; then
         awk '{if (FNR==NR) { a[FNR]=$0 } else { b[FNR]=$0 } }; END { for(i in a) print a[i] "<@##@##@>" b[i] }' \
           "$bookwrkdir"/text-book.txt "$bookstadir"/text-book.tag > "$bookwrkdir"/text-book.bast
         mv "$bookwrkdir"/text-book.bast "$bookwrkdir"/text-book.bas
       fi; ;;
     *)    ;;
  esac
  
  if [[ $locdic == "1" ]]; then
  # Создать локальные для книги словари для уменьшения используемой памяти << locdic
  
   # Список слов
   if [[ -s "$bookstadir"/bookwords.list ]] && md5sum -c --status "$bookstadir"/locdic.md5 >/dev/null 2>&1; then
  	   locdicsize=$(cat "$bookstadir"/bookwords.list | wc -l)
       printf '\e[36m%s \e[33m%s \e[36m%s \e[93m%s\e[0m\n' "Файлы в" "$bookstadir"/locdic.md5 "OK: файлы локальных словарей уже созданы. Словоформ:" $locdicsize;
   else
       printf '\e[36m%s \e[33m%s \e[36m%s \e[33m%s \e[36m%s\e[0m\n' \
              "Первый запуск для файла" $book ": создание списков слов из локальных словарей в" "$bookstadir" "Подождите...";
   sed -r 's/^/ /g' "$bookwrkdir"/text-book.txt | grep -Eo "[$RUUC$rulc$unxc-]+" |\
       sed -r "s/[$unxc]+//g;
               s/^.*$/\L\0/g;
               s/ё/е/g;
               s/^.*$/_\0=/g;
               s/^(.*)-(.*)$/\0\n\1=\n_\2/g
               s/^(.*)-(.*)$/\0\n\1=\n_\2/g
               s/^(.*)-(.*)$/\0\n\1=\n_\2/g" | sed -r "s/^_-/_/; s/-=$/=/" | sort -u > "$bookstadir"/bookwords.list
       locdicsize=$(cat "$bookstadir"/bookwords.list | wc -l )
  
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_gl.gz   | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_gl.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_prl.gz  | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_prl.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_prq.gz  | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_prq.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_rest.gz | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_rest.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_suw.gz  | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_suw.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/dic_prop.gz | sed -r "s/^([^ ]+)/_\1=/") | sed -r "s/^_([^=]+)=/\1/" | $zipper > "$bookstadir"/dic_prop.gz
   grep -Ff "$bookstadir"/bookwords.list <(zcat $sdb/namebase.gz)                                                         | $zipper > "$bookstadir"/namebase.gz
  
     md5sum "$bookstadir"/bookwords.list "$bookwrkdir"/text-book.txt $sdb/dic_gl.gz $sdb/dic_prl.gz $sdb/dic_prq.gz $sdb/dic_rest.gz $sdb/dic_suw.gz \
             $sdb/dic_prop.gz "$bookstadir"/dic_gl.gz "$bookstadir"/dic_prl.gz "$bookstadir"/dic_prq.gz "$bookstadir"/dic_rest.gz "$bookstadir"/dic_suw.gz \
             "$bookstadir"/dic_prop.gz $sdb/dix_prq.gz $sdb/namebase.gz > "$bookstadir"/locdic.md5
  
     mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
     LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s \e[36m%s \e[93m%s\e[0m\n' "Подготовка локальных словарей из словоформ в книге:" $durhum "Словоформ:" $locdicsize;
   fi;

   if [[ -s "$bookstadir"/classes.bin ]] && md5sum -c --status "$bookstadir"/classes.md5 >/dev/null 2>&1; then
       printf '\e[36m%s\n' "OK: база classes.bin создана.";
   else 
     echo "" | awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$sdb/"main.awk 2>&1 > /dev/null;
     mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
     LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\n' "Создание базы AWK:" $durhum;
   fi;
  fi; # << Конец блока создания локальных словарей
  
  # Проверить наличие необработанных "все": если есть, применить все правила, иначе выключить пару "все/всё"
  yops=$(grep -io "[^$unxc]\bвсе\b[^$unxc]" "$bookwrkdir"/text-book.txt | wc -l)
  
  if [[ ! $single -eq 1 ]]; then

      cp $sdb/main.awk "$bookstadir"/main.awk
      if [[ $do_parallel -eq 1 ]]; then
        printf '\e[32m%s \e[33m%s\e[0m\n' "GNU Parallel:" "$paraopts_awk"
        parallel --env $paraopts_awk "$bookwrkdir"/text-book.bas \
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk > "$bookwrkdir"/text-book.awk.txt
      else
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk "$bookwrkdir"/text-book.bas > "$bookwrkdir"/text-book.awk.txt
      fi # do_parallel
  
      mv "$bookwrkdir"/text-book.awk.txt "$bookwrkdir"/text-book.txt
  
      yope=$(grep -io "[^$unxc]\bвсе\b[^$unxc]" "$bookwrkdir"/text-book.txt| wc -l)
      LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s \e[36m%s \e[93m%s \e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Основная обработка:" $durhum "Остаток 'все':" $yope "из" $yops "."
      mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
#    printf '\e[36m%s\e[0m\n' "Необработанных 'все' не найдено."
 #  fi # все
  else
    # обработка только одного омографа
    if [[ $swrd -eq 1 ]]; then
#             s/^(.+#_#_# vsez !_#_!)$/#\1/g;
      sed -r '/^#_#_#txtmppra/,/^#_#_#txtmpprb/ {
              s/^(.+#_#_# all_omos !_#_!)$/#\1/g;
              s/^#([^"]+")dummy(".+#_#_# single_word !_#_!)$/\1'$somo'\2/g}' $sdb/main.awk > "$bookstadir"/main.awk
  
      if [[ $do_parallel -eq 1 ]]; then
        printf '\e[32m%s \e[33m%s\e[0m\n' "GNU Parallel:" "$paraopts_awk"
        parallel --env $paraopts_awk "$bookwrkdir"/text-book.bas \
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk > "$bookwrkdir"/text-book.awk.txt
      else
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk "$bookwrkdir"/text-book.bas > "$bookwrkdir"/text-book.awk.txt
      fi # do_parallel
  
      mv "$bookwrkdir"/text-book.awk.txt "$bookwrkdir"/text-book.txt
      mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
    fi #
  
    # обработка только одной группы омографов
    if [[ $sgrp -eq 1 ]]; then
#             s/^(.+#_#_# vsez !_#_!)$/#\1/g;
      sed -r '/^#_#_#txtmppra/,/^#_#_#txtmpprb/ {
              s/^(.+#_#_# all_omos !_#_!)$/#\1/g;
              s/^#([^"]+")dummy(".+#_#_# single_group !_#_!)$/\1'$somo'\2/g}' $sdb/main.awk > "$bookstadir"/main.awk
  
      if [[ $do_parallel -eq 1 ]]; then
        printf '\e[32m%s \e[33m%s\e[0m\n' "GNU Parallel:" "$paraopts_awk"
        parallel --env $paraopts_awk "$bookwrkdir"/text-book.bas \
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk > "$bookwrkdir"/text-book.awk.txt
      else
        awk -vindb="$sdb/" -vinax="$aux/" -vbkphydir="$bookstadir/" -vlocdic="$bookstadir/" -vmorphy_on="$morphy" -vmorphy_yo="$morphy_yo" -vvso="$vso" \
            -f "$bookstadir"/main.awk "$bookwrkdir"/text-book.bas > "$bookwrkdir"/text-book.awk.txt
     fi # do_parallel
  
      mv "$bookwrkdir"/text-book.awk.txt "$bookwrkdir"/text-book.txt
      mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
      #printf '\e[36m%s\e[0m\n' "Необработанных 'все' не найдено."
    fi # 
  fi
  
 fi # fixomo?

if [[ $main_do -eq 1 ]]; then # main_do
  # Списки слов всех омографов с маленькой и с Большой буквы
  
  grep -Po "(?<=[^$RUUC$rulc$unxc])[$rulc$unxc]+" "$bookwrkdir"/text-book.txt | grep -Ev "[$unxc]" | sed -r 's/^.+$/_\0=/g' | grep -Ff <(zcat $aux/mano-lc.pat.gz) | \
  	sort -u > "$bookwrkdir"/manofi-lc.pat
  
  grep -Po "(?<=[^$RUUC$unxc])[$RUUC$unxc]+" "$bookwrkdir"/text-book.txt | grep -Ev "[$unxc]" | sed -r 's/^.+$/_\0=/g' | grep -Ff <(zcat $aux/mano-cc.pat.gz) | \
  	sort -u > "$bookwrkdir"/manofi-cc.pat
  
  grep -Po "(?<=[^$RUUC$rulc$unxc])[$RUUC$unxc][$rulc$unxc]+" "$bookwrkdir"/text-book.txt | grep -Ev "[$unxc]" | sed -r 's/^.+$/_\0=/g' | grep -Ff <(zcat $aux/mano-uc.pat.gz) | \
  	sort -u > "$bookwrkdir"/manofi-uc.pat
  
  # Список всех омографов в обоих регистрах
  #zgrep -Ff "$bookwrkdir"/manofi-uc.pat $sdb/mano-uc.gz >  "$bookwrkdir"/mano-luc.txt
  zgrep -Ff "$bookwrkdir"/manofi-lc.pat $sdb/mano-lc.gz                                                        > "$bookwrkdir"/mano-luc.txt
  zcat $sdb/mano-lc.gz $sdb/mano-uc.gz | sed -r "s/([_ ])(.)/\1\u\2/g" | grep -Ff "$bookwrkdir"/manofi-uc.pat >> "$bookwrkdir"/mano-luc.txt
  zcat $sdb/mano-lc.gz $sdb/mano-uc.gz | sed -r "s/.*/\U\0/g"          | grep -Ff "$bookwrkdir"/manofi-cc.pat >> "$bookwrkdir"/mano-luc.txt
  
  if [[ $disc_do -eq 1 && -s "$bookwrkdir"/mano-luc.txt ]]; then # Проверяем найдено ли хоть что-то из омографов… discretchk 0
    sed -r "
           s/^_(.+)=/\1/g
           s/\x27/\xcc\x81/g
#          s/\\\xcc\\\xa0/\xcc\xa0/g
#          s/\\\xcc\\\xa3/\xcc\xa3/g
#          s/\\\xcc\\\xa4/\xcc\xa4/g
#          s/\\\xcc\\\xad/\xcc\xad/g
#          s/\\\xcc\\\xb0/\xcc\xb0/g
           " "$bookwrkdir"/mano-luc.txt | sort -u > "$bookwrkdir"/omo-luc.lst
    
    mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_time0 | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
    LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Всего обработка омографов заняла:" $durhum 
    
    # Формируем дискретные скрипты пословно
    printf '\e[32m%s ' "Идет поиск омографов для дискретных скриптов … подождите."
    
    if [[ $preview -eq 1 ]]; then printf '\e[32m%s' "Превью текста включено."
    else printf '\e[36m%s\n' "Превью текста выключено."; fi
    twd=$(tput cols)
    
    # Определяем дефолтный результат словаря lexx
     zgrep -Ff <(sed -r 's/^([^ ]+) .*/_\l\1=/g' "$bookwrkdir"/omo-luc.lst | sort -u) $sdb/uniomo.gz |\
            	   sed -r 's/_([^=]+)(=.+)$/\1=#\2/'| sed "s/\x27/\xcc\x81/" > "$bookwrkdir"/omo-lexx.txt
    
    #zgrep -Ff <(grep -Fof <(zcat $aux/ttspat.$suf.gz) <(sed -r 's/^([^ ]+) .*/_\l\1=/g' "$bookwrkdir"/omo-luc.lst | sort -u)) $aux/tts0.$suf.gz |\
    #       	sed -r 's/_([^"=]+)(\"=\"\s.+\")$/\1#\" \1\2/' | sed -r 's/_([^=]+)(=.+)$/\1=#\1\2/'| sed "s/\x27/\xcc\x81/" > "$bookwrkdir"/omo-lexx.txt
    
      sed -r "s/\xe2\x80\xa4/./g; s/\xe2\x80\xa7//g" "$bookwrkdir"/text-book.txt | \
        awk -vobook=$obook -vtwd=$twd -vpreview=$preview -vtermcor=$termcor -veditor=$edi -vbkwrkdir="$bookwrkdir/" -vindb="$sdb/" \
            -vswrd=$swrd -vsgrp=$sgrp -vsomo=$somo -f $sdb/preview.awk 
    
    shopt -s nullglob; shfiles=("$bookwrkdir"/*.sh); shquan=${#shfiles[@]}; shopt -u nullglob;
    if [[ $shquan -eq 0 ]]; then totnum=0; else totnum=$(cat "$bookwrkdir"/totnum); chmod +x "$bookwrkdir"/*.sh; fi

    printf '\e[36m%s \e[093m%s \e[36m%s \e[093m%s \e[0m' "Создано дискретных скриптов:" $shquan "Всего остаток омографов:" $totnum
    
    mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
    LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Время:" $durhum 
    
    # Собираем книгу и удаляем временные файлы
    cat "$bookwrkdir"/text-book.txt "$bookwrkdir"/binary-book.txt > "$book"
    
  else # Если не нашли омографов для ручной обработки discretchk 0
  	noomo=1
  	cat "$bookwrkdir"/text-book.txt "$bookwrkdir"/binary-book.txt > "$book"
  	printf '\e[36m%s \e[093m%s \e[36m%s\e[0m\n' "Однозначные обработаны, омографов для ручной обработки" "НЕ" "найдено."
  	rm -rf "$bookwrkdir"
  fi # discretchk 0
fi #main_do

if [[ $rust -eq 1 ]]; then # Обработать текст ruaccent’ом
	noomo=1
  debug=1
  if [[ $usevenvra -eq 1 ]]; then source .venvra/bin/activate; fi

  # Найти и добавить путь к CUDA/cuDNN библиотекам -- установить в окружение .venvra пакет nvidia-cudnn-cu12
  CUDNN_PATH=$(find "$VIRTUAL_ENV" -name "libcudnn.so.9" 2>/dev/null | head -1)

  if [ -n "$CUDNN_PATH" ]; then
    CUDNN_DIR=$(dirname "$CUDNN_PATH")
    export LD_LIBRARY_PATH="${CUDNN_DIR}:${LD_LIBRARY_PATH}"
  # echo "✓ Добавлен путь к CUDA: $CUDNN_DIR"
  else
    echo "⚠ libcudnn.so.9 не найдена в $VIRTUAL_ENV"
  fi

	printf '\e[36m%s \e[36m%s\e[0m\n' "Обработка ruaccent’ом:"
  python $sdb/pye/ruac.py $ruac_opt "$bookwrkdir"/text-book.txt > "$bookwrkdir"/text-book.rua.txt
  mv "$bookwrkdir"/text-book.rua.txt "$bookwrkdir"/text-book.txt
	cat "$bookwrkdir"/text-book.txt "$bookwrkdir"/binary-book.txt > "$book"
  rm -rf "$bookwrkdir"
  mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
  LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Время:" $durhum 
  if [[ $usevenvra -eq 1 ]]; then deactivate; fi
fi 

if [[ $rust -eq 2 ]]; then # Обработать текст silero-stress’ом
	noomo=1
  debug=1
  if [[ $usevenvsi -eq 1 ]]; then source .venvsi/bin/activate; fi
	printf '\e[36m%s \e[36m%s\e[0m\n' "Обработка silero-stress’ом:"
  python $sdb/pye/sist.py $ruac_opt "$bookwrkdir"/text-book.txt > "$bookwrkdir"/text-book.sist.txt
  mv "$bookwrkdir"/text-book.sist.txt "$bookwrkdir"/text-book.txt
	cat "$bookwrkdir"/text-book.txt "$bookwrkdir"/binary-book.txt > "$book"
  rm -rf "$bookwrkdir"
  mo_cur=$(date +%s.%N); duration=$( echo $mo_cur - $mo_prev | bc ); mo_prev=$mo_cur; durhum=$(ms2sec);
  LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Время:" $durhum 
  if [[ $usevenvsi -eq 1 ]]; then deactivate; fi
fi 

mo_prev=$(date +%s.%N); duration=$( echo $mo_prev - $mo_time0 | bc ); durhum=$(ms2sec);

# Отладка: поиск искажений текста в "пастеризованных" версиях исходника и результата dbgchk 0
if [[ debug -eq 1 ]]; then
	# "Пастеризация": всё в нижний регистр, ё -> е, удалить служебные и ударения
	sed -r "
		s=\.\.\.=…=g
		s=\xc2\xa0= =g
		s=(\S)\s+=\1 =g
		s=(<p>)\s+=\1=gI
		s=\s+(<\/p>)=\1=gI
		s=\xe2\x80\xa4=.=g
		s=\xe2\x80\xa7==g
		s=\xcc\xa0==g
		s=\xcc\xa3==g
		s=\xcc\xa4==g
		s=\xcc\xad==g
		s=\xcc\xb0==g
		s=\xcc\x81+==g
		s=Ё=Е=g
		s=ё=е=g
		" "$book".$suf > "$book".0
		if [[ $nocaps -eq 1 ]]; then sed -ri 's=^.*$=\L\0=g' "$book".0; fi

	sed -r "
		s=\xe2\x80\xa4=.=g
		s=\xe2\x80\xa7==g
		s=\xcc\xa0==g
		s=\xcc\xa3==g
		s=\xcc\xa4==g
		s=\xcc\xad==g
		s=\xcc\xb0==g
		s=\xcc\x81+==g
		s=Ё=Е=g
		s=ё=е=g
		s=\t+= =g
		" "$book" > "$book".1
		if [[ $nocaps -eq 1 ]]; then sed -ri 's=^.*$=\L\0=g' "$book".1; fi

	diff "$book".0 "$book".1 > "$book".diff
	end=$(date +%s.%N)

	if [[ -s "$book".diff ]]; then $edi -d "$book".0 "$book".1;
	else rm "$book".0 "$book".1 "$book".diff ;
		if [[ $nocaps -eq 1 ]]; then
			printf '\e[1;4;32m%s\e[0m \e[32m%s \e[93m%s\e[0m\n' "DEBUG:" "пастеризованные файлы идентичны." "Капсы убраны";
  		else
			printf '\e[1;4;32m%s\e[0m \e[32m%s \e[36m%s\e[0m\n' "DEBUG:" "пастеризованные файлы идентичны." "Капсы оставлены";
		fi
	fi
  mo_prev=$(date +%s.%N); duration=$( echo $mo_prev - $mo_time0 | bc ); durhum=$(ms2sec);
fi # dbgchk 0

LC_ALL="en_US.UTF-8" printf '\e[36m%s \e[93m%s \e[36m%s\e[0m\n' "Общее время работы скрипта:" $durhum 
if [[ ! $noomo -eq 1 ]]; then printf '\e[36m%s \e[33m%s \e[36m%s \e[33m%s\e[0m\n' "Дискретные скрипты в" "$bookwrkdir" "обрабатывают файл:" "$obook" ; fi
printf '\e[32;4;1m%s\e[0m \e[36m%s \e[33m%s \e[36m%s \e[36m%s \e[33m%s\e[0m\n' "\"Ручные омографы:\"" "Файл" "$book" "обработан." "Бэкап:" "$backup"

