# Правила для пары все-всё (переработанная версия)
# let @a=1|%s/"V\zs\d\+\ze"/\=''.(@a+setreg('a',@a+1))/g|%s/ V\[\zs\d\+\ze\]++; if(dbg){print "V\(\d\+\)"/\1/g

function x1111_f() {

###   x1111 !_#_! ==> vsje_     vsyo_     все  все́  всё
xgrp="x1111";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)         # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; is_vsje=omo1; is_vsyo=omo2; # header2

#continue

 # SpaCy или Natasha
#if ( veq(morphy_yo,1) && vsyo_sy(0) )
#{ l[i]=is_vsyo; V[1]++; if(dbg){print "V1"}; continue };
#if ( veq(morphy_yo,1) && vsje_sy(0) )
#{ l[i]=is_vsje; V[2]++; if(dbg){print "V2"}; continue };
#if ( veq(morphy_yo,1) && vsyo_tt(0) )
#{ l[i]=is_vsyo; V[3]++; if(dbg){print "V3"}; continue };
#if ( veq(morphy_yo,1) && vsje_tt(0) )
#{ l[i]=is_vsje; V[4]++; if(dbg){print "V4"}; continue };

 # Ограничим окно поиска опорных слов предложением
 WLE=-8; WRI=8;
 sos(WLE*2,-1);  Y["n-_sos"] = son; if(son && son >= WLE) {WLE = son; };
 eos(0,WRI*2);   Y["n+_eos"] = eon; if(eon && eon <= WRI) {WRI = eon; };
 qsf(0,WRI,"[,——]"); Y["n+_comma"] = sfn;
 qsb(WLE,1,","); Y["n-_comma"] = sbn;
 qsf(0,WRI,"—"); Y["n+_tire"] = sfn;
 qsb(WLE,1,"—"); Y["n-_tire"] = sbn;


 # Ищем опорные слова

 if ( bfa(1,WRI,"_ge_vsje")  ) { Y["n+_ge_vsje"]  = bfn; Y["w+_ge_vsje"]  = BFn; };
 if ( bba(WLE,-1,"_ge_vsje") ) { Y["n-_ge_vsje"]  = bbn; Y["w-_ge_vsje"]  = BBn; };

 if ( bfa(1,WRI,"_ge_vsyo")  ) { Y["n+_ge_vsyo"]  = bfn; Y["w+_ge_vsyo"]  = BFn; };
 if ( bba(WLE,-1,"_ge_vsyo") ) { Y["n-_ge_vsyo"]  = bbn; Y["w-_ge_vsyo"]  = BBn; };

 if ( bfa(1,WRI,"_gl_mental_pe")  ) { Y["n+_gl_mental_pe"]  = bfn; Y["w+_gl_mental_pe"]  = BFn; };
 if ( bba(WLE,-1,"_gl_mental_pe") ) { Y["n-_gl_mental_pe"]  = bbn; Y["w-_gl_mental_pe"]  = BBn; };

 if ( bfa(1,WRI,"_gl_vida_pe")  ) { Y["n+_gl_vida_pe"]  = bfn; Y["w+_gl_vida_pe"]  = BFn; };
 if ( bba(WLE,-1,"_gl_vida_pe") ) { Y["n-_gl_vida_pe"]  = bbn; Y["w-_gl_vida_pe"]  = BBn; };

 if ( qf(1,WRI,"suw_mnim suw_mnne") )     { Y["n+_suw_mnim"]    = qfn; };
 if ( qf(1,WRI,"suw_mnro") )              { Y["n+_suw_mnro"]    = qfn; };
 if ( qf(1,WRI,"suw_edro") )              { Y["n+_suw_edro"]    = qfn; };
 if ( qf(1,WRI,"suw_ed") && Q(qfn,"suw_noedne fam_edzene") ) { Y["n+_suw_ed"]      = qfn; };
 if ( qf(1,WRI,"suw_edsrim suw_edsrvi") ) { Y["n+_suw_edsrim"]  = qfn; };

 if ( qf(1,WRI,"qik_im") )                { Y["n+_qik_im"]      = qfn; };
 if ( qf(1,WRI,"qis_im") )                { Y["n+_qis_im"]      = qfn; };

 if ( qf(1,WRI,"gl_ed") && Q(qfn,"suw_ed") ) { Y["n+_gl_ed"]       = qfn; };
 if ( qf(1,WRI,"gl_in") )                 { Y["n+_gl_in"]       = qfn; };
 if ( qf(1,WRI,"gl_vzed") )               { Y["n+_gl_vzed"]     = qfn; };
 if ( qf(1,WRI,"gl_mn") )                 { Y["n+_gl_mn"]       = qfn; };
 if ( qf(1,WRI,"gl_vzmn") )               { Y["n+_gl_vzmn"]     = qfn; };
 if ( qf(1,WRI,"gl_pe") )                 { Y["n+_gl_pe"]       = qfn; };
 if ( qf(1,WRI,"gl_pemn") )               { Y["n+_gl_pemn"]       = qfn; };
 if ( qf(1,WRI,"gl_pnmn") )               { Y["n+_gl_pnmn"]       = qfn; };
 if ( qf(1,WRI,"sz_iili") )               { Y["n+_sz_iili"]     = qfn; if ( w(qfn,"и") ) { Y["n+_sz_i"] = qfn; }; };

 if ( qf(1,WRI,"mod_mn") )                { Y["n+_mod_mn"]      = qfn; };
 if ( qf(1,WRI,"lnk_mn") )                { Y["n+_lnk_mn"]      = qfn; };
 if ( qf(1,WRI,"prl_edsrim") )            { Y["n+_prl_edsrim"]  = qfn; };
 if ( qf(1,WRI,"prl_mnim") )              { Y["n+_prl_mnim"]    = qfn; };
 if ( qf(1,WRI,"prl_krmn") )              { Y["n+_prl_krmn"]    = qfn; };
 if ( qf(1,WRI,"prq_krmn") )              { Y["n+_prq_krmn"]    = qfn; };
 if ( qf(1,WRI,"prq_mnim") )              { Y["n+_prq_mnim"]    = qfn; };

 if ( qf(1,WRI,"pre_ro") )                { Y["n+_pre_ro"]    = qfn; };
 if ( qf(1,WRI,"pre_da") )                { Y["n+_pre_da"]    = qfn; };
 if ( qf(1,WRI,"pre_pr") )                { Y["n+_pre_pr"]    = qfn; };
 if ( qf(1,WRI,"pre_tv") )                { Y["n+_pre_tv"]    = qfn; };
 if ( qf(1,WRI,"pre_vi") )                { Y["n+_pre_vi"]    = qfn; };

 if ( qb(WLE,-1,"gl_pe deep_pe") )        { Y["n-_gl_pe"]       = qbn; };
 if ( qb(WLE,-1,"gl_ed")   )              { Y["n-_gl_ed"]       = qbn; };
 if ( qb(WLE,-1,"gl_vzed") )              { Y["n-_gl_vzed"]     = qbn; };
 if ( qb(WLE,-1,"gl_mn") )                { Y["n-_gl_mn"]       = qbn; };
 if ( qb(WLE,-1,"gl_vzmn") )              { Y["n-_gl_vzmn"]     = qbn; };
 if ( qb(WLE,-1,"mod_mn") )               { Y["n-_mod_mn"]      = qbn; };
 if ( qb(WLE,-1,"gl_pnmn") )              { Y["n-_gl_pnmn"]     = qbn; };

 if ( qb(WLE,-1,"pre_ro") )               { Y["n-_pre_ro"]      = qbn; };
 if ( qb(WLE,-1,"pre_da") )               { Y["n-_pre_da"]      = qbn; };
 if ( qb(WLE,-1,"pre_pr") )               { Y["n-_pre_pr"]      = qbn; };
 if ( qb(WLE,-1,"pre_tv") )               { Y["n-_pre_tv"]      = qbn; };
 if ( qb(WLE,-1,"pre_vi") )               { Y["n-_pre_vi"]      = qbn; };

 if ( qb(WLE,-1,"prl_edsrim") )           { Y["n-_prl_edsrim"]  = qbn; };
 if ( qb(WLE,-1,"prl_mnim") )             { Y["n-_prl_mnim"]    = qbn; };

 if ( qb(WLE,-1,"suw_mnim") )             { Y["n-_suw_mnim"]    = qbn; };

 # Правила без опорных слов
 if ( se(0,"-") && w(1,"таки") )
 { l[i]=is_vsyo; V[5]++; if(dbg){print "V5"}; continue };

 if ( s(0) && w(1,"же ж") &&
   !( q(2,"prl_krmn")||
     (w(-1,"не") && s(-1))||
     (q(2,"prl_mnim") && q(3,"mod_mn") ) ) )
 { l[i]=is_vsyo; V[6]++; if(dbg){print "V6"}; continue };

 if ( s(0) && w(1,"равно едино одно") )
 { l[i]=is_vsyo; V[7]++; if(dbg){print "V7"}; continue };

 # Все еще

 if ( w(-1,"когда") && s(-1,1) && w(1,"еще") && q(2,"gl_need gl_nemn") && p(2) )
 { l[i]=is_vsje; V[8]++; if(dbg){print "V8"}; continue };
 if ( s(0,1) && w(1,"еще также") )
 { l[i]=is_vsyo; V[9]++; if(dbg){print "V9"}; continue };

 if ( s(0,1) && bw(1,"тот") && w(2,"же ж") )
 { l[i]=is_vsyo; V[10]++; if(dbg){print "V10"}; continue };
 if ( s(0,2) && q(1,"pre_da") && q(2,"mest_da mest_3e") && bw(2,"тот этот такой") && w(3,"же ж") )
 { l[i]=is_vsyo; V[11]++; if(dbg){print "V11"}; continue };
 if ( s(0,2) && q(1,"pre_ro") && q(2,"mest_ro mest_3e") && bw(2,"тот этот такой") && w(3,"же ж") )
 { l[i]=is_vsyo; V[12]++; if(dbg){print "V12"}; continue };
 if ( s(0,2) && q(1,"pre_tv") && q(2,"mest_tv mest_3e") && bw(2,"тот этот такой") && w(3,"же ж") )
 { l[i]=is_vsyo; V[13]++; if(dbg){print "V13"}; continue };
 if ( s(0,2) && q(1,"pre_pr") && q(2,"mest_pr mest_3e") && bw(2,"тот этот такой") && w(3,"же ж") )
 { l[i]=is_vsyo; V[14]++; if(dbg){print "V14"}; continue };
 if ( s(0,2) && q(1,"pre_vi") && q(2,"mest_vi mest_3e") && bw(2,"тот этот такой") && w(3,"же ж") )
 { l[i]=is_vsyo; V[15]++; if(dbg){print "V15"}; continue };


 if ( qxs(1,"что","нужно угодно")||
      qxs(1,"с","больной","головы","на")||
      qxs(1,"так","же")||
      qxs(1,"не","то") )
 { l[i]=is_vsyo; v[6]++; if(dbg){print "v6"}; continue };

 if ( (qxs(1,"бы","ничего")||
       qxs(1,"не","так")||
       qxs(1,"ли","равно") ) &&
         p(xsn) )
 { l[i]=is_vsyo; V[16]++; if(dbg){print "V16"}; continue };

 if ( qxs(1,"за","и","против")||
      qxs(1,"и","всяческие каждый")||
      qxs(1,"против","всех")||
      qxs(1,"как","один одно одна")||
      qxs(1,"до","единого одного последнего") )
 { l[i]=is_vsje; V[17]++; if(dbg){print "V17"}; continue };

 if ( z(0) && w(1,"что чего чему чтобы") && !(s(-1) && w(-1,"они их")) )
 { l[i]=is_vsyo; V[18]++; if(dbg){print "V18"}; continue };
 if ( s(0) && w(1,"то это") && z(1) && w(2,"что чего чему") )
 { l[i]=is_vsyo; V[19]++; if(dbg){print "V19"}; continue };
 if ( s(0) && w(1,"мы вы они") && p(1) )
 { l[i]=is_vsje; V[20]++; if(dbg){print "V20"}; continue };
 if ( z(0) && qxw(1,"как","один одно одна") )
 { l[i]=is_vsje; V[21]++; if(dbg){print "V21"}; continue };

 if ( wy(1,"это") &&
     qxs(1+wyn,"от для","того")||
     qxs(1+wyn,"нипочем")||
     qxs(1+wyn,"с","чистого","листа") )
 { l[i]=is_vsyo; V[22]++; if(dbg){print "V22"}; continue };

 if ( qxs(1,"как","на","подбор") )
 { l[i]=is_vsje; V[23]++; if(dbg){print "V23"}; continue };

 if ( w(-1,"на") && s(-1) && qxs(1,"про","все") )
 { l[i]=is_vsyo; V[24]++; if(dbg){print "V24"}; continue };
 if ( qxs(-1,"на","все","про") )
 { l[i]=is_vsyo; V[25]++; if(dbg){print "V25"}; continue };


 if ( wy(1,"это то") && z(0+wyn) &&
   ( qxw(1+wyn,"о","чем")||
     qxw(1+wyn,"за на про","что")||
     qxw(1+wyn,"ради","чего того")) )
 { l[i]=is_vsyo; V[26]++; if(dbg){print "V26"}; continue };

 if ( wy(1,"эти те") && z(0+wyn) &&
   ( qxw(1+wyn,"в о","ком")||
     qxw(1+wyn,"за на про","кого") ) )
 { l[i]=is_vsje; V[27]++; if(dbg){print "V27"}; continue };

 if ( z(0) && w(1,"кто кого кому которые которым которых") )
 { l[i]=is_vsje; V[28]++; if(dbg){print "V28"}; continue };
 if ( w(1,"те") && s(0) && z(1) && w(2,"кто кого кому которые которым которых") )
 { l[i]=is_vsje; V[29]++; if(dbg){print "V29"}; continue };

 if ( qxs(-1,"как","и") &&
        p(0) && p(-3) &&
       wy(-3,"же") && q(-3-wyn,"prl_edmuim prl_edzeim") )
 { l[i]=is_vsje; V[30]++; if(dbg){print "V30"}; continue };

 if ( qxs(-1,"как","и") &&
        p(0) && veq(Y["n-_sos"],xsn-1) )
 { l[i]=is_vsje; V[31]++; if(dbg){print "V31"}; continue };

 if ( w(1,"вместе") && z(1) &&
    qxw(2,"а","не","по","одиночке") )
 { l[i]=is_vsje; V[32]++; if(dbg){print "V32"}; continue };

 if ( w(-1,"и") && s(-1) && veN(Y["n+_eos"]) && veq(Y["n+_eos"],0) && p(-3) )
 { l[i]=is_vsyo; V[33]++; if(dbg){print "V33"}; continue };
 if ( w(-1,"и") && s(-1) && veN(Y["n+_eos"]) && veq(Y["n+_eos"],0) && p(-2) )
 { l[i]=is_vsyo; V[34]++; if(dbg){print "V34"}; continue };

 # с числительными.
 if ( vgl(Y["n+_qik_im"],1,WRI) ) { bf_n=Y["n+_qik_im"];

    if ( s(0,bf_n-1) &&
       qir(1,bf_n-1,"mest_mnim mest_3e qik_im") )
    { l[i]=is_vsje; V[35]++; if(dbg){print "V35"}; continue };
 };
 if ( vgl(Y["n+_qis_im"],1,WRI) ) { bf_n=Y["n+_qis_im"];

    if ( s(0,bf_n-1) &&
       qir(1,bf_n-1,"mest_mnim mest_3e qik_im") )
    { l[i]=is_vsje; V[36]++; if(dbg){print "V36"}; continue };
 };

 if ( s(0) && q(1,"digits") )
 { l[i]=is_vsje; V[37]++; if(dbg){print "V37"}; continue };

 #Устойчивые сочетания
 cst="ажуре жопу кучу меру мусор норме нужник порядке унитаз";
 if ( vgl(Y["n-_suw_mnim"],-2,-1) && qy(-1,"qast_any qast") && s(Y["n-_suw_mnim"],-1) &&
        p(Y["n-_suw_mnim"]-1) && qxs(1,"в",cst) )
 { l[i]=is_vsje; V[38]++; if(dbg){print "V38"}; continue };

 cst="ажуре жопу кучу меру мусор норме нужник порядке унитаз";
 if ( ( veq(Y["n+_eos"],2) || p(2) ) && qxs(1,"в",cst) )
 { l[i]=is_vsyo; V[39]++; if(dbg){print "V39"}; continue };
 cst="порядку";
 if ( ( veq(Y["n+_eos"],2) || p(2) ) && qxs(1,"по",cst) )
 { l[i]=is_vsyo; V[40]++; if(dbg){print "V40"}; continue };
 cst="контролем";
 if ( ( veq(Y["n+_eos"],2) || p(2) ) && qxs(1,"под",cst) )
 { l[i]=is_vsyo; V[41]++; if(dbg){print "V41"}; continue };

 cst="выигрыше курсе";
 if ( veq(Y["n-_sos"],-1) && veq(Y["n+_eos"],2) && qxs(1,"в",cst) )
 { l[i]=is_vsje; V[42]++; if(dbg){print "V42"}; continue };

 # сравнительные наречия и прилагательные
 {
 if ( q(1,"nar_srav prl_srav") && w(2,"и") && q(3,"nar_srav prl_srav") && s(0,2) )
 { l[i]=is_vsyo; V[43]++; if(dbg){print "V43"}; continue };
 cst="больший большой малый меньший";
 if ( bw(1,cst) && w(2,"и") && bw(3,cst) && s(0,2) )
 { l[i]=is_vsyo; V[44]++; if(dbg){print "V44"}; continue };

 stopper=""; if ( w(1,"уже") ) { stopper = 1 };

 cst="новые новых";
 if ( w(1,cst) && w(2,"и") && qq(1,3) && s(0,2) )
 { l[i]=is_vsyo; V[45]++; if(dbg){print "V45"}; continue };
 if ( w(1,cst) && z(1) && w(2,"еще") && w(3,"более менее") && s(0) && s(2) )
 { l[i]=is_vsyo; V[46]++; if(dbg){print "V46"}; continue };
 if (!vex(stopper) ) {
    if ( q(1,"nar_srav prl_srav") && w(2,"и") && qq(1,3) && s(0,2) )
    { l[i]=is_vsyo; V[47]++; if(dbg){print "V47"}; continue };
    if ( q(1,"nar_srav prl_srav") && q(2,"gl_ed gl_mn gl_vzmn gl_vzed deep") && s(0,1) )
    { l[i]=is_vsyo; V[48]++; if(dbg){print "V48"}; continue };
    if ( q(1,"nar_srav prl_srav") && q(2,"prl_im prl_vi prl_ro prl_da prl_tv") && s(0,1) )
    { l[i]=is_vsyo; V[49]++; if(dbg){print "V49"}; continue };
    if ( q(1,"nar_srav prl_srav") && q(2,"suw_ro") && s(0,1) )
    { l[i]=is_vsyo; V[50]++; if(dbg){print "V50"}; continue };
    if ( q(1,"nar_srav prl_srav") && q(-1,"suw_ro") && s(-1,0) )
    { l[i]=is_vsyo; V[51]++; if(dbg){print "V51"}; continue };
    if ( q(1,"nar_srav prl_srav") && s(0) && p(1) )
    { l[i]=is_vsyo; V[52]++; if(dbg){print "V52"}; continue };
 };
 } # сравнительные

 # это
 if ( w(-1,"это") &&
     qf(1,3,"suw_vi") &&
    qir(1,qfn-1,"mest_vi prl_vi qast_ne") )
 { l[i]=is_vsyo; V[53]++; if(dbg){print "V53"}; continue };
 if ( w(-1,"это")  &&
     wf(1,3,"были") &&
    qir(1,wfn-1,"nar_any") )
 { l[i]=is_vsyo; V[54]++; if(dbg){print "V54"}; continue };
 if ( (veq(Y["n+_eos"],1)||veq(Y["n+_comma"],1)) && w(1,"это") && s(0) )
 { l[i]=is_vsyo; V[55]++; if(dbg){print "V55"}; continue };

 if ( (veq(Y["n+_eos"],0)||veq(Y["n+_comma"],0)) &&
        wb(-3,-1,"это") && s(wbn,-1) &&
       wir(wbn+1,-1,"не еще же") )
 { l[i]=is_vsyo; V[56]++; if(dbg){print "V56"}; continue };
 if ( w(1,"это то") && q(2,"pre_ro") && qf(3,6,"suw_ro") && s(0,qfn-1) && p(qfn) &&
    qir(3,qfn-1,"mest_ro mest_3e prl_ro") )
 { l[i]=is_vsyo; V[57]++; if(dbg){print "V57"}; continue };
 if ( w(1,"это то") && q(2,"pre_da") && qf(3,6,"suw_da") && s(0,qfn-1) && p(qfn) &&
    qir(3,qfn-1,"mest_da mest_3e prl_da") )
 { l[i]=is_vsyo; V[58]++; if(dbg){print "V58"}; continue };


 # с предложными фразами в конце предложения
 if ( vex(Y["n-_sos"]) && q(1,"pre_ro") && qf(2,5,"suw_ro") && s(0,qfn-1) && p(qfn) &&
      qir(Y["n-_sos"],-1,"qast_any") &&
      qir(3,qfn-1,"mest_ro mest_3e prl_ro") )
 { l[i]=is_vsyo; V[59]++; if(dbg){print "V59"}; continue };
 if ( vex(Y["n-_sos"]) && q(1,"pre_da") && qf(2,5,"suw_da") && s(0,qfn-1) && p(qfn) &&
      qir(Y["n-_sos"],-1,"qast_any") &&
      qir(3,qfn-1,"mest_da mest_3e prl_da") )
 { l[i]=is_vsyo; V[60]++; if(dbg){print "V60"}; continue };

 if ( z(0) && w(1,"кроме") && q(2,"nam_edro fam_edro pat_edro") && s(1) && cap(2) )
 { l[i]=is_vsje; V[61]++; if(dbg){print "V61"}; continue };


 # Определение для сущ ед.ч. ср.р.
 if ( vgl(Y["n+_suw_edsrim"],1,WRI) ) { bf_n=Y["n+_suw_edsrim"];

    if ( Q(bf_n,"suw_mnim suw_mnvi") && s(0,bf_n-1) &&
       qir(1,bf_n-1,"prl_edsrim mest_edsrim mest_3e nar_any prl_kred_sr") )
    { l[i]=is_vsyo; V[62]++; if(dbg){print "V62"}; continue };

    if ( Q(bf_n,"suw_mnim suw_mnvi") && s(0,bf_n-1) &&
       qir(1,bf_n-1,"prl_edsrim mest_edsrim mest_3e nar_any prl_kred_sr") )
    { l[i]=is_vsyo; V[63]++; if(dbg){print "V63"}; continue };
 };

 # Определение для сущ ед.ч. с числительными.
 if ( vgl(Y["n+_suw_edro"],1,WRI) ) { bf_n=Y["n+_suw_edro"];

    if ( w(bf_n-1,"два три четыре") && s(0,bf_n-1) &&
       qir(1,bf_n-2,"mest_mnim mest_3e") )
    { l[i]=is_vsje; V[64]++; if(dbg){print "V64"}; continue };
 };

 # Определение для сущ мн.ч. с числительными.
 if ( vgl(Y["n+_suw_mnro"],1,WRI) ) { bf_n=Y["n+_suw_mnro"];

    if ( q(bf_n-1,"qik_im") && s(0,bf_n-1) &&
       qir(1,bf_n-2,"mest_mnim mest_3e") )
    { l[i]=is_vsje; V[65]++; if(dbg){print "V65"}; continue };
 };

 # связка + существительное
 if ( vgl(Y["n+_lnk_mn"],1,WRI) ) { bf_n=Y["n+_lnk_mn"];

    if ( qf(bf_n+1,bf_n+4,"suw_mntv") && s(0,bf_n-1) &&
        qir(1,bf_n-1,"sz_i nar_any prl_kred_sr prl_srav mest_mnim") &&
        qir(bf_n+1,qfn-1,"prl_mntv mest_mntv mest_3e nar_spos nar_mest") )
    { l[i]=is_vsje; V[66]++; if(dbg){print "V66"}; continue };

 };

 # с причастием мн.ч. отдельно

 cst="новые";
 if ( !w(1,cst) && qf(1,3,"prl_mnim prq_mnim prl_krmn prq_krmn") && s(0,qfn-1) &&
     qir(1,qfn-1,"mest_mnim nar_mest qast_ne") )
 { l[i]=is_vsje; V[67]++; if(dbg){print "V67"}; continue };
 if ( mqast(1) && qf(xwn+1,xwn+3,"prl_mnim prq_mnim prl_krmn prq_krmn") && s(0,qfn-1) &&
        qir(xwn+1,qfn-1,"mest_mnim nar_mest qast_any") )
 { l[i]=is_vsje; V[68]++; if(dbg){print "V68"}; continue };

 if ( q(1,"prq_kred_sr") && s(0) )
 { l[i]=is_vsyo; V[69]++; if(dbg){print "V69"}; continue };

 if ( q(1,"prq_edsrim") && s(0) )
 { l[i]=is_vsyo; V[70]++; if(dbg){print "V70"}; continue };
 if ( z(0) && q(1,"prq_edsrim") )
 { l[i]=is_vsyo; V[71]++; if(dbg){print "V71"}; continue };

 # прилагательные и причастия в конце предложения
 if ( q(Y["n+_eos"],"prl_krmn prq_krmn") && s(0,Y["n+_eos"]-1) &&
    qir(1,Y["n+_eos"]-1,"mod_mn gl_in") )
 { l[i]=is_vsje; V[72]++; if(dbg){print "V72"}; continue };
 if ( q(Y["n+_comma"],"prl_krmn prq_krmn") && s(0,Y["n+_comma"]-1) &&
    qir(1,Y["n+_comma"]-1,"mod_mn gl_in") )
 { l[i]=is_vsje; V[73]++; if(dbg){print "V73"}; continue };

 if ( W(-1,"их") && q(Y["n+_eos"],"prl_edsrim prl_kred_sr prq_kred_sr") && s(0,Y["n+_eos"]-1) &&
    qir(1,Y["n+_eos"]-1,"mod_ed mod_bz qast_any nar_any gl_in mest_it") )
 { l[i]=is_vsyo; V[74]++; if(dbg){print "V74"}; continue };
 if ( q(Y["n+_comma"],"prl_kred_sr prq_kred_sr") && s(0,Y["n+_comma"]-1) &&
    qir(1,Y["n+_comma"]-1,"mod_ed mod_bz qast_any gl_in") )
 { l[i]=is_vsyo; V[75]++; if(dbg){print "V75"}; continue };
 if ( q(Y["n+_tire"],"prl_kred_sr prq_kred_sr") && s(0,Y["n+_tire"]-1) &&
    qir(1,Y["n+_tire"]-1,"mod_ed mod_bz qast_any gl_in") )
 { l[i]=is_vsyo; V[76]++; if(dbg){print "V76"}; continue };

 # Буквы
 cst="^[" _RUUC "]$";
 if ( s(0) && wC(1,cst) && sL(1,".") )
 { l[i]=is_vsje; V[77]++; if(dbg){print "V77"}; continue };
 cst="^ [" _LAUC "].";
 if ( sc(0,cst) )
 { l[i]=is_vsje; V[78]++; if(dbg){print "V78"}; continue };


 # Деепричание
 if ( q(-1,"deep") && q(1,"nar_srav prl_srav") && s(-1,0) )
 { l[i]=is_vsyo; V[79]++; if(dbg){print "V79"}; continue };

 if ( qb(-4,-1,"deep_ne") && s(qbn,0) && w(1,"вместе") &&
     qir(bbn+1,-1,"nar_vrem nar_mest nar_spos mest_mnim qast_any") )
 { l[i]=is_vsje; V[80]++; if(dbg){print "V80"}; continue };

 # =============== Глаголы ===============

 # с глаголом ед.ч.
 if ( vgl(Y["n+_gl_ed"],1,WRI) ) { bf_n=Y["n+_gl_ed"];

    if ( s(0,bf_n-1) &&
       qir(1,bf_n-1,"nar_any prl_kred_sr sz_i mest_edsrim qast_any prl_srav") )
    { l[i]=is_vsyo; V[81]++; if(dbg){print "V81"}; continue };

    if ( s(0,bf_n-1) &&
         q(1,"pre_pr") && q(2,"suw_pr mest_pr") &&
       qir(3,bf_n-1,"nar_any prl_kred_sr sz_i mest_edsrim qast_any prl_srav") )
    { l[i]=is_vsyo; V[82]++; if(dbg){print "V82"}; continue };

    if ( s(0,bf_n-1) &&
         q(1,"pre_da") && q(2,"suw_da mest_da") &&
       qir(3,bf_n-1,"nar_any prl_kred_sr sz_i mest_edsrim qast_any prl_srav") )
    { l[i]=is_vsyo; V[83]++; if(dbg){print "V83"}; continue };

    if ( s(0,bf_n-1) &&
         q(1,"pre_ro") && q(2,"suw_ro mest_ro mest_3e") &&
       qir(3,bf_n-1,"nar_any prl_kred_sr sz_i mest_edsrim qast_any prl_srav suw_ro") )
    { l[i]=is_vsyo; V[84]++; if(dbg){print "V84"}; continue };

 };

 # Определение для сущ мн.ч.
 if ( vgl(Y["n+_suw_mnim"],1,WRI) ) { bf_n=Y["n+_suw_mnim"];

   stopper=""; if (q(bf_n,"suw_edsrim suw_edsrvi")) { stopper = 1 }

    cst="новые";
    if ( w(1,cst) && veq(Y["n+_sz_i"],2) && qq(1,3) && s(0,bf_n-1) &&
       qir(4,bf_n-1,"prl_mnim mest_mnim mest_mnvi mest_3e") )
    { l[i]=is_vsyo; V[85]++; if(dbg){print "V85"}; continue };

    cst="новые";
    if ( !vex(stopper) && !w(1,cst) && s(0,bf_n-1) &&
          qir(1,bf_n-1,"prl_mnim mest_mnim mest_mnvi mest_3e prq_mnim qik_im nar_spos nar_vrem nar_mest prl_kred_sr") )
    { l[i]=is_vsje; V[86]++; if(dbg){print "V86"}; continue };

    if ( !vex(stopper) && vex(Y["n+_tire"]) && !w(1,cst) && s(0,Y["n+_tire"]-1) && s(Y["n+_tire"]+1,bf_n-1) &&
          qir(1,Y["n+_tire"],"nar_spos nar_vrem nar_mest prl_kred_sr") &&
          qir(Y["n+_tire"]+1,bf_n-1,"prl_mnim mest_mnim mest_mnvi mest_3e prq_mnim qik_im nar_spos nar_vrem nar_mest prl_kred_sr") )
    { l[i]=is_vsje; V[87]++; if(dbg){print "V87"}; continue };

    if ( !vex(stopper) && s(0,bf_n-1) && vgt(bf_n,2) &&
            q(1,"pre_ro") && qf(2,bf_n-1,"suw_ro") &&
          qir(2,qfn-1,"prl_ro mest_3e mest_ro") &&
          qir(qfn+1,bf_n-1,"prl_mnim mest_mnim mest_mnvi mest_3e nar_spos nar_vrem nar_mest prl_kred_sr") )
    { l[i]=is_vsje; V[88]++; if(dbg){print "V88"}; continue };

    if ( !vex(stopper) && vgl(Y["n+_sz_i"],2,bf_n-2) && s(0,bf_n-1) &&
          qir(1,Y["n+_sz_i"]-1,"prl_mnim mest_3e prq_mnim") &&
          qir(Y["n+_sz_i"]+1,bf_n-1,"prl_mnim mest_mnim mest_mnvi mest_3e prq_mnim nar_spos nar_vrem nar_mest prl_kred_sr") )
    { l[i]=is_vsje; V[89]++; if(dbg){print "V89"}; continue };

 };

