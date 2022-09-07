###   x4709 !_#_! ==> palate_    sky_    небо  нёбо  не́бо
 #    небо неба небу небом небе
function x4709_f() {

xgrp="x4709";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 # очистка переменных

#if ( q(-1,"prl_edsrim") )
#{ print l[i-1] >> "_prl_a.txt"; X[1]++; if(dbg){print "X1"}; }; continue


#if ( bfa(1,7,"_palatelike_things")   ) { Y["n+_palatelike_things"]  = bfn; Y["w+_palatelike_things"]  = BFn; };
#if ( bba(-6,-1,"_palatelike_things") ) { Y["n-_palatelike_things"]  = bbn; Y["w-_palatelike_things"]  = BBn; };
#if ( bba(-6,-1,"_palate_environs")   ) { Y["n-_palate_environs"]    = bbn; Y["w-_palate_environs"]    = BBn; };
#if ( bfa(1,6,"_palate_environs")     ) { Y["n+_palate_environs"]    = bfn; Y["w+_palate_environs"]    = BFn; };
#if ( bba(-6,-1,"_skylike_things")   ) { Y["n-_skylike_things"]    = bbn; Y["w-_skylike_things"]    = BBn; };
#if ( bfa(1,6,"_skylike_things")     ) { Y["n+_skylike_things"]    = bfn; Y["w+_skylike_things"]    = BFn; };
#if ( bba(-6,-1,"_sky_parts")        ) { Y["n-_sky_parts"]         = bbn; Y["w-_sky_parts"]         = BBn; };
#if ( bfa(1,6,"_sky_parts")          ) { Y["n+_sky_parts"]         = bfn; Y["w+_sky_parts"]         = BFn; };

 if ( iwrd=="небо" )  { Y["iwrd_case"]="iv"; Y["iwrd_form"]="ediv"; if(dbg){print "небо: им+вин, ед+мн"};

   cst="в во за на о по под подо через";
   if ( wb(-8,-1,cst) ) { qb_n=wbn;

     if ( wb(-8,-1,"в во")   )  { Y["n_pre_v_ist"]     = wbn; sw="в"     };
     if ( wb(-8,-1,"на")     )  { Y["n_pre_na_ist"]    = wbn; sw="на"    };
     if ( wb(-5,-1,"за")     )  { Y["n_pre_za_ist"]    = wbn; sw="за"    };
     if ( wb(-5,-1,"под подо")) { Y["n_pre_pod_ist"]   = wbn; sw="под"   };
     if ( wb(-5,-1,"о")      )  { Y["n_pre_o_ist"]     = wbn; sw="о"     };
     if ( wb(-5,-1,"по")     )  { Y["n_pre_po_ist"]    = wbn; sw="по"    };
     if ( wb(-5,-1,"через")  )  { Y["n_pre_qerez_ist"] = wbn; sw="через" };

     if ( vex(Y["n_pre_v_ist"])  ) {
       DEF_TN_PREVI_NEBO(Y["n_pre_v_ist"],"в во"); Y["n_pre_v"] = tn; Y["tn_ok_v"] = Y["tn_ok_vi"] = Y["tn_ok_any"] = tn_ok ; # TN_v_nebo_f()
       if ( vex(Y["tn_ok_v"]) ) { tn=Y["n_pre_v"];

#         if ( qb(tn-9,tn-1,"gl_ed gl_mn gl_in") && s(qbn,tn-1) )
#         { getBF(qbn,"gl_in","_gl_v.txt"); X[2]++; if(dbg){print "X2"}; }; continue

          if ( bba(tn-9,tn-1,"_gl_v_palate-iv")  ) { Y["n-_gl_v_palate-iv"]  = bbn; Y["w-_gl_v_palate-iv"]  = BBn; };
          if ( bba(tn-9,tn-1,"_gl_v_sky-iv")    ) { Y["n-_gl_v_sky-iv"]    = bbn; Y["w-_gl_v_sky-iv"]    = BBn; };
          if ( bba(tn-6,tn-1,"_suw_v_palate-vp") ) { Y["n-_suw_v_palate-vp"] = bbn; Y["w-_suw_v_palate-vp"] = BBn; }; };

     }; #

     if ( vex(Y["n_pre_na_ist"])    ) {
       DEF_TN_PREVI_NEBO(Y["n_pre_na_ist"],"на"); Y["n_pre_na"] = tn; Y["tn_ok_na"] = Y["tn_ok_vi"] = Y["tn_ok_any"] = tn_ok ; # TN_na_nebo_f()
       if ( vex(Y["tn_ok_na"]) ) { tn=Y["n_pre_na"];

          if ( bba(tn-7,tn-1,"_gl_na_palate")  ) { Y["n-_gl_na_palate"]  = bbn; Y["w-_gl_na_palate"]  = BBn; };
          if ( bba(tn-7,tn-1,"_gl_na_sky")    ) { Y["n-_gl_na_sky"]    = bbn; Y["w-_gl_na_sky"]    = BBn; };
          if ( bba(tn-5,tn-1,"_suw_na_palate") ) { Y["n-_suw_na_palate"] = bbn; Y["w-_suw_na_palate"] = BBn; };
          if ( bba(tn-5,tn-1,"_suw_na_sky") )   { Y["n-_suw_na_sky"]   = bbn; Y["w-_suw_na_sky"]   = BBn; }; };

       }; #

     # определить, прикреплен ли к омографу предлог
#    if ( vex(Y["n_pre_za_ist"])    ) { DEF_TN_PREVI_NEBO(Y["n_pre_za_ist"],   "за");    Y["n_pre_za"]   =tn; Y["tn_ok_za"]   =Y["tn_ok_vi"]=Y["tn_ok_any"]=tn_ok }; # TN_za_nebo_f()
#    if ( vex(Y["n_pre_pod_ist"])   ) { DEF_TN_PREVI_NEBO(Y["n_pre_pod_ist"],  "под");   Y["n_pre_pod"]  =tn; Y["tn_ok_pod"]  =Y["tn_ok_vi"]=Y["tn_ok_any"]=tn_ok }; # TN_pod_nebo_f()
#      if ( vex(Y["tn_ok_pod"]) ) { tn=Y["n_pre_pod"];
#         if ( bba(tn-7,tn-1,"_gl_pod_palate")  ) { Y["n-_gl_pod_palate"]  = bbn; Y["w-_gl_pod_palate"]  = BBn; };
#         if ( bba(tn-7,tn-1,"_gl_pod_sky")    ) { Y["n-_gl_pod_sky"]    = bbn; Y["w-_gl_pod_sky"]    = BBn; }; };
#    if ( vex(Y["n_pre_o_ist"])     ) { DEF_TN_PREVI_NEBO(Y["n_pre_o_ist"],    "о");     Y["n_pre_o"]    =tn; Y["tn_ok_o"]    =Y["tn_ok_vi"]=Y["tn_ok_any"]=tn_ok }; # TN_o_nebo_f()
#    if ( vex(Y["n_pre_po_ist"])    ) { DEF_TN_PREVI_NEBO(Y["n_pre_po_ist"],   "по");    Y["n_pre_po"]   =tn; Y["tn_ok_po"]   =Y["tn_ok_vi"]=Y["tn_ok_any"]=tn_ok }; # TN_po_nebo_f()
#    if ( vex(Y["n_pre_qerez_ist"]) ) { DEF_TN_PREVI_NEBO(Y["n_pre_qerez_ist"],"через"); Y["n_pre_qerez"]=tn; Y["tn_ok_qerez"]=Y["tn_ok_vi"]=Y["tn_ok_any"]=tn_ok }; # TN_qerez_nebo_f()
  }; #<== pre_vi

    bba(-7,-1,"_sky_pe");   Y["n-_sky_pe"]    = bbn; Y["w-_sky_pe"]           = BBn;
    bfa(1,6,  "_sky_pe");   Y["n+_sky_pe"]    = bfn; Y["w+_sky_pe"]           = BFn;
#   bba(-7,-1,"_palate_pe"); Y["n-_palate_pe"]  = bb_n = bbn; Y["w-_palate_pe"]  = BBn;
#      if ( wa(bb_n,"X_suw_palate_pe") ) { bba(-7,bb_n-1,"_palate_pe"); Y["n-_palate_pe"] = bbn; Y["w-_palate_pe"] = BBn };
#   bfa(1,6,  "_palate_pe"); Y["n+_palate_pe"]  = bfn; Y["w+_palate_pe"]         = BFn;
#   bba(-7,-1,"_gl_nebo");  Y["n-_gl_nebo"]   = bbn; Y["w-_gl_nebo"]          = BBn;
#   bfa(1,6,  "_gl_nebo");  Y["n+_gl_nebo"]   = bf_n = bfn; Y["w+_gl_nebo"]   = BFn;
#      if ( vex(Y["n+_gl_nebo"]) && q(bf_n,"mod_any") ) { if ( s(0,bf_n-1) && bfa(bf_n+1,6,"_gl_nebo") && q(bfn,"gl_in prq_kred_sr prq_krmn") && s(bf_n,bfn-1) )
#      { Y["n+_gl_nebo"] = bfn; Y["w+_gl_nebo"] = BFn }; };
#      cst="казаться оказаться считаться являться";
#      if ( vex(Y["n+_gl_nebo"]) && weq(Y["w+_gl_nebo"],cst) ) { if ( s(0,bf_n-1) && bfa(bf_n+1,6,"_gl_nebo") && q(bfn,"prq_tv") && s(bf_n,bfn-1) )
#      { Y["n+_gl_nebo"] = bfn; Y["w+_gl_nebo"] = BFn }; };


#if ( vex(Y["tn_ok_v"]) && wf(1,4,"на") && s(0,wfn-1) )
#{ print book[b] >> "_vna.txt"; X[3]++; if(dbg){print "X3"}; }; continue

    # pointesque <<-- складываем сюда исключения или случаи с опорными словами
    if ( FN_nebo_vi_esc_f(0) )
    { X[4]++; if(dbg){print "X4", "-- is_escape!"}; continue };
    # pointesque

 };
 #
 if (iwrd=="неба" ) { Y["iwrd_case"]="ro"; Y["iwrd_form"]="edro"; if(dbg){print "небо: ро, ед+мн"};
   # определить, прикреплен ли к омографу предлог
   cst="внутри вокруг до из изо от ото у";
   if ( wb(-5,-1,cst) ) { qb_n=Y["n-_pre_ro"]=wbn; Y["w-_pre_ro"]=WBn;
     if ( wb(-5,-1,"до") ) { DEF_TN_PRERO_NEBA(wbn,"до"); Y["n_pre_do"] = tn; Y["tn_ok_do"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_do_neba_f()
     if ( vex(Y["tn_ok_do"]) ) { tn=Y["n_pre_do"];
        if ( bba(tn-9,tn-1,"_gl_do_palate-ro")  ) { Y["n-_gl_do_palate-ro"]  = bbn }; };

     if ( wb(-5,-1,"от ото") ) { DEF_TN_PRERO_NEBA(wbn,"от"); Y["n_pre_ot"] = tn; Y["tn_ok_ot"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_ot_neba_f()
     if ( vex(Y["tn_ok_ot"]) ) { tn=Y["n_pre_ot"];
        if ( bba(tn-9,tn-1,"_gl_ot_palate-ro")  ) { Y["n-_gl_ot_palate-ro"]  = bbn }; };

     if ( wb(-5,-1,"из изо") ) { DEF_TN_PRERO_NEBA(wbn,"из"); Y["n_pre_iz"] = tn; Y["tn_ok_iz"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_iz_neba_f()
     if ( vex(Y["tn_ok_iz"]) ) { tn=Y["n_pre_iz"];
        if ( bba(tn-9,tn-1,"_gl_iz_palate-ro")  ) { Y["n-_gl_iz_palate-ro"]  = bbn }; };

     if ( wb(-5,-1,"внутри") ) { DEF_TN_PRERO_NEBA(wbn,"внутри"); Y["n_pre_vnutri"] = tn; Y["tn_ok_vnutri"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_vnutri_neba_f()
     if ( vex(Y["tn_ok_vnutri"]) ) { tn=Y["n_pre_vnutri"];
        if ( bba(tn-5,tn-1,"_suw_vnutri_palate-ro")  ) { Y["n-_suw_vnutri_palate-ro"]  = bbn }; };

     if ( wb(-5,-1,"вокруг") ) { DEF_TN_PRERO_NEBA(wbn,"вокруг"); Y["n_pre_vokrug"] = tn; Y["tn_ok_vokrug"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_vokrug_neba_f()
     if ( vex(Y["tn_ok_vokrug"]) ) { tn=Y["n_pre_vokrug"];
        if ( bba(tn-5,tn-1,"_suw_vokrug_palate-ro")  ) { Y["n-_suw_vokrug_palate-ro"]  = bbn }; };

     if ( wb(-5,-1,"у") ) { DEF_TN_PRERO_NEBA(wbn,"у"); Y["n_pre_u"] = tn; Y["tn_ok_u"]=Y["tn_ok_ro"]=Y["tn_ok_any"]=tn_ok }; # TN_u_neba_f()
     if ( vex(Y["tn_ok_u"]) ) { tn=Y["n_pre_u"];
        if ( bba(tn-5,tn-1,"_suw_u_palate-ro")  ) { Y["n-_suw_u_palate-ro"] = bbn }; };
    };

    # hwro
    if ( bba(-5,-1,"_hw_palate-ro") ) { Y["n-_hw_palate-ro"] = bbn; Y["w-_hw_palate-ro"] = BBn; };
    if ( bba(-5,-1,"_hw_sky-ro") )   { Y["n-_hw_sky-ro"]   = bbn; Y["w-_hw_sky-ro"]   = BBn; };

   };
 if (iwrd=="небу" )  { Y["iwrd_case"]="da"; if(dbg){print "небо: дат, ед+мн"};
    if ( wb(-5,-1,"к ко")   )       { DEF_TN_PREDA_NEBU(wbn,"к ко");   Y["n_pre_k_tv"]  =tn; Y["tn_ok_k_tv"]  =Y["tn_ok_da"]=Y["tn_ok_any"]=tn_ok }; # TN_k_nebu_f()
   };
 if (iwrd=="небом" ) { Y["iwrd_case"]="tv"; if(dbg){print "небо: тв, ед+мн"};
    if ( wb(-5,-1,"под")   )       { DEF_TN_PRETV_NEBOM(wbn,"под");   Y["n_pre_pod_tv"]  =tn; Y["tn_ok_pod_tv"]  =Y["tn_ok_tv"]=Y["tn_ok_any"]=tn_ok }; # TN_pod_neboом_f()
   };
 if (iwrd=="небе" )  { Y["iwrd_case"]="pr"; if(dbg){print "небо: пр, ед+мн"};

   cst="в во на";
   if ( wb(-8,-1,cst) ) { qb_n=wbn;

     if ( wb(-8,-1,"в во")  ) { Y["n_pre_v_ist"]=wbn;
       DEF_TN_PREPR_NEBE(wbn,"в во"); Y["n_pre_v_pr"]=tn; Y["tn_ok_v_pr"]=Y["tn_ok_pr"]=Y["tn_ok_any"]=tn_ok }; # TN_v_nebe_f()
     if ( wb(-8,-1,"на")    ) { Y["n_pre_na_ist"] = wbn; }; #

   };

 };

if ( vex(Y["n_pre_v_ist"]) && !vex(Y["tn_ok_v"]) ) { tn=Y["n_pre_v_ist"];
   if ( wba(tn+1,-1,"_sky_v_suw-pr")  ) { Y["n-_sky_v_suw-pr"]  = wbn }; };

#===============================================================================================================================================================

 if ( FN_palate_prl_f("_palate_prl_true") )
 { X[5]++; if(dbg){print "X5 -- _palate_prl_true"}; continue };

 if ( FN_sky_prl_f("_sky_prl_true") )
 { X[6]++; if(dbg){print "X6 -- _sky_prl_true"}; continue };

 ######################################################################################################
 ### небо им_п_ вин_п_
 if( veq(Y["iwrd_case"],"iv") ) {

 cst="их наше само самое это";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; X[6]++; if(dbg){print "X6 -- _sky_prl_true"}; continue };

  if ( TN_v_nebo_f() )
  { X[6]++; if(dbg){print "X6 -- TN_v_nebo_f"}; continue };

    # _sky_pe <<<---:start
    if ( vgl(Y["n-_sky_pe"],-7,-1) ) { bb_n=Y["n-_sky_pe"]; BB_n=Y["w-_sky_pe"];
      if ( q(bb_n,"prq_edmuvi") && veq(Y["iwrd_case"],"iv") && ba(bb_n-1,"_sky_pe") )
      { bb_n=bb_n-1; X[5]++; if(dbg){print "X5", "-- bb_n-1"}; };
      # _sky_pe escape <<<---:start
      # _sky_pe escape <<<---:end

       if ( vgl(bb_n,-7,-1) && s(bb_n,-1) &&
            qir(bb_n+1,-1,"suw_vi prl_vi prq_vi mest_vi mest_3e qast_any nar_any prl_kred_sr") )
       { l[i]=omo2; X[6]++; if(dbg){print "X6"}; continue };

       if ( vgl(bb_n,-7,-3) && q(-1,"narph_any") && s(bb_n,-1) &&
            qir(bb_n+1,xwn-1,"nar_any") )
       { l[i]=omo2; X[7]++; if(dbg){print "X7"}; continue };
    };
    # _sky_pe --->>>:start
    if ( vgl(Y["n+_sky_pe"],1,6) ) { bf_n=Y["n+_sky_pe"]; bb_n=Y["n-_palate_pe"]; wf_n=Y["n-_gl_v_palate-iv"];

       if ( vgl(bf_n,1,6) && s(0,bf_n-1) &&
            qir(1,bf_n-1,"mod_any gl_aux_be nar_any") )
       { l[i]=omo2; X[8]++; if(dbg){print "X8"}; continue };
    };
    # _sky_pe --->>>:end
 }; # и_п_ и в_п_ небо
 ######################################################################################################

 ### неба р_п_
 if ( veq(Y["iwrd_case"],"ro") ) {
 #
 }; # р_п_ неба
 ######################################################################################################

 ### небом дат_п_
 if ( veq(Y["iwrd_case"],"da") ) {
 #
 }; # дат_п_ небу
 ######################################################################################################


 ### небом тв_п_
 if ( veq(Y["iwrd_case"],"tv") ) {
 #
   #
 }; # тв_п_ небом
 ######################################################################################################

 ### небе пр_п_
 if ( veq(Y["iwrd_case"],"pr") ) {
 #

 }; # пр_п_ небе
 ######################################################################################################

 if ( FN_nebo_suwro_f() )
 { X[9]++; if(dbg){print "X9", "-- FN_nebo_suwro_f"}; continue };


 }; delete wpos; book[b]=joinpat(l,sep,nf) };};                                ##_footer

} #main_end

function DEF_TN_PREVI_NEBO(num,el,    fufu) { # определение компонентов между "pre_vi" и "небо"
    tn=tn_ok="";
    tn=num;
    cst1_edsrvi="prl_edsrim mcop_edsrim qis_vi qik_vi prq_edsrim qast_any mest_3e nar_kaq nar_step";
    cst2_edsrvi="prl_edsrim prq_edsrim";
    cst3_edsrvi="prl_edsrim mcop_edsrim qis_vi qik_vi prq_edsrim suw_ro suw_edne";

    if ( w(0,"небо") )
    { cst1 = cst1_edsrvi; cst2 = cst2_edsrvi;  cst3 = cst3_edsrvi; };

    if ( hwy(-1,"то") && qir(tn+1,-1-hyn,cst1) && s(tn,-1) )
    { tn_ok = 1; X[10]++; if(dbg){print "X10", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) &&
            q(tn+1,cst2) && wy(-1,"же") &&
          qir(tn+2,-1-wyn,"mest_da suw_da prq_da nar_any prl_da") )
    { tn_ok = 1; X[11]++; if(dbg){print "X11", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) &&
            q(tn+1,cst2) &&
          qir(tn+2,-2,"mest_tv prq_tv qik_tv nar_any prl_tv") &&
            q(-1,"suw_tv mest_tv") )
    { tn_ok = 1; X[12]++; if(dbg){print "X12", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) &&
            q(tn+1,cst2) &&
          qir(tn+2,-3,"mest_tv prq_tv qik_tv nar_any prl_tv") &&
            q(-2,"suw_tv qik_tv") &&
            q(-1,cst3) )
    { tn_ok = 1; X[13]++; if(dbg){print "X13", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) &&
            q(tn+1,cst2) &&
            q(tn+2,"pre_vi") &&
          qir(tn+3,-2,"prl_vi mest_vi mest_3e") &&
            q(-1,"mest_vip3e suw_vi") )
    { tn_ok = 1; X[14]++; if(dbg){print "X14", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) &&
            q(tn+1,cst2) &&
            q(tn+2,"pre_tv") &&
          qir(tn+3,-2,"prl_tv mest_tv mest_3e") &&
            q(-1,"suw_tv") )
    { tn_ok = 1; X[15]++; if(dbg){print "X15", "-- tn_ok ON", el, "небо"};};
    cst="именно собственно";
    if ( !vex(tn_ok) && s(tn,-1) && qiw(tn+1,-1,cst1,cst) )
    { tn_ok = 1; X[16]++; if(dbg){print "X16", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(-4) && zs(-3) && s(-2,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"nar_any prl_kred_sr") && q(-1,cst2) )
    { tn_ok = 1; X[17]++; if(dbg){print "X17", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-2) && wc(-1,"ское$|ное$") )
    { tn_ok = 1; X[18]++; if(dbg){print "X18", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && zs(-2) && s(-1) && veq(tn,-3) &&
            q(-2,cst2) && wc(-1,"ское$|ное$") )
    { tn_ok = 1; X[19]++; if(dbg){print "X19", "-- tn_ok ON", el, "небо"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"sz_iili") && wc(-1,"ское$|ное$") )
    { tn_ok = 1; X[20]++; if(dbg){print "X20", "-- tn_ok ON", el, "небо"};};
    # передвижка tn_ok
    if ( vex(tn_ok) && s(tn,-1) &&
       ( qxs(tn-1,"как","и")||
         qxs(tn-1,"да","еще","и")||
         qxs(tn-1,"ведь даже же прямо сразу") ) )
    { tn = xsn; X[21]++; if(dbg){print "X21", "-- tn_ok MOV", el, "небо"};};
    # выключение tn_ok
    if ( vex(tn_ok) && z(tn-1) && w(tn+1,"который") )
    { tn_ok = ""; X[22]++; if(dbg){print "X22", "-- tn_ok OFF", el, "небо"};};
    if ( vex(tn_ok) && !vex(fufu) && s(tn,-1) && qf(tn+1,-1,"prq_edsrvi") &&
         bam(qfn,"_palate_pe _sky_pe") &&
           q(1,"suw_edsrvi suw_edne") && s(0) )
    { tn_ok = ""; X[23]++; if(dbg){print "X23", "-- tn_ok OFF", el, "небо"};};
    if ( vex(tn_ok) && !vex(fufu) && s(tn,-1) &&
         qxs(-1,"прошлый тот этот","раз") )
    { tn_ok = ""; X[24]++; if(dbg){print "X24", "-- tn_ok OFF", el, "небо"};};
}

function DEF_TN_PREDA_NEBU(num,el,    fufu) { # определение компонентов между "pre_da" и "небу"
    tn=tn_ok="";
    tn=num;
    cst1_edsrvi="prl_edsrda mcop_edsrda qis_da qik_da prq_edsrda qast_any mest_3e nar_kaq nar_step";
    cst2_edsrvi="prl_edsrda prq_edsrda";
    cst3_edsrvi="prl_edsrda mcop_edsrda qis_da qik_da prq_edsrda suw_ro suw_edne";

    if ( w(0,"небу") )
    { cst1 = cst1_edsrda; cst2 = cst2_edsrda;  cst3 = cst3_edsrda; };

    if ( hwy(-1,"то") && qir(tn+1,-1-hyn,cst1) && s(tn,-1) )
    { tn_ok = 1; X[25]++; if(dbg){print "X25", "-- tn_ok ON", el, "небу"};};
    # передвижка tn_ok
    if ( vex(tn_ok) && s(tn,-1) &&
       ( qxs(tn-1,"как","и")||
         qxs(tn-1,"да","еще","и")||
         qxs(tn-1,"ведь даже же прямо сразу") ) )
    { tn = xsn; X[26]++; if(dbg){print "X26", "-- tn_ok MOV", el, "небу"};};
}

function DEF_TN_PRETV_NEBOM(num,el,    fufu) { # определение компонентов между "pre_tv" и "небом"
    tn=tn_ok="";
    tn=num;
    cst1_edsrvi="prl_edsrtv mcop_edsrtv qis_tv qik_tv prq_edsrtv qast_any mest_3e nar_kaq nar_step";
    cst2_edsrvi="prl_edsrtv prq_edsrtv";
    cst3_edsrvi="prl_edsrtv mcop_edsrtv qis_tv qik_tv prq_edsrtv suw_ro suw_edne";

    if ( w(0,"небом") )
    { cst1 = cst1_edsrtv; cst2 = cst2_edsrtv;  cst3 = cst3_edsrtv; };

    if ( hwy(-1,"то") && qir(tn+1,-1-hyn,cst1) && s(tn,-1) )
    { tn_ok = 1; X[27]++; if(dbg){print "X27", "-- tn_ok ON", el, "небом"};};
    # передвижка tn_ok
    if ( vex(tn_ok) && s(tn,-1) &&
       ( qxs(tn-1,"как","и")||
         qxs(tn-1,"да","еще","и")||
         qxs(tn-1,"ведь даже же прямо сразу") ) )
    { tn = xsn; X[28]++; if(dbg){print "X28", "-- tn_ok MOV", el, "небом"};};
}

function DEF_TN_PREPR_NEBE(num,el) { # определение компонентов между "pre_pr" и "небе"
    tn=tn_ok="";
    tn=num;
    cst1_edsrpr="prl_edsrpr mcop_edsrpr qis_pr qik_pr prq_edsrpr qast_any mest_3e nar_kaq nar_step";
    cst2_edsrpr="prl_edsrpr prq_edsrpr";
    cst3_edsrpr="prl_edsrpr mcop_edsrpr qis_pr qik_pr prq_edsrpr suw_ro suw_edne";

    if ( w(0,"небе") )
    { cst1 = cst1_edsrpr; cst2 = cst2_edsrpr;  cst3 = cst3_edsrpr; };

    if ( hwy(-1,"то") && qir(tn+1,-1-hyn,cst1) && s(tn,-1) )
    { tn_ok = 1; X[29]++; if(dbg){print "X29", "-- tn_ok ON", el, "небе"};};
    cst="именно собственно";
    if ( !vex(tn_ok) && s(tn,-1) && qiw(tn+1,-1,cst1,cst) )
    { tn_ok = 1; X[30]++; if(dbg){print "X30", "-- tn_ok ON", el, "небе"};};
    if ( !vex(tn_ok) && s(-4) && zs(-3) && s(-2,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"nar_any prl_kred_sr") && q(-1,cst2) )
    { tn_ok = 1; X[31]++; if(dbg){print "X31", "-- tn_ok ON", el, "небе"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-2) && wc(-1,"ском$|ном$") )
    { tn_ok = 1; X[32]++; if(dbg){print "X32", "-- tn_ok ON", el, "небе"};};
    if ( !vex(tn_ok) && zs(-2) && s(-1) && veq(tn,-3) &&
            q(-2,cst2) && wc(-1,"ском$|ном$") )
    { tn_ok = 1; X[33]++; if(dbg){print "X33", "-- tn_ok ON", el, "небе"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"sz_iili") && wc(-1,"ском$|ном$") )
    { tn_ok = 1; X[34]++; if(dbg){print "X34", "-- tn_ok ON", el, "небе"};};
    # передвижка tn_ok
    if ( vex(tn_ok) && s(tn,-1) &&
       ( qxs(tn-1,"как","и")||
         qxs(tn-1,"да","еще","и")||
         qxs(tn-1,"ведь даже же прямо сразу") ) )
    { tn = xsn; X[35]++; if(dbg){print "X35", "-- tn_ok MOV", el, "небе"};};
}


function TN_v_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_v_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_v"]) ) { tn=Y["n_pre_v"];


    # _gl_v_sky-iv:start
    if ( vgl(Y["n-_gl_v_sky-iv"],tn-9,tn-1) ) { bb_n=Y["n-_gl_v_sky-iv"]; BB_n=Y["w-_gl_v_sky-iv"];
         # pointesque
       cst="бить брызнуть вгонять вогнать впиться упереться упираться";
       if ( weq(BB_n,cst) ) {
         if ( veq(bb_n,tn-2) && s(bb_n,tn-1) &&
               (w(tn-1,"мне ему ей")||q(tn-1,"suw_odedda")) )
         { l[i]=omo1; X[36]++; if(dbg){print "X36"}; stopp=ret=1; continue };
       };
       cst="бить брызнуть";
       cst1="слюна сок сперма";
       if ( weq(BB_n,cst) ) {
         if ( s(bb_n,tn-1) && bw(bb_n-1,cst1) &&
            qir(bb_n+1,tn-1,"gl_aux_be mod_any mest_da nar_any suw_da isname") )
         { l[i]=omo1; X[37]++; if(dbg){print "X37"}; stopp=ret=1; continue };
         if ( veq(bb_n,tn-2) && s(bb_n,tn-1) &&
                q(tn-1,"mest_da suw_odedda") )
         { l[i]=omo1; X[38]++; if(dbg){print "X38"}; stopp=ret=1; continue };
         if ( s(bb_n,tn-1) && bf(1,3,cst1) && s(0,bfn-1) &&
            qir(bb_n+1,tn-1,"gl_aux_be mod_any mest_da nar_any suw_da isname") &&
            qir(1,bfn-1,"mest_ro prl_ro prq_ro") )
         { l[i]=omo1; X[39]++; if(dbg){print "X39"}; stopp=ret=1; continue };
       };
       cst="впиться";
       if ( weq(BB_n,cst) ) {
         if ( s(bb_n,tn-1) && wfa(1,3,"_palate_suw-ro") && s(0,wfn-1) &&
            qir(bb_n+1,tn-1,"gl_aux_be mod_any mest_da nar_any suw_da isname") &&
            qir(1,bfn-1,"mest_ro prl_ro prq_ro") )
         { l[i]=omo2; X[40]++; if(dbg){print "X40"}; stopp=ret=1; continue };
       };
       cst="упереться упираться";
       cst1="головка зуб кончик член язык";
       if ( weq(BB_n,cst) ) {
         if ( bb(bb_n-3,bb_n-1,cst1) && s(bbn,tn-1) &&
             qir(bbn+1,bb_n-1,"mod_any prl_kred_sr gl_aux_be") )
         { l[i]=omo1; X[41]++; if(dbg){print "X41"}; stopp=ret=1; continue };
         if ( bf(bb_n+1,tn-1,cst1) && s(bb_n,tn-1) &&
             qir(bb_n+1,bfn-1,"prl_edsrtv mest_edsrtv") &&
             qir(bfn+1,tn-1,"suw_ro prl_ro mest_ro mest_da") )
         { l[i]=omo1; X[42]++; if(dbg){print "X42"}; stopp=ret=1; continue };
       };
       cst="вгонять вогнать";
       cst1="кинжал крючок";
       if ( weq(BB_n,cst) ) {
         if ( s(bb_n,tn-1) && w(tn-1,cst1) &&
            qir(bb_n+1,tn-2,"mest_vi prl_vi prq_vi") )
         { l[i]=omo1; X[43]++; if(dbg){print "X43"}; stopp=ret=1; continue };
       };
         # pointesque

       if ( vgl(bb_n,tn-9,tn-1) && s(bb_n,tn-1) &&
            bba(tn+1,-1,"_palate_prl_true") )
       { bb_n=""; X[44]++; if(dbg){print "X44"}; };

       if ( veq(bb_n,tn-1) && s(tn-1) )
       { l[i]=omo2; X[45]++; if(dbg){print "X45"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-6,tn-2) &&
            qir(bb_n+1,tn-2,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname qast_any") &&
              q(tn-1,"suw_vi qast_any") && s(bb_n,tn-1) )
       { l[i]=omo2; X[46]++; if(dbg){print "X46"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-6,tn-3) && s(bb_n,tn-3) &&
            qir(bb_n+1,tn-3,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname qast_any") &&
              q(tn-2,"suw_vi qast_any") && zs(tn-2) && s(tn-1) &&
              q(tn-1,"sz") )
       { l[i]=omo2; X[47]++; if(dbg){print "X47"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-3) &&
            qir(bb_n+1,tn-3,"prl_vi prq_vi mest_vi mest_3e prl_kred_sr nar_step isname") &&
              q(tn-2,"suw_vi") &&
              q(tn-1,"suw_ro") && s(bb_n,tn-1) )
       { l[i]=omo2; X[48]++; if(dbg){print "X48"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-4) &&
              q(tn-3,"suw_vi suw_im mest_im mest_vi suw_tv qast isname") &&
              q(tn-2,"suw_vi suw_tv") &&
              q(tn-1,"suw_ro") && s(tn-4,tn-1) && Qf(tn-3,tn-1,"sz_iili pre_any"))
       { l[i]=omo2; X[49]++; if(dbg){print "X49"}; stopp=ret=1; continue }; #inspect
       if ( vgl(bb_n,tn-6,tn-2) &&
              q(bb_n+1,"suw_vi suw_edne") &&
            qir(bb_n+2,tn-2,"prl_ro prq_ro mcop_ro qis_ro qik_ro qik_vi suw_ro suw_edne isname") &&
              q(tn-1,"suw_ro suw_edne isname") && s(bb_n,tn-1) )
       { l[i]=omo2; X[50]++; if(dbg){print "X50"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-3) &&
              q(bb_n+1,"suw_vi") &&
            qir(bb_n+2,tn-3,"prl_ro prq_ro mcop_ro qis_ro qik_ro suw_ro suw_edne isname") &&
              q(tn-2,"suw_ro isname") &&
              q(tn-1,"mest_ro suw_ro") && s(bb_n,tn-1) )
       { l[i]=omo2; X[51]++; if(dbg){print "X51"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-2) &&
            qir(bb_n+1,tn-2,"prl_tv prq_tv mest_tv mcop_tv mest_vi qik_tv qis_tv prl_vi prq_vi mest_3e qik_vi qis_vi suw_vi") &&
              q(tn-1,"suw_tv") && s(bb_n,tn-1) )
       { l[i]=omo2; X[52]++; if(dbg){print "X52"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-9,tn-3) &&
            qir(bb_n+1,tn-2,"prl_tv prq_tv mest_tv mest_vi qik_tv qis_tv prl_vi prq_vi mest_3e qik_vi qis_vi suw_tv") &&
              q(tn-1,"suw_vi") && s(bb_n,tn-1) )
       { l[i]=omo2; X[53]++; if(dbg){print "X53"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-5) && s(bb_n) &&
              q(bb_n+1,"prl_vi prq_vi") && z(bb_n+1) &&
              q(bb_n+2,"prq_vi") &&
            qir(bb_n+3,tn-3,"mest_tv prl_tv prq_tv mest_3e qik_tv qis_tv") &&
              q(tn-2,"suw_tv") &&
              q(tn-1,"suw_vi") && s(bb_n+2,tn-1) )
       { l[i]=omo2; X[54]++; if(dbg){print "X54"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-5) && tz(tn-1) && tz(tn-4) && z(tn-3) && s(2) &&
              q(tn-3,"prl_kred_sr") && q(tn-2,"nar_step") && q(tn-1,"prl_kred_sr") &&
            qir(bbn+1,vvn-1,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname") &&
              q(tn-4,"suw_vi") && s(bb_n,tn-5) )
       { l[i]=omo2; X[55]++; if(dbg){print "X55"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-3) &&
              q(tn-2,"suw_vi suw_im mest_im mest_vi suw_tv mest_tv qast isname") &&
              q(tn-1,"suw_vi suw_tv qast nar_any") && s(tn-3,tn-1) )
       { l[i]=omo2; X[56]++; if(dbg){print "X56"}; stopp=ret=1; continue }; #inspect
       if ( veq(bb_n,tn-2) &&
              q(tn-1,"mest_vi mest_tv mest_im mest_3e prl_vi") && s(tn-2,tn-1) )
       { l[i]=omo2; X[57]++; if(dbg){print "X57"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-3) &&
              q(tn-2,"prl_srav prl_kred_sr nar_spos") && Q(tn-2,"pre_vi") &&
              q(tn-1,"suw_vi mest_vi suw_im mest_im mest_3e prl_kred_sr prl_srav isname nar_mest") && s(tn-3,tn-1) )
       { l[i]=omo2; X[58]++; if(dbg){print "X58"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-2) &&
              q(tn-1,"suw_im prl_kred_sr prl_srav isname nar_any qis_vi") && s(tn-2,tn-1) )
       { l[i]=omo2; X[59]++; if(dbg){print "X59"}; stopp=ret=1; continue };
    };

    # _gl_v_palate-iv:start
    if ( vgl(Y["n-_gl_v_palate-iv"],tn-9,tn-1) ) { bb_n=Y["n-_gl_v_palate-iv"]; BB_n=Y["w-_gl_v_palate-iv"];
         # pointesque

       if ( vgl(bb_n,tn-9,tn-1) && s(bb_n,tn-1) &&
            bba(tn+1,-1,"_sky_prl_true") )
       { bb_n=""; X[60]++; if(dbg){print "X60"}; };

       if ( veq(bb_n,tn-1) && s(tn-1) )
       { l[i]=omo1; X[61]++; if(dbg){print "X61"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-6,tn-2) &&
            qir(bb_n+1,tn-2,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname qast_any") &&
              q(tn-1,"suw_vi qast_any") && s(bb_n,tn-1) )
       { l[i]=omo1; X[62]++; if(dbg){print "X62"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-6,tn-3) && s(bb_n,tn-3) &&
            qir(bb_n+1,tn-3,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname qast_any") &&
              q(tn-2,"suw_vi qast_any") && zs(tn-2) && s(tn-1) &&
              q(tn-1,"sz") )
       { l[i]=omo1; X[63]++; if(dbg){print "X63"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-3) &&
            qir(bb_n+1,tn-3,"prl_vi prq_vi mest_vi mest_3e prl_kred_sr nar_step isname") &&
              q(tn-2,"suw_vi") &&
              q(tn-1,"suw_ro") && s(bb_n,tn-1) )
       { l[i]=omo1; X[64]++; if(dbg){print "X64"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-4) &&
              q(tn-3,"suw_vi suw_im mest_im mest_vi suw_tv qast isname") &&
              q(tn-2,"suw_vi suw_tv") &&
              q(tn-1,"suw_ro") && s(tn-4,tn-1) && Qf(tn-3,tn-1,"sz_iili pre_any"))
       { l[i]=omo1; X[65]++; if(dbg){print "X65"}; stopp=ret=1; continue }; #inspect
       if ( vgl(bb_n,tn-6,tn-2) &&
              q(bb_n+1,"suw_vi suw_edne") &&
            qir(bb_n+2,tn-2,"prl_ro prq_ro mcop_ro qis_ro qik_ro qik_vi suw_ro suw_edne isname") &&
              q(tn-1,"suw_ro suw_edne isname") && s(bb_n,tn-1) )
       { l[i]=omo1; X[66]++; if(dbg){print "X66"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-3) &&
              q(bb_n+1,"suw_vi") &&
            qir(bb_n+2,tn-3,"prl_ro prq_ro mcop_ro qis_ro qik_ro suw_ro suw_edne isname") &&
              q(tn-2,"suw_ro isname") &&
              q(tn-1,"mest_ro suw_ro") && s(bb_n,tn-1) )
       { l[i]=omo1; X[67]++; if(dbg){print "X67"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-2) &&
            qir(bb_n+1,tn-2,"prl_tv prq_tv mest_tv mcop_tv mest_vi qik_tv qis_tv prl_vi prq_vi mest_3e qik_vi qis_vi suw_vi") &&
              q(tn-1,"suw_tv") && s(bb_n,tn-1) )
       { l[i]=omo1; X[68]++; if(dbg){print "X68"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-9,tn-3) &&
            qir(bb_n+1,tn-2,"prl_tv prq_tv mest_tv mest_vi qik_tv qis_tv prl_vi prq_vi mest_3e qik_vi qis_vi suw_tv") &&
              q(tn-1,"suw_vi") && s(bb_n,tn-1) )
       { l[i]=omo1; X[69]++; if(dbg){print "X69"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-5) && s(bb_n) &&
              q(bb_n+1,"prl_vi prq_vi") && z(bb_n+1) &&
              q(bb_n+2,"prq_vi") &&
            qir(bb_n+3,tn-3,"mest_tv prl_tv prq_tv mest_3e qik_tv qis_tv") &&
              q(tn-2,"suw_tv") &&
              q(tn-1,"suw_vi") && s(bb_n+2,tn-1) )
       { l[i]=omo1; X[70]++; if(dbg){print "X70"}; stopp=ret=1; continue };
       if ( vgl(bb_n,tn-7,tn-5) && tz(tn-1) && tz(tn-4) && z(tn-3) && s(2) &&
              q(tn-3,"prl_kred_sr") && q(tn-2,"nar_step") && q(tn-1,"prl_kred_sr") &&
            qir(bbn+1,vvn-1,"prl_vi prq_vi mcop_vi qik_vi qis_vi prl_kred_sr nar_any isname") &&
              q(tn-4,"suw_vi") && s(bb_n,tn-5) )
       { l[i]=omo1; X[71]++; if(dbg){print "X71"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-3) &&
              q(tn-2,"suw_vi suw_im mest_im mest_vi suw_tv mest_tv qast isname") &&
              q(tn-1,"suw_vi suw_tv qast nar_any") && s(tn-3,tn-1) )
       { l[i]=omo1; X[72]++; if(dbg){print "X72"}; stopp=ret=1; continue }; #inspect
       if ( veq(bb_n,tn-2) &&
              q(tn-1,"mest_vi mest_tv mest_im mest_3e prl_vi") && s(tn-2,tn-1) )
       { l[i]=omo1; X[73]++; if(dbg){print "X73"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-3) &&
              q(tn-2,"prl_srav prl_kred_sr nar_spos") && Q(tn-2,"pre_vi") &&
              q(tn-1,"suw_vi mest_vi suw_im mest_im mest_3e prl_kred_sr prl_srav isname nar_mest") && s(tn-3,tn-1) )
       { l[i]=omo1; X[74]++; if(dbg){print "X74"}; stopp=ret=1; continue };
       if ( veq(bb_n,tn-2) &&
              q(tn-1,"suw_im prl_kred_sr prl_srav isname nar_any qis_vi") && s(tn-2,tn-1) )
       { l[i]=omo1; X[75]++; if(dbg){print "X75"}; stopp=ret=1; continue };
    };


  Y["tn_ok_v"]="";
  }; # tn_ok=1 << в небо
break}; Y["TN_v_nebo_f"]=1; return ret }

function TN_na_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_na_nebo_f"]);
   while ( !stopp ) {

   if ( vex(Y["tn_ok_na"]) ) { tn=Y["n_pre_na"];

    #
  Y["tn_ok_na"]="";
  }; # tn_ok=1 << в небо
break}; Y["TN_na_nebo_f"]=1; return ret }

function TN_za_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_za_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_za"]) ) { tn=Y["n_pre_za"];

   Y["tn_ok_za"]="";
   }; # tn_ok
break}; Y["TN_za_nebo_f"]=1; return ret }

function TN_pod_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_pod_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_pod"]) ) { tn=Y["n_pre_pod"];

   Y["tn_ok_pod"]="";
   } # tn_ok <<== end
break}; Y["TN_pod_nebo_f"]=1; return ret }

function TN_pod_nebom_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_pod_nebom_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_pod_tv"]) ) { tn=Y["n_pre_pod_tv"];

   Y["tn_ok_tv"]="";
   } # tn_ok <<== end
break}; Y["TN_pod_nebom_f"]=1; return ret }

