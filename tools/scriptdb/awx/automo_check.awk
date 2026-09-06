# Скрипт проверки групп для автоматической системы разрешения омографов
BEGIN {
   cmd = "zcat class.list.gz";
   while ((cmd|getline) > 0) { class[$1][$2]; if($3) class[$1][$3]; if($4) class[$1][$4];};
   close(cmd);

   cmd = "zcat automo.gz";
   while ((cmd|getline) > 0) { erclas=erword="";
     
     oqty[$1][$2]++

     s0=$0; gsub("ё","е",$4); gsub("'","",$4);

     if ( !($3 in class[$1]) ) { erclas = 1 };
     if ( $4 != $2 )  { erword = 1 };

     if (erclas == 1) { print "automo.gz (class) : " s0 }
     if (erword == 1) { print "automo.gz (words) : " s0 }

    }
   close(cmd);


   for (i in oqty) {
     cllen = length(class[i])
     for (j in oqty[i] ){
       if (oqty[i][j] > cllen) { print "automo.gz (too many vars) : " i, j };
       if (oqty[i][j] < cllen) { print "automo.gz (too few vars) : " i, j };
       }
     }

  }