## Все с глаголами говорения, ментальными
#if ( vgl(Y["n+_gl_mental_pe"],1,WRI) ) { bf_n=Y["n+_gl_mental_pe"]; BF_n=Y["w+_gl_mental_pe"];

#   if ( q(bf_n,"gl_mn") && s(0,bf_n-1) && s(bf_n+1,Y["n+_comma"]-1) &&
#      vle(bf_n,Y["n+_comma"]) && w(Y["n+_comma"]+1,"что чтобы для как на за кто кого кому") &&
#      qir(1,bf_n-1,"mest_mnim qast nar_any prl_kred_sr") &&
#      qir(bf_n+1,Y["n+_comma"]-1,"sz_iili nar_any prl_kred_sr gl_mn") )
#   { l[i]=is_vsje; V[90]++; if(dbg){print "V90"}; continue };
#   if ( q(-1,"mest_mnim") &&
#        q(bf_n,"gl_mn") && s(-1,bf_n-1) && q(bf_n+1,"pre_pr") && z(bf_n) &&
#      qir(1,bf_n-1,"sz_iili nar_any prl_kred_sr") )
#   { l[i]=is_vsje; V[91]++; if(dbg){print "V91"}; continue };
#   if ( q(bf_n,"gl_mn") && s(-1,bf_n) && q(bf_n+1,"pre_pr pre_vi") &&
#      qir(1,bf_n-1,"nar_any prl_kred_sr mest_mnim qast") )
#   { l[i]=is_vsje; V[92]++; if(dbg){print "V92"}; continue };

