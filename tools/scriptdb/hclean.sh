#!/bin/bash

# Служебная утилита
# key:
#  ord        перенумеровать все правила во всех рабочих скриптах и отсортировать строки
#  spell_flat все слова словарей без ё и ударений -- словарь ударений для vim
#  spell_all  все слова словарей с именами, ё, ударениями и служебными символами -- словарь ударений для vim
#  ddic       поиск в dic_*.gz дублей с разной основой (предотвратить затирание в памяти первой формы)
#  unis       генерирует словари ударений

key="$1"
# Установка редактора: vim или neovim
edi=$(sed -rn 's/^\s*editor\s*=\s*(vim|nvim)\s*$/\1/ p' settings.ini)
vimspelldir="$HOME/.config/nvim/spell"
cdata=$(date)

if command -v pigz >/dev/null 2>&1; then zipper="pigz -9"; else zipper="gzip -9"; fi
 grepper="rg"
#grepper="grep"

# Переменные алфавита и служебных
RUUC=АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ
rulc=абвгдеёжзийклмнопрстуфхцчшщъыьэюя
RVUC=АЕЁИОУЫЭЮЯ
rvlc=аеёиоуыэюя
unxc=$(printf "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")
unxa=$(printf "\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0")
unxs=$(printf "\xe2\x80\xa4\xe2\x80\xa7")

# Массив со списком обязательных файлов
pack="automo.gz awx/beautify.awk class.list.gz classes.awk cstauto.awk cstring.awk defunct.awk deomo.awk demorphy.awk dic_cust.gz \
      dic_gl.gz dic_prl.gz dic_prq.gz dic_rest.gz dic_suw.gz fb2 functions.awk awx/gw_caplists.awk hclean.sh ist.gz main.awk mano-lc.gz \
      mano-uc.gz namebase.gz namedef.awk omo_list.phy.gz yoyo.gz yoyo_alt.gz preview.awk pye/ruac.py pye/rulg_all.py pye/rulg_omo.py \
      settings.ini unistress.gz unistrehy.gz yodef.awk yodef.gz yodhy.gz yolc.gz yomo-lc.gz yomo-uc.gz ext/x4707.awk ext/x4709.awk \
      dic_prop.gz awx/rules_sort.awk cstrings.gz awx/sort_gzstrings.awk awx/gen_prq.awk dix_prq.gz awx/parser.awk xmd/xmods.py"
read -a minpack <<< $pack

# Проверка не потерялось ли чего
for f in "${minpack[@]}"; do
	if [[ ! -s $f ]]; then printf '\e[31;5;1m%s\e[0m \e[93m%s\e[0m\n' "Отсутствует файл:" $f; exit 1; fi; done

ms2sec () { awk -vms=$duration 'BEGIN {
                   D=int(ms/86400); Dr=ms%86400; if(D) { D=D " д " } else { D="" };
                   H=int(Dr/3600);  Hr=Dr%3600;  if(H) { Hs=sprintf("%d", H) ":" } else { Hs="" };
                   M=int(Hr/60);    Mr=Hr%60;    if(M) { if(H) {Ms=sprintf("%02d", M) ":"} else {Ms=sprintf("%d", M) ":" } } else { Ms="" };
                   if(M>=1) {S=sprintf("%05.2f %s", Mr, ".") } else { S=sprintf("%.2f %s", Mr, "сек.") };
                   durhum=D Hs Ms S; printf("%s", durhum) }'; }
           
create_backup() {
    local file=$1; [[ ! -s $file ]] && return
    local last_backup_num=$(ls "$file".* 2>/dev/null | grep -oE '[0-9]+' | sort -n | tail -1)
    local new_backup_num=${last_backup_num:-0};  ((new_backup_num++))
    mv "$file" "$file.$new_backup_num" && echo "Создан бэкап: $file.$new_backup_num"; }            
