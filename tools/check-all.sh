#!/bin/bash
# Скрипт проверки целостности пакета и подготовки вспомогательных файлов.
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts 
# Требует: bash, sed, grep, awk, uniq, sort, bc т.е. стандартный набор утилит, который присутствует на большинстве linux-систем.

# Варианты запуска: в консоли Linux/Mac, Cygwin под Windows, Termux под Android

# После завершения работы скрипта выдается отчет, подробности о ошибках можно посмотреть в файлах _*.txt

# Использование: запустить ./check-all.sh 
#set -e
export LC_COLLATE=C
if command -v pigz >/dev/null 2>&1; then zipper="pigz"; else zipper="gzip"; fi
aux="scriptaux"
sdb="scriptdb"


if [[ ! -d $aux ]]; then mkdir $aux; fi

if [[ ! -z "$1" ]]; then
case "$1" in
	fa |--fall ) # Принудительно заново создать все вспомогательные файлы для скриптов
       [[ -d $aux ]] && rm -rf $aux/ && mkdir $aux;;
	fg | --fgwrd ) # Перепроверить вспомогательные файлы get-words.sh
		if [[ -s $aux/zndb.md5 ]]; then rm $aux/zndb.md5; fi ;;
	fy | --fyofik ) # Перепроверить вспомогательные файлы yofik.sh
		if [[ -s $aux/zjofik.md5 ]]; then rm $aux/zjofik.md5; fi ;;
	fm | --fmomo ) # Перепроверить вспомогательные файлы momo.sh
		if [[ -s $aux/zaomo.md5 ]]; then rm $aux/zaomo.md5; fi ;;
	*) # Проверить, существует ли файл книги
		if [[ -s "$1" ]]; then book="$1"
		else printf '\e[35m%s \e[93m%s \e[35m%s \e[93m%s \e[93m%s \e[35m%s\e[0m\n' \
			"Использование:" "./check-all.sh" "или" "./check-all.sh [fa|fg|fy|fm]"; fi ; exit 1 ;;
esac; fi

# Массив со списком обязательных файлов
pack="$sdb/automo.gz $sdb/awx/beautify.awk $sdb/class.list.gz $sdb/classes.awk $sdb/cstauto.awk $sdb/cstring.awk $sdb/defunct.awk \
      $sdb/deomo.awk $sdb/demorphy.awk $sdb/dic_cust.gz $sdb/dic_gl.gz $sdb/dic_prl.gz $sdb/dic_prq.gz $sdb/dic_rest.gz \
      $sdb/dic_suw.gz $sdb/fb2 $sdb/functions.awk $sdb/awx/gw_caplists.awk $sdb/hclean.sh $sdb/ist.gz \
      $sdb/main.awk $sdb/mano-lc.gz $sdb/mano-uc.gz $sdb/namebase.gz $sdb/namedef.awk $sdb/yoyo_alt.gz \
      $sdb/omo-index.sed $sdb/omo_list.phy.gz $sdb/omoid.me $sdb/omoid_auto.gz $sdb/omoid_flat.gz $sdb/omoid_ini.gz \
      $sdb/omoid_pa_ini.gz $sdb/preview.awk $sdb/ruac.py $sdb/rulg_all.py $sdb/rulg_omo.py $sdb/settings.ini $sdb/dix_prq.gz \
      $sdb/vsevso.awk $sdb/unistress.gz $sdb/unistrehy.gz $sdb/yodef.awk $sdb/yodef.gz \
      $sdb/ext/x4707.awk $sdb/ext/x4709.awk $sdb/dik_prop.gz $sdb/cstrings.gz"
read -a minpack <<< $pack

# Проверка не потерялось ли чего
for f in "${minpack[@]}"; do
	if [[ ! -s $f ]]; then printf '\e[31;5;1m%s\e[0m \e[93m%s\e[0m\n' "Отсутствует файл:" $f; exit 1; fi; done