function TN_o_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_o_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_o"]) ) { tn=Y["n_pre_o"];

   Y["tn_ok_o"]="";
   }; # tn_ok <<== end
break}; Y["TN_o_nebo_f"]=1; return ret }

function TN_po_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_po_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_po"]) ) { tn=Y["n_pre_po"];


   Y["tn_ok_po"]="";
   }; # tn_ok <<== end
break}; Y["TN_po_nebo_f"]=1; return ret }

function TN_qerez_nebo_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_qerez_nebo_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_qerez"]) ) { tn=Y["n_pre_qerez"];

   Y["tn_ok_qerez"]="";
   }; # tn_ok <<== end
break}; Y["TN_qerez_nebo_f"]=1; return ret }

function DEF_TN_PRERO_NEBA(num,el) { # определение компонентов между "pre_ro" и "неба"
    tn=tn_ok="";
    tn=num;
    cst1_edsrro="prl_edsrro mcop_edsrro qis_ro qik_ro prq_edsrro qast_any mest_3e nar_kaq nar_step";
    cst2_edsrro="prl_edsrro prq_edsrro";
    cst3_edsrro="prl_edsrro mcop_edsrro qis_ro qik_ro prq_edsrro suw_ro suw_edne";

    if ( w(0,"неба") )
    { cst1 = cst1_edsrro; cst2 = cst2_edsrro;  cst3 = cst3_edsrro; };

    if ( hwy(-1,"то") && qir(tn+1,-1-hyn,cst1) && s(tn,-1) )
    { tn_ok = 1; X[76]++; if(dbg){print "X76", "-- tn_ok ON", el, "неба"};};
    cst="именно собственно";
    if ( !vex(tn_ok) && s(tn,-1) && qiw(tn+1,-1,cst1,cst) )
    { tn_ok = 1; X[77]++; if(dbg){print "X77", "-- tn_ok ON", el, "неба"};};
    if ( !vex(tn_ok) && s(-4) && zs(-3) && s(-2,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"nar_any prl_kred_sr") && q(-1,cst2) )
    { tn_ok = 1; X[78]++; if(dbg){print "X78", "-- tn_ok ON", el, "неба"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-2) && wc(-1,"ского$|ного$") )
    { tn_ok = 1; X[79]++; if(dbg){print "X79", "-- tn_ok ON", el, "неба"};};
    if ( !vex(tn_ok) && zs(-2) && s(-1) && veq(tn,-3) &&
            q(-2,cst2) && wc(-1,"ского$|ного$") )
    { tn_ok = 1; X[80]++; if(dbg){print "X80", "-- tn_ok ON", el, "неба"};};
    if ( !vex(tn_ok) && s(tn,-1) && veq(tn,-4) &&
            q(-3,cst2) && q(-2,"sz_iili") && wc(-1,"ского$|ного$") )
    { tn_ok = 1; X[81]++; if(dbg){print "X81", "-- tn_ok ON", el, "неба"};};
    # передвижка tn_ok
    if ( vex(tn_ok) && s(tn,-1) &&
       ( qxs(tn-1,"как","и")||
         qxs(tn-1,"да","еще","и")||
         qxs(tn-1,"ведь даже же прямо сразу") ) )
    { tn = xsn; X[82]++; if(dbg){print "X82", "-- tn_ok MOV", el, "неба"};};
}