case $key in
    ord ) # перенумеровать все правила во всех рабочих скриптах и отсортировать строки
       awky="deomo.awk";       awk -vLETT="R" -f awx/rules_sort.awk $awky | awk -f awx/beautify.awk > $awky"_ord"; mv $awky"_ord" $awky;
       awky="defunct.awk";     awk -vLETT="D" -f awx/rules_sort.awk $awky | awk -f awx/beautify.awk > $awky"_ord"; mv $awky"_ord" $awky;
       awky="ext/x1111.awk";   awk -vLETT="V" -f awx/rules_sort.awk $awky | awk -f awx/beautify.awk > $awky"_ord"; mv $awky"_ord" $awky;
       awky="ext/x4707.awk";   awk -vLETT="Z" -f awx/rules_sort.awk $awky | awk -f awx/beautify.awk > $awky"_ord"; mv $awky"_ord" $awky;
       awky="ext/x4709.awk";   awk -vLETT="X" -f awx/rules_sort.awk $awky | awk -f awx/beautify.awk > $awky"_ord"; mv $awky"_ord" $awky;

       awky="cstring.awk";     awk -f awx/beautify.awk $awky > $awky"_ord"; mv $awky"_ord" $awky;
       awky="cstauto.awk";     awk -f awx/beautify.awk $awky > $awky"_ord"; mv $awky"_ord" $awky;
       awky="classes.awk";     awk -f awx/beautify.awk $awky > $awky"_ord"; mv $awky"_ord" $awky;
       awky="awx/parser.awk";  awk -f awx/beautify.awk $awky > $awky"_ord"; mv $awky"_ord" $awky;
       awky="awx/gen_prq.awk"; awk -f awx/beautify.awk $awky > $awky"_ord"; mv $awky"_ord" $awky;

       awk -f awx/parser.awk deomo.awk defunct.awk yodef.awk ext/x4707.awk ext/x4709.awk ext/x1111.awk;

       # Проверка состояния системы automo
       awk -f awx/automo_check.awk

       # сортировка cstrings.gz
       zcat cstrings.gz | awk -f awx/sort_gzstrings.awk | $zipper > cstrings_ord.gz; mv cstrings_ord.gz cstrings.gz
       # gen_prq -- генерируем полный словарь причастий
       if md5sum -c --status <(cat awx/dix_prq.md5) >/dev/null 2>&1; then
           printf '\e[36m%s \e[36m%s\e[0m\n' "Словарь причатий не изменился.";
       else
          printf '\e[36m%s \e[36m%s\e[0m\n' "Генерация словаря причастий...";
          zcat dix_prq.gz | awk -f awx/gen_prq.awk | sort -u | $zipper > dic_prq.gz
          md5sum dix_prq.gz dic_prq.gz > awx/dix_prq.md5;
       fi;

       # ddic -- поиск дублей с разной основой
       zcat dic_cust.gz dic_gl.gz dic_prl.gz dic_prq.gz dic_rest.gz dic_suw.gz | \
         awk '{ if ( f1 == $1 && f2 == $2 )  {printf("\033[91m%s\n\033[0m", $0); fnd=1}; f1=$1; f2=$2; }
                END { if(!fnd) printf("\033[32m%s\n\033[0m", "ord: дублей с разной основой не надено.")}' ;
       exit 1; ;;

    spell_flat ) # все слова словарей без ё и ударений
               zcat dic_*.gz | awk '{print $1}' > ru.txt
               zcat dic_prop.gz | awk '{ if ( ! $4 ) printf("%s\n", $1)}' | sort -u >> ru.txt
               zcat mano-lc.gz yomo-lc.gz |sed -r "s/[_=']//g; s/ё/е/g; s/ /\r/g" >> ru.txt
               zcat yodef.gz yodhy.gz yolc.gz |sed -r "s/[_']//g; s/ё/е/g; s/=/\r/g;" >> ru.txt
               sed -r "s/\\\xcc\\\x81//g
                       s/\\\xcc\\\xa0//g
	                     s/\\\xcc\\\xa3//g
	                     s/\\\xcc\\\xa4//g
	                     s/\\\xcc\\\xad//g
	                     s/\\\xcc\\\xb0//g
                      " ru.txt |  sort -u > ruflat.txt
               $edi -c "mkspell! ru ruall.txt" +qall
               rm ru.txt ruall.txt
               mv -fv ru.utf-8.spl ~/.config/nvim/spell/ru.utf-8.spl
               printf "Список ruflat.txt: без ударений, ё, служебных символов. В vim: mkspell! ru ruflat.txt\n"
       exit 1; ;;

    spell_all ) # все слова словарей с именами, ё, ударениями и служебными символами
               zcat dic_*.gz | awk '{ if ( ! $4 ) printf("%s\n", $1)}' | sort -u > ru.txt
               zcat dic_prop.gz | awk '{ if ( ! $4 ) printf("%s\n", $1)}' | sort -u >> ru.txt
               zcat mano-lc.gz mano-uc.gz  |sed -r "s/[_=]//g; s/ /\n/g" >> ru.txt
               zcat yodef.gz yodhy.gz |sed -r "s/_//g; s/=/\n/g;" >> ru.txt
               zcat unistress.gz unistrehy.gz yoyo.gz yoyo_lc.gz |sed -r "s/_//g; s/=/\n/g;" >> ru.txt
               zcat namebase.gz |\
                    sed -r "s/(=\\\\xcc\\\\x[ab][034d])([$rulc])/\1\u\2/g
                            s/([_=])([$rulc])/\1\u\2/g
                            s/[_g]//g
                            s/=/\n/g" >> ru.txt
               zcat stray.gz names_raw.gz >> ru.txt # stray = некондиция; names_raw = имена без ударений. Только для спеллинга.
               sed -r "s/([$RVUC$rvlc])'/\1\xcc\x81/g
	                     s/\\\xcc\\\xa0/\xcc\xa0/g
	                     s/\\\xcc\\\xa3/\xcc\xa3/g
	                     s/\\\xcc\\\xa4/\xcc\xa4/g
	                     s/\\\xcc\\\xad/\xcc\xad/g
	                     s/\\\xcc\\\xb0/\xcc\xb0/g
                      " ru.txt |  sort -u > ruall.txt
               grep "[$unxa]" ruall.txt | sed -r "s/([$RVUC$rvlc])'/\1\xcc\x81/g; s/[$unxa]//g" | sort -u > ru.txt
               cat ru.txt >> ruall.txt
               $edi -c "mkspell! ru ruall.txt" +qall
               rm ru.txt ruall.txt
               mv -fv ru.utf-8.spl $vimspelldir/ru.utf-8.spl
