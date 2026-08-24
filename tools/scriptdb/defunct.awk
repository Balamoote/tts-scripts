# повторяющиеся функции для deomo
# let @a=1|%s/"D\zs\d\+\ze"/\=''.(@a+setreg('a',@a+1))/g|%s/ d\[\zs\d\+\ze\]++; if(dbg){print "D\(\d\+\)"/\1/g
# При срабатывании функции выдают значение TRUE, при вызове аргументы НЕ указываются.
function sw_im_f(ret, stopp) { while ( !stopp ) {
 #
 if (fa(1,"u_sw_4_omo_list") && q(0,"suw_im") s(0) )
 { ret=stopp=1; D[1]++; if(dbg){print "D1"}; continue };

 if ( w(-1,"снова опять") && s(-1) && p(-2) && p(0) )
 { ret=stopp=1; D[2]++; if(dbg){print "D2"}; continue };
 if ( w(-1,"воистину") && s(-1) && p(-2) )
 { ret=stopp=1; D[3]++; if(dbg){print "D3"}; continue };
 if ( w(-1,"как") &&
      q(1,"prl_ro") &&
      q(2,"suw_ro") && s(-1,1) )
 { ret=stopp=1; D[4]++; if(dbg){print "D4"}; continue };

 if ( sc(0,"^\\s—\\s$") && wc(1,"^[0-9]+$") &&
       w(2,"шт упак мин сек час ч м с руб коп") && p(2) )
 { ret=stopp=1; D[5]++; if(dbg){print "D5"}; continue };
 #
 if ( (qxs(-1,"а и но","вот как где сколько","и же его ее их")||
       qxs(-1,"а и","вот")||
       qxs(-1,"вот","и же его ее их")||
       qxs(-1,"вот","мне тебе ей вам нам им","и")||
         w(-1,"вот") ) && s(-1) )
 { ret=stopp=1; D[6]++; if(dbg){print "D6"}; continue };
 if ( (qxs(-3,"а и но","вот как где сколько","и же его ее их")||
       qxs(-3,"а и","вот")||
       qxs(-3,"вот","и же его ее их")||
       qxs(-3,"вот","мне тебе ей вам нам им","и")||
         w(-3,"вот") ) &&
         q(-2,"suw_im") &&
         w(-1,"и") && s(-3,-1) )
 { ret=stopp=1; D[7]++; if(dbg){print "D7"}; continue };
 if ( qxs(-1,"больше совсем сейчас тоже","не") &&
        q(xsn-1,"mest_da suw_da") && s(xsn-1) )
 { ret=stopp=1; D[8]++; if(dbg){print "D8"}; continue };
 if ( qxs(-2,"больше совсем сейчас тоже","не") &&
        q(xsn-1,"mest_im suw_im") && s(xsn-1) &&
        q(-1,"mest_da suw_da") && s(-1) )
 { ret=stopp=1; D[9]++; if(dbg){print "D9"}; continue };

 if ( w(-3,"у") &&
      q(-2,"mest_ro suw_ro") &&
     bw(-1,"быть") && s(-3,-1) )
 { ret=stopp=1; D[10]++; if(dbg){print "D10"}; continue };
 if ( q(-2,"mest_it") &&
      q(-1,"mest_im") && s(-2,-1) )
 { ret=stopp=1; D[11]++; if(dbg){print "D11"}; continue };
 if ( (p(-3) || (w(-3,"а и вот что") && s(-3)) ) &&
       q(-2,"suw_mnim") &&
      se(-2," — ") &&
       q(-1,"mest_it nar_step") && s(-1) )
 { ret=stopp=1; D[12]++; if(dbg){print "D12"}; continue };
 if ( (p(-2) || (w(-2,"а и вот что") && s(-2)) ) &&
       q(-1,"suw_mnim") &&
      se(-1," — ") )
 { ret=stopp=1; D[13]++; if(dbg){print "D13"}; continue };
 if ( (p(-1) || (w(-1,"а и вот что") && s(-1)) ) &&
      se(0," — ") &&
       q(1,"mest_it") )
 { ret=stopp=1; D[14]++; if(dbg){print "D14"}; continue };
 if ( (p(-1) || (w(-1,"а и вот") && s(-1)) ) &&
       q(1,"suw_ro") && se(1," — ") && s(0) &&
       q(2,"mest_it") )
 { ret=stopp=1; D[15]++; if(dbg){print "D15"}; continue };

 if ( q(1,"pre_ro") && Qw_(-1,"pre_any") &&
      q(2,"mest_ro") &&
      q(3,"suw_im suw_edne") && s(0,2) )
 { ret=stopp=1; D[16]++; if(dbg){print "D16"}; continue };

 if ( w(-3,"более менее") && s(-3) &&
      q(-2,"prl_mnim") && z(-2) &&
      w(-1,"чем") && s(-1) )
 { ret=stopp=1; D[17]++; if(dbg){print "D17"}; continue };
 if ( w(-1,"чем") && z(-2) &&
     (q(1,"prl_srav nar_srav")||w(-1,"более менее")) && s(-1,0) )
 { ret=stopp=1; D[18]++; if(dbg){print "D18"}; continue };
 if ( w(-4,"более менее") &&
      q(-3,"prl_mntv") &&
      q(-2,"suw_mntv") && z(-2) &&
      w(-1,"чем") && s(0) )
 { ret=stopp=1; D[19]++; if(dbg){print "D19"}; continue };

 if ( w(-3,"у") &&
      q(-2,"mest_ro suw_ro") &&
      q(-1,"nar_vrem") && s(-3,-1) )
 { ret=stopp=1; D[20]++; if(dbg){print "D20"}; continue };
 if ( w(-3,"у") &&
      q(-2,"mest_ro suw_ro") &&
      q(-1,"nar_vrem nar_spos") && s(-3,-1) )
 { ret=stopp=1; D[21]++; if(dbg){print "D21"}; continue };
 if ( w(-2,"у") &&
      q(-1,"mest_ro suw_ro") && s(-2,-1) && W(0,"белок") )
 { ret=stopp=1; D[22]++; if(dbg){print "D22"}; continue };

 if ( w(-2,"к") &&
      q(-1,"mest_da suw_da") && s(-2,-1) && W(0,"белок") )
 { ret=stopp=1; D[23]++; if(dbg){print "D23"}; continue };

 if ( q(-3,"mest_it") &&
    qxs(-1,"всего ведь же","лишь только просто его ее их не") && s(-3) )
 { ret=stopp=1; D[24]++; if(dbg){print "D24"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"же ж лишь только просто его ее их не") && s(-2,-1) )
 { ret=stopp=1; D[25]++; if(dbg){print "D25"}; continue };
#if ( q(-2,"mest_it") &&
#      w(-1,"не его ее их") && s(-2,-1) )
#{ ret=stopp=1; D[26]++; if(dbg){print "D26"}; continue };
 if ( q(-1,"mest_it") && s(-1) )
 { ret=stopp=1; D[27]++; if(dbg){print "D27"}; continue };

 #
 cst_gl = "цвету суть кучу тону толщу"
 cst0   = "дома повести велики"
 if ( W(0,cst0) ) {
    #
    if ( mod_ed(-2) && gl_needge(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[28]++; if(dbg){print "D28"}; continue };
    if ( q(-1,"gl_needge deep_ne") && s(-1) && p(0) &&
         W(-1,cst_gl) )
    { ret=stopp=1; D[29]++; if(dbg){print "D29"}; continue };
    if ( q(1,"mest_da suw_da") &&
         q(2,"gl_nein gl_needge deep_ne") && s(0,1) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[30]++; if(dbg){print "D30"}; continue };
    if ( q(1,"gl_nein gl_needge deep_ne") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[31]++; if(dbg){print "D31"}; continue };
    if ( q(1,"gl_pnin gl_pned deep_pn") && s(0) && p(1) &&
         W(1,cst_gl) && Qw_(-1,"pre_any") )
    { ret=stopp=1; D[32]++; if(dbg){print "D32"}; continue };
    if ( q(2,"gl_pnin gl_pned deep_pn") && s(0,1) && p(2) &&
         w(1,"не") && W(2,cst_gl) && Qw_(-1,"pre_any") )
    { ret=stopp=1; D[33]++; if(dbg){print "D33"}; continue };
    if ( q(1,"gl_nein deep_ne") && s(0) && p(1) &&
         W(1,cst_gl) && Qw_(-1,"pre_any") )
    { ret=stopp=1; D[34]++; if(dbg){print "D34"}; continue };
    if ( q(2,"gl_nein gl_need deep_ne") && s(0,1) && p(2) &&
         w(1,"не") && W(2,cst_gl) && Qw_(-1,"pre_any") )
    { ret=stopp=1; D[35]++; if(dbg){print "D35"}; continue };
    #
    if ( mod_ed(-2) && gl_peedge(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[36]++; if(dbg){print "D36"}; continue };
    if ( gl_peedge(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[37]++; if(dbg){print "D37"}; continue };
    if ( q(1,"gl_pein gl_peedge deep_pe") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[38]++; if(dbg){print "D38"}; continue };
 #
 if ( suw_edmuim(0) ) {
    #
    if ( mod_ed(-2) && gl_needmu(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[39]++; if(dbg){print "D39"}; continue };
    if ( gl_needmu(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[40]++; if(dbg){print "D40"}; continue };
    if ( q(1,"nar_spos prl_kred_sr") &&
         q(2,"gl_ed") && s(0,1) && p(-1) &&
         W(2,cst_gl) )
    { ret=stopp=1; D[41]++; if(dbg){print "D41"}; continue };
    if ( q(1,"gl_ed") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[42]++; if(dbg){print "D42"}; continue };
    #
    if ( mod_ed(-2) && gl_peedmu(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[43]++; if(dbg){print "D43"}; continue };
    if ( gl_peedmu(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[44]++; if(dbg){print "D44"}; continue };
    if ( gl_peedmu(1) && s(0) && p(-1) &&
                 W(1,cst_gl) )
    { ret=stopp=1; D[45]++; if(dbg){print "D45"}; continue };
    if ( q(1,"suw_edmuim prl_edmuim mest_edmuim") && se(0,"-") )
    { ret=stopp=1; D[46]++; if(dbg){print "D46"}; continue };

 };
 if ( suw_edsrim(0) ) {
    #
    if ( mod_ed(-2) && gl_needsr(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[47]++; if(dbg){print "D47"}; continue };
    if ( gl_needsr(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[48]++; if(dbg){print "D48"}; continue };
    if ( q(1,"nar_spos prl_kred_sr") &&
         q(2,"gl_ed") && s(0,1) && p(-1) &&
         W(2,cst_gl) )
    { ret=stopp=1; D[49]++; if(dbg){print "D49"}; continue };
    if ( q(1,"gl_ed") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[50]++; if(dbg){print "D50"}; continue };
    #
    if ( mod_ed(-2) && gl_peedsr(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[51]++; if(dbg){print "D51"}; continue };
    if ( gl_peedsr(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[52]++; if(dbg){print "D52"}; continue };
    if ( q(1,"suw_edsrim prl_edsrim mest_edsrim") && se(0,"-") )
    { ret=stopp=1; D[53]++; if(dbg){print "D53"}; continue };

 };
 if ( suw_edzeim(0) ) {
    #
    if ( mod_ed(-2) && gl_needze(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[54]++; if(dbg){print "D54"}; continue };
    if ( gl_needze(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[55]++; if(dbg){print "D55"}; continue };
    if ( q(1,"nar_spos prl_kred_sr") &&
         q(2,"gl_ed") && s(0,1) && p(-1) &&
         W(2,cst_gl) )
    { ret=stopp=1; D[56]++; if(dbg){print "D56"}; continue };
    if ( q(1,"gl_ed") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[57]++; if(dbg){print "D57"}; continue };
    #
    if ( mod_ed(-2) && gl_peedze(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[58]++; if(dbg){print "D58"}; continue };
    if ( gl_peedze(-1) && s(-1) && p(0) &&
                 W(-1,cst_gl) )
    { ret=stopp=1; D[59]++; if(dbg){print "D59"}; continue };
    if ( q(1,"suw_edzeim prl_edzeim mest_edzeim") && se(0,"-") )
    { ret=stopp=1; D[60]++; if(dbg){print "D60"}; continue };

 };
 if ( suw_mnim(0) ) {
    #
    if ( mod_ed(-2) && gl_nemn(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[61]++; if(dbg){print "D61"}; continue };
    if ( q(-1,"gl_nemn gl_vzmn") && s(-1) && p(0) &&
         W(-1,cst_gl) )
    { ret=stopp=1; D[62]++; if(dbg){print "D62"}; continue };
    if ( q(1,"gl_nemn gl_vzmn") && s(0) && p(-1) &&
         W(1,cst_gl) )
    { ret=stopp=1; D[63]++; if(dbg){print "D63"}; continue };
    #
    if ( q(1,"mod_mn") && q(2,"prq_krmn") && s(0,1) )
    { ret=stopp=1; D[64]++; if(dbg){print "D64"}; continue };
    if ( mod_ed(-2) && gl_pemn(-2) && gl_in(-1) && s(-2,-1) && p(0) &&
              W(-1,"быть") )
    { ret=stopp=1; D[65]++; if(dbg){print "D65"}; continue };
    if ( gl_pemn(-1) && s(-1) && p(0) &&
               W(-1,cst_gl) )
    { ret=stopp=1; D[66]++; if(dbg){print "D66"}; continue };
    if ( gl_pemn(1) && s(0) && p(-1) &&
               W(1,cst_gl) )
    { ret=stopp=1; D[67]++; if(dbg){print "D67"}; continue };
    if ( q(1,"suw_mnim prl_mnim mest_mnim") && se(0,"-") )
    { ret=stopp=1; D[68]++; if(dbg){print "D68"}; continue };
 };};
 if ( q(1,"mest_da suw_da") &&
     wf(2,8,"ни") && qxs(wfn+1,"к","чему") && s(0,wfn-1) )
 { ret=stopp=1; D[69]++; if(dbg){print "D69"}; continue };
 if ( wf(1,5,"цвета оттенка") && !(Qf(1,wfn-1,"prl_edmuro prl_kred_sr")) &&
       q(wfn+1,"prl_ro suw_ro prq_ro suw_edne") && s(0,wfn) )
 { ret=stopp=1; D[70]++; if(dbg){print "D70"}; continue };

break}; return ret }

function sw_da_f(ret, stopp) { while ( !stopp ) {
 if ( fa(1,"u_sw_4_omo_list") && q(0,"suw_da") && s(0) )
 { ret=stopp=1; D[71]++; if(dbg){print "D71"}; continue };
 #
 if ( !(qb(-5,-1,"pre_any") && s(qbn,-1) ) &&
         q(-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") && bam(-1,"_gl_obj_da _gl_talk") && s(-1) )
 { ret=stopp=1; D[72]++; if(dbg){print "D72"}; continue };
 if ( !(qb(-5,-1,"pre_any") && s(qbn,-1) ) && q(0,"suw_odedda suw_odmnda") &&
         q(-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") && bam(-1,"_gl_give") && s(-1) )
 { ret=stopp=1; D[73]++; if(dbg){print "D73"}; continue };
 if ( q(-1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && bam(-1,"_gl_obj_da _gl_give _gl_talk") && s(-1) )
 { ret=stopp=1; D[74]++; if(dbg){print "D74"}; continue };
 if ( q(-1,"gl_nein gl_need gl_nemn gl_poneed gl_ponemn deep_ne") && bam(-1,"_gl_obj_da _gl_give _gl_talk") && s(-1) &&
      W(0,"смогу тому") )
 { ret=stopp=1; D[75]++; if(dbg){print "D75"}; continue };
 if ( q(1,"gl_pnin gl_pned gl_pnmn deep_pn") && bam(1,"_gl_obj_da _gl_give _gl_talk") && s(0) &&
      W(0,"смогу тому") )
 { ret=stopp=1; D[76]++; if(dbg){print "D76"}; continue };
 if ( w(1,"не") &&
      q(2,"gl_in gl_ed gl_mn deep") && bam(2,"_gl_obj_da _gl_give _gl_talk") && s(0,1) &&
      W(0,"смогу") )
 { ret=stopp=1; D[77]++; if(dbg){print "D77"}; continue };
#if ( w(1,"не") &&
#      q(2,"gl_nein gl_need gl_nemn deep_ne") && bam(2,"_gl_obj_da _gl_give _gl_talk") && s(0,1) &&
#      W(0,"смогу") )
#{ ret=stopp=1; D[78]++; if(dbg){print "D78"}; continue };
#if ( w(1,"не") &&
#      q(2,"gl_pnin gl_pned gl_pnmn deep_pn") && bam(2,"_gl_obj_da _gl_give _gl_talk") && s(0,1) &&
#      W(0,"смогу") )
#{ ret=stopp=1; D[79]++; if(dbg){print "D79"}; continue };

break}; return ret }

function sw_vi_f(ret, stopp) { while ( !stopp ) {
 if ( fa(1,"u_sw_4_omo_list") && q(0,"suw_vi") && s(0) )
 { ret=stopp=1; D[80]++; if(dbg){print "D80"}; continue };
 #
 if ( q(-1,"gl_in gl_ed gl_mn gl_poed deep") && ba(-1,"_gl_obj_vi") && s(-1) )
 { ret=stopp=1; D[81]++; if(dbg){print "D81"}; continue };
 if ( q(-2,"gl_in gl_ed gl_mn gl_poed deep") && ba(-2,"_gl_obj_vi") &&
      q(-1,"mest_da") && s(-2,-1) )
 { ret=stopp=1; D[82]++; if(dbg){print "D82"}; continue };
 if ( q(-1,"gl_pnin gl_pned gl_pnmn gl_poed deep_pn") && ba(-1,"_gl_obj_vi") && s(-1) )
 { ret=stopp=1; D[83]++; if(dbg){print "D83"}; continue };
 if ( q(-2,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && bam(-2,"_gl_give _gl_talk") &&
      q(-1,"mest_da suw_da") && s(-2,-1) && W(-1,"своему твоему нашему моему") )
 { ret=stopp=1; D[84]++; if(dbg){print "D84"}; continue };
 if ( q(-2,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && ba(-2,"_gl_talk") &&
      q(-1,"mest_vi prl_mnvi") && s(-2,-1) )
 { ret=stopp=1; D[85]++; if(dbg){print "D85"}; continue };
 if ( q(-1,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && ba(-1,"_gl_talk") && s(-1) )
 { ret=stopp=1; D[86]++; if(dbg){print "D86"}; continue };
 if ( q(-2,"gl_in gl_ed gl_mn deep") && ba(-2,"_gl_learn") &&
      q(-1,"mest_vi prl_edmuvi") && s(-2,-1) )
 { ret=stopp=1; D[87]++; if(dbg){print "D87"}; continue };
 if ( q(-1,"gl_in gl_ed gl_mn deep") && ba(-1,"_gl_learn") && s(-1) )
 { ret=stopp=1; D[88]++; if(dbg){print "D88"}; continue };

 if ( q(-3,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && ba(-3,"_gl_dvizh") &&
      q(-2,"pre_vi") &&
      q(-1,"mest_vi suw_vi") && s(-3,-1) )
 { ret=stopp=1; D[89]++; if(dbg){print "D89"}; continue };

 if ( q(-1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe prq_pe") && s(-1) )
 { ret=stopp=1; D[90]++; if(dbg){print "D90"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
 pre_ro(-2) &&
      q(-1,"mest_ro suw_ro") && s(-3,-1) )
 { ret=stopp=1; D[91]++; if(dbg){print "D91"}; continue };
 if ( q(-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") && s(-1) )
 { ret=stopp=1; D[92]++; if(dbg){print "D92"}; continue };
 if ( q(-3,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
 pre_ro(-2) &&
      q(-1,"mest_ro suw_ro") && s(-3,-1) )
 { ret=stopp=1; D[93]++; if(dbg){print "D93"}; continue };
 if ( q(1,"gl_pein gl_peed gl_pemn deep_pe") &&
      q(2,"name_im_sy name_tv_sy isname") && s(0,1) )
 { ret=stopp=1; D[94]++; if(dbg){print "D94"}; continue };
 if ( q(-2,"gl_pnin gl_pned gl_pnmn gl_poed gl_pomn deep_pn") &&
      w(-1,"еще") && s(-2,-1) )
 { ret=stopp=1; D[95]++; if(dbg){print "D95"}; continue };
 if ( q(1,"suw_im") && p(-1) && Q(1,"gl_mn") &&
      q(2,"gl_pnin gl_pned gl_pnmn gl_poed gl_pomn deep_pn") && s(0,1) )
 { ret=stopp=1; D[96]++; if(dbg){print "D96"}; continue };

 if ( qb(-5,-1,"pre_any") && s(qbn,-1) &&
       q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && s(-1) )
 { ret=stopp=1; D[97]++; if(dbg){print "D97"}; continue };

 if ( qxs(-1,"в","виду") &&
        q(xsn-2,"mest_im suw_im") &&
       bw(xsn-1,"иметь") && s(xsn-2) )
 { ret=stopp=1; D[98]++; if(dbg){print "D98"}; continue };


 if ( pre_ro(-3) && p(-4) &&
           q(-2,"suw_ro") &&
           q(-1,"gl_peed gl_pemn deep_pe gl_pned gl_pnmn deep_pn") && s(-3,-1) && p(0) )
 { ret=stopp=1; D[99]++; if(dbg){print "D99"}; continue };
 if ( pre_tv(-3) && p(-4) &&
           q(-2,"suw_tv") &&
           q(-1,"gl_peed gl_pemn deep_pe gl_pned gl_pnmn deep_pn") && s(-3,-1) && p(0) )
 { ret=stopp=1; D[100]++; if(dbg){print "D100"}; continue };
 if ( q(1,"suw_edzevi prl_edzevi mest_edzevi") && se(0,"-") )
 { ret=stopp=1; D[101]++; if(dbg){print "D101"}; continue };


 if ( qxs(-1,"в","виду") &&
        q(xsn-2,"mest_im suw_im") &&
       bw(xsn-1,"иметь") && s(xsn-2) )
 { ret=stopp=1; D[102]++; if(dbg){print "D102"}; continue };


 if ( (p(-2)||(w(-2,"а и но") && s(-2)))&&
       q(-1,"suw_im mest_im name_im_sy") &&
       q(1,"gl_pein gl_peed gl_pemn gl_poed gl_pomn deep_pe") && s(-1,0) && p(1) )
 { ret=stopp=1; D[103]++; if(dbg){print "D103"}; continue };

break}; return ret }

function sw_tv_f(ret, stopp) { while ( !stopp ) {
 if ( fa(1,"u_sw_4_omo_list") && q(0,"suw_tv") && s(0) )
 { ret=stopp=1; D[104]++; if(dbg){print "D104"}; continue };
 #
 if ( q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_obj_tv") && s(-1) )
 { ret=stopp=1; D[105]++; if(dbg){print "D105"}; continue };
 if ( q(1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(1,"_gl_obj_tv") && s(0) )
 { ret=stopp=1; D[106]++; if(dbg){print "D106"}; continue };
 if ( q(-2,"suw_im mest_im") &&
      q(-1,"gl_pein gl_peed gl_pemn deep_pe") && s(-2,-1) && Q(0,"nar_vrem") )
 { ret=stopp=1; D[107]++; if(dbg){print "D107"}; continue };
 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe prq_pe") &&
      q(-1,"suw_im mest_im mest_3e") && s(-2,-1) && Q(0,"nar_vrem") )
 { ret=stopp=1; D[108]++; if(dbg){print "D108"}; continue };

break}; return ret }

function sw_ro_f(ret, stopp) { while ( !stopp ) {

 # Сильное управление

#if ( q(-2,"gl_ed gl_mn gl_in deep") && wc(-2,"^до") &&
#      w(-1,"до") && s(-2,-1) )
#{ ret=stopp=1; D[109]++; if(dbg){print "D109"}; continue };
#if ( q(-2,"gl_ed gl_mn gl_in deep") && wc(-2,"^вы ^у ^из") &&
#      w(-1,"из") && s(-2,-1) )
#{ ret=stopp=1; D[110]++; if(dbg){print "D110"}; continue };
#if ( q(-2,"gl_ed gl_mn gl_in deep") && wc(-2,"^от ^об ^из ^у") &&
#      w(-1,"от") && s(-2,-1) )
#{ ret=stopp=1; D[111]++; if(dbg){print "D111"}; continue };

 if ( q(-3,"gl_need gl_nemn gl_nein deep_ne") &&
      q(-2,"pre_vi") &&
      q(-1,"suw_vi") && Q(-1,"prl_vi mest_vi") && s(-3,-1) )
 { ret=stopp=1; D[112]++; if(dbg){print "D112"}; continue };

 if ((qi_duoz(-2)||wc(-2,"[234][^0-9]*$")) && Ww_(-3,"номер") &&
            q(-1,"mest_mnim mest_mnvi prl_mnim prl_mnvi prq_mnim prq_mnvi") && Q(-1,"mest_edim mest_edvi") && s(-2,-1) )
 { ret=stopp=1; D[113]++; if(dbg){print "D113"}; continue };

 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe") &&
      q(-1,"pre_ro") &&
      q(1,"suw_vi") && s(-2,0) )
 { ret=stopp=1; D[114]++; if(dbg){print "D114"}; continue };
 if ( qxs(-2,"то","есть") &&
        q(-1,"nar_any") && s(-1) )
 { ret=stopp=1; D[115]++; if(dbg){print "D115"}; continue };
 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe") &&
      w(-1,"как много немного немало мало") && s(-2,-1) )
 { ret=stopp=1; D[116]++; if(dbg){print "D116"}; continue };

 if ( !(q(-3,"suw_mnim") && z(-3)) &&
        q(-2,"prq_mnvi") &&
 nar_mest(-1) && pre_ro(-1) && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[117]++; if(dbg){print "D117"}; continue };
 if ( !(q(-3,"suw_mnim") && z(-3)) &&
        q(-2,"prq_mnvi") &&
 nar_mest(-1) && pre_ro(-1) && s(-2,-1) &&
      !(q(1,"prl_mnim suw_mnim") && s(1)) )
 { ret=0; stopp=1; edro2mnvi=1; D[118]++; if(dbg){print "D118"}; continue };

 if ( w(-2,"не") && q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_no_nero") && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[119]++; if(dbg){print "D119"}; continue };
 if ( w(-2,"не") && q(-1,"gl_pein gl_peed gl_pemn deep_pe") && ba(-1,"_gl_no_nero") && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[120]++; if(dbg){print "D120"}; continue };
 if ( w(-2,"не") && q(-1,"gl_nein gl_need gl_nemn gl_vzmn gl_vzed deep_ne") && ba(-1,"_gl_no_nero") && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[121]++; if(dbg){print "D121"}; continue };
 if ( Qw_(-2,"pre_ro preph_ro") && Ww_(-2,"не") &&
        q(-1,"mest_pmnim mest_3e prl_mnim prl_mnvi prq_mnim prq_mnvi") && Q(-1,"mest_edim mest_edvi") && s(-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[122]++; if(dbg){print "D122"}; continue };
 if ( Qw_(-3,"pre_ro preph_ro") && !(w(-3,"не") && ba(-2,"_gl_yes_nero") && s(-3) ) &&
        q(-2,"mest_mnim mest_mnvi prl_mnim prl_mnvi prq_mnim prq_mnvi") && Q(-2,"mest_edim mest_edvi") && s(-2) && sc(-1,"-") )
 { ret=0; stopp=1; edro2mnvi=1; D[123]++; if(dbg){print "D123"}; continue };

 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe") &&
      q(-1,"nar_any") && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[124]++; if(dbg){print "D124"}; continue };
 if ( q(-2,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
      q(-1,"nar_napr") && s(-2,-1) && W(0,"сорок"))
 { ret=0; stopp=1; edro2mnvi=1; D[125]++; if(dbg){print "D125"}; continue };
#if ( q(-2,"gl_pnin gl_pned gl_pnmn deep_pn") &&
#     q(-1,"nar_any") && s(-2,-1) )
#{ ret=0; stopp=1; edro2mnvi=1; D[126]++; if(dbg){print "D126"}; continue };
 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe") && !(qxs(-2,"то","есть")||w(-1,"как много немного")) &&
      q(-3,"nar_any") &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-4,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[127]++; if(dbg){print "D127"}; continue };

 if ( pre_tv(-3) && p(-4) &&
           q(-2,"mest_tv suw_tv") &&
           q(-1,"gl_in gl_ed gl_mn deep") && s(-3,-1) && p(0) )
 { ret=0; stopp=1; edro2mnim=1; D[128]++; if(dbg){print "D128"}; continue };
 if ( q(-2,"mest_ro suw_ro") &&
      q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_obj_ro") && s(-2,-1) )
 { ret=0; stopp=1; edro2mnvi=1; D[129]++; if(dbg){print "D129"}; continue };

 if ( q(-3,"pre_tv preph_tv") &&
      q(-2,"mest_tv prl_tv") &&
      q(-1,"suw_tv suw_edne") &&
      q(1,"suw_edim name_im_sy") &&
      q(2,"gl_ed") && s(-3,1) )
 { ret=stopp=1; D[130]++; if(dbg){print "D130"}; continue };

 if ( q(-4,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-3,"suw_vi") &&
      q(-2,"suw_ro") &&
      q(-1,"suw_ro") && s(-4,-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[131]++; if(dbg){print "D131"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-2,"suw_vi") &&
      q(-1,"suw_ro") && s(-3,-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[132]++; if(dbg){print "D132"}; continue };
 if ( q(-2,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-1,"suw_vi") && s(-2,-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[133]++; if(dbg){print "D133"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-2,"suw_da mest_da") &&
      q(-1,"suw_vi") && s(-3,-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[134]++; if(dbg){print "D134"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-2,"suw_vi") && s(-3,-2) && se(-1,"-") && Q(0,"gl_in") )
 { ret=stopp=1; D[135]++; if(dbg){print "D135"}; continue };
 if ( q(-3,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-3,-1) )
 { ret=stopp=1; D[136]++; if(dbg){print "D136"}; continue };
 if ( q(-4,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-3,"suw_vi") &&
 pre_ro(-2) &&
      q(-1,"suw_ro mest_ro") && s(-4,-1) )
 { ret=stopp=1; D[137]++; if(dbg){print "D137"}; continue };

 if ( q(-2,"mest_edim prl_edim") &&
      q(-1,"suw_edsrim") &&
      q(1,"suw_im qik_im") && s(-2,0) )
 { ret=stopp=1; D[138]++; if(dbg){print "D138"}; continue };

 if ( q(-4,"suw_tv") &&
sz_iili(-3) &&
      q(-2,"prl_tv") &&
      q(-1,"suw_tv") && s(-4,-1) )
 { ret=stopp=1; D[139]++; if(dbg){print "D139"}; continue };
 if ( sz_iili(1) &&
            q(2,"prl_ro prq_ro") &&
            q(3,"suw_ro") && s(0,2) )
 { ret=stopp=1; D[140]++; if(dbg){print "D140"}; continue };
 if ( sz_iili(1) &&
            q(2,"prq_ro") &&
       pre_pr(3) &&
           (q(4,"mest_pr suw_pr")||w(4,"него нее них")) &&
            q(5,"suw_ro") && s(0,4) )
 { ret=stopp=1; D[141]++; if(dbg){print "D141"}; continue };
 if ( q(-3,"prq_edro") &&
 pre_pr(-2) &&
     (q(-1,"mest_pr suw_pr")||w(-1,"него нее них")) && s(-3,-1) )
 { ret=stopp=1; D[142]++; if(dbg){print "D142"}; continue };
 if ( sz_iili(1) &&
            q(2,"suw_ro") && Q(2,"suw_mnim gl_ed sz") && s(0,1) )
 { ret=stopp=1; D[143]++; if(dbg){print "D143"}; continue };
 if ( q(-2,"suw_ro name_ro_sy") && Q(-2,"suw_mnim gl_ed") &&
sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[144]++; if(dbg){print "D144"}; continue };
 if ( q(-3,"suw_mnim") && Q(-3,"prl_mnim") &&
      q(-2,"suw_ro") &&
sz_iili(-1) &&
      q(1,"gl_mn gl_vzmn") && s(-3,0) )
 { ret=stopp=1; D[145]++; if(dbg){print "D145"}; continue };

 if ( q(-2,"prl_mnim prq_mnim") && !( (pre_vi(-3)||preph_vi(-3)) && s(-3)) && Q(-1,"suw_ro") &&
      q(-1,"suw_im") && s(-2,-1) && sv(-1,"-") )
 { ret=stopp=1; D[146]++; if(dbg){print "D146"}; continue };

 if ( q(1,"mest_im suw_im") && s(0,1) &&
          narph_any(2) &&
      w(xwn+1,"не") &&
      q(xwn+2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(xwn+2,"_gl_yes_nero") && s(xwn,xwn+1) )
 { ret=stopp=1; D[147]++; if(dbg){print "D147"}; continue };
 if ( q(1,"mest_im suw_im") && s(0,1) &&
          narph_any(2) && vv(xwn,xwn+5) &&
      w(vvn+1,"не") &&
      q(vvn+2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(vvn+2,"_gl_yes_nero") && s(vvn+1) )
 { ret=stopp=1; D[148]++; if(dbg){print "D148"}; continue };
 if ( q(1,"mest_im suw_im") &&
      w(2,"не") &&
      q(3,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(3,"_gl_yes_nero") && s(0,2) )
 { ret=stopp=1; D[149]++; if(dbg){print "D149"}; continue };
 if ( w(1,"не") &&
      q(2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(2,"_gl_yes_nero") && s(0,1) )
 { ret=stopp=1; D[150]++; if(dbg){print "D150"}; continue };
 if ( w(-2,"не") &&
      q(-1,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(-1,"_gl_yes_nero") && s(-2,-1) )
 { ret=stopp=1; D[151]++; if(dbg){print "D151"}; continue };
 if ( w(-4,"не") &&
      q(-3,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin prq_any") && ba(-3,"_gl_yes_nero") &&
 pre_tv(-2) &&
      q(-1,"mest_tv suw_tv") && s(-4,-1) )
 { ret=stopp=1; D[152]++; if(dbg){print "D152"}; continue };
 if ( w(-3,"не") &&
      q(-2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin") &&
      w(-1,"и ли ведь бы же") && s(-3,-1) )
 { ret=stopp=1; D[153]++; if(dbg){print "D153"}; continue };
 if ( w(-4,"не") &&
      q(-3,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin") &&
      w(-2,"там тут ли ведь бы же") &&
      w(-1,"и") && s(-4,-1) )
 { ret=stopp=1; D[154]++; if(dbg){print "D154"}; continue };

 if ( q(-6,"mest_da suw_da") &&
      q(-5,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin deep_pe deep_pn prq_pe") &&
      q(-4,"prl_im") &&
sz_iili(-3) &&
      q(-2,"prl_im") &&
      q(-1,"suw_im") &&
      q(1,"suw_ro") && s(-6,0) )
 { ret=stopp=1; D[155]++; if(dbg){print "D155"}; continue };
 if ( q(-4,"mest_da suw_da") &&
      q(-3,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin deep_pe deep_pn prq_pe") &&
      q(-2,"prl_im") &&
      q(-1,"suw_im") &&
      q(1,"suw_ro") && s(-4,0) )
 { ret=stopp=1; D[156]++; if(dbg){print "D156"}; continue };
 if ( q(-3,"mest_da suw_da") &&
      q(-2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin deep_pe deep_pn prq_pe") &&
      q(-1,"suw_im") &&
      q(1,"suw_ro") && s(-3,0) )
 { ret=stopp=1; D[157]++; if(dbg){print "D157"}; continue };

 if ( q(-2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin deep_pe deep_pn prq_pe") &&
      q(-1,"suw_vi") &&
      q(1,"mest_tv prl_tv") &&
      q(2,"suw_tv") && s(-2,1) )
 { ret=stopp=1; D[158]++; if(dbg){print "D158"}; continue };
 if ( q(-2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin deep_pe deep_pn prq_pe") &&
      q(-1,"suw_vi") &&
      q(1,"mest_tv suw_tv") && s(-2,0) )
 { ret=stopp=1; D[159]++; if(dbg){print "D159"}; continue };

 if ( q(-2,"gl_need gl_nemn gl_nein gl_pned gl_pnmn gl_pnin deep_ne deep_pn prq_pn") &&
      q(-1,"mest_da suw_da") &&
      q(1,"gl_in") && s(-2,0) )
 { ret=stopp=1; D[160]++; if(dbg){print "D160"}; continue };

 if ( ((q(-1,"sz nar_any prl_kred_sr") && s(-1))||p(-1)) &&
        w(1,"не") &&
        q(2,"gl_peed gl_pemn gl_pein gl_pned gl_pnmn gl_pnin") && s(0,1) && p(2) )
 { ret=stopp=1; D[161]++; if(dbg){print "D161"}; continue };

 if ( q(-2,"gl_in gl_ed gl_mn gl_pomn deep") && ba(-2,"_gl_obj_ro") &&
      q(-1,"nar_vrem prl_kred_sr mest_ro prl_ro") && s(-2,-1) && Q(0,"gl_in"))
 { ret=stopp=1; D[162]++; if(dbg){print "D162"}; continue };
 if ( q(-1,"gl_in gl_ed gl_mn gl_vzmn gl_pomn deep") && ba(-1,"_gl_obj_ro") && s(-1) )
 { ret=stopp=1; D[163]++; if(dbg){print "D163"}; continue };

 if ( q(-3,"suw_im mest_im") &&
      q(-2,"gl_in gl_ed gl_mn deep") && ba(-2,"_gl_obj_ro") &&
      q(-1,"mest_ro prl_edro prq_edro") && s(-3,-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[164]++; if(dbg){print "D164"}; continue };

 if ( prq_pe(-4) &&
           q(-3,"suw_vi") &&
      pre_vi(-2) &&
           q(-1,"suw_vi") && s(-4,-1) )
 { ret=stopp=1; D[165]++; if(dbg){print "D165"}; continue };


 if ( q(-1,"suw_im") && Q(-1,"prl_im mest_im") &&
      q(1,"gl_pein gl_peed gl_pemn gl_pnin gl_pned gl_pnmn") &&
      q(2,"prl_vi mest_vi") &&
      q(3,"suw_vi") && s(-1,2) )
 { ret=stopp=1; D[166]++; if(dbg){print "D166"}; continue };
 if ( q(-1,"suw_im") && Q(-1,"prl_im mest_im") &&
      q(1,"gl_pein gl_peed gl_pemn gl_pnin gl_pned gl_pnmn") &&
      q(2,"suw_vi gl_in prl_kred_sr mest_vi nar_step") && s(-1,1) )
 { ret=stopp=1; D[167]++; if(dbg){print "D167"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn gl_pnin gl_pned gl_pnmn") &&
      q(-2,"prl_edvi mest_vi") &&
      q(-1,"suw_edvi") && s(-3,-1) )
 { ret=stopp=1; D[168]++; if(dbg){print "D168"}; continue };
 if ( q(-1,"suw_im") &&
      q(1,"qast") &&
      q(2,"qast") &&
      q(3,"gl_pein gl_peed gl_pemn gl_pnin gl_pned gl_pnmn") &&
      q(4,"suw_tv gl_in prl_kred_sr mest_tv nar_step") && s(-1,3) )
 { ret=stopp=1; D[169]++; if(dbg){print "D169"}; continue };
 if ( q(-1,"suw_im") &&
      q(1,"qast") &&
      q(2,"gl_pein gl_peed gl_pemn gl_pnin gl_pned gl_pnmn") &&
      q(3,"suw_tv gl_in prl_kred_sr mest_tv nar_step") && s(-1,2) )
 { ret=stopp=1; D[170]++; if(dbg){print "D170"}; continue };

 if ( q(-1,"suw_tv") &&
      q(1,"gl_pein gl_peed gl_pemn") && s(-1,0) )
 { ret=stopp=1; D[171]++; if(dbg){print "D171"}; continue };
 if ( q(-1,"suw_da") &&
      q(1,"gl_pein gl_peed gl_pemn") && s(-1,0) )
 { ret=stopp=1; D[172]++; if(dbg){print "D172"}; continue };

 if ( q(-5,"mest_im suw_im sz") &&
 pre_ro(-4) &&
      q(-3,"prl_ro mest_ro") &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro") && s(-5,-1) )
 { ret=stopp=1; D[173]++; if(dbg){print "D173"}; continue };
 if ( q(-4,"mest_im suw_im sz") &&
 pre_ro(-3) &&
      q(-2,"prl_ro mest_ro") &&
      q(-1,"suw_ro") && s(-4,-1) && Q(-1,"narph_any") )
 { ret=stopp=1; D[174]++; if(dbg){print "D174"}; continue };
 if ( q(-3,"mest_im suw_im sz") && prex!=1 &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-3,-1) )
 { ret=stopp=1; D[175]++; if(dbg){print "D175"}; continue };
 if ( q(-5,"mest_im suw_im sz") &&
 pre_ro(-4) &&
      q(-3,"suw_ro") &&
sz_iili(-2) &&
      q(-1,"suw_ro") && s(-5,-1) )
 { ret=stopp=1; D[176]++; if(dbg){print "D176"}; continue };

 if (  prq_any(-3) && Q(-3,"prq_mnim") && p(-4) &&
        pre_ro(-2) &&
             q(-1,"suw_ro") && s(-3,-1) )
 { ret=stopp=1; D[177]++; if(dbg){print "D177"}; continue };
 if (  prq_any(-4) && Q(-4,"prq_mnim") && p(-5) &&
             q(-3,"prl_kred_sr nar_spos") &&
        pre_ro(-2) &&
             q(-1,"suw_ro") && s(-4,-1) )
 { ret=stopp=1; D[178]++; if(dbg){print "D178"}; continue };

 if ( w(-3,"чем") &&
      q(-2,"suw_im") &&
      q(-1,"suw_ro") &&
      q(1,"prl_tv suw_tv") && s(-3,0) )
 { ret=stopp=1; D[179]++; if(dbg){print "D179"}; continue };

 if ( q(-6,"pre_ro preph_ro") &&
      q(-5,"suw_ro") &&
 pre_tv(-4) &&
      q(-3,"mest_tv prl_tv prq_tv") &&
      q(-2,"suw_tv") &&
sz_iili(-1) &&
      q(1,"suw_ro") && s(-6,0) )
 { ret=stopp=1; D[180]++; if(dbg){print "D180"}; continue };
 if ( q(-5,"pre_ro preph_ro") &&
      q(-4,"suw_ro") &&
 pre_tv(-3) &&
      q(-2,"suw_tv") &&
sz_iili(-1) &&
      q(1,"suw_ro") && s(-5,0) )
 { ret=stopp=1; D[181]++; if(dbg){print "D181"}; continue };

 # рп. в перечислениях
 if ( sz_iili(1) &&
            q(2,"mest_ro prl_ro") &&
            q(3,"prl_ro") &&
            q(4,"suw_ro") && s(0,3) )
 { ret=stopp=1; D[182]++; if(dbg){print "D182"}; continue };
 if ( sz_iili(1) &&
            q(2,"mest_ro prl_ro") &&
            q(3,"suw_ro") && s(0,2) )
 { ret=stopp=1; D[183]++; if(dbg){print "D183"}; continue };
 if ( q(1,"mest_ro prl_ro") && z(0) &&
      q(2,"suw_ro") && s(1) )
 { ret=stopp=1; D[184]++; if(dbg){print "D184"}; continue };
 if ( Q(0,"suw_edne") &&
sz_iili(1) &&
      q(2,"suw_ro") && Q(2,"suw_mnim gl_paedmu") && s(0,1) )
 { ret=stopp=1; D[185]++; if(dbg){print "D185"}; continue };
 if ( sz_iili(1) && z(0) &&
            q(2,"suw_ro") && Q(2,"suw_mnim gl_paedmu") && s(1) )
 { ret=stopp=1; D[186]++; if(dbg){print "D186"}; continue };
 if ( q(1,"suw_ro") && z(0) && Qw_(-1,"suw_any prl_mnim") &&
sz_iili(2) &&
      q(3,"suw_ro") && (Q(1,"suw_mnim gl_paedmu")||Q(3,"suw_mnim gl_paedmu")) && s(1,2) )
 { ret=stopp=1; D[187]++; if(dbg){print "D187"}; continue };
 if ( Q(0,"suw_edne") &&
      q(-1,"suw_ro") && z(-1) &&
sz_iili(1) &&
      q(2,"suw_ro") && (Q(-1,"suw_mnim gl_paedmu")||Q(2,"suw_mnim gl_paedmu")) && s(0,1) )
 { ret=stopp=1; D[188]++; if(dbg){print "D188"}; continue };
 if ( q(-3,"suw_ro") && z(-3) &&
      q(-2,"suw_ro") &&
sz_iili(-1) && s(-2,-1) && (Q(-3,"suw_mnim gl_paedmu")||Q(-2,"suw_mnim gl_paedmu")) )
 { ret=stopp=1; D[189]++; if(dbg){print "D189"}; continue };
 if ( q(-5,"suw_im") &&
      q(-4,"mest_ro prl_ro") &&
      q(-3,"suw_ro") &&
sz_iili(-2) &&
      q(-1,"suw_im") && s(-5,-1) )
 { ret=stopp=1; D[190]++; if(dbg){print "D190"}; continue };
 if ( q(-4,"suw_im") &&
      q(-3,"suw_ro") &&
sz_iili(-2) &&
      q(-1,"suw_im") && s(-4,-1) )
 { ret=stopp=1; D[191]++; if(dbg){print "D191"}; continue };
 if ( q(-2,"suw_ro") && Q(-2,"suw_mnim gl_paedmu") &&
sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[192]++; if(dbg){print "D192"}; continue };
 if ( q(-2,"pre_ro preph_ro") && s(-2) &&
      q(-1,"suw_ro name_ro_sy isname") && z(-1) &&
      q(1,"suw_ro name_ro_sy isname") && s(0) && p(1) )
 { ret=stopp=1; D[193]++; if(dbg){print "D193"}; continue };
 if ( q(-2,"pre_vi preph_vi") && s(-2) &&
      q(-1,"suw_vi") && z(0) &&
      q(1,"suw_ro") && p(1) )
 { ret=stopp=1; D[194]++; if(dbg){print "D194"}; continue };
 if ( q(-3,"suw_ro name_ro_sy") && Q(-3,"suw_mnim gl_paedmu") &&
sz_iili(-2) &&
      q(-1,"nar_spos prl_kred_sr") && s(-3,-1) )
 { ret=stopp=1; D[195]++; if(dbg){print "D195"}; continue };
 if ( qxs(-1,"и или да","даже") && s(xsn-1) &&
 suw_mnro(xsn-1) && Q(xsn-1,"suw_mnim gl_paedmu") )
 { ret=stopp=1; D[196]++; if(dbg){print "D196"}; continue };
 if ( q(1,"suw_ro") && s(0) &&
    qxs(2,"и или да","опять снова даже") &&
      q(xsn+1,"suw_ro") && s(xsn) && Q(xsn+1,"suw_mnim") )
 { ret=stopp=1; D[197]++; if(dbg){print "D197"}; continue };
 if ( qxs(-1,"и или да","опять снова даже") && s(xsn-1) &&
 suw_mnro(xsn-1) &&
 suw_mnro(xsn-2) && sc(xsn-2,",") && (Q(xsn-1,"suw_mnim gl_paedmu")||Q(xsn-2,"suw_mnim gl_paedmu")) )
 { ret=stopp=1; D[198]++; if(dbg){print "D198"}; continue };
 if ( Q(0,"suw_edne") && sz_iili(1) &&
      q(2,"suw_im") && Q(2,"suw_edro") && s(0,1) && ba(2,"_unit") )
 { ret=stopp=1; D[199]++; if(dbg){print "D199"}; continue };
 if ( q(-2,"suw_im") && !(q(-2,"suw_ro")||q(1,"suw_ro")) &&
sz_iili(-1) &&
      q(1,"suw_im") && s(-2,0) && Q(0,"gl_paedze")  )
 { ret=stopp=1; D[200]++; if(dbg){print "D200"}; continue };
 if ( qF(1,5,"suw_ro","suw_im") && sq(-1,qFn-1,",") )
 { ret=stopp=1; D[201]++; if(dbg){print "D201"}; continue };
 if ( qB(-5,-1,"suw_ro","suw_im") && sq(qBn,-1,",") && p(0) && Qw_(qBn-1,"suw_im qi_mn pre_ro preph_ro") )
 { ret=stopp=1; D[202]++; if(dbg){print "D202"}; continue };

 if ( ist_suw_mnro(-2) && Q(0,"gl_paedze") && Qist(-2,"ist_suw_edsrro") &&
           sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[203]++; if(dbg){print "D203"}; continue };
 if ( p(-1) && (p(0)||(q(1,"qast") && s(0) && p(1))) &&
 qb_ist(-4,-1,"ist_suw_ro") && qq(qbn,0) )
 { ret=stopp=1; D[204]++; if(dbg){print "D204"}; continue };

 if ( pre_vi(-3) &&
           q(-2,"prl_vi mest_vi") &&
           q(-1,"suw_vi") && Q(-1,"prl_mnvi") && !( qf(1,5,"gl_mn gl_vzmn") && s(0,qfn-1) ) && s(-3,-1) &&
           Q(-1,"narph_any") )
 { ret=stopp=1; D[205]++; if(dbg){print "D205"}; continue };

 if ( w(-1,"и ни") &&
      w(1,"не") &&
      q(2,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") && s(-1,1) )
 { ret=stopp=1; D[206]++; if(dbg){print "D206"}; continue };
 if ( w(-5,"не") &&
      q(-4,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") &&
      q(-3,"prl_edro") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-5,-1) )
 { ret=stopp=1; D[207]++; if(dbg){print "D207"}; continue };
 if ( w(-3,"не") &&
      q(-2,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") && ba(-2,"_gl_give") &&
      q(-1,"suw_da mest_da") && s(-3,-1) )
 { ret=stopp=1; D[208]++; if(dbg){print "D208"}; continue };
 if ( w(-3,"не") &&
      q(-2,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") &&
      q(-1,"prl_edro prq_edro") && s(-3,-1) )
 { ret=stopp=1; D[209]++; if(dbg){print "D209"}; continue };
 cst="глаза";
 if ( w(-2,"не") && W(0,cst) &&
      q(-1,"gl_ed gl_in gl_mn gl_poed gl_pomn deep prq_pe") && s(-2,-1) )
 { ret=stopp=1; D[210]++; if(dbg){print "D210"}; continue };
 if ( w(-2,"нет") &&
      w(-1,"и ни никакого никакой никаких") && s(-2,-1) )
 { ret=stopp=1; D[211]++; if(dbg){print "D211"}; continue };
 if ( w(-3,"не") &&
      q(-2,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") &&
      w(-1,"и ни никакого никакой никаких") && s(-3,-1) )
 { ret=stopp=1; D[212]++; if(dbg){print "D212"}; continue };
 if ( w(-4,"не") &&
      q(-3,"gl_ed gl_in gl_mn gl_poed gl_pomn deep") &&
      q(-2,"prl_ro prq_ro mest_ro") &&
      q(-1,"suw_ro") && s(-4,-1) )
 { ret=stopp=1; D[213]++; if(dbg){print "D213"}; continue };
 if ( p(-1) &&
      w(1,"не") &&
      q(2,"gl_in gl_ed gl_mn deep gl_vzed gl_vzmn") && s(0,1) && p(2) )
 { ret=stopp=1; D[214]++; if(dbg){print "D214"}; continue };

 if ( q(-1,"suw_im") && Q(-1,"prl_mnim") &&
      q(1,"gl_ed gl_mn gl_in deep") &&
      w(2,"до из от с со") && s(-1,1) )
 { ret=stopp=1; D[215]++; if(dbg){print "D215"}; continue };

 if ( qf(1,5,"mod_bz") &&
       w(qfn-1,"не") && s(0,qfn-1) && p(qfn) )
 { ret=stopp=1; D[216]++; if(dbg){print "D216"}; continue };

 if ( q(-6,"gl_nein gl_need gl_nemn gl_vzmn gl_poneed gl_ponemn deep_ne") &&
 pre_pr(-5) &&
      q(-4,"prl_pr qik_pr") &&
      q(-3,"suw_pr") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-6,-1) )
 { ret=stopp=1; D[217]++; if(dbg){print "D217"}; continue };
 if ( q(-3,"gl_nein gl_need gl_nemn gl_vzmn gl_poneed gl_ponemn deep_ne") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-3,-1) )
 { ret=stopp=1; D[218]++; if(dbg){print "D218"}; continue };
 if ( q(-4,"gl_nein gl_need gl_nemn gl_vzmn gl_poneed gl_ponemn deep_ne") &&
      q(-3,"nar_mest") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-4,-1) )
 { ret=stopp=1; D[219]++; if(dbg){print "D219"}; continue };
 if ( q(-2,"pre_ro preph_ro") &&
      q(-1,"suw_ro") &&
      q(1,"gl_nein gl_need gl_nemn gl_vzmn") &&
      q(2,"mest_im prl_im") &&
      q(3,"suw_im") && s(-3,-1) )
 { ret=stopp=1; D[220]++; if(dbg){print "D220"}; continue };

 if ( preph_ro(-2) &&
             q(-1,"suw_ro") && s(-2,-1) )
 { ret=stopp=1; D[221]++; if(dbg){print "D221"}; continue };

break}; return ret }

function sw_edro_f(ret,   stopp) { while ( !stopp ) {

 if ( qb(-4,-1,"pre_vi") &&
     qir(qbn+1,-1,"mest_mnvi mest_3e prl_mnvi prq_mnvi") && s(qbn,-1) )
 { ret=0; stopp=1; D[222]++; if(dbg){print "D222"}; continue };

 if ( fa(-2,"h_sw_4_sw_edro") &&
       q(-1,"prl_edro prq_edro mest_ro") && s(-2,-1) )
 { ret=stopp=1; D[223]++; if(dbg){print "D223"}; continue };
 if ( fa(-1,"h_sw_4_sw_edro") && s(-1) )
 { ret=stopp=1; D[224]++; if(dbg){print "D224"}; continue };
 if ( fa(-2,"h_sw_4_sw_edro") && q(0,"ipa_liquid ipa_loose") &&
       q(-1,"pre_ro") && s(-2,-1) )
 { ret=stopp=1; D[225]++; if(dbg){print "D225"}; continue };

 if ( fa(1,"u_sw_4_sw_edro") && s(0) )
 { ret=stopp=1; D[226]++; if(dbg){print "D226"}; continue };



 if ( ba(-2,"_gl_dvizh") &&
       q(-1,"nar_napr") && s(-2,-1) )
 { ret=stopp=1; D[227]++; if(dbg){print "D227"}; continue };

 if ( prq_any(-2) && ba(-2,"_gl_obj_ro") &&
            q(-1,"prl_edro mest_ro muk_edro") && s(-2,-1) )
 { ret=stopp=1; D[228]++; if(dbg){print "D228"}; continue };
 if ( prq_any(-3) && ba(-3,"_gl_obj_ro") &&
            q(-2,"suw_ro") &&
      sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[229]++; if(dbg){print "D229"}; continue };
 if ( prq_any(-1) && ba(-1,"_gl_obj_ro") && s(-1) )
 { ret=stopp=1; D[230]++; if(dbg){print "D230"}; continue };

 if ( suw_any(-2) && ba(-2,"_unit") &&
            q(-1,"prl_edro prq_edro mest_ro") && s(-2,-1) && wa(0,"_is_quantative") )
 { ret=stopp=1; stopp=1; D[231]++; if(dbg){print "D231"}; continue };
 if ( suw_any(-1) && ba(-1,"_unit") && s(-1) && wa(0,"_is_quantative") )
 { ret=stopp=1; D[232]++; if(dbg){print "D232"}; continue };
 if ( q(-3,"gl_need gl_nemn gl_vzmn deep_ne gl_pned gl_pnmn deep_pn") && ba(-3,"_gl_learn") &&
 pre_vi(-2) && q(-1,"suw_vi") &&
      q(1,"suw_ro prl_ro name_ro_sy isname") && s(-3,0) )
 { ret=stopp=1; D[233]++; if(dbg){print "D233"}; continue };

 if ( prq_sdedro(-2) &&
              (q(-1,"suw_tv")||wc(-1,"[ео]й$ [ео]м$ ами$")) && s(-2,-1) )
 { ret=stopp=1; D[234]++; if(dbg){print "D234"}; continue };
 if ( prq_sdmnim(-4) &&
          pre_da(-3) &&
               q(-2,"suw_da mest_da") &&
        suw_mnim(-1) && s(-4,-1) )
 { ret=stopp=1; D[235]++; if(dbg){print "D235"}; continue };

 if ( qxs(-2,"сколько где","у") &&
        q(-1,"mest_ro suw_ro") && s(-1) && p(0) )
 { ret=stopp=1; D[236]++; if(dbg){print "D236"}; continue };
 if ( qxs(-3,"сколько","у") &&
        q(-2,"mest_ro suw_ro") &&
       bw(-1,"быть") && s(-2,-1) )
 { ret=stopp=1; D[237]++; if(dbg){print "D237"}; continue };
 if ( qxs(-2,"сколько где","у") &&
        q(-1,"mest_ro suw_ro") &&
   pre_pr(1) &&
        q(2,"suw_pr") && s(0,1) )
 { ret=stopp=1; D[238]++; if(dbg){print "D238"}; continue };

 if ( qxs(-1,"не","может","быть")||
      qxs(-1,"может","не","быть хватить оказаться") )
 { ret=stopp=1; D[239]++; if(dbg){print "D239"}; continue };

 if ( q(-3,"gl_need gl_nemn gl_vzmn deep_ne gl_pned gl_pnmn deep_pn") && p(-4) &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-3,-1) && p(0) )
 { ret=stopp=1; D[240]++; if(dbg){print "D240"}; continue };

 if ( q(-5,"gl_need gl_nemn gl_vzmn deep_ne gl_pned gl_pnmn deep_pn") &&
 pre_vi(-4) &&
      q(-3,"suw_vi") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-5,-1) )
 { ret=stopp=1; D[241]++; if(dbg){print "D241"}; continue };
 if ( q(-5,"gl_need gl_nemn gl_vzmn deep_ne gl_pned gl_pnmn deep_pn") &&
 pre_da(-4) &&
      q(-3,"suw_da") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-5,-1) )
 { ret=stopp=1; D[242]++; if(dbg){print "D242"}; continue };

 if ( qf(1,5,"gl_in gl_ed gl_mn deep") &&
       w(qfn-1,"не") && s(0,qfn-1) && ba(qfn,"_gl_learn") && Q(0,"suw_edim") )
 { ret=stopp=1; D[243]++; if(dbg){print "D243"}; continue };

 if ( q(-3,"suw_im") &&
 pre_pr(-2) &&
      q(-1,"suw_pr") && s(-3,-1) )
 { ret=stopp=1; D[244]++; if(dbg){print "D244"}; continue };

 if ( q(-2,"qi_duom qi_duoz") &&
      q(-1,"suw_edro") &&
      q(1,"gl_mn gl_vzmn") && s(-2,0) )
 { ret=stopp=1; D[245]++; if(dbg){print "D245"}; continue };

 if ( mest_it(-4) &&
            q(-3,"suw_im") &&
            q(-2,"prl_ro") &&
            q(-1,"suw_ro") &&
            q(1,"mest_ro prl_ro") &&
            q(2,"suw_ro") && s(-4,1) )
 { ret=stopp=1; D[246]++; if(dbg){print "D246"}; continue };
 if ( mest_it(-3) &&
            q(-2,"suw_im") &&
            q(-1,"suw_ro") &&
            q(1,"mest_ro prl_ro") &&
            q(2,"suw_ro") && s(-3,1) )
 { ret=stopp=1; D[247]++; if(dbg){print "D247"}; continue };
 if ( mest_it(-4) &&
            q(-3,"suw_im") &&
            q(-2,"prl_ro") &&
            q(-1,"suw_ro") &&
            q(1,"suw_ro") && s(-3,0) )
 { ret=stopp=1; D[248]++; if(dbg){print "D248"}; continue };

 if ( q(-3,"suw_edim") &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro") &&
      q(1,"gl_ed") && s(-3,0) )
 { ret=stopp=1; D[249]++; if(dbg){print "D249"}; continue };
 if ( q(-2,"suw_edim") &&
      q(-1,"suw_ro") &&
      q(1,"gl_ed") && s(-2,0) )
 { ret=stopp=1; D[250]++; if(dbg){print "D250"}; continue };
 if ( q(-3,"suw_edim") &&
      q(-2,"suw_ro") &&
      q(-1," mest_ro prl_edro") &&
      q(1,"gl_ed") && s(-3,0) )
 { ret=stopp=1; D[251]++; if(dbg){print "D251"}; continue };

 if ( q(-2,"pre_ro preph_ro") &&
      q(-1,"suw_ro") &&
      q(1,"suw_ro") &&
      q(2,"gl_mn gl_vzmn") && s(-2,1) )
 { ret=stopp=1; D[252]++; if(dbg){print "D252"}; continue };

 if ( q(-4,"pre_ro preph_ro") &&
      q(-3,"mest_ro prl_ro") &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro suw_edne") &&
      q(1,"suw_edro name_ro_sy isname") && s(-4,0) && p(1) )
 { ret=stopp=1; D[253]++; if(dbg){print "D253"}; continue };
 if ( q(-3,"pre_ro preph_ro") &&
      q(-2,"mest_ro prl_ro") &&
      q(-1,"suw_ro suw_edne") &&
      q(1,"suw_edro name_ro_sy isname") && s(-4,0) && p(1) )
 { ret=stopp=1; D[254]++; if(dbg){print "D254"}; continue };

 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe gl_pnin gl_pned gl_pnmn deep_pn prq_pe") &&
      q(-3,"suw_vi") &&
sz_iili(-2) &&
      q(-1,"suw_vi") &&
      q(1,"suw_ro") &&  s(-4,0) )
 { ret=stopp=1; D[255]++; if(dbg){print "D255"}; continue };

 if ( qb(-6,-3,"pre_ro") &&
       q(-2,"gl_nemn") && ba(-2,"_gl_obj_tv") &&
       q(-1,"suw_tv mest_tv") && s(-3,-1) )
 { ret=0; stopp=1; edro2mnim=1; D[256]++; if(dbg){print "D256"}; continue };
 if ( q(-3,"suw_im mest_im mod_bz") &&
      q(-2,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") && ba(-2,"_gl_obj_tv") &&
      q(-1,"suw_tv mest_tv") && s(-3,-1) )
 { ret=stopp=1; D[257]++; if(dbg){print "D257"}; continue };

 if ( suw_any(-3) && ba(-3,"_gl_obj_tv") && Q(-3,"gl_mn") &&
            q(-2,"prl_tv mest_tv") &&
            q(-1,"suw_tv") && s(-3,-1) )
 { ret=stopp=1; D[258]++; if(dbg){print "D258"}; continue };
 if ( suw_any(-2) && ba(-2,"_gl_obj_tv") && Q(-2,"gl_mn") &&
            q(-1,"suw_tv mest_tv") && s(-2,-1) )
 { ret=stopp=1; D[259]++; if(dbg){print "D259"}; continue };
 if ( (suw_any(-2)||w(-2,"был было была")) && Q(-2,"prl_mnim") &&
             w(-1,"цвета") && s(-2,-1) )
 { ret=stopp=1; D[260]++; if(dbg){print "D260"}; continue };

 if ( prq_mnim(-3) &&
        pre_ro(-2) &&
             q(-1,"suw_ro") &&
      suw_mnim(1) && s(-3,0) )
 { ret=stopp=1; stopp=1; D[261]++; if(dbg){print "D261"}; continue };
 if ( q(-2,"prl_mnim prq_mnim") &&
         suw_mnim(-1) && Q(-1,"prl_mnim") &&
      q(1,"gl_mn gl_vzmn") && s(-2,0) )
 { ret=stopp=1; stopp=1; D[262]++; if(dbg){print "D262"}; continue };
 #
 if ( q(-3,"pre_vi") &&
      q(-2,"suw_vi") &&
      q(-1,"suw_edro") &&
      q(1,"suw_edim") &&
      q(2,"gl_ed mod_ed") && s(-3,1) )
 { ret=stopp=1; D[263]++; if(dbg){print "D263"}; continue };
 if ( qik_vi(-3) &&
           q(-2,"pre_vi") &&
           q(-1,"suw_vi") && s(-3,-1) )
 { ret=stopp=1; D[264]++; if(dbg){print "D264"}; continue };

 # родительный падеж: массовая обработка
 if ( q(-3,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-3,"_gl_preob_tv_obj_vi") &&
 pre_tv(-2) &&
      q(-1,"suw_tv mest_tv") && s(-2,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[265]++; if(dbg){print "D265"}; continue };
 if ( Ww_(-4,"не") && ba(-3,"_gl_preob_da_obj_vi") &&
        q(-3,"gl_pnin gl_pned gl_pnmn deep_pn") &&
   pre_da(-2) &&
        q(-1,"suw_da mest_da") && s(-3,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[266]++; if(dbg){print "D266"}; continue };

 if ( q(-2,"mest_mnim") &&
      q(-1,"mest_im mest_3e") && s(-2,-1) )
 { ret=0; edro2mnim=1; stopp=1; D[267]++; if(dbg){print "D267"}; continue };
 if ( q(-1,"mest_mnim") && s(-1) )
 { ret=0; edro2mnim=1; stopp=1; D[268]++; if(dbg){print "D268"}; continue };
 if ( q(-3,"mest_mnim") &&
         suw_mnim(-2) &&
sz_iili(-1) && s(-3,-1) )
 { ret=0; edro2mnim=1; stopp=1; D[269]++; if(dbg){print "D269"}; continue };

 if ( narph_any(-1) && s(-1) &&
        gl_nemn(xwn-1) && s(xwn-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[270]++; if(dbg){print "D270"}; continue };

 if ( se(-1,"-") && suw_mnim(0) && suw_mnim(-1) && prl_mnim(-2) )
 { ret=0; edro2mnim=1; stopp=1; D[271]++; if(dbg){print "D271"}; continue };
 if ( se(-1,"-") && suw_mnim(0) && suw_mnim(-1) && Q(-1,"suw_edro") )
 { ret=0; edro2mnim=1; stopp=1; D[272]++; if(dbg){print "D272"}; continue };
 #
 if ( p(-1) &&
      q(1,"prl_ro prq_ro") &&
      q(2,"suw_ro") &&
     (q(3,"suw_ro")||name_ro_sy(3)) && z(3) &&
         prq_mnim(4) && s(-1,1) )
 { ret=0; edro2mnim=1; stopp=1; D[273]++; if(dbg){print "D273"}; continue };
 if ( p(-1) &&
      q(1,"suw_ro") &&
     (q(2,"suw_ro")||name_ro_sy(2)||isname(2)) && z(2) &&
         prq_mnim(3) && s(0,1) )
 { ret=0; edro2mnim=1; stopp=1; D[274]++; if(dbg){print "D274"}; continue };


 if ( Ww_(-2,"не") &&
  deep_na(-1) && s(-1) )
 { ret=0; stopp=1; D[275]++; if(dbg){print "D275"}; continue };
 if ( suw_edzeim(-1) && q(0,"gl_paedze prl_kred_ze") && s(-1) )
 { ret=0; stopp=1; D[276]++; if(dbg){print "D276"}; continue };
 if ( suw_mnim(-1) && q(0,"gl_pamn") && s(-1) )
 { ret=0; stopp=1; D[277]++; if(dbg){print "D277"}; continue };
 if ( q(-1,"preph_vi preph_da preph_tv") && s(-1))
 { ret=0; stopp=1; D[278]++; if(dbg){print "D278"}; continue };
 if ( Ww_(-3,"не") && Q(0,"ipa_any") &&
        q(-2,"gl_pein gl_peed gl_pemn deep_pe") && Q(-2,"suw_edim") &&
        q(-1,"suw_tv mest_tv") && suw_mnvi(0) && s(-2,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[279]++; if(dbg){print "D279"}; continue };
 if ( Ww_(-7,"не") &&
   prq_pe(-6) &&
   pre_pr(-5) &&
        q(-4,"suw_pr") &&
   pre_tv(-3) &&
        q(-2,"mest_mntv prl_mntv prq_mntv") &&
 suw_mntv(-1) && suw_mnvi(0) && s(-7,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[280]++; if(dbg){print "D280"}; continue };
 if ( Ww_(-3,"не") && Q(0,"ipa_any") &&
        q(-2,"gl_pnin gl_pned gl_pnmn deep_pn") && Q(-2,"suw_edim") &&
        q(-1,"suw_tv mest_tv") && suw_mnvi(0) && s(-2,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[281]++; if(dbg){print "D281"}; continue };
 if ( Ww_(-3,"не") &&
        q(-2,"gl_pein gl_peed gl_pemn gl_vzmn deep_pe") && Q(-2,"suw_edim") &&
        q(-1,"suw_da mest_da") && suw_mnvi(0) && Q(0,"gl_in ipa_any") && s(-2,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[282]++; if(dbg){print "D282"}; continue };
 if ( Ww_(-3,"не") &&
        q(-2,"gl_pnin gl_pned gl_pnmn deep_pn") && Q(-2,"suw_edim") &&
        q(-1,"suw_da mest_da") && suw_mnvi(0) && Q(0,"gl_in ipa_any") && s(-2,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[283]++; if(dbg){print "D283"}; continue };
 if ( narph_spos(-1) &&
             !(w(xsn-2,"не") && s(xsn-2)) &&
               q(xsn-1,"gl_pnin gl_pned gl_pnmn deep_pn") &&
        suw_mnvi(0) && s(xsn-1,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[284]++; if(dbg){print "D284"}; continue };
 if ( q(-4,"prl_mnim prq_mnim") &&
 pre_ro(-3) &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro") && suw_mnvi(0) && s(-4,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[285]++; if(dbg){print "D285"}; continue };
 if ( q(-3,"prl_mnim prq_mnim") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && suw_mnvi(0) && s(-3,-1) &&
           !(suw_mnim(1) && s(1)) )
 { ret=0; edro2mnvi=1; stopp=1; D[286]++; if(dbg){print "D286"}; continue };
 if ( q(-3,"prl_mnim prq_mnim") &&
      q(-2,"suw_tv") &&
      q(-1,"suw_ro") && suw_mnvi(0) && s(-3,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[287]++; if(dbg){print "D287"}; continue };
 if ( gl_nemn(-3) &&
            q(-2,"prl_mnim prq_mnim") &&
            q(-1,"suw_tv") &&
     suw_mnvi(0) && s(-3,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[288]++; if(dbg){print "D288"}; continue };
 if ( q(-4,"prl_mn prq_mn") && z(-4) &&
 pre_pr(-3) &&
         suw_mnpr(-2) &&
      q(-1,"suw_ro") && suw_mnvi(0) && s(-3,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[289]++; if(dbg){print "D289"}; continue };
 if ( pre_ro(-2) &&
           q(-1,"suw_ro") &&
           q(1,"prl_krmn gl_mn") && suw_mnvi(0) && s(-2,0) && sQ(-2,0,"-") && p(1) )
 { ret=0; edro2mnvi=1; stopp=1; D[290]++; if(dbg){print "D290"}; continue };
 if ( q(-4,"prl_mnim prq_mnim") &&
 pre_pr(-3) &&
mest_pr(-2) &&
      q(-1,"suw_pr") && s(-4,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[291]++; if(dbg){print "D291"}; continue };
 if ( q(-4,"gl_pned gl_pnmn") &&
nar_kaq(-3) &&
 pre_da(-2) &&
      q(-1,"suw_da mest_da") && s(-4,-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[292]++; if(dbg){print "D292"}; continue };

 if ( pre_pr(-4) &&
           q(-3,"prl_pr mest_pr") &&
           q(-2,"suw_pr") &&
           q(-1,"suw_ro") &&
           q(1,"nar_spos") &&
           q(2,"gl_mn gl_vzmn") && s(-4,1) )
 { ret=0; stopp=1; edro2mnim=1; D[293]++; if(dbg){print "D293"}; continue };

 cst="более мало менее много полно сколько столько";
 if ( (q(-4,"prl_srav nar_srav")||w(-4,cst)) &&
  pre_da(-3) && s(-4,-3) &&
       q(-2,"suw_da") && z(-2) &&
       w(-1,"чем нежели") && s(-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[294]++; if(dbg){print "D294"}; continue };
 if ( (q(-2,"prl_srav nar_srav")||w(-2,cst)) && z(-2) &&
       w(-1,"чем нежели") && s(-1) )
 { ret=0; edro2mnvi=1; stopp=1; D[295]++; if(dbg){print "D295"}; continue };

 if ( q(1,"suw_ro isname") &&
      q(2,"nar_spos prl_kred_sr") &&
      q(3,"gl_nemn gl_vzmn") && s(0,2) )
 { ret=0; edro2mnvi=1; stopp=1; D[296]++; if(dbg){print "D296"}; continue };

 ##

 if ( se(0,"-") && q(1,"suw_ro") && Q(1,"suw_mnim") )
 { ret=stopp=1; stopp=1; D[297]++; if(dbg){print "D297"}; continue };
 if ( se(-1,"-") && q(-1,"suw_ro") && Q(-1,"suw_mnim") )
 { ret=stopp=1; stopp=1; D[298]++; if(dbg){print "D298"}; continue };


 if ( q(-2,"prl_ro") &&
      q(-1,"mest_da suw_da") && s(-2,-1) && p(0) )
 { ret=stopp=1; D[299]++; if(dbg){print "D299"}; continue };

 if ( q(-5,"gl_nein gl_need gl_nemn gl_vzed gl_vzmn deep_ne") &&
 pre_da(-4) &&
      q(-3,"prl_da mest_da") &&
      q(-2,"prl_da") &&
      q(-1,"suw_da") && s(-5,-1) )
 { ret=stopp=1; D[300]++; if(dbg){print "D300"}; continue };
 if ( q(-4,"gl_nein gl_need gl_nemn gl_vzed gl_vzmn deep_ne") &&
 pre_da(-3) &&
      q(-2,"prl_da mest_da") &&
      q(-1,"suw_da") && s(-4,-1) )
 { ret=stopp=1; D[301]++; if(dbg){print "D301"}; continue };
 if ( q(-2,"gl_nein gl_need gl_nemn gl_vzed gl_vzmn deep_ne") &&
      q(-1,"suw_da") &&
      q(1,"suw_ro") && s(-2,0) )
 { ret=stopp=1; D[302]++; if(dbg){print "D302"}; continue };

 if ( q(-2,"gl_in gl_ed gl_vzed deep") &&
      q(-1,"suw_tv") && Q(-1,"pre_any") && s(-2,0) )
 { ret=stopp=1; D[303]++; if(dbg){print "D303"}; continue };

 if ( q(-2,"suw_tv") && Q(-2,"pre_any") &&
      q(-1,"mest_ro prl_ro") &&
      q(1,"gl_in gl_ed gl_vzed deep") && s(-2,0) )
 { ret=stopp=1; D[304]++; if(dbg){print "D304"}; continue };
 if ( q(-1,"suw_tv") && Q(-1,"pre_any") &&
      q(1,"gl_in gl_ed gl_vzed deep") && s(-1,0) )
 { ret=stopp=1; D[305]++; if(dbg){print "D305"}; continue };

 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe prq_pe") &&
      q(-3,"suw_vi") &&
      q(-2,"suw_ro") &&
sz_iili(-1) && s(-4,-1) )
 { ret=stopp=1; D[306]++; if(dbg){print "D306"}; continue };
 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe prq_pe") &&
      q(-1,"suw_vi") && Q(-1,"prl_vi pre_any") &&
      q(1,"suw_ro") && s(-2,0) )
 { ret=stopp=1; D[307]++; if(dbg){print "D307"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn deep_pe prq_pe") &&
      q(-2,"prl_vi") &&
      q(-1,"suw_vi") && Q(-1,"prl_vi pre_any") && s(-3,-1) )
 { ret=stopp=1; D[308]++; if(dbg){print "D308"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn deep_pe prq_pe") &&
      q(-2,"suw_vi") && Q(-2,"prl_vi pre_any") &&
      q(-1,"suw_da") && s(-3,-1) )
 { ret=stopp=1; D[309]++; if(dbg){print "D309"}; continue };

 if ( q(-2,"suw_edsrim") &&
      q(-1,"mest_ro prl_edro") &&
      q(1,"gl_edsr") && s(-2,0) )
 { ret=stopp=1; D[310]++; if(dbg){print "D310"}; continue };
 if ( q(-1,"suw_edsrim") &&
      q(1,"gl_edsr") && s(-1,0) )
 { ret=stopp=1; D[311]++; if(dbg){print "D311"}; continue };

 if ( q(-2,"suw_im") &&
      q(-1,"mest_ro prl_edro prq_edro") &&
     qf(1,5,"gl_vzmn gl_nemn") && s(-2,qfn-1) )
 { ret=stopp=1; D[312]++; if(dbg){print "D312"}; continue };

#if ( q(-1,"suw_im") &&
#      q(1,"suw_ro") && s(-1,0) && p(1) )
#{ ret=stopp=1; D[313]++; if(dbg){print "D313"}; continue };

 if ( suw_mnim(-1) && Q(-1,"prl_mnim") &&
             q(1,"nar_spos nar_step prl_kred_sr") &&
             q(2,"gl_mn gl_vzmn") && s(-1,1) )
 { ret=stopp=1; D[314]++; if(dbg){print "D314"}; continue };
 if ( suw_mnim(-1) &&
             q(1,"nar_spos nar_step prl_kred_sr") &&
             q(2,"prl_kred_sr") &&
             q(3,"gl_mn gl_vzmn") && s(-1,2) )
 { ret=stopp=1; D[315]++; if(dbg){print "D315"}; continue };
 if ( suw_mnim(-1) &&
             q(1,"nar_spos nar_step prl_kred_sr") &&
             q(2,"qast") &&
             q(3,"prl_kred_sr") &&
             q(4,"gl_mn gl_vzmn") && s(-1,3) )
 { ret=stopp=1; D[316]++; if(dbg){print "D316"}; continue };

 if ( mest_it(1) &&
            q(2,"gl_peed gl_pned") && s(0,1) )
 { ret=stopp=1; D[317]++; if(dbg){print "D317"}; continue };

 if ( q(-3,"preph_ro") &&
         suw_edro(-2) &&
sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[318]++; if(dbg){print "D318"}; continue };
 if ( pre_ro(-4) &&
           q(-3,"prl_ro prq_ro mest_edro muk_edro") &&
           q(-2,"suw_ro") &&
     sz_iili(-1) && s(-4,-1) )
 { ret=stopp=1; D[319]++; if(dbg){print "D319"}; continue };
 if ( pre_ro(-5) &&
           q(-4,"prl_ro prq_ro mest_edro muk_edro") &&
           q(-3,"suw_ro") &&
     sz_iili(-2) &&
           q(-1,"mest_ro prl_edro") && s(-5,-1) )
 { ret=stopp=1; D[320]++; if(dbg){print "D320"}; continue };
 if ( q(-4,"prl_edzero prq_edzero mest_edzero muk_edro") && W(-4,"его нее ее") &&
           suw_edzero(-3) &&
sz_iili(-2) &&
      q(-1,"mest_ro") && s(-4,-1) &&
   !( q(1,"prq_mnim") && z(0) ) )
 { ret=stopp=1; D[321]++; if(dbg){print "D321"}; continue };
 if ( q(-3,"prl_edzero prq_edzero mest_edzero muk_edro") && W(-3,"его нее ее") &&
           suw_edzero(-2) &&
sz_iili(-1) && s(-3,-1) &&
   !( q(1,"prq_mnim") && z(0) ) )
 { ret=stopp=1; D[322]++; if(dbg){print "D322"}; continue };

 if ( ((Qw_(-4,"pre_any") && q(-3,"suw_edim") && Q(-3,"prl_edim"))||q(-3,"name_im_sy isname")) &&
    sz_iili(-2) &&
          q(-1,"suw_edim") && Q(-1,"prl_edim") &&
         qf(1,3,"prq_krmn gl_mn gl_vzmn") && s(-3,qfn-1) )
 { ret=stopp=1; D[323]++; if(dbg){print "D323"}; continue };
 if ( q(-4,"pre_da preph_da") &&
      q(-3,"suw_da") &&
sz_iili(-2) &&
      q(-1,"suw_da") && s(-4,-1) )
 { ret=stopp=1; D[324]++; if(dbg){print "D324"}; continue };

 if ( qik_im(-4) &&
           q(-3,"suw_mnro") &&
           q(-2,"prl_ro") &&
           q(-1,"suw_ro") &&
           q(1,"gl_mn gl_vzmn") && s(-4,0) )
 { ret=stopp=1; D[325]++; if(dbg){print "D325"}; continue };
 if ( q(-3,"suw_mnim") &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro") &&
      q(1,"gl_mn gl_vzmn") && s(-3,0) )
 { ret=stopp=1; D[326]++; if(dbg){print "D326"}; continue };


 if ( w(-1,"пол") && sc(-1,"-") )
 { ret=stopp=1; D[327]++; if(dbg){print "D327"}; continue };

 cst="достаточно мало много нет хватает хватит";
 if ( wf(1,5,cst) && s(0,wfn-1) && p(wfn) )
 { ret=stopp=1; D[328]++; if(dbg){print "D328"}; continue };
 if ( w(-2,cst) &&
      w(-1,"ли") && s(-2,-1) && Q(0,"prl_kred_ze") )
 { ret=stopp=1; D[329]++; if(dbg){print "D329"}; continue };
 if ( w(-1,cst) && s(-1) && Q(0,"prl_kred_ze") )
 { ret=stopp=1; D[330]++; if(dbg){print "D330"}; continue };


 if ( w(-1,"ни") && s(-1) && z(0) &&
      w(1,"ни") && s(1) &&
      q(2,"suw_ro") && Q(2,"suw_mnim") )
 { ret=stopp=1; D[331]++; if(dbg){print "D331"}; continue };
 if ( w(-3,"ни") && s(-3) && z(-2) &&
      q(-2,"suw_ro") && Q(-2,"suw_mnim") &&
      w(-1,"ни") && s(1) )
 { ret=stopp=1; D[332]++; if(dbg){print "D332"}; continue };
 if ( w(-4,"ни") &&
         suw_edro(-3) && s(-4,-3) &&
         suw_mnim(-2) && z(-2) &&
      w(-1,"ни") && s(-1) )
 { ret=stopp=1; D[333]++; if(dbg){print "D333"}; continue };
 if ( w(-6,"не") &&
      q(-5,"mod_ed mod_mn") &&
  gl_in(-4) &&
 pre_ro(-3) &&
      q(-2,"mest_ro suw_ro") &&
      w(-1,"ни") && s(-6,-1) )
 { ret=stopp=1; D[334]++; if(dbg){print "D334"}; continue };
 if ( w(-4,"не") &&
      q(-3,"mod_ed mod_mn") &&
  gl_in(-2) &&
      w(-1,"ни") && s(-4,-1) )
 { ret=stopp=1; D[335]++; if(dbg){print "D335"}; continue };
 if ( w(-5,"не") &&
      q(-4,"mod_ed mod_mn") &&
   qast(-3) &&
  gl_in(-2) &&
      w(-1,"ни") && s(-5,-1) )
 { ret=stopp=1; D[336]++; if(dbg){print "D336"}; continue };

 if ( Qw_(-1,"pre_any") &&
       wf(1,6,"было будет") && w(wfn-1,"не") && s(0,wfn-1) )
 { ret=stopp=1; D[337]++; if(dbg){print "D337"}; continue };
 if ( Qw_(-1,"pre_any") &&
       wf(1,5,"стало станет осталось останется остается хватало хватит хватило хватает") && s(0,wfn-1) )
 { ret=stopp=1; D[338]++; if(dbg){print "D338"}; continue };
 if ( Qw_(-1,"pre_any") && qsf(1,5,vvpat) && s(0,sfn-1) && vv(sfn,sfn+7) &&
       wf(vvn+1,vvn+6,"стало станет осталось останется остается хватало хватит хватило хватает") && s(vvn+1,wfn-1) )
 { ret=stopp=1; D[339]++; if(dbg){print "D339"}; continue };

 cst="более больше менее меньше";
 if ( w(-2,cst) &&
      w(-1,"ни") && s(-2,-1) )
 { ret=stopp=1; D[340]++; if(dbg){print "D340"}; continue };
 if ( w(-1,"ни") &&
      w(1,cst) s(-1,0) )
 { ret=stopp=1; D[341]++; if(dbg){print "D341"}; continue };

 if ( w(1,"не") && q(2,"gl_pein gl_pnin") && s(0,1) )
 { ret=stopp=1; D[342]++; if(dbg){print "D342"}; continue };

 cst="более мало менее много полно сколько столько";
 if ( (q(-2,"prl_srav nar_srav")||w(-2,cst)) &&
      (q(-1,"prl_edro prq_edro")||w(-1,"же")) && s(-2,-1) && !(gl_in(1) && s(0)) )
 { ret=stopp=1; D[343]++; if(dbg){print "D343"}; continue };
 if ( (q(-1,"prl_srav nar_srav")||w(-1,cst)) && s(-1) && !(gl_in(1) && s(0)) )
 { ret=stopp=1; D[344]++; if(dbg){print "D344"}; continue };

 if ( q(-2,"gl_pnin gl_pned gl_pnmn deep_pn") && Q(-2,"gl_poed gl_pomn") &&
      q(-1,"suw_da mest_da") && suw_mnim(0) && Q(0,"gl_in") && s(-2,-1) && (p(0)||((sz_iili(1)||pre_any(1)) && s(0))) )
 { ret=stopp=1; D[345]++; if(dbg){print "D345"}; continue };
 if ( q(-2,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") && Q(-2,"gl_poed gl_pomn") &&
      q(-1,"suw_da mest_da") && suw_mnim(0) && Q(0,"gl_in") && s(-2,-1) && (p(0)||((sz_iili(1)||pre_any(1)) && s(0))) )
 { ret=stopp=1; D[346]++; if(dbg){print "D346"}; continue };

 if ( z(0) &&
      q(1,"prq_edro") )
 { ret=stopp=1; D[347]++; if(dbg){print "D347"}; continue };

 if ( prq_edro(-2) &&
             q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[348]++; if(dbg){print "D348"}; continue };

 if ( q(-3,"pre_tv preph_tv") &&
      q(-2,"suw_tv mest_tv") &&
      q(-1,"suw_tv") && s(-3,-1) )
 { ret=stopp=1; D[349]++; if(dbg){print "D349"}; continue };
 if ( q(-2,"pre_tv preph_tv") &&
      q(-1,"suw_tv mest_tv") && s(-2,-1) && z(0) &&
      q(1,"suw_tv") )
 { ret=stopp=1; D[350]++; if(dbg){print "D350"}; continue };
 if ( q(-2,"pre_tv preph_tv") &&
      q(-1,"suw_tv mest_tv") && s(-2,-1) && z(0) &&
      q(1,"mest_tv prl_tv mest_3e") &&
      q(2,"suw_tv") && s(1) )
 { ret=stopp=1; D[351]++; if(dbg){print "D351"}; continue };
 if ( pre_pr(-4) &&
           q(-3,"prl_edpr prq_edpr mest_pr") &&
           q(-2,"suw_pr suw_edme") &&
           q(-1,"suw_ro suw_edme") && s(-4,-1) &&
         !(w(1,"не") && gl_pnmn(2) && s(0,1)) )
 { ret=stopp=1; D[352]++; if(dbg){print "D352"}; continue };
 if ( Qw_(-4,"gl_vzed gl_vzmn gl_peed gl_pned gl_pemn gl_pnmn deep_pe deep_pn gl_pein gl_pnin") &&
   pre_pr(-3) &&
        q(-2,"prl_edpr prq_edpr mest_pr") &&
        q(-1,"suw_pr suw_edme") && s(-3,-1) &&
      !(w(1,"не") && gl_pnmn(2) && s(0,1)) )
 { ret=stopp=1; D[353]++; if(dbg){print "D353"}; continue };
 if ( pre_pr(-3) &&
           q(-2,"suw_pr suw_edme") &&
           q(-1,"suw_ro suw_edme") && s(-3,-1) &&
         !(w(1,"не") && gl_pnmn(2) && s(0,1)) )
 { ret=stopp=1; D[354]++; if(dbg){print "D354"}; continue };
 if ( pre_pr(-4) &&
    prq_edpr(-3) &&
           q(-2,"suw_tv") &&
           q(-1,"suw_da suw_edme") && s(-4,-1) )
 { ret=stopp=1; D[355]++; if(dbg){print "D355"}; continue };

 if ( q(-3,"pre_ro preph_ro") &&
      q(-2,"prl_ro prq_ro mest_ro") &&
      q(-1,"suw_ro suw_edme") &&
      q(1,"suw_im suw_edme") && s(-3,0) )
 { ret=stopp=1; D[356]++; if(dbg){print "D356"}; continue };

 if ( pre_da(-3) &&
           q(-2,"prl_edda prq_edda mest_da") &&
           q(-1,"suw_edda mest_da") && s(-3,-1) )
 { ret=stopp=1; D[357]++; if(dbg){print "D357"}; continue };
 if ( pre_da(-2) &&
           q(-1,"suw_da mest_da") && s(-2,-1) )
 { ret=stopp=1; D[358]++; if(dbg){print "D358"}; continue };
 if ( pre_ro(-2) && p(-3) &&
           q(-1,"suw_ro mest_ro") && W(-1,"них") && s(-2,0) )
 { ret=stopp=1; D[359]++; if(dbg){print "D359"}; continue };



 # seek реальные фиксированные случаи

 if ( q(-4,"gl_nein gl_need gl_nemn gl_vzmn deep_ne gl_pnin gl_pned gl_pnmn deep_pn") &&
 pre_pr(-3) &&
      q(-2,"suw_pr suw_edme mest_pr") &&
      q(-1,"mest_pr prl_edpr mest_3e") && s(-4,-1) )
 { ret=stopp=1; D[360]++; if(dbg){print "D360"}; continue };
 if ( q(-3,"gl_nein gl_need gl_nemn gl_vzmn deep_ne gl_pnin gl_pned gl_pnmn deep_pn") &&
 pre_pr(-2) &&
      q(-1,"suw_pr suw_edme mest_pr") && s(-3,-1) && Q(-1,"mest_3e") )
 { ret=stopp=1; D[361]++; if(dbg){print "D361"}; continue };
 if ( q(-6,"gl_nein gl_need gl_nemn gl_vzmn deep_ne gl_pnin gl_pned gl_pnmn deep_pn") &&
 pre_pr(-5) &&
      q(-4,"mest_pr prl_pr") &&
      q(-3,"suw_pr suw_edme") &&
 pre_pr(-2) &&
      q(-1,"suw_pr mest_pr") && s(-6,-1) )
 { ret=stopp=1; D[362]++; if(dbg){print "D362"}; continue };
 if ( q(-5,"gl_nein gl_need gl_nemn gl_vzmn deep_ne gl_pnin gl_pned gl_pnmn deep_pn") &&
 pre_tv(-4) &&
      q(-3,"suw_tv") &&
 pre_pr(-2) &&
      q(-1,"suw_pr mest_pr") && s(-5,-1) )
 { ret=stopp=1; D[363]++; if(dbg){print "D363"}; continue };
 if ( q(-5,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
      q(-4,"suw_im") &&
      q(-3,"suw_ro") &&
 pre_pr(-2) &&
      q(-1,"suw_pr mest_pr") && s(-5,-1) )
 { ret=stopp=1; D[364]++; if(dbg){print "D364"}; continue };
 if ( q(-5,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
      q(-4,"mest_tv prl_tv") &&
      q(-3,"suw_tv") &&
 pre_pr(-2) &&
      q(-1,"suw_pr suw_edme mest_pr") && s(-5,-1) )
 { ret=stopp=1; D[365]++; if(dbg){print "D365"}; continue };
 if ( q(-3,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && Q(-1,"mest_vi prl_vi") && s(-3,-1) )
 { ret=stopp=1; D[366]++; if(dbg){print "D366"}; continue };
 if ( pre_vi(-2) &&
           q(-1,"suw_vi") && q(1,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") && s(-2,0) && Q(-1,"mest_vi prl_vi") )
 { ret=stopp=1; D[367]++; if(dbg){print "D367"}; continue };
 if ( q(-4,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
      q(-3,"prl_kred_sr nar_kaq nar_spos") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && Q(-1,"mest_vi prl_vi") && s(-4,-1) )
 { ret=stopp=1; D[368]++; if(dbg){print "D368"}; continue };
 if ( q(-6,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
 pre_vi(-5) &&
      q(-4,"suw_vi") &&
      q(-3,"nar_mest") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-6,-1) )
 { ret=stopp=1; D[369]++; if(dbg){print "D369"}; continue };
 if ( q(-6,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
 pre_pr(-5) &&
      q(-4,"prl_pr") &&
      q(-3,"suw_pr suw_edme") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-6,-1) )
 { ret=stopp=1; D[370]++; if(dbg){print "D370"}; continue };
 if ( q(-5,"gl_nein gl_need gl_nemn gl_vzmn deep_ne") &&
 pre_pr(-4) &&
      q(-3,"suw_pr suw_edme") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-5,-1) )
 { ret=stopp=1; D[371]++; if(dbg){print "D371"}; continue };

 if ( q(-4,"suw_vi") &&
      q(-3,"gl_pein gl_peed gl_pemn gl_vzmn deep_pe") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && Q(-1,"mest_vi prl_vi") && s(-4,-1) )
 { ret=stopp=1; D[372]++; if(dbg){print "D372"}; continue };
 if ( q(-5,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-4,"prl_vi prq_vi mest_vi") &&
      q(-3,"suw_vi") &&
 pre_pr(-2) &&
      q(-1,"suw_pr suw_edme") && Q(-1,"mest_pr prl_pr") && s(-5,-1) )
 { ret=stopp=1; D[373]++; if(dbg){print "D373"}; continue };
 if ( q(-4,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-3,"suw_vi mest_vi") &&
 pre_pr(-2) &&
      q(-1,"suw_pr") && Q(-1,"mest_pr prl_pr") && s(-4,-1) )
 { ret=stopp=1; D[374]++; if(dbg){print "D374"}; continue };
 if ( q(-6,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-5,"prl_vi prq_vi mest_vi") &&
      q(-4,"suw_vi") &&
 pre_pr(-3) &&
      q(-2,"suw_pr") && Q(-2,"mest_pr prl_pr") &&
mest_ro(-1) && s(-6,-1) )
 { ret=stopp=1; D[375]++; if(dbg){print "D375"}; continue };
 if ( q(-5,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-4,"suw_vi mest_vi") &&
 pre_pr(-3) &&
      q(-2,"suw_pr suw_edme") && Q(-2,"mest_pr prl_pr") &&
mest_ro(-1) && s(-5,-1) )
 { ret=stopp=1; D[376]++; if(dbg){print "D376"}; continue };
 if ( q(-5,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-4,"prl_vi prq_vi mest_vi") &&
      q(-3,"suw_vi") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && Q(-1,"mest_vi prl_vi") && s(-5,-1) )
 { ret=stopp=1; D[377]++; if(dbg){print "D377"}; continue };
 if ( q(-4,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-3,"suw_vi mest_vi") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && Q(-1,"mest_vi prl_vi") && s(-4,-1) )
 { ret=stopp=1; D[378]++; if(dbg){print "D378"}; continue };
 if ( q(-5,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-4,"suw_vi mest_vi") &&
 pre_vi(-3) &&
      q(-2,"suw_vi") && Q(-2,"mest_vi prl_vi") && s(-5,-2) && sc(-1,"-") )
 { ret=stopp=1; D[379]++; if(dbg){print "D379"}; continue };
 if ( q(-5,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-4,"prl_vi prq_vi mest_vi") &&
      q(-3,"suw_vi") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-5,-1) )
 { ret=stopp=1; D[380]++; if(dbg){print "D380"}; continue };
 if ( q(-4,"gl_pein gl_pnin gl_peed gl_pemn gl_pned gl_pnmn deep_pe deep_pn") &&
      q(-3,"suw_vi mest_vi") &&
 pre_tv(-2) &&
      q(-1,"suw_tv") && Q(-1,"mest_tv prl_tv") && s(-4,-1) )
 { ret=stopp=1; D[381]++; if(dbg){print "D381"}; continue };


if ( p(-2) &&
        suw_any(-1) && s(-1) && sQ(-1,-1,"-") &&
     Q(-1,"sz qast pre_any prl_any prq_any mest_ed mest_mn gl_ed gl_pemn gl_pnmn gl_nemn nar_vrem narph_any gl_poed") )
 { ret=stopp=1; D[382]++; if(dbg){print "D382"}; continue };
 if ( suw_edzeim(-2) &&
               q(-1,"mest_ro prl_edro") &&
              qf(1,5,"gl_paedze") && s(-2,qfn-1) &&
               Q(-2,"sz qast pre_any prl_ed prl_mn mest_ed mest_mn gl_ed gl_pemn gl_pnmn gl_nemn nar_vrem narph_any gl_poed") )
 { ret=stopp=1; D[383]++; if(dbg){print "D383"}; continue };
 if ( suw_edzeim(-1) && qf(1,5,"gl_paedze") && s(-1,qfn-1) &&
               Q(-1,"sz qast pre_any prl_ed prl_mn mest_ed mest_mn gl_ed gl_pemn gl_pnmn gl_nemn nar_vrem narph_any gl_poed") )
 { ret=stopp=1; D[384]++; if(dbg){print "D384"}; continue };
 if ( prq_any(-2) &&
            q(-1,"suw_tv") && s(-2,-1) &&
            Q(-1,"sz qast pre_any prl_ed prl_mn mest_ed mest_mn gl_ed gl_pemn gl_pnmn gl_nemn nar_vrem narph_any") )
 { ret=stopp=1; D[385]++; if(dbg){print "D385"}; continue };
 if ( pre_ro(-2) &&
           q(-1,"suw_ro mest_ro") &&
           w(1,"не") && mod_bz(2) && s(-2,1) )
 { ret=stopp=1; D[386]++; if(dbg){print "D386"}; continue };


break}; return ret }

function sw_em_i_f(ret, stopp) { while ( !stopp ) {
 if ( q(1,"suw_edro prl_kred_sr") &&
      q(2,"prl_kred_mu prq_kred_mu") && s(0,1) )
 { ret=stopp=1; D[387]++; if(dbg){print "D387"}; continue };
 if ( q(1,"prl_kred_mu prq_kred_mu") && s(0) )
 { ret=stopp=1; D[388]++; if(dbg){print "D388"}; continue };

 if ( q(-2,"prl_edmuim prq_edmuim mest_edmuim muk_edim") &&
      w(-1,"всё все это") && Q(0,"gl_paedmu") && s(-2,-1) )
 { ret=stopp=1; D[389]++; if(dbg){print "D389"}; continue };
 if ( w(-1,"всё все это") && Q(0,"gl_paedmu") && s(-1) )
 { ret=stopp=1; D[390]++; if(dbg){print "D390"}; continue };

 if ( q(-2,"prl_edmuim prq_edmuim mest_edmuim muk_edim") &&
      w(-1,"один") && s(-2,-1) )
 { ret=stopp=1; D[391]++; if(dbg){print "D391"}; continue };
 if ( w(-1,"один") && s(-1) )
 { ret=stopp=1; D[392]++; if(dbg){print "D392"}; continue };

 if ( (p(-1) || ww_(-1,"а и вот что") ) &&
       q(1,"mest_pedmuim") && s(0) )
 { ret=stopp=1; D[393]++; if(dbg){print "D393"}; continue };

 if ( q(-3,"mest_it") &&
      w(-2,"всего") &&
      w(-1,"лишь только") && s(-3,-1) )
 { ret=stopp=1; D[394]++; if(dbg){print "D394"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"же ж лишь только") && s(-2,-1) )
 { ret=stopp=1; D[395]++; if(dbg){print "D395"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"не") && s(-2,-1) )
 { ret=stopp=1; D[396]++; if(dbg){print "D396"}; continue };
 if ( q(-1,"mest_it") && s(-1) )
 { ret=stopp=1; D[397]++; if(dbg){print "D397"}; continue };

 if ( w(-2,"и не") &&
      q(-1,"mest_im") && s(-2,-1) && Q(0,"gl_paedmu") )
 { ret=stopp=1; D[398]++; if(dbg){print "D398"}; continue };

 #_#_#
 if ( q(-2,"pre_im") &&
      q(-1,"prl_edmuim prq_edmuim mest_edmuim muk_edim") && s(-2,-1) )
 { ret=stopp=1; D[399]++; if(dbg){print "D399"}; continue };

 if (prex == 1) { pre_string = "prex_im" } else { pre_string = "pre_im" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[400]++; if(dbg){print "D400"}; continue };
 #_#_#

 if ( q(-1,"prl_edmuim prq_edmuim") && s(-1) )
 { ret=stopp=1; D[401]++; if(dbg){print "D401"}; continue };
 if ( q(-2,"prl_edmuim prq_edmuim mest_edmuim muk_edim") &&
      w(-1,"то") && sc(-1,"-") && s(-1) )
 { ret=stopp=1; D[402]++; if(dbg){print "D402"}; continue };

 if ( sw_im_f() )
 { ret=stopp=1; D[403]++; if(dbg){print "D403", "sw_im_f"}; continue };

break}; return ret }

function sw_em_v_f(ret, stopp) { while ( !stopp ) {
 if ( sw_vi_f() )
 { ret=stopp=1; D[404]++; if(dbg){print "D404", "sw_vi_f"}; continue };

 if ( q(-1,"gl_pein gl_peed gl_pemn deep_pe") && s(-1) &&
   !(q_(0,swo_edmu_ro) && q_(0,sw_edmu_ro)) )
 { ret=stopp=1; D[405]++; if(dbg){print "D405"}; continue };
 if ( q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && s(-1) &&
   !(q_(0,swo_edmu_ro) && q_(0,sw_edmu_ro)) )
 { ret=stopp=1; D[406]++; if(dbg){print "D406"}; continue };
 if ( qb(-3,-1,"prl_kred_mu") && s(qbn,-1) )
 { ret=stopp=1; D[407]++; if(dbg){print "D407"}; continue };

 #_#_#
 if ( q(-3,"pre_vi preph_vi") &&
     (q(-2,"prl_edmuvi prq_edmuvi mest_edmuvi")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmuvi prq_edmuvi mest_edmuvi")||wc(-1,"^[0-9]+$")) && s(-3,-1) )
 { ret=stopp=1; D[408]++; if(dbg){print "D408"}; continue };
 if ( q(-2,"pre_vi preph_vi") &&
      q(-1,"prl_edmuvi prq_edmuvi muk_edvi") && s(-2,-1) )
 { ret=stopp=1; D[409]++; if(dbg){print "D409"}; continue };

 if (prex == 1) { pre_string = "prex_vi preph_vi" } else { pre_string ="pre_vi preph_vi" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[410]++; if(dbg){print "D410"}; continue };
 #_#_#

 if ( q(-1,"preph_vi prl_edmuvi prq_edmuvi muk_edvi") && s(-1) && !(suw_any(-2) && sc(-2,"-") ) )
 { ret=stopp=1; D[411]++; if(dbg){print "D411"}; continue };
 if ( q(-2,"preph_vi prl_edmuvi prq_edmuvi muk_edvi") &&
      w(-1,"то нибудь либо") && sc(-1,"-") && s(-1) )
 { ret=stopp=1; D[412]++; if(dbg){print "D412"}; continue };

break}; return ret }

function sw_em_d_f(ret, stopp) { while ( !stopp ) {
 if ( loc2emd==1 )
 { ret=stopp=1; D[413]++; if(dbg){print "D413", "sw_da_f"}; continue };

 if ( sw_da_f() )
 { ret=stopp=1; D[414]++; if(dbg){print "D414", "sw_da_f"}; continue };

 if ( w(-1,"без до от с") && s(-1) && Q(0,"suw_edzevi prl_edzetv") )
 { ret=stopp=1; D[415]++; if(dbg){print "D415"}; continue };
 if ( w(1,"нет") && s(0) )
 { ret=stopp=1; D[416]++; if(dbg){print "D416"}; continue };

 #_#_#
 if ( q(-3,"pre_da preph_da") &&
     (q(-2,"prl_edmuda prq_edmuda mest_edmuda")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmuda prq_edmuda mest_edmuda")||wc(-1,"^[0-9]+$")) && s(-3,-1) )
 { ret=stopp=1; D[417]++; if(dbg){print "D417"}; continue };
 if ( q(-2,"pre_da preph_da") &&
     (q(-1,"prl_edmuda prq_edmuda mest_edmuda mest_3e")||wc(-1,"^[0-9]+$")) && s(-2,-1) )
 { ret=stopp=1; D[418]++; if(dbg){print "D418"}; continue };

 if (prex == 1) { pre_string = "prex_da preph_da" } else { pre_string = "pre_da preph_da" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[419]++; if(dbg){print "D419"}; continue };
 #_#_#
 if ( (q(-1,"preph_da prl_edmuda prq_edmuda mest_edmuda")||wc(-1,"^[0-9]+$")) && W(-1,"ему") && s(-1) && Wc(-1,"[ео]ву$") )
 { ret=stopp=1; D[420]++; if(dbg){print "D420"}; continue };
break}; return ret }

function sw_em_r_f(ret, stopp) { while ( !stopp ) {
 #
 if ((q(-4,"qi_duom")||wc(-4,"[234][^0-9]*$")) &&
      q(-3,"prl_mnro prq_mnro mest_mnro") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-4,-1) )
 { ret=stopp=1; D[421]++; if(dbg){print "D421"}; continue };
 if ( (w(-2,"нет")||q(-2,"pre_ro qi_duom")||wc(-2,"[234][^0-9]*$")) &&
       q(-1,"prl_mnro prq_mnro mest_mnro") && s(-2,-1) && W(-1,"них нее них") )
 { ret=stopp=1; D[422]++; if(dbg){print "D422"}; continue };
 if ( (w(-3,"нет")||q(-3,"pre_ro qi_duom")||wc(-3,"[234][^0-9]*$")) &&
       q(-2,"prl_mnro prq_mnro mest_mnro") &&
       q(-1,"prl_mnro prq_mnro mest_mnro") && s(-3,-1) && W(-1,"них нее них") )
 { ret=stopp=1; D[423]++; if(dbg){print "D423"}; continue };

 if ( (w(-1,"нет")||q(-1,"pre_ro qi_duom")||wc(-1,"[234][^0-9]*$")) && s(-1) )
 { ret=stopp=1; D[424]++; if(dbg){print "D424"}; continue };
 if ( prq_edmuro(-3) &&
          pre_pr(-2) &&
               q(-1,"suw_pr") && s(-3,-1) )
 { ret=stopp=1; D[425]++; if(dbg){print "D425"}; continue };
 if ( w(-3,"какого") &&
   qast(-2) &&
      q(-1,"mest_im suw_im") && s(-3,-1) )
 { ret=stopp=1; D[426]++; if(dbg){print "D426"}; continue };
 if ( w(-2,"какого") &&
      q(-1,"mest_im suw_im") && s(-2,-1) )
 { ret=stopp=1; D[427]++; if(dbg){print "D427"}; continue };
 if ( q(1,"prl_edmuro prl_mnro") && s(0) && p(-1) && p(1) && Q(1,"suw_ro") )
 { ret=stopp=1; D[428]++; if(dbg){print "D428"}; continue };
 if ( q(-2,"prl_edmuro prl_mnro") &&
      q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[429]++; if(dbg){print "D429"}; continue };

 #_#_#
 if ( q(-3,"pre_ro preph_ro") &&
     (q(-2,"prl_edmuro prq_edmuro mest_ro")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmuro prq_edmuro")||wc(-1,"^[0-9]+$")||wc(-1,"[ео]го$ [ео]ва$")) && s(-3,-1) )
 { ret=stopp=1; D[430]++; if(dbg){print "D430"}; continue };
 if ( q(-2,"pre_ro preph_ro") &&
     (q(-1,"prl_edmuro prq_edmuro mest_ro")||wc(-1,"^[0-9]+$")) && W(-1,"него нее них меня") && s(-2,-1) )
 { ret=stopp=1; D[431]++; if(dbg){print "D431"}; continue };

 if (prex == 1) { pre_string = "prex_ro preph_ro" } else { pre_string = "pre_ro preph_ro" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[432]++; if(dbg){print "D432"}; continue };
 #_#_#

 if ( q(-2,"prl_edmuro prq_edmuro mest_edmuro muk_edmuro") &&
mest_3e(-1) && s(-2,-1) )
 { ret=stopp=1; D[433]++; if(dbg){print "D433"}; continue };
 if ( (q(-2,"preph_ro prl_edmuro prq_edmuro mest_edmuro")||wc(-2,"^[0-9]+$")) && W(-2,"его него них него меня") &&
       w(-1,"его ее их же") && s(-2,-1) )
 { ret=stopp=1; D[434]++; if(dbg){print "D434"}; continue };
 cst="его ее меня него отчего";
 if ( (q(-1,"preph_ro prl_edmuro prq_edmuro mest_edmuro")||wc(-1,"^[0-9]+$")) && W(-1,cst) && s(-1) )
 { ret=stopp=1; D[435]++; if(dbg){print "D435"}; continue };
 if ( (q(1,"prl_edmuro prq_edmuro")||wc(-1,".[ео]го$ [ео]ва$") ) && s(0) && p(1) )
 { ret=stopp=1; D[436]++; if(dbg){print "D436"}; continue };

 if ( sw_edro_f() )
 { ret=stopp=1; D[437]++; if(dbg){print "D437", "sw_edro_f"}; continue };
 if ( sw_ro_f() )
 { ret=stopp=1; D[438]++; if(dbg){print "D438", "sw_ro_f"}; continue };
 if ( edro2mnvi )
 { ret=0; stopp=1; D[439]++; if(dbg){print "D439"}; continue };

break}; return ret }

function sw_em_t_f(ret, stopp) { while ( !stopp ) {
 if ( sw_tv_f() )
 { ret=stopp=1; D[440]++; if(dbg){print "D440", "sw_tv_f"}; continue };

 #_#_#
 if ( q(-3,"pre_tv preph_tv") &&
     (q(-2,"prl_edmutv prq_edmutv mest_edmutv")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmutv prq_edmutv mest_edmutv")||wc(-1,"^[0-9]+$")) && s(-3,-1) )
 { ret=stopp=1; D[441]++; if(dbg){print "D441"}; continue };
 if ( q(-2,"pre_tv preph_tv") &&
      q(-1,"prl_edmutv prq_edmutv mest_edmutv") && s(-2,-1) )
 { ret=stopp=1; D[442]++; if(dbg){print "D442"}; continue };

 if (prex == 1) { pre_string = "prex_tv preph_tv" } else { pre_string = "pre_tv preph_tv" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[443]++; if(dbg){print "D443"}; continue };
 #_#_#

 if ( q(-1,"preph_tv prl_edmutv prq_edmutv mest_edmutv") && s(-1) )
 { ret=stopp=1; D[444]++; if(dbg){print "D444"}; continue };
break}; return ret }

function sw_em_p_f(ret, stopp) { while ( !stopp ) {
 #
 if ( ismark(-1,"Npre") )
 { ret=0; stopp=1; D[445]++; if(dbg){print "D445"}; continue };

 #_#_#
 if ( q(-3,"pre_pr") &&
     (q(-2,"prl_edmupr prq_edmupr mest_edmupr mest_3e")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmupr prq_edmupr mest_edmupr")||wc(-1,"^[0-9]+$")) && s(-3,-1) )
 { ret=stopp=1; D[446]++; if(dbg){print "D446"}; continue };
 if ( q(-2,"pre_pr") &&
      q(-1,"prl_edmupr prq_edmupr mest_edmupr") && s(-2,-1) && W(-1,"мне нем") )
 { ret=stopp=1; D[447]++; if(dbg){print "D447"}; continue };

 if (prex == 1) { pre_string = "prex_pr" } else { pre_string = "pre_pr" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[448]++; if(dbg){print "D448"}; continue };
 #_#_#
 if ( q(-1,"prl_edmupr prq_edmupr") && s(-1) )
 { ret=stopp=1; D[449]++; if(dbg){print "D449"}; continue };

break}; return ret }

function sw_em_q_f(ret, stopp) { while ( !stopp ) {
 #
 if ((qi_duom(-2)||wc(-2,"[234][^0-9]*$")) &&
            q(-1,"prl_edmuro prq_edmuro") && s(-2,-1) )
 { ret=stopp=1; D[450]++; if(dbg){print "D450"}; continue };
 if ((qi_duom(-3)||wc(-3,"[234][^0-9]*$")) &&
          qxs(-1,"с","половиной четвертью небольшим") && s(-3,-1) )
 { ret=stopp=1; D[451]++; if(dbg){print "D451"}; continue };
 if ( w(1,"за по на") &&
         (qi_duom(2)||wc(2,"[234][^0-9]*$")) && s(0,1) )
 { ret=stopp=1; D[452]++; if(dbg){print "D452"}; continue };
 if ( (qi_duom(-1)||wc(-1,"[234][^0-9]*$")) && s(-1) )
 { ret=stopp=1; D[453]++; if(dbg){print "D453"}; continue };
 if ( (qi_duom(1)||wc(1,"[234][^0-9]*$")) && s(0) )
 { ret=stopp=1; D[454]++; if(dbg){print "D454"}; continue };

break}; return ret }

function sw_msz_z_f(ret, stopp) { while ( !stopp ) {
 #
 if ( fba(-6,-1,"h_gl_4_part") && Q(fbn+1,"gl_in") && s(fbn,-1) )
 { ret=stopp=1; D[455]++; if(dbg){print "D455"}; continue };
 if ( ffa(1,6,"h_gl_4_part") && s(0,ffn-1) )
 { ret=stopp=1; D[456]++; if(dbg){print "D456"}; continue };

 if ( suw_any(-2) && ba(-2,"_unit") &&
            q(-1,"prl_edro prq_edro mest_ro") && s(-2,-1) )
 { ret=stopp=1; stopp=1; D[457]++; if(dbg){print "D457"}; continue };
 if ( suw_any(-1) && ba(-1,"_unit") && s(-1) && Q(-1,"prl_any") )
 { ret=stopp=1; D[458]++; if(dbg){print "D458"}; continue };

 if ( pre_vi(-7) &&
           q(-6,"suw_vi") &&
           q(-5,"mod_bz") &&
          fa(-4,"h_gl_4_part") &&
     ipa_any(-3) && z(-3) &&
          qq(-7,-2) && se(-1," — ") && s(-7,-4) )
 { ret=stopp=1; D[459]++; if(dbg){print "D459"}; continue };

 if ( q(1,"mest_da suw_da") && s(0,1) && p(-1) &&
      q(2,"prl_kred_sr nar_spos nar_kaq narph_any") )
 { ret=stopp=1; D[460]++; if(dbg){print "D460"}; continue };
 if ( q(1,"mest_da suw_da") && s(0) && p(-1) && p(1) )
 { ret=stopp=1; D[461]++; if(dbg){print "D461"}; continue };
 if ( ipa_any(-2) &&
            q(-1,"mest_da suw_da") && s(-2) && p(-3) && p(-1) && p(0) )
 { ret=stopp=1; D[462]++; if(dbg){print "D462"}; continue };

 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe") &&
      q(-1,"suw_tv suw_da mest_da mest_tv") && suw_mnim(0) && s(-2,-1) )
 { ret=stopp=1; D[463]++; if(dbg){print "D463"}; continue };
 if ( q(-1,"suw_edtv") && s(-1) && W(0,"холода") )
 { ret=stopp=1; D[464]++; if(dbg){print "D464"}; continue };

break}; return ret }

function sw_em_z_f(ret, stopp) {
    while ( !stopp ) {

 if ( q(-1,"prl_edzevi mest_edzevi prq_edzevi") && s(-1) )
 { ret=0; stopp=1; D[465]++; if(dbg){print "D465", "sw_msz_z_f escape"}; continue };

 cst="немного немножечко с чуть-чуть";
 if ( (w(-2,cst)||q(-2,"suw_edtv gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn")) &&
       q(-1,"prl_edmuro prq_edmuro mest_edmuro") && s(-2,-1) )
 { ret=stopp=1; D[466]++; if(dbg){print "D466"}; continue };
 if ( q(-2,"gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn") &&
     (w(-1,cst)||q(-1,"suw_edtv prl_edmuro prq_edmuro mest_edmuro")) && s(-2,-1) )
 { ret=stopp=1; D[467]++; if(dbg){print "D467"}; continue };
 if ( (w(-1,cst)||q(-1,"prl_edmuro prq_edmuro mest_edmuro")) && s(-1) )
 { ret=stopp=1; D[468]++; if(dbg){print "D468"}; continue };

 if ( sw_msz_z_f() )
 { ret=stopp=1; D[469]++; if(dbg){print "D469", "sw_msz_z_f"}; continue };

 break}; return ret }

function sw_es_z_f(ret, stopp) {
    while ( !stopp ) {

 cst="немного немножечко с чуть-чуть";
 if ( (w(-2,cst)||q(-2,"suw_edtv gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn")) &&
       q(-1,"prl_edsrro prq_edsrro mest_edsrro") && s(-2,-1) )
 { ret=stopp=1; D[470]++; if(dbg){print "D470"}; continue };
 if ( q(-2,"gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn") &&
     (w(-1,cst)||q(-1,"suw_edtv prl_edsrro prq_edsrro mest_edsrro")) && s(-2,-1) )
 { ret=stopp=1; D[471]++; if(dbg){print "D471"}; continue };
 if ( (w(-1,cst)||q(-1,"suw_edtv prl_edsrro prq_edsrro mest_edsrro")) && s(-1) )
 { ret=stopp=1; D[472]++; if(dbg){print "D472"}; continue };

 if ( sw_msz_z_f() )
 { ret=stopp=1; D[473]++; if(dbg){print "D473", "sw_msz_z_f"}; continue };

 break}; return ret }

function sw_ez_z_f(ret, stopp) {
    while ( !stopp ) {
 if ( sw_msz_z_f() )
 { ret=stopp=1; D[474]++; if(dbg){print "D474", "sw_msz_z_f"}; continue };

 cst="немного немножечко с чуть-чуть";
 if ( (w(-2,cst)||q(-2,"suw_edtv gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn")) &&
       q(-1,"prl_edzero prq_edzero mest_edzero") && s(-2,-1) )
 { ret=stopp=1; D[475]++; if(dbg){print "D475"}; continue };
 if ( q(-2,"gl_in gl_ed gl_nemn gl_vzmn gl_pnmn gl_pemn") &&
     (w(-1,cst)||q(-1,"suw_edtv prl_edzero prq_edzero mest_edzero")) && s(-2,-1) )
 { ret=stopp=1; D[476]++; if(dbg){print "D476"}; continue };
 if ( (w(-1,cst)||q(-1,"suw_edtv prl_edzero mest_edzero")) && s(-1) && W(-1,"ее") )
 { ret=stopp=1; D[477]++; if(dbg){print "D477"}; continue };

break}; return ret }

function sw_es_i_f(ret, stopp) { while ( !stopp ) {
 if ( sw_im_f() )
 { ret=stopp=1; D[478]++; if(dbg){print "D478", "sw_im_f"}; continue };

 if ( q(1,"prl_kred_sr prq_kred_sr") && s(0) && p(1) &&
  !(qw_(-1,"suw_edsrim")||p(-1)) )
 { ret=stopp=1; D[479]++; if(dbg){print "D479"}; continue };

 if ( q(-3,"mest_it") &&
      w(-2,"всего") &&
      w(-1,"лишь только") && s(-3,-1) )
 { ret=stopp=1; D[480]++; if(dbg){print "D480"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"же ж лишь только") && s(-2,-1) )
 { ret=stopp=1; D[481]++; if(dbg){print "D481"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"не") && s(-2,-1) )
 { ret=stopp=1; D[482]++; if(dbg){print "D482"}; continue };
 if ( q(-1,"mest_it") && s(-1) )
 { ret=stopp=1; D[483]++; if(dbg){print "D483"}; continue };
 if ( q(-3,"gl_edsr") &&
      q(-2,"qast") &&
      q(-1,"qast") && s(-3,-1) )
 { ret=stopp=1; D[484]++; if(dbg){print "D484"}; continue };
 if ( q(-2,"gl_edsr") &&
      q(-1,"qast") && s(-2,-1) )
 { ret=stopp=1; D[485]++; if(dbg){print "D485"}; continue };
 if ( q(-1,"gl_edsr") && s(-1) )
 { ret=stopp=1; D[486]++; if(dbg){print "D486"}; continue };
 if ( q(1,"gl_edsr") && s(0) && Qw_(-1,"pre_any") )
 { ret=stopp=1; D[487]++; if(dbg){print "D487"}; continue };

 if ( w(-2,"и не") &&
      q(-1,"mest_im") && s(-2,-1) )
 { ret=stopp=1; D[488]++; if(dbg){print "D488"}; continue };

 #_#_#
 if ( q(-2,"pre_im") &&
      q(-1,"prl_edsrim prq_edsrim mest_edim muk_edsrim") && s(-2,-1) )
 { ret=stopp=1; D[489]++; if(dbg){print "D489"}; continue };

 if (prex == 1) { pre_string = "prex_im" } else { pre_string ="pre_im" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[490]++; if(dbg){print "D490"}; continue };
 if ( q(-2,pre_string) &&
      q(-1,"prl_im") && s(-2,-1) )
 { ret=stopp=1; D[491]++; if(dbg){print "D491"}; continue };
 if ( q(-2,pre_string) && sc(-1,"-") && s(-1) )
 { ret=stopp=1; D[492]++; if(dbg){print "D492"}; continue };
 #_#_#

 if ( q(-1,"prl_edsrim prq_edsrim mest_edim muk_edsrim") && s(-1) )
 { ret=stopp=1; D[493]++; if(dbg){print "D493"}; continue };
break}; return ret }

function sw_es_v_f(ret, stopp) { while ( !stopp ) {
 if ( sw_vi_f() )
 { ret=stopp=1; D[494]++; if(dbg){print "D494", "sw_vi_f"}; continue };

 #_#_#
 if ( q(-3,"pre_vi preph_vi") &&
      q(-2,"prl_edsrvi prq_edsrvi mest_edmuvi") &&
      q(-1,"prl_edsrvi prq_edsrvi mest_edmuvi") && s(-3,-1) )
 { ret=stopp=1; D[495]++; if(dbg){print "D495"}; continue };
 if ( q(-2,"pre_vi preph_vi") &&
      q(-1,"prl_edsrvi prq_edsrvi") && s(-2,-1) )
 { ret=stopp=1; D[496]++; if(dbg){print "D496"}; continue };

 if (prex == 1) { pre_string = "prex_vi preph_vi" } else { pre_string = "pre_vi preph_vi" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[497]++; if(dbg){print "D497"}; continue };
 #_#_#

 if ( q(-1,"preph_vi prl_edsrvi prq_edsrvi") && s(-1) )
 { ret=stopp=1; D[498]++; if(dbg){print "D498"}; continue };
break}; return ret }

function sw_es_r_f(ret, stopp) { while ( !stopp ) {
 #
 if ((q(-4,"qi_duom")||wc(-4,"[234][^0-9]*$")) &&
      q(-3,"prl_mnro prq_mnro mest_mnro") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-4,-1) )
 { ret=stopp=1; D[499]++; if(dbg){print "D499"}; continue };
 if ( (w(-2,"нет")||q(-2,"pre_ro qi_duom")||wc(-2,"[234][^0-9]*$")) &&
       q(-1,"prl_mnro prq_mnro mest_mnro") && s(-2,-1) && W(-1,"него нее них") )
 { ret=stopp=1; D[500]++; if(dbg){print "D500"}; continue };
 if ( (w(-1,"нет")||qi_duom(-1)||wc(-1,"[234][^0-9]*$")) && s(-1) )
 { ret=stopp=1; D[501]++; if(dbg){print "D501"}; continue };
 if ( w(-3,"не") &&
      q(-2,"gl_ed gl_in gl_poed") &&
      q(-1,"prl_edsrro prq_edsrro mest_ro") && s(-3,-1) )
 { ret=stopp=1; D[502]++; if(dbg){print "D502"}; continue };
 if ( w(-3,"какого") &&
   qast(-2) &&
      q(-1,"mest_im suw_im") && s(-3,-1) )
 { ret=stopp=1; D[503]++; if(dbg){print "D503"}; continue };
 if ( w(-2,"какого") &&
      q(-1,"mest_im suw_im") && s(-2,-1) )
 { ret=stopp=1; D[504]++; if(dbg){print "D504"}; continue };
 if ( q(1,"prl_edsrro prl_mnro") && s(0) && p(-1) && p(1) && Q(1,"suw_ro") )
 { ret=stopp=1; D[505]++; if(dbg){print "D505"}; continue };
 if ( q(-2,"prl_edsrro prl_mnro") &&
      q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[506]++; if(dbg){print "D506"}; continue };

 if ( q(-3,"prq_edsrro") &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-3,-1) )
 { ret=stopp=1; D[507]++; if(dbg){print "D507"}; continue };

 if ( sw_edro_f() )
 { ret=stopp=1; D[508]++; if(dbg){print "D508", "sw_edro_f"}; continue };
 if ( sw_ro_f() )
 { ret=stopp=1; D[509]++; if(dbg){print "D509", "sw_ro_f"}; continue };
 if ( edro2mnvi )
 { ret=0; stopp=1; D[510]++; if(dbg){print "D510"}; continue };

 #_#_#
 if ( q(-3,"pre_ro preph_ro") &&
     (q(-2,"prl_edsrro prq_edsrro mest_edsrro")||wc(-2,"[ео]го$ [ео]ва$")) &&
     (q(-1,"prl_edsrro prq_edsrro mest_edsrro")||wc(-1,"[ео]го$ [ео]ва$")) && s(-3,-1) )
 { ret=stopp=1; D[511]++; if(dbg){print "D511"}; continue };
 if ( q(-2,"pre_ro preph_ro") &&
     (q(-1,"prl_edsrro prq_edsrro mest_edsrro")||wc(-1,"[ео]го$ [ео]ва$")) && W(-1,"него нее них") && s(-2,-1) )
 { ret=stopp=1; D[512]++; if(dbg){print "D512"}; continue };
 if ( q(-4,"pre_ro preph_ro") &&
     (q(-3,"prl_edsrro prq_edsrro mest_edsrro")||wc(-3,"[ео]го$ [ео]ва$")) &&
     (q(-2,"prl_edsrro prq_edsrro mest_edsrro")||wc(-2,"[ео]го$ [ео]ва$")) && s(-4,-2) && sc(-1,"-") )
 { ret=stopp=1; D[513]++; if(dbg){print "D513"}; continue };
 if ( q(-3,"pre_ro preph_ro") &&
     (q(-2,"prl_edsrro prq_edsrro mest_edsrro")||wc(-2,"[ео]го$ [ео]ва$")) && W(-2,"него нее них") && s(-3,-2) && sc(-1,"-") )
 { ret=stopp=1; D[514]++; if(dbg){print "D514"}; continue };

 if (prex == 1) { pre_string = "prex_ro preph_ro" } else { pre_string = "pre_ro preph_ro" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[515]++; if(dbg){print "D515"}; continue };
 if ( q(-2,pre_string) && s(-2) && sc(-1,"-") )
 { ret=stopp=1; D[516]++; if(dbg){print "D516"}; continue };
 #_#_#

 if ( q(-2,"preph_ro prl_edsrro prq_edsrro mest_edsrro muk_edsrro") &&
      w(-1,"его ее их же") && s(-2,-1) )
 { ret=stopp=1; D[517]++; if(dbg){print "D517"}; continue };
 if ( (q(-1,"prl_edsrro prq_edsrro mest_edsrro")||wc(-1,"[ео]го$ [ео]ва$")||wc(-1,"^[0-9]+$")) && W(-1,"его него чем") && s(-1) )
 { ret=stopp=1; D[518]++; if(dbg){print "D518"}; continue };

break}; return ret }

function sw_es_d_f(ret, stopp) { while ( !stopp ) {
 if ( sw_da_f() )
 { ret=stopp=1; D[519]++; if(dbg){print "D519", "sw_da_f"}; continue };
 #
 if ( q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_obj_da") && s(-1) )
 { ret=stopp=1; D[520]++; if(dbg){print "D520"}; continue };
 if ( q(-1,"gl_pein gl_peed gl_pemn deep_pe") && ba(-1,"_gl_obj_da") && s(-1) )
 { ret=stopp=1; D[521]++; if(dbg){print "D521"}; continue };
 #_#_#
 if ( q(-3,"pre_da preph_da") &&
      q(-2,"prl_edsrda prq_edsrda mest_edmuda") &&
      q(-1,"prl_edsrda prq_edsrda mest_edmuda") && s(-3,-1) )
 { ret=stopp=1; D[522]++; if(dbg){print "D522"}; continue };
 if ( q(-2,"pre_da preph_da") &&
      q(-1,"prl_edsrda prq_edsrda") && s(-2,-1) )
 { ret=stopp=1; D[523]++; if(dbg){print "D523"}; continue };

 if (prex == 1) { pre_string = "prex_da preph_da" } else { pre_string = "pre_da preph_da" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[524]++; if(dbg){print "D524"}; continue };
 #_#_#

 if ( q(-1,"preph_da prl_edsrda prq_edsrda") && s(-1) )
 { ret=stopp=1; D[525]++; if(dbg){print "D525"}; continue };
break}; return ret }

function sw_es_t_f(ret, stopp) { while ( !stopp ) {
 if ( sw_tv_f() )
 { ret=stopp=1; D[526]++; if(dbg){print "D526", "sw_tv_f"}; continue };
 #_#_#
 if ( q(-3,"pre_tv preph_tv") &&
      q(-2,"prl_edsrtv prq_edsrtv mest_edmutv") &&
      q(-1,"prl_edsrtv prq_edsrtv mest_edmutv") && s(-3,-1) )
 { ret=stopp=1; D[527]++; if(dbg){print "D527"}; continue };
 if ( q(-2,"pre_tv preph_tv") &&
      q(-1,"prl_edsrtv prq_edsrtv") && s(-2,-1) )
 { ret=stopp=1; D[528]++; if(dbg){print "D528"}; continue };

 if (prex == 1) { pre_string = "prex_tv preph_tv" } else { pre_string = "pre_tv preph_tv" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[529]++; if(dbg){print "D529"}; continue };
 #_#_#

 if ( q(-1,"preph_tv prl_edsrtv prq_edsrtv") && s(-1) )
 { ret=stopp=1; D[530]++; if(dbg){print "D530"}; continue };
break}; return ret }

function sw_es_p_f(ret, stopp) { while ( !stopp ) {
 #
 #_#_#
  if ( q(-3,"pre_pr") &&
       q(-2,"prl_edsrpr prq_edsrpr mest_edsrpr") &&
       q(-1,"prl_edsrpr prq_edsrpr mest_edsrpr") && s(-3,-1) )
 { ret=stopp=1; D[531]++; if(dbg){print "D531"}; continue };
 if ( q(-2,"pre_pr") &&
      q(-1,"prl_edsrpr prq_edsrpr mest_edsrpr") && s(-2,-1) )
 { ret=stopp=1; D[532]++; if(dbg){print "D532"}; continue };

if (prex == 1) { pre_string = "prex_pr" } else { pre_string ="pre_pr" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[533]++; if(dbg){print "D533"}; continue };
 #_#_#

break}; return ret }

function sw_ez_i_f(ret, stopp) { while ( !stopp ) {
 if ( sw_im_f() )
 { ret=stopp=1; D[534]++; if(dbg){print "D534", "sw_im_f"}; continue };

 if ( q(1,"prl_kred_ze prq_kred_ze") && s(0) )
 { ret=stopp=1; D[535]++; if(dbg){print "D535"}; continue };

 if ( qf(1,5,"gl_paedze") && s(0,qfn-1) )
 { ret=stopp=1; D[536]++; if(dbg){print "D536"}; continue };
 if ( w(-1,"она") && gl_paedze(0) && s(0) )
 { ret=0; stopp=1; D[537]++; if(dbg){print "D537"}; continue };
 if ( q(-2,"mest_ro suw_ro") &&
      q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_obj_ro") && s(-2,-1) )
 { ret=stopp=1; D[538]++; if(dbg){print "D538"}; continue };
 if ( q(-1,"mest_ro suw_ro") &&
      q(1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(1,"_gl_obj_ro") && s(-1,0) )
 { ret=stopp=1; D[539]++; if(dbg){print "D539"}; continue };

 if ( q(-3,"mest_it") &&
      w(-2,"всего") &&
      w(-1,"лишь только") && s(-3,-1) )
 { ret=stopp=1; D[540]++; if(dbg){print "D540"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"же ж лишь только") && s(-2,-1) )
 { ret=stopp=1; D[541]++; if(dbg){print "D541"}; continue };
 if ( q(-2,"mest_it") &&
      w(-1,"не") && s(-2,-1) )
 { ret=stopp=1; D[542]++; if(dbg){print "D542"}; continue };
 if ( q(-1,"mest_it") && s(-1) )
 { ret=stopp=1; D[543]++; if(dbg){print "D543"}; continue };

 if ( w(-2,"и не") &&
      q(-1,"mest_im") && s(-2,-1) )
 { ret=stopp=1; D[544]++; if(dbg){print "D544"}; continue };

 if ( q(-3,"sz mest_it") &&
      w(-2,"не") &&
      q(-1,"mest_im") && s(-3,-1) )
 { ret=stopp=1; D[545]++; if(dbg){print "D545"}; continue };

 #_#_#
 if ( q(-3,"pre_im") &&
      q(-2,"prl_edzeim prq_edzeim mest_edzeim") &&
      q(-1,"prl_edzeim prq_edzeim mest_edzeim") && s(-3,-1) )
 { ret=stopp=1; D[546]++; if(dbg){print "D546"}; continue };
 if ( q(-2,"pre_im") &&
      q(-1,"prl_edzeim prq_edzeim mest_edzeim") && s(-2,-1) )
 { ret=stopp=1; D[547]++; if(dbg){print "D547"}; continue };
 if (prex == 1) { pre_string = "prex_im" } else { pre_string ="pre_im" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[548]++; if(dbg){print "D548"}; continue };
 #_#_#

 if ( q(-1,"prl_edzeim prq_edzeim mest_edzeim") && s(-1) )
 { ret=stopp=1; D[549]++; if(dbg){print "D549"}; continue };
 if ( qf(1,5,"gl_in gl_ed gl_mn deep") &&
       w(qfn-1,"не") && s(0,qfn-1) && ba(qfn,"_gl_learn") )
 { ret=stopp=1; D[550]++; if(dbg){print "D550"}; continue };

break}; return ret }

function sw_ez_v_f(ret, stopp) { while ( !stopp ) {
 if ( sw_vi_f() )
 { ret=stopp=1; D[551]++; if(dbg){print "D551", "sw_vi_f"}; continue };

 #_#_#
 if ( q(-3,"pre_vi preph_vi") &&
     (q(-2,"prl_edzevi prq_edzevi mest_edzevi")||wc(-2,"ую$")) &&
     (q(-1,"prl_edzevi prq_edzevi mest_edzevi")||wc(-1,"ую$")) && s(-3,-1) )
 { ret=stopp=1; D[552]++; if(dbg){print "D552"}; continue };
 if ( q(-2,"pre_vi preph_vi") &&
     (q(-1,"prl_edzevi prq_edzevi mest_edzevi")||wc(-1,"ую$")) && s(-2,-1) )
 { ret=stopp=1; D[553]++; if(dbg){print "D553"}; continue };

 if (prex == 1) { pre_string = "prex_vi preph_vi" } else { pre_string = "pre_vi preph_vi" };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[554]++; if(dbg){print "D554"}; continue };
 #_#_#

 if ( (q(-2,"prl_edzevi prq_edzevi mest_edzevi")||wc(-1,"ую$")) &&
       q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[555]++; if(dbg){print "D555"}; continue };
 if ( (q(-2,"prl_edzevi prq_edzevi mest_edzevi")||wc(-1,"ую$")) &&
       q(-1,"mest_tv suw_tv") && s(-2,-1) )
 { ret=stopp=1; D[556]++; if(dbg){print "D556"}; continue };
 if ( (q(-2,"preph_vi prl_edzevi prq_edzevi mest_edzevi muk_edzevi")||wc(-1,"ую$")) &&
    qast(-1) && s(-2,-1) )
 { ret=stopp=1; D[557]++; if(dbg){print "D557"}; continue };
 if ( (q(-1,"preph_vi prl_edzevi prq_edzevi mest_edzevi muk_edzevi")||wc(-1,"ую$")) && s(-1) )
 { ret=stopp=1; D[558]++; if(dbg){print "D558"}; continue };
break}; return ret }

function sw_ez_d_f(ret, stopp) { while ( !stopp ) {
 if ( loc2ezd==1 )
 { ret=stopp=1; D[559]++; if(dbg){print "D559", "sw_da_f"}; continue };

 if ( sw_da_f() )
 { ret=stopp=1; D[560]++; if(dbg){print "D560", "sw_da_f"}; continue };
 if ( muk_edzeda(-2) &&
               w(-1,"же лишь только") && s(-2,-1) )
 { ret=stopp=1; D[561]++; if(dbg){print "D561"}; continue };
 if ( muk_edzeda(-1) && s(-1) )
 { ret=stopp=1; D[562]++; if(dbg){print "D562"}; continue };

 #_#_#
 if (prex == 1) { pre_string = "prex_da preph_da" } else { pre_string = "pre_da preph_da" };
 if ( q(-3,pre_string) &&
      q(-2,"prl_edzeda prq_edzeda mest_edzeda muk_edzeda") &&
      q(-1,"prl_edzeda prq_edzeda mest_edzeda") && s(-3,-1) )
 { ret=stopp=1; D[563]++; if(dbg){print "D563"}; continue };
 if ( q(-2,pre_string) &&
      q(-1,"prl_edzeda prq_edzeda mest_da muk_edzeda") && s(-2,-1) )
 { ret=stopp=1; D[564]++; if(dbg){print "D564"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[565]++; if(dbg){print "D565"}; continue };
 #_#_#

 if ( q(-1,"preph_da prl_edzeda prq_edzeda mest_da muk_edzeda") && s(-1) && Q(0,"gl_in") )
 { ret=stopp=1; D[566]++; if(dbg){print "D566"}; continue };
break}; return ret }

function sw_em_l_f(ret, stopp) { while ( !stopp ) {
 if ( W(0,"берегу бреду гною хмелю") && q(0,"suw_edmuda") &&
 !( (wb(-5,-1,"в во на") && !(sq(wbn,-1,"[….:;!?]"))) || (wf(1,3,"в во на") && !(sq(0,wfn-1,"[….:;!?]")))) )
 { ret=0; stopp=1; loc2emd=1; D[567]++; if(dbg){print "D567"}; continue };
#if ( id (-1,"hsw4loc") && s(-1) )
#{ ret=stopp=1; D[568]++; if(dbg){print "D568"}; continue };

 #
 if ( pre_pr(-3) &&
    prq_edpr(-2) &&
           q(-1,"suw_tv") && s(-3,-1) )
 { ret=stopp=1; D[569]++; if(dbg){print "D569"}; continue };
 #
 if ( w(-4,"в") && s(-3) && s(-4,-3) &&
      q(-3,"prl_edmupr prq_edmupr mest_edmupr mest_3e") &&
      q(-2,"prl_edmupr prq_edmupr mest_edmupr mest_3e") && (z(-2)||s(-2)) &&
     wc(-1,"^[0-9]+$") && s(-1) )
 { ret=stopp=1; D[570]++; if(dbg){print "D570"}; continue };
 if ( w(-3,"в") && s(-3) &&
      q(-2,"prl_edmupr prq_edmupr mest_edmupr mest_3e") && (z(-2)||s(-2)) &&
     wc(-1,"^[0-9]+$") && s(-1) )
 { ret=stopp=1; D[571]++; if(dbg){print "D571"}; continue };
 #
 if ( w(-3,"в во на") &&
     (q(-2,"prl_edmupr prq_edmupr mest_edmupr mest_3e")||wc(-2,"^[0-9]+$")) &&
     (q(-1,"prl_edmupr prq_edmupr mest_edmupr mest_3e")||wc(-1,"^[0-9]+$")) && s(-3,-1) )
 { ret=stopp=1; D[572]++; if(dbg){print "D572"}; continue };
 if ( w(-2,"в во на") &&
     (q(-1,"prl_edmupr prq_edmupr mest_edmupr mest_3e")||wc(-1,"^[0-9]+$")) && s(-2,-1) )
 { ret=stopp=1; D[573]++; if(dbg){print "D573"}; continue };
 #
 if ( w(-1,"в во на") && s(-1) )
 { ret=stopp=1; D[574]++; if(dbg){print "D574"}; continue };
 if ( w(-4,"в во на") && s(-4) &&
     (q(-3,"prl_edmupr prq_edmupr mest_pr mest_vi mest_3e")||wc(-3,"^[0-9]+$")) && z(-3) &&
      q(-2,"nar_step") &&
      q(-1,"prl_edmupr prq_edmupr") && s(-2,-1) )
 { ret=stopp=1; D[575]++; if(dbg){print "D575"}; continue };

 if ( wb(-7,-2,"в во на") &&
       q(-1,"prl_edmupr prq_edmupr mest_pedmupr") && s(wbn,-1) )
 { ret=stopp=1; D[576]++; if(dbg){print "D576"}; continue };
break}; return ret }

function sw_ez_l_f(ret, stopp) { while ( !stopp ) {
 if ( W(0,"кости крови мели пыли шерсти") && q(0,"suw_edzeda") &&
 !( (wb(-5,-1,"в во на") && !(sq(wbn,-1,"[….:;!?]"))) || (wf(1,3,"в во на") && !(sq(0,wfn-1,"[….:;!?]")))) )
 { ret=0; stopp=1; loc2emd=1; D[577]++; if(dbg){print "D577"}; continue };
 if ( bam(-2,"_gl_no_locative _gl_dvizh _gl_make") &&
        w(-1,"в во на") && s(-2,-1) )
 { ret=0; stopp=1; D[578]++; if(dbg){print "D578"}; continue };
 if ( ba(-2,"_gl_learn") &&
       w(-1,"на") && s(-2,-1) )
 { ret=0; stopp=1; D[579]++; if(dbg){print "D579"}; continue };
 #
 if ( !(ba(-4,"_gl_no_locative") && s(-4) ) &&
    pre_pr(-3) &&
  prq_edpr(-2) &&
         q(-1,"suw_tv") && s(-3,-1) )
 { ret=stopp=1; D[580]++; if(dbg){print "D580"}; continue };
##
#if ( ba(-4,"_gl_v_loc") &&
#     w(-3,"в во на") &&
#     q(-2,"prl_edzepr prq_edzepr mest_pr mest_vi") &&
#     q(-1,"prl_edzepr prq_edzepr mest_pr mest_vi") && s(-4,-1) )
#{ ret=stopp=1; D[581]++; if(dbg){print "D581"}; continue };
#if ( ba(-3,"_gl_v_loc") &&
#      w(-2,"в во на") &&
#     q(-1,"prl_edzepr prq_edzepr mest_pr") && s(-3,-1) )
#{ ret=stopp=1; D[582]++; if(dbg){print "D582"}; continue };
##
#if ( ba(-3,"_gl_v_loc") &&
#     q(-2,"mest_any nar_any suw_any") &&
#       w(-1,"в во на") && s(-3,-1) )
#{ ret=stopp=1; D[583]++; if(dbg){print "D583"}; continue };
#if ( ba(-2,"_gl_v_loc") &&
#       w(-1,"в во на") && s(-2,-1) )
#{ ret=stopp=1; D[584]++; if(dbg){print "D584"}; continue };
 #
 if ( w(-3,"в во на") &&
      q(-2,"prl_edzepr prq_edzepr mest_pr mest_vi") &&
      q(-1,"prl_edzepr prq_edzepr mest_pr mest_vi") && s(-3,-1) )
 { ret=stopp=1; D[585]++; if(dbg){print "D585"}; continue };
 if ( w(-2,"в во на") &&
      q(-1,"prl_edzepr prq_edzepr mest_pr") && s(-2,-1) )
 { ret=stopp=1; D[586]++; if(dbg){print "D586"}; continue };
 #
 if (  w(-1,"в во на") && s(-1) )
 { ret=stopp=1; D[587]++; if(dbg){print "D587"}; continue };
break}; return ret }

function sw_ez_r_f(ret, stopp) { while ( !stopp ) {
 #
 if ( (w(-2,"нет")||qi_duoz(-2)||wc(-2,"[234][^0-9]*$")) &&
       q(-1,"prl_edzero prq_edzero mest_ro muk_edzero") && W(-1,"него нее них") && s(-2,-1) )
 { ret=stopp=1; D[588]++; if(dbg){print "D588"}; continue };
 if ((qi_duoz(-2)||wc(-2,"[234][^0-9]*$")) &&
            q(-1,"prl_mnim prq_mnim mest_mnim") && s(-2,-1) && se(-2," ") )
 { ret=stopp=1; D[589]++; if(dbg){print "D589"}; continue };
 if ( q(-2,"gl_in gl_ed gl_mn gl_poed gl_pomn gl_povzmn deep") && ba(-2,"_gl_obj_ro") &&
      q(-1,"prl_edzero prq_edzero") && s(-2,-1) )
 { ret=stopp=1; D[590]++; if(dbg){print "D590"}; continue };
 #
 if ( (w(-2,"нет")||wc(-1,"[234][^0-9]*$")) &&
       w(-1,"даже ли ведь же ж") && s(-2,-1) )
 { ret=stopp=1; D[591]++; if(dbg){print "D591"}; continue };
 if ( (w(-1,"нет")||qi_duoz(-1)||wc(-1,"[234][^0-9]*$")) && s(-1) )
 { ret=stopp=1; D[592]++; if(dbg){print "D592"}; continue };
 if ( muk_edzero(-2) &&
               w(-1,"же лишь только") && s(-2,-1) )
 { ret=stopp=1; D[593]++; if(dbg){print "D593"}; continue };
 if ( muk_edzero(-1) && s(-1) )
 { ret=stopp=1; D[594]++; if(dbg){print "D594"}; continue };
 if ( w(-3,"какой") &&
   qast(-2) &&
      q(-1,"mest_im suw_im") && s(-3,-1) )
 { ret=stopp=1; D[595]++; if(dbg){print "D595"}; continue };
 if ( w(-2,"какой") &&
      q(-1,"mest_im suw_im qast") && s(-2,-1) )
 { ret=stopp=1; D[596]++; if(dbg){print "D596"}; continue };

 if ( q(1,"prl_edzero prl_mnro") && s(0) && p(-1) && p(1) && Q(1,"suw_ro") )
 { ret=stopp=1; D[597]++; if(dbg){print "D597"}; continue };
 if ( q(-3,"pre_ro preph_ro") && Qw_(-4,"prq_mnim") &&
      q(-2,"prl_edzero prl_mnro") &&
      q(-1,"mest_da suw_da") && s(-3,-1) )
 { ret=stopp=1; D[598]++; if(dbg){print "D598"}; continue };
 if ( q(-4,"pre_ro preph_ro") && Qw_(-5,"prq_mnim") &&
      q(-3,"prl_edzero prl_mnro") &&
      q(-2,"mest_da suw_da") &&
      q(-1,"suw_da") && s(-4,-1) )
 { ret=stopp=1; D[599]++; if(dbg){print "D599"}; continue };

 if ( sw_edro_f() )
 { ret=stopp=1; D[600]++; if(dbg){print "D600", "sw_edro_f"}; continue };
 if ( sw_ro_f() )
 { ret=stopp=1; D[601]++; if(dbg){print "D601", "sw_ro_f"}; continue };
 if ( edro2mnvi )
 { ret=0; stopp=1; D[602]++; if(dbg){print "D602"}; continue };

 #_#_#
 if (prex == 1) { pre_string = "prex_ro preph_ro" } else { pre_string = "pre_ro preph_ro" };
 if ( q(-3,pre_string) &&
     (q(-2,"prl_edzero prq_edzero mest_edzero muk_edzero")||wc(-2,"[ео]й$ [ео]йся$")) &&
     (q(-1,"prl_edzero prq_edzero")||wc(-1,"[ео]й$ [ео]йся$")) && s(-3,-1) )
 { ret=stopp=1; D[603]++; if(dbg){print "D603"}; continue };
 if ( q(-2,pre_string)  )
 { ret=stopp=1; D[604]++; if(dbg){print "D604"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[605]++; if(dbg){print "D605"}; continue };
 if ( q(-3,pre_string) &&
      q(-2,"suw_ro") &&
sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[606]++; if(dbg){print "D606"}; continue };
 if ( q(-2,pre_string) && sc(-1,"-") && s(-2) )
 { ret=stopp=1; D[607]++; if(dbg){print "D607"}; continue };
 #_#_#

 if ( (q(-2,"preph_ro prl_edzero prq_edzero mest_edzero muk_edzero")||wc(-2,"ской$ [ео]вой$")) &&
       w(-1,"его ее их же") && s(-2,-1) )
 { ret=stopp=1; D[608]++; if(dbg){print "D608"}; continue };
 if ( (q(-1,"preph_ro prl_edzero mest_edzero muk_edzero")||wc(-1,"ской$ [ео]вой$")) && W(-1,"нее ее") && s(-1) )
 { ret=stopp=1; D[609]++; if(dbg){print "D609"}; continue };
 if ( q(-1,"prq_edzero") && sv(-2,",") && s(-1) )
 { ret=stopp=1; D[610]++; if(dbg){print "D610"}; continue };

 if ( Qw_(-3,"pre_ro") &&
       (q(-2,"prl_edzero prq_edzero mest_edzero muk_edzero")||wc(-2,"[ео]й$ [ео]йся$")) &&
       (q(-1,"prl_edzero prq_edzero mest_edzero")||wc(-1,"[ео]й$ [ео]йся$")) && s(-2,-1) )
 { ret=stopp=1; D[611]++; if(dbg){print "D611"}; continue };
 if ( (p(-1)||(q(-1,"prl_edro prq_edro") && s(-1) )) && z(0) &&
       q(1,"prl_edzeim prl_edzevi prq_edzeim prq_edzevi") )
 { ret=stopp=1; D[612]++; if(dbg){print "D612"}; continue };
 if ( q(-5,"pre_ro preph_ro") &&
     (q(-4,"prl_edzero prq_edzero mest_edzero muk_edzero")||wc(-4,"[ео]й$ [ео]йся$")) &&
     (q(-3,"prl_edzero prq_edzero mest_edzero")||wc(-3,"[ео]й$ [ео]йся$")) &&
 pre_vi(-2) &&
      q(-1,"suw_vi") && s(-5,-1) )
 { ret=stopp=1; D[613]++; if(dbg){print "D613"}; continue };

break}; return ret }

function sw_ez_t_f(ret, stopp) { while ( !stopp ) {
 if ( sw_tv_f() )
 { ret=stopp=1; D[614]++; if(dbg){print "D614", "sw_tv_f"}; continue };

 #_#_#
 if (prex == 1) { pre_string = "prex_tv preph_tv" } else { pre_string ="pre_tv preph_tv" };
 if ( q(-3,pre_string) &&
      q(-2,"prl_edzetv prq_edzetv mest_edzetv") &&
      q(-1,"prl_edzetv prq_edzetv mest_edzetv") && s(-3,-1) )
 { ret=stopp=1; D[615]++; if(dbg){print "D615"}; continue };
 if ( q(-2,pre_string) &&
      q(-1,"prl_edzetv prq_edzetv mest_tv") && s(-2,-1) )
 { ret=stopp=1; D[616]++; if(dbg){print "D616"}; continue };
 if ( q(-1,pre_string) && s(-1) && W(0,"какой") && Q_w(1,"suw_edzero suw_edzeda suw_edzepr") )
 { ret=stopp=1; D[617]++; if(dbg){print "D617"}; continue };
 #_#_#

 if ( q(-1,"preph_tv prl_edzetv prq_edzetv mest_tv") && s(-1) )
 { ret=stopp=1; D[618]++; if(dbg){print "D618"}; continue };
break}; return ret }

function sw_ez_p_f(ret, stopp) { while ( !stopp ) {
 if ( fa(1,"u_sw_4_omo_list") && q(0,"suw_pr")&& s(0) )
 { ret=stopp=1; D[619]++; if(dbg){print "D619"}; continue };
 #
 if ( muk_edzepr(-2) &&
               w(-1,"же лишь только") && s(-2,-1) )
 { ret=stopp=1; D[620]++; if(dbg){print "D620"}; continue };
 if ( muk_edzepr(-1) && s(-1) )
 { ret=stopp=1; D[621]++; if(dbg){print "D621"}; continue };
 #_#_#
 if (prex == 1) { pre_string = "prex_pr" } else { pre_string = "pre_pr" };
 if ( q(-3,pre_string) &&
      q(-2,"prl_edzepr prq_edzepr mest_edzepr muk_edzepr") &&
      q(-1,"prl_edzepr prq_edzepr mest_edzepr") && s(-3,-1) )
 { ret=stopp=1; D[622]++; if(dbg){print "D622"}; continue };
 if ( (q(-2,pre_string)||w(-2,"по")) &&
       q(-1,"prl_edzepr prq_edzepr mest_pr muk_edzepr") && s(-2,-1) )
 { ret=stopp=1; D[623]++; if(dbg){print "D623"}; continue };
 if ( (q(-1,pre_string)||w(-1,"по")) && s(-1) )
 { ret=stopp=1; D[624]++; if(dbg){print "D624"}; continue };
 #_#_#

break}; return ret }

function sw_mn_i_f(ret, stopp) { while ( !stopp ) {
 if ( edro2mnim==1 )
 { edro2mnim==""; ret=stopp=1; D[625]++; if(dbg){print "D625"}; continue };

 if ( q(0,"suw_edro") && qb(-5,-1,"pre_ro") && s(qbn,-1) && W(qbn+1,"меня нее него них чего того") &&
    qir(qbn+1,-1,"prl_edro mest_edro prq_edro mest_3e") )
 { ret=0; stopp=1; Y["sw_mnim_2_sw_edro"]=1; D[626]++; if(dbg){print "D626"}; continue };

 if ( suw_mnim(1) && se(0,"-") && Q(1,"suw_edro") )
 { ret=stopp=1; D[627]++; if(dbg){print "D627"}; continue };

 if ( (q(1,"suw_ro name_ro_sy")||wc(1,"ов$")) && s(0) && p(-1) && p(1,",") && cap(0) && Q(0,"gl_ed gl_mn") )
 { ret=stopp=1; D[628]++; if(dbg){print "D628"}; continue };

 if ( q(-2,"prq_mnim") && q(-1,"suw_tv") && s(-2,-1) )
 { ret=stopp=1; D[629]++; if(dbg){print "D629"}; continue };
 if ( q(-2,"prl_mnim") && q(-1,"suw_ro") && s(-2,-1) )
 { ret=stopp=1; D[630]++; if(dbg){print "D630"}; continue };

 if ( prl_kred_sr(1) && se(0," — ") &&
                q(2,"prl_mn") && sc(1,"-") )
 { ret=stopp=1; D[631]++; if(dbg){print "D631"}; continue };
 if ( q(1,"prl_mnim prq_mnim") && se(0," — ") &&
      q(2,"suw_mnim") && s(1))
 { ret=stopp=1; D[632]++; if(dbg){print "D632"}; continue };
 if ( q(1,"qi_duom qi_duoz") && se(0," — ") &&
      q(2,"prl_mnim prq_mnim prl_mnro prq_mnro") &&
      q(3,"suw_edro suw_mnim") && s(1,2))
 { ret=stopp=1; D[633]++; if(dbg){print "D633"}; continue };
 if ( q(1,"suw_mnim prl_mnim prl_krmn") && se(0," — ") )
 { ret=stopp=1; D[634]++; if(dbg){print "D634"}; continue };
 if ( q(-2,"suw_mnim") && s(-2) &&
      q(-1,"name_ro_sy isname") && se(-1," — ") )
 { ret=stopp=1; D[635]++; if(dbg){print "D635"}; continue };
 if ( q(-2,"prl_mnim mest_mnim") && s(-2) &&
      q(-1,"suw_mnim") && se(-1," — ") && Q(-1,"suw_edro") )
 { ret=stopp=1; D[636]++; if(dbg){print "D636"}; continue };
 if ( q(-1,"suw_mnim") && se(-1," — ") && Q(-1,"suw_edro") )
 { ret=stopp=1; D[637]++; if(dbg){print "D637"}; continue };

 if ( nar_vopr(-1) && s(-1) &&
             W(-1,"что") && Q(0,"nar_mest") )
 { ret=stopp=1; D[638]++; if(dbg){print "D638"}; continue };
 if ( qxs(1,"сами","по","себе")||
      qxs(1,"сами","собой")||
      qxs(1,"друг","друга дружки") )
 { ret=stopp=1; D[639]++; if(dbg){print "D639"}; continue };
 if ( (qxs(-1,"как","и")||
       qxs(-1,"также","как","и") ) &&
         q(xsn-1,"muk_im suw_im") && sc(xsn-1,",") )
 { ret=stopp=1; D[640]++; if(dbg){print "D640"}; continue };

 if ( p(-1) && pre_tv(1) &&
      q(2,"suw_tv suw_edne") && s(0,1) && p(2) )
 { ret=stopp=1; D[641]++; if(dbg){print "D641"}; continue };
 if ( p(-1) && pre_vi(1) &&
      q(2,"suw_vi suw_edne") && s(0,1) && p(2) && Q(0,"gl_paedze") )
 { ret=stopp=1; D[642]++; if(dbg){print "D642"}; continue };
 if ( p(-1) && pre_pr(1) &&
      q(2,"suw_pr suw_edne") && s(0,1) && p(2) )
 { ret=stopp=1; D[643]++; if(dbg){print "D643"}; continue };
 if ( p(-1) && pre_ro(1) &&
      q(2,"suw_ro suw_edne") &&
      q(3,"prl_mnim prq_mnim") && s(0,2) )
 { ret=stopp=1; D[644]++; if(dbg){print "D644"}; continue };
 if ( w(-3,"у") &&
      q(-2,"prl_ro") &&
      q(-1,"suw_ro suw_edne") &&
      q(1,"suw_ro") && s(-3,0) )
 { ret=stopp=1; D[645]++; if(dbg){print "D645"}; continue };
 if ( w(-2,"у") &&
      q(-1,"suw_ro suw_edne") &&
      q(1,"suw_ro") && s(-2,0) )
 { ret=stopp=1; D[646]++; if(dbg){print "D646"}; continue };
 if ( q(-3,"prl_mnim prq_mnim") &&
 pre_vi(-2) &&
      q(-1,"suw_vi suw_edne") && s(-3,-1) )
 { ret=stopp=1; D[647]++; if(dbg){print "D647"}; continue };

 if ( q(-3,"pre_vi preph_vi") &&
      q(-2,"prl_vi") &&
      q(-1,"suw_vi") &&
      q(1,"suw_edro") &&
      q(2,"gl_mn gl_vzmn mod_mn") && s(-3,1) )
 { ret=stopp=1; D[648]++; if(dbg){print "D648"}; continue };
 if ( q(1,"mest_ro mest_3e suw_ro") &&
      w(2,"все") &&
     (w(3,"еще же")||q(3,"prl_srav")) &&
      q(4,"gl_mn gl_vzmn mod_mn") && s(0,3) )
 { ret=stopp=1; D[649]++; if(dbg){print "D649"}; continue };
 if ( w(1,"все") &&
     (w(2,"еще же")||q(2,"prl_srav")) &&
      q(3,"gl_mn gl_vzmn mod_mn") && s(0,2) )
 { ret=stopp=1; D[650]++; if(dbg){print "D650"}; continue };

 if ( q(1,"pre_pr") &&
      q(2,"prl_pr mest_pr") &&
      q(3,"suw_edme suw_pr") &&
      q(4,"suw_ro") && z(4) &&
      q(5,"prq_sdmnim prl_mnim") && s(0,3) )
 { ret=stopp=1; D[651]++; if(dbg){print "D651"}; continue };


 if ( q(1,"suw_ro") &&
sz_iili(2) &&
      q(3,"suw_ro") &&
      q(4,"gl_mn gl_vzmn") && s(0,3) )
 { ret=stopp=1; D[652]++; if(dbg){print "D652"}; continue };
 if ( sz_iili(1) &&
            q(2,"suw_mnim") &&
            q(3,"prl_kred_sr nar_spos nar_kaq") &&
            q(4,"gl_mn gl_vzmn") && s(0,3) )
 { ret=stopp=1; D[653]++; if(dbg){print "D653"}; continue };
 if ( sz_iili(1) && p(-1) &&
            q(2,"suw_mnim") &&
       pre_pr(3) &&
            q(4,"prl_pr") &&
            q(5,"suw_pr") && s(0,4) )
 { ret=stopp=1; D[654]++; if(dbg){print "D654"}; continue };
 if ( q(-2,"suw_mnim") && p(-3) &&
sz_iili(-1) &&
 pre_pr(1) &&
      q(2,"prl_pr") &&
      q(3,"suw_pr") && s(-2,2) )
 { ret=stopp=1; D[655]++; if(dbg){print "D655"}; continue };
 if ( q(1,"mest_ro prl_ro") &&
      q(2,"suw_ro") &&
      q(3,"gl_mn gl_vzmn") && s(0,2) )
 { ret=stopp=1; D[656]++; if(dbg){print "D656"}; continue };
 if ( q(1,"mest_ro prl_ro") &&
      q(2,"prl_ro") &&
      q(3,"suw_ro") &&
      q(4,"gl_mn gl_vzmn") && s(0,3) )
 { ret=stopp=1; D[657]++; if(dbg){print "D657"}; continue };
 if ( q(1,"mest_ro prl_ro") &&
      q(2,"suw_ro") &&
      q(3,"nar_nar nar_spos nar_kaq") &&
      q(4,"gl_mn gl_vzmn") && s(0,3) )
 { ret=stopp=1; D[658]++; if(dbg){print "D658"}; continue };
 if ( q(1,"suw_ro") &&
      q(2,"prl_kred_sr nar_spos nar_kaq") &&
      q(3,"gl_mn gl_vzmn") && s(0,2) )
 { ret=stopp=1; D[659]++; if(dbg){print "D659"}; continue };
 if ( q(1,"mest_mnim") &&
      q(2,"gl_mn gl_vzmn") && s(0,1) )
 { ret=stopp=1; D[660]++; if(dbg){print "D660"}; continue };

 if ( q(1,"suw_ro") &&
      z(1) &&
      q(2,"otsz_mn prq_mnvi mest_mnvi") && s(0) )
 { ret=stopp=1; D[661]++; if(dbg){print "D661"}; continue };
 if ( q(1,"suw_ro") &&
      z(1) &&
      q(2,"prl_kred_sr") &&
      q(3,"otsz_mn prq_mnvi") && s(0) && s(2) )
 { ret=stopp=1; D[662]++; if(dbg){print "D662"}; continue };
 if ( z(0) &&
      q(1,"prl_kred_sr pre_ro") &&
      q(2,"otsz_mn prq_mnvi") && s(1) )
 { ret=stopp=1; D[663]++; if(dbg){print "D663"}; continue };
 if ( z(0) &&
      q(1,"otsz_mn prq_mnvi") )
 { ret=stopp=1; D[664]++; if(dbg){print "D664"}; continue };
 if ( z(0) && Q(-1,"suw_mnim") &&
     (w(1,"чуть едва еле только лишь слегка")||q(1,"nar_vrem")) &&
      q(2,"prl_mnim prq_mnim") && s(1))
 { ret=stopp=1; D[665]++; if(dbg){print "D665"}; continue };

 if ( (qxs(-2,"на","что фига хрена хуя")||
       qxs(-2,"для","чего")||
         w(-2,"зачем вот")) &&
         q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[666]++; if(dbg){print "D666"}; continue };
 if ( w(-3,"вот") &&
      q(-2,"mest_da suw_da") &&
      w(-1,"и") && s(-3,-1) )
 { ret=stopp=1; D[667]++; if(dbg){print "D667"}; continue };

 if ( pre_pr(-3) &&
           q(-2,"prl_edpr prq_edpr mest_pr") &&
           q(-1,"suw_pr suw_edme") &&
           w(1,"не") &&
     gl_pnmn(2) && s(-3,1) )
 { ret=stopp=1; D[668]++; if(dbg){print "D668"}; continue };

 if ( q(-3,"mest_mnim") &&
    qxs(-1,"всего ведь же","лишь только просто его ее их") && s(-3) )
 { ret=stopp=1; D[669]++; if(dbg){print "D669"}; continue };
 if ( q(-2,"mest_mnim") &&
      w(-1,"же ж лишь только просто его ее их") && s(-2,-1) )
 { ret=stopp=1; D[670]++; if(dbg){print "D670"}; continue };
 if ( q(-1,"mest_mnim") && s(-1) )
 { ret=stopp=1; D[671]++; if(dbg){print "D671"}; continue };

 if ( q(1,"suw_ro prl_kred_sr nar_spos nar_step") &&
         prq_krmn(2) && s(0,1) )
 { ret=stopp=1; D[672]++; if(dbg){print "D672"}; continue };
 if ( q(1,"nar_spos nar_vrem") &&
      q(2,"prl_mnim prq_mnim") && s(0,1) && p(2) )
 { ret=stopp=1; D[673]++; if(dbg){print "D673"}; continue };
 if ( prl_mnim(1) && s(0) && p(1) )
 { ret=stopp=1; D[674]++; if(dbg){print "D674"}; continue };

 if ( q(1,"mest_ro prl_ro") && p(-1) &&
      q(2,"suw_ro") && s(0,1) && p(2) && W(0,"цвета") )
 { ret=stopp=1; D[675]++; if(dbg){print "D675"}; continue };

 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe") &&
      q(-3,"mest_vi") &&
sz_iili(-2) &&
      q(-1,"mest_vi") && s(-4,-1) )
 { ret=stopp=1; D[676]++; if(dbg){print "D676"}; continue };
 if ( qxs(-1,"хотя","бы") &&
        q(1,"gl_popeed gl_pein") && s(0) && p(1) )
 { ret=stopp=1; D[677]++; if(dbg){print "D677"}; continue };
 if ( q(1,"gl_popeed gl_popemn gl_pein") && s(0) && p(-1) && p(1) )
 { ret=stopp=1; D[678]++; if(dbg){print "D678"}; continue };

 if ( q(-3,"gl_nemn gl_vzmn") &&
 pre_ro(-2) &&
      q(-1,"mest_ro suw_ro") && Q(-1,"prl_edzero") && s(-3,-1) )
 { ret=stopp=1; D[679]++; if(dbg){print "D679"}; continue };

 if ( q(-3,"gl_nemn gl_vzmn") && Q(-3,"suw_edim") &&
      q(-2,"qast") &&
      q(-1,"qast") && s(-3,-1) )
 { ret=stopp=1; D[680]++; if(dbg){print "D680"}; continue };
 if ( q(-2,"gl_nemn gl_vzmn") && Q(-2,"suw_edim") &&
      q(-1,"mest_vi prl_mnvi prq_mnvi qast nar_vrem") && s(-2,-1) )
 { ret=stopp=1; D[681]++; if(dbg){print "D681"}; continue };
 if ( q(-3,"gl_nemn gl_vzmn") && Q(-3,"suw_edim") &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[682]++; if(dbg){print "D682"}; continue };
 if ( q(-1,"gl_nemn gl_vzmn") && Q(-1,"suw_edim") && s(-1) )
 { ret=stopp=1; D[683]++; if(dbg){print "D683"}; continue };
 if ( q(-2,"gl_nemn gl_vzmn") && Q(-2,"suw_edim") && s(-2) && sc(-1,"-") )
 { ret=stopp=1; D[684]++; if(dbg){print "D684"}; continue };

 if ( (w(-1,"мы вы они")||suw_mnim(-1)) &&
       q(1,"suw_ro") && sc(-1,"—") )
 { ret=stopp=1; D[685]++; if(dbg){print "D685"}; continue };
#if ( (w(-1,"мы вы они")||suw_mnim(-1)) &&
#       q(1,"suw_ro suw_im") && Q(1,"gl_mn") && s(-1,0) )
#{ ret=stopp=1; D[686]++; if(dbg){print "D686"}; continue };
 if ( w(1,"есть") && s(0) && p(1) )
 { ret=stopp=1; D[687]++; if(dbg){print "D687"}; continue };
 if ( q(1,"nar_napr") && s(0) && p(1) )
 { ret=stopp=1; D[688]++; if(dbg){print "D688"}; continue };
 if ( q(1,"nar_spos") &&
      q(2,"prq_krmn") && s(0,1) && p(-1) )
 { ret=stopp=1; D[689]++; if(dbg){print "D689"}; continue };
 if ( q(-4,"prq_krmn") &&
      w(-3,"ли") &&
 pre_ro(-2) &&
      q(-1,"mest_ro suw_ro") && s(-4,-1) && p(0) )
 { ret=stopp=1; D[690]++; if(dbg){print "D690"}; continue };
 if ( q(-2,"prq_krmn") &&
      w(-1,"ли") && s(-1) && p(0) )
 { ret=stopp=1; D[691]++; if(dbg){print "D691"}; continue };
 if ( q(-1,"prq_krmn") && s(-1) && p(0) )
 { ret=stopp=1; D[692]++; if(dbg){print "D692"}; continue };
 if ( q(1,"prq_krmn") && s(0) && p(-1) )
 { ret=stopp=1; D[693]++; if(dbg){print "D693"}; continue };
 if ( w(1,"не") &&
      q(2,"nar_spos nar_mest") &&
  gl_mn(3) && s(0,2) )
 { ret=stopp=1; D[694]++; if(dbg){print "D694"}; continue };

 if ( mest_it(-3) &&
            q(-2,"gl_mn gl_vzmn") &&
            w(-1,"не") && s(-3,-1) && p(0) )
 { ret=stopp=1; D[695]++; if(dbg){print "D695"}; continue };
 if ( mest_it(-2) &&
            w(-1,"не") && s(-2,-1) && p(0) )
 { ret=stopp=1; D[696]++; if(dbg){print "D696"}; continue };
 if ( p(-3) && q(-2,"gl_mn gl_vzmn") &&
      w(-1,"не и") && s(-2,-1) && p(0) )
 { ret=stopp=1; D[697]++; if(dbg){print "D697"}; continue };

 #
  if ( q(-3,"pre_ro preph_ro") &&
       q(-2,"mest_ro prl_ro") &&
       q(-1,"suw_ro") &&
       q(1,"suw_ro name_ro_sy isname") &&
       q(2,"gl_mn gl_vzmn") && s(-3,1) )
 { ret=stopp=1; D[698]++; if(dbg){print "D698"}; continue };


 #
 if ( q(1,"suw_ro") && p(-1) &&
      q(2,"gl_mn gl_vzmn prq_krmn") && s(0,1) )
 { ret=stopp=1; D[699]++; if(dbg){print "D699"}; continue };

 if ( sz_iili(1) &&
            q(2,"suw_im") &&
            q(3,"gl_mn gl_vzmn prq_krmn") && s(0,2) )
 { ret=stopp=1; D[700]++; if(dbg){print "D700"}; continue };

 if ( q(-5,"pre_tv preph_tv") &&
      q(-4,"suw_tv") &&
      q(-3,"suw_ro") &&
sz_iili(-2) &&
      q(-1,"suw_ro") &&
      q(1,"gl_mn gl_vzmn") && s(-5,0) )
 { ret=stopp=1; D[701]++; if(dbg){print "D701"}; continue };

 if ( q(1,"prl_mnim") &&
sz_iili(2) &&
      q(3,"prl_mnim") && s(0,2) )
 { ret=stopp=1; D[702]++; if(dbg){print "D702"}; continue };
 if ( q(1,"prl_mntv") &&
sz_iili(2) &&
      q(3,"prl_mntv") && s(0,2) )
 { ret=stopp=1; D[703]++; if(dbg){print "D703"}; continue };

 # мн.ч.им.п. в перечислениях
 if ( sz_iili(1) &&
            q(2,"mest_im prl_im") &&
            q(3,"prl_im") &&
            q(4,"suw_im") && s(0,3) )
 { ret=stopp=1; D[704]++; if(dbg){print "D704"}; continue };
 if ( sz_iili(1) &&
            q(2,"mest_im prl_im") &&
            q(3,"suw_im") && s(0,2) )
 { ret=stopp=1; D[705]++; if(dbg){print "D705"}; continue };
 if ( Q(0,"suw_edne") &&
sz_iili(1) &&
      q(2,"suw_im") && Q(2,"suw_edro") && s(0,1) )
 { ret=stopp=1; D[706]++; if(dbg){print "D706"}; continue };
 if ( sz_iili(1) && z(0) &&
            q(2,"suw_im") && Q(2,"suw_edro") && s(1) )
 { ret=stopp=1; D[707]++; if(dbg){print "D707"}; continue };
 if ( q(1,"suw_im") && z(0) &&
sz_iili(2) &&
      q(3,"suw_im") && (Q(1,"suw_edro")||Q(3,"suw_edro")) && s(1,2) )
 { ret=stopp=1; D[708]++; if(dbg){print "D708"}; continue };
 if ( Q(0,"suw_edne") && q(-1,"suw_im") && z(-1) &&
sz_iili(1) &&
      q(2,"suw_im") && (Q(-1,"suw_edro")||Q(2,"suw_edro")) && s(0,1) )
 { ret=stopp=1; D[709]++; if(dbg){print "D709"}; continue };
 if ( q(1,"suw_ro") && z(1) && s(0) &&
      q(2,"mest_im mest_3e prl_im") &&
      q(3,"suw_im") && Q(3,"suw_edro") && s(2) )
 { ret=stopp=1; D[710]++; if(dbg){print "D710"}; continue };
 if ( q(-4,"mest_mnim prl_mnim") && s(-4) &&
      q(-3,"suw_im") && z(-3) &&
      q(-2,"suw_im") &&
sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[711]++; if(dbg){print "D711"}; continue };
 if ( q(-3,"mest_mnim prl_mnim") && s(-3) &&
      q(-2,"suw_im") && z(-2) &&
      q(-1,"suw_im") && p(0) )
 { ret=stopp=1; D[712]++; if(dbg){print "D712"}; continue };
 if ( q(-2,"mest_mnim prl_mnim") && s(-2) &&
      q(-1,"suw_im") && z(-1) && p(0) )
 { ret=stopp=1; D[713]++; if(dbg){print "D713"}; continue };
 if ( q(-3,"suw_im") && z(-3) &&
      q(-2,"suw_im") &&
sz_iili(-1) && s(-2,-1) && (Q(-3,"suw_edro")||Q(-2,"suw_edro")) )
 { ret=stopp=1; D[714]++; if(dbg){print "D714"}; continue };
 if ( q(-2,"suw_im") && Q(-2,"suw_edro") &&
sz_iili(-1) && s(-2,-1) && Q_w(1,"suw_edim") && Q(0,"gl_paedze") )
 { ret=stopp=1; D[715]++; if(dbg){print "D715"}; continue };
 if ( qxs(-1,"и или да","опять снова даже") && s(xsn-1) &&
 suw_mnim(xsn-1) && Q(xsn-1,"suw_edro") )
 { ret=stopp=1; D[716]++; if(dbg){print "D716"}; continue };
 if ( qxs(-1,"и или да","опять снова даже") && s(xsn-1) &&
 suw_mnim(xsn-1) &&
 suw_mnim(xsn-2) && sc(xsn-2,",") && (Q(xsn-1,"suw_edro")||Q(xsn-2,"suw_edro")) )
 { ret=stopp=1; D[717]++; if(dbg){print "D717"}; continue };
 if ( sz_iili(1) && z(-1) &&
            w(2,"тому") &&
            w(3,"подобная подобное подобный подобные") && s(0,2) )
 { ret=stopp=1; D[718]++; if(dbg){print "D718"}; continue };
 if ( q(1,"mest_mnro prl_mnro") && p(-1) &&
      q(2,"suw_ro") &&
sz_iili(3) &&
      q(4,"suw_mnro") && s(0,3) )
 { ret=stopp=1; D[719]++; if(dbg){print "D719"}; continue };
 if ( q(-5,"pre_vi preph_vi") &&
      q(-4,"mest_vi prl_vi") &&
      q(-3,"prl_vi isname") &&
sz_iili(-2) &&
      q(-1,"prl_mnvi isname") && s(-5,-1) )
 { ret=stopp=1; D[720]++; if(dbg){print "D720"}; continue };
 if ( q(1,"suw_ro") && s(0) &&
    qxs(2,"и или да","опять снова даже") &&
      q(xsn+1,"suw_im") && s(xsn) && Q(xsn+1,"suw_edro") )
 { ret=stopp=1; D[721]++; if(dbg){print "D721"}; continue };
 if ( qxs(-1,"равно","как","и") &&
        q(xsn-3,"suw_im") &&
        q(xsn-2,"prl_kred_sr nar_spos") &&
        q(xsn-1,"gl_mn gl_vzmn") && sc(xsn-1,",") && s(xsn-3,xsn-2) )
 { ret=stopp=1; D[722]++; if(dbg){print "D722"}; continue };
 if ( qF(1,5,"suw_im","suw_ro") && sq(-1,qFn-1,",") )
 { ret=stopp=1; D[723]++; if(dbg){print "D723"}; continue };
 if ( qB(-5,-1,"suw_im","suw_ro") && sq(qBn,0,",") && Q(0,"gl_paedze") )
 { ret=stopp=1; D[724]++; if(dbg){print "D724"}; continue };

 if ( ist_suw_mnim(-2) && Q(0,"gl_paedze") && Qist(-2,"ist_suw_edsrro") &&
           sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[725]++; if(dbg){print "D725"}; continue };
 if ( q(-4,"gl_pnmn gl_pemn") &&
      q(-3,"qast") &&
 pre_tv(-2) &&
      q(-1,"mest_tv suw_vi") && s(-4,-1) )
 { ret=stopp=1; D[726]++; if(dbg){print "D726"}; continue };
 if ( q(1,"qast") &&
      q(2,"gl_pnmn gl_pemn") &&
      q(3,"mest_vi prl_vi") &&
      q(4,"suw_vi") && s(0,3) )
 { ret=stopp=1; D[727]++; if(dbg){print "D727"}; continue };
 if ( q(1,"qast") &&
      q(2,"gl_pnmn gl_pemn") &&
      q(3,"suw_vi") && s(0,2) )
 { ret=stopp=1; D[728]++; if(dbg){print "D728"}; continue };

## поисковые
#if ( qsf(0,4,vvpat) &&
#      vv(sfn,sfn+7) &&
#    seek(vvn+1,vvn+6,"gl_vzmn gl_nemn mod_mn","mest_mnim suw_mnim") && s(vvn+1,skn-1) && Qw_(-1,"suw_mnim") )
#{ ret=stopp=1; D[729]++; if(dbg){print "D729"}; continue };
#if ( qsf(0,4,vvpat) &&
#      vv(sfn,sfn+7) &&
#       q(vvn+1,"gl_vzmn gl_nemn mod_mn") && Qw_(-1,"suw_mnim") )
#{ ret=stopp=1; D[730]++; if(dbg){print "D730"}; continue };
#if ( vvb(-7,-1) &&
#       q(vvn,"prl_mnim prq_mnim") )
#{ ret=stopp=1; D[731]++; if(dbg){print "D731"}; continue };

#if ( Qw_(-1,"suw_mnim") &&
#    seek(1,5,"mod_mn","mest_mnim suw_mnim") &&
#   gl_in(skn+1) && s(0,skn) )
#{ ret=stopp=1; D[732]++; if(dbg){print "D732"}; continue };
#if ( pre_ro(1) &&
#         qf(1,5,"gl_vzmn gl_nemn mod_mn") && s(0,qfn-1) && Qw_(-1,"suw_mnim") )
#{ ret=stopp=1; D[733]++; if(dbg){print "D733"}; continue };
#if ( seek(1,7,"gl_vzmn gl_nemn mod_mn","suw_mnim mest_mnim") && s(0,skn-1) && Qw_(-1,"suw_mnim") )
#{ ret=stopp=1; D[734]++; if(dbg){print "D734"}; continue };
#if ( !(qb(-5,-1,"suw_mnim") && s(qbn,-1)) &&
#       qf(1,7,"gl_pemn") && s(0,qfn-1) && W(qfn-1,"не") )
#{ ret=stopp=1; D[735]++; if(dbg){print "D735"}; continue };

#if ( qf(1,7,"gl_pnmn gl_pemn") && W(qfn-1,"не") && s(0,qfn) && Qw_(-1,"suw_mnim") &&
#      q(qfn+1,"suw_ro") )
#{ ret=stopp=1; D[736]++; if(dbg){print "D736"}; continue };
##
#if ( seek(1,7,"gl_pnmn gl_pemn","mest_mnim suw_mnim") && W(skn-1,"не") && s(0,skn-1) && Qw_(-1,"suw_mnim suw_mnro") )
#{ ret=stopp=1; D[737]++; if(dbg){print "D737"}; continue };
#if ( q(1,"suw_ro") &&
#  seek(2,7,"gl_pnmn gl_pemn","mest_mnim suw_mnim") && W(skn-1,"не") && s(0,skn-1) && Qw_(-1,"suw_mnim suw_mnro") )
#{ ret=stopp=1; D[738]++; if(dbg){print "D738"}; continue };
#if ( qf(1,7,"gl_pnmn gl_pemn") &&
#      q(qfn-2,"prl_ro prq_ro") &&
#      q(qfn-1,"suw_ro") && s(0,qfn-1) && Qw_(-1,"suw_mnim") )
#{ ret=stopp=1; D[739]++; if(dbg){print "D739"}; continue };

#if ( seek(1,5,"prl_mnim prl_krmn","suw_mnim") && s(0,skn-1) && p(skn) )
#{ ret=stopp=1; D[740]++; if(dbg){print "D740"}; continue };
##
#if ( Qw_(-1,"suw_any") &&
#      qf(1,5,"prl_krmn prq_krmn") && s(0,qfn-1) )
#{ ret=stopp=1; D[741]++; if(dbg){print "D741"}; continue };


#if ( Q(0,"suw_edne gl_in") && qF(1,7,"suw_mnim","suw_edro") && sq(0,qFn-1,",") )
#{ ret=stopp=1; D[742]++; if(dbg){print "D742"}; continue };
#if ( Q(0,"suw_edne") && qB(-7,-1,"suw_mnim","suw_edro") && sq(qBn,-1,",") )
#{ ret=stopp=1; D[743]++; if(dbg){print "D743"}; continue };
#if ( Q(0,"suw_edne") && qB(-7,-1,"suw_edim","mest_im") && sq(qBn,-1,",") && Q(0,"gl_paedze") )
#{ ret=stopp=1; D[744]++; if(dbg){print "D744"}; continue };
 #
#if ( qf(1,5,"gl_ed gl_mn")) && ba(qfn,"_gl_learn") &&
#      w(qfn-1,"не") && s(0,qfn-1) )
#{ ret=stopp=1; D[745]++; if(dbg){print "D745"}; continue };

 if ( q(-3,"prl_im prq_im") &&
sz_iili(-2) &&
      q(-1,"prl_im prq_im") && s(-3,-1) )
 { ret=stopp=1; D[746]++; if(dbg){print "D746"}; continue };
 if ( q(-3,"prl_mnim") &&
      w(-2,"у") &&
      q(-1,"mest_ro suw_ro name_ro_sy") && s(-3,-1) )
 { ret=stopp=1; D[747]++; if(dbg){print "D747"}; continue };
 if ( w(-2,"у") &&
      q(-1,"name_ro_sy") && s(-2,-1) )
 { ret=stopp=1; D[748]++; if(dbg){print "D748"}; continue };

 #
 if ( q(-2,"prq_pe prq_pn") &&
      q(-1,"suw_da mest_da") && s(-2,-1) )
 { ret=stopp=1; D[749]++; if(dbg){print "D749"}; continue };
 if ( q(-2,"prq_pe prq_pn") &&
      q(-1,"prl_mnvi mest_mnvi") && s(-2,-1) )
 { ret=stopp=1; D[750]++; if(dbg){print "D750"}; continue };
 if ( q(-1,"narph_priq") &&
      q(xwn-1,"prq_pe prq_pn") && s(xwn-1,-1) )
 { ret=stopp=1; D[751]++; if(dbg){print "D751"}; continue };
 if ( q(-1,"prq_pe prq_pn") && s(-1) )
 { ret=stopp=1; D[752]++; if(dbg){print "D752"}; continue };
 if ( q(-3,"prq_pe prq_pn") &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[753]++; if(dbg){print "D753"}; continue };

 if ( p(-1,",") &&
 pre_ro(1) &&
      q(2,"suw_ro") &&
sz_iili(3) &&
      q(4,"prl_ro prq_ro") &&
      q(5,"suw_ro") && p(5) )
 { ret=stopp=1; D[754]++; if(dbg){print "D754"}; continue };
 if ( p(-1,",") &&
 pre_ro(1) &&
      q(2,"suw_ro") &&
sz_iili(3) &&
      q(4,"suw_ro") && p(4) )
 { ret=stopp=1; D[755]++; if(dbg){print "D755"}; continue };
 if ( p(-1,",") &&
 pre_ro(1) &&
      q(2,"suw_ro") && p(2) )
 { ret=stopp=1; D[756]++; if(dbg){print "D756"}; continue };
 if ( q(1,"prl_mnim prl_mntv") && sc(0,"—") && p(1) )
 { ret=stopp=1; D[757]++; if(dbg){print "D757"}; continue };
 if ( q(1,"prl_kred_sr") && se(1,"-") &&
      q(2,"prl_mnim prl_mntv") && sc(0,"—") && p(2) )
 { ret=stopp=1; D[758]++; if(dbg){print "D758"}; continue };
 if ( p(-1,",") && p(0,",") && W(0,"воды") )
 { ret=stopp=1; D[759]++; if(dbg){print "D759"}; continue };

 #_#_#
 if (prex == 1) { pre_string = "prex_im" } else { pre_string ="pre_im" };
 if ( q(-2,pre_string) &&
      q(-1,"prl_mnim prq_mnim mest_mnim muk_mnim") && s(-2,-1) )
 { ret=stopp=1; D[760]++; if(dbg){print "D760"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[761]++; if(dbg){print "D761"}; continue };
 #_#_#

 if ( (q(-1,"prl_mnim prq_mnim muk_mnim")||(mest_mnim(-1) && Q(0,"prl_krmn"))||wc(-1,"[ео]вы$")) && s(-1) )
 { ret=stopp=1; D[762]++; if(dbg){print "D762"}; continue };
 if ( (q(-2,"prl_mnim prq_mnim muk_mnim")||(mest_mnim(-2) && Q(0,"prl_krmn"))||wc(-2,"[ео]вы$")) && s(-2) && sc(-1,"-") )
 { ret=stopp=1; D[763]++; if(dbg){print "D763"}; continue };
 if ( narph_any(-1) &&
             (q(xwn-1,"prl_mnim prq_mnim muk_mnim")||(mest_mnim(xwn-1) && Q(0,"prl_krmn"))||wc(xwn-1,"[ео]вы$")) && s(xwn-1,-1) )
 { ret=stopp=1; D[764]++; if(dbg){print "D764"}; continue };

 if ( Qw_(-3,"mest_mnim suw_mnim") &&
        q(-2,"prl_krmn") &&
        q(-1,"mest_vi prl_mnvi") && s(-2,-1) )
 { ret=stopp=1; D[765]++; if(dbg){print "D765"}; continue };
 if ( Qw_(-2,"mest_mnim suw_mnim") &&
        q(-1,"prl_krmn") && s(-1) )
 { ret=stopp=1; D[766]++; if(dbg){print "D766"}; continue };

 if ( sw_im_f() )
 { ret=stopp=1; D[767]++; if(dbg){print "D767", "sw_im_f"}; continue };
break}; return ret }

function sw_mn_v_f(ret, stopp) { while ( !stopp ) {
 if ( edro2mnvi==1 )
 { ret=stopp=1; D[768]++; if(dbg){print "D768"}; continue };

 if ( q(-1,"gl_in gl_ed gl_mn deep gl_poed") && ba(-1,"_gl_obj_vi") && s(-1) )
 { ret=stopp=1; D[769]++; if(dbg){print "D769"}; continue };

 if ( q(-3,"gl_in gl_ed gl_mn deep") && ba(-3,"_gl_learn") &&
 pre_tv(-2) &&
      q(-1,"suw_tv mest_tv") && s(-3,-1) )
 { ret=stopp=1; D[770]++; if(dbg){print "D770"}; continue };
 if ( q(-2,"gl_in gl_ed gl_poed gl_pomn gl_mn deep") && ba(-2,"_gl_learn") &&
      q(-1,"mest_vi prl_mnvi nar_mest") && s(-2,-1) )
 { ret=stopp=1; D[771]++; if(dbg){print "D771"}; continue };
 if ( q(-1,"gl_in gl_ed gl_mn deep") && ba(-1,"_gl_learn") && s(-1) )
 { ret=stopp=1; D[772]++; if(dbg){print "D772"}; continue };

 if ( qxs(-1,"а","иногда","и") &&
        q(xsn-2,"mest_vi prl_mnvi") &&
        q(xsn-1,"suw_mnvi") && sc(xsn-1,",") && s(xsn-2) )
 { ret=stopp=1; D[773]++; if(dbg){print "D773"}; continue };

 if ( w(1,"и") &&
      q(2,"suw_vi") &&
      q(3,"mest_im suw_im name_im_sy isname") &&
      q(4,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(5,"prl_tv") &&
      q(6,"suw_tv") && s(0,5) )
 { ret=stopp=1; D[774]++; if(dbg){print "D774"}; continue };
 if ( w(1,"и") &&
      q(2,"suw_vi") &&
      q(3,"mest_im suw_im name_im_sy isname") &&
      q(4,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(5,"suw_tv") && s(0,4) )
 { ret=stopp=1; D[775]++; if(dbg){print "D775"}; continue };

 if ( q(1,"mest_im suw_im name_im_sy isname") &&
      q(2,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(3,"prl_tv") &&
      q(4,"suw_tv") && s(0,3) )
 { ret=stopp=1; D[776]++; if(dbg){print "D776"}; continue };
 if ( q(1,"mest_im suw_im name_im_sy isname") &&
      q(2,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(3,"suw_tv") && s(0,2) )
 { ret=stopp=1; D[777]++; if(dbg){print "D777"}; continue };
 if ( q(1,"suw_ro name_ro_sy isname") && s(0,1) &&
          narph_any(2) &&
      q(xwn+1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
 pre_tv(xwn+2) &&
      q(xwn+3,"suw_tv") && s(xwn,xwn+2) )
 { ret=stopp=1; D[778]++; if(dbg){print "D778"}; continue };

 if ( q(-4,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(-3,"prl_vi") &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-4,-1) )
 { ret=stopp=1; D[779]++; if(dbg){print "D779"}; continue };
 if ( q(-1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && Q(-1,"prl_edzero mest_edzero") && s(-1) )
 { ret=stopp=1; D[780]++; if(dbg){print "D780"}; continue };
 if ( q(-2,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
mest_3e(-1) && s(-2,-1))
 { ret=stopp=1; D[781]++; if(dbg){print "D781"}; continue };
 if ( q(-4,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
      q(-3,"suw_mnvi mest_3e") &&
sz_iili(-2) &&
      q(-1,"mest_mnvi mest_3e prl_mnvi") && s(-4,-1) )
 { ret=stopp=1; D[782]++; if(dbg){print "D782"}; continue };
 if ( q(-3,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
         suw_mnvi(-2) &&
sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[783]++; if(dbg){print "D783"}; continue };
 if ( narph_any(-3) &&
              q(xwn-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
       suw_mnvi(-2) &&
        sz_iili(-1) && s(-3,-1) )
 { ret=stopp=1; D[784]++; if(dbg){print "D784"}; continue };
 if ( q(-4,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
      q(-3,"nar_napr") &&
 pre_ro(-2) &&
      q(-1,"suw_ro") && s(-4,-1) && W(0,"сорок") )
 { ret=stopp=1; D[785]++; if(dbg){print "D785"}; continue };
 if ( q(-2,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") &&
      q(-1,"nar_napr") && s(-2,-1) && W(0,"сорок"))
 { ret=stopp=1; D[786]++; if(dbg){print "D786"}; continue };
 if ( q(-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") && s(-1) && W(0,"сорок"))
 { ret=stopp=1; D[787]++; if(dbg){print "D787"}; continue };

 if ( q(1,"gl_pemn gl_pnmn") &&
 pre_pr(2) &&
      q(3,"suw_pr") && s(0,2) )
 { ret=stopp=1; D[788]++; if(dbg){print "D788"}; continue };
 if ( q(-4,"gl_vzed gl_vzmn gl_peed gl_pned gl_pemn gl_pnmn deep_pe deep_pn gl_pein gl_pnin") &&
 pre_pr(-3) &&
      q(-2,"prl_edpr prq_edpr mest_pr") &&
      q(-1,"suw_pr suw_edme") && s(-4,-1) )
 { ret=stopp=1; D[789]++; if(dbg){print "D789"}; continue };
 if ( q(-3,"gl_vzed gl_vzmn gl_peed gl_pned gl_pemn gl_pnmn deep_pe deep_pn gl_pein gl_pnin") &&
 pre_pr(-2) &&
      q(-1,"suw_pr suw_edme") && s(-3,-1) )
 { ret=stopp=1; D[790]++; if(dbg){print "D790"}; continue };

 # narphy
 if ( q(-1,"narph_any") && s(-1) &&
      q(xwn-1,"gl_pnin gl_pned gl_pnmn gl_popned gl_popnmn deep_pn") && s(xwn-1) && W(0,"сорок") )
 { ret=stopp=1; D[791]++; if(dbg){print "D791"}; continue };
 if ( q(-1,"narph_any") && s(-1) &&
      q(xwn-1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && s(xwn-1) )
 { ret=stopp=1; D[792]++; if(dbg){print "D792"}; continue };

 if ( q(1,"mest_im suw_im") &&
      q(2,"mod_ed mod_mn") &&
  gl_in(3) && s(0,2) )
 { ret=stopp=1; D[793]++; if(dbg){print "D793"}; continue };

 if ( qb(-5,-2,"mod_mn") &&
       q(qbn+1,"prl_krmn") && s(qbn-2,-1) )
 { ret=stopp=1; D[794]++; if(dbg){print "D794"}; continue };
#if ( qf(1,5,"mod_bz") &&
#  gl_in(qfn+1) && s(0,qfn) )
#{ ret=stopp=1; D[795]++; if(dbg){print "D795"}; continue };

 if ( q(-3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
 pre_ro(-2) &&
      q(-1,"suw_ro mest_ro") && s(-3,-1) )
 { ret=stopp=1; D[796]++; if(dbg){print "D796"}; continue };
 if ( q(1,"mest_vi") &&
   qast(2) &&
      q(3,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(4,"suw_im") && s(0,3) )
 { ret=stopp=1; D[797]++; if(dbg){print "D797"}; continue };
 if ( q(1,"mest_vi qast") &&
      q(2,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") &&
      q(3,"suw_im") && s(0,2) )
 { ret=stopp=1; D[798]++; if(dbg){print "D798"}; continue };
 if ( q(1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && Q(1,"mest_any suw_any") &&
      q(2,"suw_im") && s(0,1) )
 { ret=stopp=1; D[799]++; if(dbg){print "D799"}; continue };
 if ( q(1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && Q(1,"mest_any suw_any") &&
      q(2,"prl_im") &&
      q(3,"suw_im") && s(0,2) )
 { ret=stopp=1; D[800]++; if(dbg){print "D800"}; continue };
 if ( q(1,"mest_im prl_im mest_3e") &&
      q(2,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && Q(2,"mest_any suw_any") &&
      q(3,"prl_im") &&
      q(4,"suw_im") && s(0,3) )
 { ret=stopp=1; D[801]++; if(dbg){print "D801"}; continue };
 if ( q(1,"mest_ro suw_ro name_ro_sy isname") && s(0,1) &&
      q(2,"narph_any") &&
      q(xwn+1,"gl_paedsr") && s(xwn) &&
      Q(0,"gl_paedze suw_edsrim") && Q(1,"gl_vzed") )
 { ret=stopp=1; D[802]++; if(dbg){print "D802"}; continue };
 if ( q(1,"narph_any") && s(0) &&
      q(xwn+1,"gl_paedsr") && s(xwn) &&
      Q(0,"gl_paedze suw_edsrim") && Q(1,"gl_vzed") )
 { ret=stopp=1; D[803]++; if(dbg){print "D803"}; continue };

 if ( q(-2,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && ba(-2,"_gl_talk") &&
      q(-1,"mest_vi prl_mnvi") && s(-2,-1) )
 { ret=stopp=1; D[804]++; if(dbg){print "D804"}; continue };
 if ( q(-1,"gl_in gl_ed gl_mn gl_poed gl_pomn deep") && ba(-1,"_gl_talk") && s(-1) )
 { ret=stopp=1; D[805]++; if(dbg){print "D805"}; continue };

 if ( pre_vi(-3) &&
           q(-2,"suw_vi") &&
     sz_iili(-1) && s(-3,-1) && Q(0,"gl_paedze") )
 { ret=stopp=1; D[806]++; if(dbg){print "D806"}; continue };

 if ( q(-3,"prl_edvi prq_edvi") &&
sz_iili(-2) &&
      q(-1,"prl_edvi prq_edvi") && s(-3,-1) )
 { ret=stopp=1; D[807]++; if(dbg){print "D807"}; continue };

 if ( Ww_(-2,"не") &&
           prq_edmuim(-1) &&
           suw_edmuim(1) && s(-1,0) )
 { ret=stopp=1; D[808]++; if(dbg){print "D808"}; continue };

 #
 if ( Ww_(-3,"не") &&
        q(-2,"deep_pe gl_peed gl_pein gl_pemn gl_popeed gl_popemn") &&
        q(-1,"prl_mnvi prq_mnvi mest_vi") && s(-2,-1) )
 { ret=stopp=1; D[809]++; if(dbg){print "D809"}; continue };
 if ( Ww_(-2,"не") && !isomo(-1) &&
        q(-1,"deep_pe gl_peed gl_pein gl_pemn gl_popeed gl_popemn") && s(-1) )
 { ret=stopp=1; D[810]++; if(dbg){print "D810"}; continue };
 if ( Ww_(-5,"не") &&
        q(-4,"deep_pe gl_peed gl_pein gl_pemn gl_popeed gl_popemn") &&
        q(-3,"prl_mnvi prq_mnvi mest_vi") &&
 suw_mnvi(-2) &&
  sz_iili(-1) && s(-4,-1) )
 { ret=stopp=1; D[811]++; if(dbg){print "D811"}; continue };
 if ( Ww_(-4,"не") &&
        q(-3,"deep_pe gl_peed gl_pein gl_pemn gl_popeed gl_popemn") && Q(-3,"suw_edda suw_edvi") &&
 suw_mnvi(-2) &&
  sz_iili(-1) && s(-3,-1) && Q(0,"gl_paedze"))
 { ret=stopp=1; D[812]++; if(dbg){print "D812"}; continue };
 if ( q(-2,"prl_mnim prq_mnim mest_mnim muk_mnim") &&
      w(-1,"то") && sc(-2,"-") && s(-1) )
 { ret=stopp=1; D[813]++; if(dbg){print "D813"}; continue };
 if ( q(1,"mest_im suw_im") &&
      q(2,"gl_peed gl_pemn gl_popeed gl_popemn") && s(0,1) && p(-1) )
 { ret=stopp=1; D[814]++; if(dbg){print "D814"}; continue };

 if ( qxs(-1,"в","виду") &&
        q(xsn-2,"mest_im suw_im") &&
       bw(xsn-1,"иметь") && s(xsn-2) )
 { ret=stopp=1; D[815]++; if(dbg){print "D815"}; continue };

 #_#_#
 if (prex == 1) { pre_string = "prex_vi preph_vi" } else { pre_string = "pre_vi preph_vi" };
 if ( q(-2,pre_string) &&
      q(-1,"prl_mnvi prq_mnvi mest_mnvi") && W(-1,"него нее них") && s(-2,-1) )
 { ret=stopp=1; D[816]++; if(dbg){print "D816"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[817]++; if(dbg){print "D817"}; continue };
 if ( q(-2,pre_string) && s(-2) && sc(-1,"-") )
 { ret=stopp=1; D[818]++; if(dbg){print "D818"}; continue };
 #_#_#

 if ( q(-2,"prl_vi prq_vi") &&
      q(-1,"mest_da suw_da") && s(-2,-1) && p(0) )
 { ret=stopp=1; D[819]++; if(dbg){print "D819"}; continue };

 # мн.ч.вин.п. в перечислениях
 if ( sz_iili(1) &&
            q(2,"mest_vi prl_vi") &&
            q(3,"prl_vi") &&
            q(4,"suw_vi") && s(0,3) )
 { ret=stopp=1; D[820]++; if(dbg){print "D820"}; continue };
 if ( sz_iili(1) &&
            q(2,"mest_vi prl_vi") &&
            q(3,"suw_vi") && s(0,2) )
 { ret=stopp=1; D[821]++; if(dbg){print "D821"}; continue };
 if ( Q(0,"suw_edne") &&
sz_iili(1) &&
      q(2,"suw_vi") && Q(2,"suw_edro") && s(0,1) )
 { ret=stopp=1; D[822]++; if(dbg){print "D822"}; continue };
 if ( sz_iili(1) && z(0) &&
            q(2,"suw_vi") && Q(2,"suw_edro") && s(1) )
 { ret=stopp=1; D[823]++; if(dbg){print "D823"}; continue };
 if ( q(1,"suw_vi") && z(0) &&
sz_iili(2) &&
      q(3,"suw_vi") && (Q(1,"suw_edro")||Q(3,"suw_edro")) && s(1,2) )
 { ret=stopp=1; D[824]++; if(dbg){print "D824"}; continue };
 if ( Q(0,"suw_edne") && q(-1,"suw_vi") && z(-1) &&
sz_iili(1) &&
      q(2,"suw_vi") && (Q(-1,"suw_edro")||Q(2,"suw_edro")) && s(0,1) )
 { ret=stopp=1; D[825]++; if(dbg){print "D825"}; continue };
 if ( q(-4,"mest_mnvi prl_mnvi") && s(-4) &&
      q(-3,"suw_vi") && z(-3) &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[826]++; if(dbg){print "D826"}; continue };
 if ( q(-3,"suw_vi") && z(-3) &&
      q(-2,"suw_vi") &&
sz_iili(-1) && s(-2,-1) && (Q(-3,"suw_edro")||Q(-2,"suw_edro")) )
 { ret=stopp=1; D[827]++; if(dbg){print "D827"}; continue };
 if ( q(-2,"suw_vi") && Q(-2,"suw_edro") &&
sz_iili(-1) && s(-2,-1) && Q(0,"gl_paedze") )
 { ret=stopp=1; D[828]++; if(dbg){print "D828"}; continue };
 if ( qxs(-1,"и или да","опять снова даже") && s(xsn-1) &&
 suw_mnvi(xsn-1) && Q(xsn-1,"suw_edro") )
 { ret=stopp=1; D[829]++; if(dbg){print "D829"}; continue };
 if ( qxs(-1,"и или да","опять снова даже") && s(xsn-1) &&
 suw_mnvi(xsn-1) &&
 suw_mnvi(xsn-2) && sc(xsn-2,",") && (Q(xsn-1,"suw_edro")||Q(xsn-2,"suw_edro")) )
 { ret=stopp=1; D[830]++; if(dbg){print "D830"}; continue };
 if ( q(1,"suw_ro") && s(0) &&
    qxs(2,"и или да","опять снова даже") &&
      q(xsn+1,"suw_vi") && s(xsn) && Q(xsn+1,"suw_edro") )
 { ret=stopp=1; D[831]++; if(dbg){print "D831"}; continue };
 if ( sz_iili(1) && z(-1) &&
            w(2,"тому") &&
            w(3,"подобная подобное подобный подобные") && s(0,2) )
 { ret=stopp=1; D[832]++; if(dbg){print "D832"}; continue };
 if ( q(-3,"gl_nemn gl_vzmn") && Q(-3,"suw_edim") && s(-3) &&
         suw_mnvi(-2) && z(-2) &&
         suw_mnvi(-1) && z(-1) )
 { ret=stopp=1; D[833]++; if(dbg){print "D833"}; continue };
 if ( q(-2,"gl_nemn gl_vzmn") && Q(-2,"suw_edim") && s(-2) &&
         suw_mnvi(-1) && z(-1) )
 { ret=stopp=1; D[834]++; if(dbg){print "D834"}; continue };
 if ( qF(1,5,"suw_vi","suw_ro") && sq(-1,qFn-1,",") )
 { ret=stopp=1; D[835]++; if(dbg){print "D835"}; continue };
 if ( qB(-5,-1,"suw_vi","suw_ro") && sq(qBn,0,",") && Q(0,"gl_paedze") )
 { ret=stopp=1; D[836]++; if(dbg){print "D836"}; continue };


 if ( q(-1,"preph_vi prl_mnvi prq_mnvi mest_pmnim") && s(-1) )
 { ret=stopp=1; D[837]++; if(dbg){print "D837"}; continue };
 if ( qb(-8,-4,"gl_pnin gl_pned gl_pnmn deep_pn") &&
     Ww_(qbn-1,"не") && Q(qbn,"suw_edim") && suw_mnvi(0) && Q(0,"gl_in ipa_any") &&
       q(qbn+1,"suw_da mest_da") &&
 sz_iili(-1) && s(-2,-1) )
 { ret=stopp=1; D[838]++; if(dbg){print "D838"}; continue };

 # seek реальные фиксированные случаи
 if ( q(-3,"gl_pein gl_peed gl_pemn deep_pe") && Q(-3,"gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne") &&
 pre_pr(-2) &&
      q(-1,"suw_pr mest_pr") && s(-3,-1) )
 { ret=stopp=1; D[839]++; if(dbg){print "D839"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn deep_pe") && Q(-3,"gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne") &&
 pre_vi(-2) &&
      q(-1,"suw_vi mest_vi") && s(-3,-1) )
 { ret=stopp=1; D[840]++; if(dbg){print "D840"}; continue };
 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe") && Q(-4,"gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne") &&
 pre_vi(-3) &&
      q(-2,"suw_vi") &&
      q(-1,"mest_vi") && s(-3,-1) )
 { ret=stopp=1; D[841]++; if(dbg){print "D841"}; continue };
 if ( q(-3,"gl_pein gl_peed gl_pemn deep_pe") && Q(-3,"gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne") &&
 pre_tv(-2) && !(ba(-3,"_gl_yes_nero")) &&
      q(-1,"suw_tv mest_tv") && s(-3,-1) )
 { ret=stopp=1; D[842]++; if(dbg){print "D842"}; continue };


 # seek желательно включать только для поискановых паттернов
#if ( seek(-8,-3,"gl_pein gl_peed gl_pemn deep_pe","gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_pr(-2) &&
#       q(-1,"suw_pr mest_pr") && s(skn,-1) )
#{ ret=stopp=1; D[843]++; if(dbg){print "D843"}; continue };
#if ( seek(-9,-4,"gl_pein gl_peed gl_pemn deep_pe","gl_nein gl_pnin gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_pr(-3) &&
#       q(-2,"suw_pr") &&
#        q(-1,"mest_vi") && s(skn,-1) )
#{ ret=stopp=1; D[844]++; if(dbg){print "D844"}; continue };
#if ( seek(-8,-3,"gl_pein gl_peed gl_pemn deep_pe","gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_vi(-2) &&
#       q(-1,"suw_vi mest_vi") && s(skn,-1) )
#{ ret=stopp=1; D[845]++; if(dbg){print "D845"}; continue };
#if ( seek(-9,-4,"gl_pein gl_peed gl_pemn deep_pe","gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_vi(-3) &&
#       q(-2,"suw_vi") &&
#        q(-1,"mest_vi") && s(skn,-1) )
#{ ret=stopp=1; D[846]++; if(dbg){print "D846"}; continue };
#if ( seek(-8,-3,"gl_pein gl_peed gl_pemn deep_pe","gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_tv(-2) && !(ba(skn,"_gl_yes_nero")) &&
#       q(-1,"suw_tv mest_tv") && s(skn,-1) )
#{ ret=stopp=1; D[847]++; if(dbg){print "D847"}; continue };
#if ( seek(-9,-4,"gl_pein gl_peed gl_pemn deep_pe","gl_need gl_nemn gl_vzmn gl_pned gl_pnmn deep_pn deep_ne suw_vi") &&
#      pre_tv(-3) &&
#       q(-2,"suw_tv") &&
#        q(-1,"mest_tv") && s(skn,-1) )
#{ ret=stopp=1; D[848]++; if(dbg){print "D848"}; continue };
 if ( sz_iili(1) && qq(0,2) &&
            q(2,"suw_mnvi") && s(0,1) )
 { ret=stopp=1; D[849]++; if(dbg){print "D849"}; continue };
 if ( sz_iili(-1) && qq(0,-2) &&
            q(-2,"suw_mnvi") && s(-2,-1) )
 { ret=stopp=1; D[850]++; if(dbg){print "D850"}; continue };

break}; edro2mnvi=""; return ret }

function sw_mn_r_f(ret, stopp) { while ( !stopp ) {
 if ( suw_any(-1) && ba(-1,"_numeral") && s(-1) )
 { ret=stopp=1; D[851]++; if(dbg){print "D851"}; continue };
 if ( suw_any(-2) && ba(-2,"_numeral") &&
            q(-1,"prl_any") && se(-2,"-") && s(-1) )
 { ret=stopp=1; D[852]++; if(dbg){print "D852"}; continue };
 #
 if ( q(-1,"gl_pnin gl_pned gl_pnmn deep_pn") && ba(-1,"_gl_no_nero") && s(-1) )
 { ret=0; stopp=1; D[853]++; if(dbg){print "D853"}; continue };
 if ( q(-1,"gl_pein gl_peed gl_pemn deep_pe") && ba(-1,"_gl_no_nero") && s(-1) )
 { ret=0; stopp=1; D[854]++; if(dbg){print "D854"}; continue };
 if ( q(-1,"gl_nein gl_need gl_nemn gl_vzmn gl_vzed deep_ne") && ba(-1,"_gl_no_nero") && s(-1) )
 { ret=0; stopp=1; D[855]++; if(dbg){print "D855"}; continue };

 if ( fa(-2,"h_sw_4_sw_mnro") &&
       q(-1,"prl_mnro prq_mnro mest_ro") && s(-2,-1) )
 { ret=stopp=1; D[856]++; if(dbg){print "D856"}; continue };
 if ( fa(-1,"h_sw_4_sw_mnro") && s(-1) )
 { ret=stopp=1; D[857]++; if(dbg){print "D857"}; continue };

 if ( bw(-1,"пара") && s(-1) )
 { ret=stopp=1; D[858]++; if(dbg){print "D858"}; continue };
 if ( w(-2,"сколько") &&
      q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[859]++; if(dbg){print "D859"}; continue };

 if ( suw_ed(-1) &&
           q(1,"nar_kaq prl_kred_sr") &&
           q(2,"gl_ed") && s(-1,0) )
 { ret=stopp=1; D[860]++; if(dbg){print "D860"}; continue };
 if ( suw_ed(-1) &&
           q(1,"gl_ed") && s(-1,0) )
 { ret=stopp=1; D[861]++; if(dbg){print "D861"}; continue };

 if ( q(1,"prq_mnro") && z(0)  )
 { ret=stopp=1; D[862]++; if(dbg){print "D862"}; continue };

 if ( w(-2,"не") &&
      q(-1,"gl_peed gl_pein gl_pemn gl_poed deep_pe") && s(-2,-1) )
 { ret=stopp=1; D[863]++; if(dbg){print "D863"}; continue };
 if ( w(-2,"не") &&
      q(-1,"gl_need gl_nein gl_nemn gl_vzmn gl_poed gl_vzed deep_ne") && s(-2,-1) )
 { ret=stopp=1; D[864]++; if(dbg){print "D864"}; continue };
 if ( w(-2,"не") &&
      q(-1,"gl_pned gl_pnin gl_pnmn gl_poed deep_pn") && s(-2,-1) )
 { ret=stopp=1; D[865]++; if(dbg){print "D865"}; continue };

 if ( q(-2,"gl_pein gl_peed gl_pemn deep_pe prq_pe") && Q(-2,"suw_edim") &&
      q(-1,"suw_tv mest_tv") && s(-2,-1) )
 { ret=stopp=1; D[866]++; if(dbg){print "D866"}; continue };

 if ( qF(1,7,"suw_mnro","suw_edim") && sq(0,qFn-1,",") )
 { ret=stopp=1; D[867]++; if(dbg){print "D867"}; continue };
 if ( qB(-7,-1,"suw_mnro","suw_edim") && sq(qBn,-1,",") )
 { ret=stopp=1; D[868]++; if(dbg){print "D868"}; continue };


 #_#_#
 if (prex == 1) { pre_string = "prex_ro preph_ro" } else { pre_string ="pre_ro preph_ro" };
 if ( q(-2,pre_string) &&
     (q(-1,"prl_mnro prq_mnro mest_mnro qi_ed qi_mn")||wc(-1,"^[0-9]+$")) && s(-2,-1) )
 { ret=stopp=1; D[869]++; if(dbg){print "D869"}; continue };
 if ( Q(0,"gl_paedmu") && q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[870]++; if(dbg){print "D870"}; continue };
 if ( q(0,"gl_paedmu") && Q(-1,"nar_vrem") && q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[871]++; if(dbg){print "D871"}; continue };
 #_#_#

 if ( (q(-1,"preph_ro prl_mnro prq_mnro mest_mnro qi_ed qi_mn")||wc(-1,"^[0-9]+$")) && s(-1) )
 { ret=stopp=1; D[872]++; if(dbg){print "D872"}; continue };
 if ( (q(-3,"preph_ro prl_mnro prq_mnro mest_mnro qi_ed qi_mn")||wc(-3,"^[0-9]+$")) &&
  pre_tv(-2) &&
suw_edtv(-1) && s(-3,-1) )
 { ret=stopp=1; D[873]++; if(dbg){print "D873"}; continue };
 if ( (q(-2,"preph_ro prl_mnro prq_mnro mest_mnro qi_ed qi_mn")||wc(-1,"^[0-9]+$")) &&
       w(-1,"то") && sc(-2,"-") && s(-1) )
 { ret=stopp=1; D[874]++; if(dbg){print "D874"}; continue };

 #
 if ( w(1,"ещё еще эдак этак") &&
 pre_vi(2) &&
     (q(3,"qi_ed qi_mn")||wc(3,"^[0-9]+$")||w(3,"пару")) && s(0,2) )
 { ret=stopp=1; D[875]++; if(dbg){print "D875"}; continue };
 if ( w(1,"ещё еще эдак этак") &&
     (q(2,"qi_ed qi_mn")||wc(2,"^[0-9]+$")||w(2,"пару")) && s(0,1) )
 { ret=stopp=1; D[876]++; if(dbg){print "D876"}; continue };
 if ( pre_vi(1) &&
          (q(2,"qi_ed qi_mn")||wc(2,"^[0-9]+$")||w(2,"пару")) && s(0,1) )
 { ret=stopp=1; D[877]++; if(dbg){print "D877"}; continue };
 if ( (q(-1,"qi_ed qi_mn")||wc(-1,"^[0-9]+$")||w(-1,"пару")) && s(-1) )
 { ret=stopp=1; D[878]++; if(dbg){print "D878"}; continue };
 if ( Q(0,"gl_paedmu") &&
     (q(1,"qi_ed qi_mn")||wc(1,"^[0-9]+$")) && s(0) )
 { ret=stopp=1; D[879]++; if(dbg){print "D879"}; continue };
 if ( Q(0,"gl_paedmu") && vv(0,5) &&
     (q(vvn+1,"qi_ed qi_mn")||wc(vvn+1,"^[0-9]+$")) )
 { ret=stopp=1; D[880]++; if(dbg){print "D880"}; continue };
 #
 if ( sw_ro_f() )
 { ret=stopp=1; D[881]++; if(dbg){print "D881", "sw_ro_f"}; continue };
 if ( edro2mnvi )
 { ret=0; stopp=1; D[882]++; if(dbg){print "D882"}; continue };


break}; return ret }

function sw_mn_d_f(ret, stopp) { while ( !stopp ) {
 if ( sw_da_f() )
 { ret=stopp=1; D[883]++; if(dbg){print "D883", "sw_da_f"}; continue };
 #_#_#
 if (prex == 1) { pre_string = "prex_da preph_da" } else { pre_string ="pre_da preph_da" };
 if ( q(-2,pre_string) &&
      q(-1,"prl_mnda prq_mnda qin_da") && s(-2,-1) )
 { ret=stopp=1; D[884]++; if(dbg){print "D884"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[885]++; if(dbg){print "D885"}; continue };
 #_#_#

 if ( q(-1,"preph_da prl_mnda prq_mnda qin_da") && s(-1) )
 { ret=stopp=1; D[886]++; if(dbg){print "D886"}; continue };
break}; return ret }

function sw_mn_p_f(ret, stopp) { while ( !stopp ) {
 #_#_#
 if (prex == 1) { pre_string = "prex_pr" } else { pre_string ="pre_pr" };
 if ( q(-2,pre_string) &&
      q(-1,"prl_mnpr prq_mnpr qin_pr") && s(-2,-1) )
 { ret=stopp=1; D[887]++; if(dbg){print "D887"}; continue };
 if ( q(-1,pre_string) && s(-1) )
 { ret=stopp=1; D[888]++; if(dbg){print "D888"}; continue };
 #_#_#

break}; return ret }

function nar_vrem_f(ret, stopp) { while ( !stopp ) {
 cst="гораздо значительно лить намного только чуть";
 if ( w(-1,cst) && s(-1) )
 { ret=stopp=1; D[889]++; if(dbg){print "D889"}; continue };
 if ( q(-1,"gl_ed gl_mn gl_vzmn") && s(-1) && p(0) )
 { ret=stopp=1; D[890]++; if(dbg){print "D890"}; continue };
break}; return ret }

function pl_srav_f(ret, stopp) { while ( !stopp ) {
 if ( z(0) &&
      w(1,"чем") )
 { ret=stopp=1; D[891]++; if(dbg){print "D891"}; continue };
 if ( q(-1,"nar_step") && s(-1) && p(0))
 { ret=stopp=1; D[892]++; if(dbg){print "D892"}; continue };
 if ( bw(-1,"быть стать становиться оказаться") && s(-1) && p(0))
 { ret=stopp=1; D[893]++; if(dbg){print "D893"}; continue };
break}; return ret }

function pl_em_p_f(ret, stopp) { while ( !stopp ) {
 if ( qb(-4,-1,"pre_pr") &&
      qf(1,4,"suw_edmupr suw_edmume suw_edmune mest_edmupr") && s(qbn,qfn-1) &&
     qir(qbn+1,-1,"prl_edmupr mest_3e prq_edmupr") &&
     qir(1,qfn-1,"prl_edmupr mest_3e prq_edmupr") )
 { ret=stopp=1; D[894]++; if(dbg){print "D894"}; continue };
 if ( pre_pr(-1) && s(-1) && p(0))
 { ret=stopp=1; D[895]++; if(dbg){print "D895"}; continue };
break}; return ret }

function pl_es_p_f(ret, stopp) { while ( !stopp ) {
 if ( qb(-4,-1,"pre_pr") &&
      qf(1,4,"suw_edsrpr suw_edsrne") && s(qbn,qfn-1) &&
     qir(qbn+1,-1,"prl_edsrpr mest_3e prq_edsrpr mest_edsrpr") &&
     qir(1,qfn-1,"prl_edsrpr mest_3e prq_edsrpr") )
 { ret=stopp=1; D[896]++; if(dbg){print "D896"}; continue };
 if ( pre_pr(-1) && s(-1) && p(0))
 { ret=stopp=1; D[897]++; if(dbg){print "D897"}; continue };
break}; return ret }

function pl_em_i_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_im") &&
           suw_edmuim(1) && s(-1,0) )
 { ret=stopp=1; D[898]++; if(dbg){print "D898"}; continue };
 if ( qf(1,4,"suw_edmuim") && s(0,qfn) &&
     qir(1,qfn-1,"prl_edmuim mest_3e prq_edmuim") )
 { ret=stopp=1; D[899]++; if(dbg){print "D899"}; continue };
break}; return ret }

function pl_es_i_f(ret, stopp) { while ( !stopp ) {
 cst="самое";
 if ( w(-1,cst) &&
      q(1,"suw_edsrim mest_edsrim") && s(-1,0) )
 { ret=stopp=1; D[900]++; if(dbg){print "D900"}; continue };
 if ( q(-1,"pre_im") &&
           suw_edsrim(1) && s(-1,0) )
 { ret=stopp=1; D[901]++; if(dbg){print "D901"}; continue };
 if ( q(1,"prl_edsrim mest_edsrim prq_edsrim") &&
           suw_edsrim(2) && s(0,1) )
 { ret=stopp=1; D[902]++; if(dbg){print "D902"}; continue };
 if ( suw_edsrim(1) && s(0) )
 { ret=stopp=1; D[903]++; if(dbg){print "D903"}; continue };
 if ( q(-2,"prl_edsrim") &&
      q(-1,"sz_iili") && s(-2,-1) )
 { ret=stopp=1; D[904]++; if(dbg){print "D904"}; continue };
 if ( q(1,"sz_iili") &&
      q(2,"prl_edsrim") && s(0,1) )
 { ret=stopp=1; D[905]++; if(dbg){print "D905"}; continue };
break}; return ret }

function pl_em_v_f(ret, stopp) { while ( !stopp ) {
 if ( qf(1,4,"suw_edmuvi") && s(0,qfn-1) &&
     qir(1,qfn-1,"prl_edmuvi mest_3e mest_edmuvi prq_edmuvi") )
 { ret=stopp=1; D[906]++; if(dbg){print "D906"}; continue };
 if ( suw_edmuvi(1) && s(0) )
 { ret=stopp=1; D[907]++; if(dbg){print "D907"}; continue };
break}; return ret }

function pl_es_v_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_vi preph_vi") &&
           suw_edsrvi(1) && s(-1,0) )
 { ret=stopp=1; D[908]++; if(dbg){print "D908"}; continue };
 if ( suw_edsrvi(1) && s(0) )
 { ret=stopp=1; D[909]++; if(dbg){print "D909"}; continue };
break}; return ret }

function pl_ez_i_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_im") &&
         suw_edim(1) && s(-1,0) )
 { ret=stopp=1; D[910]++; if(dbg){print "D910"}; continue };
 if ( suw_edim(1) && s(0) )
 { ret=stopp=1; D[911]++; if(dbg){print "D911"}; continue };
break}; return ret }

function pl_ez_v_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_vi preph_vi") &&
         suw_edvi(1) && s(-1,0) )
 { ret=stopp=1; D[912]++; if(dbg){print "D912"}; continue };
 if ( suw_edvi(1) && s(0) )
 { ret=stopp=1; D[913]++; if(dbg){print "D913"}; continue };
break}; return ret }

function pl_ez_d_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_da preph_da") &&
         suw_edda(1) && s(-1,0) )
 { ret=stopp=1; D[914]++; if(dbg){print "D914"}; continue };
 if ( qf(1,4,"suw_edzeda") && s(0,qfn-1) &&
     qir(1,qfn-1,"prl_edzeda mest_3e prq_edzeda") )
 { ret=stopp=1; D[915]++; if(dbg){print "D915"}; continue };
break}; return ret }

function pl_ez_r_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_ro preph_ro") &&
           suw_edzero(1) && s(-1,0) )
 { ret=stopp=1; D[916]++; if(dbg){print "D916"}; continue };
 if ( q(-1,"prl_edzero prq_edzero") &&
           suw_edzero(1) && s(-1,0) )
 { ret=stopp=1; D[917]++; if(dbg){print "D917"}; continue };
 if ( qf(1,4,"suw_edzero") && s(0,qfn-1) &&
     qir(1,qfn-1,"prl_edzero mest_3e prq_edzero") )
 { ret=stopp=1; D[918]++; if(dbg){print "D918"}; continue };
break}; return ret }

function pl_ez_t_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_tv preph_tv") &&
         suw_edtv(1) && s(-1,0) )
 { ret=stopp=1; D[919]++; if(dbg){print "D919"}; continue };
 if ( qf(1,4,"suw_edzetv") && s(0,qfn-1) &&
     qir(1,qfn-1,"prl_edzetv mest_3e prq_edzetv") )
 { ret=stopp=1; D[920]++; if(dbg){print "D920"}; continue };
break}; return ret }

function pl_ez_p_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"pre_pr") &&
     qf(1,4,"suw_edzepr") && s(-1,qfn-1) &&
    qir(1,qfn-1,"prl_edzepr mest_3e prq_edzepr") )
 { ret=stopp=1; D[921]++; if(dbg){print "D921"}; continue };
break}; return ret }

function pl_kr_em_f(ret, stopp) { while ( !stopp ) {
 cst="будет буду будь был весьма настолько он очень сильно слишком стал станет стань столь так ты чересчур я";
 if ( (w(-2,cst)||(suw_mnim(-2) && Q(-2,"suw_edro"))) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[922]++; if(dbg){print "D922"}; continue };
 if ( (w(-1,cst)||(suw_mnim(-1) && Q(-1,"suw_edro prl_mnim"))) && s(-1) )
 { ret=stopp=1; D[923]++; if(dbg){print "D923"}; continue };

 if ( (w(-2,cst)||suw_edmuim(-2)) &&
            prl_kred_sr(-1) && s(-2,-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[924]++; if(dbg){print "D924"}; continue };
 if ( (w(-1,cst)||suw_edmuim(-1)) && s(-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[925]++; if(dbg){print "D925"}; continue };
 if ( w(-1,cst) && s(0) )
 { ret=stopp=1; D[926]++; if(dbg){print "D926"}; continue };
 if ( w(1,"был будь стань") && s(0) )
 { ret=stopp=1; D[927]++; if(dbg){print "D927"}; continue };
 if ( w(1,"ли") &&
           suw_edmuim(2) && s(0,1) )
 { ret=stopp=1; D[928]++; if(dbg){print "D928"}; continue };
 if ( prl_kred_sr(-1) && s(-1) && Q(0,"gl_bum3") )
 { ret=stopp=1; D[929]++; if(dbg){print "D929"}; continue };
 if ( q(-1,"suw_im") &&
      q(1,"suw_tv suw_ro") && s(-1,0) )
 { ret=stopp=1; D[930]++; if(dbg){print "D930"}; continue };
break}; return ret }

function pl_kr_es_f(ret, stopp) { while ( !stopp ) {
 cst="будет буду будь было весьма настолько оно очень самое сильно слишком стало станет стань столь так ты чересчур я";
 if ( (w(-2,cst)||(suw_mnim(-2) && Q(-2,"suw_edro"))) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[931]++; if(dbg){print "D931"}; continue };
 if ( (w(-1,cst)||(suw_mnim(-1) && Q(-1,"suw_edro prl_mnim"))) && s(-1) )
 { ret=stopp=1; D[932]++; if(dbg){print "D932"}; continue };

 if ( (w(-2,cst)||suw_edmuim(-2)) &&
            prl_kred_sr(-1) && s(-2,-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[933]++; if(dbg){print "D933"}; continue };
 if ( (w(-1,cst)||suw_edmuim(-1)) && s(-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[934]++; if(dbg){print "D934"}; continue };
 if ( w(-1,cst) && s(0) )
 { ret=stopp=1; D[935]++; if(dbg){print "D935"}; continue };
 if ( w(1,"был будь стань") && s(0) )
 { ret=stopp=1; D[936]++; if(dbg){print "D936"}; continue };
 if ( prl_kred_sr(-1) && s(-1) && Q(0,"gl_bum3") )
 { ret=stopp=1; D[937]++; if(dbg){print "D937"}; continue };
break}; return ret }

function pl_kr_ez_f(ret, stopp) { while ( !stopp ) {
 cst="будет буду будь была весьма настолько она очень сильно слишком стала станет стань столь так ты чересчур я";
 if ( (w(-2,cst)||(suw_mnim(-2) && Q(-2,"suw_edro"))) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[938]++; if(dbg){print "D938"}; continue };
 if ( (w(-1,cst)||(suw_mnim(-1) && Q(-1,"suw_edro prl_mnim"))) && s(-1) )
 { ret=stopp=1; D[939]++; if(dbg){print "D939"}; continue };

 if ( (w(-2,cst)||suw_edzeim(-2)) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[940]++; if(dbg){print "D940"}; continue };
 if ( (w(-2,cst)||suw_edzeim(-1)) &&
       w(-1,"же не ведь все-таки таки и") && s(-2,-1) )
 { ret=stopp=1; D[941]++; if(dbg){print "D941"}; continue };
 if ( (w(-1,cst)||suw_edzeim(-1)) && s(-1) )
 { ret=stopp=1; D[942]++; if(dbg){print "D942"}; continue };
 if ( prl_kred_sr(-1) && s(-1))
 { ret=stopp=1; D[943]++; if(dbg){print "D943"}; continue };
 if ( qast(1) &&
suw_edzeim(2) && s(0,1))
 { ret=stopp=1; D[944]++; if(dbg){print "D944"}; continue };
 if ( suw_edzeim(1) && s(0))
 { ret=stopp=1; D[945]++; if(dbg){print "D945"}; continue };
break}; return ret }

function pl_krmn_f(ret, stopp) { while ( !stopp ) {
 cst="будем будут будьте были весьма вы мы настолько они очень сильно слишком стали станем станут станьте столь чересчур";
 if ( (w(-2,cst)||(suw_mnim(-2) && Q(-2,"suw_edro"))) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[946]++; if(dbg){print "D946"}; continue };
 if ( (w(-1,cst)||(suw_mnim(-1) && Q(-1,"suw_edro prl_mnim"))) && s(-1) )
 { ret=stopp=1; D[947]++; if(dbg){print "D947"}; continue };

 if ( q(-2,"mest_mnim suw_mnim") &&
      q(-1,"nar_spos nar_step prl_kred_sr") && s(-1) )
 { ret=stopp=1; D[948]++; if(dbg){print "D948"}; continue };
 if ( suw_mnim(-1) && s(-1) && p(-2) && Q(-1,"prl_mnim") )
 { ret=stopp=1; D[949]++; if(dbg){print "D949"}; continue };
 if ( prl_kred_sr(-1) && s(-1))
 { ret=stopp=1; D[950]++; if(dbg){print "D950"}; continue };
break}; return ret }

function pq_kr_em_f(ret, stopp) { while ( !stopp ) {
 cst="буду будь был он стал стану ты я";
 if ( (w(-2,cst)||suw_edmuim(-2)) &&
            prl_kred_sr(-1) && s(-2,-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[951]++; if(dbg){print "D951"}; continue };
 if ( (w(-1,cst)||suw_edmuim(-1)) && s(-1) && (p(0)||q(1,"gl_in pre_any")) )
 { ret=stopp=1; D[952]++; if(dbg){print "D952"}; continue };
 if ( w(-1,cst) && s(0) )
 { ret=stopp=1; D[953]++; if(dbg){print "D953"}; continue };
 if ( w(1,"был будь") && s(0) )
 { ret=stopp=1; D[954]++; if(dbg){print "D954"}; continue };
 if ( prl_kred_sr(-1) && s(-1) && Q(0,"gl_bum3") )
 { ret=stopp=1; D[955]++; if(dbg){print "D955"}; continue };
break}; return ret }

function pq_kr_ez_f(ret, stopp) { while ( !stopp ) {
 if ( (w(-2,"я ты она была стала")||suw_edzeim(-2)) &&
            prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[956]++; if(dbg){print "D956"}; continue };
 if ( (w(-2,"я ты она была стала")||suw_edzeim(-1)) &&
       w(-1,"же не ведь все-таки таки и") && s(-2,-1) )
 { ret=stopp=1; D[957]++; if(dbg){print "D957"}; continue };
 if ( (w(-1,"я ты она была стала")||suw_edzeim(-1)) && s(-1) )
 { ret=stopp=1; D[958]++; if(dbg){print "D958"}; continue };
 if ( prl_kred_sr(-1) && s(-1))
 { ret=stopp=1; D[959]++; if(dbg){print "D959"}; continue };
break}; return ret }

function pq_krmn_f(ret, stopp) { while ( !stopp ) {
 if ( q(-2,"mest_mnim suw_mnim") &&
      q(-1,"nar_spos nar_step prl_kred_sr") && s(-1) )
 { ret=stopp=1; D[960]++; if(dbg){print "D960"}; continue };
 if ( suw_mnim(-1) && s(-1) && p(-2) )
 { ret=stopp=1; D[961]++; if(dbg){print "D961"}; continue };
 if ( prl_kred_sr(-1) && s(-1))
 { ret=stopp=1; D[962]++; if(dbg){print "D962"}; continue };
break}; return ret }

function gl_inf_f(ret, stopp) { while ( !stopp ) {
 if ( q(-1,"mod_ed mod_mn mod_bz") && s(-1) )
 { ret=stopp=1; D[963]++; if(dbg){print "D963"}; continue };
 #
 if ( !( q(-1,"pre_da pre_im pre_vi pre_ro pre_pr") && s(-1)) &&
         q(1,"suw_vi mest_vi") && s(0) )
 { ret=stopp=1; D[964]++; if(dbg){print "D964"}; continue };
 #
 if ( !( q(-1,"pre_any") && s(-1)) &&
         q(1,"prl_vi prq_vi mest_vi pre_vi") &&
         q(2,"suw_vi mest_vi") && s(0,1) )
 { ret=stopp=1; D[965]++; if(dbg){print "D965"}; continue };
 if ( Qw_(-1,"pre_any") &&
        q(1,"nar_step") &&
        q(2,"prl_vi prq_vi mest_vi pre_vi") &&
        q(3,"suw_vi mest_vi") && s(0,2) )
 { ret=stopp=1; D[966]++; if(dbg){print "D966"}; continue };
 if ( q(-2,"suw_im") &&
      q(-1,"mest_da suw_da") && s(-2,-1) )
 { ret=stopp=1; D[967]++; if(dbg){print "D967"}; continue };
break}; return ret }

function gl_poed_f(ret, stopp) { while ( !stopp ) {

 if ( p(-1) && q(0,"gl_popeed gl_popned") && W(0,"реки") &&
      q(1,"mest_vi suw_vi") && s(0) )
 { ret=stopp=1; D[968]++; if(dbg){print "D968"}; continue };
 if ( p(-2) && w(-1,"не") && s(-1) && p(0) )
 { ret=stopp=1; D[969]++; if(dbg){print "D969"}; continue };
 if ( q(-3,"gl_poed") &&
      w(-2,"и") &&
      w(-1,"не") && s(-3,-1) )
 { ret=stopp=1; D[970]++; if(dbg){print "D970"}; continue };
 if ( p(-1) &&
      q(1,"suw_im") && sc(1,"!") )
 { ret=stopp=1; D[971]++; if(dbg){print "D971"}; continue };
 if ( p(-1) && gl_popeed(0) && Q(0,"gl_nemn") &&
 pre_vi(1) &&
      q(2,"suw_vi") &&
      q(3,"suw_vi") && s(0,2))
 { ret=stopp=1; D[972]++; if(dbg){print "D972"}; continue };
break}; return ret }

function gl_paedmu_f(ret, stopp) { while ( !stopp ) {
 if ( (w(-2,"я ты он")||suw_edmuim(-2)) &&
       q(-1,"nar_spos prl_kred_sr") && Q(-2,"prl_edmuim") && s(-2,-1) )
 { ret=stopp=1; D[973]++; if(dbg){print "D973"}; continue };
 if ( (w(-3,"я ты он")||suw_edmuim(-2)) &&
       q(-2,"nar_spos nar_vrem prl_kred_sr") &&
       q(-1,"nar_spos nar_vrem prl_kred_sr") && Q(-2,"prl_edmuim") && s(-2,-1) )
 { ret=stopp=1; D[974]++; if(dbg){print "D974"}; continue };
 #
 if ( q(-2,"gl_paedmu") && q(-1,"sz_iili") && s(-2,-1) )
 { ret=stopp=1; D[975]++; if(dbg){print "D975"}; continue };
 if ( q(2,"gl_paedmu") && q(1,"sz_iili") && s(0,1) )
 { ret=stopp=1; D[976]++; if(dbg){print "D976"}; continue };
 if ( q(-1,"gl_paedmu") && z(-1) )
 { ret=stopp=1; D[977]++; if(dbg){print "D977"}; continue };
 if ( q(1,"gl_paedmu") && z(0) )
 { ret=stopp=1; D[978]++; if(dbg){print "D978"}; continue };
 #
 if ( qb(-5,-2,"pre_da") && s(qbn-1,-1) && q(-1,"sz_iili") &&
       q(qbn-1,"gl_paedmu") &&
     qir(qbn+1,-2,"suw_da prl_da mest_da mest_3e suw_ro") )
 { ret=stopp=1; D[979]++; if(dbg){print "D979"}; continue };
 if ( qf(-6,-2,"pre_pr") &&
      qb(qfn-5,qfn-2,"pre_da") && s(qbn-1,-1) && q(-1,"sz_iili") &&
       q(qbn-1,"gl_paedmu") &&
     qir(qbn+1,qfn-1,"suw_da prl_da mest_da mest_3e suw_ro") &&
     qir(qfn+1,-2,"suw_pr prl_pr mest_pr mest_3e suw_ro") )
 { ret=stopp=1; D[980]++; if(dbg){print "D980"}; continue };
 #
 if ( w(-1,"я ты он") && s(-1) &&
    !(s(-2) && q(-2,"gl_peed gl_pemn") ) )
 { ret=stopp=1; D[981]++; if(dbg){print "D981"}; continue };
 #
 if ( q(-1,"suw_edmuim prl_kred_sr") && Q(-1,"prl_edmuim") && s(-1) &&
   !(qb(-4,-2,"gl_peed gl_pemn gl_in") && s(qbn,-2) ) )
 { ret=stopp=1; D[982]++; if(dbg){print "D982"}; continue };
 #
 if ( q(-1,"sz_iili") && qb(-5,-2,"gl_paedmu") && s(qbn,-1) &&
    qir(qbn+1,-2,"nam_edmuim suw_edmuim mest_edmuim nar_mest nar_spos nar_step nar_vrem") )
 { ret=stopp=1; D[983]++; if(dbg){print "D983"}; continue };
 if ( q(1,"sz_iili") && qf(2,5,"gl_paedmu") && s(0,qfn-1) &&
    qir(2,qfn-1,"nam_edmuim suw_edmuim mest_edmuim nar_mest nar_spos nar_step nar_vrem") )
 { ret=stopp=1; D[984]++; if(dbg){print "D984"}; continue };
 if ( z(0) && qf(1,5,"gl_paedmu") && s(2,qfn-1) && Q(-1,"prl_edmuim mest_edmuim prq_edmuim") &&
    qir(1,qbn-1,"nam_edmuim suw_edmuim mest_edmuim nar_mest nar_spos nar_step nar_vrem") )
 { ret=stopp=1; D[985]++; if(dbg){print "D985"}; continue };
 #
 if ( (w(1,"я ты он")||q(1,"suw_edmuim prl_kred_sr")) && Q(1,"prl_edmuim") && s(0) )
 { ret=stopp=1; D[986]++; if(dbg){print "D986"}; continue };
break}; return ret }

function gl_paedsr_f(ret, stopp) { while ( !stopp ) {
 if ( q(-2,"mest_it suw_edsrim") &&
      q(-1,"nar_spos prl_kred_sr") && s(-2,-1) )
 { ret=stopp=1; D[987]++; if(dbg){print "D987"}; continue };
 if ( q(-1,"mest_it suw_edsrim") &&
      q(1,"nar_spos prl_kred_sr") && s(-1,0) && Q_w(2,"gl_in") )
 { ret=stopp=1; D[988]++; if(dbg){print "D988"}; continue };
 #
 if ( q(1,"mest_it suw_edsrim") &&
      q(2,"prl_kred_sr gl_in") && s(0,1) )
 { ret=stopp=1; D[989]++; if(dbg){print "D989"}; continue };
 if ( q(1,"prl_kred_sr") && p(-1) && p(1) )
 { ret=stopp=1; D[990]++; if(dbg){print "D990"}; continue };
 #
 if ( q(1,"mest_it suw_edsrim") && s(0) )
 { ret=stopp=1; D[991]++; if(dbg){print "D991"}; continue };
 #
 if ( q(-1,"suw_edsrim mest_it prl_kred_sr gl_in") && s(-1) )
 { ret=stopp=1; D[992]++; if(dbg){print "D992"}; continue };
 if ( qb(-6,-2,"gl_paedsr") &&
 sz_iili(-1) && s(-1) )
 { ret=stopp=1; D[993]++; if(dbg){print "D993"}; continue };
break}; return ret }

function gl_pamn_f(ret, stopp) { while ( !stopp ) {
 #
 if ( (suw_mnim(-2)||w(-2,"мы вы они")) &&
    prl_kred_sr(-1) && s(-2,-1) )
 { ret=stopp=1; D[994]++; if(dbg){print "D994"}; continue };
 if ( gl_nemn(0) &&
            q(-5,"pre_vi preph_vi") &&
            q(-4,"prl_vi prq_vi") &&
            q(-3,"suw_vi") &&
       pre_tv(-2) &&
            q(-1,"suw_tv") &&
            q(1,"prl_im") &&
            q(2,"suw_im") && s(-5,1) )
 { ret=stopp=1; D[995]++; if(dbg){print "D995"}; continue };
 #
 if ( (suw_mnim(-1)||w(-1,"мы вы они")) && s(-1) )
 { ret=stopp=1; D[996]++; if(dbg){print "D996"}; continue };
break}; return ret }

function gl_pomn_f(ret, stopp) { while ( !stopp ) {
 #
 if ( mn2e2pomn )
 { ret=stopp=1; D[997]++; if(dbg){print "D997"}; continue };
 if ( p(-1) && p(0) && W(0,"шутите гоните"))
 { ret=stopp=1; D[998]++; if(dbg){print "D998"}; continue };
 if ( w(1,"же") && s(0) && p(-1) && p(1) )
 { ret=stopp=1; D[999]++; if(dbg){print "D999"}; continue };
 if ( q(1,"mest_3e") && s(0) && p(-1) && p(1) )
 { ret=stopp=1; D[1000]++; if(dbg){print "D1000"}; continue };
 cst="пожалуйста прошу";
 if ( w(-1,cst) && z(-1) && p(-2) )
 { ret=stopp=1; D[1001]++; if(dbg){print "D1001"}; continue };
 cst="просто сначала сперва";
 if ( w(-1,cst) && s(-1) && p(-2) )
 { ret=stopp=1; D[1002]++; if(dbg){print "D1002"}; continue };
 #
 if ( sos(-9,-1) && qb(son+1,-1,"gl_po") && !isomo(qbn) )
 { ret=stopp=1; D[1003]++; if(dbg){print "D1003"}; continue };
 if ( eos(1,9) && qf(1,eon,"gl_po") && !isomo(qfn) )
 { ret=stopp=1; D[1004]++; if(dbg){print "D1004"}; continue };
 if ( q(-4,"gl_poed gl_pomn gl_povzmn") &&
      w(-3,"что") &&
      q(-2,"gl_ed gl_nemn gl_vzmn gl_pemn gl_pnmn") &&
      w(-1,"и") && s(-4,-1) )
 { ret=stopp=1; D[1005]++; if(dbg){print "D1005"}; continue };
 #
 if ( w(-2,"так") &&
      w(-1,"что вот") && s(-2,-1) )
 { ret=stopp=1; D[1006]++; if(dbg){print "D1006"}; continue };
break}; return ret }

function gl_ed1e_f(ret, stopp) { while ( !stopp ) {
 #
 if ( w(-3,"я") &&
   qast(-2) &&
      q(-1,"prl_kred_sr nar_mest nar_spos") &&
      q(1,"suw_vi pre_any") && s(-3,0) )
 { ret=stopp=1; D[1007]++; if(dbg){print "D1007"}; continue };
 if ( w(-2,"я") &&
      q(-1,"prl_kred_sr nar_mest nar_spos") &&
      q(1,"suw_vi pre_any") && s(-2,0) )
 { ret=stopp=1; D[1008]++; if(dbg){print "D1008"}; continue };
 if ( w(-1,"я") &&
      q(1,"prl_kred_sr nar_mest nar_spos") &&
      q(2,"suw_vi pre_any") && s(-1,1) )
 { ret=stopp=1; D[1009]++; if(dbg){print "D1009"}; continue };
 if ( w(-1,"я") &&
      q(1,"suw_vi nar_napr nar_spos gl_in pre_any") && s(-1,0) )
 { ret=stopp=1; D[1010]++; if(dbg){print "D1010"}; continue };
 if ( w(-2,"я") &&
   qast(-1) && s(-2,-1) )
 { ret=stopp=1; D[1011]++; if(dbg){print "D1011"}; continue };
 if ( w(-1,"я") && s(-1) )
 { ret=stopp=1; D[1012]++; if(dbg){print "D1012"}; continue };
break}; return ret }

function gl_ed3e_f(ret, stopp) { while ( !stopp ) {
 #
 if ( (w(-2,"он она оно")||q(-2,"suw_edim mest_it")) &&
       q(-1,"prl_kred_sr nar_mest nar_spos") &&
       q(1,"suw_vi pre_any") && s(-2,0) )
 { ret=stopp=1; D[1013]++; if(dbg){print "D1013"}; continue };
 if ( (w(-2,"он она оно")||q(-2,"suw_edim mest_it")) &&
       q(1,"prl_kred_sr nar_mest nar_spos") &&
       q(2,"suw_vi pre_any") && s(-1,1) )
 { ret=stopp=1; D[1014]++; if(dbg){print "D1014"}; continue };
 if ( (w(-2,"он она оно")||q(-2,"suw_edim mest_it")) &&
       q(1,"suw_vi nar_napr nar_spos gl_in pre_any") && s(-1,0) )
 { ret=stopp=1; D[1015]++; if(dbg){print "D1015"}; continue };
 if ( (w(-1,"он она оно который")||q(-1,"suw_edim mest_it")) && s(-1) )
 { ret=stopp=1; D[1016]++; if(dbg){print "D1016"}; continue };
break}; return ret }

function gl_paedze_f(ret, stopp) { while ( !stopp ) {
 #
 if ( wb(-5,-1,"я ты вы она") && s(wbn,-1) )
 { ret=stopp=1; D[1017]++; if(dbg){print "D1017"}; continue };
 #
 if ( q(-2,"gl_paedze") && q(-1,"sz_iili") && s(-2,-1) )
 { ret=stopp=1; D[1018]++; if(dbg){print "D1018"}; continue };
 if ( q(2,"gl_paedze") && q(1,"sz_iili") && s(0,1) )
 { ret=stopp=1; D[1019]++; if(dbg){print "D1019"}; continue };
 if ( q(-1,"gl_paedze") && z(-1) )
 { ret=stopp=1; D[1020]++; if(dbg){print "D1020"}; continue };
 if ( q(1,"gl_paedze") && z(0) )
 { ret=stopp=1; D[1021]++; if(dbg){print "D1021"}; continue };
 #
 if ( qb(-5,-2,"pre_da") && s(qbn-1,-1) && q(-1,"sz_iili") &&
       q(qbn-1,"gl_paedze") &&
     qir(qbn+1,-2,"suw_da prl_da mest_da mest_3e suw_ro") )
 { ret=stopp=1; D[1022]++; if(dbg){print "D1022"}; continue };
 if ( qf(-6,-2,"pre_pr") &&
      qb(qfn-5,qfn-2,"pre_da") && s(qbn-1,-1) && q(-1,"sz_iili") &&
       q(qbn-1,"gl_paedze") &&
     qir(qbn+1,qfn-1,"suw_da prl_da mest_da mest_3e suw_ro") &&
     qir(qfn+1,-2,"suw_pr prl_pr mest_pr mest_3e suw_ro") )
 { ret=stopp=1; D[1023]++; if(dbg){print "D1023"}; continue };
 #
 if ( qb(-5,-1,"suw_edzeim") && s(qbn,-1) )
 { ret=stopp=1; D[1024]++; if(dbg){print "D1024"}; continue };
 if ( suw_edzeim(-3) && s(-3) &&
           gl_ed(-2) && z(-2) &&
               w(-1,"что как") && s(-1) )
 { ret=stopp=1; D[1025]++; if(dbg){print "D1025"}; continue };
break}; return ret }

function gl_mn1e_f(ret, stopp) { while ( !stopp ) {
 #
 if ( wb(-5,-1,"мы если когда коли куда") && s(wbn,-1) )
 { ret=stopp=1; D[1026]++; if(dbg){print "D1026"}; continue };
 #
 if ( p(-1) && p(0) )
 { ret=stopp=1; D[1027]++; if(dbg){print "D1027"}; continue };
break}; return ret }

function gl_mn3e_f(ret, stopp) { while ( !stopp ) {
 #
 if ( (q(-1,"suw_mnim muk_mnim otsz_mnim")||w(-1,"они")) && s(wbn,-1) )
 { ret=stopp=1; D[1028]++; if(dbg){print "D1028"}; continue };
 #
 if ( p(-1) && p(0) )
 { ret=stopp=1; D[1029]++; if(dbg){print "D1029"}; continue };
break}; return ret }

function gl_mn2e_f(ret, stopp) { while ( !stopp ) {
 #
 if ( qxs(-1,"так","что вот") )
 { ret=0; stopp=1; mn2e2pomn=1; D[1030]++; if(dbg){print "D1030"}; continue };
 if ( w(-2,"а да") &&
      w(-1,"вы") && s(-2,-1) && Q_w(1,"mest_da suw_da") &&
      W(0,"шутите гоните"))
 { ret=0; stopp=1; mn2e2pomn=1; D[1031]++; if(dbg){print "D1031"}; continue };
 if ( w(-2,"вы") &&
      w(-1,"только лучше") && s(-2,-1) )
 { ret=0; stopp=1; mn2e2pomn=1; D[1032]++; if(dbg){print "D1032"}; continue };
 if ( w(-3,"вы") &&
      q(-2,"mest_vi suw_vi") &&
      w(-1,"не") && s(-3,-1) && p(0,"?") )
 { ret=0; stopp=1; mn2e2pomn=1; D[1033]++; if(dbg){print "D1033"}; continue };

 #
 if ( wb(-5,-1,"будто где если зачем когда коли которого которую которые который которых куда насколько небось откуда пока почему пошто сколько что") &&
      (q(wbn-1,"sz qast")||p(wbn-1)||sc(wbn-1,"[pv]")) && s(wbn,-1) )
 { ret=stopp=1; D[1034]++; if(dbg){print "D1034"}; continue };
 #
 if ( wb(-5,-2,"как") &&
       w(wbn-1,"бы долго же") && s(wbn,-1) )
 { ret=stopp=1; D[1035]++; if(dbg){print "D1035"}; continue };
 #
 if ( wb(-5,-1,"вы") && s(wbn,-1) )
 { ret=stopp=1; D[1036]++; if(dbg){print "D1036"}; continue };
 if ( vvb(-5,-1) &&
        w(vvn,"вы") && Ww_(vvn-1,"а") )
 { ret=stopp=1; D[1037]++; if(dbg){print "D1037"}; continue };
 if ( vvb(-5,-1) &&
       wb(vvn-5,vvn,"вы") && s(wbn,vvn-1) )
 { ret=stopp=1; D[1038]++; if(dbg){print "D1038"}; continue };
 #
 if ( sc(0,"?") )
 { ret=stopp=1; D[1039]++; if(dbg){print "D1039"}; continue };
 #
 if ( z(0) &&
      q(1,"mod_mn") &&
      w(2,"не") &&
      q(3,"gl_in") && s(1,2) )
 { ret=stopp=1; D[1040]++; if(dbg){print "D1040"}; continue };
#if ( z(0) &&
#      w(1,"не") &&
#       q(2,"gl_povzmn") && s(1) )
#{ ret=stopp=1; D[1041]++; if(dbg){print "D1041"}; continue };
break}; return ret }

function nar_spos_f(ret, stopp) { while ( !stopp ) {
 #
 if ( p(-1) &&
      q(1,"gl_mn gl_vzmn") &&
      q(2,"mest_mnim suw_mnim") && s(0,1) )
 { ret=stopp=1; D[1042]++; if(dbg){print "D1042"}; continue };
 #
 if ( p(-2) &&
      q(-1,"gl_mn gl_vzmn") &&
      q(1,"mest_mnim suw_mnim") && s(-1,0) )
 { ret=stopp=1; D[1043]++; if(dbg){print "D1043"}; continue };
 #
 if ( p(-3) &&
      q(-2,"gl_mn gl_vzmn") &&
      q(-1,"mest_mnim suw_mnim") && s(-2,-1) )
 { ret=stopp=1; D[1044]++; if(dbg){print "D1044"}; continue };

break}; return ret }