#}; # n+_gl_mental_pe
#if ( vgl(Y["n-_gl_mental_pe"],WLE,-1) ) { bb_n=Y["n-_gl_mental_pe"]; BB_n=Y["w-_gl_mental_pe"];

#   if ( veq(bb_n,-1) && q(1,"pre_pr") &&
#         qf(2,5,"suw_pr") && s(-1,qfn-1) &&
#        qir(2,qfn-1,"prl_pr mest_pr mest_3e prq_pr") )
#   { l[i]=is_vsyo; V[93]++; if(dbg){print "V93"}; continue };
#}; # n-_gl_mental_pe

## Все с глаголами типа гл. что кому
#if ( vgl(Y["n+_gl_vida_pe"],1,WRI) ) { bf_n=Y["n+_gl_vida_pe"]; BF_n=Y["w+_gl_vida_pe"];

#   if ( q(-1,"mest_da suw_da") && s(-1,bf_n) &&
#        q(bf_n+1,"pre_pr") &&
#      qir(1,bf_n-1,"mest_mnim qast nar_any prl_kred_sr") )
#   { l[i]=is_vsyo; V[94]++; if(dbg){print "V94"}; continue };
#   if ( q(1,"mest_da suw_da") && s(0,bf_n) &&
#        q(bf_n+1,"pre_pr") &&
#      qir(2,bf_n-1,"mest_mnim qast nar_any prl_kred_sr") )
#   { l[i]=is_vsyo; V[95]++; if(dbg){print "V95"}; continue };


