# Очистить файл от ударений и служебного, кроме указанных слов
# womo = отдельное слово с учётом регистра
# somo = отдельное слово
# xomo = группа омографов
# indb = путь к файлу automo.gz
function splitline(string,    ret) {                # Разбить строку на слова
                ret=patsplit(string,l,patword,sep); return ret }
function joinpat(array, seps, nuf,    ret, i, k) {  # Склеить строку обратно
                ret = seps[0]; for (i=1; i<= nuf; i++) {ret = ret array[i] seps[i]}; return ret }
function lc(n,   ret) {                             # перевести в нижний регистр и пастеризовать
                ret = gensub(unxy,"","g",tolower(l[i])); gsub(/ё/,"е",ret); return ret }
function cL(n,   ret) {                             # пастеризовать l[i]
                ret = gensub(unxy,"","g",l[i]); gsub(/Ё/,"Е",ret); gsub(/ё/,"е",ret); return ret }
function strip(wrd,   ret) {                             # перевести в нижний регистр и пастеризовать
                ret = gensub(unxy,"","g",wrd); gsub(/ё/,"е",ret); gsub(/Ё/,"Е",ret); return ret }

BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"

   _unxy   = "\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0"
   _RUUC   = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
   _rulc   = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"

   unxy    = "[" _unxy "]+"
   patword = "[" _RUUC _rulc _unxy "0-9]+"

   somo = tolower(somo);
   xomo = tolower(xomo);

   switch (swch) {
      case "ws": task = "womo"; break
      case "so": task = "somo"; break
      case "sn": task = "sono"; break
      case "xo": task = "xomo"; cmd = "zcat " indb "automo.gz"  ; while ((cmd|getline) > 0) { automo[$1][$2] }; break
      case "xn": task = "xono"; cmd = "zcat " indb "automo.gz"  ; while ((cmd|getline) > 0) { automo[$1][$2] }; break
      case "na": task = "name"; cmd = "zcat " indb "namebase.gz | sed -r 's/\x27//g; s/_(.+)=(.+)$/\\u\\1 \\u\\2/g'";
                                while ((cmd|getline) > 0) { namebase[$1]; namebase[$2] }; break
      default: break
     }
 }{

  nf=splitline($0);

  switch (task) {
      case "womo": for (i in l) { word = cL(i); if (   word == womo          ) { l[i] = strip(l[i]) };}; break
      case "somo": for (i in l) { word = lc(i); if (   word == somo          ) { l[i] = strip(l[i]) };}; break
      case "sono": for (i in l) { word = lc(i); if (   word != somo          ) { l[i] = strip(l[i]) };}; break
      case "xomo": for (i in l) { word = lc(i); if (   word in automo[xomo]  ) { l[i] = strip(l[i]) };}; break
      case "xono": for (i in l) { word = lc(i); if ( !(word in automo[xomo]) ) { l[i] = strip(l[i]) };}; break
      case "name": for (i in l) { word = lc(i); if (   word in namebase      ) { l[i] = strip(l[i]) };}; break
      default: break
    }

  print joinpat(l,sep,nf)

   }