# Проверка по md5: zaomo.md5 zjofik.md5 zndb.md5 zstu.md5 . Назначаем "1", если ОК, и "0"", если нужно пересоздать.
if [[ -s $aux/zaomo.md5   ]] && md5sum -c --status $aux/zaomo.md5   >/dev/null 2>&1; then aomo=1;  else aomo=0  ; fi
if [[ -s $aux/zjofik.md5  ]] && md5sum -c --status $aux/zjofik.md5  >/dev/null 2>&1; then jofik=1; else jofik=0 ; fi
if [[ -s $aux/zndb.md5    ]] && md5sum -c --status $aux/zndb.md5    >/dev/null 2>&1; then ndb=1;   else ndb=0   ; fi
if [[ -s $aux/zstu.md5    ]] && md5sum -c --status $aux/zstu.md5    >/dev/null 2>&1; then stu=1;   else stu=0   ; fi
if [[ -s $aux/zuni.md5    ]] && md5sum -c --status $aux/zuni.md5    >/dev/null 2>&1; then uni=1;   else uni=0   ; fi
if [[ -s $aux/zdic.md5    ]] && md5sum -c --status $aux/zdic.md5    >/dev/null 2>&1; then dic=1;   else dic=0   ; fi
if [[ -s $aux/yodef.md5   ]] && md5sum -c --status $aux/yodef.md5   >/dev/null 2>&1; then yod=1;   else yod=0   ; fi
if [[ -s $aux/zdix.md5    ]] && md5sum -c --status $aux/zdix.md5    >/dev/null 2>&1; then dix=1;   else dix=0   ; fi
if [[ -s $aux/classes.md5 ]] && md5sum -c --status $aux/classes.md5 >/dev/null 2>&1; then tst=1;   else tst=0   ; fi


### Выполняем проверку вспомогательных файлов из ./momo.sh

if [[ $aomo -eq 1 ]] && [[ $tst -eq 1 ]]; then
       	printf '\e[36m%s \e[32m%s ' "MOM:" "старые"
else
  yod=0; uni=0
  sed -r "s/=.+$/=/g" <(zcat $sdb/malc.gz) | $zipper > $aux/malc.pat.gz

  cd $sdb
  ./hclean.sh prune_omo > /dev/null
  cd ..

  # Формируем в $aux/ файлы mano-lc.pat.gz mano-uc.pat.gz mano-cc.pat.gz mano-ca.pat.gz
  awk -vomtype="mano" -f $sdb/awx/omopat.awk

   ./testrule.sh > /dev/null # создать awk-базу для testrule.sh

  md5sum $sdb/mano-uc.gz $aux/mano-uc.pat.gz $sdb/mano-lc.gz $aux/mano-lc.pat.gz $sdb/malc.gz \
         $sdb/omo-index.sed $aux/mano-cc.pat.gz $aux/mano-ca.pat.gz $aux/malc.pat.gz > $aux/zaomo.md5
  printf '\e[36m%s \e[93m%s ' "MOM:" "новые"
fi

if [[ $uni -eq 0 ]]; then
  yod=0; yofik=0
  cd $sdb
  ./hclean.sh stress > /dev/null
  cd ..
  md5sum $sdb/uniomo.gz $sdb/unistrehy.gz $sdb/yodhy.gz $sdb/unistress.gz $sdb/yodef.gz > $aux/zuni.md5
fi

### Выполняем проверку вспомогательных файлов из ./yofik.sh

if [[ $jofik -eq 1 ]] && [[ $yod -eq 1 ]]; then
       	printf '\e[36m%s \e[32m%s ' "YOF:" "старые"
