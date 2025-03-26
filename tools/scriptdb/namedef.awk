# Скрипт простановки ударений в именах собственных
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts
@load "rwarray"

function joinpat(array, seps, nuf,    ret, i, k) { # Склеить строку обратно
                ret = seps[0]; for (i=1; i<= nuf; i++) {ret = ret array[i] seps[i]}; return ret }

BEGIN {

  inax = inax "/"

    patword = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb00-9A-Z]+"
    capword = "^[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]+$"

 # Проверяем версию gawk, если меньше 5.2.1, то выключаем функции сохранения и восстановления массивов и переменных: базы тогда читаются всегда заново.
    redix=gawk52="42"
    cmd = "awk -Wversion | head -1"
    cmd|getline verheader; close(cmd)
    split(verheader, gnuawk, "[ .,]")
    if (gnuawk[1] == "GNU" && gnuawk[2] == "Awk" && gnuawk[3] >= 5 && gnuawk[4] >= 2 && gnuawk[5] >= 1) { gawk52 = 1 };
 # Если словари и этот скрипт не изменились и gawk>=5.2.1, восстановить состояние, иначе прочитать всё заново.
   if ( gawk52 == 1 ) {
    cmd   = "md5sum -c --status " inax "namedef.md5 >/dev/null 2>&1"
    redix = system(cmd); close(cmd);};

   namecache = inax "namedef.bin"

   if (redix == 0 && gawk52 == 1) { readall(namecache) } else {

   cmd = "zcat " inax "namebase.gz | \
       sed -r 's/([аеёиоуыэюя])\\x27/\\1\\xcc\\x81/gI; \
               s/^_(.)(.+)=(.)(.+)$/\\u\\1\\2 \\u\\3\\4 \\U\\1\\2\\E \\U\\3\\4\\E/g;'";
   while ((cmd|getline) > 0) {

         if ($2 ~ /[Ёё]/) { Yok = gensub("'","","g",$2); YOK = gensub("'","","g",$4) };

         namedef[$1] =$2; namedef[$3] =$4;
         namedef[Yok]=$2; namedef[YOK]=$4;

   }; close(cmd);

 # Записать состояние словарных массивов
  if (gawk52 == 1) { writeall(namecache) };
  cmd = "md5sum " indb "namedef.awk " inax "namedef.bin " indb "namebase.gz > " inax "namedef.md5"
  system(cmd); close(cmd);
   } #gnuawk

} {

 nf=patsplit($0, l, patword, sep);

 for (i=1; i<=nf; i++) {
   if ( l[i] in namedef ) { l[i]=namedef[l[i]] };
 };

 # вывести изменённую строку
 $0 = joinpat(l, sep, nf)
 print $0

}