#}; # n+_gl_vida_pe
#if ( vgl(Y["n-_gl_vida_pe"],WLE,-1) ) { bb_n=Y["n-_gl_vida_pe"]; BB_n=Y["w-_gl_vida_pe"];

#   if ( veq(bb_n,-1) && q(1,"pre_pr") &&
#        qf(2,5,"suw_pr") && s(-1,qfn-1) &&
#        qir(2,qfn-1,"prl_pr mest_pr mest_3e prq_pr") )
#   { l[i]=is_vsyo; V[96]++; if(dbg){print "V96"}; continue };
#}; # n-_gl_vida_pe

 # Все с глаголами из списка
 if ( vgl(Y["n+_ge_vsje"],1,WRI) ) { bf_n=Y["n+_ge_vsje"]; BF_n=Y["w+_ge_vsje"];

    if ( q(bf_n,"gl_mn gl_vzmn") && s(0,bf_n-1) &&
       qir(1,bf_n-1,"mest_mnim qast nar_any prl_kred_sr") )
    { l[i]=is_vsje; V[97]++; if(dbg){print "V97"}; continue };
 };
 # n+_ge_vsje
 if ( vgl(Y["n-_ge_vsje"],WLE,-1) ) { bb_n=Y["n-_ge_vsje"]; BB_n=Y["w-_ge_vsje"];

    if ( veq(Y["n-_gl_mn"],bb_n) && s(bb_n,-1) &&
         qir(bb_n+1,-1,"mest_mnim qast nar_any prl_kred_sr") )
    { l[i]=is_vsje; V[98]++; if(dbg){print "V98"}; continue };
 };
 # n-_ge_vsje


 if ( vgl(Y["n+_ge_vsyo"],1,WRI) ) { bf_n=Y["n+_ge_vsyo"]; BF_n=Y["w+_ge_vsyo"];

    if ( veq(Y["n+_gl_mn"],bf_n) && s(0,bf_n-1) &&
         qir(1,bf_n-1,"mest_mnim qast nar_any prl_kred_sr") )
    { l[i]=is_vsyo; V[99]++; if(dbg){print "V99"}; continue };
 };
 # n+_ge_vsyo
 if ( vgl(Y["n-_ge_vsyo"],WLE,-1) ) { bb_n=Y["n-_ge_vsyo"]; BB_n=Y["w-_ge_vsyo"];

    if ( veq(Y["n-_gl_mn"],bb_n) && s(bb_n,-1) &&
         qir(bb_n+1,-1,"mest_mnim qast nar_any prl_kred_sr") )
    { l[i]=is_vsyo; V[100]++; if(dbg){print "V100"}; continue };
 };
 # n-_ge_vsje

 if ( vgl(Y["n-_gl_ed"],WLE,-1) ) { bb_n=Y["n-_gl_ed"];

   stopper="";
   if (veq(Y["n+_prl_mnim"],1)) { stopper=1 };
   if (veq(Y["n+_prq_mnim"],1)) { stopper=1 };
   if (q(1,"mest_mnim")) { stopper=1 };
   cst="за";
   if (w(1,cst)) { stopper=1 };

    if ( !vex(stopper) && s(bb_n,-1) &&
          qir(bb_n+1,-1,"nar_any prl_kred_sr sz_i mest_edsrim qast_any prl_srav") )
    { l[i]=is_vsyo; V[101]++; if(dbg){print "V101"}; continue };

 };

 # с возвратным глаголом мн.ч.
 if ( vgl(Y["n+_gl_vzmn"],1,WRI) ) { bf_n=Y["n+_gl_vzmn"];

    cst="уже";
    if ( W(1,cst) && q(1,"nar_srav prl_srav") && s(0,bf_n-1) &&
       qir(2,bf_n-1,"nar_srav prl_srav") )
    { l[i]=is_vsyo; V[102]++; if(dbg){print "V102"}; continue };
    if (  q(-1,"suw_mnim") && w(1,"не") && veq(bf_n,2) && s(-1,1) )
    { l[i]=is_vsyo; V[103]++; if(dbg){print "V103"}; continue };
    if ( s(0,bf_n-1) &&
       qir(1,bf_n-1,"sz_i nar_vrem nar_mest nar_spos mest_mnim qast_any qast") )
    { l[i]=is_vsje; V[104]++; if(dbg){print "V104"}; continue };

 };
 if ( vgl(Y["n-_gl_vzmn"],WLE,-1) ) { bb_n=Y["n-_gl_vzmn"];

    if ( s(bb_n,-1) &&
       qir(bb_n+1,-1,"nar_vrem nar_mest nar_spos mest_mnim qast_any") )
    { l[i]=is_vsje; V[105]++; if(dbg){print "V105"}; continue };

 };