else
	zcat $sdb/yodef.gz | sed -r "s/=.+$/=/g" | $zipper > $aux/yodef.pat.gz
  zgrep "ё"      $sdb/mano-lc.gz           | $zipper > $sdb/yomo-lc.gz
  zgrep "ё"      $sdb/mano-uc.gz           | $zipper > $sdb/yomo-uc.gz
  sed -r "s/=.+$/=/g" <(zcat $sdb/yolc.gz)    | $zipper > $aux/yolc.pat.gz

  # Формируем в $aux/ файлы yomo-lc.pat.gz yomo-uc.pat.gz yomo-cc.pat.gz yomo-ca.pat.gz
  awk -vomtype="yomo" -f $sdb/awx/omopat.awk

  # Формируем в $sdb/  : yoyo.gz yoyo_lc.gz
  #           в $aux/ : yoyo.pat.gz yoyo_lc.pat.gz yoye.pat.gz yoye_lc.pat.gz
  awk -f $sdb/awx/yopat.awk
  sed -r "s/=.+$/=/g" <(zcat $sdb/yoyo_lc.gz) | $zipper >> $aux/yoyo.pat.gz

  # Создаём yodef.bin
  echo "" | awk -vindb="$sdb/" -vinax="$aux/" -f $sdb/yodef.awk >/dev/null

  printf '\e[36m%s \e[93m%s ' "YOF:" "новые"
	md5sum $sdb/yodef.gz $aux/yodef.pat.gz $sdb/yomo-lc.gz $aux/yomo-lc.pat.gz $sdb/yodef.awk $sdb/yomo-uc.gz \
         $aux/yomo-uc.pat.gz $sdb/yolc.gz $aux/yolc.pat.gz $aux/yomo-cc.pat.gz $sdb/yoyo.gz $sdb/yoyo.gz \
         $aux/yoyo.pat.gz $aux/yoyo_lc.pat.gz $aux/yoye.pat.gz $aux/yoye_lc.pat.gz $sdb/yodhy.gz \
         > $aux/zjofik.md5
fi

### Выполняем проверку вспомогательных файлов из ./get-words.sh
if [[ $stu -eq 1 ]]; then
	printf '\e[36m%s \e[32m%s ' "STU:" "старый" 
else
  zcat $sdb/unistress.gz $sdb/unistrehy.gz | sed -r 's/=.+$/=/g' | $zipper > $aux/unistress.pat.gz
  zcat $sdb/unistress.gz $sdb/unistrehy.gz $sdb/mano-lc.gz $sdb/malc.gz $sdb/yodef.gz $sdb/yodhy.gz $sdb/yoyo.gz $sdb/yoyo_alt.gz |\
       sed -r 's/=.+$/=/g' | $zipper > $aux/unistress-all.pat.gz
  printf '\e[36m%s \e[93m%s ' "STU:" "новый" 
  md5sum $sdb/unistress.gz $sdb/mano-lc.gz $sdb/malc.gz $sdb/yodef.gz $sdb/yodhy.gz $sdb/yoyo.gz $sdb/yoyo_alt.gz \
         $aux/unistress-all.pat.gz $sdb/unistrehy.gz > $aux/zstu.md5;
fi

if [[ $ndb -eq 1 ]]; then
       	printf '\e[36m%s \e[32m%s ' "NDB:" "старые"
else
	sed -r 's/=.+$/=/g' <(zcat $sdb/namebase.gz) | $zipper > $aux/namebase.pat.gz
	zcat $aux/namebase.pat.gz $aux/mano-sm.pat.gz | sort -u | $zipper > $aux/names-all.pat.gz
  md5sum $sdb/namebase.gz $aux/namebase.pat.gz $aux/mano-sm.pat.gz $aux/names-all.pat.gz > $aux/zndb.md5
  printf '\e[36m%s \e[93m%s ' "NDB:" "новые"
fi
 
if [[ $dix -eq 0 ]]; then
  dic=0
  zcat $sdb/dix_prq.gz | awk -f $sdb/gen_prq.awk | sort -u | $zipper > $aux/dic_prq.gz
  md5sum $sdb/dix_prq.gz $sdb/dic_prq.gz > $aux/zdix.md5
fi

if [[ $dic -eq 1 ]]; then
       	printf '\e[36m%s \e[32m%s ' "DIC:" "старые"
else
  zcat $sdb/dic_*.gz | awk '{ print "_" $1 "=" }' | sort -u | $zipper > $aux/dic.pat.gz
  md5sum $aux/dic.pat.gz $sdb/dic_prq.gz $sdb/dix_prq.gz $sdb/dic_gl.gz $sdb/dic_prl.gz $sdb/dic_suw.gz $sdb/dic_cust.gz $sdb/dic_rest.gz > $aux/zdic.md5
  printf '\e[36m%s \e[93m%s ' "DIC:" "новые"
fi

printf '\e[32;4;1m%s\e[0m\n' "Всё ОК!"


