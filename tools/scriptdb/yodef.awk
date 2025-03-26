# Скрипт ёфикации однозначных случаев
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts
@load "rwarray"
@include "scriptdb/functions.awk"

BEGIN {
    PROCINFO["sorted_in"]="@ind_num_asc"

    patword = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb00-9]+"
    fsword  = "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb0]"
    capword = "^[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]+$"

 # Проверяем версию gawk, если меньше 5.2.1, то выключаем функции сохранения и восстановления массивов и переменных: базы тогда читаются всегда заново.
    redix=gawk52="42"
    cmd = "awk -Wversion | head -1"
    cmd|getline verheader; close(cmd)
    split(verheader, gnuawk, "[ .,]")
    if (gnuawk[1] == "GNU" && gnuawk[2] == "Awk" && gnuawk[3] >= 5 && gnuawk[4] >= 2 && gnuawk[5] >= 1) { gawk52 = 1 };
 # Если словари и этот скрипт не изменились и gawk>=5.2.1, восстановить состояние, иначе прочитать всё заново.
   if ( gawk52 == 1 ) {
    cmd   = "md5sum -c --status " inax "yodef.md5 >/dev/null 2>&1"
    redix = system(cmd); close(cmd);};

   yocache = inax "yodef.bin"

   if (redix == 0 && gawk52 == 1) { readall(yocache) } else {

   cmd = "zcat " indb "yodef.gz " indb "yodhy.gz | \
          sed -r 's/([_=-])(.)/\\1\\u\\2/g; s/_//g; s/=/ /g; \
                  s/(.)(.+) (.)(.+)/\\L\\1\\2 \\3\\4\\E \\1\\L\\2\\E \\3\\L\\4\\E \\U\\0\\E \\0/g; \
                  s/\\x27/\xcc\x81/g;'";
   while ((cmd|getline) > 0) {
         yok=gensub("\\xcc\\x81","","g",$2)
         Yok=gensub("\\xcc\\x81","","g",$4)
         YOK=gensub("\\xcc\\x81","","g",$6)
         YoK=gensub("\\xcc\\x81","","g",$8)

         yodef[$1] =$2; yodef[$3] =$4; yodef[$5] =$6; yodef[$7] =$8;
         yodef[yok]=$2; yodef[Yok]=$4; yodef[YOK]=$6; yodef[YoK]=$8;

   } close(cmd);

   cmd = "zcat " indb "yolc.gz | sed -r 's/^_//g; s/=/ /g; s/\\x27/\xcc\x81/g'";
   while ((cmd|getline) > 0) {

        if ($2 ~ /[Ёё]/) { yok = gensub("'","","g",$2); yodef[yok]=$2; };
        yodef[$1]=$2;

   } close(cmd);

 # Записать состояние словарных массивов
  if (gawk52 == 1) { writeall(yocache) };
  cmd = "md5sum " indb "yodef.awk " inax "yodef.bin " indb "yodef.gz " indb "yodhy.gz " indb "yolc.gz > " inax "yodef.md5"
  system(cmd); close(cmd);
   } #gnuawk

       # Всё с регистрами
       cst="все=всё";
       tuptoar(cst,vsyo)

       # Омографы с относительно простыми правилами
       cst="всем=всём е=ё моем=моём нем=нём припеку=припёку сем=сём таки=таки чем=чём черт=чёрт";
       tuptoar(cst,omoz)

       # Компоненты составных слов с ё
       cst="блекло=блёкло варено=варёно желто=жёлто зелено=зелёно пестро=пёстро солено=солёно твердо=твёрдо тепло=тёпло темно=тёмно черно=чёрно пожелто=пожёлто позелено=позелёно \
            потемно=потёмно почерно=почёрно";
       tuptoar(cst,cmpy)

       cst="трех=трёх";
       tuptoar(cst,trex)
       cst="четырех=четырёх";
       tuptoar(cst,qtrx)

   savefs = FS;
   FS = fsword;
} {
    num++; book[num] = $0;

    for ( i=1; i<=NF; i++ ) { ci = tolower($i);
        if ( ci in yodef && num != num00[$i] ) { yods[$i] = yods[$i] " " num; num00[$i] = num; continue };
        if ( $i in omoz  && num != num01[$i] ) { omos[$i] = omos[$i] " " num; num01[$i] = num; continue };
        if ( $i in cmpy  && num != num02[$i] ) { cmps[$i] = cmps[$i] " " num; num02[$i] = num; continue };
        if ( $i ~ /(^|десяти|дцати|сорока|исяти|ста|тысяче)трех\S/    && num != num03[$i] ) { Trex[$i] = Trex[$i] " " num; num03[$i] = num; continue };
        if ( $i ~ /(^|десяти|дцати|сорока|исяти|ста|тысяче)четырех\S/ && num != num04[$i] ) { qTrx[$i] = qTrx[$i] " " num; num04[$i] = num; continue };
        };
   }