## Переходные глаголы во мн.ч  с дополнением
#if ( vgl(Y["n+_gl_pnmn"],1,WRI) ) { bf_n=Y["n+_gl_pnmn"];

#   if ( q(-3,"mest_im suw_odim") && q(-2,"sz_iili") && q(-1,"mest_im suw_odim") &&
#        q(bf_n+1,"pre_ro pre_pr pre_da pre_tv pre_vi") && s(-3,bfn) &&
#      qir(2,bf_n-1,"nar_spos nar_vrem") )
#   { l[i]=is_vsyo; V[106]++; if(dbg){print "V106"}; continue };
#   if ( q(-1,"mest_mnim suw_odmnim") && q(bf_n+1,"pre_ro pre_pr pre_da pre_tv pre_vi") && s(-1,bfn) &&
#      qir(2,bf_n-1,"nar_spos nar_vrem") )
#   { l[i]=is_vsyo; V[107]++; if(dbg){print "V107"}; continue };
#   if ( q(1,"mest_mnim suw_odmnim") && q(bf_n+1,"pre_ro pre_pr pre_da pre_tv pre_vi") && s(0,bfn) &&
#      qir(2,bf_n-1,"nar_spos nar_vrem") )
#   { l[i]=is_vsyo; V[108]++; if(dbg){print "V108"}; continue };
#   if ( vex(Y["n+_comma"]) && vle(bf_n,Y["n+_comma"]) && s(0,Y["n+_comma"]-1) &&
#          w(Y["n+_comma"]+1,"что") &&
#        qir(1,bf_n-1,"mest_mnim mest_vi sz_i nar_any prl_kred_sr") &&
#        qir(bf_n+1,Y["n+_comma"],"nar_spos mest_da suw_da") )
#   { l[i]=is_vsje; V[109]++; if(dbg){print "V109"}; continue };

