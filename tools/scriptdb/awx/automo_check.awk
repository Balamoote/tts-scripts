# Скрипт проверки групп для автоматической системы разрешения омографов
BEGIN {
   cmd = "zcat class.list.gz";
   while ((cmd|getline) > 0) { class[$1][$2]; class[$1][$3]; class[$1][$4]; };
   close(cmd);

   cmd = "zcat automo.gz";
   while ((cmd|getline) > 0) { err="";
     
     s0=$0; gsub("ё","е",$4); gsub("'","",$4);

     if ( !($3 in class[$1]) ) { err = 1 };
     if ( $4 != $2 )  { err = 2 };
     if (err == 1) { print "automo.gz (class) : " s0 }
     if (err == 2) { print "automo.gz (words) : " s0 }

    }
   close(cmd);
  }
