@load "rwarray"

BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"
# Скрипт генерации служебных списков для get-words.sh
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts
    # внешние переменные
    # indb inax book
    #

   inax = inax "/"

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
  if (wdb == 0 && gawk52 == 1) { readall(cache) } else { savefs = FS; FS = "[_= ]";
      cmd = "zcat " inax "unistress.gz " inax "unistrehy.gz " inax "yoyo.gz"; while ((cmd|getline) > 0) { stubase[$2] }; close(cmd);
      cmd = "zcat " inax "yodef.gz " inax "yodhy.gz " inax "yoyo.gz";         while ((cmd|getline) > 0) { yobase[$2]  }; close(cmd);
      cmd = "zcat " inax "dic.pat.gz " inax "yoyo.pat.gz";                    while ((cmd|getline) > 0) { dicbase[$2] }; close(cmd);
      FS = savefs;
  if (gawk52 == 1) {writeall(cache);
      cmd = "md5sum " cache " " inax "unistress.gz " inax "unistrehy.gz " inax "yodef.gz " inax "yodhy.gz " inax "yoyo.gz " \
                                inax "yoyo.pat.gz " inax "dic.pat.gz > " inax "wdb.md5";
      system(cmd); close(cmd)};};

  #
      savefs = FS; FS = "[_= ]";
      cmd = "cat " inax "anycap-may.pat"; while ((cmd|getline) > 0) { anycap_may[$2] }; close(cmd);
      cmd = "cat " inax "surcap-raw.pat"; while ((cmd|getline) > 0) { surcap_raw[$2] }; close(cmd);
      FS = savefs;
      cmd = "rm " inax "anycap-lex.pat " inax "anycap-bas.pat " inax "surcap-lex.pat " inax "surcap-bas.pat 2>/dev/null";
      system(cmd); close(cmd);

      for (i in anycap_may) { if (!(i in stubase)) anycap_lex_pat[i]; print "_" i "=" >> inax "anycap-lex.pat" }; fflush();
      for (i in anycap_may) { if (  i in stubase ) anycap_bas_pat[i]; print "_" i "=" >> inax "anycap-bas.pat" }; fflush();
      for (i in surcap_raw) { if (!(i in stubase)) surcap_lex_pat[i]; print "_" i "=" >> inax "surcap-lex.pat" }; fflush();
      for (i in surcap_raw) { if (  i in stubase ) surcap_bas_pat[i]; print "_" i "=" >> inax "surcap-bas.pat" }; fflush();

}