#   if ( qf(bf_n+1,bf_n+4,"suw_ro") && s(0,qfn-1) &&
#       qir(1,bf_n-1,"mest_mnim nar_any prl_kred_sr") &&
#       qir(bf_n+1,qfn-1,"prl_ro mest_ro mest_3e") )
#   { l[i]=is_vsje; V[110]++; if(dbg){print "V110"}; continue };
#   if ( qf(bf_n+1,bf_n+3,"pre_ro pre_pr pre_da pre_tv pre_vi") && s(0,qfn-1) &&
#       qir(1,bf_n-1,"mest_mnim nar_any prl_kred_sr mest_da suw_da qast") &&
#       qir(bf_n+1,qfn-1,"suw_da mest_da nar_any") )
#   { l[i]=is_vsje; V[111]++; if(dbg){print "V111"}; continue };
#  if ( qb(-7,-1,"pre_pr") && s(qbn,qfn-1) &&
#      qir(1,bf_n-1,"mest_mnim nar_any prl_kred_sr mest_da suw_da") &&
#      qir(qbn+1,-1,"suw_pr prl_pr mest_pr mest_3e nar_any") )
#  { l[i]=is_vsje; V[112]++; if(dbg){print "V112"}; continue };

#};
#if ( vgl(Y["n-_gl_pnmn"],WLE,-1) ) { bb_n=Y["n-_gl_pnmn"]; # todo