#              printf "Список ruall.txt: с ударениями в омографах, ё, служебными символами! В vim: mkspell! ru ruall.txt\n"
               printf "\e[32m%s \e[36m%s \e[33m%s%s \e[36m%s\e[m\n" \
                 "$cdata" 'Установлен файл' $vimspelldir "/ru.utf-8.spl" 'с ударениями в омографах, ё, служебными символами.'
       exit 1; ;;

    ddic ) # поиск в dic_*.gz дублей с разной основой (предотвратить затирание в памяти первой формы)
               zcat dic_*.gz | awk '{ if ( f1 == $1 && f2 == $2 )  {printf("\033[91m%s\n\033[0m", $0); fnd=1}; f1=$1; f2=$2; }
                           END { if(!fnd) printf("\033[32m%s\n\033[0m", "Дублей с разной основой не надено.")}' ;
       exit 1; ;;

    pat4oc ) # создать полный список всех словоформ для фильтрации словаря opencorpora
              zcat dic_*.gz | awk '{ print "_" $1 "=" }' | sort -u | $zipper > _stock.pat.gz
#             zcat dic_*.gz | awk '{ print "_" $1 "=" }' | sort -u | $zipper > _stock.patt.gz
#             zcat dik_*.gz | awk '{ $1=tolower($1); gsub("ё","е",$1); print "_" $1 "=" }' | sort -u | $zipper >> _stock.patt.gz
#             zcat _stock.patt.gz | sort -u | $zipper > _stock.pat.gz; rm _stock.patt.gz
       exit 1; ;;

    pat4all ) # создать полный список всех словоформ для фильтрации словаря wiktionary
#             zcat dix_prq.gz | awk -f awx/gen_prq.awk | sort -u | $zipper > dic_prq.gz

              zcat dic_*.gz | awk '{ print "_" $1 "=" }' | sort -u | $zipper > _stock.pat.gz
#             zcat dic_*.gz | awk '{ print "_" $1 "=" }' | sort -u | $zipper > _stock.patt.gz
#             zcat dik_*.gz | awk '{ $1=tolower($1); gsub("ё","е",$1); print "_" $1 "=" }' | sort -u | $zipper >> _stock.patt.gz
#             zcat _stock.patt.gz | sort -u | $zipper > _stock.pat.gz; rm _stock.patt.gz
              zcat dic_prl.gz  | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_prl.pat.gz
              zcat dic_prl.gz  | awk '{ print "\\s" $2 "\\s" }' | sort -u | $zipper > _class_prl.gz
              zcat dic_prq.gz  | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_prq.pat.gz
              zcat dic_prq.gz  | awk '{ print "\\s" $2 "\\s" }' | sort -u | $zipper > _class_prq.gz
              zcat dic_suw.gz  | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_suw.pat.gz
              zcat dic_suw.gz  | awk '{ print "\\s" $2 "\\s" }' | sort -u | $zipper > _class_suw.gz
              zcat dic_gl.gz   | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_gl.pat.gz
              zcat dic_gl.gz   | awk '{ print "\\s" $2 "\\s" }' | sort -u | $zipper > _class_gl.gz
              zcat dic_rest.gz | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_rest.pat.gz
              zcat dic_rest.gz | awk '{ print "\\s" $2 "\\s" }' | sort -u | $zipper > _class_rest.gz
              zcat dix_prq.gz  | awk '{ print   "_" $1 "="   }' | sort -u | $zipper > _stock_dixprq.pat.gz