function TN_do_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_do_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_do"]) ) { tn=Y["n_pre_do"];


   }; # tn_ok <<== end
break}; Y["TN_do_neba_f"]=1; return ret }

function TN_u_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_u_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_u"]) ) { tn=Y["n_pre_u"];


   }; # tn_ok <<== end
break}; Y["TN_u_neba_f"]=1; return ret }

function TN_vokrug_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_vokrug_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_vokrug"]) ) { tn=Y["n_pre_vokrug"];


   }; # tn_ok <<== end
break}; Y["TN_vokrug_neba_f"]=1; return ret }

function TN_vnutri_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_vnutri_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_vnutri"]) ) { tn=Y["n_pre_vnutri"];


   }; # tn_ok <<== end
break}; Y["TN_vnutri_neba_f"]=1; return ret }

function TN_iz_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_iz_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_iz"]) ) { tn=Y["n_pre_iz"];


   }; # tn_ok <<== end
break}; Y["TN_iz_neba_f"]=1; return ret }

function TN_ot_neba_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_ot_neba_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_ot"]) ) { tn=Y["n_pre_ot"];


   }; # tn_ok <<== end
break}; Y["TN_ot_neba_f"]=1; return ret }

function TN_v_nebe_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_v_nebe_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_v_pr"]) ) { tn=Y["n_pre_v_pr"];


   }; # tn_ok <<== end
