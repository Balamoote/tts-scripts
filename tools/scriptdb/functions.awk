# Библиотека различных функций обработки текста
# Последняя версия файла тут: https://github.com/Balamoote/tts-scripts

# служебные фунции
function readfile(file,  tmp, save_rs) {            # Функция чтения файла в скаляр
                save_rs = RS; RS = "^$"; getline tmp < file; close(file); RS = save_rs; return tmp }
function joinpat(array, seps, nuf,    ret, i, k) {  # Склеить строку обратно
                ret = seps[0]; for (i=1; i<= nuf; i++) {ret = ret array[i] seps[i]}; return ret }
function pusha(arr, arrto,    k) {                  # добавить массив в целевой массив
                for (k in arr) {arrto[k]}; }
function abs(n) { # модуль числа
                n = n+0; if(n<0) n= -1*n; return n }
function Zag(str,    ret) { # Записать строку с заглавной буквы
                ret = toupper(substr(str,1,1)) substr(str,2); return ret }
function stoar(string, arrto, sepr,    artmp,k) {         # добавить в массив arrto элементы строки string
                split(string, artmp, sepr); for (k in artmp) {if(artmp[k]) {arrto[artmp[k]]}; };}
function tuptoar(string, arrto,   artmp, al, k) { # добавить в массив arrto элементы строки string типа 'слово=слово' с вариантами слово, Слово, СЛОВО
                split(string, artmp, "[ =]"); al=length(artmp); for (k=1; k<=al; k=k+2) {if(artmp[k]) {
                arrto[artmp[k]]=artmp[k+1]; arrto[toupper(artmp[k])]=toupper(artmp[k+1]); arrto[Zag(artmp[k])]=Zag(artmp[k+1]) }; };}
function stotar(string, arrto, sepr,    artmp, k, ret) { # добавить во ВРЕМЕННЫЙ массив arrto элементы строки string
                delete arrto;ret=split(string, artmp, sepr); for (k in artmp) {if(artmp[k]) {arrto[artmp[k]]}; }; return ret}
function sto2xw(string, arrto,   artmp,arr1,j,k) {             # добавить в массив arrto элементы строки для 2-х связанных слов w1:w2 arrto[w1][w2]
                split(string, artmp, " "); for (k in artmp) { if(artmp[k]) { split(artmp[k], arr1, "_"); arrto[arr1[1]][arr1[2]] }; }; }
function sto3xw(string, arrto,   artmp,arr1,j,k) {             # добавить в массив arrto элементы строки для 3-х связанных слов w1:w2,w3 arrto[w1][w2][w3]
                split(string, artmp, " "); for (k in artmp) { if(artmp[k]) { split(artmp[k], arr1, "_"); arrto[arr1[1]][arr1[2]][arr1[3]] }; }; }
function stoid(string1, string2,wid,   art1, k,j) {      # добавить в omoid[омограф из строки][омоид из строки][функция]
                split(string1, arr1," ");split(string2, arr2," "); for (k in arr1) {for(j in arr2){omoid[arr1[k]][arr2[j]][wid]};};}
function atoid(string, arr,wid,    k,j) {           # добавить в omoid[омограф из массива][омоид из строки][функция]
                split(string, arr1," "); for (k in arr1) {for(j in arr){omoid[j][arr1[k]][wid]};};}
function addw2x(el, arrto,   artmp,j,k) {          # добавить в массив arrto два_слова
                split(el, artmp, "_"); if( el && length(artmp)==2 ) {arrto[artmp[1]][artmp[2]]} } 
function addw3x(el, arrto,   artmp,j,k) {          # добавить в массив arrto три_таких_слова
                split(el, artmp, "_"); if( el && length(artmp)==3 ) {arrto[artmp[1]][artmp[2]][artmp[3]]} } 
function sanit(string, sepin, sepout,   artmp,j,k,ret) {  # строку с разделителями отсортировать и удалить повторения
                delete sant; split(string,artmp,sepin); for(k in artmp){if(artmp[k]){sant[artmp[k]]}; }; for(j in sant) {if(ret) {ret = ret sepout j}else{ret=j} }; return ret}
function hyphback(hystring,     l0,l1,l2,sw,hyw) {    # Склеить слова с дефисом, присутствующие в словаре
                  hystring = gensub(/unxyp/,"","g",tolower(hystring)); if (hystring ~ hysnip) { for (i=1; i<=nf-1; i++) {sw="";
                  if( sc(0,"-") ){ sw=1; l0=lc(0); l1=lc(1); if( sc(1,"-") ) { sw=2; l2=lc(2) }; };
                  switch (sw) {
                  case "1": if (l0 != iwrd && l1 != iwrd) { hyw = l0 "-" l1; if (hyw in dichyph) { l[i] = l[i] sep[i] l[i+1];
                            delete sep[i]; delete l[i+1]; nf=arrpack(i+1,l); arrpack(i, sep) };}; break
                  case "2": if (l0 != iwrd && l1 != iwrdi && l2 != iwrd) { hyw = l0 "-" l1 "-" l2; if (hyw in dichyph) { l[i] = l[i] sep[i] l[i+1] sep[i+1] l[i+2];
                            delete sep[i]; delete l[i+1]; nf=arrpack(i+1,l); arrpack(i,sep);
                            delete sep[i]; delete l[i+1]; nf=arrpack(i+1,l); arrpack(i,sep) };}; break
                  default: break }; }; }; }
function hyphbphy(hystring,     l0,l1,l2,sw,hyw,es,ess) {    # Склеить слова с дефисом, присутствующие в словаре
                  hystring = gensub(/<#@_[^@]+@#>/,"","g",tolower(hystring)); if (hystring ~ hysnip) { for (i=1; i<=nf-1; i++) { sw="";
                  if ( sepphy[i] ~ "-"   ) { sw=1; l0=tolower(lphy[i]); l1=tolower(lphy[i+1]); if ( sepphy[i] ~ /<#@_[^@]+@#>/ ) sw=3;
                  if ( sepphy[i+1] ~ "-" ) { sw=2; l2=tolower(lphy[i+2]); if ( sepphy[i+1] ~ /<#@_[^@]+@#>/ ) sw=4; }; };
                  switch (sw) {
                  case "1": if (l0 != iwrd && l1 != iwrd) { hyw = l0 "-" l1; if (hyw in dichyph) { lphy[i] = lphy[i] sepphy[i] lphy[i+1];
                            delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy) };}; break
                  case "2": if (l0 != iwrd && l1 != iwrdi && l2 != iwrd) { hyw = l0 "-" l1 "-" l2; if (hyw in dichyph) {
                            lphy[i] = lphy[i] sepphy[i] lphy[i+1] sepphy[i+1] lphy[i+2]; delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy);
                            delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy) };}; break
                  case "3": if (l0 != iwrd && l1 != iwrd) { hyw = l0 "-" l1; if (hyw in dichyph) { es=gensub("-","","g",sepphy[i]);
                            lphy[i] = lphy[i] "-" lphy[i+1]; sepphy[i+1] = es sepphy[i+1];
                            delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy) };}; break
                  case "4": if (l0 != iwrd && l1 != iwrd && l2 != iwrd) { hyw = l0 "-" l1 "-" l2; if (hyw in dichyph) { es=gensub("-","","g",sepphy[i]);
                            ess=gensub("-","","g",sepphy[i+1]); lphy[i] = lphy[i] "-" lphy[i+1] "-" lphy[i+2]; sepphy[i+2] = es ess sepphy[i+2];
                            delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy);
                            delete sepphy[i]; delete lphy[i+1]; nf=arrpack(i+1,lphy); arrpack(i,sepphy) };}; break
                  default: break }; }; }; }
function hyphbphy_(hystring,    l0,l1,l2,sw,hyw) {      # Склеить слова с дефисом, присутствующие в словаре
                  hystring = gensub(/<#@_[^@]+@#>/,"","g",tolower(hystring));
                  if (hystring ~ hysnip) { for (i=1; i<=nf-1; i++) {
                  if ( sepphy[i] == "-" && sepphy[i+1] != "-")  { l0=tolower(lphy[i]); l1=tolower(lphy[i+1]); if (l0 != iwrd && l1 != iwrd) { hyw = l0 "-" l1;
                    if ( hyw in dichyph ) { lphy[i] = lphy[i] sepphy[i] lphy[i+1]; delete sepphy[i]; delete lphy[i+1]; nfphy=arrpack(i+1, lphy); arrpack(i, sepphy) };};};
                  if ( sepphy[i] == "-" && sepphy[i+1] == "-" ) { l0=tolower(lphy[i]); l1=tolower(lphy[i+1]); l2=tolower(lphy[i+2]);
                    if (l0 != iwrd && l1 != iwrd && l2 != iwrd) { hyw = l0 "-" l1 "-" l2; if ( hyw in dichyph ) { lphy[i] = lphy[i] sepphy[i] lphy[i+1] sepphy[i+1] lphy[i+2];
                    delete sepphy[i]; delete lphy[i+1]; nfphy=arrpack(i+1, lphy); arrpack(i, sepphy); nfphy=arrpack(i+1, lphy); arrpack(i, sepphy) };};};
                  if ( sepphy[i] ~ /(-<#@_[^@]+@#>)|(<#@_[^@]+@#>-)/ ) {l0=tolower(lphy[i]); l1=tolower(lphy[i+1]); if (l0 != iwrd && l1 != iwrd) { hyw = l0 "-" l1;
                  if ( hyw in dichyph ) { lphy[i] = lphy[i] "-" lphy[i+1]; sepphy[i+1] = sepphy[i] sepphy[i+1]; delete sepphy[i]; delete lphy[i+1];
                  nfphy=arrpack(i+1, lphy); arrpack(i, sepphy) }; };};   };};}
function splitline(string,    ret) {              # Разбить строку на слова
                ret=patsplit(string,l,patword,sep); return ret }
function splitlinephy(string,    ret) {             # Разбить строку на слова
                ret=patsplit(string,lphy,patword,sepphy); return ret }
function regwpart(word, part,    ret) {             # Получить заменяемую часть слова в нужном регистре
                ret=substr(word,index(tolower(word),part),length(part)); return ret }
function getwpos(word,    n) {                      # Получить адрес слова в строке, Без учёта регистра
                delete wpos; for(n=1;n<=nf;n++) {if(tolower(l[n])==word) wpos[n]} }
function regwpos(word,    n) {                      # Получить адрес слова в строке, с учётом регистра
                delete wpos; for(n=1;n<=nf;n++) {if(l[n]==word) wpos[n]} }
function arrpack(n, array,   i, ret) {              # устранить пропуск в массиве
                ret = length(array); for (i=n; i<=ret; i++) {array[i] = array[i+1]}; delete array[ret+1]; return ret }
function omakevars(xklass) {                        # определить переменные iwrd, winfo, omoX
                iwrd=tolower(wrd);winfo=oms[xklass]["info"][iwrd];wln=split(omap[xklass][wrd],omlin," ");
                omo1=oms[xklass][xclass[xklass][1]][wrd];omo2=oms[xklass][xclass[xklass][2]][wrd];omo3=oms[xklass][xclass[xklass][3]][wrd] }
function makebookvars() {                           # разбить строку, но склеить словарные слова с дефисом
                b=strtonum(omlin[y]);nf=splitline(book[b]);splitlinephy(bphy[b]);hyphback(book[b]);hyphbphy(bphy[b]);regwpos(wrd); }
function makebookvars_nohyphback() {                # разбить строку, но словарные слова с дефисом не склеивать
                b=strtonum(omlin[y]);nf=splitline(book[b]);splitlinephy(bphy[b]);regwpos(wrd); }
function makewposvars() {                           # определить переменные внутри цикла для слова в позиции i
                i=strtonum(i); delete Y;
                prex=edro2mnim=edro2mnvi=nizm=mn2e2pomn=loc2emd=loc2ezd=NORULE=tn=hyn=qyn=wyn=do_tn="" }
function DO_DEBUG(array,a_prefix,   outfile, k,cmd) {
                outfile = "_" a_prefix ".txt"; for (k in array) { if ( array[k] ) {printf ("%s%s %s %s\n", a_prefix, k, "=", array[k]) >> outfile }; }; }
function rfix(n,m) {             # ограничить диапазон размерами строки
                if( n+i < 1 ) n = 1-i; if ( m+i < nf ) m = nf-i-1 }

# x0300
function rawstuff(nem,    stn,len,ph,phr,lk,wrda,sepa,j,hystring,l0,l1,l2,sw,hyw,omn) { # Функция чтения файла rawstuff.gz с некондицией
      stn=index($0,"#")+3; len=length($0); ph=substr($0,stn,len-stn); phr=cLs(ph); lk=patsplit(phr,wrda,patword,sepa);
      for(j=1; j<=lk; j++) {eWRD[nem][j-$4]=wrda[j]}; eOMO[wrda[$4]][nem]=oms[$1][xclass[$1][substr($2,4,1)]][wrda[$4]];
      # для строки: s = ignore start sep; e = ignore end sep; S,E = do NOT ignore s/e seps; L = last char of 1st sep; R = 1st char of last sep
      switch ($3) {
        case "se": for(j=1; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; break
        case "Se": for(j=0; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; break
        case "sE": for(j=1; j<=lk; j++) {eSEP[nem][j-$4]=sepa[j]}; break
        case "SE": for(j=0; j<=lk; j++) {eSEP[nem][j-$4]=sepa[j]}; break
        case "Le": for(j=1; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; eSPL[nem][-$4]=substr(sepa[0],length(sepa[0])); break
        case "sR": for(j=1; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; eSPR[nem][lk-$4]=substr(sepa[lk],1,1); break
        case "LE": for(j=1; j<=lk; j++) {eSEP[nem][j-$4]=sepa[j]}; eSPL[nem][-$4]=substr(sepa[0],length(sepa[0])); break
        case "SR": for(j=0; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; eSPR[nem][lk-$4]=substr(sepa[lk],1,1); break
        case "LR": for(j=1; j< lk; j++) {eSEP[nem][j-$4]=sepa[j]}; eSPL[nem][-$4]=substr(sepa[0],length(sepa[0])); eSPR[nem][lk-$4]=substr(sepa[lk],1,1); break
        default: break } }
function esca(    j,k,f,el,sk,sl, ret) {   # точная фраза как строка из файла rawstuff.gz -- выставляет омограф сама, только найденные ранее строки b и текущий омограф
        if ( b in eSCAN && length(eOMO[wrd]) ) { for (j in eOMO[wrd]) {ret=1; for (k in eWRD[j]) { el = cL(k); if ( el != eWRD[j][k] ) { ret=0; break};};
        if (ret) { for (f in eSPL[j]) { sk=gensub(unxy,"","g",sep[i+f]); sl=substr(sk,length(sk)); if ( sl != eSPL[j][f] ) { ret=0 }; break }; };
        if (ret) { for (f in eSPR[j]) { sk=gensub(unxy,"","g",sep[i+f]); sl=substr(sk,1,1);        if ( sl != eSPR[j][f] ) { ret=0 }; break }; };
        if (ret) { for (k in eSEP[j]) { if(gensub(unxy,"","g",sep[i+k]) != eSEP[j][k] ) { ret=0; break };};}; 
        if (ret) { l[i]=eOMO[wrd][j];  break };};}; return ret}
function ecap(    j,k,f,el,sk,sl, ret) {   # выделение ударения капсами
        if ( b in eSCAP && wrd in cOMO ) { ret=1; l[i]=cOMO[wrd]; }; return ret}

# функции обработки слов: сбор слов для записи в отдельный файл
function getBF(n,class,file,   itmz, k) {                      # выдать базовую форму слова по адресу n и записать ее в file, омограф при этом в файл не пишется
                catch_file=file; stotar(wordbf(n),itmz,"#"); for(k in itmz) { if( q_str(k,class) )  wCAT[k] };}
function getBFb(n,m,file,    k, ret) {              # выдать базовые формы слов в диапазоне {-n,-m} и записать их в file (только словарные базовые формы, без препинаний)
                for (k=m; k>=n; k--) {if(l[i+k]) ret = sanit(wordbf(k),"#","\x2f") " " ret }; ret = ret iwrd; print ret >> file }
function getBFf(n,m,file,    k, ret) {              # выдать базовые формы слов в диапазоне {+n,+m} и записать их в file (только словарные базовые формы, без препинаний)
                ret = iwrd; for (k=n; k<=m; k++) {if(l[i+k]) ret = ret " " sanit(wordbf(k),"#","\x2f") }; print ret >> file }
function getBFx(n,m,file,   sw,kw, k,j, ret) {      # выдать базовые формы слов в диапазоне {n,m} и записать их в file, где n и m могут быть как "-" так и "+"
                sw=""; if(n<0 && m<0) sw=1; if(n>0 && m>0) sw=2; if(n<0 && m>0) sw=3;
                  switch (sw) {
                   case "1": for(j= m;j>=n;j--){if(l[i+j]){kw=sanit(wordbf(j),"#","\x2f");if(kw=="")kw=l[i+j];ret=kw  sep[i+j]   ret} else {break};};ret=ret iwrd sep[i]; break
                   case "2": for(k= n;k<=m;k++){if(l[i+j]){kw=sanit(wordbf(k),"#","\x2f");if(kw=="")kw=l[i+k];ret=ret sep[i+k-1] kw } else {break};};ret=iwrd ret sep[i+k]; break
                   case "3": for(j=-1;j>=n;j--){if(l[i+j]){kw=sanit(wordbf(j),"#","\x2f");if(kw=="")kw=l[i+j];ret=kw  sep[i+j]   ret} else {break};};ret=ret iwrd;
                             for(k= 1;k<=m;k++){if(l[i+k]){kw=sanit(wordbf(k),"#","\x2f");if(kw=="")kw=l[i+k];ret=ret sep[i+k-1] kw } else {break};};ret=ret sep[i+k]; break
                   default: ret=iwrd; break }; print ret >> file }
# функции обработки сепараторов
function p(n,sym,    pkt,el,ret) {                  # разделитель содержит препинания, кроме указанных wl?
                pkt="[…,.:;!?—]"; if (sym) { gsub(sym,"",pkt) }; el = pkt "|(<\\/?[pv]>)|(<\\/?subtitle>)";
                if ( ( sep[i+n] ~ el ) || ( i+n < 0 ) || ( i+n > nf ) ) {ret=1} else {ret=0}; return ret}
function s(n,m,sym,    pkt,el,k,sw,ret)  {          # разделители в диапазоне НЕ содержат препинаний? = пробел (не видит дефис), sym = разрешённые препинания
                pkt="[…,.:;!?—]"; if (m ~ pkt) {sym=m; m=n}; if (m==""||n==m) {sw=1} else {if (n<m) {sw=2};};
                if (sym) { gsub(sym,"",pkt) }; el = pkt "|(<\\/?[pv]>)|(<\\/?subtitle>)";
                switch (sw) {
                  case "1": if ( sep[i+n] ~ el ) {ret=0} else {ret=1}; break
                  case "2": for (k=n; k<=m; k++) { if ( sep[i+k] ~ el ) {ret=0; break} else {ret=1};}; break
                  default: ret=1; break}; return ret }
function sL(n,sym,    ret) {                         # 1-й символ строки-сепаратора равен sym (Leftmost)
                if( substr(sep[i+n],1,1) == sym ) {ret=1} else {ret=0}; return ret }
function sR(n,sym,    ret) {                         # последний символ строки-сепаратора равен sym (Rightmost)
                if( substr(sep[i+n],length(sep[i+n]),1) == sym ) {ret=1} else {ret=0}; return ret }
function z(n,    el, ret) {                         # разделитель содержит запятую ","
                el = sep[i+n]; if (el ~ /,/)    {ret=1} else {ret=0}; return ret }
function tz(n,    el, ret) {                         # разделитель содержит запятую ","
                el = sep[i+n]; if (el ~ /[,—]/)    {ret=1} else {ret=0}; return ret }
function zs(n,  el, ret) {                          # разделитель содержит [ ,—]
                if(s(n)||z(n)||se(n," — ")) {ret=1} else {ret=0}; return ret }
function ds(n,  el, ret) {                          # разделитеть содержит [ -]
                if(s(n)||se(n,"-")) {ret=1} else {ret=0}; return ret }
function ts(n,  el, ret) {                          # разделитель содержит [ —]
                if(s(n)||se(n," — ")) {ret=1} else {ret=0}; return ret }
function sc(n, sym,    el, ret) {                   # поиск символа в разделителе: "содержит"
                el = sep[i+n]; if (el ~ sym)    {ret=1} else {ret=0}; return ret }
function scw(n, sym,    el, ret) {                   # поиск символа/word в разделителе: "содержит"
                el = tolower(sep[i+n]); if (el ~ sym)  {ret=1} else {ret=0}; return ret }
function sv(n, sym,    el, ret) {                   # поиск символа в разделителе: "НЕ содержит"
                el = sep[i+n]; if (el !~ sym)    {ret=1} else {ret=0}; return ret }
function se(n, sym,    el, ret) {                   # разделитель "равен"
                el = sep[i+n]; if (el == sym)   {ret=1} else {ret=0}; return ret }
function sq(n, m, pu,   k, ret) {                   # ВСЕ разделители в диапазоне n-m содержат содержит sym
                for (k=n; k<=m; k++) { if (sep[i+k] ~ pu ) {ret=1} else {ret=0; break};}; return ret }
function sQ(n, m, pu,   k, ret) {                   # разделители в диапазоне НЕ содержат препинания pu
                for (k=n; k<=m; k++) { if (sep[i+k] ~ pu ) {ret=0; break} else {ret=1};}; return ret }
# функции обработки диапазона сепараторов
function qsf(n, m, sym,   k, stps, ret) {           # поиск ВПЕРЕД разделителя в диапазоне n-m, который содержит sym и выдать его адрес в sfn
                sfn=ret="";  stps="[….,:;!?—]"; gsub(sym,"",stps); for(k=n; k<=m; k++) { if(sep[i+k] !~ stps) {if(sep[i+k] ~ sym) {ret=1; sfn=k; break};}else{break};}; return ret }
function qsF(n, m, sym,   k, stps, ret) {           # поиск ВПЕРЕД разделителя в диапазоне n-m, который содержит sym и выдать его адрес в sfn
                sfn="";ret=1;stps="[….,:;!?—]"; gsub(sym,"",stps); for(k=n; k<=m; k++) { if(sep[i+k] !~ stps) {if(sep[i+k] ~ sym) {sfn=k; break};}else{ret="";break};}; return ret }
function qsb(n, m, sym,   k, ret) {                 # поиск НАЗАД разделителя в диапазоне n-m, который содержит sym и выдать его адрес в sbn
                sbn=ret="";  stps="[….,:;!?—]"; gsub(sym,"",stps); for(k=m; k>=n; k--) { if(sep[i+k] !~ stps) {if(sep[i+k] ~ sym) {ret=1; sbn=k; break};}else{break};}; return ret }
function qsB(n, m, sym,   k, ret) {                 # поиск НАЗАД разделителя в диапазоне n-m, который содержит sym и выдать его адрес в sbn
                sbn="";ret=1;stps="[….,:;!?—]"; gsub(sym,"",stps); for(k=m; k>=n; k--) { if(sep[i+k] !~ stps) {if(sep[i+k] ~ sym) {sbn=k; break};}else{ret="";break};}; return ret }
function sos(n, m,   stps,k,ret) {                  # найти адрес разделителя в начале текущего предложения, и выдать его адрес в son
                son=ret=""; stps="[….:;!?]"; for(k=m; k>=n; k--) { if(sep[i+k]~stps||sep[i+k]~/<[pv]>/||sep[i+k]=="") {ret=1; son=k; break};}; return ret }
function eos(n, m,   stps,k,ret) {                  # найти адрес разделителя в конце текущего предложения, и выдать его адрес в eon
                eon=ret=""; stps="[….:;!?]"; for(k=n; k<=m; k++) { if(sep[i+k]~stps||sep[i+k]~/<[pv]>/||sep[i+k]=="") {ret=1; eon=k; break};}; return ret }
function vv(n,m,    k, ret) {                       # выдать границы вводного предложения: , и —, n= первая запятая (vvpat задана в шапке основного скрипта)
                vvn=ret=""; if(sep[i+n]~vvpat && sep[i+n]!~/[….:;!?]/) {
		      for(k=++n;k<=m;k++) {if(sep[i+k] !~ "[….:;!?]") {if(sep[i+k]~vvpat) {ret=1;vvn=k;break};}else{break};};}; return ret}
function vvb(n,m,    k, ret) {                      # выдать границы вводного предложения: , и —, m= первая запятая
                vvn=ret=""; if(sep[i+m]~vvpat && sep[i+m]!~/[….:;!?]/) {
                      for(k=--m;k>=n;k--) {if(sep[i+k] !~ "[….:;!?]") {if(sep[i+k]~vvpat) {ret=1;vvn=k;break};}else{break};};}; return ret}
# функции обработки слов
function lc(n,   ret) {                             # перевести в нижний регистр и пастеризовать
                ret = gensub(unxy,"","g",tolower(l[i+n])); gsub(/ё/,"е",ret); return ret }
function cL(n,   ret) {                             # пастеризовать l[i]
                ret = gensub(unxy,"","g",l[i+n]); gsub(/Ё/,"Е",ret); gsub(/ё/,"е",ret); return ret }
function cLs(wl,   ret) {                           # Пастеризовать строку, регистр оставить как есть
                ret = gensub(unxy,"","g",wl); gsub(/Ё/,"Е",ret); gsub(/ё/,"е",ret); return ret }
function lcne(n,   ret) {                           # перевести в нижний регистр, отрезать начальное "не" и выдать результат
                ret = gensub(unxy,"","g",tolower(l[i+n])); gsub(/ё/,"е",ret); gsub(/^не/,"",ret); return ret }
function q_(n, array,    el, ret) {                 # слово в БАЗОВОМ массиве?
                if(lc(n) in array) {ret=1} else {ret=0}; return ret}
function qb_(n,m, array,    k, ret) {               # поиск на n шагов назад наличия слова в базовом массиве
                ret=qbn=""; if(n>m)n=m; for (k=m; k>=n; k--) { if ( lc(k) in array ) {ret=1; qbn=k; break}; }; return ret }
function qf_(n,m, array,    k, ret) {               # поиск на n шагов вперёд наличия слова в базовом массиве
                ret=qfn=""; if(n>m)m=n; for (k=n; k<=m; k++) { if ( lc(k) in array ) {ret=1; qfn=k; break}; }; return ret }
function q(n, alist,   afun,itmz,k,wd, ret) {                # обертка для нескольких функций
                ret=0; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd)) {ret=1; break} }; return ret}
function q_str(wd, alist,  n, afun,itmz,k, ret) {                # обертка для нескольких функций
                ret=n=0; split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd)) {ret=1; break} }; return ret}
function q_ist(n, alist,   afun,itmz,k,wd, ret) {                # обертка для нескольких функций
                ret=0; wd=tolower(l[i+n]); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd)) {ret=1; break} }; return ret}
function q_w(n, alist,    afun,itmz,k,wd, ret) {              # обертка для нескольких функций - нахождение + пробел до
                ret=0; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd) && s(n-1) && sv(n-1,"-") ) {ret=1; break} }; return ret}
function qw_(n, alist,    afun,itmz,k,wd, ret) {              # обертка для нескольких функций - нахождение + пробел после
                ret=0; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd) && s(n) && sv(n,"-") ) {ret=1; break} }; return ret}
function qy(n, alist,    afun,itmz,k,wd, ret) {               # обертка для нескольких функций "?", qyn=сдвиг
                qyn=0; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd)) {qyn=1; break} }; ret=1; return ret}
function Qist(n, alist,    afun,itmz,k,wd, ret) {             # обертка для нескольких функций
                ret=1; split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n)) {ret=0; break} }; return ret}
function Q(n, alist,    afun,itmz,k,wd, ret) {                # обертка для нескольких функций - НЕ нахождение
                ret=1; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd)) {ret=0; break}; }; return ret}
function Qw_(n, alist,    afun,itmz,k,wd, ret) {              # обертка для нескольких функций - НЕ нахождение + пробел после
                ret=1; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd) && s(n) && sv(n,"-") ) {ret=0; break} }; return ret}
function Q_w(n, alist,    afun,itmz,k,wd, ret) {              # обертка для нескольких функций - НЕ нахождение + пробел до
                ret=1; wd=lc(n); split(alist,itmz," "); for(k in itmz) { afun=itmz[k]; if(@afun(n,wd) && s(n-1) && sv(n-1,"-") ) {ret=0; break} }; return ret}
function id_(n, wl,   itmz,k, ret) {                     # связанное слово в позиции и с морфологической функцией wl
                stotar(wordbf(n),itmz,"#");ret=""; for(k in itmz) {if ( wl in omoids[iwrd][k] ) {ret=1;break}}; return ret }
function id(n, wl,    ret) {                        # связанное слово в позиции и с морфологической функцией wl
                if ( wl in omoid[iwrd][lc(n)] ) {ret=1} else {ret=0}; return ret }
function idf(n,m, wl,    k, ret) {                  # связанное слово в позиции и с морфологической функцией на n позиций вперёд
                ret=idn=""; if(n>m)m=n;rfix(n,m); for (k=n; k<=m; k++) { if ( wl in omoid[iwrd][lc(k)] ) {ret=1; idn=k; break}; }; return ret }
function idb(n,m, wl,    k, ret) {                  # связанное слово в позиции и с морфологической функцией на n позиций назад
                ret=idn=""; if(n>m)n=m;rfix(n,m); for (k=m; k>=n; k--) { if ( wl in omoid[iwrd][lc(k)] ) {ret=1; idn=k; break}; }; return ret }
function qm(n, isclass, wl,    ret) {               # обертка для нескольких функций и ba
                if ( q(n,isclass) && bam(n,wl) ) {ret=1} else {ret=0}; return ret}
function qq(n, m,    ret) {                         # слово m равно слово n?
                if ( lc(m) == lc(n) ) {ret=1} else {ret=0}; return ret}
function bqq(n, m,   k,itmz1,itmz2, ret) {          # базовая форма равна для m и n?
                stotar(wordbf(n),itmz1,"#");stotar(wordbf(m),itmz2,"#");for(k in itmz1){if(k in itmz2){ret=1;break}else{ret=0};}; return ret}
function qb(n,m, isclass,    k, ret) {              # поиск на n шагов назад наличия слова в классе
                ret=qbn=""; if(n>m)n=m;rfix(n,m); for (k=m; k>=n; k--) { if ( q(k,isclass) ) {ret=1; qbn=k; break}; }; return ret }
function qbv(n,m, isclass,wl,    k,itmz, ret) {  # поиск на n шагов назад наличия слова в классе
                ret=qbn=""; if(n>m)n=m;rfix(n,m);stotar(wl,itmz,"[ |]"); for(k=m; k>=n; k--) { if(!(lc(k) in itmz) && q(k,isclass)){ret=1; qbn=k; break};}; return ret }
function qb_ist(n,m, isclass,    k, ret) {              # поиск на n шагов назад наличия слова в классе
                ret=qbn=""; if(n>m)n=m; for (k=m; k>=n; k--) { if ( q_ist(k,isclass) ) {ret=1; qbn=k; break}; }; return ret }
function qB(n,m, isclass, notclass,    k, ret) {    # поиск на n шагов назад наличия слова в классе и отсутствия его же в другом классе
                ret=qbn=""; if(n>m)n=m; for (k=m; k>=n; k--) { if ( q(k,isclass) && Q(k,notclass) ) {ret=1; qbn=k; break}; }; return ret }
function seek(n,m, isclass, notclass,    k, ret) {  # поиск на n шагов наличия слова в классах и отсутствия слов в интервале в других классах, прервать, если найден notclass
                ret=skn="";                         # SLOW?
                if (n < 0){if(n>m)n=m;for(k=m;k>=n;k--){if( q(k,isclass )){ret=1; skn=k; break} else {if( q(k,notclass )&& k>=n &&k<m ){ret=0; break};};};}
                else      {if(n>m)m=n;for(k=n;k<=m;k++){if( q(k,isclass )){ret=1; skn=k; break} else {if( q(k,notclass) && k>=n &&k<m ){ret=0; break};};};}; return ret}
function qf(n,m, isclass,    k, ret) {              # поиск на n шагов вперёд наличия слова в классе
                ret=qfn=""; if(n>m)m=n;rfix(n,m); for (k=n; k<=m; k++) { if ( q(k,isclass) ) {ret=1; qfn=k; break}; }; return ret }
function qfv(n,m, isclass,wl,    k,itmz, ret) {      # поиск на n шагов вперёд наличия слова в классе
                ret=qfn=""; if(n>m)m=n;rfix(n,m);stotar(wl,itmz,"[ |]"); for(k=n; k<=m; k++){ if(!(lc(k) in itmz) && q(k,isclass)){ret=1; qfn=k; break};}; return ret }
function qfba(n,m, isclass, wl,    k, ret) {          # поиск на n шагов вперёд наличия слова в классе
                ret=nqf=""; if(n>m)m=n;rfix(n,m); for (k=n; k<=m; k++) { if ( q(k,isclass) && bam(k,wl) ) {ret=1; nqf=k; break}; }; return ret }
function qbba(n,m, isclass, wl,    k, ret) {              # поиск на n шагов назад наличия слова в классе
                ret=nqb=""; if(n>m)n=m;rfix(n,m); for (k=m; k>=n; k--) { if ( q(k,isclass) && bam(k,wl) ) {ret=1; nqb=k; break}; }; return ret }
function qir(n,m, isclass,    k, ret) {            # в промежутке ТОЛЬКО слова из класса или ничего, в заданном промежутке: при n>=m = true
                ret=1; for (k=n; k<=m; k++) { if ( Q(k,isclass) ) {ret=0; break}; }; return ret }
function qia(n,m, isclass1, isclass,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 1-й элемент только в начале: при n>=m = true
                ret=1; el=isclass " " isclass1; for(k=n+1;k<=m;k++) { if( Q(k,isclass) ) {ret=0; break};}; if(ret==1 && n<=m && Q(n,el) ) {ret=0}; return ret }
function qiz(n,m, isclass, isclass1,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 2-й элемент только в конце: при n>=m = true
                ret=1; el=isclass " " isclass1; for(k=n  ;k< m;k++) { if( Q(k,isclass) ) {ret=0; break};}; if(ret==1 && n<=m && Q(m,el) ) {ret=0}; return ret }
function wir(n,m, wl,    k, ret) {            # в промежутке ТОЛЬКО слова из списка или ничего, в заданном промежутке: при n>=m = true
                ret=1; for (k=n; k<=m; k++) { if ( W(k,wl) ) {ret=0; break}; }; return ret }
function wia(n,m, wl1, wl,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 1-й элемент только в начале: при n>=m = true
                ret=1; el=wl " " wl1; for(k=n+1;k<=m;k++) { if( W(k,wl) ) {ret=0; break};}; if(ret==1 && n<=m && W(n,el) ) {ret=0}; return ret }
function wiz(n,m, wl, wl1,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 2-й элемент только в конце: при n>=m = true
                ret=1; el=wl " " wl1; for(k=n  ;k< m;k++) { if( W(k,wl) ) {ret=0; break};}; if(ret==1 && n<=m && W(m,el) ) {ret=0}; return ret }
function wiq(n,m, wl, isclass,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 1-й элемент-СЛОВО только в начале: при n>=m = true
                ret=1; for(k=n+1;k<=m;k++) { if( Q(k,isclass) ) {ret=0; break};}; if(ret==1 && n<=m && W(n,wl) ) {ret=0}; return ret }
function qiw(n,m, isclass, wl,    el,k,ret) { # в промежутке ТОЛЬКО слова из класса или ничего, 2-й элемент-СЛОВО только в конце: при n>=m = true
                ret=1; for(k=n  ;k< m;k++) { if( Q(k,isclass) ) {ret=0; break};}; if(ret==1 && n<=m && W(m,wl) ) {ret=0}; return ret }
function qF(n,m, isclass, notclass,    k, ret) {    # поиск на n шагов вперёд наличия слова в классе и отсутсвия его же в другом классе
                ret=qfn="";rfix(n,m); for (k=n; k<=m; k++) { if ( q(k,isclass) && Q(k,notclass) ) {ret=1; qfn=k; break}; }; return ret }
function Qb(n,m, isclass,    k, ret) {              # поиск на n шагов назад отсутствия слова в классе
                ret=1;rfix(n,m); for (k=m; k>=n; k--)   { if ( q(k,isclass) && s(k,m) ) {ret=0; break}; }; return ret }
function Qf(n,m, isclass,    k, ret) {              # поиск на n шагов вперёд отсутствия слова в классе
                ret=1;rfix(n,m); for (k=n; k<=m; k++)   { if ( q(k,isclass) && s(n,k-1) ) {ret=0; break}; }; return ret }
function Qb_(n, array,    k, ret) {                 # поиск на n шагов назад отсутствия слова в БАЗОВОМ массиве
                ret=1; for (k=-1; k>=n; k--)   { if (lc(k) in array) {ret=0; break}; }; return ret }
function Qf_(n, array,    k, ret) {                 # поиск на n шагов вперёд отсутствия слова в БАЗОВОМ массиве
                ret=1; for (k= 1; k<=n; k++)   { if (lc(k) in array) {ret=0; break}; }; return ret }
function Q_(n, array,    ret) {                     # слово НЕ в БАЗОВОМ массиве?
                if (lc(n) in array) {ret=0} else {ret=1}; return ret }
function isname(n,    wd, el, en, es, ret) {            # Слово с Заглавной буквы?
                el = "^" RUUC_ rulc; en=gensub(unxyp,"","g",l[i+n]); es="^\\s+" LAUC_ lalc; if( (en ~ el) || (sep[i+n-1] ~ es) ) {ret=1} else {ret=0}; return ret }
function isacro(n,    wd, el, en, ret) {            # Слово - АКРОНИМ?
                el = "^" RUUC "$"; en=gensub(unxyp,"","g",l[i+n]); if ( en ~ el ) {ret=1} else {ret=0}; return ret }
function cap(n,    ret) {                           # Слово начинается с заглавной буквы?
                if ( substr(l[i+n],1,1) ~ RUUC ) {ret=1} else {ret=0}; return ret }
function w2x(n,wl,    w1,w2,j,k, ret) {                     # словосочетание из 2-х слов, т -->> из массива omarr[wl]?
               w1=lc(n); w2=lc(n+1); if (w1 in omarr[wl] && w2 in omarr[wl][w1]) {ret=1} else {ret=0}; return ret }
function w3x(n,wl,    w1,w2,w3,j,k, ret) {                  # словосочетание из 2-х слов, т -->> из массива omarr[wl]?
               w1=lc(n); w2=lc(n+1); w3=lc(n+2); if(w1 in omarr[wl] && w2 in omarr[wl][w1] && w3 in omarr[wl][w1][w2]) {ret=1} else {ret=0}; return ret }
function bw(n,wl,    itmz,wls,k, ret) {                      # имеет ли слово(n) базовую форму из списка wl из массивов BASE
                stotar(wl,wls," ");stotar(wordbf(n),itmz,"#");for(k in itmz){if(k in wls){ret=1;break}else{ret=0};}; return ret }
function mbba(n,m,wl,  w1,  itmz1,itmz2,k, ret) {               # match сочетание "базовой формы"(m) слова и "базовой формы"(n) из пары в массиве wl: b_b
               stotar(wordbf(n),itmz1,"#"); for(w1 in itmz1){if(w1 in omarr[wl]) {stotar(wordbf(m),itmz2,"#");
               for(k in itmz2){if(k in omarr[wl][w1]){ret=1;break}else{ret=0};};};}; return ret }
function mwba(n,m,wl,  itmz,w1,k, ret) {               # match сочетание частной формы(m) слова и "базовой формы"(n) из пары в массиве wl: w_b
               w1=lc(n); if (w1 in omarr[wl]) {stotar(wordbf(m),itmz,"#");for(k in itmz){if(k in omarr[wl][w1]){ret=1;break}else{ret=0};};}; return ret }
function mwwa(n,m,wl,  itmz,w1,k, ret) {               # match сочетание частной формы(m) слова и частной формы(n) из пары в массиве wl: w_w
               w1=lc(n); if (w1 in omarr[wl]) {stotar(lc(m),itmz,"#");for(k in itmz){if(k in omarr[wl][w1]){ret=1;break}else{ret=0};};}; return ret }
function bf(n,m,wl,   itmz,wls,j,k, ret) {                   # нахождение ВПЕРЁД базовых форм wl в диапазоне n-m из массивов BASE
               bfn=BFn=ret="";if(n>m)m=n;rfix(n,m);stotar(wl,wls," ");for(j=n;j<=m;j++){if(ret)break;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in wls){ret=1;bfn=j;BFn=k;break};};}; return ret }
function bf2(n,m,wl,   itmz,wls,j,k, ret) {                   # нахождение ВПЕРЁД базовых форм wl в диапазоне n-m из массивов BASE
               bfN=BFN=ret="";if(n>m)m=n;rfix(n,m);stotar(wl,wls," ");for(j=n;j<=m;j++){if(ret)break;;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in wls){ret=1;bfN=j;BFN=k;break};};}; return ret }
function bb(n,m,wl,   itmz,wls,j,k, ret) {                   # нахождение НАЗАД базовых форм wl в диапазоне n-m из массивов BASE
               bbn=BBn=ret="";if(n>m)n=m;rfix(n,m);stotar(wl,wls," ");for(j=m;j>=n;j--){if(ret)break;;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in wls){ret=1;bbn=j;BBn=k;break};};}; return ret }
function bb2(n,m,wl,   itmz,wls,j,k, ret) {                   # нахождение НАЗАД базовых форм wl в диапазоне n-m из массивов BASE
               bbN=BBN=ret="";if(n>m)n=m;rfix(n,m);stotar(wl,wls," ");for(j=m;j>=n;j--){if(ret)break;;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in wls){ret=1;bbN=j;BBN=k;break};};}; return ret }
function bam(n,wl,    itmz1,k, ret) {                     # принадлежность слова в n к одному из omarr массивов (wl = _идентификаторов_групп_слов) -- несколько функций ba
                split(wl,itmz1," ");for(k in itmz1){if(ba(n,itmz1[k]) ){ret=1;break}else{ret=0};}; return ret }
function ba(n,wl,     itmz,k, ret) {                     # имеет ли слово(n) базовую форму из массива omarr[wl] из массивов BASE
               ret="";stotar(wordbf(n),itmz,"#");for(k in itmz){if(k in omarr[wl]){ret=1;break};}; return ret }
function bfa(n,m,wl,   itmz,j,k, ret) {                  # нахождение ВПЕРЁД базовых форм из массива omarr[wl] в диапазоне n-m из массивов BASE
               bfn=BFn=ret="";if(n>m)m=n;rfix(n,m);for(j=n;j<=m;j++){if(ret)break;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in omarr[wl]){ret=1;bfn=j;BFn=k;break};};}; return ret }
function bfa2(n,m,wl,   itmz,j,k, ret) {             # нахождение ВПЕРЁД базовых форм из массива omarr[wl] в диапазоне n-m из массивов BASE
               bfN=BFN=ret="";if(n>m)m=n;rfix(n,m);for(j=n;j<=m;j++){if(ret)break;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in omarr[wl]){ret=1;bfN=j;BFN=k;break};};}; return ret }
function bba(n,m,wl,     itmz,k, ret) {              # нахождение НАЗАД базовых форм из массива omarr[wl] в диапазоне n-m -- только 1 строка-идентификатор! из массивов BASE
               bbn=BBn=ret="";if(n>m)n=m;rfix(n,m);for(j=m;j>=n;j--){if(ret)break;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in omarr[wl]){ret=1;bbn=j;BBn=k;break};};}; return ret }
function bba2(n,m,wl,    itmz,k, ret) {              # нахождение НАЗАД базовых форм из массива omarr[wl] в диапазоне n-m = bba - для возможности использовать 2 раза
               bbN=BBN=ret="";if(n>m)n=m;rfix(n,m);for(j=m;j>=n;j--){if(ret)break;stotar(wordbf(j),itmz,"#");
               for(k in itmz){if(k in omarr[wl]){ret=1;bbN=j;BBN=k;break};};}; return ret }
function bsca(n,m,wl,     itmz,k, ret) {             # нахождение НАЗАД базовых форм из массива omarr[wl] в диапазоне n-m -- только 1 строка-идентификатор! из массивов BASE
               delete bscan[wl];rfix(n,m);for(j=m;j>=n;j--){stotar(wordbf(j),itmz,"#");for(k in itmz){if(k in omarr[wl]){ret=1;bscan[wl][k]=j};};}; return ret }
function fsca(n,m,wl,   itmz,j,k, ret) {             # нахождение ВПЕРЁД базовых форм из массива omarr[wl] в диапазоне n-m из массивов BASE
               delete fscan[wl];rfix(n,m);for(j=n;j<=m;j++){stotar(wordbf(j),itmz,"#");for(k in itmz){if(k in omarr[wl]){ret=1;fscan[wl][k]=j};};}; return ret }
function Xw(n,wl,           ret) {                   # слово(n) содержится в массиве исключений omarr[wl]: выдать 0
               if(lc(n) in omarr[wl]) {ret=0} else {ret=1}; return ret }
function xw(n,wl,           ret) {                   # слово(n) содержится в массиве исключений omarr[wl]: выдать 1
               if(lc(n) in omarr[wl]) {ret=1} else {ret=0}; return ret }
function digits(n, ret) {                   # нахождение в списке? = "одно из слов"
                if (l[i+n] ~ /[0-9]+$/) {ret=1} else {ret=0}; return ret }
function roman(n, ret) {                   # нахождение в списке? = "одно из слов"
                if (sep[i+n] ~ /[IVXLMC]+/) {ret=1} else {ret=0}; return ret }
function w(n, wl,    itmz, ret) {                   # нахождение в списке? = "одно из слов"
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz) {ret=1} else {ret=0}; return ret }
function weq(var, wl,   vc,itmz1,itmz2,k, ret) {     # нахождение значения переменной var в списке wl
                vc=stotar(var,itmz1,"#"); stotar(wl,itmz2,"[ |]"); if (vc==1) { if (var in itmz2) {ret=1} else {ret=0} } else
                { for (k in itmz1) { if (k in itmz2) {ret=1;break} else {ret=0} } }; return ret }
function vwq(var1,var2,var3, wl,    ret) {           # обёртка для veq + weq
                if ( veq(var1,var2) && weq(var3,wl) ) { ret=1 } else { ret=0 }; return ret }
function wy(n, wl,    itmz, ret) {                   # слово? = "1 или 0", wyn=сдвиг
                wyn="";stotar(wl, itmz, "[ |]"); if (lc(n) in itmz) {wyn=1}; ret=1; return ret }
function hwy(n, wl,    itmz, ret) {                  # -слово? = "1 или 0", hyn=сдвиг
                hyn="";stotar(wl, itmz, "[ |]"); if (lc(n) in itmz && sep[i+n-1]=="-") {hyn=1}; ret=1; return ret }
function wa(n, wl,    ret) {                        # нахождение в списке? = "одно из слов", но список в массиве omarr[wl] из массивов FLAT
                if (lc(n) in omarr[wl]) {ret=1} else {ret=0}; return ret }
function ww_(n, wl,    itmz, ret) {                 # нахождение в списке? + пробел после слова
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz && s(n)  ) {ret=1} else {ret=0}; return ret }
function w_w(n, wl,    itmz, ret) {                 # НЕнахождение в списке? + пробел перед словом
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz && s(n-1)) {ret=1} else {ret=0}; return ret }
function wist(n, wl,    itmz, ret) {                # нахождение в списке? = "одно из слов" ist = слово со всеми правками
                stotar(wl, itmz, "[ |]"); if (tolower(l[i+n]) in itmz) {ret=1} else {ret=0}; return ret }
function gist(n, m,    wd, istomo,  ret) {          # омограф текщей группы в позиции n обработан ранее и является формой 1, 2, или 3 = m, (со всеми правками)
                istomo=tolower(l[i+n]); wd=oms[xgrp][xclass[xgrp][m]][lc(n)]; if(wd == istomo) {ret=1}; return ret }
function wc(n, wl,    itmz, k, lk, ret) {           # нахождение части слова в списке? = "один из набора"
                lk=split(wl, itmz, "[ |]"); for (k=1; k<=lk; k++) { if (lc(n)~itmz[k]) {ret=1; break} else {ret=0};}; return ret }
function jme(n, p1, p2,    itmz1, itmz2, jwordz, jword, k, j, ret) {   # нахождение части слова в списке из "серединки" и окончания слова
                lk1=split(p1, itmz1, "[ |]");lk2=split(p2, itmz2, "[ |]"); for (k in itmz1) { for (j in itmz2) {jword=itmz1[k] itmz2[j] "$"; jwordz[jword]};}; 
                  for(k in jwordz){ if (lc(n) ~ k) {ret=1;break} else {ret=0};}; return ret }
function wme(n, p1, p2,    itmz1, itmz2, jwordz, jword, k, j, ret) {   # нахождение части слова в списке из "начала" и окончания слова
                lk1=split(p1, itmz1, "[ |]");lk2=split(p2, itmz2, "[ |]"); for (k in itmz1) { for (j in itmz2) {jword="^" itmz1[k] itmz2[j] "$"; jwordz[jword]};}; 
                  for(k in jwordz){ if (lc(n) ~ k) {ret=1;break} else {ret=0};}; return ret }
function wma(n, p1, p2,    itmz2, jwordz, jword, k, j, ret) {   # нахождение части слова в списке из "начала" и окончания слова
                lk2=split(p2, itmz2, "[ |]"); for (k in omarr[p1]) { for (j in itmz2) {jword="^" k itmz2[j] "$"; jwordz[jword]};}; 
                  for(k in jwordz){ if (lc(n) ~ k) {ret=1;break} else {ret=0};}; return ret }
function Wc(n, wl,    itmz, k, lk, ret) {           # НЕнахождение части слова в списке? = "один из набора"
                lk=split(wl, itmz, "[ |]"); for (k=1; k<=lk; k++) { if (lc(n)~itmz[k]) {ret=0; break} else {ret=1};}; return ret }
function W(n, wl,    itmz, ret) {                   # НЕнахождение в списке? != "одно из слов"
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz) {ret=0} else {ret=1}; return ret }
function Ww_(n, wl,    itmz, ret) {                 # НЕнахождение в списке? != "одно из слов"
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz && s(n)  ) {ret=0} else {ret=1}; return ret }
function W_w(n, wl,    itmz, ret) {                 # НЕнахождение в списке? != "одно из слов"
                stotar(wl, itmz, "[ |]"); if (lc(n) in itmz && s(n-1)) {ret=0} else {ret=1}; return ret }
function wb(n,m, wl,    itmz,wd,k, ret) {             # поиск на n шагов назад слова из списка
                ret=wbn=WBn=""; if(n>m)n=m;rfix(n,m); stotar(wl, itmz, "[ |]"); for (k=m; k>=n; k--) {wd=lc(k); if(wd in itmz) {ret=1;wbn=k;WBn=wd;break};}; return ret }
function wb2(n,m, wl,    itmz,wd,k, ret) {            # поиск на n шагов назад слова из списка (если wb уже задействована)
                ret=wbN=WBN=""; if(n>m)n=m;rfix(n,m); stotar(wl, itmz, "[ |]"); for (k=m; k>=n; k--) {wd=lc(k); if(wd in itmz) {ret=1;wbN=k;WBN=wd;break};}; return ret }
function wba(n,m, wl,    k,wd, ret) {                  # поиск на n шагов назад слова из списка, но список в массиве omarr[wl] FLAT
                ret=wbn=WBn=""; if(n>m)n=m; for (k=m; k>=n; k--) {wd=lc(k); if(wd in omarr[wl]) {ret=1; wbn=k; WBn=wd; break};}; return ret }
function wb_raw(n,m, wl,    itmz, k, ret) {         # поиск на n шагов назад НЕОЧИЩЕННОГО слова из списка
                ret=wbn=""; if(n>m)n=m;rfix(n,m); stotar(wl, itmz, "[ |]"); for (k=m; k>=n; k--) { if (tolower(l[i+k]) in itmz) {ret=1; wbn=k; break};}; return ret }
function wf(n,m, wl,    itmz,wd,k, ret) {             # поиск на n шагов вперёд наличия слова в массиве
                ret=wfn=WFn=""; if(n>m)m=n;rfix(n,m); stotar(wl, itmz, "[ |]"); for (k=n; k<=m; k++) {wd=lc(k); if(wd in itmz) {ret=1;wfn=k;WFn=wd;break};}; return ret }
function wf2(n,m, wl,    itmz,wd,k, ret) {             # поиск на n шагов вперёд наличия слова в массиве
                ret=wfN=WFN=""; if(n>m)m=n;rfix(n,m); stotar(wl, itmz, "[ |]"); for (k=n; k<=m; k++) {wd=lc(k); if(wd in itmz) {ret=1;wfN=k;WFN=wd;break};}; return ret }
function wfa(n,m, wl,    k,wd, ret) {                  # поиск на n шагов вперёд наличия слова из массивов FLAT
                ret=wfn=WFn=""; if(n>m)m=n;rfix(n,m); for (k=n; k<=m; k++) {wd=lc(k); if (wd in omarr[wl]) {ret=1; wfn=k; WFn=wd; break};}; return ret }
function exf(n, wl,    itmz, wls, k, lk, ret) {   # точная фраза как строка от адреса вправо, последний разделитель НЕ проверяется
                xfn="";ret=1;lk=patsplit(wl,itmz,patword,wls);for(k=1;k<lk;k++){if(!(gensub(unxy,"","g",l[i+k+n-1])==itmz[k]&&gensub(unxy,"","g",sep[i+k+n-1])==wls[k]))
                {ret=0;break};}; if(ret && gensub(unxy,"","g",l[i+lk+n-1])==itmz[lk] ){xfn=n+lk-1} else {ret=0}; return ret}
function exF(n, wl,    itmz, wls, k, lk, ret) {   # точная фраза как строка от адреса вправо, последний разделитель ПРОВЕРЯЕТСЯ
                xfn="";ret=1;lk=patsplit(wl,itmz,patword,wls);for(k=1;k<=lk;k++){if(!(gensub(unxy,"","g",l[i+k+n-1])==itmz[k]&&gensub(unxy,"","g",sep[i+k+n-1])==wls[k]))
                {ret=0;break};}; if(ret) {xfn=n+lk-1}; return ret}
function exb(n, wl,    itmz, wls, k, lk, ret) {   # точная фраза как строка от адреса влево, последний разделитель НЕ проверяется
                xbn="";ret=1;lk=patsplit(wl,itmz,patword,wls);for(k=1;k<lk;k++){if(!(gensub(unxy,"","g",l[i+k-lk+n])==itmz[k]&&gensub(unxy,"","g",sep[i+k-lk+n])==wls[k]))
                {ret=0;break};}; if(ret && gensub( unxy,"","g",l[i+n])==itmz[lk] ){ret=1; xbn=n-lk+1}; return ret}
function exB(n, wl,    itmz, wls, k, lk, ret) {   # точная фраза как строка от адреса влево, последний разделитель ПРОВЕРЯЕТСЯ
                xbn="";ret=1;lk=patsplit(wl,itmz,patword,wls);for(k=lk;k>=1;k--){if(!(gensub(unxy,"","g",l[i+k-lk+n])==itmz[k]&&gensub(unxy,"","g",sep[i+k-lk+n])==wls[k]))
                {ret=0;break};}; if(ret) {xbn=n-lk+1}; return ret}
function phs(n, wl,    itmz, k, lk, cnt, ret) {     # фраза как пастеризованная строка от адреса влево, проверка пробелов отдельно!
                hsn="";lk=split(wl,itmz," "); for(k=1;k<=lk;k++) {if(lc(k+n-lk)==itmz[k]) {cnt++} else {cnt=0; break};};
                  if(cnt==lk) {ret=1; hsn=n-lk} else {ret=0}; return ret}
function phf(n, wl,    itmz, k, lk, cnt, ret) {     # фраза как пастеризованная строка от адреса вправо, проверка пробелов отдельно!
                hfn="";lk=split(wl,itmz," "); for(k=1;k<=lk;k++) {if(lc(n+k-1)==itmz[k]) {cnt++} else {cnt=0; break};};
                  if(cnt==lk) {ret=1;hfn=n+lk} else {ret=0}; return ret}
function wmark(mrk,wl,    itmz,k,el,vmrk, ret) {       # УСТАРЕЛО! нахождение в подстроке #xxx (mrk) метки wl -- метка основного слова (winfo)
                vmrk= "^" mrk;el="_" wl "_";split(winfo,itmz,"#"); for(k in itmz){if(itmz[k]~vmrk&&itmz[k]~el){ret=1;break}else{ret=0};}; return ret }
function ismark(n,mrk,    itmz,k,el,vmrk, ret) {       # нахождение СЛОВА в метке основного слова winfo, начинающейся с mrk (переменная winfo): для управления омонимами из automo.gz
                el="_" tolower(l[i+n]) "_";vmrk= "^" mrk;split(winfo,itmz,"#");for(k in itmz){if(itmz[k]~vmrk&&itmz[k]~el){ret=1;break}else{ret=0};}; return ret }
function notmark(n,mrk,    itmz,k,el,vmrk, ret) {      # НЕ нахождение СЛОВА в метке, начинающейся с mrk (переменная winfo): для управления омонимами из automo.gz
                el="_" tolower(l[i+n]) "_";vmrk= "^" mrk;split(winfo,itmz,"#");for(k in itmz){if(itmz[k]~vmrk&&itmz[k]~el){ret=0;break}else{ret=1};}; return ret }
function notsym(n,sym,    ret) {                    # НЕ нахождение подстроки sym в слове
                if (l[i+n] !~ sym) {ret=1} else {ret=0}; return ret }
function qxs(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret) { # фраза от адреса <_<_<_._>_>_>, составленная из 1-5 переменных элементов, проверка пробелов, xsn=адрес слова с другой стороны
                if(a0) a_=1; if(b0) b_=1; if(c0) c_=1; if(d0) d_=1; if(e0) e_=1; sw=a_+b_+c_+d_+e_; xsn=""
                  if (n < 0) { switch (sw) {
                      case "1": if( s(n      ) && w(n  ,a0)                                                     ) {xsn=n       ;ret=1} else {ret=0}; break
                      case "2": if( s(n-1,n  ) && w(n-1,a0) && w(n  ,b0)                                        ) {xsn=n-(sw-1);ret=1} else {ret=0}; break
                      case "3": if( s(n-2,n  ) && w(n-2,a0) && w(n-1,b0) && w(n  ,c0)                           ) {xsn=n-(sw-1);ret=1} else {ret=0}; break
                      case "4": if( s(n-3,n  ) && w(n-3,a0) && w(n-2,b0) && w(n-1,c0) && w(n  ,d0)              ) {xsn=n-(sw-1);ret=1} else {ret=0}; break
                      case "5": if( s(n-4,n  ) && w(n-4,a0) && w(n-3,b0) && w(n-2,c0) && w(n-1,d0) && w(n  ,e0) ) {xsn=n-(sw-1);ret=1} else {ret=0}; break
                      default: ret=xsn=""; break }
                  } else { switch (sw) {
                      case "1": if( s(n-1    ) && w(n  ,a0)                                                     ) {xsn=n+(sw-1);ret=1} else {ret=0}; break
                      case "2": if( s(n-1,n  ) && w(n  ,a0) && w(n+1,b0)                                        ) {xsn=n+(sw-1);ret=1} else {ret=0}; break
                      case "3": if( s(n-1,n+1) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0)                           ) {xsn=n+(sw-1);ret=1} else {ret=0}; break
                      case "4": if( s(n-1,n+2) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0)              ) {xsn=n+(sw-1);ret=1} else {ret=0}; break
                      case "5": if( s(n-1,n+3) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0) && w(n+4,e0) ) {xsn=n+(sw-1);ret=1} else {ret=0}; break
                      default: ret=xsn=""; break };}; return ret}
function qxw(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret) { # фраза от адреса <_<_<.>_>_>, составленная из 1-5 переменных элементов, проверка пробелов, xsn=адрес первого слова
                if(a0) a_=1; if(b0) b_=1; if(c0) c_=1; if(d0) d_=1; if(e0) e_=1; sw=a_+b_+c_+d_+e_; xsn=""
                  if (n < 0) { switch (sw) {
                      case "1": if(               w(n  ,a0)                                                     ) {xwn=n       ;ret=1} else {ret=0}; break
                      case "2": if( s(n-1    ) && w(n-1,a0) && w(n  ,b0)                                        ) {xwn=n-(sw-1);ret=1} else {ret=0}; break
                      case "3": if( s(n-2,n-1) && w(n-2,a0) && w(n-1,b0) && w(n  ,c0)                           ) {xwn=n-(sw-1);ret=1} else {ret=0}; break
                      case "4": if( s(n-3,n-1) && w(n-3,a0) && w(n-2,b0) && w(n-1,c0) && w(n  ,d0)              ) {xwn=n-(sw-1);ret=1} else {ret=0}; break
                      case "5": if( s(n-4,n-1) && w(n-4,a0) && w(n-3,b0) && w(n-2,c0) && w(n-1,d0) && w(n  ,e0) ) {xwn=n-(sw-1);ret=1} else {ret=0}; break
                      default: ret=xwn=""; break }
                  } else { switch (sw) {
                      case "1": if( s(n      ) && w(n  ,a0)                                                     ) {xwn=n+(sw-1);ret=1} else {ret=0}; break
                      case "2": if( s(n  ,n  ) && w(n  ,a0) && w(n+1,b0)                                        ) {xwn=n+(sw-1);ret=1} else {ret=0}; break
                      case "3": if( s(n  ,n+1) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0)                           ) {xwn=n+(sw-1);ret=1} else {ret=0}; break
                      case "4": if( s(n  ,n+2) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0)              ) {xwn=n+(sw-1);ret=1} else {ret=0}; break
                      case "5": if( s(n  ,n+3) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0) && w(n+4,e0) ) {xwn=n+(sw-1);ret=1} else {ret=0}; break
                      default: ret=xwn=""; break };}; return ret}
function qaw(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret) { # фраза от адреса .>_>_>, составленная из 1-5 переменных элементов, пр
                if(a0) a_=1; if(b0) b_=1; if(c0) c_=1; if(d0) d_=1; if(e0) e_=1; sw=a_+b_+c_+d_+e_; awn=""
                      switch (sw) {
                      case "1": if(               w(n  ,a0)                                                     ) {awn=n+(sw-1);ret=1} else {ret=0}; break
                      case "2": if( s(n      ) && w(n  ,a0) && w(n+1,b0)                                        ) {awn=n+(sw-1);ret=1} else {ret=0}; break
                      case "3": if( s(n  ,n+1) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0)                           ) {awn=n+(sw-1);ret=1} else {ret=0}; break
                      case "4": if( s(n  ,n+2) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0)              ) {awn=n+(sw-1);ret=1} else {ret=0}; break
                      case "5": if( s(n  ,n+3) && w(n  ,a0) && w(n+1,b0) && w(n+2,c0) && w(n+3,d0) && w(n+4,e0) ) {awn=n+(sw-1);ret=1} else {ret=0}; break
                      default: ret=awn=""; break }; return ret}
function qxd(n,a0,b0,c0,      a_,b_,c_,sw,ret) { # фраза от адреса <-<-<.>->->, составленная из 1-5 переменных элементов, проверка дефисов, xdn=адрес первого слова
                if(a0) a_=1; if(b0) b_=1; if(c0) c_=1; sw=a_+b_+c_; xdn=""
                  if (n < 0) { switch (sw) {
                      case "2": if( se(n-1,"-") &&  w(n-1,a0 ) && w(n  ,b0)                                     ) {xdn=n-(sw-1);ret=1} else {ret=0}; break
                      case "3": if( se(n-2,"-") && se(n-1,"-") && w(n-2,a0) && w(n-1,b0) && w(n  ,c0)           ) {xdn=n-(sw-1);ret=1} else {ret=0}; break
                      default: ret=xdn=""; break }
                  } else { switch (sw) {
                      case "2": if( se(n  ,"-") &&  w(n  ,a0 ) && w(n+1,b0)                                     ) {xdn=n+(sw-1);ret=1} else {ret=0}; break
                      case "3": if( se(n  ,"-") && se(n+1,"-") && w(n  ,a0) && w(n+1,b0) && w(n+2,c0)           ) {xdn=n+(sw-1);ret=1} else {ret=0}; break
                      default: ret=xdn=""; break };}; return ret}

function rodeq_sw_pl(n,m,      sw,ret) { # определить род сущевительного по адресу n, сравнить его с родом прилагательного или местоимения по адресу m
                if(suw_mu(n)) sw=1; if(suw_ze(n)) sw=2; if(suw_sr(n)) sw=3; if(suw_mn(n)) sw=4;
                  switch (sw) {
                      case "1": if( prl_mu(m)||muk_mu(m)                                                       ) {rdn="mu";ret=1} else {ret=0}; break
                      case "2": if( prl_ze(m)||muk_ze(m)                                                       ) {rdn="ze";ret=1} else {ret=0}; break
                      case "3": if( prl_sr(m)||muk_sr(m)                                                       ) {rdn="sr";ret=1} else {ret=0}; break
                      case "4": if( prl_mn(m)||muk_mn(m)                                                       ) {rdn="mn";ret=1} else {ret=0}; break
                      default: ret=rdn=""; break }; return ret}

function caseq_sw_sw(n,m,      sw,ret) { # определить падеж сущевительного по адресу n, сравнить его с родом существительного по адресу m
                if(suw_im(n)) sw=1; if(suw_ro(n)) sw=2; if(suw_vi(n)) sw=3; if(suw_da(n)) sw=4; if(suw_tv(n)) sw=5; if(suw_pr(n)) sw=6;
                  switch (sw) {
                      case "1": if( suw_im(m)                                                                  ) {csn="im";ret=1} else {ret=0}; break
                      case "2": if( suw_ro(m)                                                                  ) {csn="ro";ret=1} else {ret=0}; break
                      case "3": if( suw_vi(m)                                                                  ) {csn="vi";ret=1} else {ret=0}; break
                      case "4": if( suw_da(m)                                                                  ) {csn="da";ret=1} else {ret=0}; break
                      case "5": if( suw_tv(m)                                                                  ) {csn="tv";ret=1} else {ret=0}; break
                      case "6": if( suw_pr(m)                                                                  ) {csn="pr";ret=1} else {ret=0}; break
                      default: ret=csn=""; break }; return ret}

# логические функции проверки переменных -- для лучшей читаемости. Только, если переменная не равна "" (0)
function v2s(var,         ret) { if (typeof(var)=="untyped") {ret=""} else {ret=var}; return ret } # если переменная не инициализирована, создать ее перед проверкой (для > 5.2)
function vge(var,  val,   ret) { if (v2s(var) >= val)                  {ret=1} else {ret=0};  return ret } # переменная больше или равна
function vle(var,  val,   ret) { if (v2s(var) <= val)                  {ret=1} else {ret=0};  return ret } # переменная меньше или равна
function vgt(var,  val,   ret) { if (v2s(var) >  val)                  {ret=1} else {ret=0};  return ret } # переменная больше чем
function vlt(var,  val,   ret) { if (v2s(var) <  val)                  {ret=1} else {ret=0};  return ret } # переменная меньше чем
function veq(var,  val,   ret) { if (v2s(var) == val)                  {ret=1} else {ret=0};  return ret } # переменная равна значению
function vgl(var,v1,v2,   ret) { if (v2s(var) >= v1 && v2s(var) <= v2) {ret=1} else {ret=0};  return ret } # переменная в диапазоне, включительно
function vxt(var,v1,v2,   ret) { if (v2s(var) >  v1 && v2s(var) <  v2) {ret=1} else {ret=0};  return ret } # переменная в диапазоне, не включительно
function vex(var,         ret) { if (v2s(var))                         {ret=1} else {ret=0};  return ret } # переменная существует и не равна 0
function vem(var,   artmp,ret) { split(var,artmp," "); for (k in artmp) {if ( v2s(artmp[k]) )  {ret=1;break} else {ret=0}}; return ret } # как vex, но для нескольких переменных
function v2v(v1,v2,       ret) { yvn=""; if ( v1 ) {ret=1;yvn=v1} else { if ( v2 ) {ret=1;yvn=v2} else {ret=0} }; return ret } # yvn = первой из ненулевых переменных


# функции проверки принадлежности к классам. "Классы" собираются из "базовых массивов", которые формируются при чтении словаря посредством classes.awk
# география
function geo_sr(n,        wd,ret) { wd = lc(n);        if (wd in geo_edsrim)                                                                    {ret=1} else {ret=0}; return ret}
function geo_mn(n,        wd,ret) { wd = lc(n);        if (wd in geo_mnim)                                                                      {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# модальные слова                                                                                                                               
function mod_bz(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in md_bz)                                                                           {ret=1} else {ret=0}; return ret}
function mod_ed(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in md_ed)                                                                           {ret=1} else {ret=0}; return ret}
function mod_mn(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in md_mn)                                                                           {ret=1} else {ret=0}; return ret}
function mod_dp(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in md_dp)                                                                           {ret=1} else {ret=0}; return ret}
function mod_any(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in md_bz||wd in md_ed||wd in md_mn||wd in md_dp)                                    {ret=1} else {ret=0}; return ret}

# вспомогательные глаголы                                                                                                                               
function gl_aux_be(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gla_be)                                                                          {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# указательные местоимения                                                                                                                      
function muk_edmuim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuim)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzeim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzeim)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrim)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edmuvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuvi)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzevi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzevi)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrvi)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edmuda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuda)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzeda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzeda)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrda)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edmuro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuro)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzero(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzero)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrro)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edmutv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmutv)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzetv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzetv)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrtv)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edmupr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmupr)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edzepr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edzepr)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edsrpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edsrpr)                                                                      {ret=1} else {ret=0}; return ret}
function muk_edim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuim||wd in muc_edzeim||wd in muc_edsrim)                                  {ret=1} else {ret=0}; return ret}
function muk_edvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuvi||wd in muc_edzevi||wd in muc_edsrvi)                                  {ret=1} else {ret=0}; return ret}
function muk_edda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuda||wd in muc_edzeda||wd in muc_edsrda)                                  {ret=1} else {ret=0}; return ret}
function muk_edro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuro||wd in muc_edzero||wd in muc_edsrro)                                  {ret=1} else {ret=0}; return ret}
function muk_edtv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmutv||wd in muc_edzetv||wd in muc_edsrtv)                                  {ret=1} else {ret=0}; return ret}
function muk_edpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmupr||wd in muc_edzepr||wd in muc_edsrpr)                                  {ret=1} else {ret=0}; return ret}
function muk_mnim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mnim)                                                                        {ret=1} else {ret=0}; return ret}
function muk_mnvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mnvi)                                                                        {ret=1} else {ret=0}; return ret}
function muk_mnda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mnda)                                                                        {ret=1} else {ret=0}; return ret}
function muk_mnro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mnro)                                                                        {ret=1} else {ret=0}; return ret}
function muk_mntv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mntv)                                                                        {ret=1} else {ret=0}; return ret}
function muk_mnpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in muc_mnpr)                                                                        {ret=1} else {ret=0}; return ret}
function muk_im(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuim||wd in muc_edzeim||wd in muc_edsrim||wd in muc_mnim)                  {ret=1} else {ret=0}; return ret}
function muk_vi(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuvi||wd in muc_edzevi||wd in muc_edsrvi||wd in muc_mnvi)                  {ret=1} else {ret=0}; return ret}
function muk_da(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuda||wd in muc_edzeda||wd in muc_edsrda||wd in muc_mnda)                  {ret=1} else {ret=0}; return ret}
function muk_ro(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmuro||wd in muc_edzero||wd in muc_edsrro||wd in muc_mnro)                  {ret=1} else {ret=0}; return ret}
function muk_tv(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmutv||wd in muc_edzetv||wd in muc_edsrtv||wd in muc_mntv)                  {ret=1} else {ret=0}; return ret}
function muk_pr(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in muc_edmupr||wd in muc_edzepr||wd in muc_edsrpr||wd in muc_mnpr)                  {ret=1} else {ret=0}; return ret}
function muk_ed(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in muc_edmuim||wd in muc_edzeim||wd in muc_edsrim||wd in muc_edmuvi||wd in muc_edzevi||wd in muc_edsrvi||          
                          wd in muc_edmuda||wd in muc_edzeda||wd in muc_edsrda||wd in muc_edmuro||wd in muc_edzero||wd in muc_edsrro||          
                          wd in muc_edmutv||wd in muc_edzetv||wd in muc_edsrtv||wd in muc_edmupr||wd in muc_edzepr||wd in muc_edsrpr)           {ret=1} else {ret=0}; return ret}
function muk_mu(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in muc_edmuim||wd in muc_edmuvi||wd in muc_edmuda||wd in muc_edmuro||wd in muc_edmutv||wd in muc_edmupr)           {ret=1} else {ret=0}; return ret}
function muk_ze(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in muc_edzeim||wd in muc_edzevi||wd in muc_edzeda||wd in muc_edzero||wd in muc_edzetv||wd in muc_edzepr)           {ret=1} else {ret=0}; return ret}
function muk_sr(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in muc_edsrim||wd in muc_edsrvi||wd in muc_edsrda||wd in muc_edsrro||wd in muc_edsrtv||wd in muc_edsrpr)           {ret=1} else {ret=0}; return ret}
function muk_mn(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in muc_mnim||wd in muc_mnvi||wd in muc_mnda||wd in muc_mnro||wd in muc_mntv||wd in muc_mnpr)                       {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# кастомные местоимения                                                                                                                         
function mest_it(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in mst_it && sep[i+n-1]!="-")                                                       {ret=1} else {ret=0}; return ret}
function mest_pedmuim(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edmuim && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedmuro(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edmuro && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedmuda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edmuda && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedmutv(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edmutv && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedmupr(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edmupr && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedsrim(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edsrim && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedzeim(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edzeim && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedzevi(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edzevi && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedzeda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edzero && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pedzero(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_edzero && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pmnim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_mnim   && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pmnro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_mnro   && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pmnda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_mnda   && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pmntv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_mntv   && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
function mest_pmnpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_mnpr   && sep[i+n-1]!="-")                                                  {ret=1} else {ret=0}; return ret}
                                                                                                                                                
function mest_3e(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_3e)                                                                         {ret=1} else {ret=0}; return ret}
function mest_vip3e(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_vip3e)                                                                      {ret=1} else {ret=0}; return ret}
function mest_impe(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mstc_impe)                                                                       {ret=1} else {ret=0}; return ret}

# местоимения в функции определения существительного
function mcop_edmuim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_mu_im||wd in msto_ed_im||wd in msto_im)                                  {ret=1} else {ret=0}; return ret}
function mcop_edmuvi(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_vi||wd in msto_ed_mu_im||wd in msto_ed_mu_ro||wd in msto_mn_ro||wd in msto_ed_vi||wd in msto_vi)     {ret=1} else {ret=0}; return ret}
function mcop_edmuro(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_mu_ro||wd in msto_ed_ro||wd in msto_ro)                                  {ret=1} else {ret=0}; return ret}
function mcop_edmuda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_mu_da||wd in msto_ed_da||wd in msto_da)                                  {ret=1} else {ret=0}; return ret}
function mcop_edmutv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_mu_tv||wd in msto_ed_tv||wd in msto_tv)                                  {ret=1} else {ret=0}; return ret}
function mcop_edmupr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_mu_pr||wd in msto_ed_pr||wd in msto_pr)                                  {ret=1} else {ret=0}; return ret}
function mcop_edsrim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_im||wd in msto_ed_sr)                                                 {ret=1} else {ret=0}; return ret}
function mcop_edsrvi(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_im||wd in msto_ed_sr_vi||wd in msto_ed_sr_ro||wd in msto_ed_sr)       {ret=1} else {ret=0}; return ret}
function mcop_edsrro(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_ro||wd in msto_ed_ro||wd in msto_ro)                                  {ret=1} else {ret=0}; return ret}
function mcop_edsrda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_da||wd in msto_ed_da||wd in msto_da)                                  {ret=1} else {ret=0}; return ret}
function mcop_edsrtv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_tv||wd in msto_ed_tv||wd in msto_tv)                                  {ret=1} else {ret=0}; return ret}
function mcop_edsrpr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_sr_pr||wd in msto_ed_pr||wd in msto_pr)                                  {ret=1} else {ret=0}; return ret}
function mcop_edzeim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_im)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edzevi(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_vi)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edzero(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_ro)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edzeda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_da)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edzetv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_tv)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edzepr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in msto_ed_ze_pr)                                                                   {ret=1} else {ret=0}; return ret}
function mcop_edmu(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu||wd in msto_ed_mu_da||wd in msto_ed_mu_im||wd in msto_ed_mu_pr||wd in msto_ed_mu_ro||
                          wd in msto_ed_mu_tv||wd in msto_ed_mu_vi)                                                                             {ret=1} else {ret=0}; return ret}
function mcop_edze(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_ze_vi||wd in msto_ed_ze_da||wd in msto_ed_ze_im||wd in msto_ed_ze_pr||wd in msto_ed_ze_ro||
                          wd in msto_ed_ze_tv||wd in msto_ed_ze)                                                                                {ret=1} else {ret=0}; return ret}
function mcop_edsr(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_sr_vi||wd in msto_ed_sr_da||wd in msto_ed_sr_im||wd in msto_ed_sr_pr||wd in msto_ed_sr_ro||
                          wd in msto_ed_sr_tv||wd in msto_ed_sr)                                                                                {ret=1} else {ret=0}; return ret}
function mcop_edim(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_im||wd in msto_ed_ze_im||wd in msto_ed_sr_im||wd in msto_ed_im||wd in msto_im)                       {ret=1} else {ret=0}; return ret}
function mcop_edvi(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_vi||wd in msto_ed_sr_vi||wd in msto_ed_vi||wd in msto_ed_ze_vi||wd in msto_vi)                       {ret=1} else {ret=0}; return ret}
function mcop_im(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_im||wd in msto_ed_ze_im||wd in msto_ed_sr_im||wd in msto_mn_im||wd in msto_ed_mu||wd in msto_ed_ze||
                          wd in msto_ed_im||wd in msto_im||wd in mstc_3e)                                                                       {ret=1} else {ret=0}; return ret}
function mcop_vi(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_vi||wd in msto_ed_mu_im||wd in msto_ed_mu_ro||wd in msto_ed_ze_vi||wd in msto_ed_sr_vi||
                          wd in msto_mn_im||wd in msto_mn_ro||wd in msto_mn_vi||wd in msto_ed_vi||wd in msto_vi)                                {ret=1} else {ret=0}; return ret}
function mcop_ro(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_ro||wd in msto_ed_ze_ro||wd in msto_ed_sr_ro||wd in msto_mn_ro||wd in msto_ed_ro||wd in msto_ro)     {ret=1} else {ret=0}; return ret}
function mcop_da(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_da||wd in msto_ed_ze_da||wd in msto_ed_sr_da||wd in msto_mn_da||wd in msto_ed_da||wd in msto_da||
                          wd in mstc_3e)                                                                                                        {ret=1} else {ret=0}; return ret}
function mcop_tv(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_tv||wd in msto_ed_ze_tv||wd in msto_ed_sr_tv||wd in msto_mn_tv||wd in msto_ed_tv||wd in msto_tv||
                          wd in mstc_3e)                                                                                                        {ret=1} else {ret=0}; return ret}
function mcop_pr(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_pr||wd in msto_ed_ze_pr||wd in msto_ed_sr_pr||wd in msto_mn_pr||wd in msto_ed_pr||wd in msto_pr)     {ret=1} else {ret=0}; return ret}
function mcop_edro(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in msto_ed_mu_ro||wd in msto_ed_sr_ro||wd in msto_ed_ze_ro||wd in msto_ed_ro||wd in msto_ro)                       {ret=1} else {ret=0}; return ret}
function mcop_mnim(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_im)                                                                      {ret=1} else {ret=0}; return ret}
function mcop_mnvi(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_im||wd in msto_mn_ro||wd in msto_mn_vi)                                  {ret=1} else {ret=0}; return ret}
function mcop_mnro(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_ro)                                                                      {ret=1} else {ret=0}; return ret}
function mcop_mnda(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_da)                                                                      {ret=1} else {ret=0}; return ret}
function mcop_mntv(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_tv)                                                                      {ret=1} else {ret=0}; return ret}
function mcop_mnpr(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in msto_mn_pr)                                                                      {ret=1} else {ret=0}; return ret}

function mcop_any(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mstc_3e||wd in msto_da||wd in msto_ed_da||wd in msto_ed_im||wd in msto_ed_mu||wd in msto_ed_mu_da||
                          wd in msto_ed_mu_im||wd in msto_ed_mu_pr||wd in msto_ed_mu_ro||wd in msto_ed_mu_tv||wd in msto_ed_mu_vi||
                          wd in msto_ed_pr||wd in msto_ed_ro||wd in msto_ed_sr_da||wd in msto_ed_sr_im||wd in msto_ed_sr_pr||
                          wd in msto_ed_sr_ro||wd in msto_ed_sr_tv||wd in msto_ed_sr_vi||wd in msto_ed_tv||wd in msto_ed_vi||
                          wd in msto_ed_ze_da||wd in msto_ed_ze_im||wd in msto_ed_ze_pr||wd in msto_ed_ze_ro||wd in msto_ed_ze_tv||
                          wd in msto_ed_ze_vi||wd in msto_ed_ze||wd in msto_im||wd in msto_mn_da||wd in msto_mn_im||wd in msto_mn_pr||
                          wd in msto_mn_ro||wd in msto_mn_tv||wd in msto_mn_vi||wd in msto_pr||wd in msto_ro||wd in msto_tv||wd in msto_vi)    {ret=1} else {ret=0}; return ret}
                                                                                                                                                

# относительные прилагательные/местоимения в роли союза
function otsz_edmuim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuim)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzeim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzeim)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrim)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edmuvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuvi)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzevi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzevi)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrvi)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edmuda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuda)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzeda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzeda)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrda)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edmuro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuro)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzero(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzero)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrro)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edmutv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmutv)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzetv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzetv)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrtv)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edmupr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmupr)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edzepr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edzepr)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edsrpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edsrpr)                                                                    {ret=1} else {ret=0}; return ret}
function otsz_edim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuim||wd in otm_edzeim||wd in otm_edsrim)                                {ret=1} else {ret=0}; return ret}
function otsz_edvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuvi||wd in otm_edzevi||wd in otm_edsrvi)                                {ret=1} else {ret=0}; return ret}
function otsz_edda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuda||wd in otm_edzeda||wd in otm_edsrda)                                {ret=1} else {ret=0}; return ret}
function otsz_edro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuro||wd in otm_edzero||wd in otm_edsrro)                                {ret=1} else {ret=0}; return ret}
function otsz_edtv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmutv||wd in otm_edzetv||wd in otm_edsrtv)                                {ret=1} else {ret=0}; return ret}
function otsz_edpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmupr||wd in otm_edzepr||wd in otm_edsrpr)                                {ret=1} else {ret=0}; return ret}
function otsz_mnim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mnim)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_mnvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mnvi)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_mnda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mnda)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_mnro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mnro)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_mntv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mntv)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_mnpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in otm_mnpr)                                                                      {ret=1} else {ret=0}; return ret}
function otsz_im(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuim||wd in otm_edzeim||wd in otm_edsrim||wd in otm_mnim)                {ret=1} else {ret=0}; return ret}
function otsz_vi(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuvi||wd in otm_edzevi||wd in otm_edsrvi||wd in otm_mnvi)                {ret=1} else {ret=0}; return ret}
function otsz_da(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuda||wd in otm_edzeda||wd in otm_edsrda||wd in otm_mnda)                {ret=1} else {ret=0}; return ret}
function otsz_ro(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmuro||wd in otm_edzero||wd in otm_edsrro||wd in otm_mnro)                {ret=1} else {ret=0}; return ret}
function otsz_tv(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmutv||wd in otm_edzetv||wd in otm_edsrtv||wd in otm_mntv)                {ret=1} else {ret=0}; return ret}
function otsz_pr(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in otm_edmupr||wd in otm_edzepr||wd in otm_edsrpr||wd in otm_mnpr)                {ret=1} else {ret=0}; return ret}
function otsz_ed(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in otm_edmuim||wd in otm_edzeim||wd in otm_edsrim||wd in otm_edmuvi||wd in otm_edzevi||wd in otm_edsrvi||          
                          wd in otm_edmuda||wd in otm_edzeda||wd in otm_edsrda||wd in otm_edmuro||wd in otm_edzero||wd in otm_edsrro||          
                          wd in otm_edmutv||wd in otm_edzetv||wd in otm_edsrtv||wd in otm_edmupr||wd in otm_edzepr||wd in otm_edsrpr)          {ret=1} else {ret=0}; return ret}
function otsz_mn(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in otm_mnim||wd in otm_mnvi||wd in otm_mnda||wd in otm_mnro||wd in otm_mntv||wd in otm_mnpr)                      {ret=1} else {ret=0}; return ret}
function otsz_any(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in otm_edmuim||wd in otm_edzeim||wd in otm_edsrim||wd in otm_edmuvi||wd in otm_edzevi||wd in otm_edsrvi||          
                          wd in otm_edmuda||wd in otm_edzeda||wd in otm_edsrda||wd in otm_edmuro||wd in otm_edzero||wd in otm_edsrro||          
                          wd in otm_edmutv||wd in otm_edzetv||wd in otm_edsrtv||wd in otm_edmupr||wd in otm_edzepr||wd in otm_edsrpr||
                          wd in otm_mnim||wd in otm_mnvi||wd in otm_mnda||wd in otm_mnro||wd in otm_mntv||wd in otm_mnpr)                      {ret=1} else {ret=0}; return ret}
function otsz_mu(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in otm_edmuim||wd in otm_edmuvi||wd in otm_edmuda||wd in otm_edmuro||wd in otm_edmutv||wd in otm_edmupr||          
                          wd in otm_mnim||wd in otm_mnvi||wd in otm_mnda||wd in otm_mnro||wd in otm_mntv||wd in otm_mnpr)                      {ret=1} else {ret=0}; return ret}

# двойственное число
function qi_duom(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in qd_duom)                                                                        {ret=1} else {ret=0}; return ret}
function qi_duoz(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in qd_duoz)                                                                        {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# кастомные предлоги                                                                                                                            
# возможен однин падеж                                                                                                                          
function prex_im(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_im)                                                                       {ret=1} else {ret=0}; return ret}
function prex_vi(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_vi)                                                                       {ret=1} else {ret=0}; return ret}
function prex_ro(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_ro)                                                                       {ret=1} else {ret=0}; return ret}
function prex_da(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_da)                                                                       {ret=1} else {ret=0}; return ret}
function prex_tv(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_tv)                                                                       {ret=1} else {ret=0}; return ret}
function prex_pr(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in predc_pr)                                                                       {ret=1} else {ret=0}; return ret}
# возможны несколько падежей                                                                                                                   
function prem_imvipr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in predc_imvipr)                                                                   {ret=1} else {ret=0}; return ret}
function prem_vipr(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in predc_vipr)                                                                     {ret=1} else {ret=0}; return ret}
function prem_vitv(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in predc_vitv)                                                                     {ret=1} else {ret=0}; return ret}
function prem_rotv(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in predc_rotv)                                                                     {ret=1} else {ret=0}; return ret}
function prem_virotv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in predc_virotv)                                                                   {ret=1} else {ret=0}; return ret}
function prem_vidapr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in predc_vidapr)                                                                   {ret=1} else {ret=0}; return ret}
                                                                                                                                               
# предлоги квази-предлоги из нескольких слов                                                                                                   
function preph_vi(n,                                                                                                                           ret) {
                     if ( qxw(n,"без","оглядки согласия","на")||                                                                               
                          qxw(n,"в","обмен ответ расчете","на")||                                                                              
                          qxw(n,"глядя невзирая несмотря","на")||                                                                              
                          qxw(n,"в","порядок") )                                                                                               {ret=1} else {ret=0}; return ret}
function preph_da(n,                                                                                                                           ret) {
                     if ( qxw(n,"в","дополнение направлении приложение приложении применении","к ко") ||
                          qxw(n,"в","память","о об") ||
                          qxw(n,"в","замену противность противовес противоположность тон угоду ущерб") ||
                          qxw(n,"боком вдобавок вплотную вплоть лицом плюс применительно","к ко") ||
                          qxw(n,"вдоль вниз вверх глядя смотря судя","по") ||
                          qxw(n,"на","пути путях","к ко") ||
                          qxw(n,"на","радость пользу смену") ||
                          qxw(n,"не","в","пример") ||
                          qxw(n,"по","направлению отношению","к ко")||
                          qxw(n,"под","стать"))                                                                                                {ret=1} else {ret=0}; return ret}
function preph_ro(n,                                                                                                                           ret) {
                     if ( qxw(n,"без","согласования","с со") ||
                          qxw(n,"без","ведома помощи согласия указания") ||
                          qxw(n,"в","близи далеке дали зависимости отдалении отличие отрыве стороне сторону шаге","от") ||
                          qxw(n,"в","авангард авангарде адрес аспекте видах виде возрасте границах глазах глубине глубь гуще деле довершение доказательство должности духе завершение заключение зачёт зачет защиту знак ипостаси истории исходе интересах качестве количестве компании конец конце круге кругу курс курсе лице меру мире направлении нарушение начале области область обстановке обход ознаменование ожидании окружении основе отношении отмену отсутствие память плане поисках пользу порядке предвидении предвкушении преддверии преддверье пределах пределы присутствии продолжение процессе разгар разрезе размере районе рамках рамки распоряжение распоряжении середине рассуждении расцвете результате роли русле ряде ряду свете силу случае смысле сопровождении составе стенах сторону сумме сфере счет течение торце условиях форме форму формулировке центр центре характере ходе целях части честь честь числе число") ||
                          qxw(n,"вне","зависимости","от") ||
                          qxw(n,"вне","границ пределов рамок сферы") ||
                          qxw(n,"во","вкусе власти времена время главе здравие избежание изменение имя исполнение славу спасение") ||
                          qxw(n,"вплоть впредь задолго незадолго что","до") ||
                          qxw(n,"до","выяснения глубины завершения истечения конца наступления начала прихода окончания середины") ||
                          qxw(n,"за","вычетом границами границы исключением неимением пределами пределы счет место") ||
                          qxw(n,"из","расчета среды числа") ||
                          qxw(n,"именем имени конец конца конце концу начало начала начале началу середина середине середину несть") ||
                          qxw(n,"исходя","из") ||
                          qxw(n,"к","довершению завершению исходу концу краю началу окончанию помощи прибытию приезду приходу расцвету середине чести числу") ||
                          qxw(n,"ко","времени") ||
                          qxw(n,"на","глазах виду совести","у") ||
                          qxw(n,"на","переднем","крае") ||
                          qxw(n,"на","базе берег берегу бок боку благо вершине волне вопрос время высоте глазах грани дне имя заре краю манер месте начало ниве окраине опушке основании основе поверхности порог пороге потребу почве правах предмет примере произвол протяжении пути путях случай склон склоне склонах совести срок стороне сторону страже стыке счету тему углу уровне фоне") ||
                          qxw(n,"над","краем уровнем") ||
                          qxw(n,"вблизи вдалеке вдали влево вправо наискосок наискось налево направо начиная невдалеке недалеко независимо неподалеку поблизости поодаль прочь сбоку сверху слева снизу справа","от") ||
                          qxw(n,"начиная","с со") ||
                          qxw(n,"не","без до доходя считая") ||
                          qxw(n,"перед","концом лицом началом") ||
                          qxw(n,"по","адресу бокам вине вопросам вопросу выражению долгу истечении линии мановению мере милости миновани имнению направлению наущению неимению поводу поручению праву примеру принципу причине прошествии пути образу окончании сведениям склону случаю стопам сути уполномочию части ходу") ||
                          qxw(n,"по","образу","и","подобию") ||
                          qxw(n,"под","видом гнётом гнетом знаком знамёна знамена знамёнами знаменами знаменем знамя командованием личиной маркой названием началом номером покровом предлогом председательством сенью стенами тон тяжестью углом эгидой") ||
                          qxw(n,"при","помощи посредстве указании условии") ||
                          qxw(n,"от","имени рук руки лица") ||
                          qxw(n,"с","ведома внешностью лишением момента подачи помощью начала началом наступлением прибытием приходом отделением учетом уходом целью") ||
                          qxw(n,"с","лёгкой легкой","руки") ||
                          qxw(n,"сквозь","призму") ||
                          qxw(n,"со","знанием слов стороны") ||
                          qxw(n,"через","посредство призму") )                                                                                 {ret=1} else {ret=0}; return ret}
function preph_tv(n,                                                                                                                           ret) {
                     if ( qxw(n,"в","ногу компании мире вровень связи связи согласии сообществе соответствии сопоставлении сравнении унисон уровень","с со") ||
                          qxw(n,"в","бытность") ||
                          qxw(n,"вкупе одновременно","с со") ||
                          qxw(n,"во","главе","с со") ||
                          qxw(n,"вслед следом","за") ||
                          qxw(n,"по","аналогии согласованию сравнению","с со") ||
                          qxw(n,"о","бок","с со") ||
                          qxw(n,"вдогонку вслед далеко следом","за") ||
                          qxw(n,"вместе наравне наряду рядом совместно совокупно согласно сообразно сообща соответственно соразмерно сравнительно","с со") )
                                                                                                                                               {ret=1} else {ret=0}; return ret}
function preph_any(n,   ret) { if ( preph_vi(n)||preph_da(n)||preph_ro(n)||preph_tv(n) )                                                       {ret=1} else {ret=0}; return ret }
                                                                                                                                                
# прилагательные                                                                                                                                
function prl_kred_mu(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in pl_kred_mu)                                                                      {ret=1} else {ret=0}; return ret}
function prl_kred_ze(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in pl_kred_ze)                                                                      {ret=1} else {ret=0}; return ret}
function prl_kred_sr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in pl_kred_sr)                                                                      {ret=1} else {ret=0}; return ret}
function prl_kred(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_kred_mu||wd in pl_kred_ze||wd in pl_kred_sr)                                  {ret=1} else {ret=0}; return ret}
function prl_krmn(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_krmn)                                                                         {ret=1} else {ret=0}; return ret}
function prl_srav(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_srv)                                                                          {ret=1} else {ret=0}; return ret}
function prl_neiz(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_neiz)                                                                         {ret=1} else {ret=0}; return ret}
function prl_affix(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in pl_affix)                                                                        {ret=1} else {ret=0}; return ret}
function prl_edmuim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_im||wd in pl_pv_edmu_im)                                                 {ret=1} else {ret=0}; return ret}
function prl_edmuvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_im||wd in pl_pv_edmu_im||wd in pl_edmu_ro||wd in pl_pv_edmu_ro)          {ret=1} else {ret=0}; return ret}
function prl_edmuro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_ro||wd in pl_pv_edmu_ro)                                                 {ret=1} else {ret=0}; return ret}
function prl_edmuda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_da||wd in pl_pv_edmu_da)                                                 {ret=1} else {ret=0}; return ret}
function prl_edmutv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_tv||wd in pl_pv_edmu_tv)                                                 {ret=1} else {ret=0}; return ret}
function prl_edmupr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edmu_pr||wd in pl_pv_edmu_pr)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_im||wd in pl_pv_edsr_im)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_im||wd in pl_pv_edsr_im)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_ro||wd in pl_pv_edsr_ro)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_da||wd in pl_pv_edsr_da)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_tv||wd in pl_pv_edsr_tv)                                                 {ret=1} else {ret=0}; return ret}
function prl_edsrpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edsr_pr||wd in pl_pv_edsr_pr)                                                 {ret=1} else {ret=0}; return ret}
function prl_edzeim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_im||wd in pl_pv_edze_im)                                                 {ret=1} else {ret=0}; return ret}
function prl_edzevi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_vi||wd in pl_pv_edze_vi)                                                 {ret=1} else {ret=0}; return ret}
function prl_edzero(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_dr||wd in pl_pv_edze_dr)                                                 {ret=1} else {ret=0}; return ret}
function prl_edzeda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_dr||wd in pl_pv_edze_dr)                                                 {ret=1} else {ret=0}; return ret}
function prl_edzetv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_tv||wd in pl_pv_edze_tv||wd in pl_edze_dr||wd in pl_pv_edze_dr)          {ret=1} else {ret=0}; return ret}
function prl_edzepr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_edze_dr||wd in pl_pv_edze_dr)                                                 {ret=1} else {ret=0}; return ret}
function prl_edim(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edsr_im||wd in pl_edze_im||wd in pl_pv_edmu_im||wd in pl_pv_edsr_im||wd in pl_pv_edze_im)  {ret=1} else {ret=0}; return ret}
function prl_edvi(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edmu_ro||wd in pl_edsr_im||wd in pl_edze_vi||wd in pl_pv_edmu_im||wd in pl_pv_edmu_ro||    
                          wd in pl_pv_edsr_im||wd in pl_pv_edze_vi)                                                                             {ret=1} else {ret=0}; return ret}
function prl_edro(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_ro||wd in pl_edsr_ro||wd in pl_edze_dr||wd in pl_pv_edmu_ro||wd in pl_pv_edsr_ro||wd in pl_pv_edze_dr)  {ret=1} else {ret=0}; return ret}
function prl_edda(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_da||wd in pl_edsr_da||wd in pl_edze_dr||wd in pl_pv_edmu_da||wd in pl_pv_edsr_da||wd in pl_pv_edze_dr)  {ret=1} else {ret=0}; return ret}
function prl_edtv(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_tv||wd in pl_edsr_tv||wd in pl_edze_tv||wd in pl_edze_dr||wd in pl_pv_edmu_tv||wd in pl_pv_edsr_tv||    
                          wd in pl_pv_edze_tv||wd in pl_pv_edze_dr)                                                                             {ret=1} else {ret=0}; return ret}
function prl_edpr(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_pr||wd in pl_edsr_pr||wd in pl_edze_dr||wd in pl_pv_edmu_pr||wd in pl_pv_edsr_pr||wd in pl_pv_edze_dr)  {ret=1} else {ret=0}; return ret}
function prl_mnim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_im||wd in pl_pv_mn_im)                                                     {ret=1} else {ret=0}; return ret}
function prl_mnvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_im||wd in pl_mn_ro||wd in pl_pv_mn_im||wd in pl_pv_mn_ro)                  {ret=1} else {ret=0}; return ret}
function prl_mnro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_ro||wd in pl_pv_mn_ro)                                                     {ret=1} else {ret=0}; return ret}
function prl_mnda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_da||wd in pl_pv_mn_da)                                                     {ret=1} else {ret=0}; return ret}
function prl_mntv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_tv||wd in pl_pv_mn_tv)                                                     {ret=1} else {ret=0}; return ret}
function prl_mnpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pl_mn_ro||wd in pl_pv_mn_pr)                                                     {ret=1} else {ret=0}; return ret}
function prl_pvedtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_pv_edmu_tv||wd in pl_pv_edsr_tv||wd in pl_pv_edze_tv)                         {ret=1} else {ret=0}; return ret}
function prl_pvmntv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in pl_pv_mn_tv)                                                                     {ret=1} else {ret=0}; return ret}
function prl_im(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edsr_im||wd in pl_edze_im||wd in pl_pv_edmu_im||wd in pl_pv_edsr_im||wd in pl_pv_edze_im||
                          wd in pl_mn_im||wd in pl_pv_mn_im)                                                                                    {ret=1} else {ret=0}; return ret}
function prl_vi(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edmu_ro||wd in pl_edsr_im||wd in pl_edze_vi||wd in pl_pv_edmu_im||wd in pl_pv_edmu_ro||
                          wd in pl_pv_edsr_im||wd in pl_pv_edze_vi||wd in pl_mn_im||wd in pl_mn_ro||wd in pl_pv_mn_im||wd in pl_pv_mn_ro)       {ret=1} else {ret=0}; return ret}
function prl_ro(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_ro||wd in pl_edsr_ro||wd in pl_edze_dr||wd in pl_pv_edmu_ro||wd in pl_pv_edsr_ro||wd in pl_pv_edze_dr||
                          wd in pl_mn_ro||wd in pl_pv_mn_ro)                                                                                    {ret=1} else {ret=0}; return ret}
function prl_da(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_da||wd in pl_edsr_da||wd in pl_edze_dr||wd in pl_pv_edmu_da||wd in pl_pv_edsr_da||wd in pl_pv_edze_dr||
                          wd in pl_mn_da||wd in pl_pv_mn_da)                                                                                    {ret=1} else {ret=0}; return ret}
function prl_tv(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_tv||wd in pl_edsr_tv||wd in pl_edze_tv||wd in pl_edze_dr||wd in pl_pv_edmu_tv||wd in pl_pv_edsr_tv||
                          wd in pl_pv_edze_tv||wd in pl_pv_edze_dr||wd in pl_mn_tv||wd in pl_pv_mn_tv)                                          {ret=1} else {ret=0}; return ret}
function prl_pr(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_pr||wd in pl_edsr_pr||wd in pl_edze_dr||wd in pl_pv_edmu_pr||wd in pl_pv_edsr_pr||wd in pl_pv_edze_dr||
                          wd in pl_mn_ro||wd in pl_pv_mn_pr)                                                                                    {ret=1} else {ret=0}; return ret}
function prl_ed(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edsr_im||wd in pl_edze_im||wd in pl_pv_edmu_im||wd in pl_pv_edsr_im||wd in pl_edmu_da||
                          wd in pl_edze_vi||wd in pl_pv_edze_vi||wd in pl_edmu_ro||wd in pl_pv_edmu_ro|| wd in pl_edsr_ro||wd in pl_edze_dr||
                          wd in pl_pv_edsr_ro||wd in pl_pv_edze_dr||wd in pl_edsr_da||wd in pl_pv_edmu_da||wd in pl_pv_edze_im||
                          wd in pl_pv_edsr_da||wd in pl_edmu_tv||wd in pl_edsr_tv||wd in pl_edze_tv||wd in pl_pv_edmu_tv||wd in pl_edmu_pr||
                          wd in pl_pv_edsr_tv||wd in pl_pv_edze_tv||wd in pl_edsr_pr||wd in pl_pv_edmu_pr||wd in pl_pv_edsr_pr)                 {ret=1} else {ret=0}; return ret}
function prl_edmu(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_pv_edmu_im||wd in pl_edmu_da||wd in pl_edmu_ro||wd in pl_pv_edmu_ro||wd in pl_pv_edmu_da||
                          wd in pl_edmu_tv||wd in pl_pv_edmu_tv||wd in pl_edmu_pr||wd in pl_pv_edmu_pr)                                         {ret=1} else {ret=0}; return ret}
function prl_edze(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edze_im||wd in pl_edze_vi||wd in pl_pv_edze_vi||wd in pl_edze_dr||wd in pl_pv_edze_dr||wd in pl_pv_edze_im||
                          wd in pl_edze_tv||wd in pl_pv_edze_tv)                                                                                {ret=1} else {ret=0}; return ret}
function prl_edsr(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edsr_im||wd in pl_pv_edsr_im||wd in pl_edsr_ro||wd in pl_pv_edsr_ro||wd in pl_edsr_da||wd in pl_pv_edsr_da||
                          wd in pl_edsr_tv||wd in pl_pv_edsr_tv||wd in pl_edsr_pr||wd in pl_pv_edsr_pr)                                         {ret=1} else {ret=0}; return ret}
function prl_mu(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_pv_edmu_im||wd in pl_edmu_da||wd in pl_edmu_ro||wd in pl_pv_edmu_ro||wd in pl_pv_edmu_da||
                          wd in pl_edmu_tv||wd in pl_pv_edmu_tv||wd in pl_edmu_pr||wd in pl_pv_edmu_pr||wd in pl_pv_edmu_tv)                    {ret=1} else {ret=0}; return ret}
function prl_ze(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edze_im||wd in pl_edze_vi||wd in pl_pv_edze_vi||wd in pl_edze_dr||wd in pl_pv_edze_dr||
                          wd in pl_pv_edze_im||wd in pl_edze_tv||wd in pl_pv_edze_tv)                                                           {ret=1} else {ret=0}; return ret}
function prl_sr(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edsr_im||wd in pl_pv_edsr_im||wd in pl_edsr_ro||wd in pl_pv_edsr_ro||wd in pl_edsr_da||wd in pl_pv_edsr_da||
                          wd in pl_edsr_tv||wd in pl_pv_edsr_tv||wd in pl_edsr_pr||wd in pl_pv_edsr_pr)                                         {ret=1} else {ret=0}; return ret}
function prl_mn(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_mn_im||wd in pl_pv_mn_im||wd in pl_mn_ro||wd in pl_pv_mn_ro||wd in pl_mn_da||wd in pl_pv_mn_da||
                          wd in pl_mn_tv||wd in pl_pv_mn_tv||wd in pl_pv_mn_pr)                                                                 {ret=1} else {ret=0}; return ret}
function prl_pv_any(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_pv_edmu_im||wd in pl_pv_edsr_im||wd in pl_pv_edze_vi||wd in pl_pv_edmu_ro||wd in pl_pv_edsr_ro||
                          wd in pl_pv_edze_dr||wd in pl_pv_edmu_da||wd in pl_pv_edze_im||wd in pl_pv_edsr_da||wd in pl_pv_edmu_tv||
                          wd in pl_pv_edsr_tv||wd in pl_pv_edze_tv||wd in pl_pv_edmu_pr||wd in pl_pv_edsr_pr||wd in pl_pv_mn_im||
                          wd in pl_pv_mn_ro||wd in pl_pv_mn_da||wd in pl_pv_mn_tv||wd in pl_pv_mn_pr||wd in pl_pv_edmu_tv)                      {ret=1} else {ret=0}; return ret}
function prl_any(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pl_edmu_im||wd in pl_edsr_im||wd in pl_edze_im||wd in pl_pv_edmu_im||wd in pl_pv_edsr_im||wd in pl_edmu_da||
                          wd in pl_edze_vi||wd in pl_pv_edze_vi||wd in pl_edmu_ro||wd in pl_pv_edmu_ro|| wd in pl_edsr_ro||wd in pl_edze_dr||
                          wd in pl_pv_edsr_ro||wd in pl_pv_edze_dr||wd in pl_edsr_da||wd in pl_pv_edmu_da||wd in pl_pv_edze_im||
                          wd in pl_pv_edsr_da||wd in pl_edmu_tv||wd in pl_edsr_tv||wd in pl_edze_tv||wd in pl_pv_edmu_tv||wd in pl_edmu_pr||
                          wd in pl_pv_edsr_tv||wd in pl_pv_edze_tv||wd in pl_edsr_pr||wd in pl_pv_edmu_pr||wd in pl_pv_edsr_pr||
                          wd in pl_mn_im||wd in pl_pv_mn_im||wd in pl_mn_ro||wd in pl_pv_mn_ro||wd in pl_mn_da||wd in pl_pv_mn_da||
                          wd in pl_mn_tv||wd in pl_pv_mn_tv||wd in pl_pv_mn_pr||wd in pl_pv_edmu_tv)                                            {ret=1} else {ret=0}; return ret}

# причастия
function prq_kred_mu(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_mu||wd in pq2_pa_kred_mu||wd in pqn_na_kred_mu||wd in pqn_pa_kred_mu||wd in pqs_pa_kred_mu)         {ret=1} else {ret=0}; return ret}
function prq_kred_ze(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_ze||wd in pq2_pa_kred_ze||wd in pqn_na_kred_ze||wd in pqn_pa_kred_ze||wd in pqs_pa_kred_ze)         {ret=1} else {ret=0}; return ret}
function prq_kred_sr(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_sr||wd in pq2_pa_kred_sr||wd in pqn_na_kred_sr||wd in pqn_pa_kred_sr||wd in pqs_pa_kred_sr)         {ret=1} else {ret=0}; return ret}
function prq_kred(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_mu||wd in pq2_pa_kred_mu||wd in pqn_na_kred_mu||wd in pqn_pa_kred_mu||wd in pqs_pa_kred_mu||        
                          wd in pq2_na_kred_ze||wd in pq2_pa_kred_ze||wd in pqn_na_kred_ze||wd in pqn_pa_kred_ze||wd in pqs_pa_kred_ze||        
                          wd in pq2_na_kred_sr||wd in pq2_pa_kred_sr||wd in pqn_na_kred_sr||wd in pqn_pa_kred_sr||wd in pqs_pa_kred_sr)         {ret=1} else {ret=0}; return ret}
function prq_krmn(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_krmn||wd in pq2_pa_krmn||wd in pqn_na_krmn||wd in pqn_pa_krmn||wd in pqs_pa_krmn)                        {ret=1} else {ret=0}; return ret}
function prq_edmuim(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edsrim(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||wd in pq2_ne_na_ed_sr_im||wd in pq2_ne_pa_ed_sr_im||
                          wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_im||
                          wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||wd in pqn_ne_vz_na_ed_sr_im||wd in pqn_ne_vz_pa_ed_sr_im||
                          wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||wd in pqn_pe_na_ed_sr_im||wd in pqn_pe_pa_ed_sr_im||
                          wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_pa_ed_sr_im||
                          wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_im||
                          wd in pqs_pn_pa_ed_sr_im)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edzeim(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
	              if (wd in pq2_ne_vz_na_ed_ze_im||wd in pq2_ne_vz_pa_ed_ze_im||wd in pq2_ne_na_ed_ze_im||wd in pq2_ne_pa_ed_ze_im||
                          wd in pq2_pe_na_ed_ze_im||wd in pq2_pe_pa_ed_ze_im||wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_im||
                          wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_pa_ed_ze_im||wd in pqn_ne_vz_na_ed_ze_im||wd in pqn_ne_vz_pa_ed_ze_im||
                          wd in pqn_ne_na_ed_ze_im||wd in pqn_ne_pa_ed_ze_im||wd in pqn_pe_na_ed_ze_im||wd in pqn_pe_pa_ed_ze_im||
                          wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_im||wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_pa_ed_ze_im||
                          wd in pqs_ne_vz_pa_ed_ze_im||wd in pqs_ne_pa_ed_ze_im||wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_im||
                          wd in pqs_pn_pa_ed_ze_im)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edmuvi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||
                          wd in pq2_ne_pa_ed_mu_ro||wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||
                          wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||
                          wd in pqn_ne_vz_pa_ed_mu_ro||wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||
                          wd in pqn_pe_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||
                          wd in pqn_pn_pa_ed_mu_ro||wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||
                          wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_ro)                                                                {ret=1} else {ret=0}; return ret}
function prq_edsrvi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||wd in pq2_ne_na_ed_sr_im||wd in pq2_ne_pa_ed_sr_im||
                          wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_im||
                          wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||wd in pqn_ne_vz_na_ed_sr_im||wd in pqn_ne_vz_pa_ed_sr_im||
                          wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||wd in pqn_pe_na_ed_sr_im||wd in pqn_pe_pa_ed_sr_im||
                          wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_pa_ed_sr_im||
                          wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_im||
                          wd in pqs_pn_pa_ed_sr_im)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edzevi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_ze_vi||wd in pq2_ne_vz_pa_ed_ze_vi||wd in pq2_ne_na_ed_ze_vi||wd in pq2_ne_pa_ed_ze_vi||
                          wd in pq2_pe_na_ed_ze_vi||wd in pq2_pe_pa_ed_ze_vi||wd in pq2_pe_sd_na_ed_ze_vi||wd in pq2_pe_sd_pa_ed_ze_vi||
                          wd in pq2_pn_na_ed_ze_vi||wd in pq2_pn_pa_ed_ze_vi||wd in pqn_ne_vz_na_ed_ze_vi||wd in pqn_ne_vz_pa_ed_ze_vi||
                          wd in pqn_ne_na_ed_ze_vi||wd in pqn_ne_pa_ed_ze_vi||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_pa_ed_ze_vi||
                          wd in pqn_pe_sd_na_ed_ze_vi||wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pn_na_ed_ze_vi||wd in pqn_pn_pa_ed_ze_vi||
                          wd in pqs_ne_vz_pa_ed_ze_vi||wd in pqs_ne_pa_ed_ze_vi||wd in pqs_pe_pa_ed_ze_vi||wd in pqs_pe_sd_pa_ed_ze_vi||
                          wd in pqs_pn_pa_ed_ze_vi)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edmuro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||wd in pq2_ne_pa_ed_mu_ro||
                          wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||
                          wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||wd in pqn_ne_vz_pa_ed_mu_ro||
                          wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_pa_ed_mu_ro||
                          wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||wd in pqn_pn_pa_ed_mu_ro||
                          wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_ro||
                          wd in pqs_pn_pa_ed_mu_ro)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_sdedmuro(n,                                                                                                                        wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||                               
                          wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_ro)                                                             {ret=1} else {ret=0}; return ret}
function prq_edsrro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_sr_ro||wd in pq2_ne_vz_pa_ed_sr_ro||wd in pq2_ne_na_ed_sr_ro||wd in pq2_ne_pa_ed_sr_ro||
                          wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_pa_ed_sr_ro||wd in pq2_pe_sd_na_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_ro||
                          wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_pa_ed_sr_ro||wd in pqn_ne_vz_na_ed_sr_ro||wd in pqn_ne_vz_pa_ed_sr_ro||
                          wd in pqn_ne_na_ed_sr_ro||wd in pqn_ne_pa_ed_sr_ro||wd in pqn_pe_na_ed_sr_ro||wd in pqn_pe_pa_ed_sr_ro||
                          wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pn_na_ed_sr_ro||wd in pqn_pn_pa_ed_sr_ro||
                          wd in pqs_ne_vz_pa_ed_sr_ro||wd in pqs_ne_pa_ed_sr_ro||wd in pqs_pe_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_ro||
                          wd in pqs_pn_pa_ed_sr_ro)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_sdedsrro(n,                                                                                                                        wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pe_sd_na_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_ro||                               
                          wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_ro)                                                             {ret=1} else {ret=0}; return ret}
function prq_edzero(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
	              if (wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||
                          wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||
                          wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||
                          wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||
                          wd in pqs_pn_pa_ed_ze_dr)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edmuda(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                     if (wd in pq2_ne_vz_na_ed_mu_da||wd in pq2_ne_vz_pa_ed_mu_da||wd in pq2_ne_na_ed_mu_da||wd in pq2_ne_pa_ed_mu_da||
                         wd in pq2_pe_na_ed_mu_da||wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_pa_ed_mu_da||
                         wd in pq2_pn_na_ed_mu_da||wd in pq2_pn_pa_ed_mu_da||wd in pqn_ne_vz_na_ed_mu_da||wd in pqn_ne_vz_pa_ed_mu_da||
                         wd in pqn_ne_na_ed_mu_da||wd in pqn_ne_pa_ed_mu_da||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_pa_ed_mu_da||
                         wd in pqn_pe_sd_na_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_pa_ed_mu_da||
                         wd in pqs_ne_vz_pa_ed_mu_da||wd in pqs_ne_pa_ed_mu_da||wd in pqs_pe_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_da||
                         wd in pqs_pn_pa_ed_mu_da)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edsrda(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                     if (wd in pq2_ne_vz_na_ed_sr_da||wd in pq2_ne_vz_pa_ed_sr_da||wd in pq2_ne_na_ed_sr_da||wd in pq2_ne_pa_ed_sr_da||
                         wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_da||wd in pq2_pe_sd_pa_ed_sr_da||
                         wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_pa_ed_sr_da||wd in pqn_ne_vz_na_ed_sr_da||wd in pqn_ne_vz_pa_ed_sr_da||
                         wd in pqn_ne_na_ed_sr_da||wd in pqn_ne_pa_ed_sr_da||wd in pqn_pe_na_ed_sr_da||wd in pqn_pe_pa_ed_sr_da||
                         wd in pqn_pe_sd_na_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pn_na_ed_sr_da||wd in pqn_pn_pa_ed_sr_da||
                         wd in pqs_ne_vz_pa_ed_sr_da||wd in pqs_ne_pa_ed_sr_da||wd in pqs_pe_pa_ed_sr_da||wd in pqs_pe_sd_pa_ed_sr_da||
                         wd in pqs_pn_pa_ed_sr_da)                                                                                             {ret=1} else {ret=0}; return ret}
function prq_edzeda(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||
                          wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||
                          wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||
                          wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||
                          wd in pqs_pn_pa_ed_ze_dr)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edmutv(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_tv||wd in pq2_ne_vz_pa_ed_mu_tv||wd in pq2_ne_na_ed_mu_tv||wd in pq2_ne_pa_ed_mu_tv||
                          wd in pq2_pe_na_ed_mu_tv||wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_pa_ed_mu_tv||
                          wd in pq2_pn_na_ed_mu_tv||wd in pq2_pn_pa_ed_mu_tv||wd in pqn_ne_vz_na_ed_mu_tv||wd in pqn_ne_vz_pa_ed_mu_tv||
                          wd in pqn_ne_na_ed_mu_tv||wd in pqn_ne_pa_ed_mu_tv||wd in pqn_pe_na_ed_mu_tv||wd in pqn_pe_pa_ed_mu_tv||
                          wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pn_na_ed_mu_tv||wd in pqn_pn_pa_ed_mu_tv||
                          wd in pqs_ne_vz_pa_ed_mu_tv||wd in pqs_ne_pa_ed_mu_tv||wd in pqs_pe_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_mu_tv||
                          wd in pqs_pn_pa_ed_mu_tv)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edsrtv(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_sr_tv||wd in pq2_ne_vz_pa_ed_sr_tv||wd in pq2_ne_na_ed_sr_tv||wd in pq2_ne_pa_ed_sr_tv||
                          wd in pq2_pe_na_ed_sr_tv||wd in pq2_pe_pa_ed_sr_tv||wd in pq2_pe_sd_na_ed_sr_tv||wd in pq2_pe_sd_pa_ed_sr_tv||
                          wd in pq2_pn_na_ed_sr_tv||wd in pq2_pn_pa_ed_sr_tv||wd in pqn_ne_vz_na_ed_sr_tv||wd in pqn_ne_vz_pa_ed_sr_tv||
                          wd in pqn_ne_na_ed_sr_tv||wd in pqn_ne_pa_ed_sr_tv||wd in pqn_pe_na_ed_sr_tv||wd in pqn_pe_pa_ed_sr_tv||
                          wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_pa_ed_sr_tv||wd in pqn_pn_na_ed_sr_tv||wd in pqn_pn_pa_ed_sr_tv||
                          wd in pqs_ne_vz_pa_ed_sr_tv||wd in pqs_ne_pa_ed_sr_tv||wd in pqs_pe_pa_ed_sr_tv||wd in pqs_pe_sd_pa_ed_sr_tv||
                          wd in pqs_pn_pa_ed_sr_tv)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edzetv(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_ze_tv||wd in pq2_ne_vz_pa_ed_ze_tv||wd in pq2_ne_na_ed_ze_tv||wd in pq2_ne_pa_ed_ze_tv||
                          wd in pq2_pe_na_ed_ze_tv||wd in pq2_pe_pa_ed_ze_tv||wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_tv||
                          wd in pq2_pn_na_ed_ze_tv||wd in pq2_pn_pa_ed_ze_tv||wd in pqn_ne_vz_na_ed_ze_tv||wd in pqn_ne_vz_pa_ed_ze_tv||
                          wd in pqn_ne_na_ed_ze_tv||wd in pqn_ne_pa_ed_ze_tv||wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_pa_ed_ze_tv||
                          wd in pqn_pe_sd_na_ed_ze_tv||wd in pqn_pe_sd_pa_ed_ze_tv||wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_pa_ed_ze_tv||
                          wd in pqs_ne_vz_pa_ed_ze_tv||wd in pqs_ne_pa_ed_ze_tv||wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_tv||
                          wd in pqs_pn_pa_ed_ze_tv||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||
                          wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||
                          wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||
                          wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||
                          wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||
                          wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||
                          wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr)                                                               {ret=1} else {ret=0}; return ret}
function prq_edmupr(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_pr||wd in pq2_ne_vz_pa_ed_mu_pr||wd in pq2_ne_na_ed_mu_pr||wd in pq2_ne_pa_ed_mu_pr||
                          wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_pr||
                          wd in pq2_pn_na_ed_mu_pr||wd in pq2_pn_pa_ed_mu_pr||wd in pqn_ne_vz_na_ed_mu_pr||wd in pqn_ne_vz_pa_ed_mu_pr||
                          wd in pqn_ne_na_ed_mu_pr||wd in pqn_ne_pa_ed_mu_pr||wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_pa_ed_mu_pr||
                          wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_pa_ed_mu_pr||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_pa_ed_mu_pr||
                          wd in pqs_ne_vz_pa_ed_mu_pr||wd in pqs_ne_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_pr)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edsrpr(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_sr_pr||wd in pq2_ne_vz_pa_ed_sr_pr||wd in pq2_ne_na_ed_sr_pr||wd in pq2_ne_pa_ed_sr_pr||
                          wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_pr||wd in pq2_pe_sd_pa_ed_sr_pr||
                          wd in pq2_pn_na_ed_sr_pr||wd in pq2_pn_pa_ed_sr_pr||wd in pqn_ne_vz_na_ed_sr_pr||wd in pqn_ne_vz_pa_ed_sr_pr||
                          wd in pqn_ne_na_ed_sr_pr||wd in pqn_ne_pa_ed_sr_pr||wd in pqn_pe_na_ed_sr_pr||wd in pqn_pe_pa_ed_sr_pr||
                          wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_pa_ed_sr_pr||wd in pqn_pn_na_ed_sr_pr||wd in pqn_pn_pa_ed_sr_pr||
                          wd in pqs_ne_vz_pa_ed_sr_pr||wd in pqs_ne_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_pr||wd in pqs_pe_sd_pa_ed_sr_pr||
                          wd in pqs_pn_pa_ed_sr_pr)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edzepr(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||
                          wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||
                          wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||
                          wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||
                          wd in pqs_pn_pa_ed_ze_dr)                                                                                            {ret=1} else {ret=0}; return ret}
function prq_edim(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n); 
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||wd in pq2_ne_na_ed_sr_im||
                          wd in pq2_ne_pa_ed_sr_im||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_im||
                          wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||wd in pqn_ne_vz_na_ed_sr_im||
                          wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||wd in pqn_pe_na_ed_sr_im||
                          wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pn_na_ed_sr_im||
                          wd in pqn_pn_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_im||
                          wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_im||wd in pq2_ne_vz_na_ed_ze_im||wd in pq2_ne_vz_pa_ed_ze_im||
                          wd in pq2_ne_na_ed_ze_im||wd in pq2_ne_pa_ed_ze_im||wd in pq2_pe_na_ed_ze_im||wd in pq2_pe_pa_ed_ze_im||
                          wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_pa_ed_ze_im||
                          wd in pqn_ne_vz_na_ed_ze_im||wd in pqn_ne_vz_pa_ed_ze_im||wd in pqn_ne_na_ed_ze_im||wd in pqn_ne_pa_ed_ze_im||
                          wd in pqn_pe_na_ed_ze_im||wd in pqn_pe_pa_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_im||
                          wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_pa_ed_ze_im||wd in pqs_ne_vz_pa_ed_ze_im||wd in pqs_ne_pa_ed_ze_im||
                          wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_im||wd in pqs_pn_pa_ed_ze_im)                                     {ret=1} else {ret=0}; return ret}
function prq_edvi(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||
                          wd in pq2_ne_pa_ed_mu_ro||wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||
                          wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||
                          wd in pqn_ne_vz_pa_ed_mu_ro||wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||
                          wd in pqn_pe_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||
                          wd in pqn_pn_pa_ed_mu_ro||wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||
                          wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_ro||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||
                          wd in pq2_ne_na_ed_sr_im||wd in pq2_ne_pa_ed_sr_im||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||
                          wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||
                          wd in pqn_ne_vz_na_ed_sr_im||wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||
                          wd in pqn_pe_na_ed_sr_im||wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||
                          wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||
                          wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_im||wd in pq2_ne_vz_na_ed_ze_vi||
                          wd in pq2_ne_vz_pa_ed_ze_vi||wd in pq2_ne_na_ed_ze_vi||wd in pq2_ne_pa_ed_ze_vi||wd in pq2_pe_na_ed_ze_vi||
                          wd in pq2_pe_pa_ed_ze_vi||wd in pq2_pe_sd_na_ed_ze_vi||wd in pq2_pe_sd_pa_ed_ze_vi||wd in pq2_pn_na_ed_ze_vi||
                          wd in pq2_pn_pa_ed_ze_vi||wd in pqn_ne_vz_na_ed_ze_vi||wd in pqn_ne_vz_pa_ed_ze_vi||wd in pqn_ne_na_ed_ze_vi||
                          wd in pqn_ne_pa_ed_ze_vi||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_pa_ed_ze_vi||wd in pqn_pe_sd_na_ed_ze_vi||
                          wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pn_na_ed_ze_vi||wd in pqn_pn_pa_ed_ze_vi||wd in pqs_ne_vz_pa_ed_ze_vi||
                          wd in pqs_ne_pa_ed_ze_vi||wd in pqs_pe_pa_ed_ze_vi||wd in pqs_pe_sd_pa_ed_ze_vi||wd in pqs_pn_pa_ed_ze_vi)           {ret=1} else {ret=0}; return ret}
function prq_edro(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||wd in pq2_ne_pa_ed_mu_ro||
                          wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||
                          wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||wd in pqn_ne_vz_pa_ed_mu_ro||
                          wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_pa_ed_mu_ro||
                          wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||wd in pqn_pn_pa_ed_mu_ro||
                          wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_ro||
                          wd in pqs_pn_pa_ed_mu_ro||wd in pq2_ne_vz_na_ed_sr_ro||wd in pq2_ne_vz_pa_ed_sr_ro||wd in pq2_ne_na_ed_sr_ro||
                          wd in pq2_ne_pa_ed_sr_ro||wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_pa_ed_sr_ro||wd in pq2_pe_sd_na_ed_sr_ro||
                          wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_pa_ed_sr_ro||wd in pqn_ne_vz_na_ed_sr_ro||
                          wd in pqn_ne_vz_pa_ed_sr_ro||wd in pqn_ne_na_ed_sr_ro||wd in pqn_ne_pa_ed_sr_ro||wd in pqn_pe_na_ed_sr_ro||
                          wd in pqn_pe_pa_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pn_na_ed_sr_ro||
                          wd in pqn_pn_pa_ed_sr_ro||wd in pqs_ne_vz_pa_ed_sr_ro||wd in pqs_ne_pa_ed_sr_ro||wd in pqs_pe_pa_ed_sr_ro||
                          wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pn_pa_ed_sr_ro||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr)                                     {ret=1} else {ret=0}; return ret}
function prq_sdedro(n,                                                                                                                         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||
                          wd in pqs_pe_sd_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_ro||
                          wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_ro||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr)                               {ret=1} else {ret=0}; return ret}
function prq_edda(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_da||wd in pq2_ne_vz_pa_ed_mu_da||wd in pq2_ne_na_ed_mu_da||wd in pq2_ne_pa_ed_mu_da||
                          wd in pq2_pe_na_ed_mu_da||wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_pa_ed_mu_da||
                          wd in pq2_pn_na_ed_mu_da||wd in pq2_pn_pa_ed_mu_da||wd in pqn_ne_vz_na_ed_mu_da||wd in pqn_ne_vz_pa_ed_mu_da||
                          wd in pqn_ne_na_ed_mu_da||wd in pqn_ne_pa_ed_mu_da||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_pa_ed_mu_da||
                          wd in pqn_pe_sd_na_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_pa_ed_mu_da||
                          wd in pqs_ne_vz_pa_ed_mu_da||wd in pqs_ne_pa_ed_mu_da||wd in pqs_pe_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_da||
                          wd in pqs_pn_pa_ed_mu_da||wd in pq2_ne_vz_na_ed_sr_da||wd in pq2_ne_vz_pa_ed_sr_da||wd in pq2_ne_na_ed_sr_da||
                          wd in pq2_ne_pa_ed_sr_da||wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_da||
                          wd in pq2_pe_sd_pa_ed_sr_da||wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_pa_ed_sr_da||wd in pqn_ne_vz_na_ed_sr_da||
                          wd in pqn_ne_vz_pa_ed_sr_da||wd in pqn_ne_na_ed_sr_da||wd in pqn_ne_pa_ed_sr_da||wd in pqn_pe_na_ed_sr_da||
                          wd in pqn_pe_pa_ed_sr_da||wd in pqn_pe_sd_na_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pn_na_ed_sr_da||
                          wd in pqn_pn_pa_ed_sr_da||wd in pqs_ne_vz_pa_ed_sr_da||wd in pqs_ne_pa_ed_sr_da||wd in pqs_pe_pa_ed_sr_da||
                          wd in pqs_pe_sd_pa_ed_sr_da||wd in pqs_pn_pa_ed_sr_da||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr)                                     {ret=1} else {ret=0}; return ret}
function prq_edtv(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_tv||wd in pq2_ne_vz_pa_ed_mu_tv||wd in pq2_ne_na_ed_mu_tv||wd in pq2_ne_pa_ed_mu_tv||
                          wd in pq2_pe_na_ed_mu_tv||wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_pa_ed_mu_tv||
                          wd in pq2_pn_na_ed_mu_tv||wd in pq2_pn_pa_ed_mu_tv||wd in pqn_ne_vz_na_ed_mu_tv||wd in pqn_ne_vz_pa_ed_mu_tv||
                          wd in pqn_ne_na_ed_mu_tv||wd in pqn_ne_pa_ed_mu_tv||wd in pqn_pe_na_ed_mu_tv||wd in pqn_pe_pa_ed_mu_tv||
                          wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pn_na_ed_mu_tv||wd in pqn_pn_pa_ed_mu_tv||
                          wd in pqs_ne_vz_pa_ed_mu_tv||wd in pqs_ne_pa_ed_mu_tv||wd in pqs_pe_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_mu_tv||
                          wd in pqs_pn_pa_ed_mu_tv||wd in pq2_ne_vz_na_ed_sr_tv||wd in pq2_ne_vz_pa_ed_sr_tv||wd in pq2_ne_na_ed_sr_tv||
                          wd in pq2_ne_pa_ed_sr_tv||wd in pq2_pe_na_ed_sr_tv||wd in pq2_pe_pa_ed_sr_tv||wd in pq2_pe_sd_na_ed_sr_tv||
                          wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pn_na_ed_sr_tv||wd in pq2_pn_pa_ed_sr_tv||wd in pqn_ne_vz_na_ed_sr_tv||
                          wd in pqn_ne_vz_pa_ed_sr_tv||wd in pqn_ne_na_ed_sr_tv||wd in pqn_ne_pa_ed_sr_tv||wd in pqn_pe_na_ed_sr_tv||
                          wd in pqn_pe_pa_ed_sr_tv||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_pa_ed_sr_tv||wd in pqn_pn_na_ed_sr_tv||
                          wd in pqn_pn_pa_ed_sr_tv||wd in pqs_ne_vz_pa_ed_sr_tv||wd in pqs_ne_pa_ed_sr_tv||wd in pqs_pe_pa_ed_sr_tv||
                          wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pn_pa_ed_sr_tv||wd in pq2_ne_vz_na_ed_ze_tv||wd in pq2_ne_vz_pa_ed_ze_tv||
                          wd in pq2_ne_na_ed_ze_tv||wd in pq2_ne_pa_ed_ze_tv||wd in pq2_pe_na_ed_ze_tv||wd in pq2_pe_pa_ed_ze_tv||
                          wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_tv||wd in pq2_pn_na_ed_ze_tv||wd in pq2_pn_pa_ed_ze_tv||
                          wd in pqn_ne_vz_na_ed_ze_tv||wd in pqn_ne_vz_pa_ed_ze_tv||wd in pqn_ne_na_ed_ze_tv||wd in pqn_ne_pa_ed_ze_tv||
                          wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_pa_ed_ze_tv||wd in pqn_pe_sd_na_ed_ze_tv||wd in pqn_pe_sd_pa_ed_ze_tv||
                          wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_pa_ed_ze_tv||wd in pqs_ne_vz_pa_ed_ze_tv||wd in pqs_ne_pa_ed_ze_tv||
                          wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_tv||wd in pqs_pn_pa_ed_ze_tv||wd in pq2_ne_vz_na_ed_ze_dr||
                          wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||
                          wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||
                          wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||
                          wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||
                          wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||
                          wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr)           {ret=1} else {ret=0}; return ret}
function prq_edpr(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_pr||wd in pq2_ne_vz_pa_ed_mu_pr||wd in pq2_ne_na_ed_mu_pr||wd in pq2_ne_pa_ed_mu_pr||
                          wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_pr||
                          wd in pq2_pn_na_ed_mu_pr||wd in pq2_pn_pa_ed_mu_pr||wd in pqn_ne_vz_na_ed_mu_pr||wd in pqn_ne_vz_pa_ed_mu_pr||
                          wd in pqn_ne_na_ed_mu_pr||wd in pqn_ne_pa_ed_mu_pr||wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_pa_ed_mu_pr||
                          wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_pa_ed_mu_pr||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_pa_ed_mu_pr||
                          wd in pqs_ne_vz_pa_ed_mu_pr||wd in pqs_ne_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_pr||wd in pq2_ne_vz_na_ed_sr_pr||wd in pq2_ne_vz_pa_ed_sr_pr||wd in pq2_ne_na_ed_sr_pr||
                          wd in pq2_ne_pa_ed_sr_pr||wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_pr||
                          wd in pq2_pe_sd_pa_ed_sr_pr||wd in pq2_pn_na_ed_sr_pr||wd in pq2_pn_pa_ed_sr_pr||wd in pqn_ne_vz_na_ed_sr_pr||
                          wd in pqn_ne_vz_pa_ed_sr_pr||wd in pqn_ne_na_ed_sr_pr||wd in pqn_ne_pa_ed_sr_pr||wd in pqn_pe_na_ed_sr_pr||
                          wd in pqn_pe_pa_ed_sr_pr||wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_pa_ed_sr_pr||wd in pqn_pn_na_ed_sr_pr||  
                          wd in pqn_pn_pa_ed_sr_pr||wd in pqs_ne_vz_pa_ed_sr_pr||wd in pqs_ne_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_pr||
                          wd in pqs_pe_sd_pa_ed_sr_pr||wd in pqs_pn_pa_ed_sr_pr||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr)                                         {ret=1} else {ret=0}; return ret}
function prq_mnim(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_im||wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_na_mn_im||wd in pq2_ne_pa_mn_im||wd in pq2_pe_na_mn_im||
                          wd in pq2_pe_pa_mn_im||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pn_na_mn_im||wd in pq2_pn_pa_mn_im||
                          wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_na_mn_im||wd in pqn_ne_pa_mn_im||wd in pqn_pe_na_mn_im||
                          wd in pqn_pe_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pn_na_mn_im||wd in pqn_pn_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_im||wd in pqs_ne_pa_mn_im||wd in pqs_pe_pa_mn_im||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pn_pa_mn_im) {ret=1} else {ret=0}; return ret}
function prq_sdmnim(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||
                          wd in pqs_pe_sd_pa_mn_im)                                                                                                {ret=1} else {ret=0}; return ret}
function prq_mnvi(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_im||wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_na_mn_im||wd in pq2_ne_pa_mn_im||wd in pq2_pe_na_mn_im||
                          wd in pq2_pe_pa_mn_im||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pn_na_mn_im||wd in pq2_pn_pa_mn_im||
                          wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_na_mn_im||wd in pqn_ne_pa_mn_im||wd in pqn_pe_na_mn_im||
                          wd in pqn_pe_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pn_na_mn_im||wd in pqn_pn_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_im||wd in pqs_ne_pa_mn_im||wd in pqs_pe_pa_mn_im||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pn_pa_mn_im||
                          wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro) {ret=1} else {ret=0}; return ret}
function prq_mnro(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro) {ret=1} else {ret=0}; return ret}
function prq_mnda(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_da||wd in pq2_ne_vz_pa_mn_da||wd in pq2_ne_na_mn_da||wd in pq2_ne_pa_mn_da||wd in pq2_pe_na_mn_da||
                          wd in pq2_pe_pa_mn_da||wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pn_na_mn_da||wd in pq2_pn_pa_mn_da||
                          wd in pqn_ne_vz_na_mn_da||wd in pqn_ne_vz_pa_mn_da||wd in pqn_ne_na_mn_da||wd in pqn_ne_pa_mn_da||wd in pqn_pe_na_mn_da||
                          wd in pqn_pe_pa_mn_da||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_pa_mn_da||wd in pqn_pn_na_mn_da||wd in pqn_pn_pa_mn_da||
                          wd in pqs_ne_vz_pa_mn_da||wd in pqs_ne_pa_mn_da||wd in pqs_pe_pa_mn_da||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pn_pa_mn_da) {ret=1} else {ret=0}; return ret}
function prq_mntv(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_tv||wd in pq2_ne_vz_pa_mn_tv||wd in pq2_ne_na_mn_tv||wd in pq2_ne_pa_mn_tv||wd in pq2_pe_na_mn_tv||
                          wd in pq2_pe_pa_mn_tv||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_mn_tv||wd in pq2_pn_na_mn_tv||wd in pq2_pn_pa_mn_tv||
                          wd in pqn_ne_vz_na_mn_tv||wd in pqn_ne_vz_pa_mn_tv||wd in pqn_ne_na_mn_tv||wd in pqn_ne_pa_mn_tv||wd in pqn_pe_na_mn_tv||
                          wd in pqn_pe_pa_mn_tv||wd in pqn_pe_sd_na_mn_tv||wd in pqn_pe_sd_pa_mn_tv||wd in pqn_pn_na_mn_tv||wd in pqn_pn_pa_mn_tv||
                          wd in pqs_ne_vz_pa_mn_tv||wd in pqs_ne_pa_mn_tv||wd in pqs_pe_pa_mn_tv||wd in pqs_pe_sd_pa_mn_tv||wd in pqs_pn_pa_mn_tv) {ret=1} else {ret=0}; return ret}
function prq_mnpr(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro) {ret=1} else {ret=0}; return ret}
function prq_im(n,                                                                                                                                 wd,ret) { if(!wd)wd=lc(n); 
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||wd in pq2_ne_na_ed_sr_im||
                          wd in pq2_ne_pa_ed_sr_im||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_im||
                          wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||wd in pqn_ne_vz_na_ed_sr_im||
                          wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||wd in pqn_pe_na_ed_sr_im||
                          wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pn_na_ed_sr_im||
                          wd in pqn_pn_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_im||
                          wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_im||wd in pq2_ne_vz_na_ed_ze_im||wd in pq2_ne_vz_pa_ed_ze_im||
                          wd in pq2_ne_na_ed_ze_im||wd in pq2_ne_pa_ed_ze_im||wd in pq2_pe_na_ed_ze_im||wd in pq2_pe_pa_ed_ze_im||
                          wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_pa_ed_ze_im||
                          wd in pqn_ne_vz_na_ed_ze_im||wd in pqn_ne_vz_pa_ed_ze_im||wd in pqn_ne_na_ed_ze_im||wd in pqn_ne_pa_ed_ze_im||
                          wd in pqn_pe_na_ed_ze_im||wd in pqn_pe_pa_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_im||
                          wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_pa_ed_ze_im||wd in pqs_ne_vz_pa_ed_ze_im||wd in pqs_ne_pa_ed_ze_im||
                          wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_im||wd in pqs_pn_pa_ed_ze_im||wd in pq2_ne_vz_na_mn_im||
                          wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_na_mn_im||wd in pq2_ne_pa_mn_im||wd in pq2_pe_na_mn_im||
                          wd in pq2_pe_pa_mn_im||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pn_na_mn_im||wd in pq2_pn_pa_mn_im||
                          wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_na_mn_im||wd in pqn_ne_pa_mn_im||wd in pqn_pe_na_mn_im||
                          wd in pqn_pe_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pn_na_mn_im||wd in pqn_pn_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_im||wd in pqs_ne_pa_mn_im||wd in pqs_pe_pa_mn_im||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pn_pa_mn_im) {ret=1} else {ret=0}; return ret}
function prq_vi(n,                                                                                                                                 wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||
                          wd in pq2_ne_pa_ed_mu_ro||wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||
                          wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||
                          wd in pqn_ne_vz_pa_ed_mu_ro||wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||
                          wd in pqn_pe_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||
                          wd in pqn_pn_pa_ed_mu_ro||wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||
                          wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_ro||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||
                          wd in pq2_ne_na_ed_sr_im||wd in pq2_ne_pa_ed_sr_im||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||
                          wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||
                          wd in pqn_ne_vz_na_ed_sr_im||wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||
                          wd in pqn_pe_na_ed_sr_im||wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||
                          wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||
                          wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_im||wd in pq2_ne_vz_na_ed_ze_vi||
                          wd in pq2_ne_vz_pa_ed_ze_vi||wd in pq2_ne_na_ed_ze_vi||wd in pq2_ne_pa_ed_ze_vi||wd in pq2_pe_na_ed_ze_vi||
                          wd in pq2_pe_pa_ed_ze_vi||wd in pq2_pe_sd_na_ed_ze_vi||wd in pq2_pe_sd_pa_ed_ze_vi||wd in pq2_pn_na_ed_ze_vi||
                          wd in pq2_pn_pa_ed_ze_vi||wd in pqn_ne_vz_na_ed_ze_vi||wd in pqn_ne_vz_pa_ed_ze_vi||wd in pqn_ne_na_ed_ze_vi||
                          wd in pqn_ne_pa_ed_ze_vi||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_pa_ed_ze_vi||wd in pqn_pe_sd_na_ed_ze_vi||
                          wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pn_na_ed_ze_vi||wd in pqn_pn_pa_ed_ze_vi||wd in pqs_ne_vz_pa_ed_ze_vi||
                          wd in pqs_ne_pa_ed_ze_vi||wd in pqs_pe_pa_ed_ze_vi||wd in pqs_pe_sd_pa_ed_ze_vi||wd in pqs_pn_pa_ed_ze_vi||
			                    wd in pq2_ne_vz_na_mn_im||wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_na_mn_im||wd in pq2_ne_pa_mn_im||wd in pq2_pe_na_mn_im||
                          wd in pq2_pe_pa_mn_im||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pn_na_mn_im||wd in pq2_pn_pa_mn_im||
                          wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_na_mn_im||wd in pqn_ne_pa_mn_im||wd in pqn_pe_na_mn_im||
                          wd in pqn_pe_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pn_na_mn_im||wd in pqn_pn_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_im||wd in pqs_ne_pa_mn_im||wd in pqs_pe_pa_mn_im||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pn_pa_mn_im||
                          wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro){ret=1} else {ret=0}; return ret}
function prq_ro(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||wd in pq2_ne_pa_ed_mu_ro||
                          wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||
                          wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||wd in pqn_ne_vz_pa_ed_mu_ro||
                          wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_pa_ed_mu_ro||
                          wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||wd in pqn_pn_pa_ed_mu_ro||
                          wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_ro||
                          wd in pqs_pn_pa_ed_mu_ro||wd in pq2_ne_vz_na_ed_sr_ro||wd in pq2_ne_vz_pa_ed_sr_ro||wd in pq2_ne_na_ed_sr_ro||
                          wd in pq2_ne_pa_ed_sr_ro||wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_pa_ed_sr_ro||wd in pq2_pe_sd_na_ed_sr_ro||
                          wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_pa_ed_sr_ro||wd in pqn_ne_vz_na_ed_sr_ro||
                          wd in pqn_ne_vz_pa_ed_sr_ro||wd in pqn_ne_na_ed_sr_ro||wd in pqn_ne_pa_ed_sr_ro||wd in pqn_pe_na_ed_sr_ro||
                          wd in pqn_pe_pa_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pn_na_ed_sr_ro||
                          wd in pqn_pn_pa_ed_sr_ro||wd in pqs_ne_vz_pa_ed_sr_ro||wd in pqs_ne_pa_ed_sr_ro||wd in pqs_pe_pa_ed_sr_ro||
                          wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pn_pa_ed_sr_ro||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr||
                          wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro){ret=1} else {ret=0}; return ret}
function prq_da(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_da||wd in pq2_ne_vz_pa_ed_mu_da||wd in pq2_ne_na_ed_mu_da||wd in pq2_ne_pa_ed_mu_da||
                          wd in pq2_pe_na_ed_mu_da||wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_pa_ed_mu_da||
                          wd in pq2_pn_na_ed_mu_da||wd in pq2_pn_pa_ed_mu_da||wd in pqn_ne_vz_na_ed_mu_da||wd in pqn_ne_vz_pa_ed_mu_da||
                          wd in pqn_ne_na_ed_mu_da||wd in pqn_ne_pa_ed_mu_da||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_pa_ed_mu_da||
                          wd in pqn_pe_sd_na_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_pa_ed_mu_da||
                          wd in pqs_ne_vz_pa_ed_mu_da||wd in pqs_ne_pa_ed_mu_da||wd in pqs_pe_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_da||
                          wd in pqs_pn_pa_ed_mu_da||wd in pq2_ne_vz_na_ed_sr_da||wd in pq2_ne_vz_pa_ed_sr_da||wd in pq2_ne_na_ed_sr_da||
                          wd in pq2_ne_pa_ed_sr_da||wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_da||
                          wd in pq2_pe_sd_pa_ed_sr_da||wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_pa_ed_sr_da||wd in pqn_ne_vz_na_ed_sr_da||
                          wd in pqn_ne_vz_pa_ed_sr_da||wd in pqn_ne_na_ed_sr_da||wd in pqn_ne_pa_ed_sr_da||wd in pqn_pe_na_ed_sr_da||
                          wd in pqn_pe_pa_ed_sr_da||wd in pqn_pe_sd_na_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pn_na_ed_sr_da||
                          wd in pqn_pn_pa_ed_sr_da||wd in pqs_ne_vz_pa_ed_sr_da||wd in pqs_ne_pa_ed_sr_da||wd in pqs_pe_pa_ed_sr_da||
                          wd in pqs_pe_sd_pa_ed_sr_da||wd in pqs_pn_pa_ed_sr_da||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr||
                          wd in pq2_ne_vz_na_mn_da||wd in pq2_ne_vz_pa_mn_da||wd in pq2_ne_na_mn_da||wd in pq2_ne_pa_mn_da||wd in pq2_pe_na_mn_da||
                          wd in pq2_pe_pa_mn_da||wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pn_na_mn_da||wd in pq2_pn_pa_mn_da||
                          wd in pqn_ne_vz_na_mn_da||wd in pqn_ne_vz_pa_mn_da||wd in pqn_ne_na_mn_da||wd in pqn_ne_pa_mn_da||wd in pqn_pe_na_mn_da||
                          wd in pqn_pe_pa_mn_da||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_pa_mn_da||wd in pqn_pn_na_mn_da||wd in pqn_pn_pa_mn_da||
                          wd in pqs_ne_vz_pa_mn_da||wd in pqs_ne_pa_mn_da||wd in pqs_pe_pa_mn_da||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pn_pa_mn_da){ret=1} else {ret=0}; return ret}
function prq_tv(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_tv||wd in pq2_ne_vz_pa_ed_mu_tv||wd in pq2_ne_na_ed_mu_tv||wd in pq2_ne_pa_ed_mu_tv||
                          wd in pq2_pe_na_ed_mu_tv||wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_pa_ed_mu_tv||
                          wd in pq2_pn_na_ed_mu_tv||wd in pq2_pn_pa_ed_mu_tv||wd in pqn_ne_vz_na_ed_mu_tv||wd in pqn_ne_vz_pa_ed_mu_tv||
                          wd in pqn_ne_na_ed_mu_tv||wd in pqn_ne_pa_ed_mu_tv||wd in pqn_pe_na_ed_mu_tv||wd in pqn_pe_pa_ed_mu_tv||
                          wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pn_na_ed_mu_tv||wd in pqn_pn_pa_ed_mu_tv||
                          wd in pqs_ne_vz_pa_ed_mu_tv||wd in pqs_ne_pa_ed_mu_tv||wd in pqs_pe_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_mu_tv||
                          wd in pqs_pn_pa_ed_mu_tv||wd in pq2_ne_vz_na_ed_sr_tv||wd in pq2_ne_vz_pa_ed_sr_tv||wd in pq2_ne_na_ed_sr_tv||
                          wd in pq2_ne_pa_ed_sr_tv||wd in pq2_pe_na_ed_sr_tv||wd in pq2_pe_pa_ed_sr_tv||wd in pq2_pe_sd_na_ed_sr_tv||
                          wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pn_na_ed_sr_tv||wd in pq2_pn_pa_ed_sr_tv||wd in pqn_ne_vz_na_ed_sr_tv||
                          wd in pqn_ne_vz_pa_ed_sr_tv||wd in pqn_ne_na_ed_sr_tv||wd in pqn_ne_pa_ed_sr_tv||wd in pqn_pe_na_ed_sr_tv||
                          wd in pqn_pe_pa_ed_sr_tv||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_pa_ed_sr_tv||wd in pqn_pn_na_ed_sr_tv||
                          wd in pqn_pn_pa_ed_sr_tv||wd in pqs_ne_vz_pa_ed_sr_tv||wd in pqs_ne_pa_ed_sr_tv||wd in pqs_pe_pa_ed_sr_tv||
                          wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pn_pa_ed_sr_tv||wd in pq2_ne_vz_na_ed_ze_tv||wd in pq2_ne_vz_pa_ed_ze_tv||
                          wd in pq2_ne_na_ed_ze_tv||wd in pq2_ne_pa_ed_ze_tv||wd in pq2_pe_na_ed_ze_tv||wd in pq2_pe_pa_ed_ze_tv||
                          wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_tv||wd in pq2_pn_na_ed_ze_tv||wd in pq2_pn_pa_ed_ze_tv||
                          wd in pqn_ne_vz_na_ed_ze_tv||wd in pqn_ne_vz_pa_ed_ze_tv||wd in pqn_ne_na_ed_ze_tv||wd in pqn_ne_pa_ed_ze_tv||
                          wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_pa_ed_ze_tv||wd in pqn_pe_sd_na_ed_ze_tv||wd in pqn_pe_sd_pa_ed_ze_tv||
                          wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_pa_ed_ze_tv||wd in pqs_ne_vz_pa_ed_ze_tv||wd in pqs_ne_pa_ed_ze_tv||
                          wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_tv||wd in pqs_pn_pa_ed_ze_tv||wd in pq2_ne_vz_na_ed_ze_dr||
                          wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||
                          wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||
                          wd in pq2_pn_pa_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||
                          wd in pqn_ne_pa_ed_ze_dr||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||
                          wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||
                          wd in pqs_ne_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr||
                          wd in pq2_ne_vz_na_mn_tv||wd in pq2_ne_vz_pa_mn_tv||wd in pq2_ne_na_mn_tv||wd in pq2_ne_pa_mn_tv||wd in pq2_pe_na_mn_tv||
                          wd in pq2_pe_pa_mn_tv||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_mn_tv||wd in pq2_pn_na_mn_tv||wd in pq2_pn_pa_mn_tv||
                          wd in pqn_ne_vz_na_mn_tv||wd in pqn_ne_vz_pa_mn_tv||wd in pqn_ne_na_mn_tv||wd in pqn_ne_pa_mn_tv||wd in pqn_pe_na_mn_tv||
                          wd in pqn_pe_pa_mn_tv||wd in pqn_pe_sd_na_mn_tv||wd in pqn_pe_sd_pa_mn_tv||wd in pqn_pn_na_mn_tv||wd in pqn_pn_pa_mn_tv||
                          wd in pqs_ne_vz_pa_mn_tv||wd in pqs_ne_pa_mn_tv||wd in pqs_pe_pa_mn_tv||wd in pqs_pe_sd_pa_mn_tv||wd in pqs_pn_pa_mn_tv){ret=1} else {ret=0}; return ret}
function prq_pr(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_pr||wd in pq2_ne_vz_pa_ed_mu_pr||wd in pq2_ne_na_ed_mu_pr||wd in pq2_ne_pa_ed_mu_pr||
                          wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_pr||
                          wd in pq2_pn_na_ed_mu_pr||wd in pq2_pn_pa_ed_mu_pr||wd in pqn_ne_vz_na_ed_mu_pr||wd in pqn_ne_vz_pa_ed_mu_pr||
                          wd in pqn_ne_na_ed_mu_pr||wd in pqn_ne_pa_ed_mu_pr||wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_pa_ed_mu_pr||
                          wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_pa_ed_mu_pr||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_pa_ed_mu_pr||
                          wd in pqs_ne_vz_pa_ed_mu_pr||wd in pqs_ne_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_pr||wd in pq2_ne_vz_na_ed_sr_pr||wd in pq2_ne_vz_pa_ed_sr_pr||wd in pq2_ne_na_ed_sr_pr||
                          wd in pq2_ne_pa_ed_sr_pr||wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_pr||
                          wd in pq2_pe_sd_pa_ed_sr_pr||wd in pq2_pn_na_ed_sr_pr||wd in pq2_pn_pa_ed_sr_pr||wd in pqn_ne_vz_na_ed_sr_pr||
                          wd in pqn_ne_vz_pa_ed_sr_pr||wd in pqn_ne_na_ed_sr_pr||wd in pqn_ne_pa_ed_sr_pr||wd in pqn_pe_na_ed_sr_pr||
                          wd in pqn_pe_pa_ed_sr_pr||wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_pa_ed_sr_pr||wd in pqn_pn_na_ed_sr_pr||  
                          wd in pqn_pn_pa_ed_sr_pr||wd in pqs_ne_vz_pa_ed_sr_pr||wd in pqs_ne_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_pr||
                          wd in pqs_pe_sd_pa_ed_sr_pr||wd in pqs_pn_pa_ed_sr_pr||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr||
                          wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro){ret=1} else {ret=0}; return ret}
function prq_ed(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_pa_ed_mu_im||wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_pa_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_im||
                          wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_pa_ed_mu_im||wd in pqn_ne_vz_na_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_im||
                          wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_pa_ed_mu_im||wd in pqn_pe_na_ed_mu_im||wd in pqn_pe_pa_ed_mu_im||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pn_pa_ed_mu_im||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_pa_ed_sr_im||wd in pq2_ne_na_ed_sr_im||
                          wd in pq2_ne_pa_ed_sr_im||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_im||
                          wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_pa_ed_sr_im||wd in pqn_ne_vz_na_ed_sr_im||
                          wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_pa_ed_sr_im||wd in pqn_pe_na_ed_sr_im||
                          wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pn_na_ed_sr_im||
                          wd in pqn_pn_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_im||
                          wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_im||wd in pq2_ne_vz_na_ed_ze_im||wd in pq2_ne_vz_pa_ed_ze_im||
                          wd in pq2_ne_na_ed_ze_im||wd in pq2_ne_pa_ed_ze_im||wd in pq2_pe_na_ed_ze_im||wd in pq2_pe_pa_ed_ze_im||
                          wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_pa_ed_ze_im||
                          wd in pqn_ne_vz_na_ed_ze_im||wd in pqn_ne_vz_pa_ed_ze_im||wd in pqn_ne_na_ed_ze_im||wd in pqn_ne_pa_ed_ze_im||
                          wd in pqn_pe_na_ed_ze_im||wd in pqn_pe_pa_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_im||
                          wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_pa_ed_ze_im||wd in pqs_ne_vz_pa_ed_ze_im||wd in pqs_ne_pa_ed_ze_im||
                          wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_im||wd in pqs_pn_pa_ed_ze_im||wd in pq2_ne_vz_na_ed_mu_ro||
                          wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_na_ed_mu_ro||wd in pq2_ne_pa_ed_mu_ro||wd in pq2_pe_na_ed_mu_ro||
                          wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pn_na_ed_mu_ro||
                          wd in pq2_pn_pa_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_ro||wd in pqn_ne_vz_pa_ed_mu_ro||wd in pqn_ne_na_ed_mu_ro||
                          wd in pqn_ne_pa_ed_mu_ro||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_pa_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_ro||
                          wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pn_na_ed_mu_ro||wd in pqn_pn_pa_ed_mu_ro||wd in pqs_ne_vz_pa_ed_mu_ro||
                          wd in pqs_ne_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_ro||
                          wd in pq2_ne_vz_na_ed_ze_vi||wd in pq2_ne_vz_pa_ed_ze_vi||wd in pq2_ne_na_ed_ze_vi||wd in pq2_ne_pa_ed_ze_vi||
                          wd in pq2_pe_na_ed_ze_vi||wd in pq2_pe_pa_ed_ze_vi||wd in pq2_pe_sd_na_ed_ze_vi||wd in pq2_pe_sd_pa_ed_ze_vi||
                          wd in pq2_pn_na_ed_ze_vi||wd in pq2_pn_pa_ed_ze_vi||wd in pqn_ne_vz_na_ed_ze_vi||wd in pqn_ne_vz_pa_ed_ze_vi||
                          wd in pqn_ne_na_ed_ze_vi||wd in pqn_ne_pa_ed_ze_vi||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_pa_ed_ze_vi||
                          wd in pqn_pe_sd_na_ed_ze_vi||wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pn_na_ed_ze_vi||wd in pqn_pn_pa_ed_ze_vi||
                          wd in pqs_ne_vz_pa_ed_ze_vi||wd in pqs_ne_pa_ed_ze_vi||wd in pqs_pe_pa_ed_ze_vi||wd in pqs_pe_sd_pa_ed_ze_vi||
                          wd in pqs_pn_pa_ed_ze_vi||wd in pq2_ne_vz_na_ed_sr_ro||wd in pq2_ne_vz_pa_ed_sr_ro||wd in pq2_ne_na_ed_sr_ro||
                          wd in pq2_ne_pa_ed_sr_ro||wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_pa_ed_sr_ro||wd in pq2_pe_sd_na_ed_sr_ro||
                          wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_pa_ed_sr_ro||wd in pqn_ne_vz_na_ed_sr_ro||
                          wd in pqn_ne_vz_pa_ed_sr_ro||wd in pqn_ne_na_ed_sr_ro||wd in pqn_ne_pa_ed_sr_ro||wd in pqn_pe_na_ed_sr_ro||
                          wd in pqn_pe_pa_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pn_na_ed_sr_ro||
                          wd in pqn_pn_pa_ed_sr_ro||wd in pqs_ne_vz_pa_ed_sr_ro||wd in pqs_ne_pa_ed_sr_ro||wd in pqs_pe_pa_ed_sr_ro||
                          wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pn_pa_ed_sr_ro||wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_dr||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_pa_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_pa_ed_ze_dr||
                          wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_pa_ed_ze_dr||
                          wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_dr||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_pa_ed_ze_dr||wd in pqs_ne_vz_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_dr||wd in pq2_ne_vz_na_ed_mu_da||
                          wd in pq2_ne_vz_pa_ed_mu_da||wd in pq2_ne_na_ed_mu_da||wd in pq2_ne_pa_ed_mu_da||wd in pq2_pe_na_ed_mu_da||
                          wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_pa_ed_mu_da||wd in pq2_pn_na_ed_mu_da||
                          wd in pq2_pn_pa_ed_mu_da||wd in pqn_ne_vz_na_ed_mu_da||wd in pqn_ne_vz_pa_ed_mu_da||wd in pqn_ne_na_ed_mu_da||
                          wd in pqn_ne_pa_ed_mu_da||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_pa_ed_mu_da||wd in pqn_pe_sd_na_ed_mu_da||
                          wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_pa_ed_mu_da||wd in pqs_ne_vz_pa_ed_mu_da||
                          wd in pqs_ne_pa_ed_mu_da||wd in pqs_pe_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_da||wd in pqs_pn_pa_ed_mu_da||
                          wd in pq2_ne_vz_na_ed_sr_da||wd in pq2_ne_vz_pa_ed_sr_da||wd in pq2_ne_na_ed_sr_da||wd in pq2_ne_pa_ed_sr_da||
                          wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_da||wd in pq2_pe_sd_pa_ed_sr_da||
                          wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_pa_ed_sr_da||wd in pqn_ne_vz_na_ed_sr_da||wd in pqn_ne_vz_pa_ed_sr_da||
                          wd in pqn_ne_na_ed_sr_da||wd in pqn_ne_pa_ed_sr_da||wd in pqn_pe_na_ed_sr_da||wd in pqn_pe_pa_ed_sr_da||
                          wd in pqn_pe_sd_na_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pn_na_ed_sr_da||wd in pqn_pn_pa_ed_sr_da||
                          wd in pqs_ne_vz_pa_ed_sr_da||wd in pqs_ne_pa_ed_sr_da||wd in pqs_pe_pa_ed_sr_da||wd in pqs_pe_sd_pa_ed_sr_da||
                          wd in pqs_pn_pa_ed_sr_da||wd in pq2_ne_vz_na_ed_mu_tv||wd in pq2_ne_vz_pa_ed_mu_tv||wd in pq2_ne_na_ed_mu_tv||
                          wd in pq2_ne_pa_ed_mu_tv||wd in pq2_pe_na_ed_mu_tv||wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_sd_na_ed_mu_tv||
                          wd in pq2_pe_sd_pa_ed_mu_tv||wd in pq2_pn_na_ed_mu_tv||wd in pq2_pn_pa_ed_mu_tv||wd in pqn_ne_vz_na_ed_mu_tv||
                          wd in pqn_ne_vz_pa_ed_mu_tv||wd in pqn_ne_na_ed_mu_tv||wd in pqn_ne_pa_ed_mu_tv||wd in pqn_pe_na_ed_mu_tv||
                          wd in pqn_pe_pa_ed_mu_tv||wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pn_na_ed_mu_tv||
                          wd in pqn_pn_pa_ed_mu_tv||wd in pqs_ne_vz_pa_ed_mu_tv||wd in pqs_ne_pa_ed_mu_tv||wd in pqs_pe_pa_ed_mu_tv||
                          wd in pqs_pe_sd_pa_ed_mu_tv||wd in pqs_pn_pa_ed_mu_tv||wd in pq2_ne_vz_na_ed_sr_tv||wd in pq2_ne_vz_pa_ed_sr_tv||
                          wd in pq2_ne_na_ed_sr_tv||wd in pq2_ne_pa_ed_sr_tv||wd in pq2_pe_na_ed_sr_tv||wd in pq2_pe_pa_ed_sr_tv||
                          wd in pq2_pe_sd_na_ed_sr_tv||wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pn_na_ed_sr_tv||wd in pq2_pn_pa_ed_sr_tv||
                          wd in pqn_ne_vz_na_ed_sr_tv||wd in pqn_ne_vz_pa_ed_sr_tv||wd in pqn_ne_na_ed_sr_tv||wd in pqn_ne_pa_ed_sr_tv||
                          wd in pqn_pe_na_ed_sr_tv||wd in pqn_pe_pa_ed_sr_tv||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_pa_ed_sr_tv||
                          wd in pqn_pn_na_ed_sr_tv||wd in pqn_pn_pa_ed_sr_tv||wd in pqs_ne_vz_pa_ed_sr_tv||wd in pqs_ne_pa_ed_sr_tv||
                          wd in pqs_pe_pa_ed_sr_tv||wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pn_pa_ed_sr_tv||wd in pq2_ne_vz_na_ed_ze_tv||
                          wd in pq2_ne_vz_pa_ed_ze_tv||wd in pq2_ne_na_ed_ze_tv||wd in pq2_ne_pa_ed_ze_tv||wd in pq2_pe_na_ed_ze_tv||
                          wd in pq2_pe_pa_ed_ze_tv||wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_tv||wd in pq2_pn_na_ed_ze_tv||
                          wd in pq2_pn_pa_ed_ze_tv||wd in pqn_ne_vz_na_ed_ze_tv||wd in pqn_ne_vz_pa_ed_ze_tv||wd in pqn_ne_na_ed_ze_tv||
                          wd in pqn_ne_pa_ed_ze_tv||wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_pa_ed_ze_tv||wd in pqn_pe_sd_na_ed_ze_tv||
                          wd in pqn_pe_sd_pa_ed_ze_tv||wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_pa_ed_ze_tv||wd in pqs_ne_vz_pa_ed_ze_tv||
                          wd in pqs_ne_pa_ed_ze_tv||wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_tv||wd in pqs_pn_pa_ed_ze_tv||
                          wd in pq2_ne_vz_na_ed_mu_pr||wd in pq2_ne_vz_pa_ed_mu_pr||wd in pq2_ne_na_ed_mu_pr||wd in pq2_ne_pa_ed_mu_pr||
                          wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_pr||
                          wd in pq2_pn_na_ed_mu_pr||wd in pq2_pn_pa_ed_mu_pr||wd in pqn_ne_vz_na_ed_mu_pr||wd in pqn_ne_vz_pa_ed_mu_pr||
                          wd in pqn_ne_na_ed_mu_pr||wd in pqn_ne_pa_ed_mu_pr||wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_pa_ed_mu_pr||
                          wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_pa_ed_mu_pr||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_pa_ed_mu_pr||
                          wd in pqs_ne_vz_pa_ed_mu_pr||wd in pqs_ne_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_pr||wd in pq2_ne_vz_na_ed_sr_pr||wd in pq2_ne_vz_pa_ed_sr_pr||wd in pq2_ne_na_ed_sr_pr||
                          wd in pq2_ne_pa_ed_sr_pr||wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_pr||
                          wd in pq2_pe_sd_pa_ed_sr_pr||wd in pq2_pn_na_ed_sr_pr||wd in pq2_pn_pa_ed_sr_pr||wd in pqn_ne_vz_na_ed_sr_pr||
                          wd in pqn_ne_vz_pa_ed_sr_pr||wd in pqn_ne_na_ed_sr_pr||wd in pqn_ne_pa_ed_sr_pr||wd in pqn_pe_na_ed_sr_pr||
                          wd in pqn_pe_pa_ed_sr_pr||wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_pa_ed_sr_pr||wd in pqn_pn_na_ed_sr_pr||
                          wd in pqn_pn_pa_ed_sr_pr||wd in pqs_ne_vz_pa_ed_sr_pr||wd in pqs_ne_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_pr||
                          wd in pqs_pe_sd_pa_ed_sr_pr||wd in pqs_pn_pa_ed_sr_pr)                                                                   {ret=1} else {ret=0}; return ret}
function prq_mn(n,                                                                                                                                 wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_ne_vz_na_mn_im||wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_na_mn_im||wd in pq2_ne_pa_mn_im||wd in pq2_pe_na_mn_im||
                          wd in pq2_pe_pa_mn_im||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pn_na_mn_im||wd in pq2_pn_pa_mn_im||
                          wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_na_mn_im||wd in pqn_ne_pa_mn_im||wd in pqn_pe_na_mn_im||
                          wd in pqn_pe_pa_mn_im||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pn_na_mn_im||wd in pqn_pn_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_im||wd in pqs_ne_pa_mn_im||wd in pqs_pe_pa_mn_im||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pn_pa_mn_im||
                          wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_pa_mn_ro||wd in pq2_ne_na_mn_ro||wd in pq2_ne_pa_mn_ro||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_pa_mn_ro||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pn_na_mn_ro||wd in pq2_pn_pa_mn_ro||
                          wd in pqn_ne_vz_na_mn_ro||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_na_mn_ro||wd in pqn_ne_pa_mn_ro||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_pa_mn_ro||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pn_na_mn_ro||wd in pqn_pn_pa_mn_ro||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_pa_mn_ro||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pn_pa_mn_ro||
                          wd in pq2_ne_vz_na_mn_da||wd in pq2_ne_vz_pa_mn_da||wd in pq2_ne_na_mn_da||wd in pq2_ne_pa_mn_da||wd in pq2_pe_na_mn_da||
                          wd in pq2_pe_pa_mn_da||wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pn_na_mn_da||wd in pq2_pn_pa_mn_da||
                          wd in pqn_ne_vz_na_mn_da||wd in pqn_ne_vz_pa_mn_da||wd in pqn_ne_na_mn_da||wd in pqn_ne_pa_mn_da||wd in pqn_pe_na_mn_da||
                          wd in pqn_pe_pa_mn_da||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_pa_mn_da||wd in pqn_pn_na_mn_da||wd in pqn_pn_pa_mn_da||
                          wd in pqs_ne_vz_pa_mn_da||wd in pqs_ne_pa_mn_da||wd in pqs_pe_pa_mn_da||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pn_pa_mn_da||
                          wd in pq2_ne_vz_na_mn_tv||wd in pq2_ne_vz_pa_mn_tv||wd in pq2_ne_na_mn_tv||wd in pq2_ne_pa_mn_tv||wd in pq2_pe_na_mn_tv||
                          wd in pq2_pe_pa_mn_tv||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_mn_tv||wd in pq2_pn_na_mn_tv||wd in pq2_pn_pa_mn_tv||
                          wd in pqn_ne_vz_na_mn_tv||wd in pqn_ne_vz_pa_mn_tv||wd in pqn_ne_na_mn_tv||wd in pqn_ne_pa_mn_tv||wd in pqn_pe_na_mn_tv||
                          wd in pqn_pe_pa_mn_tv||wd in pqn_pe_sd_na_mn_tv||wd in pqn_pe_sd_pa_mn_tv||wd in pqn_pn_na_mn_tv||wd in pqn_pn_pa_mn_tv||
                          wd in pqs_ne_vz_pa_mn_tv||wd in pqs_ne_pa_mn_tv||wd in pqs_pe_pa_mn_tv||wd in pqs_pe_sd_pa_mn_tv||wd in pqs_pn_pa_mn_tv) {ret=1} else {ret=0}; return ret}
function prq_sd(n,                                                                                                                                 wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_ro||
                          wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_na_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_ro||
                          wd in pq2_pe_sd_na_ed_sr_tv||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_na_ed_ze_vi||
                          wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_ed_mu_da||
                          wd in pq2_pe_sd_pa_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_tv||wd in pq2_pe_sd_pa_ed_sr_da||
                          wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_pr||wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_vi||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pe_sd_pa_mn_im||
                          wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pe_sd_pa_mn_tv||wd in pqn_pe_sd_na_ed_mu_da||wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_na_ed_mu_pr||
                          wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_na_ed_sr_da||wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_pr||
                          wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_na_ed_ze_dr||wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_tv||
                          wd in pqn_pe_sd_na_ed_ze_vi||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_na_mn_im||wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_na_mn_tv||
                          wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_pr||wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_tv||
                          wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_pr||wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_tv||
                          wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_tv||wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pe_sd_pa_mn_da||
                          wd in pqn_pe_sd_pa_mn_im||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pe_sd_pa_mn_tv||wd in pqs_pe_sd_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_im||
                          wd in pqs_pe_sd_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_sr_da||wd in pqs_pe_sd_pa_ed_sr_im||
                          wd in pqs_pe_sd_pa_ed_sr_pr||wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_im||
                          wd in pqs_pe_sd_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_vi||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pe_sd_pa_mn_ro||
                          wd in pqs_pe_sd_pa_mn_tv)                                                                                                {ret=1} else {ret=0}; return ret}
function prq_any(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_mu||wd in pq2_na_kred_sr||wd in pq2_na_kred_ze||wd in pq2_na_krmn||wd in pq2_ne_na_ed_mu_da||
                          wd in pq2_ne_na_ed_mu_im||wd in pq2_ne_na_ed_mu_pr||wd in pq2_ne_na_ed_mu_ro||wd in pq2_ne_na_ed_mu_tv||wd in pq2_ne_na_ed_sr_da||
                          wd in pq2_ne_na_ed_sr_im||wd in pq2_ne_na_ed_sr_pr||wd in pq2_ne_na_ed_sr_ro||wd in pq2_ne_na_ed_sr_tv||wd in pq2_ne_na_ed_ze_dr||
                          wd in pq2_ne_na_ed_ze_im||wd in pq2_ne_na_ed_ze_tv||wd in pq2_ne_na_ed_ze_vi||wd in pq2_ne_na_mn_da||wd in pq2_ne_na_mn_im||
                          wd in pq2_ne_na_mn_ro||wd in pq2_ne_na_mn_tv||wd in pq2_ne_pa_ed_mu_da||wd in pq2_ne_pa_ed_mu_im||wd in pq2_ne_pa_ed_mu_pr||
                          wd in pq2_ne_pa_ed_mu_ro||wd in pq2_ne_pa_ed_mu_tv||wd in pq2_ne_pa_ed_sr_da||wd in pq2_ne_pa_ed_sr_im||wd in pq2_ne_pa_ed_sr_pr||
                          wd in pq2_ne_pa_ed_sr_ro||wd in pq2_ne_pa_ed_sr_tv||wd in pq2_ne_pa_ed_ze_dr||wd in pq2_ne_pa_ed_ze_im||wd in pq2_ne_pa_ed_ze_tv||
                          wd in pq2_ne_pa_ed_ze_vi||wd in pq2_ne_pa_mn_da||wd in pq2_ne_pa_mn_im||wd in pq2_ne_pa_mn_ro||wd in pq2_ne_pa_mn_tv||
                          wd in pq2_ne_vz_na_ed_mu_da||wd in pq2_ne_vz_na_ed_mu_im||wd in pq2_ne_vz_na_ed_mu_pr||wd in pq2_ne_vz_na_ed_mu_ro||wd in pq2_ne_vz_na_ed_mu_tv||
                          wd in pq2_ne_vz_na_ed_sr_da||wd in pq2_ne_vz_na_ed_sr_im||wd in pq2_ne_vz_na_ed_sr_pr||wd in pq2_ne_vz_na_ed_sr_ro||wd in pq2_ne_vz_na_ed_sr_tv||
                          wd in pq2_ne_vz_na_ed_ze_dr||wd in pq2_ne_vz_na_ed_ze_im||wd in pq2_ne_vz_na_ed_ze_tv||wd in pq2_ne_vz_na_ed_ze_vi||wd in pq2_ne_vz_na_mn_da||
                          wd in pq2_ne_vz_na_mn_im||wd in pq2_ne_vz_na_mn_ro||wd in pq2_ne_vz_na_mn_tv||wd in pq2_ne_vz_pa_ed_mu_da||wd in pq2_ne_vz_pa_ed_mu_im||
                          wd in pq2_ne_vz_pa_ed_mu_pr||wd in pq2_ne_vz_pa_ed_mu_ro||wd in pq2_ne_vz_pa_ed_mu_tv||wd in pq2_ne_vz_pa_ed_sr_da||wd in pq2_ne_vz_pa_ed_sr_im||
                          wd in pq2_ne_vz_pa_ed_sr_pr||wd in pq2_ne_vz_pa_ed_sr_ro||wd in pq2_ne_vz_pa_ed_sr_tv||wd in pq2_ne_vz_pa_ed_ze_dr||wd in pq2_ne_vz_pa_ed_ze_im||
                          wd in pq2_ne_vz_pa_ed_ze_tv||wd in pq2_ne_vz_pa_ed_ze_vi||wd in pq2_ne_vz_pa_mn_da||wd in pq2_ne_vz_pa_mn_im||wd in pq2_ne_vz_pa_mn_ro||
                          wd in pq2_ne_vz_pa_mn_tv||wd in pq2_pa_kred_mu||wd in pq2_pa_kred_sr||wd in pq2_pa_kred_ze||wd in pq2_pa_krmn||
                          wd in pq2_pe_na_ed_mu_da||wd in pq2_pe_na_ed_mu_im||wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_na_ed_mu_tv||
                          wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_na_ed_sr_im||wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_na_ed_sr_tv||
                          wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_na_ed_ze_im||wd in pq2_pe_na_ed_ze_tv||wd in pq2_pe_na_ed_ze_vi||wd in pq2_pe_na_mn_da||
                          wd in pq2_pe_na_mn_im||wd in pq2_pe_na_mn_ro||wd in pq2_pe_na_mn_tv||wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_pa_ed_mu_im||
                          wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_pa_ed_mu_ro||wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_pa_ed_sr_im||
                          wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_pa_ed_sr_ro||wd in pq2_pe_pa_ed_sr_tv||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_pa_ed_ze_im||
                          wd in pq2_pe_pa_ed_ze_tv||wd in pq2_pe_pa_ed_ze_vi||wd in pq2_pe_pa_mn_da||wd in pq2_pe_pa_mn_im||wd in pq2_pe_pa_mn_ro||
                          wd in pq2_pe_pa_mn_tv||wd in pq2_pe_sd_na_ed_mu_da||wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_ro||
                          wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_na_ed_sr_da||wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_ro||
                          wd in pq2_pe_sd_na_ed_sr_tv||wd in pq2_pe_sd_na_ed_ze_dr||wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_na_ed_ze_vi||
                          wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_na_mn_im||wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_ed_mu_da||
                          wd in pq2_pe_sd_pa_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_pr||wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_tv||wd in pq2_pe_sd_pa_ed_sr_da||
                          wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_pr||wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pe_sd_pa_ed_ze_dr||
                          wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_tv||wd in pq2_pe_sd_pa_ed_ze_vi||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pe_sd_pa_mn_im||
                          wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pe_sd_pa_mn_tv||wd in pq2_pn_na_ed_mu_da||wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_na_ed_mu_pr||
                          wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_na_ed_mu_tv||wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_na_ed_sr_pr||
                          wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_na_ed_sr_tv||wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_na_ed_ze_tv||
                          wd in pq2_pn_na_ed_ze_vi||wd in pq2_pn_na_mn_da||wd in pq2_pn_na_mn_im||wd in pq2_pn_na_mn_ro||wd in pq2_pn_na_mn_tv||
                          wd in pq2_pn_pa_ed_mu_da||wd in pq2_pn_pa_ed_mu_im||wd in pq2_pn_pa_ed_mu_pr||wd in pq2_pn_pa_ed_mu_ro||wd in pq2_pn_pa_ed_mu_tv||
                          wd in pq2_pn_pa_ed_sr_da||wd in pq2_pn_pa_ed_sr_im||wd in pq2_pn_pa_ed_sr_pr||wd in pq2_pn_pa_ed_sr_ro||wd in pq2_pn_pa_ed_sr_tv||
                          wd in pq2_pn_pa_ed_ze_dr||wd in pq2_pn_pa_ed_ze_im||wd in pq2_pn_pa_ed_ze_tv||wd in pq2_pn_pa_ed_ze_vi||wd in pq2_pn_pa_mn_da||
                          wd in pq2_pn_pa_mn_im||wd in pq2_pn_pa_mn_ro||wd in pq2_pn_pa_mn_tv||wd in pqn_na_kred_mu||wd in pqn_na_kred_sr||
                          wd in pqn_na_kred_ze||wd in pqn_na_krmn||wd in pqn_ne_na_ed_mu_da||wd in pqn_ne_na_ed_mu_im||wd in pqn_ne_na_ed_mu_pr||
                          wd in pqn_ne_na_ed_mu_ro||wd in pqn_ne_na_ed_mu_tv||wd in pqn_ne_na_ed_sr_da||wd in pqn_ne_na_ed_sr_im||wd in pqn_ne_na_ed_sr_pr||
                          wd in pqn_ne_na_ed_sr_ro||wd in pqn_ne_na_ed_sr_tv||wd in pqn_ne_na_ed_ze_dr||wd in pqn_ne_na_ed_ze_im||wd in pqn_ne_na_ed_ze_tv||
                          wd in pqn_ne_na_ed_ze_vi||wd in pqn_ne_na_mn_da||wd in pqn_ne_na_mn_im||wd in pqn_ne_na_mn_ro||wd in pqn_ne_na_mn_tv||
                          wd in pqn_ne_pa_ed_mu_da||wd in pqn_ne_pa_ed_mu_im||wd in pqn_ne_pa_ed_mu_pr||wd in pqn_ne_pa_ed_mu_ro||wd in pqn_ne_pa_ed_mu_tv||
                          wd in pqn_ne_pa_ed_sr_da||wd in pqn_ne_pa_ed_sr_im||wd in pqn_ne_pa_ed_sr_pr||wd in pqn_ne_pa_ed_sr_ro||wd in pqn_ne_pa_ed_sr_tv||
                          wd in pqn_ne_pa_ed_ze_dr||wd in pqn_ne_pa_ed_ze_im||wd in pqn_ne_pa_ed_ze_tv||wd in pqn_ne_pa_ed_ze_vi||wd in pqn_ne_pa_mn_da||
                          wd in pqn_ne_pa_mn_im||wd in pqn_ne_pa_mn_ro||wd in pqn_ne_pa_mn_tv||wd in pqn_ne_vz_na_ed_mu_da||wd in pqn_ne_vz_na_ed_mu_im||
                          wd in pqn_ne_vz_na_ed_mu_pr||wd in pqn_ne_vz_na_ed_mu_ro||wd in pqn_ne_vz_na_ed_mu_tv||wd in pqn_ne_vz_na_ed_sr_da||wd in pqn_ne_vz_na_ed_sr_im||
                          wd in pqn_ne_vz_na_ed_sr_pr||wd in pqn_ne_vz_na_ed_sr_ro||wd in pqn_ne_vz_na_ed_sr_tv||wd in pqn_ne_vz_na_ed_ze_dr||wd in pqn_ne_vz_na_ed_ze_im||
                          wd in pqn_ne_vz_na_ed_ze_tv||wd in pqn_ne_vz_na_ed_ze_vi||wd in pqn_ne_vz_na_mn_da||wd in pqn_ne_vz_na_mn_im||wd in pqn_ne_vz_na_mn_ro||
                          wd in pqn_ne_vz_na_mn_tv||wd in pqn_ne_vz_pa_ed_mu_da||wd in pqn_ne_vz_pa_ed_mu_im||wd in pqn_ne_vz_pa_ed_mu_pr||wd in pqn_ne_vz_pa_ed_mu_ro||
                          wd in pqn_ne_vz_pa_ed_mu_tv||wd in pqn_ne_vz_pa_ed_sr_da||wd in pqn_ne_vz_pa_ed_sr_im||wd in pqn_ne_vz_pa_ed_sr_pr||wd in pqn_ne_vz_pa_ed_sr_ro||
                          wd in pqn_ne_vz_pa_ed_sr_tv||wd in pqn_ne_vz_pa_ed_ze_dr||wd in pqn_ne_vz_pa_ed_ze_im||wd in pqn_ne_vz_pa_ed_ze_tv||wd in pqn_ne_vz_pa_ed_ze_vi||
                          wd in pqn_ne_vz_pa_mn_da||wd in pqn_ne_vz_pa_mn_im||wd in pqn_ne_vz_pa_mn_ro||wd in pqn_ne_vz_pa_mn_tv||wd in pqn_pa_kred_mu||
                          wd in pqn_pa_kred_sr||wd in pqn_pa_kred_ze||wd in pqn_pa_krmn||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_na_ed_mu_im||
                          wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_na_ed_mu_tv||wd in pqn_pe_na_ed_sr_da||wd in pqn_pe_na_ed_sr_im||
                          wd in pqn_pe_na_ed_sr_pr||wd in pqn_pe_na_ed_sr_ro||wd in pqn_pe_na_ed_sr_tv||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_na_ed_ze_im||
                          wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_na_mn_da||wd in pqn_pe_na_mn_im||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_na_mn_tv||wd in pqn_pe_pa_ed_mu_da||wd in pqn_pe_pa_ed_mu_im||wd in pqn_pe_pa_ed_mu_pr||wd in pqn_pe_pa_ed_mu_ro||
                          wd in pqn_pe_pa_ed_mu_tv||wd in pqn_pe_pa_ed_sr_da||wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_pa_ed_sr_pr||wd in pqn_pe_pa_ed_sr_ro||
                          wd in pqn_pe_pa_ed_sr_tv||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_pa_ed_ze_im||wd in pqn_pe_pa_ed_ze_tv||wd in pqn_pe_pa_ed_ze_vi||
                          wd in pqn_pe_pa_mn_da||wd in pqn_pe_pa_mn_im||wd in pqn_pe_pa_mn_ro||wd in pqn_pe_pa_mn_tv||wd in pqn_pe_sd_na_ed_mu_da||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_na_ed_sr_da||
                          wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_na_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_tv||wd in pqn_pe_sd_na_ed_ze_vi||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_na_mn_im||
                          wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_na_mn_tv||wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_pr||
                          wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_pr||
                          wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_tv||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_tv||
                          wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pe_sd_pa_mn_da||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pe_sd_pa_mn_tv||
                          wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_na_ed_mu_ro||wd in pqn_pn_na_ed_mu_tv||
                          wd in pqn_pn_na_ed_sr_da||wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_na_ed_sr_pr||wd in pqn_pn_na_ed_sr_ro||wd in pqn_pn_na_ed_sr_tv||
                          wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_na_ed_ze_vi||wd in pqn_pn_na_mn_da||
                          wd in pqn_pn_na_mn_im||wd in pqn_pn_na_mn_ro||wd in pqn_pn_na_mn_tv||wd in pqn_pn_pa_ed_mu_da||wd in pqn_pn_pa_ed_mu_im||
                          wd in pqn_pn_pa_ed_mu_pr||wd in pqn_pn_pa_ed_mu_ro||wd in pqn_pn_pa_ed_mu_tv||wd in pqn_pn_pa_ed_sr_da||wd in pqn_pn_pa_ed_sr_im||
                          wd in pqn_pn_pa_ed_sr_pr||wd in pqn_pn_pa_ed_sr_ro||wd in pqn_pn_pa_ed_sr_tv||wd in pqn_pn_pa_ed_ze_dr||wd in pqn_pn_pa_ed_ze_im||
                          wd in pqn_pn_pa_ed_ze_tv||wd in pqn_pn_pa_ed_ze_vi||wd in pqn_pn_pa_mn_da||wd in pqn_pn_pa_mn_im||wd in pqn_pn_pa_mn_ro||
                          wd in pqn_pn_pa_mn_tv||wd in pqs_ne_pa_ed_mu_da||wd in pqs_ne_pa_ed_mu_im||wd in pqs_ne_pa_ed_mu_pr||wd in pqs_ne_pa_ed_mu_ro||
                          wd in pqs_ne_pa_ed_mu_tv||wd in pqs_ne_pa_ed_sr_da||wd in pqs_ne_pa_ed_sr_im||wd in pqs_ne_pa_ed_sr_pr||wd in pqs_ne_pa_ed_sr_ro||
                          wd in pqs_ne_pa_ed_sr_tv||wd in pqs_ne_pa_ed_ze_dr||wd in pqs_ne_pa_ed_ze_im||wd in pqs_ne_pa_ed_ze_tv||wd in pqs_ne_pa_ed_ze_vi||
                          wd in pqs_ne_pa_mn_da||wd in pqs_ne_pa_mn_im||wd in pqs_ne_pa_mn_ro||wd in pqs_ne_pa_mn_tv||wd in pqs_ne_vz_pa_ed_mu_da||
                          wd in pqs_ne_vz_pa_ed_mu_im||wd in pqs_ne_vz_pa_ed_mu_pr||wd in pqs_ne_vz_pa_ed_mu_ro||wd in pqs_ne_vz_pa_ed_mu_tv||wd in pqs_ne_vz_pa_ed_sr_da||
                          wd in pqs_ne_vz_pa_ed_sr_im||wd in pqs_ne_vz_pa_ed_sr_pr||wd in pqs_ne_vz_pa_ed_sr_ro||wd in pqs_ne_vz_pa_ed_sr_tv||wd in pqs_ne_vz_pa_ed_ze_dr||
                          wd in pqs_ne_vz_pa_ed_ze_im||wd in pqs_ne_vz_pa_ed_ze_tv||wd in pqs_ne_vz_pa_ed_ze_vi||wd in pqs_ne_vz_pa_mn_da||wd in pqs_ne_vz_pa_mn_im||
                          wd in pqs_ne_vz_pa_mn_ro||wd in pqs_ne_vz_pa_mn_tv||wd in pqs_pa_kred_mu||wd in pqs_pa_kred_sr||wd in pqs_pa_kred_ze||
                          wd in pqs_pa_krmn||wd in pqs_pe_pa_ed_mu_da||wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_ro||
                          wd in pqs_pe_pa_ed_mu_tv||wd in pqs_pe_pa_ed_sr_da||wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_ro||
                          wd in pqs_pe_pa_ed_sr_tv||wd in pqs_pe_pa_ed_ze_dr||wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_pa_ed_ze_vi||
                          wd in pqs_pe_pa_mn_da||wd in pqs_pe_pa_mn_im||wd in pqs_pe_pa_mn_ro||wd in pqs_pe_pa_mn_tv||wd in pqs_pe_sd_pa_ed_mu_da||
                          wd in pqs_pe_sd_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_pr||wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_sr_da||
                          wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_pr||wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pe_sd_pa_ed_ze_dr||
                          wd in pqs_pe_sd_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_tv||wd in pqs_pe_sd_pa_ed_ze_vi||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pe_sd_pa_mn_im||
                          wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pe_sd_pa_mn_tv||wd in pqs_pn_pa_ed_mu_da||wd in pqs_pn_pa_ed_mu_im||wd in pqs_pn_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_tv||wd in pqs_pn_pa_ed_sr_da||wd in pqs_pn_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_pr||
                          wd in pqs_pn_pa_ed_sr_ro||wd in pqs_pn_pa_ed_sr_tv||wd in pqs_pn_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_im||wd in pqs_pn_pa_ed_ze_tv||
                          wd in pqs_pn_pa_ed_ze_vi||wd in pqs_pn_pa_mn_da||wd in pqs_pn_pa_mn_im||wd in pqs_pn_pa_mn_ro||wd in pqs_pn_pa_mn_tv)         {ret=1} else {ret=0}; return ret}

function prq_pe(n,                                                                                                                                      wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_na_kred_mu||wd in pq2_na_kred_sr||wd in pq2_na_kred_ze||wd in pq2_na_krmn||wd in pq2_pa_kred_mu||
                          wd in pq2_pa_kred_sr||wd in pq2_pa_kred_ze||wd in pq2_pa_krmn||wd in pq2_pe_na_ed_mu_da||wd in pq2_pe_na_ed_mu_im||
                          wd in pq2_pe_na_ed_mu_pr||wd in pq2_pe_na_ed_mu_ro||wd in pq2_pe_na_ed_mu_tv||wd in pq2_pe_na_ed_sr_da||wd in pq2_pe_na_ed_sr_im||
                          wd in pq2_pe_na_ed_sr_pr||wd in pq2_pe_na_ed_sr_ro||wd in pq2_pe_na_ed_sr_tv||wd in pq2_pe_na_ed_ze_dr||wd in pq2_pe_na_ed_ze_im||
                          wd in pq2_pe_na_ed_ze_tv||wd in pq2_pe_na_ed_ze_vi||wd in pq2_pe_na_mn_da||wd in pq2_pe_na_mn_im||wd in pq2_pe_na_mn_ro||
                          wd in pq2_pe_na_mn_tv||wd in pq2_pe_pa_ed_mu_da||wd in pq2_pe_pa_ed_mu_im||wd in pq2_pe_pa_ed_mu_pr||wd in pq2_pe_pa_ed_mu_ro||
                          wd in pq2_pe_pa_ed_mu_tv||wd in pq2_pe_pa_ed_sr_da||wd in pq2_pe_pa_ed_sr_im||wd in pq2_pe_pa_ed_sr_pr||wd in pq2_pe_pa_ed_sr_ro||
                          wd in pq2_pe_pa_ed_sr_tv||wd in pq2_pe_pa_ed_ze_dr||wd in pq2_pe_pa_ed_ze_im||wd in pq2_pe_pa_ed_ze_tv||wd in pq2_pe_pa_ed_ze_vi||
                          wd in pq2_pe_pa_mn_da||wd in pq2_pe_pa_mn_im||wd in pq2_pe_pa_mn_ro||wd in pq2_pe_pa_mn_tv||wd in pq2_pe_sd_na_ed_mu_da||
                          wd in pq2_pe_sd_na_ed_mu_im||wd in pq2_pe_sd_na_ed_mu_pr||wd in pq2_pe_sd_na_ed_mu_ro||wd in pq2_pe_sd_na_ed_mu_tv||wd in pq2_pe_sd_na_ed_sr_da||
                          wd in pq2_pe_sd_na_ed_sr_im||wd in pq2_pe_sd_na_ed_sr_pr||wd in pq2_pe_sd_na_ed_sr_ro||wd in pq2_pe_sd_na_ed_sr_tv||wd in pq2_pe_sd_na_ed_ze_dr||
                          wd in pq2_pe_sd_na_ed_ze_im||wd in pq2_pe_sd_na_ed_ze_tv||wd in pq2_pe_sd_na_ed_ze_vi||wd in pq2_pe_sd_na_mn_da||wd in pq2_pe_sd_na_mn_im||
                          wd in pq2_pe_sd_na_mn_ro||wd in pq2_pe_sd_na_mn_tv||wd in pq2_pe_sd_pa_ed_mu_da||wd in pq2_pe_sd_pa_ed_mu_im||wd in pq2_pe_sd_pa_ed_mu_pr||
                          wd in pq2_pe_sd_pa_ed_mu_ro||wd in pq2_pe_sd_pa_ed_mu_tv||wd in pq2_pe_sd_pa_ed_sr_da||wd in pq2_pe_sd_pa_ed_sr_im||wd in pq2_pe_sd_pa_ed_sr_pr||
                          wd in pq2_pe_sd_pa_ed_sr_ro||wd in pq2_pe_sd_pa_ed_sr_tv||wd in pq2_pe_sd_pa_ed_ze_dr||wd in pq2_pe_sd_pa_ed_ze_im||wd in pq2_pe_sd_pa_ed_ze_tv||
                          wd in pq2_pe_sd_pa_ed_ze_vi||wd in pq2_pe_sd_pa_mn_da||wd in pq2_pe_sd_pa_mn_im||wd in pq2_pe_sd_pa_mn_ro||wd in pq2_pe_sd_pa_mn_tv||
                          wd in pqn_na_kred_mu||wd in pqn_na_kred_sr||wd in pqn_na_kred_ze||wd in pqn_na_krmn||wd in pqn_pa_kred_mu||
                          wd in pqn_pa_kred_sr||wd in pqn_pa_kred_ze||wd in pqn_pa_krmn||wd in pqn_pe_na_ed_mu_da||wd in pqn_pe_na_ed_mu_im||
                          wd in pqn_pe_na_ed_mu_pr||wd in pqn_pe_na_ed_mu_ro||wd in pqn_pe_na_ed_mu_tv||wd in pqn_pe_na_ed_sr_da||wd in pqn_pe_na_ed_sr_im||
                          wd in pqn_pe_na_ed_sr_pr||wd in pqn_pe_na_ed_sr_ro||wd in pqn_pe_na_ed_sr_tv||wd in pqn_pe_na_ed_ze_dr||wd in pqn_pe_na_ed_ze_im||
                          wd in pqn_pe_na_ed_ze_tv||wd in pqn_pe_na_ed_ze_vi||wd in pqn_pe_na_mn_da||wd in pqn_pe_na_mn_im||wd in pqn_pe_na_mn_ro||
                          wd in pqn_pe_na_mn_tv||wd in pqn_pe_pa_ed_mu_da||wd in pqn_pe_pa_ed_mu_im||wd in pqn_pe_pa_ed_mu_pr||wd in pqn_pe_pa_ed_mu_ro||
                          wd in pqn_pe_pa_ed_mu_tv||wd in pqn_pe_pa_ed_sr_da||wd in pqn_pe_pa_ed_sr_im||wd in pqn_pe_pa_ed_sr_pr||wd in pqn_pe_pa_ed_sr_ro||
                          wd in pqn_pe_pa_ed_sr_tv||wd in pqn_pe_pa_ed_ze_dr||wd in pqn_pe_pa_ed_ze_im||wd in pqn_pe_pa_ed_ze_tv||wd in pqn_pe_pa_ed_ze_vi||
                          wd in pqn_pe_pa_mn_da||wd in pqn_pe_pa_mn_im||wd in pqn_pe_pa_mn_ro||wd in pqn_pe_pa_mn_tv||wd in pqn_pe_sd_na_ed_mu_da||
                          wd in pqn_pe_sd_na_ed_mu_im||wd in pqn_pe_sd_na_ed_mu_pr||wd in pqn_pe_sd_na_ed_mu_ro||wd in pqn_pe_sd_na_ed_mu_tv||wd in pqn_pe_sd_na_ed_sr_da||
                          wd in pqn_pe_sd_na_ed_sr_im||wd in pqn_pe_sd_na_ed_sr_pr||wd in pqn_pe_sd_na_ed_sr_ro||wd in pqn_pe_sd_na_ed_sr_tv||wd in pqn_pe_sd_na_ed_ze_dr||
                          wd in pqn_pe_sd_na_ed_ze_im||wd in pqn_pe_sd_na_ed_ze_tv||wd in pqn_pe_sd_na_ed_ze_vi||wd in pqn_pe_sd_na_mn_da||wd in pqn_pe_sd_na_mn_im||
                          wd in pqn_pe_sd_na_mn_ro||wd in pqn_pe_sd_na_mn_tv||wd in pqn_pe_sd_pa_ed_mu_da||wd in pqn_pe_sd_pa_ed_mu_im||wd in pqn_pe_sd_pa_ed_mu_pr||
                          wd in pqn_pe_sd_pa_ed_mu_ro||wd in pqn_pe_sd_pa_ed_mu_tv||wd in pqn_pe_sd_pa_ed_sr_da||wd in pqn_pe_sd_pa_ed_sr_im||wd in pqn_pe_sd_pa_ed_sr_pr||
                          wd in pqn_pe_sd_pa_ed_sr_ro||wd in pqn_pe_sd_pa_ed_sr_tv||wd in pqn_pe_sd_pa_ed_ze_dr||wd in pqn_pe_sd_pa_ed_ze_im||wd in pqn_pe_sd_pa_ed_ze_tv||
                          wd in pqn_pe_sd_pa_ed_ze_vi||wd in pqn_pe_sd_pa_mn_da||wd in pqn_pe_sd_pa_mn_im||wd in pqn_pe_sd_pa_mn_ro||wd in pqn_pe_sd_pa_mn_tv||
                          wd in pqs_pa_kred_mu||wd in pqs_pa_kred_sr||wd in pqs_pa_kred_ze||wd in pqs_pa_krmn||wd in pqs_pe_pa_ed_mu_da||
                          wd in pqs_pe_pa_ed_mu_im||wd in pqs_pe_pa_ed_mu_pr||wd in pqs_pe_pa_ed_mu_ro||wd in pqs_pe_pa_ed_mu_tv||wd in pqs_pe_pa_ed_sr_da||
                          wd in pqs_pe_pa_ed_sr_im||wd in pqs_pe_pa_ed_sr_pr||wd in pqs_pe_pa_ed_sr_ro||wd in pqs_pe_pa_ed_sr_tv||wd in pqs_pe_pa_ed_ze_dr||
                          wd in pqs_pe_pa_ed_ze_im||wd in pqs_pe_pa_ed_ze_tv||wd in pqs_pe_pa_ed_ze_vi||wd in pqs_pe_pa_mn_da||wd in pqs_pe_pa_mn_im||
                          wd in pqs_pe_pa_mn_ro||wd in pqs_pe_pa_mn_tv||wd in pqs_pe_sd_pa_ed_mu_da||wd in pqs_pe_sd_pa_ed_mu_im||wd in pqs_pe_sd_pa_ed_mu_pr||
                          wd in pqs_pe_sd_pa_ed_mu_ro||wd in pqs_pe_sd_pa_ed_mu_tv||wd in pqs_pe_sd_pa_ed_sr_da||wd in pqs_pe_sd_pa_ed_sr_im||wd in pqs_pe_sd_pa_ed_sr_pr||
                          wd in pqs_pe_sd_pa_ed_sr_ro||wd in pqs_pe_sd_pa_ed_sr_tv||wd in pqs_pe_sd_pa_ed_ze_dr||wd in pqs_pe_sd_pa_ed_ze_im||wd in pqs_pe_sd_pa_ed_ze_tv||
                          wd in pqs_pe_sd_pa_ed_ze_vi||wd in pqs_pe_sd_pa_mn_da||wd in pqs_pe_sd_pa_mn_im||wd in pqs_pe_sd_pa_mn_ro||wd in pqs_pe_sd_pa_mn_tv)
                                                                                                                                                     {ret=1} else {ret=0}; return ret}
function prq_pn(n,                                                                                                                                   wd,ret) { if(!wd)wd=lc(n);
                      if (wd in pq2_pn_na_ed_mu_da||wd in pq2_pn_na_ed_mu_im||wd in pq2_pn_na_ed_mu_pr||wd in pq2_pn_na_ed_mu_ro||wd in pq2_pn_na_ed_mu_tv||
                          wd in pq2_pn_na_ed_sr_da||wd in pq2_pn_na_ed_sr_im||wd in pq2_pn_na_ed_sr_pr||wd in pq2_pn_na_ed_sr_ro||wd in pq2_pn_na_ed_sr_tv||
                          wd in pq2_pn_na_ed_ze_dr||wd in pq2_pn_na_ed_ze_im||wd in pq2_pn_na_ed_ze_tv||wd in pq2_pn_na_ed_ze_vi||wd in pq2_pn_na_mn_da||
                          wd in pq2_pn_na_mn_im||wd in pq2_pn_na_mn_ro||wd in pq2_pn_na_mn_tv||wd in pq2_pn_pa_ed_mu_da||wd in pq2_pn_pa_ed_mu_im||
                          wd in pq2_pn_pa_ed_mu_pr||wd in pq2_pn_pa_ed_mu_ro||wd in pq2_pn_pa_ed_mu_tv||wd in pq2_pn_pa_ed_sr_da||wd in pq2_pn_pa_ed_sr_im||
                          wd in pq2_pn_pa_ed_sr_pr||wd in pq2_pn_pa_ed_sr_ro||wd in pq2_pn_pa_ed_sr_tv||wd in pq2_pn_pa_ed_ze_dr||wd in pq2_pn_pa_ed_ze_im||
                          wd in pq2_pn_pa_ed_ze_tv||wd in pq2_pn_pa_ed_ze_vi||wd in pq2_pn_pa_mn_da||wd in pq2_pn_pa_mn_im||wd in pq2_pn_pa_mn_ro||
                          wd in pq2_pn_pa_mn_tv||wd in pqn_pn_na_ed_mu_da||wd in pqn_pn_na_ed_mu_im||wd in pqn_pn_na_ed_mu_pr||wd in pqn_pn_na_ed_mu_ro||
                          wd in pqn_pn_na_ed_mu_tv||wd in pqn_pn_na_ed_sr_da||wd in pqn_pn_na_ed_sr_im||wd in pqn_pn_na_ed_sr_pr||wd in pqn_pn_na_ed_sr_ro||
                          wd in pqn_pn_na_ed_sr_tv||wd in pqn_pn_na_ed_ze_dr||wd in pqn_pn_na_ed_ze_im||wd in pqn_pn_na_ed_ze_tv||wd in pqn_pn_na_ed_ze_vi||
                          wd in pqn_pn_na_mn_da||wd in pqn_pn_na_mn_im||wd in pqn_pn_na_mn_ro||wd in pqn_pn_na_mn_tv||wd in pqn_pn_pa_ed_mu_da||
                          wd in pqn_pn_pa_ed_mu_im||wd in pqn_pn_pa_ed_mu_pr||wd in pqn_pn_pa_ed_mu_ro||wd in pqn_pn_pa_ed_mu_tv||wd in pqn_pn_pa_ed_sr_da||
                          wd in pqn_pn_pa_ed_sr_im||wd in pqn_pn_pa_ed_sr_pr||wd in pqn_pn_pa_ed_sr_ro||wd in pqn_pn_pa_ed_sr_tv||wd in pqn_pn_pa_ed_ze_dr||
                          wd in pqn_pn_pa_ed_ze_im||wd in pqn_pn_pa_ed_ze_tv||wd in pqn_pn_pa_ed_ze_vi||wd in pqn_pn_pa_mn_da||wd in pqn_pn_pa_mn_im||
                          wd in pqn_pn_pa_mn_ro||wd in pqn_pn_pa_mn_tv||wd in pqs_pn_pa_ed_mu_da||wd in pqs_pn_pa_ed_mu_im||wd in pqs_pn_pa_ed_mu_pr||
                          wd in pqs_pn_pa_ed_mu_ro||wd in pqs_pn_pa_ed_mu_tv||wd in pqs_pn_pa_ed_sr_da||wd in pqs_pn_pa_ed_sr_im||wd in pqs_pn_pa_ed_sr_pr||
                          wd in pqs_pn_pa_ed_sr_ro||wd in pqs_pn_pa_ed_sr_tv||wd in pqs_pn_pa_ed_ze_dr||wd in pqs_pn_pa_ed_ze_im||wd in pqs_pn_pa_ed_ze_tv||
                          wd in pqs_pn_pa_ed_ze_vi||wd in pqs_pn_pa_mn_da||wd in pqs_pn_pa_mn_im||wd in pqs_pn_pa_mn_ro||wd in pqs_pn_pa_mn_tv)  {ret=1} else {ret=0}; return ret}



# деепричастия
function deep(n,                                                                                                                                 wd,ret) { if(!wd)wd=lc(n);
                      if (wd in dps_pe_pa||wd in dps_vz_ne_pa||wd in dpn_vz_ne_na||wd in dpn_vz_ne_pa||wd in dpn_pe_na||wd in dps_ne_pa||
                          wd in dps_pn_pa||wd in dpn_ne_na||wd in dpn_pn_na||wd in dpn_pe_pa||wd in dpn_pn_pa||wd in dpn_ne_pa)                  {ret=1} else {ret=0}; return ret}
function deep_ne(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);                                                                                             
                      if (wd in dps_vz_ne_pa||wd in dpn_vz_ne_na||wd in dpn_vz_ne_pa||wd in dps_ne_pa||wd in dpn_ne_na||wd in dpn_ne_pa)               {ret=1} else {ret=0}; return ret}
function deep_pe(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in dps_pe_pa||wd in dpn_pe_na||wd in dpn_pe_pa)                                      {ret=1} else {ret=0}; return ret}
function deep_pn(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in dps_pn_pa||wd in dpn_pn_na||wd in dpn_pn_pa)                                      {ret=1} else {ret=0}; return ret}
function deep_pa(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in dps_pe_pa||wd in dps_vz_ne_pa||wd in dpn_vz_ne_pa||wd in dps_ne_pa||wd in dps_pn_pa||wd in dpn_pe_pa||
                          wd in dpn_pn_pa||wd in dpn_ne_pa)                                                                                      {ret=1} else {ret=0}; return ret}
function deep_na(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in dpn_vz_ne_na||wd in dpn_pe_na||wd in dpn_ne_na||wd in dpn_pn_na)                  {ret=1} else {ret=0}; return ret}
                                                                                                                                                 
# глаголы                                                                                                                                        
function gl_ed(n,                                                                                                                                wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_vz_nepa_edze||wd in gn_vz_nepa_edmu||
                          wd in gn_vz_nepa_edsr||wd in gn_nena_e1||wd in gn_nena_e2||wd in gn_nena_e3||wd in gn_nepa_edze||wd in gn_nepa_edmu||
                          wd in gn_nepa_edsr||wd in gn_pena_e1||wd in gn_pena_e2||wd in gn_pena_e3||wd in gn_pepa_edze||wd in gn_pepa_edmu||
                          wd in gn_pepa_edsr||wd in gn_pnna_e1||wd in gn_pnna_e2||wd in gn_pnna_e3||wd in gn_pnpa_edze||wd in gn_pnpa_edmu||
                          wd in gn_pnpa_edsr||wd in gs_nebu_e1||wd in gs_nebu_e2||wd in gs_nebu_e3||wd in gs_vz_nebu_e1||wd in gs_vz_nebu_e2||
                          wd in gs_vz_nebu_e3||wd in gs_vz_nepa_edze||wd in gs_vz_nepa_edmu||wd in gs_vz_nepa_edsr||wd in gs_nepa_edze||
                          wd in gs_nepa_edmu||wd in gs_nepa_edsr||wd in gs_pebu_e1||wd in gs_pebu_e2||wd in gs_pebu_e3||wd in gs_pepa_edze||
                          wd in gs_pepa_edmu||wd in gs_pepa_edsr||wd in gs_pnbu_e1||wd in gs_pnbu_e2||wd in gs_pnbu_e3||wd in gs_pnpa_edze||
                          wd in gs_pnpa_edmu||wd in gs_pnpa_edsr||wd in g2_pebu_e1||wd in g2_pebu_e2||wd in g2_pebu_e3||wd in g2_pena_e1||
                          wd in g2_pena_e2||wd in g2_pena_e3||wd in g2_pepa_edze||wd in g2_pepa_edmu||wd in g2_pepa_edsr||wd in g2_nebu_e1||
                          wd in g2_nebu_e2||wd in g2_nebu_e3||wd in g2_vz_nebu_e1||wd in g2_vz_nebu_e2||wd in g2_vz_nebu_e3||
                          wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||wd in g2_vz_nepa_edze||wd in g2_vz_nepa_edmu||
                          wd in g2_vz_nepa_edsr||wd in g2_nena_e1||wd in g2_nena_e2||wd in g2_nena_e3||wd in g2_nepa_edze||wd in g2_nepa_edmu||
                          wd in g2_nepa_edsr||wd in g2_pnbu_e1||wd in g2_pnbu_e2||wd in g2_pnbu_e3||wd in g2_pnna_e1||wd in g2_pnna_e2||
                          wd in g2_pnna_e3||wd in g2_pnpa_edze||wd in g2_pnpa_edmu||wd in g2_pnpa_edsr)                                         {ret=1} else {ret=0}; return ret}
function gl_naed(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_nena_e1||wd in gn_nena_e2||wd in gn_nena_e3||
                          wd in gn_pena_e1||wd in gn_pena_e2||wd in gn_pena_e3||wd in gn_pnna_e1||wd in gn_pnna_e2||wd in gn_pnna_e3||
                          wd in g2_pena_e1||wd in g2_pena_e2||wd in g2_pena_e3||wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||
                          wd in g2_nena_e1||wd in g2_nena_e2||wd in g2_nena_e3||wd in g2_pnna_e1||wd in g2_pnna_e2||wd in g2_pnna_e3)           {ret=1} else {ret=0}; return ret}
function gl_naneed(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_nena_e1||wd in gn_nena_e2||wd in gn_nena_e3||
                          wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||wd in g2_nena_e1||wd in g2_nena_e2||wd in g2_nena_e3)  {ret=1} else {ret=0}; return ret}
function gl_paed(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edze||wd in gn_vz_nepa_edmu||wd in gn_vz_nepa_edsr||wd in gn_nepa_edze||wd in gn_nepa_edmu||
                          wd in gn_nepa_edsr||wd in gn_pepa_edze||wd in gn_pepa_edmu||wd in gn_pepa_edsr||wd in gn_pnpa_edze||
                          wd in gn_pnpa_edmu||wd in gn_pnpa_edsr||wd in gs_vz_nepa_edze||wd in gs_vz_nepa_edmu||wd in gs_vz_nepa_edsr||
                          wd in gs_nepa_edze||wd in gs_nepa_edmu||wd in gs_nepa_edsr||wd in gs_pepa_edze||wd in gs_pepa_edmu||
                          wd in gs_pepa_edsr||wd in gs_pnpa_edze||wd in gs_pnpa_edmu||wd in gs_pnpa_edsr||wd in g2_pepa_edze||
                          wd in g2_pepa_edmu||wd in g2_pepa_edsr||wd in g2_vz_nepa_edze||wd in g2_vz_nepa_edmu||wd in g2_vz_nepa_edsr||
                          wd in g2_nepa_edze||wd in g2_nepa_edmu||wd in g2_nepa_edsr||wd in g2_pnpa_edze||wd in g2_pnpa_edmu||
                          wd in g2_pnpa_edsr)                                                                                                   {ret=1} else {ret=0}; return ret}
function gl_paneed(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pepa_edze||wd in gn_pepa_edmu||wd in gn_pepa_edsr||wd in gs_pepa_edze||wd in gs_pepa_edmu||
                          wd in gs_pepa_edsr||wd in g2_pepa_edze||wd in g2_pepa_edmu||wd in g2_pepa_edsr)                                       {ret=1} else {ret=0}; return ret}
function gl_bued(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gs_nebu_e1||wd in gs_nebu_e2||wd in gs_nebu_e3||wd in gs_vz_nebu_e1||wd in gs_vz_nebu_e2||wd in gs_vz_nebu_e3||
                          wd in gs_pebu_e1||wd in gs_pebu_e2||wd in gs_pebu_e3||wd in gs_pnbu_e1||wd in gs_pnbu_e2||wd in gs_pnbu_e3||
                          wd in g2_pebu_e1||wd in g2_pebu_e2||wd in g2_pebu_e3||wd in g2_nebu_e1||wd in g2_nebu_e2||wd in g2_nebu_e3||
                          wd in g2_vz_nebu_e1||wd in g2_vz_nebu_e2||wd in g2_vz_nebu_e3||wd in g2_pnbu_e1||wd in g2_pnbu_e2||wd in g2_pnbu_e3)  {ret=1} else {ret=0}; return ret}
function gl_paedmu(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edmu||wd in gn_nepa_edmu||wd in gn_pepa_edmu||wd in gn_pnpa_edmu||wd in gs_vz_nepa_edmu||
                          wd in gs_nepa_edmu||wd in gs_pepa_edmu||wd in gs_pnpa_edmu||wd in g2_pepa_edmu||wd in g2_vz_nepa_edmu||
                          wd in g2_nepa_edmu||wd in g2_pnpa_edmu)                                                                               {ret=1} else {ret=0}; return ret}
function gl_paedsr(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edsr||wd in gn_nepa_edsr||wd in gn_pepa_edsr||wd in gn_pnpa_edsr||wd in gs_vz_nepa_edsr||
                          wd in gs_nepa_edsr||wd in gs_pepa_edsr||wd in gs_pnpa_edsr||wd in g2_pepa_edsr||wd in g2_vz_nepa_edsr||
                          wd in g2_nepa_edsr||wd in g2_pnpa_edsr)                                                                               {ret=1} else {ret=0}; return ret}
function gl_paedze(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edze||wd in gn_nepa_edze||wd in gn_pepa_edze||wd in gn_pnpa_edze||wd in gs_vz_nepa_edze||
                          wd in gs_nepa_edze||wd in gs_pepa_edze||wd in gs_pnpa_edze||wd in g2_pepa_edze||wd in g2_vz_nepa_edze||
                          wd in g2_nepa_edze||wd in g2_pnpa_edze)                                                                               {ret=1} else {ret=0}; return ret}
function gl_peed(n,       wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pena_e1||wd in gn_pena_e2||wd in gn_pena_e3||wd in gn_pepa_edze||wd in gn_pepa_edmu||wd in gn_pepa_edsr||
                          wd in gs_pebu_e1||wd in gs_pebu_e2||wd in gs_pebu_e3||wd in gs_pepa_edze||wd in gs_pepa_edmu||wd in gs_pepa_edsr||
                          wd in g2_pebu_e1||wd in g2_pebu_e2||wd in g2_pebu_e3||wd in g2_pena_e1||wd in g2_pena_e2||wd in g2_pena_e3||
                          wd in g2_pepa_edze||wd in g2_pepa_edmu||wd in g2_pepa_edsr)                                                           {ret=1} else {ret=0}; return ret}
function gl_pned(n,       wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pnna_e1||wd in gn_pnna_e2||wd in gn_pnna_e3||wd in gn_pnpa_edze||wd in gn_pnpa_edmu||wd in gn_pnpa_edsr||
                          wd in gs_pnbu_e1||wd in gs_pnbu_e2||wd in gs_pnbu_e3||wd in gs_pnpa_edze||wd in gs_pnpa_edmu||wd in gs_pnpa_edsr||
                          wd in g2_pnbu_e1||wd in g2_pnbu_e2||wd in g2_pnbu_e3||wd in g2_pnna_e1||wd in g2_pnna_e2||wd in g2_pnna_e3||
                          wd in g2_pnpa_edze||wd in g2_pnpa_edmu||wd in g2_pnpa_edsr)                                                           {ret=1} else {ret=0}; return ret}
function gl_need(n,       wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_vz_nepa_edze||wd in gn_vz_nepa_edmu||
                          wd in gn_vz_nepa_edsr||wd in gn_nena_e1||wd in gn_nena_e2||wd in gn_nena_e3||wd in gn_nepa_edze||wd in gn_nepa_edmu||
                          wd in gn_nepa_edsr||wd in gs_nebu_e1||wd in gs_nebu_e2||wd in gs_nebu_e3||wd in gs_vz_nebu_e1||wd in gs_vz_nebu_e2||
                          wd in gs_vz_nebu_e3||wd in gs_vz_nepa_edze||wd in gs_vz_nepa_edmu||wd in gs_vz_nepa_edsr||wd in gs_nepa_edze||
                          wd in gs_nepa_edmu||wd in gs_nepa_edsr||wd in g2_nebu_e1||wd in g2_nebu_e2||wd in g2_nebu_e3||wd in g2_vz_nebu_e1||
                          wd in g2_vz_nebu_e2||wd in g2_vz_nebu_e3||wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||
                          wd in g2_vz_nepa_edze||wd in g2_vz_nepa_edmu||wd in g2_vz_nepa_edsr||wd in g2_nena_e1||wd in g2_nena_e2||
                          wd in g2_nena_e3||wd in g2_nepa_edze||wd in g2_nepa_edmu||wd in g2_nepa_edsr)                                         {ret=1} else {ret=0}; return ret}
function gl_in(n,         wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_ne_in||wd in gn_nein||wd in gn_nein_bz||wd in gn_vz_nein_bz||wd in gn_pein||wd in gn_pein_bz||
                          wd in gn_pnin||wd in gs_vz_nein||wd in gs_nein||wd in gs_vz_nein_bz||wd in gs_nein_bz||wd in gs_pein||
                          wd in gs_pein_bz||wd in gs_pnin||wd in g2_pein||wd in g2_vz_nein||wd in g2_nein||wd in g2_pnin)                       {ret=1} else {ret=0}; return ret}
function gl_pein(n,       wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pein||wd in gn_pein_bz||wd in gs_pein||wd in gs_pein_bz||wd in g2_pein)                                      {ret=1} else {ret=0}; return ret}
function gl_pnin(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in gn_pnin||wd in gs_pnin||wd in g2_pnin)                                           {ret=1} else {ret=0}; return ret}
function gl_nein(n,       wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_ne_in||wd in gn_nein||wd in gn_nein_bz||wd in gn_vz_nein_bz||wd in gs_vz_nein||wd in gs_nein||
                          wd in gs_vz_nein_bz||wd in gs_nein_bz||wd in g2_vz_nein||wd in g2_nein)                                               {ret=1} else {ret=0}; return ret}
function gl_vzed(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_vz_nepo_ed||wd in gn_vz_nepa_edze||
                          wd in gn_vz_nepa_edmu||wd in gn_vz_nepa_edsr||wd in gs_vz_nebu_e1||wd in gs_vz_nebu_e2||wd in gs_vz_nebu_e3||
                          wd in gs_vz_nepo_ed||wd in gs_vz_nepa_edze||wd in gs_vz_nepa_edmu||wd in gs_vz_nepa_edsr||wd in g2_vz_nebu_e1||
                          wd in g2_vz_nebu_e2||wd in g2_vz_nebu_e3||wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||
                          wd in g2_vz_nepo_ed||wd in g2_vz_nepa_edze||wd in g2_vz_nepa_edmu||wd in g2_vz_nepa_edsr)                             {ret=1} else {ret=0}; return ret}
function gl_needge(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_e1||wd in gn_vz_nena_e2||wd in gn_vz_nena_e3||wd in gn_nena_e1||wd in gn_nena_e2||wd in gn_nena_e3||
                          wd in gs_nebu_e1||wd in gs_nebu_e2||wd in gs_nebu_e3||wd in gs_vz_nebu_e1||wd in gs_vz_nebu_e2||wd in gs_vz_nebu_e3||
                          wd in g2_nebu_e1||wd in g2_nebu_e2||wd in g2_nebu_e3||wd in g2_vz_nebu_e1||wd in g2_vz_nebu_e2||wd in g2_vz_nebu_e3||
                          wd in g2_vz_nena_e1||wd in g2_vz_nena_e2||wd in g2_vz_nena_e3||wd in g2_nena_e1||wd in g2_nena_e2||wd in g2_nena_e3)  {ret=1} else {ret=0}; return ret}
function gl_peedge(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pena_e1||wd in gn_pena_e2||wd in gn_pena_e3||wd in gs_pebu_e1||wd in gs_pebu_e2||wd in gs_pebu_e3||
                          wd in g2_pebu_e1||wd in g2_pebu_e2||wd in g2_pebu_e3||wd in g2_pena_e1||wd in g2_pena_e2||wd in g2_pena_e3)           {ret=1} else {ret=0}; return ret}
function gl_needmu(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edmu||wd in gn_nepa_edmu||wd in gs_vz_nepa_edmu||wd in gs_nepa_edmu||wd in g2_vz_nepa_edmu||
                          wd in g2_nepa_edmu)                                                                                                   {ret=1} else {ret=0}; return ret}
function gl_peedmu(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pepa_edmu||wd in gs_pepa_edmu||wd in g2_pepa_edmu)                                                           {ret=1} else {ret=0}; return ret}
function gl_needze(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edze||wd in gn_nepa_edze||wd in gs_vz_nepa_edze||wd in gs_nepa_edze||wd in g2_vz_nepa_edze||
                          wd in g2_nepa_edze)                                                                                                   {ret=1} else {ret=0}; return ret}
function gl_peedze(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pepa_edze||wd in gs_pepa_edze||wd in g2_pepa_edze)                                                           {ret=1} else {ret=0}; return ret}
function gl_needsr(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edsr||wd in gn_nepa_edsr||wd in gs_vz_nepa_edsr||wd in gs_nepa_edsr||wd in g2_vz_nepa_edsr||
                          wd in g2_nepa_edsr)                                                                                                   {ret=1} else {ret=0}; return ret}
function gl_peedsr(n,     wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pepa_edsr||wd in gs_pepa_edsr||wd in g2_pepa_edsr)                                                           {ret=1} else {ret=0}; return ret}
function gl_edsr(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_edsr||wd in gn_nepa_edsr||wd in gn_pepa_edsr||wd in gn_pnpa_edsr||wd in gs_vz_nepa_edsr||
                          wd in gs_nepa_edsr||wd in gs_pepa_edsr||wd in gs_pnpa_edsr||wd in g2_pepa_edsr||wd in g2_vz_nepa_edsr||
                          wd in g2_nepa_edsr||wd in g2_pnpa_edsr)                                                                               {ret=1} else {ret=0}; return ret}
function gl_poed(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepo_ed||wd in gn_nepo_ed||wd in gn_pepo_ed||wd in gn_pnpo_ed||wd in gs_vz_nepo_ed||wd in gs_nepo_ed||
                          wd in gs_pepo_ed||wd in gs_pnpo_ed||wd in g2_pepo_ed||wd in g2_vz_nepo_ed||wd in g2_nepo_ed||wd in g2_pnpo_ed)        {ret=1} else {ret=0}; return ret}
function gl_popeed(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gn_pepo_ed||wd in gs_pepo_ed||wd in g2_pepo_ed)                                  {ret=1} else {ret=0}; return ret}
function gl_popned(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gn_pnpo_ed||wd in gs_pnpo_ed||wd in g2_pnpo_ed)                                  {ret=1} else {ret=0}; return ret}
function gl_poneed(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepo_ed||wd in gn_nepo_ed||wd in gs_vz_nepo_ed||wd in gs_nepo_ed||wd in g2_vz_nepo_ed||wd in g2_nepo_ed)  {ret=1} else {ret=0}; return ret}
function gl_bue3(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gs_nebu_e3||wd in gs_vz_nebu_e3||wd in gs_pebu_e3||wd in gs_pnbu_e3||wd in g2_pebu_e3||wd in g2_nebu_e3||
                          wd in g2_vz_nebu_e3||wd in g2_pnbu_e3)                                                                                {ret=1} else {ret=0}; return ret}
function gl_vzmn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_m1||wd in gn_vz_nena_m2||wd in gn_vz_nena_m3||wd in gn_vz_nepa_mn||wd in g2_vz_nena_m1||
                          wd in gs_vz_nebu_m1||wd in gs_vz_nebu_m2||wd in gs_vz_nebu_m3||wd in gs_vz_nepa_mn||wd in g2_vz_nena_m2||
                          wd in g2_vz_nebu_m1||wd in g2_vz_nebu_m2||wd in g2_vz_nebu_m3||wd in g2_vz_nepa_mn||wd in g2_vz_nena_m3)              {ret=1} else {ret=0}; return ret}
function gl_navzmn(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nena_m1||wd in gn_vz_nena_m2||wd in gn_vz_nena_m3||wd in g2_vz_nena_m1||wd in g2_vz_nena_m2||
                         wd in g2_vz_nena_m3)                                                                                                   {ret=1} else {ret=0}; return ret}
function gl_pavzmn(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepa_mn||wd in gs_vz_nepa_mn||wd in g2_vz_nepa_mn)                                                        {ret=1} else {ret=0}; return ret}
function gl_buvzmn(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gs_vz_nebu_m1||wd in gs_vz_nebu_m2||wd in gs_vz_nebu_m3||wd in g2_vz_nebu_m1||wd in g2_vz_nebu_m2||
                          wd in g2_vz_nebu_m3)                                                                                                  {ret=1} else {ret=0}; return ret}
function gl_povzmn(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepo_mn||wd in gs_vz_nepo_mn||wd in g2_vz_nepo_mn)                                                        {ret=1} else {ret=0}; return ret}
function gl_pomn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_nepo_mn||wd in gn_pepo_mn||wd in gn_pnpo_mn||wd in gs_nepo_mn||wd in gs_pepo_mn||wd in gs_pnpo_mn||
                          wd in g2_pepo_mn||wd in g2_nepo_mn||wd in g2_pnpo_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_popemn(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gn_pepo_mn||wd in gs_pepo_mn||wd in g2_pepo_mn)                                  {ret=1} else {ret=0}; return ret}
function gl_popnmn(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gn_pnpo_mn||wd in gs_pnpo_mn||wd in g2_pnpo_mn)                                  {ret=1} else {ret=0}; return ret}
function gl_ponemn(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in gn_nepo_mn||wd in gs_nepo_mn||wd in g2_nepo_mn)                                  {ret=1} else {ret=0}; return ret}
function gl_po(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_vz_nepo_ed||wd in gn_nepo_ed||wd in gn_pepo_ed||wd in gn_pnpo_ed||wd in gs_vz_nepo_ed||wd in gs_nepo_ed||  
                          wd in gs_pepo_ed||wd in gs_pnpo_ed||wd in g2_pepo_ed||wd in g2_vz_nepo_ed||wd in g2_nepo_ed||wd in g2_pnpo_edi||      
                          wd in gn_vz_nepo_mn||wd in gs_vz_nepo_mn||wd in g2_vz_nepo_mn||wd in gn_nepo_mn||wd in gn_pepo_mn||wd in gn_pnpo_mn||
                          wd in gs_nepo_mn||wd in gs_pepo_mn||wd in gs_pnpo_mn||wd in g2_pepo_mn||wd in g2_nepo_mn||wd in g2_pnpo_mn)           {ret=1} else {ret=0}; return ret}
function gl_nemn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_nena_m1||wd in gn_nena_m2||wd in gn_nena_m3||wd in gn_nepa_mn||wd in gs_nebu_m1||wd in gs_nebu_m2||
                          wd in gs_nebu_m3||wd in gs_nepa_mn||wd in g2_nebu_m1||wd in g2_nebu_m2||wd in g2_nebu_m3||wd in g2_nena_m1||
                          wd in g2_nena_m2||wd in g2_nena_m3||wd in g2_nepa_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_pnmn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pnna_m1||wd in gn_pnna_m2||wd in gn_pnna_m3||wd in gn_pnpa_mn||wd in gs_pnbu_m1||wd in gs_pnbu_m2||
                          wd in gs_pnbu_m3||wd in gs_pnpa_mn||wd in g2_pnbu_m1||wd in g2_pnbu_m2||wd in g2_pnbu_m3||wd in g2_pnna_m1||
                          wd in g2_pnna_m2||wd in g2_pnna_m3||wd in g2_pnpa_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_pemn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_pena_m1||wd in gn_pena_m2||wd in gn_pena_m3||wd in gn_pepa_mn||wd in gs_pebu_m1||wd in gs_pebu_m2||
                          wd in gs_pebu_m3||wd in gs_pepa_mn||wd in g2_pebu_m1||wd in g2_pebu_m2||wd in g2_pebu_m3||wd in g2_pena_m1||
                          wd in g2_pena_m2||wd in g2_pena_m3||wd in g2_pepa_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_bum3(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gs_nebu_m3||wd in g2_nebu_m3||wd in gs_pnbu_m3||wd in g2_pnbu_m3||wd in gs_pebu_m3||wd in g2_pebu_m3)           {ret=1} else {ret=0}; return ret}
function gl_mn(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_nena_m1||wd in gn_nena_m2||wd in gn_nena_m3||wd in gn_nepa_mn||wd in gs_nebu_m1||wd in gs_nebu_m2||
                          wd in gs_nebu_m3||wd in gs_nepa_mn||wd in g2_nebu_m1||wd in g2_nebu_m2||wd in g2_nebu_m3||wd in g2_nena_m1||
                          wd in g2_nena_m2||wd in g2_nena_m3||wd in g2_nepa_mn||wd in gn_pnna_m1||wd in gn_pnna_m2||wd in gn_pnna_m3||
                          wd in gn_pnpa_mn||wd in gs_pnbu_m1||wd in gs_pnbu_m2||wd in gs_pnbu_m3||wd in gs_pnpa_mn||wd in g2_pnbu_m1||
                          wd in g2_pnbu_m2||wd in g2_pnbu_m3||wd in g2_pnna_m1||wd in g2_pnna_m2||wd in g2_pnna_m3||wd in g2_pnpa_mn||
                          wd in gn_pena_m1||wd in gn_pena_m2||wd in gn_pena_m3||wd in gn_pepa_mn||wd in gs_pebu_m1||wd in gs_pebu_m2||
                          wd in gs_pebu_m3||wd in gs_pepa_mn||wd in g2_pebu_m1||wd in g2_pebu_m2||wd in g2_pebu_m3||wd in g2_pena_m1||
                          wd in g2_pena_m2||wd in g2_pena_m3||wd in g2_pepa_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_namn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_nena_m1||wd in gn_nena_m2||wd in gn_nena_m3||wd in g2_nena_m1||wd in g2_nena_m2||wd in g2_nena_m3||
                          wd in gn_pnna_m1||wd in gn_pnna_m2||wd in gn_pnna_m3||wd in g2_pnna_m1||wd in g2_pnna_m2||wd in g2_pnna_m3||
                          wd in gn_pena_m1||wd in gn_pena_m2||wd in gn_pena_m3||wd in g2_pena_m1||wd in g2_pena_m2||wd in g2_pena_m3)           {ret=1} else {ret=0}; return ret}
function gl_pamn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gn_nepa_mn||wd in gs_nepa_mn||wd in g2_nepa_mn||wd in gn_pnpa_mn||wd in gs_pnpa_mn||wd in g2_pnpa_mn||
                          wd in gn_pepa_mn||wd in gs_pepa_mn||wd in g2_pepa_mn)                                                                 {ret=1} else {ret=0}; return ret}
function gl_bumn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in gs_nebu_m1||wd in gs_nebu_m2||wd in gs_nebu_m3||wd in g2_nebu_m1||wd in g2_nebu_m2||wd in g2_nebu_m3||
                          wd in gs_pnbu_m1||wd in gs_pnbu_m2||wd in gs_pnbu_m3||wd in g2_pnbu_m1||wd in g2_pnbu_m2||wd in g2_pnbu_m3||
                          wd in gs_pebu_m1||wd in gs_pebu_m2||wd in gs_pebu_m3||wd in g2_pebu_m1||wd in g2_pebu_m2||wd in g2_pebu_m3)           {ret=1} else {ret=0}; return ret}

# существительные
function suw_edmuim(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_im||wd in sw_edob_im||wd in swn_edmu_im||wd in swn_edob_im||wd in swo_edmu_im||wd in swo_edob_im)       {ret=1} else {ret=0}; return ret}
function suw_edmuvi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_vi||wd in sw_edmu_vi||wd in sw_edob_vi||wd in swn_edmu_im||wd in swn_edob_vi||wd in swo_edmu_vi||
                          wd in swo_edob_vi)                                                                                                    {ret=1} else {ret=0}; return ret}
function suw_edmuda(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edob_da||wd in swn_edmu_da||wd in swn_edob_da||wd in swo_edmu_da||wd in swo_edob_da)       {ret=1} else {ret=0}; return ret}
function suw_edmuro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_ro||wd in sw_edob_ro||wd in swn_edmu_ro||wd in swn_edob_ro||wd in swo_edmu_ro||wd in swo_edob_ro)       {ret=1} else {ret=0}; return ret}
function suw_edmutv(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_tv||wd in sw_edob_tv||wd in swn_edmu_tv||wd in swn_edob_tv||wd in swo_edmu_tv||wd in swo_edob_tv)       {ret=1} else {ret=0}; return ret}
function suw_edmupr(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_pr||wd in sw_edob_pr||wd in swn_edmu_pr||wd in swn_edob_pr||wd in swo_edmu_pr||wd in swo_edob_pr)       {ret=1} else {ret=0}; return ret}

function suw_edsrim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in sw_edsr_im||wd in swn_edsr_im||wd in swo_edsr_im)                                {ret=1} else {ret=0}; return ret}
function suw_edsrvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in sw_edsr_vi||wd in swn_edsr_vi||wd in swo_edsr_vi)                                {ret=1} else {ret=0}; return ret}
function suw_edsrda(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edob_da||wd in sw_edsr_da||wd in swn_edob_da||wd in swn_edsr_da||wd in swo_edob_da||wd in swo_edsr_da)       {ret=1} else {ret=0}; return ret}
function suw_edsrro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edob_ro||wd in sw_edsr_ro||wd in swn_edob_ro||wd in swn_edsr_ro||wd in swo_edob_ro||wd in swo_edsr_ro)       {ret=1} else {ret=0}; return ret}
function suw_edsrpr(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edob_pr||wd in sw_edsr_pr||wd in swn_edob_pr||wd in swn_edsr_pr||wd in swo_edob_pr||wd in swo_edsr_pr)       {ret=1} else {ret=0}; return ret}

function suw_edzeim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_im||wd in swo_edze_im||wd in sw_edze_im)                                {ret=1} else {ret=0}; return ret}
function suw_edzevi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_vi||wd in swo_edze_vi||wd in sw_edze_vi)                                {ret=1} else {ret=0}; return ret}
function suw_edzero(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_ro||wd in swo_edze_ro||wd in sw_edze_ro)                                {ret=1} else {ret=0}; return ret}
function suw_edzeda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_da||wd in swo_edze_da||wd in sw_edze_da)                                {ret=1} else {ret=0}; return ret}
function suw_edzetv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_tv||wd in swo_edze_tv||wd in sw_edze_tv)                                {ret=1} else {ret=0}; return ret}
function suw_edzepr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_pr||wd in swo_edze_pr||wd in sw_edze_pr)                                {ret=1} else {ret=0}; return ret}

function suw_edim(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_im||wd in sw_edob_im||wd in sw_edsr_im||wd in sw_edze_im||wd in swn_edmu_im||wd in swn_edob_im||
                          wd in swn_edsr_im||wd in swn_edze_im||wd in swo_edmu_im||wd in swo_edob_im||wd in swo_edsr_im||wd in swo_edze_im)     {ret=1} else {ret=0}; return ret}
function suw_edvi(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_vi||wd in sw_edob_vi||wd in sw_edsr_vi||wd in sw_edze_vi||wd in swn_edmu_im||wd in swn_edob_vi||
                          wd in swn_edsr_vi||wd in swn_edze_vi||wd in swo_edmu_vi||wd in swo_edob_vi||wd in swo_edsr_vi||wd in swo_edze_vi)     {ret=1} else {ret=0}; return ret}
function suw_edro(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_ro||wd in sw_edob_ro||wd in sw_edsr_ro||wd in sw_edze_ro||wd in swn_edmu_ro||wd in swn_edob_ro||
                          wd in swn_edsr_ro||wd in swn_edze_ro||wd in swo_edmu_ro||wd in swo_edob_ro||wd in swo_edsr_ro||wd in swo_edze_ro)     {ret=1} else {ret=0}; return ret}
function suw_edda(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edob_da||wd in sw_edsr_da||wd in sw_edze_da||wd in swn_edmu_da||wd in swn_edob_da||
                          wd in swn_edsr_da||wd in swn_edze_da||wd in swo_edmu_da||wd in swo_edob_da||wd in swo_edsr_da||wd in swo_edze_da)     {ret=1} else {ret=0}; return ret}
function suw_edtv(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_tv||wd in sw_edob_tv||wd in sw_edsr_tv||wd in sw_edze_tv||wd in swn_edmu_tv||wd in swn_edob_tv||
                          wd in swn_edsr_tv||wd in swn_edze_tv||wd in swo_edmu_tv||wd in swo_edob_tv||wd in swo_edsr_tv||wd in swo_edze_tv)     {ret=1} else {ret=0}; return ret}
function suw_edpr(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_pr||wd in sw_edob_pr||wd in sw_edsr_pr||wd in sw_edze_pr||wd in swn_edmu_pr||wd in swn_edob_pr||
                          wd in swn_edsr_pr||wd in swn_edze_pr||wd in swo_edmu_pr||wd in swo_edob_pr||wd in swo_edsr_pr||wd in swo_edze_pr)     {ret=1} else {ret=0}; return ret}
function suw_mnim(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_im||wd in swo_mn_im||wd in sw_mn_im)                                      {ret=1} else {ret=0}; return ret}
function suw_mnvi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_vi||wd in swn_mn_im||wd in swo_mn_ro)                                      {ret=1} else {ret=0}; return ret}
function suw_mnro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_ro||wd in swn_mn_ro||wd in swo_mn_ro)                                      {ret=1} else {ret=0}; return ret}
function suw_mnda(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_da||wd in swn_mn_da||wd in swo_mn_da)                                      {ret=1} else {ret=0}; return ret}
function suw_mntv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_tv||wd in swn_mn_tv||wd in swo_mn_tv)                                      {ret=1} else {ret=0}; return ret}
function suw_mnpr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_pr||wd in swn_mn_pr||wd in swo_mn_pr)                                      {ret=1} else {ret=0}; return ret}
function suw_im(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_im||wd in sw_edob_im||wd in sw_edsr_im||wd in sw_edze_im||wd in swn_edmu_im||wd in swn_edob_im||
                          wd in swn_edsr_im||wd in swn_edze_im||wd in swo_edmu_im||wd in swo_edob_im||wd in swo_edsr_im||wd in swo_edze_im||
                          wd in swn_mn_im||wd in swo_mn_im||wd in sw_mn_im)                                                                     {ret=1} else {ret=0}; return ret}
function suw_vi(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_vi||wd in sw_edob_vi||wd in sw_edsr_vi||wd in sw_edze_vi||wd in swn_edmu_im||wd in swn_edob_vi||
                          wd in swn_edsr_vi||wd in swn_edze_vi||wd in swo_edmu_vi||wd in swo_edob_vi||wd in swo_edsr_vi||wd in swo_edze_vi||
                          wd in sw_mn_vi||wd in swn_mn_im||wd in swo_mn_ro)                                                                     {ret=1} else {ret=0}; return ret}
function suw_ro(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_ro||wd in sw_edob_ro||wd in sw_edsr_ro||wd in sw_edze_ro||wd in swn_edmu_ro||wd in swn_edob_ro||
                          wd in swn_edsr_ro||wd in swn_edze_ro||wd in swo_edmu_ro||wd in swo_edob_ro||wd in swo_edsr_ro||wd in swo_edze_ro||
                          wd in sw_mn_ro||wd in swn_mn_ro||wd in swo_mn_ro)                                                                     {ret=1} else {ret=0}; return ret}
function suw_da(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edob_da||wd in sw_edsr_da||wd in sw_edze_da||wd in swn_edmu_da||wd in swn_edob_da||
                          wd in swn_edsr_da||wd in swn_edze_da||wd in swo_edmu_da||wd in swo_edob_da||wd in swo_edsr_da||wd in swo_edze_da||
                          wd in sw_mn_da||wd in swn_mn_da||wd in swo_mn_da)                                                                     {ret=1} else {ret=0}; return ret}
function suw_tv(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_tv||wd in sw_edob_tv||wd in sw_edsr_tv||wd in sw_edze_tv||wd in swn_edmu_tv||wd in swn_edob_tv||
                          wd in swn_edsr_tv||wd in swn_edze_tv||wd in swo_edmu_tv||wd in swo_edob_tv||wd in swo_edsr_tv||wd in swo_edze_tv||
                          wd in sw_mn_tv||wd in swn_mn_tv||wd in swo_mn_tv)                                                                     {ret=1} else {ret=0}; return ret}
function suw_pr(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_pr||wd in sw_edob_pr||wd in sw_edsr_pr||wd in sw_edze_pr||wd in swn_edmu_pr||wd in swn_edob_pr||
                          wd in swn_edsr_pr||wd in swn_edze_pr||wd in swo_edmu_pr||wd in swo_edob_pr||wd in swo_edsr_pr||wd in swo_edze_pr||
                          wd in sw_mn_pr||wd in swn_mn_pr||wd in swo_mn_pr)                                                                     {ret=1} else {ret=0}; return ret}
function suw_oded(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_da||wd in swo_edmu_im||wd in swo_edmu_ne||wd in swo_edmu_pr||wd in swo_edmu_ro||wd in swo_edmu_tv||
                          wd in swo_edmu_vi||wd in swo_edmu_zv||wd in swo_edob_da||wd in swo_edob_im||wd in swo_edob_ne||wd in swo_edob_pr||
                          wd in swo_edob_ro||wd in swo_edob_tv||wd in swo_edob_vi||wd in swo_edsr_da||wd in swo_edsr_im||wd in swo_edsr_pr||
                          wd in swo_edsr_ro||wd in swo_edsr_tv||wd in swo_edsr_vi||wd in swo_edze_da||wd in swo_edze_im||wd in swo_edze_ne||
                          wd in swo_edze_pr||wd in swo_edze_ro||wd in swo_edze_tv||wd in swo_edze_vi||wd in swo_edze_zv||wd in swo_edsr_ne||
                          wd in swo_edob_zv)                                                                                                    {ret=1} else {ret=0}; return ret}
function suw_odim(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_im||wd in swo_edmu_ne||wd in swo_edob_im||wd in swo_edob_ne||wd in swo_edsr_im||wd in swo_edze_im||
                          wd in swo_edze_ne||wd in swo_mn_im||wd in swo_mn_ne||wd in swo_edsr_ne)                                               {ret=1} else {ret=0}; return ret}
function suw_odvi(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ne||wd in swo_edmu_vi||wd in swo_edob_ne||wd in swo_edob_vi||wd in swo_edsr_vi||wd in swo_edze_ne||
                          wd in swo_edze_vi||wd in swo_mn_im||wd in swo_mn_ne||wd in swo_edsr_ne)                                               {ret=1} else {ret=0}; return ret}
function suw_odro(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ne||wd in swo_edmu_ro||wd in swo_edob_ne||wd in swo_edob_ro||wd in swo_edsr_ro||wd in swo_edze_ne||
                          wd in swo_edze_ro||wd in swo_mn_ro||wd in swo_mn_ne||wd in swo_edsr_ne)                                               {ret=1} else {ret=0}; return ret}
function suw_odda(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_da||wd in swo_edmu_ne||wd in swo_edob_da||wd in swo_edob_ne||wd in swo_edsr_da||wd in swo_edze_da||
                          wd in swo_edze_ne||wd in swo_mn_da||wd in swo_mn_ne||wd in swo_edsr_ne||wd in swo_edsr_ne)                            {ret=1} else {ret=0}; return ret}
function suw_odtv(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ne||wd in swo_edmu_tv||wd in swo_edob_ne||wd in swo_edob_tv||wd in swo_edsr_tv||wd in swo_edze_ne||
                          wd in swo_edze_tv||wd in swo_mn_tv||wd in swo_mn_ne||wd in swo_edsr_ne)                                               {ret=1} else {ret=0}; return ret}
function suw_odpr(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ne||wd in swo_edmu_pr||wd in swo_edob_ne||wd in swo_edob_pr||wd in swo_edsr_pr||wd in swo_edze_ne||
                          wd in swo_edze_pr||wd in swo_mn_pr||wd in swo_mn_ne||wd in swo_edsr_ne)                                               {ret=1} else {ret=0}; return ret}
function suw_odzv(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ne||wd in swo_edmu_zv||wd in swo_edob_ne||wd in swo_edze_ne||wd in swo_edze_zv||wd in swo_edsr_ne||
                          wd in swo_edob_zv)                                                                                                    {ret=1} else {ret=0}; return ret}
function suw_odedim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swo_edmu_im||wd in swo_edob_im||wd in swo_edsr_im||wd in swo_edze_im)            {ret=1} else {ret=0}; return ret}
function suw_odedvi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edob_vi||wd in swo_edsr_vi||wd in swo_edze_vi||wd in swo_edmu_vi||wd in swo_edob_ro||wd in swo_edsr_ro)     {ret=1} else {ret=0}; return ret}
function suw_odedro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_ro||wd in swo_edob_ro||wd in swo_edsr_ro||wd in swo_edze_ro)                                           {ret=1} else {ret=0}; return ret}
function suw_odedda(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_da||wd in swo_edob_da||wd in swo_edsr_da||wd in swo_edze_da)                                           {ret=1} else {ret=0}; return ret}
function suw_odedmuda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in swo_edmu_da||wd in swo_edob_da)                                                  {ret=1} else {ret=0}; return ret}
function suw_odedsrda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in swo_edob_da||wd in swo_edsr_da)                                                  {ret=1} else {ret=0}; return ret}
function suw_odedtv(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_tv||wd in swo_edob_tv||wd in swo_edsr_tv||wd in swo_edze_tv)                                           {ret=1} else {ret=0}; return ret}
function suw_odedpr(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_edmu_pr||wd in swo_edob_pr||wd in swo_edsr_pr||wd in swo_edze_pr)                                           {ret=1} else {ret=0}; return ret}
function suw_odmnvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swo_mn_ro)                                                                       {ret=1} else {ret=0}; return ret}
function suw_odmnim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swo_mn_im||wd in swo_mn_ne)                                                      {ret=1} else {ret=0}; return ret}
function suw_odmn(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swo_mn_da||wd in swo_mn_im||wd in swo_mn_ne||wd in swo_mn_pr||wd in swo_mn_ro||wd in swo_mn_sq||wd in swo_mn_tv){ret=1} else {ret=0}; return ret}
function suw_odmnro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swo_mn_ne||wd in swo_mn_ro)                                                      {ret=1} else {ret=0}; return ret}
function suw_odmnda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swo_mn_da||wd in swo_mn_ne)                                                      {ret=1} else {ret=0}; return ret}
function suw_noed(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edmu_da||wd in swn_edmu_im||wd in swn_edmu_me||wd in swn_edmu_ne||wd in swn_edmu_pr||wd in swn_edmu_pt||
                          wd in swn_edmu_ro||wd in swn_edmu_sq||wd in swn_edmu_tv||wd in swn_edob_da||wd in swn_edob_im||wd in swn_edob_ne||
                          wd in swn_edob_pr||wd in swn_edob_ro||wd in swn_edob_tv||wd in swn_edob_vi||wd in swn_edsr_da||wd in swn_edsr_im||
                          wd in swn_edsr_ne||wd in swn_edsr_pr||wd in swn_edsr_ro||wd in swn_edsr_tv||wd in swn_edsr_vi||wd in swn_edze_da||
                          wd in swn_edze_im||wd in swn_edze_me||wd in swn_edze_ne||wd in swn_edze_pr||wd in swn_edze_ro||wd in swn_edze_tv||
                          wd in swn_edze_vi)                                                                                                    {ret=1} else {ret=0}; return ret}
function suw_noedim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edmu_im||wd in swn_edob_im||wd in swn_edsr_im||wd in swn_edze_im)            {ret=1} else {ret=0}; return ret}
function suw_noedmuim(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edmu_im||wd in swn_edob_im)                                                  {ret=1} else {ret=0}; return ret}
function suw_noedmuda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edmu_da||wd in swn_edob_da||wd in sw_edmu_da||wd in sw_edob_da)              {ret=1} else {ret=0}; return ret}
function suw_noedsrda(n,  wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edsr_da||wd in swn_edob_da||wd in sw_edsr_da||wd in sw_edob_da)              {ret=1} else {ret=0}; return ret}
function suw_noedvi(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edmu_im||wd in swn_edob_im||wd in swn_edob_vi||wd in swn_edsr_im||wd in swn_edsr_vi||wd in swn_edze_im||
                          wd in swn_edze_vi)                                                                                                    {ret=1} else {ret=0}; return ret}
function suw_noedro(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edmu_ro||wd in swn_edob_ro||wd in swn_edsr_ro||wd in swn_edze_ro||wd in sw_edob_ro)                         {ret=1} else {ret=0}; return ret}
function suw_noedtv(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edmu_tv||wd in swn_edob_tv||wd in swn_edsr_tv||wd in swn_edze_tv)                                           {ret=1} else {ret=0}; return ret}
function suw_noedpr(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edmu_pr||wd in swn_edob_pr||wd in swn_edsr_pr||wd in swn_edze_pr)                                           {ret=1} else {ret=0}; return ret}
function suw_nomnim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_im)                                                                       {ret=1} else {ret=0}; return ret}
function suw_nomn(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_mn_da||wd in swn_mn_im||wd in swn_mn_ne||wd in swn_mn_pr||wd in swn_mn_ro||wd in swn_mn_sq||wd in swn_mn_tv){ret=1} else {ret=0}; return ret}
function suw_nomnvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_im||wd in swn_mn_ne)                                                      {ret=1} else {ret=0}; return ret}
function suw_nomnro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_ro||wd in swn_mn_ro)                                                       {ret=1} else {ret=0}; return ret}
function suw_nomntv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_tv)                                                                       {ret=1} else {ret=0}; return ret}
function suw_nomnpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_pr)                                                                       {ret=1} else {ret=0}; return ret}
function suw_edme(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edmu_me||wd in swn_edze_me)                                                  {ret=1} else {ret=0}; return ret}
function suw_edmume(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edmu_me)                                                                     {ret=1} else {ret=0}; return ret}
function suw_edzeme(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in swn_edze_me)                                                                     {ret=1} else {ret=0}; return ret}
function suw_edne(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_ne||wd in sw_edob_ne||wd in swn_edmu_ne||wd in swn_edob_ne||wd in swn_edsr_ne||wd in swn_edze_ne||
                          wd in swo_edmu_ne||wd in swo_edob_ne||wd in swo_edze_ne||wd in swo_edsr_ne)                                           {ret=1} else {ret=0}; return ret}
function suw_edzene(n,                                                                                                                          wd,ret) { if(!wd)wd=lc(n);
                      if (wd in swn_edze_ne||wd in swo_edze_ne||wd in sw_edob_ne||wd in swn_edob_ne)                                            {ret=1} else {ret=0}; return ret}
function suw_mnne(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in sw_mn_ne||wd in swn_mn_ne||wd in swo_mn_ne)                                      {ret=1} else {ret=0}; return ret}
function suw_mnsq(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in swn_mn_sq||wd in swo_mn_sq)                                                      {ret=1} else {ret=0}; return ret}
function suw_ed(n,                                                                                                                              wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edmu_im||wd in sw_edmu_ne||wd in sw_edmu_pr||wd in sw_edmu_ro||wd in sw_edmu_tv||
                          wd in sw_edmu_vi||wd in sw_edob_da||wd in sw_edob_im||wd in sw_edob_ne||wd in sw_edob_pr||wd in sw_edob_ro||
                          wd in sw_edob_tv||wd in sw_edob_vi||wd in sw_edsr_da||wd in sw_edsr_im||wd in sw_edsr_pr||wd in sw_edsr_ro||
                          wd in sw_edsr_tv||wd in sw_edsr_vi||wd in sw_edze_da||wd in sw_edze_im||wd in sw_edze_pr||wd in sw_edze_ro||
                          wd in sw_edze_tv||wd in sw_edze_vi||wd in swn_edmu_da||wd in swn_edmu_im||wd in swn_edmu_me||wd in swn_edmu_ne||
                          wd in swn_edmu_pr||wd in swn_edmu_pt||wd in swn_edmu_ro||wd in swn_edmu_sq||wd in swn_edmu_tv||wd in swn_edob_da||
                          wd in swn_edob_im||wd in swn_edob_ne||wd in swn_edob_pr||wd in swn_edob_ro||wd in swn_edob_tv||wd in swn_edob_vi||
                          wd in swn_edsr_da||wd in swn_edsr_im||wd in swn_edsr_ne||wd in swn_edsr_pr||wd in swn_edsr_ro||wd in swn_edsr_tv||
                          wd in swn_edsr_vi||wd in swn_edze_da||wd in swn_edze_im||wd in swn_edze_me||wd in swn_edze_ne||wd in swn_edze_pr||
                          wd in swn_edze_ro||wd in swn_edze_tv||wd in swn_edze_vi||wd in swo_edmu_da||wd in swo_edmu_im||wd in swo_edmu_ne||
                          wd in swo_edmu_pr||wd in swo_edmu_ro||wd in swo_edmu_tv||wd in swo_edmu_vi||wd in swo_edmu_zv||wd in swo_edob_da||
                          wd in swo_edob_im||wd in swo_edob_ne||wd in swo_edob_pr||wd in swo_edob_ro||wd in swo_edob_tv||wd in swo_edob_vi||
                          wd in swo_edsr_da||wd in swo_edsr_im||wd in swo_edsr_pr||wd in swo_edsr_ro||wd in swo_edsr_tv||wd in swo_edsr_vi||
                          wd in swo_edze_da||wd in swo_edze_im||wd in swo_edze_ne||wd in swo_edze_pr||wd in swo_edze_ro||wd in swo_edze_tv||
                          wd in swo_edze_vi||wd in swo_edze_zv||wd in swo_edsr_ne||wd in swo_edob_zv)                                          {ret=1} else {ret=0}; return ret}
function suw_mu(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edmu_im||wd in sw_edmu_ne||wd in sw_edmu_pr||wd in sw_edmu_ro||wd in sw_edmu_tv||
                          wd in sw_edmu_vi||wd in swn_edmu_da||wd in swn_edmu_im||wd in swn_edmu_me||wd in swn_edmu_ne||wd in swn_edmu_pr||
                          wd in swn_edmu_pt||wd in swn_edmu_ro||wd in swn_edmu_sq||wd in swn_edmu_tv||wd in swo_edmu_da||wd in swo_edmu_im||
                          wd in swo_edmu_ne||wd in swo_edmu_pr||wd in swo_edmu_ro||wd in swo_edmu_tv||wd in swo_edmu_vi||wd in swo_edmu_zv)    {ret=1} else {ret=0}; return ret}
function suw_ze(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edze_da||wd in sw_edze_im||wd in sw_edze_pr||wd in sw_edze_ro||wd in sw_edze_tv||wd in sw_edze_vi||
                          wd in swn_edze_da||wd in swn_edze_im||wd in swn_edze_me||wd in swn_edze_ne||wd in swn_edze_pr||wd in swn_edze_ro||
                          wd in swn_edze_tv||wd in swn_edze_vi||wd in swo_edze_da||wd in swo_edze_im||wd in swo_edze_ne||wd in swo_edze_pr||
                          wd in swo_edze_ro||wd in swo_edze_tv||wd in swo_edze_vi||wd in swo_edze_zv||wd in swo_edob_zv)                       {ret=1} else {ret=0}; return ret}
function suw_sr(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edsr_da||wd in sw_edsr_im||wd in sw_edsr_pr||wd in sw_edsr_ro||wd in sw_edsr_tv||wd in sw_edsr_vi||
                          wd in swn_edsr_da||wd in swn_edsr_im||wd in swn_edsr_ne||wd in swn_edsr_pr||wd in swn_edsr_ro||wd in swn_edsr_tv||
                          wd in swn_edsr_vi||wd in swo_edsr_da||wd in swo_edsr_im||wd in swo_edsr_pr||wd in swo_edsr_ro||wd in swo_edsr_tv||
                          wd in swo_edsr_vi||wd in swo_edsr_ne)                                                                                {ret=1} else {ret=0}; return ret}
function suw_ob(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edob_da||wd in sw_edob_im||wd in sw_edob_ne||wd in sw_edob_pr||wd in sw_edob_ro||wd in sw_edob_tv||
                          wd in sw_edob_vi||wd in swn_edob_da||wd in swn_edob_im||wd in swn_edob_ne||wd in swn_edob_pr||wd in swn_edob_ro||
                          wd in swn_edob_tv||wd in swn_edob_vi||wd in swo_edob_da||wd in swo_edob_im||wd in swo_edob_ne||wd in swo_edob_pr||
                          wd in swo_edob_ro||wd in swo_edob_tv||wd in swo_edob_vi)                                                             {ret=1} else {ret=0}; return ret}
function suw_mn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_mn_da||wd in sw_mn_im||wd in sw_mn_ne||wd in sw_mn_pr||wd in sw_mn_ro||wd in sw_mn_tv||wd in sw_mn_vi||
                          wd in swn_mn_da||wd in swn_mn_im||wd in swn_mn_ne||wd in swn_mn_pr||wd in swn_mn_ro||wd in swn_mn_sq||
                          wd in swn_mn_tv||wd in swo_mn_da||wd in swo_mn_im||wd in swo_mn_ne||wd in swo_mn_pr||wd in swo_mn_ro||
                          wd in swo_mn_sq||wd in swo_mn_tv)                                                                                    {ret=1} else {ret=0}; return ret}
function suw_any(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in sw_edmu_da||wd in sw_edmu_im||wd in sw_edmu_ne||wd in sw_edmu_pr||wd in sw_edmu_ro||wd in sw_edmu_tv||
                          wd in sw_edmu_vi||wd in sw_edob_da||wd in sw_edob_im||wd in sw_edob_ne||wd in sw_edob_pr||wd in sw_edob_ro||
                          wd in sw_edob_tv||wd in sw_edob_vi||wd in sw_edsr_da||wd in sw_edsr_im||wd in sw_edsr_pr||wd in sw_edsr_ro||
                          wd in sw_edsr_tv||wd in sw_edsr_vi||wd in sw_edze_da||wd in sw_edze_im||wd in sw_edze_pr||wd in sw_edze_ro||
                          wd in sw_edze_tv||wd in sw_edze_vi||wd in sw_mn_da||wd in sw_mn_im||wd in sw_mn_ne||wd in sw_mn_pr||wd in sw_mn_ro||
                          wd in sw_mn_tv||wd in sw_mn_vi||wd in swn_edmu_da||wd in swn_edmu_im||wd in swn_edmu_me||wd in swn_edmu_ne||
                          wd in swn_edmu_pr||wd in swn_edmu_pt||wd in swn_edmu_ro||wd in swn_edmu_sq||wd in swn_edmu_tv||wd in swn_edob_da||
                          wd in swn_edob_im||wd in swn_edob_ne||wd in swn_edob_pr||wd in swn_edob_ro||wd in swn_edob_tv||wd in swn_edob_vi||
                          wd in swn_edsr_da||wd in swn_edsr_im||wd in swn_edsr_ne||wd in swn_edsr_pr||wd in swn_edsr_ro||wd in swn_edsr_tv||
                          wd in swn_edsr_vi||wd in swn_edze_da||wd in swn_edze_im||wd in swn_edze_me||wd in swn_edze_ne||wd in swn_edze_pr||
                          wd in swn_edze_ro||wd in swn_edze_tv||wd in swn_edze_vi||wd in swn_mn_da||wd in swn_mn_im||wd in swn_mn_ne||
                          wd in swn_mn_pr||wd in swn_mn_ro||wd in swn_mn_sq||wd in swn_mn_tv||wd in swo_edmu_da||wd in swo_edmu_im||
                          wd in swo_edmu_ne||wd in swo_edmu_pr||wd in swo_edmu_ro||wd in swo_edmu_tv||wd in swo_edmu_vi||wd in swo_edmu_zv||
                          wd in swo_edob_da||wd in swo_edob_im||wd in swo_edob_ne||wd in swo_edob_pr||wd in swo_edob_ro||wd in swo_edob_tv||
                          wd in swo_edob_vi||wd in swo_edsr_da||wd in swo_edsr_im||wd in swo_edsr_pr||wd in swo_edsr_ro||wd in swo_edsr_tv||
                          wd in swo_edsr_vi||wd in swo_edze_da||wd in swo_edze_im||wd in swo_edze_ne||wd in swo_edze_pr||wd in swo_edze_ro||
                          wd in swo_edze_tv||wd in swo_edze_vi||wd in swo_edze_zv||wd in swo_mn_da||wd in swo_mn_im||wd in swo_mn_ne||
                          wd in swo_mn_pr||wd in swo_mn_ro||wd in swo_mn_sq||wd in swo_mn_tv||wd in swo_edsr_ne||wd in swo_edob_zv)             {ret=1} else {ret=0}; return ret}

# Омографы-партитивы: все, абстрактные, газы, еда, жидкости=питьё, сыпучие, твёрдные
function ipa_any(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_any)                                                                        {ret=1} else {ret=0}; return ret}
function ipa_abst(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_abst)                                                                       {ret=1} else {ret=0}; return ret}  
function ipa_gas(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_gas)                                                                        {ret=1} else {ret=0}; return ret}
function ipa_food(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_food)                                                                       {ret=1} else {ret=0}; return ret}
function ipa_liquid(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_liquid)                                                                     {ret=1} else {ret=0}; return ret}
function ipa_loose(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_loose)                                                                      {ret=1} else {ret=0}; return ret}
function ipa_solid(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in ispa_solid)                                                                      {ret=1} else {ret=0}; return ret}

# местоимения
function mest_any(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_da||wd in mst_ed_im||wd in mst_ed_mu||wd in mst_ed_mu_da||wd in mst_ed_mu_im||wd in mst_ed_mu_pr||
                          wd in mst_ed_mu_ro||wd in mst_ed_mu_tv||wd in mst_ed_mu_vi||wd in mst_ed_pr||wd in mst_ed_ro||wd in mst_ed_sr||
                          wd in mst_ed_sr_da||wd in mst_ed_sr_im||wd in mst_ed_sr_pr||wd in mst_ed_sr_ro||wd in mst_ed_sr_tv||
                          wd in mst_ed_sr_vi||wd in mst_ed_tv||wd in mst_ed_vi||wd in mst_ed_ze||wd in mst_ed_ze_da||wd in mst_ed_ze_im||
                          wd in mst_ed_ze_pr||wd in mst_ed_ze_ro||wd in mst_ed_ze_tv||wd in mst_ed_ze_vi||wd in mst_im||wd in mst_ro||
                          wd in mst_da||wd in mst_tv||wd in mst_pr||wd in mst_mn_im||wd in mst_mn_ro||wd in mst_mn_vi||wd in mst_mn_da||
                          wd in mst_mn_pr||wd in mst_mn_tv)                                                                                     {ret=1} else {ret=0}; return ret}
function mest_ed(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_da||wd in mst_ed_im||wd in mst_ed_mu||wd in mst_ed_mu_da||wd in mst_ed_mu_im||wd in mst_ed_mu_pr||
                          wd in mst_ed_mu_ro||wd in mst_ed_mu_tv||wd in mst_ed_mu_vi||wd in mst_ed_pr||wd in mst_ed_ro||wd in mst_ed_sr||
                          wd in mst_ed_sr_da||wd in mst_ed_sr_im||wd in mst_ed_sr_pr||wd in mst_ed_sr_ro||wd in mst_ed_sr_tv||
                          wd in mst_ed_sr_vi||wd in mst_ed_tv||wd in mst_ed_vi||wd in mst_ed_ze||wd in mst_ed_ze_da||wd in mst_ed_ze_im||
                          wd in mst_ed_ze_pr||wd in mst_ed_ze_ro||wd in mst_ed_ze_tv||wd in mst_ed_ze_vi||wd in mst_im||wd in mst_ro||
                          wd in mst_da||wd in mst_tv||wd in mst_pr)                                                                             {ret=1} else {ret=0}; return ret}
function mest_mn(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_mn_im||wd in mst_mn_ro||wd in mst_mn_vi||wd in mst_mn_da||wd in mst_mn_pr||wd in mst_mn_tv)                 {ret=1} else {ret=0}; return ret}
function mest_edmuim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_im||wd in mst_ed_im||wd in mst_im)                                     {ret=1} else {ret=0}; return ret}
function mest_edmuvi(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_vi||wd in mst_ed_mu_ro||wd in mst_mn_ro||wd in mst_ed_vi||wd in mst_vi){ret=1} else {ret=0}; return ret}
function mest_edmuro(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_ro||wd in mst_ed_ro||wd in mst_ro)                                     {ret=1} else {ret=0}; return ret}
function mest_edmuda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_da||wd in mst_ed_da||wd in mst_da)                                     {ret=1} else {ret=0}; return ret}
function mest_edmutv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_tv||wd in mst_ed_tv||wd in mst_tv)                                     {ret=1} else {ret=0}; return ret}
function mest_edmupr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_mu_pr||wd in mst_ed_pr||wd in mst_pr)                                     {ret=1} else {ret=0}; return ret}
function mest_edsrim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_im||wd in mst_ed_sr)                                                   {ret=1} else {ret=0}; return ret}
function mest_edsrvi(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_im||wd in mst_ed_sr_vi||wd in mst_ed_sr_ro||wd in mst_ed_sr)           {ret=1} else {ret=0}; return ret}
function mest_edsrro(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_ro||wd in mst_ed_ro||wd in mst_ro)                                     {ret=1} else {ret=0}; return ret}
function mest_edsrda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_da||wd in mst_ed_da||wd in mst_da)                                     {ret=1} else {ret=0}; return ret}
function mest_edsrtv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_tv||wd in mst_ed_tv||wd in mst_tv)                                     {ret=1} else {ret=0}; return ret}
function mest_edsrpr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_sr_pr||wd in mst_ed_pr||wd in mst_pr)                                     {ret=1} else {ret=0}; return ret}
function mest_edzeim(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_im)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edzevi(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_vi)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edzero(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_ro)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edzeda(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_da)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edzetv(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_tv)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edzepr(n,   wd,ret) { if(!wd)wd=lc(n); if (wd in mst_ed_ze_pr)                                                                    {ret=1} else {ret=0}; return ret}
function mest_edmu(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu||wd in mst_ed_mu_da||wd in mst_ed_mu_im||wd in mst_ed_mu_pr||wd in mst_ed_mu_ro||
                          wd in mst_ed_mu_tv||wd in mst_ed_mu_vi)                                                                               {ret=1} else {ret=0}; return ret}
function mest_edze(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_ze_vi||wd in mst_ed_ze_da||wd in mst_ed_ze_im||wd in mst_ed_ze_pr||wd in mst_ed_ze_ro||
                          wd in mst_ed_ze_tv||wd in mst_ed_ze)                                                                                  {ret=1} else {ret=0}; return ret}
function mest_edsr(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_sr_vi||wd in mst_ed_sr_da||wd in mst_ed_sr_im||wd in mst_ed_sr_pr||wd in mst_ed_sr_ro||
                          wd in mst_ed_sr_tv||wd in mst_ed_sr)                                                                                  {ret=1} else {ret=0}; return ret}
function mest_edim(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_im||wd in mst_ed_ze_im||wd in mst_ed_sr_im||wd in mst_ed_im||wd in mst_im)                            {ret=1} else {ret=0}; return ret}
function mest_edvi(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_vi||wd in mst_ed_sr_vi||wd in mst_ed_vi||wd in mst_ed_ze_vi||wd in mst_vi)                            {ret=1} else {ret=0}; return ret}
function mest_edro(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_ro||wd in mst_ed_sr_ro||wd in mst_ed_ze_ro||wd in mst_ed_ro||wd in mst_ro)                            {ret=1} else {ret=0}; return ret}
function mest_edtv(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_tv||wd in mst_ed_ze_tv||wd in mst_ed_sr_tv||wd in mst_ed_tv||wd in mst_tv)                            {ret=1} else {ret=0}; return ret}
function mest_edda(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_da||wd in mst_ed_ze_da||wd in mst_ed_sr_da||wd in mst_ed_da||wd in mst_da)                            {ret=1} else {ret=0}; return ret}
function mest_edpr(n,                                                                                                                           wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_pr||wd in mst_ed_ze_pr||wd in mst_ed_sr_pr||wd in mst_ed_pr||wd in mst_pr)                            {ret=1} else {ret=0}; return ret}
function mest_im(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_im||wd in mst_ed_ze_im||wd in mst_ed_sr_im||wd in mst_mn_im||wd in mst_ed_mu||wd in mst_ed_ze||
                          wd in mst_ed_im||wd in mst_im)                                                                                        {ret=1} else {ret=0}; return ret}
function mest_vi(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_vi||wd in mst_ed_mu_ro||wd in mst_ed_ze_vi||wd in mst_ed_sr_vi||wd in mst_mn_im||
                          wd in mst_mn_ro||wd in mst_mn_vi||wd in mst_ed_vi||wd in mst_vi)                                                      {ret=1} else {ret=0}; return ret}
function mest_ro(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_ro||wd in mst_ed_ze_ro||wd in mst_ed_sr_ro||wd in mst_mn_ro||wd in mst_ed_ro||wd in mst_ro)           {ret=1} else {ret=0}; return ret}
function mest_da(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_da||wd in mst_ed_ze_da||wd in mst_ed_sr_da||wd in mst_mn_da||wd in mst_ed_da||wd in mst_da)           {ret=1} else {ret=0}; return ret}
function mest_tv(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_tv||wd in mst_ed_ze_tv||wd in mst_ed_sr_tv||wd in mst_mn_tv||wd in mst_ed_tv||wd in mst_tv)           {ret=1} else {ret=0}; return ret}
function mest_pr(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                      if (wd in mst_ed_mu_pr||wd in mst_ed_ze_pr||wd in mst_ed_sr_pr||wd in mst_mn_pr||wd in mst_ed_pr||wd in mst_pr)           {ret=1} else {ret=0}; return ret}
function mest_mnim(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_im)                                                                       {ret=1} else {ret=0}; return ret}
function mest_mnvi(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_im||wd in mst_mn_ro||wd in mst_mn_vi)                                     {ret=1} else {ret=0}; return ret}
function mest_mnro(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_ro)                                                                       {ret=1} else {ret=0}; return ret}
function mest_mnda(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_da)                                                                       {ret=1} else {ret=0}; return ret}
function mest_mntv(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_tv)                                                                       {ret=1} else {ret=0}; return ret}
function mest_mnpr(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in mst_mn_pr)                                                                       {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# наречия                                                                                                                                       
function nar_srav(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_srv)                                                                            {ret=1} else {ret=0}; return ret}
function nar_kaq(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in nr_opka)                                                                           {ret=1} else {ret=0}; return ret}
function nar_spos(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_opsp)                                                                           {ret=1} else {ret=0}; return ret}
function nar_step(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_opst)                                                                           {ret=1} else {ret=0}; return ret}
function nar_vrem(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_obvr)                                                                           {ret=1} else {ret=0}; return ret}
function nar_mest(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_obme||wd in nr_mest)                                                            {ret=1} else {ret=0}; return ret}
function nar_napr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_obna)                                                                           {ret=1} else {ret=0}; return ret}
function nar_priq(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_obpr)                                                                           {ret=1} else {ret=0}; return ret}
function nar_cel(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in nr_obce)                                                                           {ret=1} else {ret=0}; return ret}
function nar_vopr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_vopr)                                                                           {ret=1} else {ret=0}; return ret}
#function nar_pron(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_mest)                                                                           {ret=1} else {ret=0}; return ret}
function nar_prev(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in nr_pv)                                                                             {ret=1} else {ret=0}; return ret}
function nar_nar(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in nr_nar)                                                                            {ret=1} else {ret=0}; return ret}
function nar_any(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                    if (wd in nr_srv||wd in nr_opka||wd in nr_opsp||wd in nr_opst||wd in nr_obvr||wd in nr_obme||wd in nr_mest||wd in nr_obna||
                        wd in nr_obpr||wd in nr_obce||wd in nr_vopr||wd in nr_pv||wd in nr_nar)                                                 {ret=1} else {ret=0}; return ret}

# предлоги
function pre_im(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_im)                                                                           {ret=1} else {ret=0}; return ret}
function pre_vi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_vi)                                                                           {ret=1} else {ret=0}; return ret}
function pre_da(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_da)                                                                           {ret=1} else {ret=0}; return ret}
function pre_pr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_pr)                                                                           {ret=1} else {ret=0}; return ret}
function pre_ro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_ro)                                                                           {ret=1} else {ret=0}; return ret}
function pre_tv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in pred_tv)                                                                           {ret=1} else {ret=0}; return ret}
function pre_any(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in pred_im||wd in pred_vi||wd in pred_da||wd in pred_pr||wd in pred_ro||wd in pred_tv){ret=1} else {ret=0}; return ret}
function pre_s(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in pred_s)                                                                            {ret=1} else {ret=0}; return ret}
function pre_u(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in pred_u)                                                                            {ret=1} else {ret=0}; return ret}

# Одиночные классы
function predik(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in predk)                                                                             {ret=1} else {ret=0}; return ret}
function mezd(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in mzd)                                                                               {ret=1} else {ret=0}; return ret}
function qast(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in qst)                                                                               {ret=1} else {ret=0}; return ret}
function vvod(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in vvodn)                                                                             {ret=1} else {ret=0}; return ret}
function sz(n,          wd,ret) { if(!wd)wd=lc(n); if (wd in soyz)                                                                              {ret=1} else {ret=0}; return ret}
function sz_iili(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_iili)                                                                         {ret=1} else {ret=0}; return ret}
function sz_i(n,        wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_i)                                                                            {ret=1} else {ret=0}; return ret}
function sz_qto(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_qto)                                                                          {ret=1} else {ret=0}; return ret}
function sz_dge(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_gde)                                                                          {ret=1} else {ret=0}; return ret}
function sz_kak(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_kak)                                                                          {ret=1} else {ret=0}; return ret}
function sz_kogda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in soyz_kogda)                                                                        {ret=1} else {ret=0}; return ret}
function titul(n,       wd,ret) { if(!wd)wd=lc(n); if (wd in titl)                                                                              {ret=1} else {ret=0}; return ret}
                                                                                                                                                
# Числительные                                                                                                                                  
function qik_im(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_im||wd in qko_ed_mu_im||wd in qko_ed_sr_im||wd in qko_im||
                                                         wd in qko_ze_im||wd in qko_mn_im)                                                      {ret=1} else {ret=0}; return ret}
function qik_vi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_vi||wd in qko_ed_mu_vi||wd in qko_ed_sr_vi||wd in qko_vi||
                                                         wd in qko_ze_vi||wd in qko_mn_vi)                                                      {ret=1} else {ret=0}; return ret}
function qik_ro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_ro||wd in qko_ed_mu_ro||wd in qko_ed_sr_ro||wd in qko_ro||wd in qko_mn_ro){ret=1} else {ret=0}; return ret}
function qik_da(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_da||wd in qko_ed_mu_da||wd in qko_ed_sr_da||wd in qko_da||wd in qko_mn_da){ret=1} else {ret=0}; return ret}
function qik_tv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_tv||wd in qko_ed_mu_tv||wd in qko_ed_sr_tv||wd in qko_tv||wd in qko_mn_tv){ret=1} else {ret=0}; return ret}
function qik_pr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_pr||wd in qko_ed_mu_pr||wd in qko_ed_sr_pr||wd in qko_pr||wd in qko_mn_pr){ret=1} else {ret=0}; return ret}
function qik_edim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_im||wd in qko_ed_mu_im||wd in qko_ed_sr_im||wd in qko_im)                {ret=1} else {ret=0}; return ret}
function qik_edvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_vi||wd in qko_ed_mu_vi||wd in qko_ed_sr_vi||wd in qko_vi)                {ret=1} else {ret=0}; return ret}
function qik_edro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_ro||wd in qko_ed_mu_ro||wd in qko_ed_sr_ro||wd in qko_ro)                {ret=1} else {ret=0}; return ret}
function qik_edda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_da||wd in qko_ed_mu_da||wd in qko_ed_sr_da||wd in qko_da)                {ret=1} else {ret=0}; return ret}
function qik_edtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_tv||wd in qko_ed_mu_tv||wd in qko_ed_sr_tv||wd in qko_tv)                {ret=1} else {ret=0}; return ret}
function qik_edpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_ed_ze_pr||wd in qko_ed_mu_pr||wd in qko_ed_sr_pr||wd in qko_pr)                {ret=1} else {ret=0}; return ret}
function qik_mnim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_im)                                                                         {ret=1} else {ret=0}; return ret}
function qik_mnvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_vi)                                                                         {ret=1} else {ret=0}; return ret}
function qik_mnro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_ro)                                                                         {ret=1} else {ret=0}; return ret}
function qik_mnda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_da)                                                                         {ret=1} else {ret=0}; return ret}
function qik_mntv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_tv)                                                                         {ret=1} else {ret=0}; return ret}
function qik_mnpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qko_mn_pr)                                                                         {ret=1} else {ret=0}; return ret}
function qip_im(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_im||wd in qpo_ed_mu_im||wd in qpo_ed_sr_im||wd in qpo_mn_im)             {ret=1} else {ret=0}; return ret}
function qip_vi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_vi||wd in qpo_ed_mu_im||wd in qpo_ed_mu_ro||wd in qpo_ed_sr_vi||
                                                         wd in qpo_mn_im||wd in qpo_mn_ro)                                                      {ret=1} else {ret=0}; return ret}
function qip_ro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_ro||wd in qpo_ed_mu_ro||wd in qpo_ed_sr_ro||wd in qpo_mn_ro)             {ret=1} else {ret=0}; return ret}
function qip_da(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_da||wd in qpo_ed_mu_da||wd in qpo_ed_sr_da||wd in qpo_mn_da)             {ret=1} else {ret=0}; return ret}
function qip_tv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_tv||wd in qpo_ed_mu_tv||wd in qpo_ed_sr_tv||wd in qpo_mn_tv)             {ret=1} else {ret=0}; return ret}
function qip_pr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_pr||wd in qpo_ed_mu_pr||wd in qpo_ed_sr_pr||wd in qpo_mn_pr)             {ret=1} else {ret=0}; return ret}
function qip_edim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_im||wd in qpo_ed_mu_im||wd in qpo_ed_sr_im)                              {ret=1} else {ret=0}; return ret}
function qip_edvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_vi||wd in qpo_ed_mu_im||wd in qpo_ed_mu_ro||wd in qpo_ed_sr_vi)          {ret=1} else {ret=0}; return ret}
function qip_edro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_ro||wd in qpo_ed_mu_ro||wd in qpo_ed_sr_ro)                              {ret=1} else {ret=0}; return ret}
function qip_edda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_da||wd in qpo_ed_mu_da||wd in qpo_ed_sr_da)                              {ret=1} else {ret=0}; return ret}
function qip_edtv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_tv||wd in qpo_ed_mu_tv||wd in qpo_ed_sr_tv)                              {ret=1} else {ret=0}; return ret}
function qip_edpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_ed_ze_pr||wd in qpo_ed_mu_pr||wd in qpo_ed_sr_pr)                              {ret=1} else {ret=0}; return ret}
function qip_mnim(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_im)                                                                         {ret=1} else {ret=0}; return ret}
function qip_mnvi(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_im||wd in qpo_mn_ro)                                                        {ret=1} else {ret=0}; return ret}
function qip_mnro(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_ro)                                                                         {ret=1} else {ret=0}; return ret}
function qip_mnda(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_da)                                                                         {ret=1} else {ret=0}; return ret}
function qip_mntv(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_tv)                                                                         {ret=1} else {ret=0}; return ret}
function qip_mnpr(n,    wd,ret) { if(!wd)wd=lc(n); if (wd in qpo_mn_pr)                                                                         {ret=1} else {ret=0}; return ret}
function qin_im(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_im)                                                                            {ret=1} else {ret=0}; return ret}
function qin_vi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_vi)                                                                            {ret=1} else {ret=0}; return ret}
function qin_ro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_ro)                                                                            {ret=1} else {ret=0}; return ret}
function qin_da(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_da)                                                                            {ret=1} else {ret=0}; return ret}
function qin_tv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_tv)                                                                            {ret=1} else {ret=0}; return ret}
function qin_pr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qne_pr)                                                                            {ret=1} else {ret=0}; return ret}
function qis_im(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_ze_im||wd in qso_im||wd in qso_mu_im||wd in qso_sr_im)                         {ret=1} else {ret=0}; return ret}
function qis_vi(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_vi||wd in qso_ze_vi||wd in qso_mu_vi||wd in qso_sr_vi)                         {ret=1} else {ret=0}; return ret}
function qis_ro(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_ze_ro||wd in qso_mu_ro||wd in qso_ro||wd in qso_sr_ro)                         {ret=1} else {ret=0}; return ret}
function qis_da(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_da||wd in qso_ze_da||wd in qso_mu_da||wd in qso_sr_da)                         {ret=1} else {ret=0}; return ret}
function qis_tv(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_ze_tv||wd in qso_mu_tv||wd in qso_sr_tv||wd in qso_tv)                         {ret=1} else {ret=0}; return ret}
function qis_pr(n,      wd,ret) { if(!wd)wd=lc(n); if (wd in qso_ze_pr||wd in qso_mu_pr||wd in qso_pr||wd in qso_sr_pr)                         {ret=1} else {ret=0}; return ret}
function qi_ed(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                    if (wd in qko_ed_mu_da||wd in qko_ed_mu_im||wd in qko_ed_mu_pr||wd in qko_ed_mu_ro||wd in qko_ed_mu_tv||wd in qko_im||
                        wd in qko_ed_mu_vi||wd in qko_ed_sr_da||wd in qko_ed_sr_im||wd in qko_ed_sr_pr||wd in qko_ed_sr_ro||wd in qko_vi||
                        wd in qko_ed_sr_tv||wd in qko_ed_sr_vi||wd in qko_ed_ze_da||wd in qko_ed_ze_im||wd in qko_ed_ze_pr||wd in qko_ro||
                        wd in qko_ed_ze_ro||wd in qko_ed_ze_tv||wd in qko_ed_ze_vi||wd in qpo_ed_mu_da||wd in qpo_ed_mu_im||wd in qko_da||
                        wd in qpo_ed_mu_pr||wd in qpo_ed_mu_ro||wd in qpo_ed_mu_tv||wd in qpo_ed_sr_da||wd in qpo_ed_sr_im||wd in qko_tv||
                        wd in qpo_ed_sr_pr||wd in qpo_ed_sr_ro||wd in qpo_ed_sr_tv||wd in qpo_ed_sr_vi||wd in qpo_ed_ze_da||wd in qko_pr||
                        wd in qpo_ed_ze_im||wd in qpo_ed_ze_pr||wd in qpo_ed_ze_ro||wd in qpo_ed_ze_tv||wd in qpo_ed_ze_vi)                     {ret=1} else {ret=0}; return ret}
function qi_mn(n,                                                                                                                               wd,ret) { if(!wd)wd=lc(n);
                    if (wd in qko_mn_vi||wd in qko_mn_da||wd in qko_mn_im||wd in qko_mn_pr||wd in qko_mn_ro||wd in qko_mn_tv||
                        wd in qpo_mn_im||wd in qpo_mn_ro||wd in qpo_mn_da||wd in qpo_mn_im||wd in qpo_mn_pr||wd in qpo_mn_ro||
                        wd in qpo_mn_tv||wd in qko_ze_im||wd in qko_ze_vi||wd in qne_im||wd in qne_vi||wd in qne_ro||wd in qne_da||
                        wd in qne_tv||wd in qne_pr)                                                                                             {ret=1} else {ret=0}; return ret}

# Обработанные омографы
function ist_any(n,                                                                                                                             wd,ret) { wd=tolower(l[i+n]);
                    if (wd in is_nar_mest||wd in is_nar_napr||wd in is_nar_spos||wd in is_nar_vrem||wd in is_prl_edmuim||
                        wd in is_prl_edmupr||wd in is_prl_edmuvi||wd in is_prl_edsrpr||wd in is_prl_edzeda||wd in is_prl_edzeim||
                        wd in is_prl_edzepr||wd in is_prl_edzero||wd in is_prl_edzetv||wd in is_prl_kred_mu||wd in is_prl_kred_ze||
                        wd in is_prl_krmn||wd in is_suw_edmuda||wd in is_suw_edmuim||wd in is_suw_edmulo||wd in is_suw_edmune||
                        wd in is_suw_edmupa||wd in is_suw_edmupr||wd in is_suw_edmuro||wd in is_suw_edmusq||wd in is_suw_edmutv||
                        wd in is_suw_edmuvi||wd in is_suw_edsrda||wd in is_suw_edsrim||wd in is_suw_edsrne||wd in is_suw_edsrpr||
                        wd in is_suw_edsrro||wd in is_suw_edsrtv||wd in is_suw_edsrvi||wd in is_suw_edsrzv||wd in is_suw_edzeda||
                        wd in is_suw_edzeim||wd in is_suw_edzelo||wd in is_suw_edzepr||wd in is_suw_edzero||wd in is_suw_edzetv||
                        wd in is_suw_edzevi||wd in is_suw_mnda||wd in is_suw_mnim||wd in is_suw_mnpr||wd in is_suw_mnro||
                        wd in is_suw_mnvi||wd in is_suw_edmuro||wd in is_suw_edmuzv||wd in is_suw_edzero)                                       {ret=1} else {ret=0}; return ret}
function ist_nar_mest(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_nar_mest    )                                                         {ret=1} else {ret=0}; return ret}
function ist_nar_napr(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_nar_napr    )                                                         {ret=1} else {ret=0}; return ret}
function ist_nar_spos(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_nar_spos    )                                                         {ret=1} else {ret=0}; return ret}
function ist_nar_vrem(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_nar_vrem    )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edmuim(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edmuim  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edmupr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edmupr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edmuvi(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edmuvi  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edsrpr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edsrpr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edzeda(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edzeda  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edzeim(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edzeim  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edzepr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edzepr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edzero(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edzero  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_edzetv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_edzetv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_kred_mu(n,    wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_kred_mu )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_kred_ze(n,    wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_kred_ze )                                                         {ret=1} else {ret=0}; return ret}
function ist_prl_krmn(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_prl_krmn    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmuda(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuda  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmuim(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuim  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmulo(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmulo  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmune(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmune  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmupa(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmupa  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmupr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmupr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmuro(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuro  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmusq(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmusq  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmutv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmutv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmuvi(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuvi  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edmuzv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuzv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrda(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrda  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrim(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrim  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrne(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrne  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrpr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrpr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrro(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrro  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrtv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrtv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrvi(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrvi  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edsrzv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edsrzv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzeda(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzeda  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzeim(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzeim  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzelo(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzelo  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzepr(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzepr  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzero(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzero  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzetv(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzetv  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_edzevi(n,     wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edzevi  )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_mnda(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_mnda    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_mnim(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_mnim    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_mnpr(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_mnpr    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_mnro(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_mnro    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_mnvi(n,       wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_mnvi    )                                                         {ret=1} else {ret=0}; return ret}
function ist_suw_im(n,   wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuim||wd in is_suw_edsrim||wd in is_suw_edzeim||wd in is_suw_mnim)    {ret=1} else {ret=0}; return ret}
function ist_suw_vi(n,   wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuvi||wd in is_suw_edsrvi||wd in is_suw_edzevi||wd in is_suw_mnvi)    {ret=1} else {ret=0}; return ret}
function ist_suw_ro(n,                                                                                                                          wd,ret) { wd=tolower(l[i+n]);
                    if (wd in is_suw_edmuro||wd in is_suw_edsrro||wd in is_suw_edzero||wd in is_suw_mnro||wd in is_suw_edmuro||                 
                        wd in is_suw_edzero)                                                                                                    {ret=1} else {ret=0}; return ret}
function ist_suw_da(n,  wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmuda||wd in is_suw_edsrda||wd in is_suw_edzeda||wd in is_suw_mnda)     {ret=1} else {ret=0}; return ret}
function ist_suw_tv(n,  wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmutv||wd in is_suw_edsrtv||wd in is_suw_edzetv)                        {ret=1} else {ret=0}; return ret}
function ist_suw_pr(n,  wd,ret) { wd=tolower(l[i+n]); if (wd in is_suw_edmupr||wd in is_suw_edsrpr||wd in is_suw_edzepr||wd in is_suw_mnpr)     {ret=1} else {ret=0}; return ret}

# наречные обороты, wd - заглушка для совместимости
function narph_vrem(n,  wd,                                                                                                                     ret) {
                     if ( qxw(n,"на","минуточку секунду минуту мгновение время ночь день зиму лето осень весну утро вечер")||
                          qxw(n,"в","момент полдень обед")||
                          qxw(n,"в","который очередной","раз")||
                          qxw(n,"в","свое это то","время")||
                          qxw(n,"в","этот тот","момент")||
                          qxw(n,"время","от","времени")||
                          qxw(n,"вчера завтра сегодня позавчера послезавтра","утром днём днем вечером ночью")||
                          qxw(n,"до","сих тех этих","пор")||
                          qxw(n,"как","можно","позже раньше скорее позже быстрее")||
                          qxw(n,"от","веку")||
                          qxw(n,"по","вечерам")||
                          qxw(n,"пока","что же")||
                          qxw(n,"то","и","дело")||
                          qxw(n,"с","утра дня вечера ночи") )                                                                                   {ret=1} else {ret=0}; return ret }
function narph_napr(n,  wd,                                                                                                                     ret) {
                     if ( qxw(n,"в во","все разные","стороны")||
                          qxw(n,"со","всех","направлений сторон")||
                          qxw(n,"как","можно","ближе выше дальше ниже")||
                          qxw(n,"в","сторону")||
                          qxw(n,"перед передо","мной тобой вами нами ним ней ними собой") )                                                     {ret=1} else {ret=0}; return ret }
function narph_priq(n,  wd,                                                                                                                     ret) {
                     if ( qxw(n,"от","боли изумления радости страха удивления")||
                          qxw(n,"по","какой-то","причине" ) )                                                                                   {ret=1} else {ret=0}; return ret }
function narph_kaq(n,   wd,                                                                                                                     ret) {
                     if ( qxw(n,"вовсе","не","нужно обязательно больно")||
                          qxw(n,"и","без","того")||
                          qxw(n,"по","крайней меньшей","мере")||
                          qxw(n,"по","большому","счёту счету счету")||
                          qxw(n,"первым","делом")||
                          qxw(n,"с","натяжкой")||
                          qxw(n,"с","горем","пополам")||
                          qxw(n,"не","нужно обязательно")  )                                                                                    {ret=1} else {ret=0}; return ret }
function narph_spos(n,  wd,                                                                                                                     ret) {
                     if ( qxw(n,"близко","к","сердцу")||
                          qxw(n,"в","два","счета")||
                          qxw(n,"в","общем","и","целом")||
                          qxw(n,"в","клочья прах спешке щепки")||
                          qxw(n,"в","конце","концов")||
                          qxw(n,"в","дикой лютой страшной","спешке")||
                          qxw(n,"в","самом","деле")||
                          qxw(n,"в","точности")||
                          qxw(n,"в","целости","и","сохранности")||
                          qxw(n,"во","весь","опор")||
                          qxw(n,"друг","другу дружке")||
                          qxw(n,"друг","напротив","друга")||
                          qxw(n,"друг","с","другом дружкой")||
                          qxw(n,"душа","в","душу")||
                          qxw(n,"еще","более менее")||
                          qxw(n,"и","так")||
                          qxw(n,"из-под","полы")||
                          qxw(n,"и","так","и","сяк")||
                          qxw(n,"как","две","капли","воды")||
                          qxw(n,"как","две","капли")||
                          qxw(n,"на","веру весу руках горбу")||
                          qxw(n,"на","всех","парах")||
                          qxw(n,"на","скорую","руку")||
                          qxw(n,"по","пятам очереди незнанию")||
                          qxw(n,"под","руку")||
                          qxw(n,"при","том этом")||
                          qxw(n,"рука","об","руку")||
                          qxw(n,"с","ходу тобой собой ней ним ними вами нами мясом корнем грохотом треском помпой трудом")||
                          qxw(n,"со","мной")||
                          qxw(n,"со","всей","дури силы мочи")||
                          qxw(n,"со","всех","ног сил")||
                          qxw(n,"так","и","сяк")||
                          qxw(n,"так","или","иначе") )                                                                                          {ret=1} else {ret=0}; return ret }
function narph_step(n,  wd,                                                                                                                     ret) {
                     if ( qxw(n,"и","вовсе")||
                          qxw(n,"еще","более менее")||
                          qxw(n,"куда","как более менее" )||
                          qxw(n,"на","удивление" )||
                          qxw(n,"не","более менее" ) )                                                                                          {ret=1} else {ret=0}; return ret }

function narph_any(n,wd,  ret) { if ( narph_vrem(n)||narph_spos(n)||narph_kaq(n)||narph_napr(n)||narph_priq(n)||narph_step(n) )                 {ret=1} else {ret=0}; return ret }

# составные "существительные" - обороты
function swc_edtv(n,                                                                                                                            ret) {
                     if ( qxs(n,"друг","другу дружке") )                                                                                        {ret=1} else {ret=0}; return ret }
# частицы
function qast_by(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_by)                                                                            {ret=1} else {ret=0}; return ret}
function qast_cn(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_cn)                                                                            {ret=1} else {ret=0}; return ret}
function qast_po(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_po)                                                                            {ret=1} else {ret=0}; return ret}
function qast_ne(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_ne)                                                                            {ret=1} else {ret=0}; return ret}
function qast_dt(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_dt)                                                                            {ret=1} else {ret=0}; return ret}
function qast_us(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_us)                                                                            {ret=1} else {ret=0}; return ret}
function qast_lm(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_lm)                                                                            {ret=1} else {ret=0}; return ret}
function qast_hy(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_hy)                                                                            {ret=1} else {ret=0}; return ret}
function qast_ro(n,     wd,ret) { if(!wd)wd=lc(n); if (wd in qst_ro)                                                                            {ret=1} else {ret=0}; return ret}

function qast_any(n,                                                                                                                            wd,ret) { if(!wd)wd=lc(n);
                     if (wd in qst_by||wd in qst_cn||wd in qst_po||wd in qst_ne||wd in qst_dt||wd in qst_us||wd in qst_lm||wd in qst_hy)        {ret=1} else {ret=0}; return ret}
function qast_sg(n,                                                                                                                             wd,ret) { if(!wd)wd=lc(n);
                     if (wd in qst_by||wd in qst_cn||wd in qst_po||wd in qst_ne||wd in qst_dt||wd in qst_us||wd in qst_lm)                      {ret=1} else {ret=0}; return ret}

function mqast(n,                                                                                                                               ret) {
                     if ( qxw(n,"вряд едва навряд","ли")||
                          qxw(n,"вот даже ну","и")||
                          qxw(n,"всего едва только","лишь")||
                          qxw(n,"а","вон вот")||
                          qxw(n,"так","и")||
                          qxw(n,"как","раз")||
                          qxw(n,"вовсе далеко отнюдь совсем","не") )                                                                            {ret=1} else {ret=0}; return ret }

function mqast_srav(n,                                                                                                                          ret) {
                     if ( qxw(n,"куда","как")||
                          qxw(n,"гораздо","более менее больше меньше")||
                          qxw(n,"куда еще") )                                                                                                   {ret=1} else {ret=0}; return ret }

function wordbf_(n,   el, ret) { el=lc(n); #_#alt#_# при поиске через массив BF - памяти больше, прироста скорости почти нет
   if(el in BF)  { ret = BF[el] } else {ret=""}; return ret }

function wordbf(n,   el, ret) { el=lc(n); #_#main#_#
  while ( el ) {
   if(el in dpn_ne_na              ) { ret = ret "#" dpn_ne_na              [el]; };
   if(el in dpn_ne_pa              ) { ret = ret "#" dpn_ne_pa              [el]; };
   if(el in dpn_pe_na              ) { ret = ret "#" dpn_pe_na              [el]; };
   if(el in dpn_pe_pa              ) { ret = ret "#" dpn_pe_pa              [el]; };
   if(el in dpn_pn_na              ) { ret = ret "#" dpn_pn_na              [el]; };
   if(el in dpn_pn_pa              ) { ret = ret "#" dpn_pn_pa              [el]; };
   if(el in dpn_vz_ne_na           ) { ret = ret "#" dpn_vz_ne_na           [el]; };
   if(el in dpn_vz_ne_pa           ) { ret = ret "#" dpn_vz_ne_pa           [el]; };
   if(el in dps_ne_pa              ) { ret = ret "#" dps_ne_pa              [el]; };
   if(el in dps_pe_pa              ) { ret = ret "#" dps_pe_pa              [el]; };
   if(el in dps_pn_pa              ) { ret = ret "#" dps_pn_pa              [el]; };
   if(el in dps_vz_ne_pa           ) { ret = ret "#" dps_vz_ne_pa           [el]; };
   if(el in g2_nebu_e1             ) { ret = ret "#" g2_nebu_e1             [el]; };
   if(el in g2_nebu_e2             ) { ret = ret "#" g2_nebu_e2             [el]; };
   if(el in g2_nebu_e3             ) { ret = ret "#" g2_nebu_e3             [el]; };
   if(el in g2_nebu_m1             ) { ret = ret "#" g2_nebu_m1             [el]; };
   if(el in g2_nebu_m2             ) { ret = ret "#" g2_nebu_m2             [el]; };
   if(el in g2_nebu_m3             ) { ret = ret "#" g2_nebu_m3             [el]; };
   if(el in g2_nein                ) { ret = ret "#" g2_nein                [el]; };
   if(el in g2_nena_e1             ) { ret = ret "#" g2_nena_e1             [el]; };
   if(el in g2_nena_e2             ) { ret = ret "#" g2_nena_e2             [el]; };
   if(el in g2_nena_e3             ) { ret = ret "#" g2_nena_e3             [el]; };
   if(el in g2_nena_m1             ) { ret = ret "#" g2_nena_m1             [el]; };
   if(el in g2_nena_m2             ) { ret = ret "#" g2_nena_m2             [el]; };
   if(el in g2_nena_m3             ) { ret = ret "#" g2_nena_m3             [el]; };
   if(el in g2_nepa_edmu           ) { ret = ret "#" g2_nepa_edmu           [el]; };
   if(el in g2_nepa_edsr           ) { ret = ret "#" g2_nepa_edsr           [el]; };
   if(el in g2_nepa_edze           ) { ret = ret "#" g2_nepa_edze           [el]; };
   if(el in g2_nepa_mn             ) { ret = ret "#" g2_nepa_mn             [el]; };
   if(el in g2_nepo_ed             ) { ret = ret "#" g2_nepo_ed             [el]; };
   if(el in g2_nepo_mn             ) { ret = ret "#" g2_nepo_mn             [el]; };
   if(el in g2_pebu_e1             ) { ret = ret "#" g2_pebu_e1             [el]; };
   if(el in g2_pebu_e2             ) { ret = ret "#" g2_pebu_e2             [el]; };
   if(el in g2_pebu_e3             ) { ret = ret "#" g2_pebu_e3             [el]; };
   if(el in g2_pebu_m1             ) { ret = ret "#" g2_pebu_m1             [el]; };
   if(el in g2_pebu_m2             ) { ret = ret "#" g2_pebu_m2             [el]; };
   if(el in g2_pebu_m3             ) { ret = ret "#" g2_pebu_m3             [el]; };
   if(el in g2_pein                ) { ret = ret "#" g2_pein                [el]; };
   if(el in g2_pena_e1             ) { ret = ret "#" g2_pena_e1             [el]; };
   if(el in g2_pena_e2             ) { ret = ret "#" g2_pena_e2             [el]; };
   if(el in g2_pena_e3             ) { ret = ret "#" g2_pena_e3             [el]; };
   if(el in g2_pena_m1             ) { ret = ret "#" g2_pena_m1             [el]; };
   if(el in g2_pena_m2             ) { ret = ret "#" g2_pena_m2             [el]; };
   if(el in g2_pena_m3             ) { ret = ret "#" g2_pena_m3             [el]; };
   if(el in g2_pepa_edmu           ) { ret = ret "#" g2_pepa_edmu           [el]; };
   if(el in g2_pepa_edsr           ) { ret = ret "#" g2_pepa_edsr           [el]; };
   if(el in g2_pepa_edze           ) { ret = ret "#" g2_pepa_edze           [el]; };
   if(el in g2_pepa_mn             ) { ret = ret "#" g2_pepa_mn             [el]; };
   if(el in g2_pepo_ed             ) { ret = ret "#" g2_pepo_ed             [el]; };
   if(el in g2_pepo_mn             ) { ret = ret "#" g2_pepo_mn             [el]; };
   if(el in g2_pnbu_e1             ) { ret = ret "#" g2_pnbu_e1             [el]; };
   if(el in g2_pnbu_e2             ) { ret = ret "#" g2_pnbu_e2             [el]; };
   if(el in g2_pnbu_e3             ) { ret = ret "#" g2_pnbu_e3             [el]; };
   if(el in g2_pnbu_m1             ) { ret = ret "#" g2_pnbu_m1             [el]; };
   if(el in g2_pnbu_m2             ) { ret = ret "#" g2_pnbu_m2             [el]; };
   if(el in g2_pnbu_m3             ) { ret = ret "#" g2_pnbu_m3             [el]; };
   if(el in g2_pnin                ) { ret = ret "#" g2_pnin                [el]; };
   if(el in g2_pnna_e1             ) { ret = ret "#" g2_pnna_e1             [el]; };
   if(el in g2_pnna_e2             ) { ret = ret "#" g2_pnna_e2             [el]; };
   if(el in g2_pnna_e3             ) { ret = ret "#" g2_pnna_e3             [el]; };
   if(el in g2_pnna_m1             ) { ret = ret "#" g2_pnna_m1             [el]; };
   if(el in g2_pnna_m2             ) { ret = ret "#" g2_pnna_m2             [el]; };
   if(el in g2_pnna_m3             ) { ret = ret "#" g2_pnna_m3             [el]; };
   if(el in g2_pnpa_edmu           ) { ret = ret "#" g2_pnpa_edmu           [el]; };
   if(el in g2_pnpa_edsr           ) { ret = ret "#" g2_pnpa_edsr           [el]; };
   if(el in g2_pnpa_edze           ) { ret = ret "#" g2_pnpa_edze           [el]; };
   if(el in g2_pnpa_mn             ) { ret = ret "#" g2_pnpa_mn             [el]; };
   if(el in g2_pnpo_ed             ) { ret = ret "#" g2_pnpo_ed             [el]; };
   if(el in g2_pnpo_mn             ) { ret = ret "#" g2_pnpo_mn             [el]; };
   if(el in g2_vz_nebu_e1          ) { ret = ret "#" g2_vz_nebu_e1          [el]; };
   if(el in g2_vz_nebu_e2          ) { ret = ret "#" g2_vz_nebu_e2          [el]; };
   if(el in g2_vz_nebu_e3          ) { ret = ret "#" g2_vz_nebu_e3          [el]; };
   if(el in g2_vz_nebu_m1          ) { ret = ret "#" g2_vz_nebu_m1          [el]; };
   if(el in g2_vz_nebu_m2          ) { ret = ret "#" g2_vz_nebu_m2          [el]; };
   if(el in g2_vz_nebu_m3          ) { ret = ret "#" g2_vz_nebu_m3          [el]; };
   if(el in g2_vz_nein             ) { ret = ret "#" g2_vz_nein             [el]; };
   if(el in g2_vz_nena_e1          ) { ret = ret "#" g2_vz_nena_e1          [el]; };
   if(el in g2_vz_nena_e2          ) { ret = ret "#" g2_vz_nena_e2          [el]; };
   if(el in g2_vz_nena_e3          ) { ret = ret "#" g2_vz_nena_e3          [el]; };
   if(el in g2_vz_nena_m1          ) { ret = ret "#" g2_vz_nena_m1          [el]; };
   if(el in g2_vz_nena_m2          ) { ret = ret "#" g2_vz_nena_m2          [el]; };
   if(el in g2_vz_nena_m3          ) { ret = ret "#" g2_vz_nena_m3          [el]; };
   if(el in g2_vz_nepa_edmu        ) { ret = ret "#" g2_vz_nepa_edmu        [el]; };
   if(el in g2_vz_nepa_edsr        ) { ret = ret "#" g2_vz_nepa_edsr        [el]; };
   if(el in g2_vz_nepa_edze        ) { ret = ret "#" g2_vz_nepa_edze        [el]; };
   if(el in g2_vz_nepa_mn          ) { ret = ret "#" g2_vz_nepa_mn          [el]; };
   if(el in g2_vz_nepo_ed          ) { ret = ret "#" g2_vz_nepo_ed          [el]; };
   if(el in g2_vz_nepo_mn          ) { ret = ret "#" g2_vz_nepo_mn          [el]; };
   if(el in gn_nein                ) { ret = ret "#" gn_nein                [el]; };
   if(el in gn_nein_bz             ) { ret = ret "#" gn_nein_bz             [el]; };
   if(el in gn_nena_e1             ) { ret = ret "#" gn_nena_e1             [el]; };
   if(el in gn_nena_e2             ) { ret = ret "#" gn_nena_e2             [el]; };
   if(el in gn_nena_e3             ) { ret = ret "#" gn_nena_e3             [el]; };
   if(el in gn_nena_m1             ) { ret = ret "#" gn_nena_m1             [el]; };
   if(el in gn_nena_m2             ) { ret = ret "#" gn_nena_m2             [el]; };
   if(el in gn_nena_m3             ) { ret = ret "#" gn_nena_m3             [el]; };
   if(el in gn_nepa_edmu           ) { ret = ret "#" gn_nepa_edmu           [el]; };
   if(el in gn_nepa_edsr           ) { ret = ret "#" gn_nepa_edsr           [el]; };
   if(el in gn_nepa_edze           ) { ret = ret "#" gn_nepa_edze           [el]; };
   if(el in gn_nepa_mn             ) { ret = ret "#" gn_nepa_mn             [el]; };
   if(el in gn_nepo_ed             ) { ret = ret "#" gn_nepo_ed             [el]; };
   if(el in gn_nepo_mn             ) { ret = ret "#" gn_nepo_mn             [el]; };
   if(el in gn_pein                ) { ret = ret "#" gn_pein                [el]; };
   if(el in gn_pein_bz             ) { ret = ret "#" gn_pein_bz             [el]; };
   if(el in gn_pena_e1             ) { ret = ret "#" gn_pena_e1             [el]; };
   if(el in gn_pena_e2             ) { ret = ret "#" gn_pena_e2             [el]; };
   if(el in gn_pena_e3             ) { ret = ret "#" gn_pena_e3             [el]; };
   if(el in gn_pena_m1             ) { ret = ret "#" gn_pena_m1             [el]; };
   if(el in gn_pena_m2             ) { ret = ret "#" gn_pena_m2             [el]; };
   if(el in gn_pena_m3             ) { ret = ret "#" gn_pena_m3             [el]; };
   if(el in gn_pepa_edmu           ) { ret = ret "#" gn_pepa_edmu           [el]; };
   if(el in gn_pepa_edsr           ) { ret = ret "#" gn_pepa_edsr           [el]; };
   if(el in gn_pepa_edze           ) { ret = ret "#" gn_pepa_edze           [el]; };
   if(el in gn_pepa_mn             ) { ret = ret "#" gn_pepa_mn             [el]; };
   if(el in gn_pepo_ed             ) { ret = ret "#" gn_pepo_ed             [el]; };
   if(el in gn_pepo_mn             ) { ret = ret "#" gn_pepo_mn             [el]; };
   if(el in gn_pnin                ) { ret = ret "#" gn_pnin                [el]; };
   if(el in gn_pnna_e1             ) { ret = ret "#" gn_pnna_e1             [el]; };
   if(el in gn_pnna_e2             ) { ret = ret "#" gn_pnna_e2             [el]; };
   if(el in gn_pnna_e3             ) { ret = ret "#" gn_pnna_e3             [el]; };
   if(el in gn_pnna_m1             ) { ret = ret "#" gn_pnna_m1             [el]; };
   if(el in gn_pnna_m2             ) { ret = ret "#" gn_pnna_m2             [el]; };
   if(el in gn_pnna_m3             ) { ret = ret "#" gn_pnna_m3             [el]; };
   if(el in gn_pnpa_edmu           ) { ret = ret "#" gn_pnpa_edmu           [el]; };
   if(el in gn_pnpa_edsr           ) { ret = ret "#" gn_pnpa_edsr           [el]; };
   if(el in gn_pnpa_edze           ) { ret = ret "#" gn_pnpa_edze           [el]; };
   if(el in gn_pnpa_mn             ) { ret = ret "#" gn_pnpa_mn             [el]; };
   if(el in gn_pnpo_ed             ) { ret = ret "#" gn_pnpo_ed             [el]; };
   if(el in gn_pnpo_mn             ) { ret = ret "#" gn_pnpo_mn             [el]; };
   if(el in gn_vz_ne_in            ) { ret = ret "#" gn_vz_ne_in            [el]; };
   if(el in gn_vz_nein_bz          ) { ret = ret "#" gn_vz_nein_bz          [el]; };
   if(el in gn_vz_nena_e1          ) { ret = ret "#" gn_vz_nena_e1          [el]; };
   if(el in gn_vz_nena_e2          ) { ret = ret "#" gn_vz_nena_e2          [el]; };
   if(el in gn_vz_nena_e3          ) { ret = ret "#" gn_vz_nena_e3          [el]; };
   if(el in gn_vz_nena_m1          ) { ret = ret "#" gn_vz_nena_m1          [el]; };
   if(el in gn_vz_nena_m2          ) { ret = ret "#" gn_vz_nena_m2          [el]; };
   if(el in gn_vz_nena_m3          ) { ret = ret "#" gn_vz_nena_m3          [el]; };
   if(el in gn_vz_nepa_edmu        ) { ret = ret "#" gn_vz_nepa_edmu        [el]; };
   if(el in gn_vz_nepa_edsr        ) { ret = ret "#" gn_vz_nepa_edsr        [el]; };
   if(el in gn_vz_nepa_edze        ) { ret = ret "#" gn_vz_nepa_edze        [el]; };
   if(el in gn_vz_nepa_mn          ) { ret = ret "#" gn_vz_nepa_mn          [el]; };
   if(el in gn_vz_nepo_ed          ) { ret = ret "#" gn_vz_nepo_ed          [el]; };
   if(el in gn_vz_nepo_mn          ) { ret = ret "#" gn_vz_nepo_mn          [el]; };
   if(el in gs_nebu_e1             ) { ret = ret "#" gs_nebu_e1             [el]; };
   if(el in gs_nebu_e2             ) { ret = ret "#" gs_nebu_e2             [el]; };
   if(el in gs_nebu_e3             ) { ret = ret "#" gs_nebu_e3             [el]; };
   if(el in gs_nebu_m1             ) { ret = ret "#" gs_nebu_m1             [el]; };
   if(el in gs_nebu_m2             ) { ret = ret "#" gs_nebu_m2             [el]; };
   if(el in gs_nebu_m3             ) { ret = ret "#" gs_nebu_m3             [el]; };
   if(el in gs_nein                ) { ret = ret "#" gs_nein                [el]; };
   if(el in gs_nein_bz             ) { ret = ret "#" gs_nein_bz             [el]; };
   if(el in gs_nepa_edmu           ) { ret = ret "#" gs_nepa_edmu           [el]; };
   if(el in gs_nepa_edsr           ) { ret = ret "#" gs_nepa_edsr           [el]; };
   if(el in gs_nepa_edze           ) { ret = ret "#" gs_nepa_edze           [el]; };
   if(el in gs_nepa_mn             ) { ret = ret "#" gs_nepa_mn             [el]; };
   if(el in gs_nepo_ed             ) { ret = ret "#" gs_nepo_ed             [el]; };
   if(el in gs_nepo_mn             ) { ret = ret "#" gs_nepo_mn             [el]; };
   if(el in gs_pebu_e1             ) { ret = ret "#" gs_pebu_e1             [el]; };
   if(el in gs_pebu_e2             ) { ret = ret "#" gs_pebu_e2             [el]; };
   if(el in gs_pebu_e3             ) { ret = ret "#" gs_pebu_e3             [el]; };
   if(el in gs_pebu_m1             ) { ret = ret "#" gs_pebu_m1             [el]; };
   if(el in gs_pebu_m2             ) { ret = ret "#" gs_pebu_m2             [el]; };
   if(el in gs_pebu_m3             ) { ret = ret "#" gs_pebu_m3             [el]; };
   if(el in gs_pein                ) { ret = ret "#" gs_pein                [el]; };
   if(el in gs_pein_bz             ) { ret = ret "#" gs_pein_bz             [el]; };
   if(el in gs_pepa_edmu           ) { ret = ret "#" gs_pepa_edmu           [el]; };
   if(el in gs_pepa_edsr           ) { ret = ret "#" gs_pepa_edsr           [el]; };
   if(el in gs_pepa_edze           ) { ret = ret "#" gs_pepa_edze           [el]; };
   if(el in gs_pepa_mn             ) { ret = ret "#" gs_pepa_mn             [el]; };
   if(el in gs_pepo_ed             ) { ret = ret "#" gs_pepo_ed             [el]; };
   if(el in gs_pepo_mn             ) { ret = ret "#" gs_pepo_mn             [el]; };
   if(el in gs_pnbu_e1             ) { ret = ret "#" gs_pnbu_e1             [el]; };
   if(el in gs_pnbu_e2             ) { ret = ret "#" gs_pnbu_e2             [el]; };
   if(el in gs_pnbu_e3             ) { ret = ret "#" gs_pnbu_e3             [el]; };
   if(el in gs_pnbu_m1             ) { ret = ret "#" gs_pnbu_m1             [el]; };
   if(el in gs_pnbu_m2             ) { ret = ret "#" gs_pnbu_m2             [el]; };
   if(el in gs_pnbu_m3             ) { ret = ret "#" gs_pnbu_m3             [el]; };
   if(el in gs_pnin                ) { ret = ret "#" gs_pnin                [el]; };
   if(el in gs_pnpa_edmu           ) { ret = ret "#" gs_pnpa_edmu           [el]; };
   if(el in gs_pnpa_edsr           ) { ret = ret "#" gs_pnpa_edsr           [el]; };
   if(el in gs_pnpa_edze           ) { ret = ret "#" gs_pnpa_edze           [el]; };
   if(el in gs_pnpa_mn             ) { ret = ret "#" gs_pnpa_mn             [el]; };
   if(el in gs_pnpo_ed             ) { ret = ret "#" gs_pnpo_ed             [el]; };
   if(el in gs_pnpo_mn             ) { ret = ret "#" gs_pnpo_mn             [el]; };
   if(el in gs_vz_nebu_e1          ) { ret = ret "#" gs_vz_nebu_e1          [el]; };
   if(el in gs_vz_nebu_e2          ) { ret = ret "#" gs_vz_nebu_e2          [el]; };
   if(el in gs_vz_nebu_e3          ) { ret = ret "#" gs_vz_nebu_e3          [el]; };
   if(el in gs_vz_nebu_m1          ) { ret = ret "#" gs_vz_nebu_m1          [el]; };
   if(el in gs_vz_nebu_m2          ) { ret = ret "#" gs_vz_nebu_m2          [el]; };
   if(el in gs_vz_nebu_m3          ) { ret = ret "#" gs_vz_nebu_m3          [el]; };
   if(el in gs_vz_nein             ) { ret = ret "#" gs_vz_nein             [el]; };
   if(el in gs_vz_nein_bz          ) { ret = ret "#" gs_vz_nein_bz          [el]; };
   if(el in gs_vz_nepa_edmu        ) { ret = ret "#" gs_vz_nepa_edmu        [el]; };
   if(el in gs_vz_nepa_edsr        ) { ret = ret "#" gs_vz_nepa_edsr        [el]; };
   if(el in gs_vz_nepa_edze        ) { ret = ret "#" gs_vz_nepa_edze        [el]; };
   if(el in gs_vz_nepa_mn          ) { ret = ret "#" gs_vz_nepa_mn          [el]; };
   if(el in gs_vz_nepo_ed          ) { ret = ret "#" gs_vz_nepo_ed          [el]; };
   if(el in gs_vz_nepo_mn          ) { ret = ret "#" gs_vz_nepo_mn          [el]; };
   if(el in mst_da                 ) { ret = ret "#" mst_da                 [el]; };
   if(el in mst_ed_da              ) { ret = ret "#" mst_ed_da              [el]; };
   if(el in mst_ed_im              ) { ret = ret "#" mst_ed_im              [el]; };
   if(el in mst_ed_mu              ) { ret = ret "#" mst_ed_mu              [el]; };
   if(el in mst_ed_mu_da           ) { ret = ret "#" mst_ed_mu_da           [el]; };
   if(el in mst_ed_mu_im           ) { ret = ret "#" mst_ed_mu_im           [el]; };
   if(el in mst_ed_mu_pr           ) { ret = ret "#" mst_ed_mu_pr           [el]; };
   if(el in mst_ed_mu_ro           ) { ret = ret "#" mst_ed_mu_ro           [el]; };
   if(el in mst_ed_mu_tv           ) { ret = ret "#" mst_ed_mu_tv           [el]; };
   if(el in mst_ed_mu_vi           ) { ret = ret "#" mst_ed_mu_vi           [el]; };
   if(el in mst_ed_pr              ) { ret = ret "#" mst_ed_pr              [el]; };
   if(el in mst_ed_ro              ) { ret = ret "#" mst_ed_ro              [el]; };
   if(el in mst_ed_sr              ) { ret = ret "#" mst_ed_sr              [el]; };
   if(el in mst_ed_sr_da           ) { ret = ret "#" mst_ed_sr_da           [el]; };
   if(el in mst_ed_sr_im           ) { ret = ret "#" mst_ed_sr_im           [el]; };
   if(el in mst_ed_sr_pr           ) { ret = ret "#" mst_ed_sr_pr           [el]; };
   if(el in mst_ed_sr_ro           ) { ret = ret "#" mst_ed_sr_ro           [el]; };
   if(el in mst_ed_sr_tv           ) { ret = ret "#" mst_ed_sr_tv           [el]; };
   if(el in mst_ed_sr_vi           ) { ret = ret "#" mst_ed_sr_vi           [el]; };
   if(el in mst_ed_tv              ) { ret = ret "#" mst_ed_tv              [el]; };
   if(el in mst_ed_vi              ) { ret = ret "#" mst_ed_vi              [el]; };
   if(el in mst_ed_ze              ) { ret = ret "#" mst_ed_ze              [el]; };
   if(el in mst_ed_ze_da           ) { ret = ret "#" mst_ed_ze_da           [el]; };
   if(el in mst_ed_ze_im           ) { ret = ret "#" mst_ed_ze_im           [el]; };
   if(el in mst_ed_ze_pr           ) { ret = ret "#" mst_ed_ze_pr           [el]; };
   if(el in mst_ed_ze_ro           ) { ret = ret "#" mst_ed_ze_ro           [el]; };
   if(el in mst_ed_ze_tv           ) { ret = ret "#" mst_ed_ze_tv           [el]; };
   if(el in mst_ed_ze_vi           ) { ret = ret "#" mst_ed_ze_vi           [el]; };
   if(el in mst_im                 ) { ret = ret "#" mst_im                 [el]; };
   if(el in mst_mn_da              ) { ret = ret "#" mst_mn_da              [el]; };
   if(el in mst_mn_im              ) { ret = ret "#" mst_mn_im              [el]; };
   if(el in mst_mn_pr              ) { ret = ret "#" mst_mn_pr              [el]; };
   if(el in mst_mn_ro              ) { ret = ret "#" mst_mn_ro              [el]; };
   if(el in mst_mn_tv              ) { ret = ret "#" mst_mn_tv              [el]; };
   if(el in mst_mn_vi              ) { ret = ret "#" mst_mn_vi              [el]; };
   if(el in mst_pr                 ) { ret = ret "#" mst_pr                 [el]; };
   if(el in mst_ro                 ) { ret = ret "#" mst_ro                 [el]; };
   if(el in mst_tv                 ) { ret = ret "#" mst_tv                 [el]; };
   if(el in mst_vi                 ) { ret = ret "#" mst_vi                 [el]; };
   if(el in mzd                    ) { ret = ret "#" mzd                    [el]; };
   if(el in nr_mest                ) { ret = ret "#" nr_mest                [el]; };
   if(el in nr_nar                 ) { ret = ret "#" nr_nar                 [el]; };
   if(el in nr_obce                ) { ret = ret "#" nr_obce                [el]; };
   if(el in nr_obme                ) { ret = ret "#" nr_obme                [el]; };
   if(el in nr_obna                ) { ret = ret "#" nr_obna                [el]; };
   if(el in nr_obpr                ) { ret = ret "#" nr_obpr                [el]; };
   if(el in nr_obvr                ) { ret = ret "#" nr_obvr                [el]; };
   if(el in nr_opka                ) { ret = ret "#" nr_opka                [el]; };
   if(el in nr_opsp                ) { ret = ret "#" nr_opsp                [el]; };
   if(el in nr_opst                ) { ret = ret "#" nr_opst                [el]; };
   if(el in nr_pv                  ) { ret = ret "#" nr_pv                  [el]; };
   if(el in nr_srv                 ) { ret = ret "#" nr_srv                 [el]; };
   if(el in nr_vopr                ) { ret = ret "#" nr_vopr                [el]; };
   if(el in pl_edmu_da             ) { ret = ret "#" pl_edmu_da             [el]; };
   if(el in pl_edmu_im             ) { ret = ret "#" pl_edmu_im             [el]; };
   if(el in pl_edmu_pr             ) { ret = ret "#" pl_edmu_pr             [el]; };
   if(el in pl_edmu_ro             ) { ret = ret "#" pl_edmu_ro             [el]; };
   if(el in pl_edmu_tv             ) { ret = ret "#" pl_edmu_tv             [el]; };
   if(el in pl_edsr_da             ) { ret = ret "#" pl_edsr_da             [el]; };
   if(el in pl_edsr_im             ) { ret = ret "#" pl_edsr_im             [el]; };
   if(el in pl_edsr_pr             ) { ret = ret "#" pl_edsr_pr             [el]; };
   if(el in pl_edsr_ro             ) { ret = ret "#" pl_edsr_ro             [el]; };
   if(el in pl_edsr_tv             ) { ret = ret "#" pl_edsr_tv             [el]; };
   if(el in pl_edze_dr             ) { ret = ret "#" pl_edze_dr             [el]; };
   if(el in pl_edze_im             ) { ret = ret "#" pl_edze_im             [el]; };
   if(el in pl_edze_tv             ) { ret = ret "#" pl_edze_tv             [el]; };
   if(el in pl_edze_vi             ) { ret = ret "#" pl_edze_vi             [el]; };
   if(el in pl_kred_mu             ) { ret = ret "#" pl_kred_mu             [el]; };
   if(el in pl_kred_sr             ) { ret = ret "#" pl_kred_sr             [el]; };
   if(el in pl_kred_ze             ) { ret = ret "#" pl_kred_ze             [el]; };
   if(el in pl_krmn                ) { ret = ret "#" pl_krmn                [el]; };
   if(el in pl_mn_da               ) { ret = ret "#" pl_mn_da               [el]; };
   if(el in pl_mn_im               ) { ret = ret "#" pl_mn_im               [el]; };
   if(el in pl_mn_ro               ) { ret = ret "#" pl_mn_ro               [el]; };
   if(el in pl_mn_tv               ) { ret = ret "#" pl_mn_tv               [el]; };
   if(el in pl_neiz                ) { ret = ret "#" pl_neiz                [el]; };
   if(el in pl_pv_edmu_da          ) { ret = ret "#" pl_pv_edmu_da          [el]; };
   if(el in pl_pv_edmu_im          ) { ret = ret "#" pl_pv_edmu_im          [el]; };
   if(el in pl_pv_edmu_pr          ) { ret = ret "#" pl_pv_edmu_pr          [el]; };
   if(el in pl_pv_edmu_ro          ) { ret = ret "#" pl_pv_edmu_ro          [el]; };
   if(el in pl_pv_edmu_tv          ) { ret = ret "#" pl_pv_edmu_tv          [el]; };
   if(el in pl_pv_edsr_da          ) { ret = ret "#" pl_pv_edsr_da          [el]; };
   if(el in pl_pv_edsr_im          ) { ret = ret "#" pl_pv_edsr_im          [el]; };
   if(el in pl_pv_edsr_pr          ) { ret = ret "#" pl_pv_edsr_pr          [el]; };
   if(el in pl_pv_edsr_ro          ) { ret = ret "#" pl_pv_edsr_ro          [el]; };
   if(el in pl_pv_edsr_tv          ) { ret = ret "#" pl_pv_edsr_tv          [el]; };
   if(el in pl_pv_edze_dr          ) { ret = ret "#" pl_pv_edze_dr          [el]; };
   if(el in pl_pv_edze_im          ) { ret = ret "#" pl_pv_edze_im          [el]; };
   if(el in pl_pv_edze_tv          ) { ret = ret "#" pl_pv_edze_tv          [el]; };
   if(el in pl_pv_edze_vi          ) { ret = ret "#" pl_pv_edze_vi          [el]; };
   if(el in pl_pv_mn_da            ) { ret = ret "#" pl_pv_mn_da            [el]; };
   if(el in pl_pv_mn_im            ) { ret = ret "#" pl_pv_mn_im            [el]; };
   if(el in pl_pv_mn_pr            ) { ret = ret "#" pl_pv_mn_pr            [el]; };
   if(el in pl_pv_mn_ro            ) { ret = ret "#" pl_pv_mn_ro            [el]; };
   if(el in pl_pv_mn_tv            ) { ret = ret "#" pl_pv_mn_tv            [el]; };
   if(el in pl_srv                 ) { ret = ret "#" pl_srv                 [el]; };
   if(el in pq2_ne_na_ed_mu_da     ) { ret = ret "#" pq2_ne_na_ed_mu_da     [el]; };
   if(el in pq2_ne_na_ed_mu_im     ) { ret = ret "#" pq2_ne_na_ed_mu_im     [el]; };
   if(el in pq2_ne_na_ed_mu_pr     ) { ret = ret "#" pq2_ne_na_ed_mu_pr     [el]; };
   if(el in pq2_ne_na_ed_mu_ro     ) { ret = ret "#" pq2_ne_na_ed_mu_ro     [el]; };
   if(el in pq2_ne_na_ed_mu_tv     ) { ret = ret "#" pq2_ne_na_ed_mu_tv     [el]; };
   if(el in pq2_ne_pa_ed_mu_da     ) { ret = ret "#" pq2_ne_pa_ed_mu_da     [el]; };
   if(el in pq2_ne_pa_ed_mu_im     ) { ret = ret "#" pq2_ne_pa_ed_mu_im     [el]; };
   if(el in pq2_ne_pa_ed_mu_pr     ) { ret = ret "#" pq2_ne_pa_ed_mu_pr     [el]; };
   if(el in pq2_ne_pa_ed_mu_ro     ) { ret = ret "#" pq2_ne_pa_ed_mu_ro     [el]; };
   if(el in pq2_ne_pa_ed_mu_tv     ) { ret = ret "#" pq2_ne_pa_ed_mu_tv     [el]; };
   if(el in pq2_ne_vz_na_ed_mu_da  ) { ret = ret "#" pq2_ne_vz_na_ed_mu_da  [el]; };
   if(el in pq2_ne_vz_na_ed_mu_im  ) { ret = ret "#" pq2_ne_vz_na_ed_mu_im  [el]; };
   if(el in pq2_ne_vz_na_ed_mu_pr  ) { ret = ret "#" pq2_ne_vz_na_ed_mu_pr  [el]; };
   if(el in pq2_ne_vz_na_ed_mu_ro  ) { ret = ret "#" pq2_ne_vz_na_ed_mu_ro  [el]; };
   if(el in pq2_ne_vz_na_ed_mu_tv  ) { ret = ret "#" pq2_ne_vz_na_ed_mu_tv  [el]; };
   if(el in pq2_ne_vz_pa_ed_mu_da  ) { ret = ret "#" pq2_ne_vz_pa_ed_mu_da  [el]; };
   if(el in pq2_ne_vz_pa_ed_mu_im  ) { ret = ret "#" pq2_ne_vz_pa_ed_mu_im  [el]; };
   if(el in pq2_ne_vz_pa_ed_mu_pr  ) { ret = ret "#" pq2_ne_vz_pa_ed_mu_pr  [el]; };
   if(el in pq2_ne_vz_pa_ed_mu_ro  ) { ret = ret "#" pq2_ne_vz_pa_ed_mu_ro  [el]; };
   if(el in pq2_ne_vz_pa_ed_mu_tv  ) { ret = ret "#" pq2_ne_vz_pa_ed_mu_tv  [el]; };
   if(el in pq2_pe_na_ed_mu_da     ) { ret = ret "#" pq2_pe_na_ed_mu_da     [el]; };
   if(el in pq2_pe_na_ed_mu_im     ) { ret = ret "#" pq2_pe_na_ed_mu_im     [el]; };
   if(el in pq2_pe_na_ed_mu_pr     ) { ret = ret "#" pq2_pe_na_ed_mu_pr     [el]; };
   if(el in pq2_pe_na_ed_mu_ro     ) { ret = ret "#" pq2_pe_na_ed_mu_ro     [el]; };
   if(el in pq2_pe_na_ed_mu_tv     ) { ret = ret "#" pq2_pe_na_ed_mu_tv     [el]; };
   if(el in pq2_pe_pa_ed_mu_da     ) { ret = ret "#" pq2_pe_pa_ed_mu_da     [el]; };
   if(el in pq2_pe_pa_ed_mu_im     ) { ret = ret "#" pq2_pe_pa_ed_mu_im     [el]; };
   if(el in pq2_pe_pa_ed_mu_pr     ) { ret = ret "#" pq2_pe_pa_ed_mu_pr     [el]; };
   if(el in pq2_pe_pa_ed_mu_ro     ) { ret = ret "#" pq2_pe_pa_ed_mu_ro     [el]; };
   if(el in pq2_pe_pa_ed_mu_tv     ) { ret = ret "#" pq2_pe_pa_ed_mu_tv     [el]; };
   if(el in pq2_pe_sd_na_ed_mu_da  ) { ret = ret "#" pq2_pe_sd_na_ed_mu_da  [el]; };
   if(el in pq2_pe_sd_na_ed_mu_im  ) { ret = ret "#" pq2_pe_sd_na_ed_mu_im  [el]; };
   if(el in pq2_pe_sd_na_ed_mu_pr  ) { ret = ret "#" pq2_pe_sd_na_ed_mu_pr  [el]; };
   if(el in pq2_pe_sd_na_ed_mu_ro  ) { ret = ret "#" pq2_pe_sd_na_ed_mu_ro  [el]; };
   if(el in pq2_pe_sd_na_ed_mu_tv  ) { ret = ret "#" pq2_pe_sd_na_ed_mu_tv  [el]; };
   if(el in pq2_pe_sd_pa_ed_mu_da  ) { ret = ret "#" pq2_pe_sd_pa_ed_mu_da  [el]; };
   if(el in pq2_pe_sd_pa_ed_mu_im  ) { ret = ret "#" pq2_pe_sd_pa_ed_mu_im  [el]; };
   if(el in pq2_pe_sd_pa_ed_mu_pr  ) { ret = ret "#" pq2_pe_sd_pa_ed_mu_pr  [el]; };
   if(el in pq2_pe_sd_pa_ed_mu_ro  ) { ret = ret "#" pq2_pe_sd_pa_ed_mu_ro  [el]; };
   if(el in pq2_pe_sd_pa_ed_mu_tv  ) { ret = ret "#" pq2_pe_sd_pa_ed_mu_tv  [el]; };
   if(el in pq2_pn_na_ed_mu_da     ) { ret = ret "#" pq2_pn_na_ed_mu_da     [el]; };
   if(el in pq2_pn_na_ed_mu_im     ) { ret = ret "#" pq2_pn_na_ed_mu_im     [el]; };
   if(el in pq2_pn_na_ed_mu_pr     ) { ret = ret "#" pq2_pn_na_ed_mu_pr     [el]; };
   if(el in pq2_pn_na_ed_mu_ro     ) { ret = ret "#" pq2_pn_na_ed_mu_ro     [el]; };
   if(el in pq2_pn_na_ed_mu_tv     ) { ret = ret "#" pq2_pn_na_ed_mu_tv     [el]; };
   if(el in pq2_pn_pa_ed_mu_da     ) { ret = ret "#" pq2_pn_pa_ed_mu_da     [el]; };
   if(el in pq2_pn_pa_ed_mu_im     ) { ret = ret "#" pq2_pn_pa_ed_mu_im     [el]; };
   if(el in pq2_pn_pa_ed_mu_pr     ) { ret = ret "#" pq2_pn_pa_ed_mu_pr     [el]; };
   if(el in pq2_pn_pa_ed_mu_ro     ) { ret = ret "#" pq2_pn_pa_ed_mu_ro     [el]; };
   if(el in pq2_pn_pa_ed_mu_tv     ) { ret = ret "#" pq2_pn_pa_ed_mu_tv     [el]; };
   if(el in pqn_ne_na_ed_mu_da     ) { ret = ret "#" pqn_ne_na_ed_mu_da     [el]; };
   if(el in pqn_ne_na_ed_mu_im     ) { ret = ret "#" pqn_ne_na_ed_mu_im     [el]; };
   if(el in pqn_ne_na_ed_mu_pr     ) { ret = ret "#" pqn_ne_na_ed_mu_pr     [el]; };
   if(el in pqn_ne_na_ed_mu_ro     ) { ret = ret "#" pqn_ne_na_ed_mu_ro     [el]; };
   if(el in pqn_ne_na_ed_mu_tv     ) { ret = ret "#" pqn_ne_na_ed_mu_tv     [el]; };
   if(el in pqn_ne_pa_ed_mu_da     ) { ret = ret "#" pqn_ne_pa_ed_mu_da     [el]; };
   if(el in pqn_ne_pa_ed_mu_im     ) { ret = ret "#" pqn_ne_pa_ed_mu_im     [el]; };
   if(el in pqn_ne_pa_ed_mu_pr     ) { ret = ret "#" pqn_ne_pa_ed_mu_pr     [el]; };
   if(el in pqn_ne_pa_ed_mu_ro     ) { ret = ret "#" pqn_ne_pa_ed_mu_ro     [el]; };
   if(el in pqn_ne_pa_ed_mu_tv     ) { ret = ret "#" pqn_ne_pa_ed_mu_tv     [el]; };
   if(el in pqn_ne_vz_na_ed_mu_da  ) { ret = ret "#" pqn_ne_vz_na_ed_mu_da  [el]; };
   if(el in pqn_ne_vz_na_ed_mu_im  ) { ret = ret "#" pqn_ne_vz_na_ed_mu_im  [el]; };
   if(el in pqn_ne_vz_na_ed_mu_pr  ) { ret = ret "#" pqn_ne_vz_na_ed_mu_pr  [el]; };
   if(el in pqn_ne_vz_na_ed_mu_ro  ) { ret = ret "#" pqn_ne_vz_na_ed_mu_ro  [el]; };
   if(el in pqn_ne_vz_na_ed_mu_tv  ) { ret = ret "#" pqn_ne_vz_na_ed_mu_tv  [el]; };
   if(el in pqn_ne_vz_pa_ed_mu_da  ) { ret = ret "#" pqn_ne_vz_pa_ed_mu_da  [el]; };
   if(el in pqn_ne_vz_pa_ed_mu_im  ) { ret = ret "#" pqn_ne_vz_pa_ed_mu_im  [el]; };
   if(el in pqn_ne_vz_pa_ed_mu_pr  ) { ret = ret "#" pqn_ne_vz_pa_ed_mu_pr  [el]; };
   if(el in pqn_ne_vz_pa_ed_mu_ro  ) { ret = ret "#" pqn_ne_vz_pa_ed_mu_ro  [el]; };
   if(el in pqn_ne_vz_pa_ed_mu_tv  ) { ret = ret "#" pqn_ne_vz_pa_ed_mu_tv  [el]; };
   if(el in pqn_pe_na_ed_mu_da     ) { ret = ret "#" pqn_pe_na_ed_mu_da     [el]; };
   if(el in pqn_pe_na_ed_mu_im     ) { ret = ret "#" pqn_pe_na_ed_mu_im     [el]; };
   if(el in pqn_pe_na_ed_mu_pr     ) { ret = ret "#" pqn_pe_na_ed_mu_pr     [el]; };
   if(el in pqn_pe_na_ed_mu_ro     ) { ret = ret "#" pqn_pe_na_ed_mu_ro     [el]; };
   if(el in pqn_pe_na_ed_mu_tv     ) { ret = ret "#" pqn_pe_na_ed_mu_tv     [el]; };
   if(el in pqn_pe_pa_ed_mu_da     ) { ret = ret "#" pqn_pe_pa_ed_mu_da     [el]; };
   if(el in pqn_pe_pa_ed_mu_im     ) { ret = ret "#" pqn_pe_pa_ed_mu_im     [el]; };
   if(el in pqn_pe_pa_ed_mu_pr     ) { ret = ret "#" pqn_pe_pa_ed_mu_pr     [el]; };
   if(el in pqn_pe_pa_ed_mu_ro     ) { ret = ret "#" pqn_pe_pa_ed_mu_ro     [el]; };
   if(el in pqn_pe_pa_ed_mu_tv     ) { ret = ret "#" pqn_pe_pa_ed_mu_tv     [el]; };
   if(el in pqn_pe_sd_na_ed_mu_da  ) { ret = ret "#" pqn_pe_sd_na_ed_mu_da  [el]; };
   if(el in pqn_pe_sd_na_ed_mu_im  ) { ret = ret "#" pqn_pe_sd_na_ed_mu_im  [el]; };
   if(el in pqn_pe_sd_na_ed_mu_pr  ) { ret = ret "#" pqn_pe_sd_na_ed_mu_pr  [el]; };
   if(el in pqn_pe_sd_na_ed_mu_ro  ) { ret = ret "#" pqn_pe_sd_na_ed_mu_ro  [el]; };
   if(el in pqn_pe_sd_na_ed_mu_tv  ) { ret = ret "#" pqn_pe_sd_na_ed_mu_tv  [el]; };
   if(el in pqn_pe_sd_pa_ed_mu_da  ) { ret = ret "#" pqn_pe_sd_pa_ed_mu_da  [el]; };
   if(el in pqn_pe_sd_pa_ed_mu_im  ) { ret = ret "#" pqn_pe_sd_pa_ed_mu_im  [el]; };
   if(el in pqn_pe_sd_pa_ed_mu_pr  ) { ret = ret "#" pqn_pe_sd_pa_ed_mu_pr  [el]; };
   if(el in pqn_pe_sd_pa_ed_mu_ro  ) { ret = ret "#" pqn_pe_sd_pa_ed_mu_ro  [el]; };
   if(el in pqn_pe_sd_pa_ed_mu_tv  ) { ret = ret "#" pqn_pe_sd_pa_ed_mu_tv  [el]; };
   if(el in pqn_pn_na_ed_mu_da     ) { ret = ret "#" pqn_pn_na_ed_mu_da     [el]; };
   if(el in pqn_pn_na_ed_mu_im     ) { ret = ret "#" pqn_pn_na_ed_mu_im     [el]; };
   if(el in pqn_pn_na_ed_mu_pr     ) { ret = ret "#" pqn_pn_na_ed_mu_pr     [el]; };
   if(el in pqn_pn_na_ed_mu_ro     ) { ret = ret "#" pqn_pn_na_ed_mu_ro     [el]; };
   if(el in pqn_pn_na_ed_mu_tv     ) { ret = ret "#" pqn_pn_na_ed_mu_tv     [el]; };
   if(el in pqn_pn_pa_ed_mu_da     ) { ret = ret "#" pqn_pn_pa_ed_mu_da     [el]; };
   if(el in pqn_pn_pa_ed_mu_im     ) { ret = ret "#" pqn_pn_pa_ed_mu_im     [el]; };
   if(el in pqn_pn_pa_ed_mu_pr     ) { ret = ret "#" pqn_pn_pa_ed_mu_pr     [el]; };
   if(el in pqn_pn_pa_ed_mu_ro     ) { ret = ret "#" pqn_pn_pa_ed_mu_ro     [el]; };
   if(el in pqn_pn_pa_ed_mu_tv     ) { ret = ret "#" pqn_pn_pa_ed_mu_tv     [el]; };
   if(el in pqs_ne_pa_ed_mu_da     ) { ret = ret "#" pqs_ne_pa_ed_mu_da     [el]; };
   if(el in pqs_ne_pa_ed_mu_im     ) { ret = ret "#" pqs_ne_pa_ed_mu_im     [el]; };
   if(el in pqs_ne_pa_ed_mu_pr     ) { ret = ret "#" pqs_ne_pa_ed_mu_pr     [el]; };
   if(el in pqs_ne_pa_ed_mu_ro     ) { ret = ret "#" pqs_ne_pa_ed_mu_ro     [el]; };
   if(el in pqs_ne_pa_ed_mu_tv     ) { ret = ret "#" pqs_ne_pa_ed_mu_tv     [el]; };
   if(el in pqs_ne_vz_pa_ed_mu_da  ) { ret = ret "#" pqs_ne_vz_pa_ed_mu_da  [el]; };
   if(el in pqs_ne_vz_pa_ed_mu_im  ) { ret = ret "#" pqs_ne_vz_pa_ed_mu_im  [el]; };
   if(el in pqs_ne_vz_pa_ed_mu_pr  ) { ret = ret "#" pqs_ne_vz_pa_ed_mu_pr  [el]; };
   if(el in pqs_ne_vz_pa_ed_mu_ro  ) { ret = ret "#" pqs_ne_vz_pa_ed_mu_ro  [el]; };
   if(el in pqs_ne_vz_pa_ed_mu_tv  ) { ret = ret "#" pqs_ne_vz_pa_ed_mu_tv  [el]; };
   if(el in pqs_pe_pa_ed_mu_da     ) { ret = ret "#" pqs_pe_pa_ed_mu_da     [el]; };
   if(el in pqs_pe_pa_ed_mu_im     ) { ret = ret "#" pqs_pe_pa_ed_mu_im     [el]; };
   if(el in pqs_pe_pa_ed_mu_pr     ) { ret = ret "#" pqs_pe_pa_ed_mu_pr     [el]; };
   if(el in pqs_pe_pa_ed_mu_ro     ) { ret = ret "#" pqs_pe_pa_ed_mu_ro     [el]; };
   if(el in pqs_pe_pa_ed_mu_tv     ) { ret = ret "#" pqs_pe_pa_ed_mu_tv     [el]; };
   if(el in pqs_pe_sd_pa_ed_mu_da  ) { ret = ret "#" pqs_pe_sd_pa_ed_mu_da  [el]; };
   if(el in pqs_pe_sd_pa_ed_mu_im  ) { ret = ret "#" pqs_pe_sd_pa_ed_mu_im  [el]; };
   if(el in pqs_pe_sd_pa_ed_mu_pr  ) { ret = ret "#" pqs_pe_sd_pa_ed_mu_pr  [el]; };
   if(el in pqs_pe_sd_pa_ed_mu_ro  ) { ret = ret "#" pqs_pe_sd_pa_ed_mu_ro  [el]; };
   if(el in pqs_pe_sd_pa_ed_mu_tv  ) { ret = ret "#" pqs_pe_sd_pa_ed_mu_tv  [el]; };
   if(el in pqs_pn_pa_ed_mu_da     ) { ret = ret "#" pqs_pn_pa_ed_mu_da     [el]; };
   if(el in pqs_pn_pa_ed_mu_im     ) { ret = ret "#" pqs_pn_pa_ed_mu_im     [el]; };
   if(el in pqs_pn_pa_ed_mu_pr     ) { ret = ret "#" pqs_pn_pa_ed_mu_pr     [el]; };
   if(el in pqs_pn_pa_ed_mu_ro     ) { ret = ret "#" pqs_pn_pa_ed_mu_ro     [el]; };
   if(el in pqs_pn_pa_ed_mu_tv     ) { ret = ret "#" pqs_pn_pa_ed_mu_tv     [el]; };
   if(el in pq2_ne_na_ed_sr_da     ) { ret = ret "#" pq2_ne_na_ed_sr_da     [el]; };
   if(el in pq2_ne_na_ed_sr_im     ) { ret = ret "#" pq2_ne_na_ed_sr_im     [el]; };
   if(el in pq2_ne_na_ed_sr_pr     ) { ret = ret "#" pq2_ne_na_ed_sr_pr     [el]; };
   if(el in pq2_ne_na_ed_sr_ro     ) { ret = ret "#" pq2_ne_na_ed_sr_ro     [el]; };
   if(el in pq2_ne_na_ed_sr_tv     ) { ret = ret "#" pq2_ne_na_ed_sr_tv     [el]; };
   if(el in pq2_ne_pa_ed_sr_da     ) { ret = ret "#" pq2_ne_pa_ed_sr_da     [el]; };
   if(el in pq2_ne_pa_ed_sr_im     ) { ret = ret "#" pq2_ne_pa_ed_sr_im     [el]; };
   if(el in pq2_ne_pa_ed_sr_pr     ) { ret = ret "#" pq2_ne_pa_ed_sr_pr     [el]; };
   if(el in pq2_ne_pa_ed_sr_ro     ) { ret = ret "#" pq2_ne_pa_ed_sr_ro     [el]; };
   if(el in pq2_ne_pa_ed_sr_tv     ) { ret = ret "#" pq2_ne_pa_ed_sr_tv     [el]; };
   if(el in pq2_ne_vz_na_ed_sr_da  ) { ret = ret "#" pq2_ne_vz_na_ed_sr_da  [el]; };
   if(el in pq2_ne_vz_na_ed_sr_im  ) { ret = ret "#" pq2_ne_vz_na_ed_sr_im  [el]; };
   if(el in pq2_ne_vz_na_ed_sr_pr  ) { ret = ret "#" pq2_ne_vz_na_ed_sr_pr  [el]; };
   if(el in pq2_ne_vz_na_ed_sr_ro  ) { ret = ret "#" pq2_ne_vz_na_ed_sr_ro  [el]; };
   if(el in pq2_ne_vz_na_ed_sr_tv  ) { ret = ret "#" pq2_ne_vz_na_ed_sr_tv  [el]; };
   if(el in pq2_ne_vz_pa_ed_sr_da  ) { ret = ret "#" pq2_ne_vz_pa_ed_sr_da  [el]; };
   if(el in pq2_ne_vz_pa_ed_sr_im  ) { ret = ret "#" pq2_ne_vz_pa_ed_sr_im  [el]; };
   if(el in pq2_ne_vz_pa_ed_sr_pr  ) { ret = ret "#" pq2_ne_vz_pa_ed_sr_pr  [el]; };
   if(el in pq2_ne_vz_pa_ed_sr_ro  ) { ret = ret "#" pq2_ne_vz_pa_ed_sr_ro  [el]; };
   if(el in pq2_ne_vz_pa_ed_sr_tv  ) { ret = ret "#" pq2_ne_vz_pa_ed_sr_tv  [el]; };
   if(el in pq2_pe_na_ed_sr_da     ) { ret = ret "#" pq2_pe_na_ed_sr_da     [el]; };
   if(el in pq2_pe_na_ed_sr_im     ) { ret = ret "#" pq2_pe_na_ed_sr_im     [el]; };
   if(el in pq2_pe_na_ed_sr_pr     ) { ret = ret "#" pq2_pe_na_ed_sr_pr     [el]; };
   if(el in pq2_pe_na_ed_sr_ro     ) { ret = ret "#" pq2_pe_na_ed_sr_ro     [el]; };
   if(el in pq2_pe_na_ed_sr_tv     ) { ret = ret "#" pq2_pe_na_ed_sr_tv     [el]; };
   if(el in pq2_pe_pa_ed_sr_da     ) { ret = ret "#" pq2_pe_pa_ed_sr_da     [el]; };
   if(el in pq2_pe_pa_ed_sr_im     ) { ret = ret "#" pq2_pe_pa_ed_sr_im     [el]; };
   if(el in pq2_pe_pa_ed_sr_pr     ) { ret = ret "#" pq2_pe_pa_ed_sr_pr     [el]; };
   if(el in pq2_pe_pa_ed_sr_ro     ) { ret = ret "#" pq2_pe_pa_ed_sr_ro     [el]; };
   if(el in pq2_pe_pa_ed_sr_tv     ) { ret = ret "#" pq2_pe_pa_ed_sr_tv     [el]; };
   if(el in pq2_pe_sd_na_ed_sr_da  ) { ret = ret "#" pq2_pe_sd_na_ed_sr_da  [el]; };
   if(el in pq2_pe_sd_na_ed_sr_im  ) { ret = ret "#" pq2_pe_sd_na_ed_sr_im  [el]; };
   if(el in pq2_pe_sd_na_ed_sr_pr  ) { ret = ret "#" pq2_pe_sd_na_ed_sr_pr  [el]; };
   if(el in pq2_pe_sd_na_ed_sr_ro  ) { ret = ret "#" pq2_pe_sd_na_ed_sr_ro  [el]; };
   if(el in pq2_pe_sd_na_ed_sr_tv  ) { ret = ret "#" pq2_pe_sd_na_ed_sr_tv  [el]; };
   if(el in pq2_pe_sd_pa_ed_sr_da  ) { ret = ret "#" pq2_pe_sd_pa_ed_sr_da  [el]; };
   if(el in pq2_pe_sd_pa_ed_sr_im  ) { ret = ret "#" pq2_pe_sd_pa_ed_sr_im  [el]; };
   if(el in pq2_pe_sd_pa_ed_sr_pr  ) { ret = ret "#" pq2_pe_sd_pa_ed_sr_pr  [el]; };
   if(el in pq2_pe_sd_pa_ed_sr_ro  ) { ret = ret "#" pq2_pe_sd_pa_ed_sr_ro  [el]; };
   if(el in pq2_pe_sd_pa_ed_sr_tv  ) { ret = ret "#" pq2_pe_sd_pa_ed_sr_tv  [el]; };
   if(el in pq2_pn_na_ed_sr_da     ) { ret = ret "#" pq2_pn_na_ed_sr_da     [el]; };
   if(el in pq2_pn_na_ed_sr_im     ) { ret = ret "#" pq2_pn_na_ed_sr_im     [el]; };
   if(el in pq2_pn_na_ed_sr_pr     ) { ret = ret "#" pq2_pn_na_ed_sr_pr     [el]; };
   if(el in pq2_pn_na_ed_sr_ro     ) { ret = ret "#" pq2_pn_na_ed_sr_ro     [el]; };
   if(el in pq2_pn_na_ed_sr_tv     ) { ret = ret "#" pq2_pn_na_ed_sr_tv     [el]; };
   if(el in pq2_pn_pa_ed_sr_da     ) { ret = ret "#" pq2_pn_pa_ed_sr_da     [el]; };
   if(el in pq2_pn_pa_ed_sr_im     ) { ret = ret "#" pq2_pn_pa_ed_sr_im     [el]; };
   if(el in pq2_pn_pa_ed_sr_pr     ) { ret = ret "#" pq2_pn_pa_ed_sr_pr     [el]; };
   if(el in pq2_pn_pa_ed_sr_ro     ) { ret = ret "#" pq2_pn_pa_ed_sr_ro     [el]; };
   if(el in pq2_pn_pa_ed_sr_tv     ) { ret = ret "#" pq2_pn_pa_ed_sr_tv     [el]; };
   if(el in pqn_ne_na_ed_sr_da     ) { ret = ret "#" pqn_ne_na_ed_sr_da     [el]; };
   if(el in pqn_ne_na_ed_sr_im     ) { ret = ret "#" pqn_ne_na_ed_sr_im     [el]; };
   if(el in pqn_ne_na_ed_sr_pr     ) { ret = ret "#" pqn_ne_na_ed_sr_pr     [el]; };
   if(el in pqn_ne_na_ed_sr_ro     ) { ret = ret "#" pqn_ne_na_ed_sr_ro     [el]; };
   if(el in pqn_ne_na_ed_sr_tv     ) { ret = ret "#" pqn_ne_na_ed_sr_tv     [el]; };
   if(el in pqn_ne_pa_ed_sr_da     ) { ret = ret "#" pqn_ne_pa_ed_sr_da     [el]; };
   if(el in pqn_ne_pa_ed_sr_im     ) { ret = ret "#" pqn_ne_pa_ed_sr_im     [el]; };
   if(el in pqn_ne_pa_ed_sr_pr     ) { ret = ret "#" pqn_ne_pa_ed_sr_pr     [el]; };
   if(el in pqn_ne_pa_ed_sr_ro     ) { ret = ret "#" pqn_ne_pa_ed_sr_ro     [el]; };
   if(el in pqn_ne_pa_ed_sr_tv     ) { ret = ret "#" pqn_ne_pa_ed_sr_tv     [el]; };
   if(el in pqn_ne_vz_na_ed_sr_da  ) { ret = ret "#" pqn_ne_vz_na_ed_sr_da  [el]; };
   if(el in pqn_ne_vz_na_ed_sr_im  ) { ret = ret "#" pqn_ne_vz_na_ed_sr_im  [el]; };
   if(el in pqn_ne_vz_na_ed_sr_pr  ) { ret = ret "#" pqn_ne_vz_na_ed_sr_pr  [el]; };
   if(el in pqn_ne_vz_na_ed_sr_ro  ) { ret = ret "#" pqn_ne_vz_na_ed_sr_ro  [el]; };
   if(el in pqn_ne_vz_na_ed_sr_tv  ) { ret = ret "#" pqn_ne_vz_na_ed_sr_tv  [el]; };
   if(el in pqn_ne_vz_pa_ed_sr_da  ) { ret = ret "#" pqn_ne_vz_pa_ed_sr_da  [el]; };
   if(el in pqn_ne_vz_pa_ed_sr_im  ) { ret = ret "#" pqn_ne_vz_pa_ed_sr_im  [el]; };
   if(el in pqn_ne_vz_pa_ed_sr_pr  ) { ret = ret "#" pqn_ne_vz_pa_ed_sr_pr  [el]; };
   if(el in pqn_ne_vz_pa_ed_sr_ro  ) { ret = ret "#" pqn_ne_vz_pa_ed_sr_ro  [el]; };
   if(el in pqn_ne_vz_pa_ed_sr_tv  ) { ret = ret "#" pqn_ne_vz_pa_ed_sr_tv  [el]; };
   if(el in pqn_pe_na_ed_sr_da     ) { ret = ret "#" pqn_pe_na_ed_sr_da     [el]; };
   if(el in pqn_pe_na_ed_sr_im     ) { ret = ret "#" pqn_pe_na_ed_sr_im     [el]; };
   if(el in pqn_pe_na_ed_sr_pr     ) { ret = ret "#" pqn_pe_na_ed_sr_pr     [el]; };
   if(el in pqn_pe_na_ed_sr_ro     ) { ret = ret "#" pqn_pe_na_ed_sr_ro     [el]; };
   if(el in pqn_pe_na_ed_sr_tv     ) { ret = ret "#" pqn_pe_na_ed_sr_tv     [el]; };
   if(el in pqn_pe_pa_ed_sr_da     ) { ret = ret "#" pqn_pe_pa_ed_sr_da     [el]; };
   if(el in pqn_pe_pa_ed_sr_im     ) { ret = ret "#" pqn_pe_pa_ed_sr_im     [el]; };
   if(el in pqn_pe_pa_ed_sr_pr     ) { ret = ret "#" pqn_pe_pa_ed_sr_pr     [el]; };
   if(el in pqn_pe_pa_ed_sr_ro     ) { ret = ret "#" pqn_pe_pa_ed_sr_ro     [el]; };
   if(el in pqn_pe_pa_ed_sr_tv     ) { ret = ret "#" pqn_pe_pa_ed_sr_tv     [el]; };
   if(el in pqn_pe_sd_na_ed_sr_da  ) { ret = ret "#" pqn_pe_sd_na_ed_sr_da  [el]; };
   if(el in pqn_pe_sd_na_ed_sr_im  ) { ret = ret "#" pqn_pe_sd_na_ed_sr_im  [el]; };
   if(el in pqn_pe_sd_na_ed_sr_pr  ) { ret = ret "#" pqn_pe_sd_na_ed_sr_pr  [el]; };
   if(el in pqn_pe_sd_na_ed_sr_ro  ) { ret = ret "#" pqn_pe_sd_na_ed_sr_ro  [el]; };
   if(el in pqn_pe_sd_na_ed_sr_tv  ) { ret = ret "#" pqn_pe_sd_na_ed_sr_tv  [el]; };
   if(el in pqn_pe_sd_pa_ed_sr_da  ) { ret = ret "#" pqn_pe_sd_pa_ed_sr_da  [el]; };
   if(el in pqn_pe_sd_pa_ed_sr_im  ) { ret = ret "#" pqn_pe_sd_pa_ed_sr_im  [el]; };
   if(el in pqn_pe_sd_pa_ed_sr_pr  ) { ret = ret "#" pqn_pe_sd_pa_ed_sr_pr  [el]; };
   if(el in pqn_pe_sd_pa_ed_sr_ro  ) { ret = ret "#" pqn_pe_sd_pa_ed_sr_ro  [el]; };
   if(el in pqn_pe_sd_pa_ed_sr_tv  ) { ret = ret "#" pqn_pe_sd_pa_ed_sr_tv  [el]; };
   if(el in pqn_pn_na_ed_sr_da     ) { ret = ret "#" pqn_pn_na_ed_sr_da     [el]; };
   if(el in pqn_pn_na_ed_sr_im     ) { ret = ret "#" pqn_pn_na_ed_sr_im     [el]; };
   if(el in pqn_pn_na_ed_sr_pr     ) { ret = ret "#" pqn_pn_na_ed_sr_pr     [el]; };
   if(el in pqn_pn_na_ed_sr_ro     ) { ret = ret "#" pqn_pn_na_ed_sr_ro     [el]; };
   if(el in pqn_pn_na_ed_sr_tv     ) { ret = ret "#" pqn_pn_na_ed_sr_tv     [el]; };
   if(el in pqn_pn_pa_ed_sr_da     ) { ret = ret "#" pqn_pn_pa_ed_sr_da     [el]; };
   if(el in pqn_pn_pa_ed_sr_im     ) { ret = ret "#" pqn_pn_pa_ed_sr_im     [el]; };
   if(el in pqn_pn_pa_ed_sr_pr     ) { ret = ret "#" pqn_pn_pa_ed_sr_pr     [el]; };
   if(el in pqn_pn_pa_ed_sr_ro     ) { ret = ret "#" pqn_pn_pa_ed_sr_ro     [el]; };
   if(el in pqn_pn_pa_ed_sr_tv     ) { ret = ret "#" pqn_pn_pa_ed_sr_tv     [el]; };
   if(el in pqs_ne_pa_ed_sr_da     ) { ret = ret "#" pqs_ne_pa_ed_sr_da     [el]; };
   if(el in pqs_ne_pa_ed_sr_im     ) { ret = ret "#" pqs_ne_pa_ed_sr_im     [el]; };
   if(el in pqs_ne_pa_ed_sr_pr     ) { ret = ret "#" pqs_ne_pa_ed_sr_pr     [el]; };
   if(el in pqs_ne_pa_ed_sr_ro     ) { ret = ret "#" pqs_ne_pa_ed_sr_ro     [el]; };
   if(el in pqs_ne_pa_ed_sr_tv     ) { ret = ret "#" pqs_ne_pa_ed_sr_tv     [el]; };
   if(el in pqs_ne_vz_pa_ed_sr_da  ) { ret = ret "#" pqs_ne_vz_pa_ed_sr_da  [el]; };
   if(el in pqs_ne_vz_pa_ed_sr_im  ) { ret = ret "#" pqs_ne_vz_pa_ed_sr_im  [el]; };
   if(el in pqs_ne_vz_pa_ed_sr_pr  ) { ret = ret "#" pqs_ne_vz_pa_ed_sr_pr  [el]; };
   if(el in pqs_ne_vz_pa_ed_sr_ro  ) { ret = ret "#" pqs_ne_vz_pa_ed_sr_ro  [el]; };
   if(el in pqs_ne_vz_pa_ed_sr_tv  ) { ret = ret "#" pqs_ne_vz_pa_ed_sr_tv  [el]; };
   if(el in pqs_pe_pa_ed_sr_da     ) { ret = ret "#" pqs_pe_pa_ed_sr_da     [el]; };
   if(el in pqs_pe_pa_ed_sr_im     ) { ret = ret "#" pqs_pe_pa_ed_sr_im     [el]; };
   if(el in pqs_pe_pa_ed_sr_pr     ) { ret = ret "#" pqs_pe_pa_ed_sr_pr     [el]; };
   if(el in pqs_pe_pa_ed_sr_ro     ) { ret = ret "#" pqs_pe_pa_ed_sr_ro     [el]; };
   if(el in pqs_pe_pa_ed_sr_tv     ) { ret = ret "#" pqs_pe_pa_ed_sr_tv     [el]; };
   if(el in pqs_pe_sd_pa_ed_sr_da  ) { ret = ret "#" pqs_pe_sd_pa_ed_sr_da  [el]; };
   if(el in pqs_pe_sd_pa_ed_sr_im  ) { ret = ret "#" pqs_pe_sd_pa_ed_sr_im  [el]; };
   if(el in pqs_pe_sd_pa_ed_sr_pr  ) { ret = ret "#" pqs_pe_sd_pa_ed_sr_pr  [el]; };
   if(el in pqs_pe_sd_pa_ed_sr_ro  ) { ret = ret "#" pqs_pe_sd_pa_ed_sr_ro  [el]; };
   if(el in pqs_pe_sd_pa_ed_sr_tv  ) { ret = ret "#" pqs_pe_sd_pa_ed_sr_tv  [el]; };
   if(el in pqs_pn_pa_ed_sr_da     ) { ret = ret "#" pqs_pn_pa_ed_sr_da     [el]; };
   if(el in pqs_pn_pa_ed_sr_im     ) { ret = ret "#" pqs_pn_pa_ed_sr_im     [el]; };
   if(el in pqs_pn_pa_ed_sr_pr     ) { ret = ret "#" pqs_pn_pa_ed_sr_pr     [el]; };
   if(el in pqs_pn_pa_ed_sr_ro     ) { ret = ret "#" pqs_pn_pa_ed_sr_ro     [el]; };
   if(el in pqs_pn_pa_ed_sr_tv     ) { ret = ret "#" pqs_pn_pa_ed_sr_tv     [el]; };
   if(el in pq2_ne_na_ed_ze_dr     ) { ret = ret "#" pq2_ne_na_ed_ze_dr     [el]; };
   if(el in pq2_ne_na_ed_ze_im     ) { ret = ret "#" pq2_ne_na_ed_ze_im     [el]; };
   if(el in pq2_ne_na_ed_ze_tv     ) { ret = ret "#" pq2_ne_na_ed_ze_tv     [el]; };
   if(el in pq2_ne_na_ed_ze_vi     ) { ret = ret "#" pq2_ne_na_ed_ze_vi     [el]; };
   if(el in pq2_ne_pa_ed_ze_dr     ) { ret = ret "#" pq2_ne_pa_ed_ze_dr     [el]; };
   if(el in pq2_ne_pa_ed_ze_im     ) { ret = ret "#" pq2_ne_pa_ed_ze_im     [el]; };
   if(el in pq2_ne_pa_ed_ze_tv     ) { ret = ret "#" pq2_ne_pa_ed_ze_tv     [el]; };
   if(el in pq2_ne_pa_ed_ze_vi     ) { ret = ret "#" pq2_ne_pa_ed_ze_vi     [el]; };
   if(el in pq2_ne_vz_na_ed_ze_dr  ) { ret = ret "#" pq2_ne_vz_na_ed_ze_dr  [el]; };
   if(el in pq2_ne_vz_na_ed_ze_im  ) { ret = ret "#" pq2_ne_vz_na_ed_ze_im  [el]; };
   if(el in pq2_ne_vz_na_ed_ze_tv  ) { ret = ret "#" pq2_ne_vz_na_ed_ze_tv  [el]; };
   if(el in pq2_ne_vz_na_ed_ze_vi  ) { ret = ret "#" pq2_ne_vz_na_ed_ze_vi  [el]; };
   if(el in pq2_ne_vz_pa_ed_ze_dr  ) { ret = ret "#" pq2_ne_vz_pa_ed_ze_dr  [el]; };
   if(el in pq2_ne_vz_pa_ed_ze_im  ) { ret = ret "#" pq2_ne_vz_pa_ed_ze_im  [el]; };
   if(el in pq2_ne_vz_pa_ed_ze_tv  ) { ret = ret "#" pq2_ne_vz_pa_ed_ze_tv  [el]; };
   if(el in pq2_ne_vz_pa_ed_ze_vi  ) { ret = ret "#" pq2_ne_vz_pa_ed_ze_vi  [el]; };
   if(el in pq2_pe_na_ed_ze_dr     ) { ret = ret "#" pq2_pe_na_ed_ze_dr     [el]; };
   if(el in pq2_pe_na_ed_ze_im     ) { ret = ret "#" pq2_pe_na_ed_ze_im     [el]; };
   if(el in pq2_pe_na_ed_ze_tv     ) { ret = ret "#" pq2_pe_na_ed_ze_tv     [el]; };
   if(el in pq2_pe_na_ed_ze_vi     ) { ret = ret "#" pq2_pe_na_ed_ze_vi     [el]; };
   if(el in pq2_pe_pa_ed_ze_dr     ) { ret = ret "#" pq2_pe_pa_ed_ze_dr     [el]; };
   if(el in pq2_pe_pa_ed_ze_im     ) { ret = ret "#" pq2_pe_pa_ed_ze_im     [el]; };
   if(el in pq2_pe_pa_ed_ze_tv     ) { ret = ret "#" pq2_pe_pa_ed_ze_tv     [el]; };
   if(el in pq2_pe_pa_ed_ze_vi     ) { ret = ret "#" pq2_pe_pa_ed_ze_vi     [el]; };
   if(el in pq2_pe_sd_na_ed_ze_dr  ) { ret = ret "#" pq2_pe_sd_na_ed_ze_dr  [el]; };
   if(el in pq2_pe_sd_na_ed_ze_im  ) { ret = ret "#" pq2_pe_sd_na_ed_ze_im  [el]; };
   if(el in pq2_pe_sd_na_ed_ze_tv  ) { ret = ret "#" pq2_pe_sd_na_ed_ze_tv  [el]; };
   if(el in pq2_pe_sd_na_ed_ze_vi  ) { ret = ret "#" pq2_pe_sd_na_ed_ze_vi  [el]; };
   if(el in pq2_pe_sd_pa_ed_ze_dr  ) { ret = ret "#" pq2_pe_sd_pa_ed_ze_dr  [el]; };
   if(el in pq2_pe_sd_pa_ed_ze_im  ) { ret = ret "#" pq2_pe_sd_pa_ed_ze_im  [el]; };
   if(el in pq2_pe_sd_pa_ed_ze_tv  ) { ret = ret "#" pq2_pe_sd_pa_ed_ze_tv  [el]; };
   if(el in pq2_pe_sd_pa_ed_ze_vi  ) { ret = ret "#" pq2_pe_sd_pa_ed_ze_vi  [el]; };
   if(el in pq2_pn_na_ed_ze_dr     ) { ret = ret "#" pq2_pn_na_ed_ze_dr     [el]; };
   if(el in pq2_pn_na_ed_ze_im     ) { ret = ret "#" pq2_pn_na_ed_ze_im     [el]; };
   if(el in pq2_pn_na_ed_ze_tv     ) { ret = ret "#" pq2_pn_na_ed_ze_tv     [el]; };
   if(el in pq2_pn_na_ed_ze_vi     ) { ret = ret "#" pq2_pn_na_ed_ze_vi     [el]; };
   if(el in pq2_pn_pa_ed_ze_dr     ) { ret = ret "#" pq2_pn_pa_ed_ze_dr     [el]; };
   if(el in pq2_pn_pa_ed_ze_im     ) { ret = ret "#" pq2_pn_pa_ed_ze_im     [el]; };
   if(el in pq2_pn_pa_ed_ze_tv     ) { ret = ret "#" pq2_pn_pa_ed_ze_tv     [el]; };
   if(el in pq2_pn_pa_ed_ze_vi     ) { ret = ret "#" pq2_pn_pa_ed_ze_vi     [el]; };
   if(el in pqn_ne_na_ed_ze_dr     ) { ret = ret "#" pqn_ne_na_ed_ze_dr     [el]; };
   if(el in pqn_ne_na_ed_ze_im     ) { ret = ret "#" pqn_ne_na_ed_ze_im     [el]; };
   if(el in pqn_ne_na_ed_ze_tv     ) { ret = ret "#" pqn_ne_na_ed_ze_tv     [el]; };
   if(el in pqn_ne_na_ed_ze_vi     ) { ret = ret "#" pqn_ne_na_ed_ze_vi     [el]; };
   if(el in pqn_ne_pa_ed_ze_dr     ) { ret = ret "#" pqn_ne_pa_ed_ze_dr     [el]; };
   if(el in pqn_ne_pa_ed_ze_im     ) { ret = ret "#" pqn_ne_pa_ed_ze_im     [el]; };
   if(el in pqn_ne_pa_ed_ze_tv     ) { ret = ret "#" pqn_ne_pa_ed_ze_tv     [el]; };
   if(el in pqn_ne_pa_ed_ze_vi     ) { ret = ret "#" pqn_ne_pa_ed_ze_vi     [el]; };
   if(el in pqn_ne_vz_na_ed_ze_dr  ) { ret = ret "#" pqn_ne_vz_na_ed_ze_dr  [el]; };
   if(el in pqn_ne_vz_na_ed_ze_im  ) { ret = ret "#" pqn_ne_vz_na_ed_ze_im  [el]; };
   if(el in pqn_ne_vz_na_ed_ze_tv  ) { ret = ret "#" pqn_ne_vz_na_ed_ze_tv  [el]; };
   if(el in pqn_ne_vz_na_ed_ze_vi  ) { ret = ret "#" pqn_ne_vz_na_ed_ze_vi  [el]; };
   if(el in pqn_ne_vz_pa_ed_ze_dr  ) { ret = ret "#" pqn_ne_vz_pa_ed_ze_dr  [el]; };
   if(el in pqn_ne_vz_pa_ed_ze_im  ) { ret = ret "#" pqn_ne_vz_pa_ed_ze_im  [el]; };
   if(el in pqn_ne_vz_pa_ed_ze_tv  ) { ret = ret "#" pqn_ne_vz_pa_ed_ze_tv  [el]; };
   if(el in pqn_ne_vz_pa_ed_ze_vi  ) { ret = ret "#" pqn_ne_vz_pa_ed_ze_vi  [el]; };
   if(el in pqn_pe_na_ed_ze_dr     ) { ret = ret "#" pqn_pe_na_ed_ze_dr     [el]; };
   if(el in pqn_pe_na_ed_ze_im     ) { ret = ret "#" pqn_pe_na_ed_ze_im     [el]; };
   if(el in pqn_pe_na_ed_ze_tv     ) { ret = ret "#" pqn_pe_na_ed_ze_tv     [el]; };
   if(el in pqn_pe_na_ed_ze_vi     ) { ret = ret "#" pqn_pe_na_ed_ze_vi     [el]; };
   if(el in pqn_pe_pa_ed_ze_dr     ) { ret = ret "#" pqn_pe_pa_ed_ze_dr     [el]; };
   if(el in pqn_pe_pa_ed_ze_im     ) { ret = ret "#" pqn_pe_pa_ed_ze_im     [el]; };
   if(el in pqn_pe_pa_ed_ze_tv     ) { ret = ret "#" pqn_pe_pa_ed_ze_tv     [el]; };
   if(el in pqn_pe_pa_ed_ze_vi     ) { ret = ret "#" pqn_pe_pa_ed_ze_vi     [el]; };
   if(el in pqn_pe_sd_na_ed_ze_dr  ) { ret = ret "#" pqn_pe_sd_na_ed_ze_dr  [el]; };
   if(el in pqn_pe_sd_na_ed_ze_im  ) { ret = ret "#" pqn_pe_sd_na_ed_ze_im  [el]; };
   if(el in pqn_pe_sd_na_ed_ze_tv  ) { ret = ret "#" pqn_pe_sd_na_ed_ze_tv  [el]; };
   if(el in pqn_pe_sd_na_ed_ze_vi  ) { ret = ret "#" pqn_pe_sd_na_ed_ze_vi  [el]; };
   if(el in pqn_pe_sd_pa_ed_ze_dr  ) { ret = ret "#" pqn_pe_sd_pa_ed_ze_dr  [el]; };
   if(el in pqn_pe_sd_pa_ed_ze_im  ) { ret = ret "#" pqn_pe_sd_pa_ed_ze_im  [el]; };
   if(el in pqn_pe_sd_pa_ed_ze_tv  ) { ret = ret "#" pqn_pe_sd_pa_ed_ze_tv  [el]; };
   if(el in pqn_pe_sd_pa_ed_ze_vi  ) { ret = ret "#" pqn_pe_sd_pa_ed_ze_vi  [el]; };
   if(el in pqn_pn_na_ed_ze_dr     ) { ret = ret "#" pqn_pn_na_ed_ze_dr     [el]; };
   if(el in pqn_pn_na_ed_ze_im     ) { ret = ret "#" pqn_pn_na_ed_ze_im     [el]; };
   if(el in pqn_pn_na_ed_ze_tv     ) { ret = ret "#" pqn_pn_na_ed_ze_tv     [el]; };
   if(el in pqn_pn_na_ed_ze_vi     ) { ret = ret "#" pqn_pn_na_ed_ze_vi     [el]; };
   if(el in pqn_pn_pa_ed_ze_dr     ) { ret = ret "#" pqn_pn_pa_ed_ze_dr     [el]; };
   if(el in pqn_pn_pa_ed_ze_im     ) { ret = ret "#" pqn_pn_pa_ed_ze_im     [el]; };
   if(el in pqn_pn_pa_ed_ze_tv     ) { ret = ret "#" pqn_pn_pa_ed_ze_tv     [el]; };
   if(el in pqn_pn_pa_ed_ze_vi     ) { ret = ret "#" pqn_pn_pa_ed_ze_vi     [el]; };
   if(el in pqs_ne_pa_ed_ze_dr     ) { ret = ret "#" pqs_ne_pa_ed_ze_dr     [el]; };
   if(el in pqs_ne_pa_ed_ze_im     ) { ret = ret "#" pqs_ne_pa_ed_ze_im     [el]; };
   if(el in pqs_ne_pa_ed_ze_tv     ) { ret = ret "#" pqs_ne_pa_ed_ze_tv     [el]; };
   if(el in pqs_ne_pa_ed_ze_vi     ) { ret = ret "#" pqs_ne_pa_ed_ze_vi     [el]; };
   if(el in pqs_ne_vz_pa_ed_ze_dr  ) { ret = ret "#" pqs_ne_vz_pa_ed_ze_dr  [el]; };
   if(el in pqs_ne_vz_pa_ed_ze_im  ) { ret = ret "#" pqs_ne_vz_pa_ed_ze_im  [el]; };
   if(el in pqs_ne_vz_pa_ed_ze_tv  ) { ret = ret "#" pqs_ne_vz_pa_ed_ze_tv  [el]; };
   if(el in pqs_ne_vz_pa_ed_ze_vi  ) { ret = ret "#" pqs_ne_vz_pa_ed_ze_vi  [el]; };
   if(el in pqs_pe_pa_ed_ze_dr     ) { ret = ret "#" pqs_pe_pa_ed_ze_dr     [el]; };
   if(el in pqs_pe_pa_ed_ze_im     ) { ret = ret "#" pqs_pe_pa_ed_ze_im     [el]; };
   if(el in pqs_pe_pa_ed_ze_tv     ) { ret = ret "#" pqs_pe_pa_ed_ze_tv     [el]; };
   if(el in pqs_pe_pa_ed_ze_vi     ) { ret = ret "#" pqs_pe_pa_ed_ze_vi     [el]; };
   if(el in pqs_pe_sd_pa_ed_ze_dr  ) { ret = ret "#" pqs_pe_sd_pa_ed_ze_dr  [el]; };
   if(el in pqs_pe_sd_pa_ed_ze_im  ) { ret = ret "#" pqs_pe_sd_pa_ed_ze_im  [el]; };
   if(el in pqs_pe_sd_pa_ed_ze_tv  ) { ret = ret "#" pqs_pe_sd_pa_ed_ze_tv  [el]; };
   if(el in pqs_pe_sd_pa_ed_ze_vi  ) { ret = ret "#" pqs_pe_sd_pa_ed_ze_vi  [el]; };
   if(el in pqs_pn_pa_ed_ze_dr     ) { ret = ret "#" pqs_pn_pa_ed_ze_dr     [el]; };
   if(el in pqs_pn_pa_ed_ze_im     ) { ret = ret "#" pqs_pn_pa_ed_ze_im     [el]; };
   if(el in pqs_pn_pa_ed_ze_tv     ) { ret = ret "#" pqs_pn_pa_ed_ze_tv     [el]; };
   if(el in pqs_pn_pa_ed_ze_vi     ) { ret = ret "#" pqs_pn_pa_ed_ze_vi     [el]; };
   if(el in pq2_na_kred_mu         ) { ret = ret "#" pq2_na_kred_mu         [el]; };
   if(el in pq2_na_kred_sr         ) { ret = ret "#" pq2_na_kred_sr         [el]; };
   if(el in pq2_na_kred_ze         ) { ret = ret "#" pq2_na_kred_ze         [el]; };
   if(el in pq2_na_krmn            ) { ret = ret "#" pq2_na_krmn            [el]; };
   if(el in pq2_pa_kred_mu         ) { ret = ret "#" pq2_pa_kred_mu         [el]; };
   if(el in pq2_pa_kred_sr         ) { ret = ret "#" pq2_pa_kred_sr         [el]; };
   if(el in pq2_pa_kred_ze         ) { ret = ret "#" pq2_pa_kred_ze         [el]; };
   if(el in pq2_pa_krmn            ) { ret = ret "#" pq2_pa_krmn            [el]; };
   if(el in pqn_na_kred_mu         ) { ret = ret "#" pqn_na_kred_mu         [el]; };
   if(el in pqn_na_kred_sr         ) { ret = ret "#" pqn_na_kred_sr         [el]; };
   if(el in pqn_na_kred_ze         ) { ret = ret "#" pqn_na_kred_ze         [el]; };
   if(el in pqn_na_krmn            ) { ret = ret "#" pqn_na_krmn            [el]; };
   if(el in pqn_pa_kred_mu         ) { ret = ret "#" pqn_pa_kred_mu         [el]; };
   if(el in pqn_pa_kred_sr         ) { ret = ret "#" pqn_pa_kred_sr         [el]; };
   if(el in pqn_pa_kred_ze         ) { ret = ret "#" pqn_pa_kred_ze         [el]; };
   if(el in pqn_pa_krmn            ) { ret = ret "#" pqn_pa_krmn            [el]; };
   if(el in pqs_pa_kred_mu         ) { ret = ret "#" pqs_pa_kred_mu         [el]; };
   if(el in pqs_pa_kred_sr         ) { ret = ret "#" pqs_pa_kred_sr         [el]; };
   if(el in pqs_pa_kred_ze         ) { ret = ret "#" pqs_pa_kred_ze         [el]; };
   if(el in pqs_pa_krmn            ) { ret = ret "#" pqs_pa_krmn            [el]; };
   if(el in pq2_ne_na_mn_da        ) { ret = ret "#" pq2_ne_na_mn_da        [el]; };
   if(el in pq2_ne_na_mn_im        ) { ret = ret "#" pq2_ne_na_mn_im        [el]; };
   if(el in pq2_ne_na_mn_ro        ) { ret = ret "#" pq2_ne_na_mn_ro        [el]; };
   if(el in pq2_ne_na_mn_tv        ) { ret = ret "#" pq2_ne_na_mn_tv        [el]; };
   if(el in pq2_ne_pa_mn_da        ) { ret = ret "#" pq2_ne_pa_mn_da        [el]; };
   if(el in pq2_ne_pa_mn_im        ) { ret = ret "#" pq2_ne_pa_mn_im        [el]; };
   if(el in pq2_ne_pa_mn_ro        ) { ret = ret "#" pq2_ne_pa_mn_ro        [el]; };
   if(el in pq2_ne_pa_mn_tv        ) { ret = ret "#" pq2_ne_pa_mn_tv        [el]; };
   if(el in pq2_ne_vz_na_mn_da     ) { ret = ret "#" pq2_ne_vz_na_mn_da     [el]; };
   if(el in pq2_ne_vz_na_mn_im     ) { ret = ret "#" pq2_ne_vz_na_mn_im     [el]; };
   if(el in pq2_ne_vz_na_mn_ro     ) { ret = ret "#" pq2_ne_vz_na_mn_ro     [el]; };
   if(el in pq2_ne_vz_na_mn_tv     ) { ret = ret "#" pq2_ne_vz_na_mn_tv     [el]; };
   if(el in pq2_ne_vz_pa_mn_da     ) { ret = ret "#" pq2_ne_vz_pa_mn_da     [el]; };
   if(el in pq2_ne_vz_pa_mn_im     ) { ret = ret "#" pq2_ne_vz_pa_mn_im     [el]; };
   if(el in pq2_ne_vz_pa_mn_ro     ) { ret = ret "#" pq2_ne_vz_pa_mn_ro     [el]; };
   if(el in pq2_ne_vz_pa_mn_tv     ) { ret = ret "#" pq2_ne_vz_pa_mn_tv     [el]; };
   if(el in pq2_pe_na_mn_da        ) { ret = ret "#" pq2_pe_na_mn_da        [el]; };
   if(el in pq2_pe_na_mn_im        ) { ret = ret "#" pq2_pe_na_mn_im        [el]; };
   if(el in pq2_pe_na_mn_ro        ) { ret = ret "#" pq2_pe_na_mn_ro        [el]; };
   if(el in pq2_pe_na_mn_tv        ) { ret = ret "#" pq2_pe_na_mn_tv        [el]; };
   if(el in pq2_pe_pa_mn_da        ) { ret = ret "#" pq2_pe_pa_mn_da        [el]; };
   if(el in pq2_pe_pa_mn_im        ) { ret = ret "#" pq2_pe_pa_mn_im        [el]; };
   if(el in pq2_pe_pa_mn_ro        ) { ret = ret "#" pq2_pe_pa_mn_ro        [el]; };
   if(el in pq2_pe_pa_mn_tv        ) { ret = ret "#" pq2_pe_pa_mn_tv        [el]; };
   if(el in pq2_pe_sd_na_mn_da     ) { ret = ret "#" pq2_pe_sd_na_mn_da     [el]; };
   if(el in pq2_pe_sd_na_mn_im     ) { ret = ret "#" pq2_pe_sd_na_mn_im     [el]; };
   if(el in pq2_pe_sd_na_mn_ro     ) { ret = ret "#" pq2_pe_sd_na_mn_ro     [el]; };
   if(el in pq2_pe_sd_na_mn_tv     ) { ret = ret "#" pq2_pe_sd_na_mn_tv     [el]; };
   if(el in pq2_pe_sd_pa_mn_da     ) { ret = ret "#" pq2_pe_sd_pa_mn_da     [el]; };
   if(el in pq2_pe_sd_pa_mn_im     ) { ret = ret "#" pq2_pe_sd_pa_mn_im     [el]; };
   if(el in pq2_pe_sd_pa_mn_ro     ) { ret = ret "#" pq2_pe_sd_pa_mn_ro     [el]; };
   if(el in pq2_pe_sd_pa_mn_tv     ) { ret = ret "#" pq2_pe_sd_pa_mn_tv     [el]; };
   if(el in pq2_pn_na_mn_da        ) { ret = ret "#" pq2_pn_na_mn_da        [el]; };
   if(el in pq2_pn_na_mn_im        ) { ret = ret "#" pq2_pn_na_mn_im        [el]; };
   if(el in pq2_pn_na_mn_ro        ) { ret = ret "#" pq2_pn_na_mn_ro        [el]; };
   if(el in pq2_pn_na_mn_tv        ) { ret = ret "#" pq2_pn_na_mn_tv        [el]; };
   if(el in pq2_pn_pa_mn_da        ) { ret = ret "#" pq2_pn_pa_mn_da        [el]; };
   if(el in pq2_pn_pa_mn_im        ) { ret = ret "#" pq2_pn_pa_mn_im        [el]; };
   if(el in pq2_pn_pa_mn_ro        ) { ret = ret "#" pq2_pn_pa_mn_ro        [el]; };
   if(el in pq2_pn_pa_mn_tv        ) { ret = ret "#" pq2_pn_pa_mn_tv        [el]; };
   if(el in pqn_ne_na_mn_da        ) { ret = ret "#" pqn_ne_na_mn_da        [el]; };
   if(el in pqn_ne_na_mn_im        ) { ret = ret "#" pqn_ne_na_mn_im        [el]; };
   if(el in pqn_ne_na_mn_ro        ) { ret = ret "#" pqn_ne_na_mn_ro        [el]; };
   if(el in pqn_ne_na_mn_tv        ) { ret = ret "#" pqn_ne_na_mn_tv        [el]; };
   if(el in pqn_ne_pa_mn_da        ) { ret = ret "#" pqn_ne_pa_mn_da        [el]; };
   if(el in pqn_ne_pa_mn_im        ) { ret = ret "#" pqn_ne_pa_mn_im        [el]; };
   if(el in pqn_ne_pa_mn_ro        ) { ret = ret "#" pqn_ne_pa_mn_ro        [el]; };
   if(el in pqn_ne_pa_mn_tv        ) { ret = ret "#" pqn_ne_pa_mn_tv        [el]; };
   if(el in pqn_ne_vz_na_mn_da     ) { ret = ret "#" pqn_ne_vz_na_mn_da     [el]; };
   if(el in pqn_ne_vz_na_mn_im     ) { ret = ret "#" pqn_ne_vz_na_mn_im     [el]; };
   if(el in pqn_ne_vz_na_mn_ro     ) { ret = ret "#" pqn_ne_vz_na_mn_ro     [el]; };
   if(el in pqn_ne_vz_na_mn_tv     ) { ret = ret "#" pqn_ne_vz_na_mn_tv     [el]; };
   if(el in pqn_ne_vz_pa_mn_da     ) { ret = ret "#" pqn_ne_vz_pa_mn_da     [el]; };
   if(el in pqn_ne_vz_pa_mn_im     ) { ret = ret "#" pqn_ne_vz_pa_mn_im     [el]; };
   if(el in pqn_ne_vz_pa_mn_ro     ) { ret = ret "#" pqn_ne_vz_pa_mn_ro     [el]; };
   if(el in pqn_ne_vz_pa_mn_tv     ) { ret = ret "#" pqn_ne_vz_pa_mn_tv     [el]; };
   if(el in pqn_pe_na_mn_da        ) { ret = ret "#" pqn_pe_na_mn_da        [el]; };
   if(el in pqn_pe_na_mn_im        ) { ret = ret "#" pqn_pe_na_mn_im        [el]; };
   if(el in pqn_pe_na_mn_ro        ) { ret = ret "#" pqn_pe_na_mn_ro        [el]; };
   if(el in pqn_pe_na_mn_tv        ) { ret = ret "#" pqn_pe_na_mn_tv        [el]; };
   if(el in pqn_pe_pa_mn_da        ) { ret = ret "#" pqn_pe_pa_mn_da        [el]; };
   if(el in pqn_pe_pa_mn_im        ) { ret = ret "#" pqn_pe_pa_mn_im        [el]; };
   if(el in pqn_pe_pa_mn_ro        ) { ret = ret "#" pqn_pe_pa_mn_ro        [el]; };
   if(el in pqn_pe_pa_mn_tv        ) { ret = ret "#" pqn_pe_pa_mn_tv        [el]; };
   if(el in pqn_pe_sd_na_mn_da     ) { ret = ret "#" pqn_pe_sd_na_mn_da     [el]; };
   if(el in pqn_pe_sd_na_mn_im     ) { ret = ret "#" pqn_pe_sd_na_mn_im     [el]; };
   if(el in pqn_pe_sd_na_mn_ro     ) { ret = ret "#" pqn_pe_sd_na_mn_ro     [el]; };
   if(el in pqn_pe_sd_na_mn_tv     ) { ret = ret "#" pqn_pe_sd_na_mn_tv     [el]; };
   if(el in pqn_pe_sd_pa_mn_da     ) { ret = ret "#" pqn_pe_sd_pa_mn_da     [el]; };
   if(el in pqn_pe_sd_pa_mn_im     ) { ret = ret "#" pqn_pe_sd_pa_mn_im     [el]; };
   if(el in pqn_pe_sd_pa_mn_ro     ) { ret = ret "#" pqn_pe_sd_pa_mn_ro     [el]; };
   if(el in pqn_pe_sd_pa_mn_tv     ) { ret = ret "#" pqn_pe_sd_pa_mn_tv     [el]; };
   if(el in pqn_pn_na_mn_da        ) { ret = ret "#" pqn_pn_na_mn_da        [el]; };
   if(el in pqn_pn_na_mn_im        ) { ret = ret "#" pqn_pn_na_mn_im        [el]; };
   if(el in pqn_pn_na_mn_ro        ) { ret = ret "#" pqn_pn_na_mn_ro        [el]; };
   if(el in pqn_pn_na_mn_tv        ) { ret = ret "#" pqn_pn_na_mn_tv        [el]; };
   if(el in pqn_pn_pa_mn_da        ) { ret = ret "#" pqn_pn_pa_mn_da        [el]; };
   if(el in pqn_pn_pa_mn_im        ) { ret = ret "#" pqn_pn_pa_mn_im        [el]; };
   if(el in pqn_pn_pa_mn_ro        ) { ret = ret "#" pqn_pn_pa_mn_ro        [el]; };
   if(el in pqn_pn_pa_mn_tv        ) { ret = ret "#" pqn_pn_pa_mn_tv        [el]; };
   if(el in pqs_ne_pa_mn_da        ) { ret = ret "#" pqs_ne_pa_mn_da        [el]; };
   if(el in pqs_ne_pa_mn_im        ) { ret = ret "#" pqs_ne_pa_mn_im        [el]; };
   if(el in pqs_ne_pa_mn_ro        ) { ret = ret "#" pqs_ne_pa_mn_ro        [el]; };
   if(el in pqs_ne_pa_mn_tv        ) { ret = ret "#" pqs_ne_pa_mn_tv        [el]; };
   if(el in pqs_ne_vz_pa_mn_da     ) { ret = ret "#" pqs_ne_vz_pa_mn_da     [el]; };
   if(el in pqs_ne_vz_pa_mn_im     ) { ret = ret "#" pqs_ne_vz_pa_mn_im     [el]; };
   if(el in pqs_ne_vz_pa_mn_ro     ) { ret = ret "#" pqs_ne_vz_pa_mn_ro     [el]; };
   if(el in pqs_ne_vz_pa_mn_tv     ) { ret = ret "#" pqs_ne_vz_pa_mn_tv     [el]; };
   if(el in pqs_pe_pa_mn_da        ) { ret = ret "#" pqs_pe_pa_mn_da        [el]; };
   if(el in pqs_pe_pa_mn_im        ) { ret = ret "#" pqs_pe_pa_mn_im        [el]; };
   if(el in pqs_pe_pa_mn_ro        ) { ret = ret "#" pqs_pe_pa_mn_ro        [el]; };
   if(el in pqs_pe_pa_mn_tv        ) { ret = ret "#" pqs_pe_pa_mn_tv        [el]; };
   if(el in pqs_pe_sd_pa_mn_da     ) { ret = ret "#" pqs_pe_sd_pa_mn_da     [el]; };
   if(el in pqs_pe_sd_pa_mn_im     ) { ret = ret "#" pqs_pe_sd_pa_mn_im     [el]; };
   if(el in pqs_pe_sd_pa_mn_ro     ) { ret = ret "#" pqs_pe_sd_pa_mn_ro     [el]; };
   if(el in pqs_pe_sd_pa_mn_tv     ) { ret = ret "#" pqs_pe_sd_pa_mn_tv     [el]; };
   if(el in pqs_pn_pa_mn_da        ) { ret = ret "#" pqs_pn_pa_mn_da        [el]; };
   if(el in pqs_pn_pa_mn_im        ) { ret = ret "#" pqs_pn_pa_mn_im        [el]; };
   if(el in pqs_pn_pa_mn_ro        ) { ret = ret "#" pqs_pn_pa_mn_ro        [el]; };
   if(el in pqs_pn_pa_mn_tv        ) { ret = ret "#" pqs_pn_pa_mn_tv        [el]; };
   if(el in pred_da                ) { ret = ret "#" pred_da                [el]; };
   if(el in pred_im                ) { ret = ret "#" pred_im                [el]; };
   if(el in pred_pr                ) { ret = ret "#" pred_pr                [el]; };
   if(el in pred_ro                ) { ret = ret "#" pred_ro                [el]; };
   if(el in pred_tv                ) { ret = ret "#" pred_tv                [el]; };
   if(el in pred_vi                ) { ret = ret "#" pred_vi                [el]; };
   if(el in predk                  ) { ret = ret "#" predk                  [el]; };
   if(el in qall                   ) { ret = ret "#" qall                   [el]; };
   if(el in qko_da                 ) { ret = ret "#" qko_da                 [el]; };
   if(el in qko_ed_mu_da           ) { ret = ret "#" qko_ed_mu_da           [el]; };
   if(el in qko_ed_mu_im           ) { ret = ret "#" qko_ed_mu_im           [el]; };
   if(el in qko_ed_mu_pr           ) { ret = ret "#" qko_ed_mu_pr           [el]; };
   if(el in qko_ed_mu_ro           ) { ret = ret "#" qko_ed_mu_ro           [el]; };
   if(el in qko_ed_mu_tv           ) { ret = ret "#" qko_ed_mu_tv           [el]; };
   if(el in qko_ed_mu_vi           ) { ret = ret "#" qko_ed_mu_vi           [el]; };
   if(el in qko_ed_sr_da           ) { ret = ret "#" qko_ed_sr_da           [el]; };
   if(el in qko_ed_sr_im           ) { ret = ret "#" qko_ed_sr_im           [el]; };
   if(el in qko_ed_sr_pr           ) { ret = ret "#" qko_ed_sr_pr           [el]; };
   if(el in qko_ed_sr_ro           ) { ret = ret "#" qko_ed_sr_ro           [el]; };
   if(el in qko_ed_sr_tv           ) { ret = ret "#" qko_ed_sr_tv           [el]; };
   if(el in qko_ed_sr_vi           ) { ret = ret "#" qko_ed_sr_vi           [el]; };
   if(el in qko_ed_ze_da           ) { ret = ret "#" qko_ed_ze_da           [el]; };
   if(el in qko_ed_ze_im           ) { ret = ret "#" qko_ed_ze_im           [el]; };
   if(el in qko_ed_ze_pr           ) { ret = ret "#" qko_ed_ze_pr           [el]; };
   if(el in qko_ed_ze_ro           ) { ret = ret "#" qko_ed_ze_ro           [el]; };
   if(el in qko_ed_ze_tv           ) { ret = ret "#" qko_ed_ze_tv           [el]; };
   if(el in qko_ed_ze_vi           ) { ret = ret "#" qko_ed_ze_vi           [el]; };
   if(el in qko_im                 ) { ret = ret "#" qko_im                 [el]; };
   if(el in qko_mn_da              ) { ret = ret "#" qko_mn_da              [el]; };
   if(el in qko_mn_im              ) { ret = ret "#" qko_mn_im              [el]; };
   if(el in qko_mn_pr              ) { ret = ret "#" qko_mn_pr              [el]; };
   if(el in qko_mn_ro              ) { ret = ret "#" qko_mn_ro              [el]; };
   if(el in qko_mn_tv              ) { ret = ret "#" qko_mn_tv              [el]; };
   if(el in qko_mn_vi              ) { ret = ret "#" qko_mn_vi              [el]; };
   if(el in qko_pr                 ) { ret = ret "#" qko_pr                 [el]; };
   if(el in qko_ro                 ) { ret = ret "#" qko_ro                 [el]; };
   if(el in qko_tv                 ) { ret = ret "#" qko_tv                 [el]; };
   if(el in qko_vi                 ) { ret = ret "#" qko_vi                 [el]; };
   if(el in qko_ze_im              ) { ret = ret "#" qko_ze_im              [el]; };
   if(el in qko_ze_vi              ) { ret = ret "#" qko_ze_vi              [el]; };
   if(el in qne_da                 ) { ret = ret "#" qne_da                 [el]; };
   if(el in qne_im                 ) { ret = ret "#" qne_im                 [el]; };
   if(el in qne_pr                 ) { ret = ret "#" qne_pr                 [el]; };
   if(el in qne_ro                 ) { ret = ret "#" qne_ro                 [el]; };
   if(el in qne_tv                 ) { ret = ret "#" qne_tv                 [el]; };
   if(el in qne_vi                 ) { ret = ret "#" qne_vi                 [el]; };
   if(el in qpo_ed_mu_da           ) { ret = ret "#" qpo_ed_mu_da           [el]; };
   if(el in qpo_ed_mu_im           ) { ret = ret "#" qpo_ed_mu_im           [el]; };
   if(el in qpo_ed_mu_pr           ) { ret = ret "#" qpo_ed_mu_pr           [el]; };
   if(el in qpo_ed_mu_ro           ) { ret = ret "#" qpo_ed_mu_ro           [el]; };
   if(el in qpo_ed_mu_tv           ) { ret = ret "#" qpo_ed_mu_tv           [el]; };
   if(el in qpo_ed_sr_da           ) { ret = ret "#" qpo_ed_sr_da           [el]; };
   if(el in qpo_ed_sr_im           ) { ret = ret "#" qpo_ed_sr_im           [el]; };
   if(el in qpo_ed_sr_pr           ) { ret = ret "#" qpo_ed_sr_pr           [el]; };
   if(el in qpo_ed_sr_ro           ) { ret = ret "#" qpo_ed_sr_ro           [el]; };
   if(el in qpo_ed_sr_tv           ) { ret = ret "#" qpo_ed_sr_tv           [el]; };
   if(el in qpo_ed_sr_vi           ) { ret = ret "#" qpo_ed_sr_vi           [el]; };
   if(el in qpo_ed_ze_da           ) { ret = ret "#" qpo_ed_ze_da           [el]; };
   if(el in qpo_ed_ze_im           ) { ret = ret "#" qpo_ed_ze_im           [el]; };
   if(el in qpo_ed_ze_pr           ) { ret = ret "#" qpo_ed_ze_pr           [el]; };
   if(el in qpo_ed_ze_ro           ) { ret = ret "#" qpo_ed_ze_ro           [el]; };
   if(el in qpo_ed_ze_tv           ) { ret = ret "#" qpo_ed_ze_tv           [el]; };
   if(el in qpo_ed_ze_vi           ) { ret = ret "#" qpo_ed_ze_vi           [el]; };
   if(el in qpo_mn_da              ) { ret = ret "#" qpo_mn_da              [el]; };
   if(el in qpo_mn_im              ) { ret = ret "#" qpo_mn_im              [el]; };
   if(el in qpo_mn_pr              ) { ret = ret "#" qpo_mn_pr              [el]; };
   if(el in qpo_mn_ro              ) { ret = ret "#" qpo_mn_ro              [el]; };
   if(el in qpo_mn_tv              ) { ret = ret "#" qpo_mn_tv              [el]; };
   if(el in qso_da                 ) { ret = ret "#" qso_da                 [el]; };
   if(el in qso_im                 ) { ret = ret "#" qso_im                 [el]; };
   if(el in qso_mu_da              ) { ret = ret "#" qso_mu_da              [el]; };
   if(el in qso_mu_im              ) { ret = ret "#" qso_mu_im              [el]; };
   if(el in qso_mu_pr              ) { ret = ret "#" qso_mu_pr              [el]; };
   if(el in qso_mu_ro              ) { ret = ret "#" qso_mu_ro              [el]; };
   if(el in qso_mu_tv              ) { ret = ret "#" qso_mu_tv              [el]; };
   if(el in qso_mu_vi              ) { ret = ret "#" qso_mu_vi              [el]; };
   if(el in qso_pr                 ) { ret = ret "#" qso_pr                 [el]; };
   if(el in qso_ro                 ) { ret = ret "#" qso_ro                 [el]; };
   if(el in qso_sr_da              ) { ret = ret "#" qso_sr_da              [el]; };
   if(el in qso_sr_im              ) { ret = ret "#" qso_sr_im              [el]; };
   if(el in qso_sr_pr              ) { ret = ret "#" qso_sr_pr              [el]; };
   if(el in qso_sr_ro              ) { ret = ret "#" qso_sr_ro              [el]; };
   if(el in qso_sr_tv              ) { ret = ret "#" qso_sr_tv              [el]; };
   if(el in qso_sr_vi              ) { ret = ret "#" qso_sr_vi              [el]; };
   if(el in qso_tv                 ) { ret = ret "#" qso_tv                 [el]; };
   if(el in qso_vi                 ) { ret = ret "#" qso_vi                 [el]; };
   if(el in qso_ze_da              ) { ret = ret "#" qso_ze_da              [el]; };
   if(el in qso_ze_im              ) { ret = ret "#" qso_ze_im              [el]; };
   if(el in qso_ze_pr              ) { ret = ret "#" qso_ze_pr              [el]; };
   if(el in qso_ze_ro              ) { ret = ret "#" qso_ze_ro              [el]; };
   if(el in qso_ze_tv              ) { ret = ret "#" qso_ze_tv              [el]; };
   if(el in qso_ze_vi              ) { ret = ret "#" qso_ze_vi              [el]; };
   if(el in qst                    ) { ret = ret "#" qst                    [el]; };
   if(el in suyz                   ) { ret = ret "#" suyz                   [el]; };
   if(el in sw_edmu_da             ) { ret = ret "#" sw_edmu_da             [el]; };
   if(el in sw_edmu_im             ) { ret = ret "#" sw_edmu_im             [el]; };
   if(el in sw_edmu_ne             ) { ret = ret "#" sw_edmu_ne             [el]; };
   if(el in sw_edmu_pr             ) { ret = ret "#" sw_edmu_pr             [el]; };
   if(el in sw_edmu_ro             ) { ret = ret "#" sw_edmu_ro             [el]; };
   if(el in sw_edmu_tv             ) { ret = ret "#" sw_edmu_tv             [el]; };
   if(el in sw_edmu_vi             ) { ret = ret "#" sw_edmu_vi             [el]; };
   if(el in sw_edob_da             ) { ret = ret "#" sw_edob_da             [el]; };
   if(el in sw_edob_im             ) { ret = ret "#" sw_edob_im             [el]; };
   if(el in sw_edob_ne             ) { ret = ret "#" sw_edob_ne             [el]; };
   if(el in sw_edob_pr             ) { ret = ret "#" sw_edob_pr             [el]; };
   if(el in sw_edob_ro             ) { ret = ret "#" sw_edob_ro             [el]; };
   if(el in sw_edob_tv             ) { ret = ret "#" sw_edob_tv             [el]; };
   if(el in sw_edob_vi             ) { ret = ret "#" sw_edob_vi             [el]; };
   if(el in sw_edsr_da             ) { ret = ret "#" sw_edsr_da             [el]; };
   if(el in sw_edsr_im             ) { ret = ret "#" sw_edsr_im             [el]; };
   if(el in sw_edsr_pr             ) { ret = ret "#" sw_edsr_pr             [el]; };
   if(el in sw_edsr_ro             ) { ret = ret "#" sw_edsr_ro             [el]; };
   if(el in sw_edsr_tv             ) { ret = ret "#" sw_edsr_tv             [el]; };
   if(el in sw_edsr_vi             ) { ret = ret "#" sw_edsr_vi             [el]; };
   if(el in sw_edze_da             ) { ret = ret "#" sw_edze_da             [el]; };
   if(el in sw_edze_im             ) { ret = ret "#" sw_edze_im             [el]; };
   if(el in sw_edze_pr             ) { ret = ret "#" sw_edze_pr             [el]; };
   if(el in sw_edze_ro             ) { ret = ret "#" sw_edze_ro             [el]; };
   if(el in sw_edze_tv             ) { ret = ret "#" sw_edze_tv             [el]; };
   if(el in sw_edze_vi             ) { ret = ret "#" sw_edze_vi             [el]; };
   if(el in sw_mn_da               ) { ret = ret "#" sw_mn_da               [el]; };
   if(el in sw_mn_im               ) { ret = ret "#" sw_mn_im               [el]; };
   if(el in sw_mn_ne               ) { ret = ret "#" sw_mn_ne               [el]; };
   if(el in sw_mn_pr               ) { ret = ret "#" sw_mn_pr               [el]; };
   if(el in sw_mn_ro               ) { ret = ret "#" sw_mn_ro               [el]; };
   if(el in sw_mn_tv               ) { ret = ret "#" sw_mn_tv               [el]; };
   if(el in sw_mn_vi               ) { ret = ret "#" sw_mn_vi               [el]; };
   if(el in swn_edmu_da            ) { ret = ret "#" swn_edmu_da            [el]; };
   if(el in swn_edmu_im            ) { ret = ret "#" swn_edmu_im            [el]; };
   if(el in swn_edmu_me            ) { ret = ret "#" swn_edmu_me            [el]; };
   if(el in swn_edmu_ne            ) { ret = ret "#" swn_edmu_ne            [el]; };
   if(el in swn_edmu_pr            ) { ret = ret "#" swn_edmu_pr            [el]; };
   if(el in swn_edmu_pt            ) { ret = ret "#" swn_edmu_pt            [el]; };
   if(el in swn_edmu_ro            ) { ret = ret "#" swn_edmu_ro            [el]; };
   if(el in swn_edmu_sq            ) { ret = ret "#" swn_edmu_sq            [el]; };
   if(el in swn_edmu_tv            ) { ret = ret "#" swn_edmu_tv            [el]; };
   if(el in swn_edob_da            ) { ret = ret "#" swn_edob_da            [el]; };
   if(el in swn_edob_im            ) { ret = ret "#" swn_edob_im            [el]; };
   if(el in swn_edob_ne            ) { ret = ret "#" swn_edob_ne            [el]; };
   if(el in swn_edob_pr            ) { ret = ret "#" swn_edob_pr            [el]; };
   if(el in swn_edob_ro            ) { ret = ret "#" swn_edob_ro            [el]; };
   if(el in swn_edob_tv            ) { ret = ret "#" swn_edob_tv            [el]; };
   if(el in swn_edob_vi            ) { ret = ret "#" swn_edob_vi            [el]; };
   if(el in swn_edsr_da            ) { ret = ret "#" swn_edsr_da            [el]; };
   if(el in swn_edsr_im            ) { ret = ret "#" swn_edsr_im            [el]; };
   if(el in swn_edsr_ne            ) { ret = ret "#" swn_edsr_ne            [el]; };
   if(el in swn_edsr_pr            ) { ret = ret "#" swn_edsr_pr            [el]; };
   if(el in swn_edsr_ro            ) { ret = ret "#" swn_edsr_ro            [el]; };
   if(el in swn_edsr_tv            ) { ret = ret "#" swn_edsr_tv            [el]; };
   if(el in swn_edsr_vi            ) { ret = ret "#" swn_edsr_vi            [el]; };
   if(el in swn_edze_da            ) { ret = ret "#" swn_edze_da            [el]; };
   if(el in swn_edze_im            ) { ret = ret "#" swn_edze_im            [el]; };
   if(el in swn_edze_me            ) { ret = ret "#" swn_edze_me            [el]; };
   if(el in swn_edze_ne            ) { ret = ret "#" swn_edze_ne            [el]; };
   if(el in swn_edze_pr            ) { ret = ret "#" swn_edze_pr            [el]; };
   if(el in swn_edze_ro            ) { ret = ret "#" swn_edze_ro            [el]; };
   if(el in swn_edze_tv            ) { ret = ret "#" swn_edze_tv            [el]; };
   if(el in swn_edze_vi            ) { ret = ret "#" swn_edze_vi            [el]; };
   if(el in swn_mn_da              ) { ret = ret "#" swn_mn_da              [el]; };
   if(el in swn_mn_im              ) { ret = ret "#" swn_mn_im              [el]; };
   if(el in swn_mn_ne              ) { ret = ret "#" swn_mn_ne              [el]; };
   if(el in swn_mn_pr              ) { ret = ret "#" swn_mn_pr              [el]; };
   if(el in swn_mn_ro              ) { ret = ret "#" swn_mn_ro              [el]; };
   if(el in swn_mn_sq              ) { ret = ret "#" swn_mn_sq              [el]; };
   if(el in swn_mn_tv              ) { ret = ret "#" swn_mn_tv              [el]; };
   if(el in swo_edmu_da            ) { ret = ret "#" swo_edmu_da            [el]; };
   if(el in swo_edmu_im            ) { ret = ret "#" swo_edmu_im            [el]; };
   if(el in swo_edmu_ne            ) { ret = ret "#" swo_edmu_ne            [el]; };
   if(el in swo_edmu_pr            ) { ret = ret "#" swo_edmu_pr            [el]; };
   if(el in swo_edmu_ro            ) { ret = ret "#" swo_edmu_ro            [el]; };
   if(el in swo_edmu_tv            ) { ret = ret "#" swo_edmu_tv            [el]; };
   if(el in swo_edmu_vi            ) { ret = ret "#" swo_edmu_vi            [el]; };
   if(el in swo_edmu_zv            ) { ret = ret "#" swo_edmu_zv            [el]; };
   if(el in swo_edob_da            ) { ret = ret "#" swo_edob_da            [el]; };
   if(el in swo_edob_im            ) { ret = ret "#" swo_edob_im            [el]; };
   if(el in swo_edob_ne            ) { ret = ret "#" swo_edob_ne            [el]; };
   if(el in swo_edob_pr            ) { ret = ret "#" swo_edob_pr            [el]; };
   if(el in swo_edob_ro            ) { ret = ret "#" swo_edob_ro            [el]; };
   if(el in swo_edob_tv            ) { ret = ret "#" swo_edob_tv            [el]; };
   if(el in swo_edob_vi            ) { ret = ret "#" swo_edob_vi            [el]; };
   if(el in swo_edob_zv            ) { ret = ret "#" swo_edob_zv            [el]; };
   if(el in swo_edsr_da            ) { ret = ret "#" swo_edsr_da            [el]; };
   if(el in swo_edsr_im            ) { ret = ret "#" swo_edsr_im            [el]; };
   if(el in swo_edsr_pr            ) { ret = ret "#" swo_edsr_pr            [el]; };
   if(el in swo_edsr_ro            ) { ret = ret "#" swo_edsr_ro            [el]; };
   if(el in swo_edsr_tv            ) { ret = ret "#" swo_edsr_tv            [el]; };
   if(el in swo_edsr_vi            ) { ret = ret "#" swo_edsr_vi            [el]; };
   if(el in swo_edsr_ne            ) { ret = ret "#" swo_edsr_ne            [el]; };
   if(el in swo_edze_da            ) { ret = ret "#" swo_edze_da            [el]; };
   if(el in swo_edze_im            ) { ret = ret "#" swo_edze_im            [el]; };
   if(el in swo_edze_ne            ) { ret = ret "#" swo_edze_ne            [el]; };
   if(el in swo_edze_pr            ) { ret = ret "#" swo_edze_pr            [el]; };
   if(el in swo_edze_ro            ) { ret = ret "#" swo_edze_ro            [el]; };
   if(el in swo_edze_tv            ) { ret = ret "#" swo_edze_tv            [el]; };
   if(el in swo_edze_vi            ) { ret = ret "#" swo_edze_vi            [el]; };
   if(el in swo_edze_zv            ) { ret = ret "#" swo_edze_zv            [el]; };
   if(el in swo_mn_da              ) { ret = ret "#" swo_mn_da              [el]; };
   if(el in swo_mn_im              ) { ret = ret "#" swo_mn_im              [el]; };
   if(el in swo_mn_ne              ) { ret = ret "#" swo_mn_ne              [el]; };
   if(el in swo_mn_pr              ) { ret = ret "#" swo_mn_pr              [el]; };
   if(el in swo_mn_ro              ) { ret = ret "#" swo_mn_ro              [el]; };
   if(el in swo_mn_sq              ) { ret = ret "#" swo_mn_sq              [el]; };
   if(el in swo_mn_tv              ) { ret = ret "#" swo_mn_tv              [el]; };
   if(el in vvodn                  ) { ret = ret "#" vvodn                  [el]; };
                                                                              
#  if(el in gc_ed                  ) { ret = ret "#" gc_ed                  [el]; };
#  if(el in gc_in                  ) { ret = ret "#" gc_in                  [el]; };
#  if(el in gc_mn                  ) { ret = ret "#" gc_mn                  [el]; };
#  if(el in gc_po                  ) { ret = ret "#" gc_po                  [el]; };
#  if(el in geo_edsrim             ) { ret = ret "#" geo_edsrim             [el]; };
#  if(el in geo_mnim               ) { ret = ret "#" geo_mnim               [el]; };
   if(el in md_bz                  ) { ret = ret "#" md_bz                  [el]; };
   if(el in md_ed                  ) { ret = ret "#" md_ed                  [el]; };
   if(el in md_mn                  ) { ret = ret "#" md_mn                  [el]; };
   if(el in gla_be                 ) { ret = ret "#" gla_be                 [el]; };
   if(el in titl                   ) { ret = ret "#" titl                   [el]; };
#  if(el in muc_edmuda             ) { ret = ret "#" muc_edmuda             [el]; };
#  if(el in muc_edmuim             ) { ret = ret "#" muc_edmuim             [el]; };
#  if(el in muc_edmupr             ) { ret = ret "#" muc_edmupr             [el]; };
#  if(el in muc_edmuro             ) { ret = ret "#" muc_edmuro             [el]; };
#  if(el in muc_edmutv             ) { ret = ret "#" muc_edmutv             [el]; };
#  if(el in muc_edmuvi             ) { ret = ret "#" muc_edmuvi             [el]; };
#  if(el in muc_edsrda             ) { ret = ret "#" muc_edsrda             [el]; };
#  if(el in muc_edsrim             ) { ret = ret "#" muc_edsrim             [el]; };
#  if(el in muc_edsrpr             ) { ret = ret "#" muc_edsrpr             [el]; };
#  if(el in muc_edsrro             ) { ret = ret "#" muc_edsrro             [el]; };
#  if(el in muc_edsrtv             ) { ret = ret "#" muc_edsrtv             [el]; };
#  if(el in muc_edsrvi             ) { ret = ret "#" muc_edsrvi             [el]; };
#  if(el in muc_edzeda             ) { ret = ret "#" muc_edzeda             [el]; };
#  if(el in muc_edzeim             ) { ret = ret "#" muc_edzeim             [el]; };
#  if(el in muc_edzepr             ) { ret = ret "#" muc_edzepr             [el]; };
#  if(el in muc_edzero             ) { ret = ret "#" muc_edzero             [el]; };
#  if(el in muc_edzetv             ) { ret = ret "#" muc_edzetv             [el]; };
#  if(el in muc_edzevi             ) { ret = ret "#" muc_edzevi             [el]; };
#  if(el in muc_mnda               ) { ret = ret "#" muc_mnda               [el]; };
#  if(el in muc_mnim               ) { ret = ret "#" muc_mnim               [el]; };
#  if(el in muc_mnpr               ) { ret = ret "#" muc_mnpr               [el]; };
#  if(el in muc_mnro               ) { ret = ret "#" muc_mnro               [el]; };
#  if(el in muc_mntv               ) { ret = ret "#" muc_mntv               [el]; };
#  if(el in muc_mnvi               ) { ret = ret "#" muc_mnvi               [el]; };
   el="" }; gsub(/ё/,"е",ret); return ret }
