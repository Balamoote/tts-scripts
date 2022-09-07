# Принимает причастия в им.п., выдаёт полную парадигму причастия
function stoar(string, arrto, sepr,    artmp,k) {         # добавить в массив arrto элементы строки string
                split(string, artmp, sepr); for (k in artmp) {if(artmp[k]) {arrto[artmp[k]]}; };}
function mktup(string, arrto,    a1,a2,al,k) { # добавить в массив arrto элементы строки string типа 'слово=слово'
         split(string, a1, " "); al=length(a1); for (k=1; k<=al; k++) {if(a1[k]) {split(a1[k],a2,"="); arrto[a2[2]]=a2[1]; }; };}
function prout(osn,ty,    wrd,i,ret) { for (i in end[ty]) { wrd = osn end[ty][i]; se = s3;
                                       if(wrd in opFM) {se = s3 " NOP"}; if(wrd in spFM) {se = s3 " NOS"}; ret = wrd " " s2 i " " se; print ret }; }
BEGIN { PROCINFO["sorted_in"]="@ind_num_asc"

  cst="аяся=_ед_жен_им егося=_ед_муж_вин_одуш егося=_ед_муж_род егося=_ед_ср_род ееся=_ед_ср_вин ееся=_ед_ср_им ейся=_ед_жен_дат ейся=_ед_жен_пр ейся=_ед_жен_род \
       ейся=_ед_жен_тв емся=_ед_муж_пр емся=_ед_ср_пр емуся=_ед_муж_дат емуся=_ед_ср_дат иеся=_мн_вин_неод иеся=_мн_им ийся=_ед_муж_вин_неод ийся=_ед_муж_им \
       имися=_мн_тв имся=_ед_муж_тв имся=_ед_ср_тв имся=_мн_дат ихся=_мн_вин_одуш ихся=_мн_пр ихся=_мн_род уюся=_ед_жен_вин";
  mrk="ийся"; mktup(cst,end[mrk])

  cst="ая=_ед_жен_им его=_ед_муж_вин_одуш его=_ед_муж_род его=_ед_ср_род ее=_ед_ср_вин ее=_ед_ср_им ей=_ед_жен_дат ей=_ед_жен_пр ей=_ед_жен_род ей=_ед_жен_тв \
       ем=_ед_муж_пр ем=_ед_ср_пр ему=_ед_муж_дат ему=_ед_ср_дат ие=_мн_вин_неод ие=_мн_им ий=_ед_муж_вин_неод ий=_ед_муж_им им=_ед_муж_тв им=_ед_ср_тв им=_мн_дат \
       ими=_мн_тв их=_мн_вин_одуш их=_мн_пр их=_мн_род ую=_ед_жен_вин";
  mrk="ий"; mktup(cst,end[mrk])

  cst="ая=_ед_жен_им ого=_ед_муж_вин_одуш ого=_ед_муж_род ого=_ед_ср_род ое=_ед_ср_вин ое=_ед_ср_им ой=_ед_жен_дат ой=_ед_жен_пр ой=_ед_жен_род ой=_ед_жен_тв \
       ом=_ед_муж_пр ом=_ед_ср_пр ому=_ед_муж_дат ому=_ед_ср_дат ую=_ед_жен_вин ые=_мн_вин_неод ые=_мн_им ый=_ед_муж_вин_неод ый=_ед_муж_им ым=_ед_муж_тв ым=_ед_ср_тв \
       ым=_мн_дат ыми=_мн_тв ых=_мн_вин_одуш ых=_мн_пр ых=_мн_род";
  mrk="ый"; mktup(cst,end[mrk])

  # Исключения в словаре причастий
  cst="вылокать выменить заменьжеваться карёжить котить меньжеваться обигоривать обигорить прошать псить разгнать разымать распочать руссифицировать руссифицироваться \
       скарёжить скарёжиться сустретить сустреть убегти успокоивать щеплять юлозить";
  stoar(cst,spBF," "); # исключить из проверки правописания по инфинитиву -- NOS

  cst="";
  stoar(cst,spFM," "); # исключить из проверки правописания отдельную форму причастия -- NOS

  cst="впечатлевший держущий держущийся жгенный мяучущий подъемлемый подъемлющий претерпенный стелящий стелящийся";
  stoar(cst,spIM," "); # исключить из проверки правописания по начальной форме причастия в им.п. муж.р -- NOS

  cst="брат брата браты нужен оборот оборота обороты минуты минутой минутою";
  stoar(cst,opFM," "); # исключить при сканировании словаря отдельные формы -- NOP

  cst="будущий";
  stoar(cst,opIM," "); # исключить при сканировании словаря по начальной форме причастия в им.п. муж.р -- NOP

  }

  { s4=""; s3=$3;

             if( $3 in spBF ) { s3 = $3 " NOS"; s4=1};
   if(!s4) { if( $1 in spIM ) { s3 = $3 " NOS"; s4=1} };
   if(!s4) { if( $1 in opIM ) { s3 = $3 " NOP"; s4=1} };

   l1=length($1); l2=length($2); e2=substr($1,l1-1); e4=substr($1,l1-3); s2=substr($2,1,l2-10)

   if( e4 == "ийся") { osn=substr($1,1,l1-4); prout(osn,e4); wrd=osn "еюся"; se=s3;
     if(!s4) { if( wrd in opFM ) {se=s3 " NOP"}; if( wrd in spFM ) {se=s3 " NOS"}; }; print wrd " " s2 "_ед_жен_тв " se };

   if( e2 == "ий"  ) { osn=substr($1,1,l1-2); prout(osn,e2); wrd=osn "ею"; se=s3;
     if( s4) { if( wrd in opFM ) {se=s3 " NOP"}; if( wrd in spFM ) {se=s3 " NOS"}; }; print wrd " " s2 "_ед_жен_тв " se };

   if( e2 == "ый"  ) { osn=substr($1,1,l1-2); prout(osn,e2); wrd=osn "ою"; se=s3;
     if(!s4) { if( wrd in opFM ) {se=s3 " NOP"}; if( wrd in spFM ) {se=s3 " NOS"}; }; print wrd " " s2 "_ед_жен_тв " se;

       oe1=substr($1,l1-2,1); oe2=substr($1,l1-3,2); s2="прч_крат" substr(s2,4);

       if( oe1 == "м" ) { wrd = osn;     se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_муж " se;
                          wrd = osn "а"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_жен " se;
                          wrd = osn "о"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_ср "  se;
                          wrd = osn "ы"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_мн "     se }
       if( oe1 == "т" ) { wrd = osn;     se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_муж " se;
                          wrd = osn "а"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_жен " se;
                          wrd = osn "о"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_ср "  se;
                          wrd = osn "ы"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_мн "     se }
       if( oe2 == "нн" ){ osn = substr($1,1,l1-3);
                          wrd = osn;     se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_муж " se;
                          wrd = osn "а"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_жен " se;
                          wrd = osn "о"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_ед_ср "  se;
                          wrd = osn "ы"; se=s3; if(wrd in opFM) {se=s3 " NOP"}; print wrd " " s2 "_мн "     se }
       }

    }