#   if ( q(1,"mest_mnim") && q(bb_n,"pre_tv") && s(0,bfn) &&
#      qir(2,bf_n-1,"nar_spos nar_vrem") )
#   { l[i]=is_vsyo; V[113]++; if(dbg){print "V113"}; continue };

#};


# # с переходным глаголом  в мн.ч.
#if ( vgl(Y["n+_gl_pemn"],1,WRI) ) { bf_n=Y["n+_gl_pemn"];

#   if ( q(bf_n-1,"suw_tv") &&
#        q(-1,"mest_3e mest_vi suw_vi") && s(-1,bf_n-1) &&
#      qir(1,bf_n-2,"prl_tv mest_tv") )
#   { l[i]=is_vsje; V[114]++; if(dbg){print "V114"}; continue };
#   if ( veq(bf_n,1) && s(0,bf_n) &&
#          q(2,"mest_vi mest_3e suw_vi") )
#   { l[i]=is_vsje; V[115]++; if(dbg){print "V115"}; continue };
#   if ( vex(Y["n+_comma"]) && vle(bf_n,Y["n+_comma"]) && s(0,Y["n+_comma"]-1) &&
#          w(Y["n+_comma"]+1,"что") &&
#        qir(1,bf_n-1,"mest_mnim mest_vi sz_i nar_any prl_kred_sr") &&
#        qir(bf_n+1,Y["n+_comma"],"nar_spos mest_da suw_da") )
#   { l[i]=is_vsje; V[116]++; if(dbg){print "V116"}; continue };


#};

##
## с переходным глаголом
#if ( vgl(Y["n+_gl_pe"],1,WRI) ) { bf_n=Y["n+_gl_pe"];

#   if ( veq(bf_n,2) && q(bf_n,"gl_pemn") &&
#          q(-1,"mest_mnim") && s(0,bf_n-1) &&
#          q(1,"mest_vi mest_3e") )
#   { l[i]=is_vsje; V[117]++; if(dbg){print "V117"}; continue };

#};
#if ( vgl(Y["n-_gl_pe"],WLE,-1) ) { bb_n=Y["n-_gl_pe"];

#   if ( veq(bb_n,-2) && w(-1,"их") && s(-2,-1) )
#   { l[i]=is_vsje; V[118]++; if(dbg){print "V118"}; continue };
#   if ( veq(bb_n,-1) && q(1,"pre_pr") &&
#         qf(2,5,"suw_pr") && q(qfn+1,"suw_mnim") && s(-1,qfn) &&
#        qir(2,qfn-1,"mest_pr mest_3e prl_pr") )
#   { l[i]=is_vsje; V[119]++; if(dbg){print "V119"}; continue };

#};

 if ( vgl(Y["n+_suw_ed"],1,WRI) ) { bf_n=Y["n+_suw_ed"];

    stopper=""
    if ( q(bf_n,"suw_mnim suw_mnvi nar_spos") ) { stopper = 1 };
    if ( w(1,"уже перед") ) { stopper = 1 };
    if ( q(bf_n,"prl_kred_mu") ) { stopper = 1 };

    if (  vex(Y["n+_eos"]) && vle(bf_n,Y["n+_eos"]) && vgt(bf_n,1) && s(0,bf_n-1) &&
          qir(1,bf_n-1,"prl_ed mest_ed") &&
          qir(bf_n+1,Y["n+_eos"],"prl_ed") )
    { l[i]=is_vsyo; V[120]++; if(dbg){print "V120"}; continue };

    if ( !vex(stopper) && vex(Y["n+_eos"]) && vle(bf_n,Y["n+_eos"]) && s(0,bf_n-1) &&
          qir(1,bf_n-1,"prl_ed mest_ed mest_3e nar_any prl_kred_sr") &&
          qir(bf_n+1,Y["n+_eos"],"prl_ed") )
    { l[i]=is_vsyo; V[121]++; if(dbg){print "V121"}; continue };

    if ( !vex(stopper) && s(0,bf_n-1) &&
          qir(1,bf_n-1,"prl_edsrim mest_edsrim mest_3e nar_any prl_kred_sr") )
    { l[i]=is_vsyo; V[122]++; if(dbg){print "V122"}; continue };
 };

