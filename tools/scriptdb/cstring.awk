BEGIN {
    # массивы для разных целей, которые всегда читаются при запуске из-за частых правок
    # Метки:
    # BASE = список базовых форм (инфинитив, и.п.ед.ч, и т.д.)             = ba bba bfa
    # FLAT = список слов в определённых формах (падеж, лицо, время и т.д.) = wa wba wfa
    # X_метка: Пример: X_gl_v_castle-iv escape: отдельные словоформы, которые не должны срабатывать. Например совпадение словоформ глагола и существительного

  # прочесть список некондиции
  if ( escan ) { cmd = "zcat " indb "rawstuff.gz";#nem="";
                 while ((cmd|getline) > 0) { rawstuff(nem++); }; close(cmd); stoar(escan,eSCAN,"_"); };
  # Вывести список ключевых слов из rawstuff.gz
# for (i in eOMO) printf("eOMO: %s %s\n", i, length(eOMO[i]) )

  # обработка ударений, обозначенных капсом, кроме ударения на первую букву слова
  if ( escap ) {
   cmd = "zcat " indb "mano-lc.gz";
   while ((cmd|getline) > 0) {

         for (i=2; i<=NF; i++) { sinda[i]=index(gensub(/[\\xcab0-9]/,"","g",$i),"\x27")-1 };
#        gsub("\\\\xcc\\\\xa0","\xcc\xa0",$0); gsub("\\\\xcc\\\\xa3","\xcc\xa3",$0); gsub("\\\\xcc\\\\xa4","\xcc\xa4",$0)
#        gsub("\\\\xcc\\\\xad","\xcc\xad",$0); gsub("\\\\xcc\\\\xb0","\xcc\xb0",$0);
         gsub("\x27","\xcc\x81",$0); gsub(/[_=]/,"",$0)

         for (i=2; i<=NF; i++) { if(sinda[i]>1) { w0rd=substr($1,1,sinda[i]-1) toupper(substr($1,sinda[i],1)) substr($1,sinda[i]+1); cOMO[w0rd]=$i
                                                  w0rd=Zag(w0rd); cOMO[w0rd]=Zag($i) };};
   }; close(cmd); stoar(escap,eSCAP,"_");

   cmd = "zcat " indb "mano-uc.gz";
   while ((cmd|getline) > 0) {

         for (i=2; i<=NF; i++) { sinda[i]=index(gensub(/[\\xcab0-9]/,"","g",$i),"\x27")-1 };
#        gsub("\\\\xcc\\\\xa0","\xcc\xa0",$0); gsub("\\\\xcc\\\\xa3","\xcc\xa3",$0); gsub("\\\\xcc\\\\xa4","\xcc\xa4",$0)
#        gsub("\\\\xcc\\\\xad","\xcc\xad",$0); gsub("\\\\xcc\\\\xb0","\xcc\xb0",$0);
         gsub("\x27","\xcc\x81",$0); gsub(/[_=]/,"",$0)

         for (i=2; i<=NF; i++) { if(sinda[i]>1) { w0rd=substr($1,1,sinda[i]-1) toupper(substr($1,sinda[i],1)) substr($1,sinda[i]+1);
                                                  w0rd=Zag(w0rd); cOMO[w0rd]=Zag($i) };};
   }; close(cmd); stoar(escap,eSCAP,"_");
 };

  # Часть массивов omarr перенесены в cstrings.gz, это эквивалент вызова функции omarr в данном файле
  cmd = "zcat " indb "cstrings.gz";
  while ((cmd|getline) > 0) {
    if($2 == "1x" && $NF == "[=") { cstgrp = $1} else { for (i=1; i<=NF; i++) { if($i!= "=]" && $i!="")       {omarr[cstgrp][$i] }; }; };
    if($2 == "2x" && $NF == "[=") { cstgrp = $1} else { for (i=1; i<=NF; i++) { if($i!= "=]" && $i!="") addw2x($i,omarr[cstgrp]) }; };
    if($2 == "3x" && $NF == "[=") { cstgrp = $1} else { for (i=1; i<=NF; i++) { if($i!= "=]" && $i!="") addw3x($i,omarr[cstgrp]) }; };
  }; close(cmd);

 # geo ---> заменитьна loc
 # geo_edsrim BASE
 cst="баку балахонье бездомье белогорье беломорье бордо вильно гродно запорожье кале ковно левобережье мехико нагасаки огайо осло палермо побужье поволжье \
      поднепровье подолье полесье правобережье причерноморье рио ровно сантьяго тбилиси токио чили";
 stoar(cst,geo_edsrim," "); #

 # geo_mnim BASE
 cst="альпы аппенины афины балканы вогезы гималаи канны карпаты кордильеры лубны пиренеи татры фивы чебоксары";
 stoar(cst,geo_mnim," "); #

 # titl BASE
 cst="веб-мастер генерал-майор герр гражданин доктор дон инженер-майор лорд-мэр майор мастер мистер мужик мэр обер-мастер пан плац-майор премьер-майор ревизор \
      рядовой секунд-майор сержант сэр товарищ";
 stoar(cst,titl," "); #

 # слова с признаками модальности
 cst="готово довелось доводилось должно жаль можно надо надобно нельзя нужно охота понадобилось пора приходилось пришлось способно суждено";
 stoar(cst,md_bz," "); #
 cst="будет готов готова должен должна способен способна";
 stoar(cst,md_ed," "); #
 cst="будут готовы должны способны";
 stoar(cst,md_mn," "); #
 # глаголы в cstauto.awk, т.к. они нужны для сканирования базы глаголов


 # кастомные массивы для слов-омографов находятся в массиве omarr["метка"]
 # !!! Ниже дополнение для основного метода загрузки этих массивов из cstrings.gz
 pusha(omarr["_castle_suw-ro"],omarr["_castle_suw-ro2"])
 pusha(omarr["_castle_suw-ro1"],omarr["_castle_suw-ro2"])
 # ================================================================================================================

 # _gl_v_palate BASE
 cst="";
 mrk="_gl_v_palate-iv"; stoar(cst,omarr[mrk]," "); #

 # _gl_v_sky BASE
 cst="вонзать вонзаться";
 mrk="_gl_v_sky-iv"; stoar(cst,omarr[mrk]," "); #

 # _sky_pe BASE
 cst="бороздить";
 mrk="_sky_pe"; stoar(cst,omarr[mrk]," "); #

 # _palate_suw-ro FLAT
 cst="монстра чудовища";
 mrk="_palate_suw-ro"; stoar(cst,omarr[mrk]," "); #

## Возможные варианты добавления:
##
## _castle_tv BASE[|FLAT]
#cst="владеть";
#mrk="_castle_tv"; stoar(cst,omarr[mrk]," "); #

## M_lock_na_suw-pr_gl_qerez_castle MATCH
#cst="руках_тащить";
#mrk="M_lock_na_suw-pr_gl_qerez_castle";sto2xw(cst,omarr[mrk]); #

## _castle_w_w_w FLAT
#cst="авара_вил_умена азей_ле_ридо";
#mrk="_castle_w_w_w";sto3xw(cst,omarr[mrk]); #


}