break}; Y["TN_v_nebe_f"]=1; return ret }

function TN_k_nebu_f(    ret, tn, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["TN_k_nebu_f"]);
  while ( !stopp ) {

  if ( vex(Y["tn_ok_k_tv"]) ) { tn=Y["n_pre_k_tv"];


   }; # tn_ok <<== end
break}; Y["TN_v_nebu_f"]=1; return ret }

function FN_palate_prl_f(str_palate,    ret, stopp_str, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp_str="FN" str_palate "_f"; stopp=v2s(Y[stopp_str]);
  while ( !stopp ) {

       if ( iwrd == "небо") {

          if ( s(-1) && q(-1,"prl_edsrim prl_kred_sr") && ba(-1,str_palate) && !wa(-1,"X_palate_prl") )
          { l[i]=omo1; X[83]++; if(dbg){print "X83"}; stopp=ret=1; continue };
          if ( zs(-2) && s(-1) && qm(-2,"prl_edsrim prl_kred_sr",str_palate) && !wa(-2,"X_palate_prl") && !wa(-1,"_sky_prl_true") &&
                q(-1,"prl_edsrim mest_edsrvi prq_edsrim mest_3e qast_any nar_any prl_kred_sr gl_aux_be isname") && zs(-2) && s(-1)  )
          { l[i]=omo1; X[84]++; if(dbg){print "X84"}; stopp=ret=1; continue }; #uphere
          if ( z(-3) && s(-2,-1) && qm(-3,"prl_edsrim",str_palate) && q(-2,"prl_edsrim prl_kred_sr nar_any sz_i") && q(-1,"prl_edsrim") )
          { l[i]=omo1; X[85]++; if(dbg){print "X85"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrim prl_edsrtv qast_any gl_aux_be") && qm(2,"prl_edsrim prl_edsrtv",str_palate) && Q_w(3,"suw_edvi suw_edim suw_edtv") &&
             (zs(0)||se(0," — ")) && zs(1) )
          { l[i]=omo1; X[86]++; if(dbg){print "X86"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrim prl_edsrtv") &&
               q(2,"prl_edsrim prl_edsrtv qast_any gl_aux_be") && qm(3,"prl_edsrim prl_edsrtv",str_palate) && Q_w(4,"suw_edvi suw_edim suw_edtv") &&
             (zs(0)||se(0," — ")) && zs(2) )
          { l[i]=omo1; X[87]++; if(dbg){print "X87"}; stopp=ret=1; continue };
          if ( qm(1,"prl_edsrim",str_palate) && (s(0)||se(0," — ")||sc(0,":")) && Q_w(2,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo1; X[88]++; if(dbg){print "X88"}; stopp=ret=1; continue };
          if ( qf(1,5,"prl_edsrim prl_edsrtv prl_kred_sr") && qir(1,qfn-1,"gl_aux_be qast_any nar_any predik prl_kred_sr muk_edsrim") && !wa(qfn,"X_palate_prl") &&
               ba(qfn,str_palate) && (zs(0)||se(0," — ")) && s(1,qfn-1) && Q_w(qfn+1,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo1; X[89]++; if(dbg){print "X89"}; stopp=ret=1; continue };
          if ( qb(1,5,"prl_edsrim prl_edsrtv prl_kred_sr") && qir(1,qbn-1,"gl_aux_be qast_any nar_any prl_kred_sr prl_edsrim prl_edsrtv muk_edsrim mezd") && !wa(qbn,"X_palate_prl") &&
               ba(qbn,str_palate) && (zs(0)||se(0," — ")) && s(1,qbn-1) && Q(qbn+1,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo1; X[90]++; if(dbg){print "X90"}; stopp=ret=1; continue };

          if ( q(1,"vvod") && z(0) && z(1) && qm(2,"prl_edsrim prl_kred_sr",str_palate) && Q_w(3,"suw_edvi suw_edim") )
          { l[i]=omo1; X[91]++; if(dbg){print "X91"}; stopp=ret=1; continue };
          if ( q(1,"nar_mest") && s(0) && q(2,"vvod") && z(1) && z(2) && qm(3,"prl_edsrim prl_kred_sr",str_palate) && Q_w(4,"suw_edvi suw_edim") )
          { l[i]=omo1; X[92]++; if(dbg){print "X92"}; stopp=ret=1; continue };
          if ( q(1,"nar_mest") && s(0) && q(2,"vvod") && z(1) && z(2) && q(3,"nar_spos") && qm(4,"prl_edsrim prl_kred_sr",str_palate) && Q_w(5,"suw_edvi suw_edim") )
          { l[i]=omo1; X[93]++; if(dbg){print "X93"}; stopp=ret=1; continue };

          if ( qf(1,5,"prl_edsrim prl_edsrtv") && qir(1,qfn-1,"gl_aux_be qast_any nar_any prl_kred_sr") && sc(qfn,"[,—]") &&
                q(qfn+1,"prl_edsrim prl_edsrtv") && ba(qfn+1,str_palate) && s(0,qfn-1) )
          { l[i]=omo1; X[94]++; if(dbg){print "X94"}; stopp=ret=1; continue };
          if ( qf(2,6,"sz_i") && qiz(1,qfn-1,"gl_aux_be qast_any nar_any prl_kred_sr muk_edsrim muk_edsrtv","prl_edsrim prl_edsrtv") &&
                q(qfn+1,"prl_edsrim prl_edsrtv") && ba(qfn+1,str_palate) && s(0,qfn) )
          { l[i]=omo1; X[95]++; if(dbg){print "X95"}; stopp=ret=1; continue };

          cst="казаться оказаться остаться показаться являться";
          if ( bf(1,3,cst) ) { wf_n=bfn;
              if ( qf(wf_n+1,wf_n+3,"prl_edsrtv") && ba(qfn,str_palate) && s(0,qfn-1) && Q_w(qfn+1,"suw_edtv") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qfn-1,"nar_any qast_any") )
              { l[i]=omo1; X[96]++; if(dbg){print "X96"}; stopp=ret=1; continue };
              if ( qb(wf_n+1,wf_n+3,"prl_edsrtv") && ba(qbn,str_palate) && s(0,qbn-1) && Q_w(qfn+1,"suw_edtv") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qbn-1,"nar_any qast_any prl_edsrtv") )
              { l[i]=omo1; X[97]++; if(dbg){print "X97"}; stopp=ret=1; continue };
              if ( qf(wf_n+1,wf_n+3,"prl_edsrim prl_kred_sr") && ba(qfn,str_palate) && s(0,qfn-1) && Q_w(qfn+1,"suw_edvi suw_edim") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qfn-1,"nar_any qast_any") )
              { l[i]=omo1; X[98]++; if(dbg){print "X98"}; stopp=ret=1; continue };
              if ( qb(wf_n+1,wf_n+3,"prl_edsrim prl_kred_sr") && ba(qbn,str_palate) && s(0,qbn-1) && Q_w(qfn+1,"suw_edvi suw_edim") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qbn-1,"nar_any qast_any prl_edsrim") )
              { l[i]=omo1; X[99]++; if(dbg){print "X99"}; stopp=ret=1; continue };
          };
       }; #небо
       if ( iwrd == "неба") {
          if ( s(-1) && q(-1,"prl_edsrro") && ba(-1,str_palate) )
          { l[i]=omo1; X[100]++; if(dbg){print "X100"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrro(-2) && q(-1,"prl_edsrro") && ba(-2,str_palate) )
          { l[i]=omo1; X[101]++; if(dbg){print "X101"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небу") {
          if ( s(-1) && q(-1,"prl_edsrda") && ba(-1,str_palate) )
          { l[i]=omo1; X[102]++; if(dbg){print "X102"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrda(-2) && q(-1,"prl_edsrda") && ba(-2,str_palate) )
          { l[i]=omo1; X[103]++; if(dbg){print "X103"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrda") && (s(0)||se(0," — ")||sc(0,":")) && Q_w(2,"suw_edda") )
          { l[i]=omo1; X[104]++; if(dbg){print "X104"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небом") {
          if ( s(-1) && q(-1,"prl_edsrtv") && ba(-1,str_palate) )
          { l[i]=omo1; X[105]++; if(dbg){print "X105"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrtv(-2) && q(-1,"prl_edsrtv") && ba(-2,str_palate) )
          { l[i]=omo1; X[106]++; if(dbg){print "X106"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небе") {
          if ( s(-1) && q(-1,"prl_edsrpr") && ba(-1,str_palate) )
          { l[i]=omo1; X[107]++; if(dbg){print "X107"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrpr(-2) && q(-1,"prl_edsrpr") && ba(-2,str_palate) )
          { l[i]=omo1; X[108]++; if(dbg){print "X108"}; stopp=ret=1; continue };
       };
    # _palate_prl:end
break}; Y[stopp_str]=1; return ret }

function FN_sky_prl_f(str_sky,    ret, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp_str="FN" str_sky "_f"; stopp=v2s(Y[stopp_str]);
  while ( !stopp ) {

       if ( iwrd == "небо") {

          if ( s(-1) && q(-1,"prl_edsrim prl_kred_sr") && ba(-1,str_sky) && !wa(-1,"X_sky_prl") )
          { l[i]=omo2; X[109]++; if(dbg){print "X109"}; stopp=ret=1; continue };
          if ( zs(-2) && s(-1) && qm(-2,"prl_edsrim prl_kred_sr",str_sky) && !wa(-2,"X_sky_prl") && !wa(-1,"_palate_prl") &&
                q(-1,"prl_edsrim mest_edsrvi prq_edsrim mest_3e qast_any nar_any prl_kred_sr gl_aux_be isname") && zs(-2) && s(-1)  )
          { l[i]=omo2; X[110]++; if(dbg){print "X110"}; stopp=ret=1; continue }; #uphere
          if ( z(-3) && s(-2,-1) && qm(-3,"prl_edsrim",str_sky) && q(-2,"prl_edsrim prl_kred_sr nar_any sz_i") && q(-1,"prl_edsrim") )
          { l[i]=omo2; X[111]++; if(dbg){print "X111"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrim prl_edsrtv qast_any gl_aux_be") && qm(2,"prl_edsrim prl_edsrtv",str_sky) && Q_w(3,"suw_edvi suw_edim suw_edtv") &&
             (zs(0)||se(0," — ")) && zs(1) )
          { l[i]=omo2; X[112]++; if(dbg){print "X112"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrim prl_edsrtv") &&
               q(2,"prl_edsrim prl_edsrtv qast_any gl_aux_be") && qm(3,"prl_edsrim prl_edsrtv",str_sky) && Q_w(4,"suw_edvi suw_edim suw_edtv") &&
             (zs(0)||se(0," — ")) && zs(2) )
          { l[i]=omo2; X[113]++; if(dbg){print "X113"}; stopp=ret=1; continue };
          if ( qm(1,"prl_edsrim",str_sky) && (s(0)||se(0," — ")||sc(0,":")) && Q_w(2,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo2; X[114]++; if(dbg){print "X114"}; stopp=ret=1; continue };
          if ( qf(1,5,"prl_edsrim prl_edsrtv prl_kred_sr") && qir(1,qfn-1,"gl_aux_be qast_any nar_any predik prl_kred_sr muk_edsrim") && !wa(qfn,"X_sky_prl") &&
               ba(qfn,str_sky) && (zs(0)||se(0," — ")) && s(1,qfn-1) && Q_w(qfn+1,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo2; X[115]++; if(dbg){print "X115"}; stopp=ret=1; continue };
          if ( qb(1,5,"prl_edsrim prl_edsrtv prl_kred_sr") && qir(1,qbn-1,"gl_aux_be qast_any nar_any prl_kred_sr prl_edsrim prl_edsrtv muk_edsrim mezd") && !wa(qbn,"X_sky_prl") &&
               ba(qbn,str_sky) && (zs(0)||se(0," — ")) && s(1,qbn-1) && Q(qbn+1,"suw_edvi suw_edim suw_edtv") )
          { l[i]=omo2; X[116]++; if(dbg){print "X116"}; stopp=ret=1; continue };

          if ( q(1,"vvod") && z(0) && z(1) && qm(2,"prl_edsrim prl_kred_sr",str_sky) && Q_w(3,"suw_edvi suw_edim") )
          { l[i]=omo2; X[117]++; if(dbg){print "X117"}; stopp=ret=1; continue };
          if ( q(1,"nar_mest") && s(0) && q(2,"vvod") && z(1) && z(2) && qm(3,"prl_edsrim prl_kred_sr",str_sky) && Q_w(4,"suw_edvi suw_edim") )
          { l[i]=omo2; X[118]++; if(dbg){print "X118"}; stopp=ret=1; continue };
          if ( q(1,"nar_mest") && s(0) && q(2,"vvod") && z(1) && z(2) && q(3,"nar_spos") && qm(4,"prl_edsrim prl_kred_sr",str_sky) && Q_w(5,"suw_edvi suw_edim") )
          { l[i]=omo2; X[119]++; if(dbg){print "X119"}; stopp=ret=1; continue };

          if ( qf(1,5,"prl_edsrim prl_edsrtv") && qir(1,qfn-1,"gl_aux_be qast_any nar_any prl_kred_sr") && sc(qfn,"[,—]") &&
                q(qfn+1,"prl_edsrim prl_edsrtv") && ba(qfn+1,str_sky) && s(0,qfn-1) )
          { l[i]=omo2; X[120]++; if(dbg){print "X120"}; stopp=ret=1; continue };
          if ( qf(2,6,"sz_i") && qiz(1,qfn-1,"gl_aux_be qast_any nar_any prl_kred_sr muk_edsrim muk_edsrtv","prl_edsrim prl_edsrtv") &&
                q(qfn+1,"prl_edsrim prl_edsrtv") && ba(qfn+1,str_sky) && s(0,qfn) )
          { l[i]=omo2; X[121]++; if(dbg){print "X121"}; stopp=ret=1; continue };

          cst="казаться оказаться остаться показаться являться";
          if ( bf(1,3,cst) ) { wf_n=bfn;
              if ( qf(wf_n+1,wf_n+3,"prl_edsrtv") && ba(qfn,str_sky) && s(0,qfn-1) && Q_w(qfn+1,"suw_edtv") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qfn-1,"nar_any qast_any") )
              { l[i]=omo2; X[122]++; if(dbg){print "X122"}; stopp=ret=1; continue };
              if ( qb(wf_n+1,wf_n+3,"prl_edsrtv") && ba(qbn,str_sky) && s(0,qbn-1) && Q_w(qfn+1,"suw_edtv") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qbn-1,"nar_any qast_any prl_edsrtv") )
              { l[i]=omo2; X[123]++; if(dbg){print "X123"}; stopp=ret=1; continue };
              if ( qf(wf_n+1,wf_n+3,"prl_edsrim prl_kred_sr") && ba(qfn,str_sky) && s(0,qfn-1) && Q_w(qfn+1,"suw_edvi suw_edim") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qfn-1,"nar_any qast_any") )
              { l[i]=omo2; X[124]++; if(dbg){print "X124"}; stopp=ret=1; continue };
              if ( qb(wf_n+1,wf_n+3,"prl_edsrim prl_kred_sr") && ba(qbn,str_sky) && s(0,qbn-1) && Q_w(qfn+1,"suw_edvi suw_edim") &&
                  qir(1,wf_n-1,"nar_any qast_any") && qir(wf_n+1,qbn-1,"nar_any qast_any prl_edsrim") )
              { l[i]=omo2; X[125]++; if(dbg){print "X125"}; stopp=ret=1; continue };
          };
       }; #небо
       if ( iwrd == "неба") {
          if ( s(-1) && q(-1,"prl_edsrro") && ba(-1,str_sky) )
          { l[i]=omo2; X[126]++; if(dbg){print "X126"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrro(-2) && q(-1,"prl_edsrro") && ba(-2,str_sky) )
          { l[i]=omo2; X[127]++; if(dbg){print "X127"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небу") {
          if ( s(-1) && q(-1,"prl_edsrda") && ba(-1,str_sky) )
          { l[i]=omo2; X[128]++; if(dbg){print "X128"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrda(-2) && q(-1,"prl_edsrda") && ba(-2,str_sky) )
          { l[i]=omo2; X[129]++; if(dbg){print "X129"}; stopp=ret=1; continue };
          if ( q(1,"prl_edsrda") && (s(0)||se(0," — ")||sc(0,":")) && Q_w(2,"suw_edda") )
          { l[i]=omo2; X[130]++; if(dbg){print "X130"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небом") {
          if ( s(-1) && q(-1,"prl_edsrtv") && ba(-1,str_sky) )
          { l[i]=omo2; X[131]++; if(dbg){print "X131"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrtv(-2) && q(-1,"prl_edsrtv") && ba(-2,str_sky) )
          { l[i]=omo2; X[132]++; if(dbg){print "X132"}; stopp=ret=1; continue };
       };
       if ( iwrd == "небе") {
          if ( s(-1) && q(-1,"prl_edsrpr") && ba(-1,str_sky) )
          { l[i]=omo2; X[133]++; if(dbg){print "X133"}; stopp=ret=1; continue };
          if ( s(-2,-1) && prl_edsrpr(-2) && q(-1,"prl_edsrpr") && ba(-2,str_sky) )
          { l[i]=omo2; X[134]++; if(dbg){print "X134"}; stopp=ret=1; continue };
       };
    # _sky_prl:end
break}; Y[stopp_str]=1; return ret }

function FN_hw_neba_f(    ret, stopp_str, stopp, bb_n,bf_n,qb_n,qf_n,QB_n,QF_n,wb_n,wf_n, fufu) { stopp=v2s(Y["FN_hw_neba_f"]);
  while ( !stopp ) {

break}; Y["FN_hw_neba_f"]=1; return ret }

function FN_nebo_suwro_f(    ret, stopp_str, stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) { stopp=v2s(Y["FN_nebo_suwro_f"]);
  while ( !stopp ) {
  # _palate_suw-ro:start
  if ( wfa(1,5,"_palate_suw-ro") ) { wf_n=wfn;
     if ( vgl(wf_n,1,5) && s(0,wf_n-1) && !( isname(wf_n)||isname(1) ) &&
          qir(1,wf_n-1,"prl_ro mest_ro prq_ro prl_kred_sr nar_step qip_ro qik_im") )
     { l[i]=omo1; X[135]++; if(dbg){print "X135"}; stopp=ret=1; continue };
  };
  # _palate_suw-ro:end

  # _sky_suw-ro:start
  if ( wfa(1,5,"_sky_suw-ro") ) { wf_n=wfn;

        if ( vgl(wf_n,1,5) && s(0,wf_n-1) &&
             qir(1,wf_n-1,"prl_ro mest_ro prq_ro qik_im qip_ro") )
        { l[i]=omo2; X[136]++; if(dbg){print "X136"}; stopp=ret=1; continue };
 };

 # _sky_suw-ro:end
break}; Y["FN_nebo_suwro_f"]=1; return ret }

function FN_nebo_vi_esc_f(lvl,    ret, stopp_str,fufu,stopp, bb_n,bf_n,qb_n,qf_n,wb_n,wf_n,BB_n,BF_n,eb_n,EB_n,ef_n,EF_n) {
  while ( !stopp ) {


break}; return ret }


