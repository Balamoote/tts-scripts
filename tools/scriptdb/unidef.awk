# Скрипт простановки ударений в именах собственных
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts
@load "rwarray"
@include "scriptdb/functions.awk"

BEGIN {

  inax = inax "/"

#   patword = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb00-9A-Z]+"
#   capword = "^[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]+$"

   _unxy   = "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0"
   _RUUC   = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
   _rulc   = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
   _LAUC   = "A-ZÀÁÂÃÄÅĀĂÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝ"
   _lalc   = "a-zàáâãäåāăæçèéêëìíîïðñòóôõöøùúûüýß"

   unxy    = "[" _unxy "]"
   unxyp   = "[" _unxy "]+"
   unxn    = "[^" _unxy "]"
   RUUC    = "[" _RUUC "]+"
   RUUC_   = "[" _RUUC "]"
   rulc    = "[" _rulc "]+"
   rulc_   = "[" _rulc "]"
   LAUC_   = "[" _LAUC "]"
   lalc    = "[" _lalc "]+"
   patword = "[" _RUUC _rulc _unxy "0-9]+"
   regword = "[" _RUUC _rulc _unxy "]"
   fsword  = "[^" _RUUC _rulc _unxy "]"
   capword = "^[" _RUUC "]+$"

   vvpat   = "[,—]"
   hysnip  = regword "[-]" regword


 # Проверяем версию gawk, если меньше 5.2.1, то выключаем функции сохранения и восстановления массивов и переменных: базы тогда читаются всегда заново.
    lexpat=wdb=gawk52="42"
    cmd = "awk -Wversion | head -1"
    cmd|getline verheader; close(cmd)
    split(verheader, gnuawk, "[ .,]")
    if (gnuawk[1] == "GNU" && gnuawk[2] == "Awk" && gnuawk[3] >= 5 && gnuawk[4] >= 2 && gnuawk[5] >= 1) { gawk52 = 1 };
 # Если словари и этот скрипт не изменились и gawk>=5.2.1, восстановить состояние, иначе прочитать всё заново.
   if ( gawk52 == 1 ) {
    cmd = "md5sum -c --status " inax "zwdb.md5 >/dev/null 2>&1"
    wdb = system(cmd); close(cmd);
   };

 # Читаем базовый список слов
  cache = inax "wdb.bin"
  if (wdb == 0 && gawk52 == 1) { readall(cache) } else {

      cmd = "zcat " inax "unistress.gz " inax "unistrehy.gz " inax "yodef.gz " inax "yodhy.gz " inax "yoyo.gz | \
          sed -r 's/([_=-])(.)/\\1\\u\\2/g; s/_//g; s/=/ /g; \
                  s/(.)(.+) (.)(.+)/\\L\\0\\E \\1\\L\\2\\E \\3\\L\\4\\E \\U\\0\\E \\0/g; \
                  s/\\x27/\xcc\x81/g;'";
      while ((cmd|getline) > 0) {
         if ($2 ~ /[Ёё]/) { yok=gensub("\\xcc\\x81","","g",$2); Yok=gensub("\\xcc\\x81","","g",$4);
                            YOK=gensub("\\xcc\\x81","","g",$6); YoK=gensub("\\xcc\\x81","","g",$8);
                            unibase[yok]=$2; unibase[Yok]=$4; unibase[YOK]=$6; unibase[YoK]=$8;     };

         unibase[$1]=$2; unibase[$3]=$4; unibase[$5]=$6; unibase[$7]=$8; } close(cmd);

      # Лобавляем в wdb.bin также и имена
      cmd = "zcat " inax "namebase.gz | \
              sed -r 's/([аеёиоуыэюя])\\x27/\\1\\xcc\\x81/gI; \
                      s/^_(.)(.+)=(.)(.+)$/\\u\\1\\2 \\u\\3\\4 \\U\\1\\2\\E \\U\\3\\4\\E/g;'";

      while ((cmd|getline) > 0) {

         if ($2 ~ /[Ёё]/) { Yok = gensub("'","","g",$2); YOK = gensub("'","","g",$4)
                            unibase[Yok]=$2; unibase[YOK]=$4;  };

         unibase[$1]=$2; unibase[$3]=$4; }; close(cmd);

      cmd = "zcat " inax "malc.gz | sed -r 's/([аеёиоуыэюя])\\x27/\\1\\xcc\\x81/gI; s/^_(.+)=(.+)$/\\1 \\2/g;'";
      while ((cmd|getline) > 0) {
         if ($2 ~ /[Ёё]/) { yok = gensub("'","","g",$2); unibase[yok]=$2; };

         unibase[$1]=$2; }; close(cmd);

      cmd = "zcat " inax "dic.pat.gz " inax "yoyo.pat.gz";
      while ((cmd|getline) > 0) { dicbase[$2] }; close(cmd);

      for (i in unibase) {if( i ~ "-") dichyph[i]};

  if (gawk52 == 1) {writeall(cache);
      cmd = "md5sum " cache " " inax "unistress.gz " inax "unistrehy.gz " inax "yodef.gz " inax "yodhy.gz " inax "yoyo.gz " \
                                inax "malc.gz "inax "yoyo.pat.gz " inax "dic.pat.gz > " inax "wdb.md5";
      system(cmd); close(cmd)};}; #gnuawk

} {

 nf=patsplit($0, l, patword, sep); hyphback($0)

 for (i=1; i<=nf; i++) {
   if ( l[i] in unibase ) { l[i]=unibase[l[i]] };
 };

 # вывести изменённую строку
 $0 = joinpat(l, sep, nf)
 print $0

}