#             zcat unistress.gz| awk 'BEGIN{FS="="}{ print $1 "=" }' | sort -u | $zipper > _stock_wb0.pat.gz
       exit 1; ;;

    gen_prq ) # создать полный список всех словоформ причастий из словаря dix
              zcat dix_prq.gz | awk -f awx/gen_prq.awk | sort -u | $zipper > dic_prq.gz
       exit 1; ;;

    prune_omo ) # создать полный список всех словоформ причастий из словаря dix
             zcat mano-lc.gz | awk -f awx/prune_omo.awk | $zipper > _mano-lc.gz; mv _mano-lc.gz mano-lc.gz
             zcat mano-uc.gz | awk -f awx/prune_omo.awk | $zipper > _mano-uc.gz; mv _mano-uc.gz mano-uc.gz

             rg -zH " [^- ']( |$)" mano-lc.gz mano-uc.gz

       exit 1; ;;

    unis ) # Пересобрать базы ударений и проверить их
            tmp_files=( _U_unar _N_unar _U_uni _U_una _U_names_pat _U_uni_pat _U_names_conflict _U_uniq_D.pat _N_uniq_D.pat mano_luc.pat \
                        _U_error _U_namuni_omo _U_2bases mano_luc.pat _U_error _N_error _Y_error )
            for file in "${tmp_files[@]}"; do [[ -s $file ]] && rm "$file"; done
            
            create_backup "_N_omo"; create_backup "_U_omo"; create_backup "_Y_omo"; create_backup "_N_omo_in_NB"
            
            zcat unistress.gz unistrehy.gz yodef.gz yodhy.gz uniomo.gz |\
            sort -u | tee _U_unar | sed -r "s/ё/е/g; s/[_']//g" |
            awk -F"=" '{ print "_" $1 "="; gsub("-","",$0); if($1 != $2) print "_" $0 >> "_U_error" }' | uniq -D | sort -u > _U_uniq_D.pat
            
            grep -Fvhf _U_uniq_D.pat _U_unar > _U_una
            grep -Fhf _U_uniq_D.pat _U_unar > _U_omo
            zcat mano-lc.gz mano-uc.gz | sed -r "s/=.*/=/" > mano_luc.pat

            # Основная обработка
            if [[ -s _U_una ]]; then
                grep -Ff mano_luc.pat _U_una | $zipper > uniomo.gz; fi
            grep -Fvf mano_luc.pat _U_una > _U_uni

            zcat namebase.gz | sort -u | tee _N_unar | sed -r "s/ё/е/g; s/[_']//g" |\
            awk -F"=" '{ print "_" $1 "="; gsub("-","",$0); if($1 != $2) print "_" $0 >> "_N_error" }' | uniq -D | sort -u > _N_uniq_D.pat

            grep -Ff mano_luc.pat _N_unar > _N_omo_in_NB
            grep -Ff _N_uniq_D.pat _N_unar > _N_omo
            grep -Fvf <(cat mano_luc.pat _N_uniq_D.pat) _N_unar | $zipper > namebase.gz;
            
            zcat yoyo_alt.gz | sort -u | tee _Y_unar | sed -r "s/[_']//g" |\
            awk -F"=" '{ print "_" $1 "="; gsub("-","",$0); if($1 != $2) print "_" $0 >> "_Y_error" }' | uniq -D | sort -u > _Y_uniq_D.pat

            grep -Ff  _Y_uniq_D.pat _Y_unar > _Y_omo
            grep -Fvf _Y_uniq_D.pat _Y_unar | $zipper > yoyo_alt.gz;
            
            comm_uni=$(grep -c ^ _U_uni); nb_uni=$(zgrep -c ^ namebase.gz); mano_uc=$(zgrep -c ^ mano-uc.gz);
            mano_lc=$(zgrep -c ^ mano-lc.gz); ruac_uni=$(zgrep -c ^ unis_ruac.gz)
            totom=$(($comm_uni + $nb_uni + $mano_uc + $mano_lc + $ruac_uni))
            printf "%s %s %s %s %s %s %s %s %s %s %s %s\n" \
                   "Акцентированные формы. Слова:" $comm_uni \
                   "| Обычных омографов:" $mano_lc \
                   "| Имён:" $nb_uni \
                   "| Имён-омографов:" $mano_uc \
                   "| Остаток ruac:" $ruac_uni \
                   "| Всего:" $totom

            sed -r "s/=.*/=/g" _U_uni > _U_uni_pat
            zcat namebase.gz | sed -r "s/=.*/=/g" > _U_names_pat

            if [[ -s _U_uni ]]; then
              grep    "ё" _U_uni | grep -v "-" | $zipper > yodef.gz
              grep    "ё" _U_uni | grep    "-" | $zipper > yodhy.gz
              grep -v "ё" _U_uni | grep -v "-" | $zipper > unistress.gz
              grep -v "ё" _U_uni | grep    "-" | $zipper > unistrehy.gz
            fi

            zgrep -Fvf <(cat _U_uni_pat _U_names_pat mano_luc.pat) unis_ruac.gz | $zipper > unis_ruact.gz && mv unis_ruact.gz unis_ruac.gz

            zgrep -Ff _U_uni_pat namebase.gz > _U_names_conflict
            grep  -Ff _U_names_pat _U_uni   >> _U_names_conflict

            awk 'BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"; FS="=" } { word[$1][$2] }
                   END { for (i in word) { for (j in word[i]) { len=length(word[i])
                         if (len == 1) { print i "=" j >> "_U_2bases"}
                         else { if (len != 0) {print i "=" j >> "_U_namuni_omo"}} }} }' _U_names_conflict

            zgrep -v -e "'" -e "[^$rvlc]'" unistress.gz yodef.gz namebase.gz
            rg -zH " [^- ']( |$)" mano-lc.gz mano-uc.gz

            zcat unistrehy.gz yodhy.gz |sed -r "s/^.*=//g"|\
              awk -F"-" '{ for(i=1; i <=NF; i++) { ci=$i; va=gsub(/[аяеэыиуюоё]/,"",ci)
                               if ($i !~ "\x27" && va > 1   ) print $0 };
                               if ($0  ~ /[^аяеэыиуюоё]\x27/) print $0 }'

            zgrep -FvHf mano_luc.pat uniomo.gz
            zgrep -FvHf mano_luc.pat mano-lc.gz mano-uc.gz
            rg -z "_=" uni*.gz yo*.gz malc.gz namebase.gz

            if [[ -s "_U_omo" ]]; then fnum=$(grep -c ^ _U_omo); printf '%s %s %s\n' "Омографов в общей лексике:" $fnum "==> _U_omo"; fi;
            if [[ -s "_N_omo" ]]; then fnum=$(grep -c ^ _N_omo); printf '%s %s %s\n' "Омографов в базе имён    :" $fnum "==> _N_omo"; fi;
            if [[ -s "_Y_omo" ]]; then fnum=$(grep -c ^ _Y_omo); printf '%s %s %s\n' "Омографов в ё-вариантах  :" $fnum "==> _Y_omo"; fi;
            if [[ -s "_N_omo_in_NB" ]]; then fnum=$(grep -c ^ _N_omo_in_NB); printf '%s %s %s\n' "Известные омографы в базе имён:" $fnum "==> _N_omo_in_NB"; fi;
            if [[ -s "_N_error" ]]; then fnum=$(grep -c ^ _N_error); printf '%s %s %s\n' "Найдено ошибок:" $fnum "==> _N_error"; fi;
            if [[ -s "_U_error" ]]; then fnum=$(grep -c ^ _U_error); printf '%s %s %s\n' "Найдено ошибок:" $fnum "==> _U_error"; fi;
            if [[ -s "_Y_error" ]]; then fnum=$(grep -c ^ _Y_error); printf '%s %s %s\n' "Найдено ошибок:" $fnum "==> _Y_error"; fi;
            if [[ -s "_U_2bases" ]]; then fnum=$(grep -c ^ _U_2bases); printf '%s %s %s\n' "Повторения в базах имён и лексики:" $fnum "==> _U_2bases"; fi;
            if [[ -s "_U_namuni_omo" ]]; then fnum=$(grep -c ^ _U_namuni_omo); printf '%s %s %s\n' "Омографы на 2 базы:" $fnum "==> _U_namuni_omo"; fi;

            tmp_files=( _N_omo _U_omo _Y_omo _N_omo_in_NB _N_error _U_error _Y_error _U_namuni_omo _U_2bases )
            for file in "${tmp_files[@]}"; do if [[ -f "$file" && ! -s "$file" ]]; then rm "$file"; fi; done

            tmp_files=( _U_unar _N_unar _Y_unar _U_uni _U_una _U_names_pat _U_uni_pat _U_uniq_D.pat _N_uniq_D.pat _Y_uniq_D.pat mano_luc.pat mano_luc.pat _U_names_conflict )
            for file in "${tmp_files[@]}"; do [[ -f $file ]] && rm "$file"; done

            exit 1; ;;

     * ) printf "%s\n" "WRONG ARG!"; exit 0; ;;


esac