## с глаголом мн.ч.
#if ( vgl(Y["n+_mod_mn"],1,WRI) ) { bf_n=Y["n+_mod_mn"];

#   if ( vex(Y["n+_gl_in"]) && vlt(bf_n,Y["n+_gl_in"]) && s(0,bf_n-1) &&
#        qir(1,bf_n-1,"sz_i nar_any prl_kred_sr prl_srav mest_mnim") &&
#        qir(bf_n+1,Y["n+_gl_in"]-1,"nar_any mest_vi mest_da suw_da suw_vi") )
#   { l[i]=is_vsje; V[123]++; if(dbg){print "V123"}; continue };

#   if ( vex(Y["n+_prl_krmn"]) && vlt(bf_n,Y["n+_prl_krmn"]) && s(0,bf_n-1) &&
#        qir(1,bf_n-1,"sz_i nar_any prl_kred_sr prl_srav mest_mnim") &&
#        qir(bf_n+1,Y["n+_prl_krmn"]-1,"nar_any mest_da mest_tv suw_da suw_tv") )
#   { l[i]=is_vsje; V[124]++; if(dbg){print "V124"}; continue };
#   if ( vex(Y["n+_prq_krmn"]) && vlt(bf_n,Y["n+_prq_krmn"]) && s(0,bf_n-1) &&
#        qir(1,bf_n-1,"sz_i nar_any prl_kred_sr prl_srav mest_mnim") &&
#        qir(bf_n+1,Y["n+_prq_krmn"]-1,"nar_any mest_da mest_tv suw_da suw_tv") )
#   { l[i]=is_vsje; V[125]++; if(dbg){print "V125"}; continue };

#   if ( s(0,bf_n-1) && vex(Y["n+_eos"]) && vle(bf_n,Y["n+_eos"]) &&
#      qir(1,bf_n-1,"mest_mnim suw_mnim nes_mnim") &&
#      qir(bf_n+1,Y["n+_eos"]-1,"nar_any") )
#   { l[i]=is_vsje; V[126]++; if(dbg){print "V126"}; continue };
#   if ( s(0,bf_n-1) && vex(Y["n+_comma"]) && vle(bf_n,Y["n+_comma"]) &&
#      qir(1,bf_n-1,"mest_mnim suw_mnim nes_mnim") &&
#      qir(bf_n+1,Y["n+_comma"]-1,"nar_any") )
#   { l[i]=is_vsje; V[127]++; if(dbg){print "V127"}; continue };
#};

#if ( vgl(Y["n-_mod_mn"],WLE,-1) ) { bb_n=Y["n-_mod_mn"];

#   if ( veq(bb_n,-1) && q(1,"gl_pnin gl_nein") && s(-2,0) &&
#          q(-2,"mest_mnim suw_mnim sz_qto mest_da suw_da") )
#   { l[i]=is_vsje; V[128]++; if(dbg){print "V128"}; continue };
#   if ( veq(bb_n,-2) && q(-1,"gl_pnin gl_nein") && s(-2,0) )
#   { l[i]=is_vsje; V[129]++; if(dbg){print "V129"}; continue };
#   if ( veq(bb_n,-1) && vex(Y["n+_gl_pnin"]) && s(bb_n,Y["n+_gl_pnin"]-1) &&
#        qir(1,Y["n+_gl_in"]-1,"nar_srav prl_srav mest_it mest_3e mest_vi") )
#   { l[i]=is_vsyo; V[130]++; if(dbg){print "V130"}; continue };

#};

#if ( vgl(Y["n+_gl_in"],1,WRI) ) { bf_n=Y["n+_gl_in"];

#   if ( s(0,bf_n-1) &&
#      qir(1,bf_n-1,"nar_any prl_kred_sr mest_edsrim qast_any prl_srav mod_bz mod_ed") )
#   { l[i]=is_vsyo; V[131]++; if(dbg){print "V131"}; continue };

#};

#{ #
#  stopper=""
#  if ( vex(Y["n-_gl_mn"])   && s(Y["n-_gl_mn"],-1) )   { stopper = 1 };
#  if ( vex(Y["n-_gl_vzmn"]) && s(Y["n-_gl_vzmn"],-1) ) { stopper = 1 };


#  if ( ! vex(stopper) ){

#     if ( q(-1,"mest_mnim") && vex(Y["n+_comma"]) && vle(Y["n+_comma"],3) &&
#          q(Y["n+_comma"],"nar_any prl_kred_sr prq_kred_sr") && s(-1,Y["n+_comma"]-1) &&
#        qir(1,Y["n+_comma"]-1,"nar_any prl_kred_sr prq_kred_sr sz_iili prq_edsrim prl_edsrim") )
#     { l[i]=is_vsje; V[132]++; if(dbg){print "V132"}; continue };
#     if ( q(-1,"mest_mnim") && vex(Y["n+_eos"]) && vle(Y["n+_eos"],3) &&
#          q(Y["n+_eos"],"nar_any prl_kred_sr prq_kred_sr") && s(-1,Y["n+_eos"]-1) &&
#        qir(1,Y["n+_eos"]-1,"nar_any prl_kred_sr prq_kred_sr sz_iili prq_edsrim prl_edsrim") )
#     { l[i]=is_vsje; V[133]++; if(dbg){print "V133"}; continue };
#     if ( vex(Y["n+_eos"]) && vle(Y["n+_eos"],3) &&
#            q(Y["n+_eos"],"nar_any prl_kred_sr prq_kred_sr") && s(0,Y["n+_eos"]-1) &&
#          qir(1,Y["n+_eos"]-1,"nar_any prl_kred_sr prq_kred_sr sz_iili prq_edsrim prl_edsrim") )
#     { l[i]=is_vsyo; V[134]++; if(dbg){print "V134"}; continue };
#     if ( vex(Y["n+_comma"]) && vle(Y["n+_comma"],3) &&
#            q(Y["n+_comma"],"nar_any prl_kred_sr prq_edsrim prl_edsrim") && s(0,Y["n+_comma"]-1) &&
#          qir(1,Y["n+_comma"]-1,"nar_any prl_kred_sr") )
#     { l[i]=is_vsyo; V[135]++; if(dbg){print "V135"}; continue };
#     if ( wf(1,4,"и") && q(wfn-1,"nar_any prl_kred_sr") && s(0,wfn) &&
#         qir(1,wfn-2,"nar_any prl_kred_sr") )
#     { l[i]=is_vsyo; V[136]++; if(dbg){print "V136"}; continue };
#  };
#}



             }; # for(i in wpos)

 book[b]=joinpat(l,sep,nf) };};                                                ##_footer_vsez

}
