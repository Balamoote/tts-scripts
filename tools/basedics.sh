#!/bin/bash

# Выводить парадигму причастий полностью 0/1 -- для случаев bf или "слово по маске"
prq_full=0
# Выводить $1, если оно изменено
echo_S1=0
S2=$2

aux="scriptaux"
sdb="scriptdb"

if [[ $2 == "yo" ]]; then S1=$(echo "$1" | sed -r "s/[её]/[её]/g; s/\*/.*/g; s/_//g"); S2="";
else S1=$(echo "$1" | sed -r "s/ё/[её]/g; s/\*/.*/g; s/_//g"); fi

if [[ $S1 != $1 && $echo_S1 -eq 1 ]]; then printf "%s\n" $S1; fi

if [[ $1 =~ ^x[0-9]+$ ]]; then grparp=1; fi

dicword="^"$S1"\b"
bfword="(\s|#)"$S1"(#|\s|$)"
sstring="\b"$S1"\b"
astromo="\s"$S1"\s"
mstromo="_"$S1"="

wrd=$mstromo

twid=$(tput cols)
if [[ $twid -lt 67 ]]; then pad=$((($twid/2)-1)); else pad=31; fi

# При поиске по базовой форме выдавать причастия только в им.п. ед.ч.
 alldics="dic_gl.gz dic_prl.gz dic_prq.gz dic_rest.gz dic_suw.gz dic_cust.gz dic_prop.gz"
  alldix="dic_gl.gz dic_prl.gz dix_prq.gz dic_rest.gz dic_suw.gz dic_cust.gz dic_prop.gz"
# выбрать одину из утилит для поиска: zgrep или rg (он же ripgrep)
grepper="rg -zNS --no-heading"
#grepper="zgrep -EH"

awk_omo () { awk -vomfi=$omfi 'BEGIN {FS="[ =_:]+"} {
         $0 = gensub(/(.)\x27/,"\033[32m\\1\xcc\x81\033[0m","g",$0)
         printf ("\033[36m%s\033[36m%s \033[93m%s\033[0m %s %s %s %s\n", omfi, ":", $1, $2, $3, $4, $5, $6)
    }'; }


cd $sdb/

case $S2 in
  bf | бф | = ) # для поиска по базовой форме слова
   $grepper $bfword $alldix |\
       awk 'BEGIN {FS="[ :]"} { printf ( "\033[36m%s \033[93m%s \033[33m%s \033[32m%s \033[31m%s\033[0m\n", $1, $2, $3, $4, $5 ) }';
   S2=""
   exit 1
  ;;
  bff | бфф | == ) # для поиска по базовой форме слова со всеми причастиями
   $grepper $bfword $alldics |\
       awk 'BEGIN {FS="[ :]"} { printf ( "\033[36m%s \033[93m%s \033[33m%s \033[32m%s \033[31m%s\033[0m\n", $1, $2, $3, $4, $5 ) }';
   S2=""
   exit 1
  ;;
  full | + | ++ ) # по словоформе, по всем словарям, включая все причастия
   $grepper "$dicword" $alldics |\
       awk 'BEGIN {FS="[ :]"} { printf ( "\033[36m%s \033[93m%s \033[33m%s \033[32m%s \033[31m%s\033[0m\n", $1, $2, $3, $4, $5 ) }';
   S2=""
#  exit 1
  ;;
	*) # для всех остальных случаеев
   if [[ $1 ]]; then
      if [[ $prq_full -eq 0 ]]; then alldicts=$alldix; fi
      $grepper "$dicword" $alldicts |\
      awk 'BEGIN {FS="[ :]"} { printf ( "\033[36m%s \033[93m%s \033[33m%s \033[32m%s \033[31m%s\033[0m\n", $1, $2, $3, $4, $5 ) }'
       else printf '\e[36m%s \e[33m%s \e[36m%s \e[33m%s \e[36m%s \e[33m%s \e[36m%s\e[0m\n' "Использование:" \
         "./basedics.sh слово" "или" "./basedics.sh слов*" "или" "./basedics.sh слово =" "Ключи: bf|бф|=|bff|бфф|==|full|++|+"; fi;
#         exit 1
  ;;
esac

if [[ $grparp -eq 1 ]]; then
   $grepper $1 automo.gz |\
          awk 'BEGIN {FS="[ :]"} { gsub(/\x27/,"́",$5);
               $0 = gensub(/(.)\x27/,"\033[32m\\1\xcc\x81\033[0m","g",$0)
               printf ( "\033[36m%s\033[0m %s \033[33m%s\033[0m \033[93m%s\033[0m\n", $1, $4, $3, $5 ) }'
               exit 1;
fi

$grepper "$astromo" automo.gz |\
    awk 'BEGIN {FS="[ :]"} { gsub(/\x27/,"́",$5);
         $0 = gensub(/(.)\x27/,"\033[32m\\1\xcc\x81\033[0m","g",$0)
         printf ( "\033[36m%s\033[0m %s \033[33m%s\033[0m \033[93m%s\033[0m\n", $1, $4, $3, $5 ) }'

printf '\n\e[32m%s \e[96m%s \e[93m%s \e[96m%s\e[0m\n' "Looking up:" ">>>" $S1 "<<<"

# Ударения отмечены знаком ударения и цветом или только цветом
if [[ -z "$S2" ]]; then
 $grepper "$wrd" unistress.gz unistrehy.gz yodef.gz yodhy.gz yoyo_alt.gz namebase.gz mano-uc.gz mano-lc.gz malc.gz uniomo.gz |\
    awk -v pad=$pad -F"[ _=:]+" '{
              $0 = gensub(/(.)\x27/,"\033[32m\\1\xcc\x81\033[0m","g",$0)
              len1=length($1);
              len=length($2);
              pad0 = 12 ;
              pad1 = pad + 9;
              pad2 = pad*2 + 7;
              pad3 = pad*3 + 7;
            switch(NF) {
              case "3": format = "\033[36m%-" pad0 "s:\033[0m %-" pad "s\n";                       printf(format, $1, $3        ); break
              case "4": format = "\033[36m%-" pad0 "s:\033[0m %-" pad "s %-" pad "s\n";            printf(format, $1, $3, $4    ); break
              case "5": format = "\033[36m%-" pad0 "s:\033[0m %-" pad "s %-" pad "s %-" pad "s\n"; printf(format, $1, $3, $4, $5); break
            default: break
          };}';
#printf '\e[91m%s\e[0m\n' "==>> No variants args passed."
else
	printf '\e[91m%s \e[96m%s \e[92m%s \e[96m%s \e[93m%s \e[96m%s\e[0m\n' "Variants:" "NOT >>>" $S2\' "<<< IN >>>" $wrd "<<<"

$grepper "$wrd" unistress.gz unistrehy.gz yodef.gz yodhy.gz yoyo_alt.gz | grep -v $S2\' |\
	awk -v pad=$pad -F"[ =_:]+" '{
         $0 = gensub(/(.)\x27/,"\033[32m\\1\xcc\x81\033[0m","g",$0)
         format = "%-" pad "s %-" pad "s %s\n"; printf(format, $2, $3, $1)}';

	printf '\e[95m%s\e[0m\n' "==>> end of variants!"
fi
cd ..
