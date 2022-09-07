# Формирует списки омографов lc, uc, cc, ca
# на входе задать переменные: omtype
function Zag(str,    ret) { # Записать строку с заглавной буквы
                ret = toupper(substr(str,1,1)) substr(str,2); return ret }

BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"
  indb = "scriptdb/"
  inax = "scriptaux/"
  omlc = omtype "-lc.gz"
  omuc = omtype "-uc.gz"

   cmd = "zcat " indb omlc;
   while ((cmd|getline) > 0) {
     if ($0 !~ "-") {
         gsub(/[_=]/,"",$1)
         lcOMO[$1]
         ucOMO[Zag($1)]
         ccOMO[toupper($1)]

         for (i=2; i<=NF; i++) {
            sinda = index($i,"\x27")-1;
            uglas = substr($i,sinda,1)

            if (sinda > 1 && $i !~ "-") {
              if ( uglas != "ё") {
                w0rd=substr($1,1,sinda-1) toupper(substr($1,sinda,1)) substr($1,sinda+1);
                caOMO[w0rd]; caOMO[Zag(w0rd)];
              }
              else {
                w0rd=substr($1,1,sinda-1) "Ё" substr($1,sinda+1);
                caOMO[w0rd]; caOMO[Zag(w0rd)];
              }
         };};

      };}; close(cmd);

   cmd = "zcat " indb omuc;
   while ((cmd|getline) > 0) {
     if ($0 !~ "-") {
         gsub(/[_=]/,"",$1)
         gsub("\x27","\xcc\x81",$0);
         ucomo[$1]
         ucOMO[Zag($1)]
         ccOMO[toupper($1)]

         for (i=2; i<=NF; i++) {
            sinda = index($i,"\x27")-1;
            uglas = substr($i,sinda,1)

            if (sinda > 1) {
              if ( uglas != "ё") {
                w0rd=substr($1,1,sinda-1) toupper(substr($1,sinda,1)) substr($1,sinda+1);
                caOMO[w0rd]; caOMO[Zag(w0rd)];
              }
              else {
                w0rd=substr($1,1,sinda-1) "Ё" substr($1,sinda+1);
                caOMO[Zag(w0rd)];
              }
         };};

      };}; close(cmd);



     oo=""; for (i in lcOMO) { oo = oo "\n_" i "=" }; print substr(oo,2) | "gzip > " inax omtype "-lc.pat.gz";
     oo=""; for (i in ucOMO) { oo = oo "\n_" i "=" }; print substr(oo,2) | "gzip > " inax omtype "-uc.pat.gz";
     oo=""; for (i in ucomo) { oo = oo "\n_" i "=" }; print substr(oo,2) | "gzip > " inax omtype "-sm.pat.gz";
     oo=""; for (i in ccOMO) { oo = oo "\n_" i "=" }; print substr(oo,2) | "gzip > " inax omtype "-cc.pat.gz";
     oo=""; for (i in caOMO) { oo = oo "\n_" i "=" }; print substr(oo,2) | "gzip > " inax omtype "-ca.pat.gz";


}
