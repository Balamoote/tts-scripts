# Формирует списки однозначных ё-форм

BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"
  indb = "scriptdb/"
  inax = "scriptaux/"
  save_FS = FS

   FS = "[ _=]+"
   cmd = "zcat " indb "yoyo_alt.gz " indb "yodef.gz " indb "yodhy.gz";
   while ((cmd|getline) > 0) {
         yok=gensub("'","","g",$3)
         yodef[yok]=$3;

   }; close(cmd);
   cmd = "zcat " indb "namebase.gz";
   while ((cmd|getline) > 0) {
     if ($3 ~ "ё") {
         yok=gensub("'","","g",$3)
         yolca[yok]=$3;

   };}; close(cmd);
   cmd = "zcat " indb "malc.gz";
   while ((cmd|getline) > 0) {
         yok=gensub("'","","g",$3);
         if ($3 ~ "ё") { yolca[yok]=$3; };
         yolcg[yok]=$3;

   }; close(cmd);

   FS = save_FS

   cmd = "zcat " indb "mano-lc.gz " indb "mano-uc.gz";
   while ((cmd|getline) > 0) {

         for (i=2; i<=NF; i++) {
           if ( $i ~ "ё")  {
           omoyo[$i];
           gsub("ё","е",$i); gsub("'","",$i)
           yoda[$i]
         } };

      }; close(cmd);

   for (i in omoyo) {
            yok=gensub("'","","g",i)
      if ( !(yok in yodef) ) {
        if (yok !~ "-" ) {yodef[yok] = i };
      }

   }

# Склеиваем массивы в строку.

      for (i in yodef) { yopat = yopat "\n_" i "="; yodic = yodic "\n_" i "=" yodef[i] };
      for (i in yolca) { lcpat = lcpat "\n_" i "="; lcdic = lcdic "\n_" i "=" yolca[i] };
      for (i in yolcg) { if (i in yoda) {
        yolcpat = yolcpat "\n_" i "="; yolcdic = yolcdic "\n_" i "=" yolcg[i] };};

# Записываем строки

      print substr(yodic,2) | "gzip > " indb "yoyo.gz";
      print substr(yopat,2) | "gzip > " inax "yoyo.pat.gz";

      print substr(yolcdic,2) | "gzip > " indb "yolc.gz";
      print substr(yolcpat,2) | "gzip > " inax "yolc.pat.gz";

      print substr(lcdic,2) | "gzip > " indb "yoyo_lc.gz";
      print substr(lcpat,2) | "gzip > " inax "yoyo_lc.pat.gz";

      gsub("ё","е",yopat); gsub("ё","е",lcpat);

      print substr(yopat,2) | "gzip > " inax "yoye.pat.gz";
      print substr(lcpat,2) | "gzip > " inax "yoye_lc.pat.gz";

}