END {
FS = savefs
    for(wrd in yods ){wln=split(yods[wrd],yolin," ");for(y=1;y<=wln;y++){b=strtonum(yolin[y]);nf=splitline(book[b]);
    for (i=1; i<=nf; i++) { if ( l[i] in yodef ) { l[i]=yodef[l[i]] }; };
#      if ( l[i] ~ capword ) { lcf=tolower(l[i]); if ( lcf in yodef ) { l[i]=toupper(yodef[lcf]) }; }
#      else { if ( l[i] in yodef ) { l[i]=yodef[l[i]] }; }; };

    book[b]=joinpat(l,sep,nf)};};


### трех- !_#_!
    for(wrd in Trex ){wln=split(Trex[wrd],omlin," ");rexa=regwpart(wrd,"трех");somo=trex[rexa];for(y=1;y<=wln;y++)                 # header1
    {b=strtonum(omlin[y]);nf=splitline(book[b]);regwpos(wrd);for(i in wpos){i=strtonum(i);if(tolower(l[i])!=tolower(wrd))continue; # header2

      sub(rexa,somo,l[i]); r[2]++; if(dbg){print "R2"}; continue;
  
    }; book[b]=joinpat(l,sep,nf);};}; # footer
### четырех- !_#_!
    for(wrd in qTrx ){wln=split(qTrx[wrd],omlin," ");rexa=regwpart(wrd,"четырех");somo=qtrx[rexa];for(y=1;y<=wln;y++)              # header1
    {b=strtonum(omlin[y]);nf=splitline(book[b]);regwpos(wrd);for(i in wpos){i=strtonum(i);if(tolower(l[i])!=tolower(wrd))continue; # header2

      sub(rexa,somo,l[i]); r[2]++; if(dbg){print "R2"}; continue;
  
    }; book[b]=joinpat(l,sep,nf);};}; # footer
### cmpy !_#_!
    for(wrd in cmps){wln=split(cmps[wrd],omlin," ");somo=cmpy[wrd];for(y=1;y<=wln;y++)     # header1
    {b=strtonum(omlin[y]);nf=splitline(book[b]);regwpos(wrd);for(i in wpos){i=strtonum(i); # header2

      if ( sL(0,"-")||sR(-1,"-") )
      { l[i]=somo; r[10]++; if(dbg){print "R10"}; continue;};
           
    }; book[b]=joinpat(l,sep,nf)};}; # footer

# Различные слова из omoz
    for(wrd in omos){wln=split(omos[wrd],omlin," ");somo=omoz[wrd];for(y=1;y<=wln;y++){b=strtonum(omlin[y]);nf=splitline(book[b]); # wrd in omos

### всем !_#_!
    if(tolower(wrd)== "всем" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"во о обо на при") && s(-1) )
      { l[i]=somo; r[2]++; if(dbg){print "R2"}; continue;};
  
    }; book[b]=joinpat(l,sep,nf);}; # footer

### моем !_#_!
    if(tolower(wrd)== "моем" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"в о об на при") && s(-1) )
      { l[i]=somo; r[3]++; if(dbg){print "R3"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### нем !_#_!
    if(tolower(wrd)== "нем" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"в о об на при по") && s(-1) )
      { l[i]=somo; r[4]++; if(dbg){print "R4"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### припеку !_#_!
    if(tolower(wrd)== "припеку" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"сбоку") && se(-1,"-") )
      { l[i]=somo; r[13]++; if(dbg){print "R13"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### сем !_#_!
    if(tolower(wrd)== "сем" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"в о об на при по") && s(-1) )
      { l[i]=somo; r[5]++; if(dbg){print "R5"}; continue;};
      if ( w(-1,"сам") && se(-1,"-") )
      { l[i]=somo; r[13]++; if(dbg){print "R13"}; continue;};

    }; book[b]=joinpat(l,sep,nf)}; # footer

### чем !_#_!
    if(tolower(wrd)== "чем" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( !(w(-2,"не") && s(-2,-2)) && 
              w(-1,"в о об на при по") && s(-1) )
      { l[i]=somo; r[7]++; if(dbg){print "R7"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### таки !_#_!
    if(tolower(wrd)== "таки" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

      if ( w(-1,"все") && se(-1,"-") )
      { somo=vsyo[l[i-1]];l[i-1]=somo; r[8]++; if(dbg){print "R8"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### е !_#_!
    if(tolower(wrd)== "е" ){regwpos(wrd);for(i in wpos){i=strtonum(i); # header

       if ( se(0,"-") && w(1,"моё мое") )
       { l[i]=somo; r[9]++; if(dbg){print "R9"}; continue;};
   
    }; book[b]=joinpat(l,sep,nf)}; # footer

### черт !_#_!
    if(tolower(wrd)== "черт" ){for(i=1; i<=nf; i++){if(l[i]==wrd)wpos[i];};for(i in wpos){i=strtonum(i); # header

       if ( se(0,"-") && w(-1,"те") )
       { l[i]=somo; r[18]++; if(dbg){print "R18"}; continue;};

    }; book[b]=joinpat(l,sep,nf)}; # footer

       }; # b in omos
   }; # omos

### END_SECTION !_#_!
 # вывести изменённую строку

 for (i=1; i<=num; i++) { print book[i] }


#dbgstat = 1;
 cmd = "rm _stat.txt _yods.txt _omos.txt"
 if (dbgstat==1) {system(cmd);
     for (i=1; i<=572; i++) { printf ("%s%s %s %s\n", "R", i, "=", r[i]) >> "_stat.txt"};
     for (i in yods) { print i, yods[i] >> "_yods.txt"}
     for (i in omos) { print i, omos[i] >> "_omos.txt" }
                 };
}

