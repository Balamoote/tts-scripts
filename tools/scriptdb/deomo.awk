END { FS = savefs

### все !_#_!

VSEVSO_F() # если подключена "новая" функция "все", то выйти
                                                                       # правила находятся в файле vsevso.awk (старая функция)
###   x0300 !_#_! ==> phrases
xgrp="x0300";for(wrd in omap[xgrp]){iwrd=tolower(wrd);wln=split(omap[xgrp][wrd],omlin," ");for(y=1;y<=wln;y++)         # header1
{b=strtonum(omlin[y]);nf=splitline(book[b]);regwpos(wrd);for(i in wpos){i=strtonum(i);if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( esca() )
 { R[1]++; if(dbg){print "R1", "-- is a phrase!"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x0301 !_#_! ==> CAPS marked stress
xgrp="x0301";for(wrd in omap[xgrp]){iwrd=tolower(wrd);wln=split(omap[xgrp][wrd],omlin," ");for(y=1;y<=wln;y++)         # header1
{b=strtonum(omlin[y]);nf=splitline(book[b]);regwpos(wrd);for(i in wpos){i=strtonum(i);if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( ecap() )
 { R[2]++; if(dbg){print "R2", "-- caps-marked!"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

 ##   x1000 !_#_! ==> klitika_  none_
 xgrp="x1000";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
 {makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback

#if(iwrd=="была") {
#  if ( qxs(-1,"была","не") )
#  { l[i]=omo2; R[3]++; if(dbg){print "R3"}; continue };
#};
 #
#if ( ismark(-1,"Ykl") && notsym(-1,unxy) && s(-1) )
#{ l[i-1]=gensub(/([АЕЁИОУЫЭЮЯаеёиоуыэюя])/,"\\1\xcc\x81",1,l[i-1]); l[i]=gensub(/^(.)/,"\xcc\xa0\\1\xcc\xad",1,l[i]); R[4]++; if(dbg){print "R4", "klitika"}; continue };

#l[i]=omo2; R[5]++; if(dbg){print "R5", "def"}; continue

 l[i]=omo2; R[6]++; if(dbg){print "R6"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1001 !_#_! ==> m2_1gl_bumn_2pq_kr_em_      gl_bumn_
#xgrp="x1001";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
#{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
##
# if ( gl_pomn_f() )
# { l[i]=omo1; R[7]++; if(dbg){print "R7", "gl_pomn_f"}; continue };

# }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1002 !_#_! ==> m2_1gl_namn_2pq_kr_em_     gl_bumn_    по типу избе́га́ем
xgrp="x1002";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 if(iwrd=="избегаем") {
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo1; R[8]++; if(dbg){print "R8"}; continue };
 };

 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[9]++; if(dbg){print "R9", "pq_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1003 !_#_! ==> sw_em_r_      zalt_
xgrp="x1003";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[10]++; if(dbg){print "R10", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1004 !_#_! ==> sw_1em_vr_2mn_iv_   zalt_
xgrp="x1004";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[11]++; if(dbg){print "R11", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[12]++; if(dbg){print "R12", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[13]++; if(dbg){print "R13", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[14]++; if(dbg){print "R14", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1005 !_#_! ==> sw_1ez_r_2mn_iv_    zalt_
xgrp="x1005";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[15]++; if(dbg){print "R15", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[16]++; if(dbg){print "R16", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[17]++; if(dbg){print "R17", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1006 !_#_! ==> sw_em_d_      zalt_
xgrp="x1006";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[18]++; if(dbg){print "R18", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1007 !_#_! ==> sw_em_i_      zalt_
xgrp="x1007";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[19]++; if(dbg){print "R19", "sw_em_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1008 !_#_! ==> sw_em_iv_     zalt_
xgrp="x1008";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[20]++; if(dbg){print "R20", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[21]++; if(dbg){print "R21", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1009 !_#_! ==> sw_es_iv_     zalt_
xgrp="x1009";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo1; R[22]++; if(dbg){print "R22", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo1; R[23]++; if(dbg){print "R23", "sw_es_v_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[24]++; if(dbg){print "R24", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1010 !_#_! ==> sw_es_t_      zalt_
xgrp="x1010";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_t_f() )
 { l[i]=omo1; R[25]++; if(dbg){print "R25", "sw_es_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1011 !_#_! ==> sw_ez_d_      zalt_
xgrp="x1011";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[26]++; if(dbg){print "R26", "sw_ez_d_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1012 !_#_! ==> sw_ez_dp_     zalt_
xgrp="x1012";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[27]++; if(dbg){print "R27", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo1; R[28]++; if(dbg){print "R28", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1013 !_#_! ==> sw_ez_i_      zalt_
xgrp="x1013";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[29]++; if(dbg){print "R29", "sw_ez_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1014 !_#_! ==> sw_ez_r_      zalt_  одуш.  казачки  каза́чки  казачки́
xgrp="x1014";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[30]++; if(dbg){print "R30", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1015 !_#_! ==> sw_ez_v_      zalt_  шлепку  шлёпку  шлепку́
xgrp="x1015";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[31]++; if(dbg){print "R31", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1016 !_#_! ==> sw_mn_iv_     zalt_  дельца тельца
xgrp="x1016";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[32]++; if(dbg){print "R32", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[33]++; if(dbg){print "R33", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1017 !_#_! ==> swn_mn_p_  swo_mn_p_  купчих  ку́пчих  купчи́х
xgrp="x1017";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_p_f() )
 { l[i]=omo1; R[34]++; if(dbg){print "R34", "sw_mn_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1018 !_#_! ==> sw_em_v_      zalt_  парю  па́рю  парю́
xgrp="x1018";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[35]++; if(dbg){print "R35", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1019 !_#_! ==> hyphdef_word_   default_
xgrp="x1019";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( w(-1,"по") && se(-1,"-") )
 { l[i]=omo1; R[36]++; if(dbg){print "R36"}; continue };
 if ( !(sR(-1,"-")||sL(0,"-")) )
 { l[i]=omo2; R[37]++; if(dbg){print "R37"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1020 !_#_! ==> hyphany_word_  (default_)
xgrp="x1020";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if(iwrd=="ага") {
   if ( sR(0,"-") )
   { l[i]=omo2; R[38]++; if(dbg){print "R38"}; continue };
 };

 #
 if ( sc(-1,"-") )
 { l[i]=omo1; R[39]++; if(dbg){print "R39"}; continue };

 # l[i]=omo2; R[40]++; if(dbg){print "R40"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1021 !_#_! ==> hyph1_word_hyph2_    word_
xgrp="x1021";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sR(-1,"-") && sL(0,"-") )
 { l[i]=omo1; R[41]++; if(dbg){print "R41"}; continue };
 if ( sL(0,"-") )
 { l[i]=omo1; R[42]++; if(dbg){print "R42"}; continue };

 l[i]=omo2; R[43]++; if(dbg){print "R43"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1022 !_#_! ==> pl_em_iv_  sw_ez_t_  какой  како́й  ка́кой
xgrp="x1022";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sL(0,"-") && w(1,"то либо нибудь") )
 { l[i]=omo1; R[44]++; if(dbg){print "R44"}; continue };
 #
 cst="весть знает";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[45]++; if(dbg){print "R45", "sw_ez_t_f"}; continue };
 if ( q(-1,"gl_po pre_tv pre_vi pre_da pre_ro pre_pr") && s(-1) )
 { l[i]=omo1; R[46]++; if(dbg){print "R46", "sw_ez_t_f"}; continue };
 #
 if ( pl_em_i_f()||pl_em_v_f()||pl_ez_d_f()||pl_ez_p_f()||pl_ez_r_f()||pl_ez_t_f() )
 { l[i]=omo1; R[47]++; if(dbg){print "R47", "pl_eX_X_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[48]++; if(dbg){print "R48", "sw_ez_t_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1023 !_#_! ==> word_hyphany_  (default_)
xgrp="x1023";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sL(0,"-") )
 { l[i]=omo1; R[49]++; if(dbg){print "R49"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1024 !_#_! ==> sw_em_v_  (zalt_)
xgrp="x1024";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(-1,"pre_vi preph_vi") && s(-1) )
 { l[i]=omo1; R[50]++; if(dbg){print "R50"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1025 !_#_! ==> tem_je_       тем  те́м
xgrp="x1025";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 l[i]=omo1; R[51]++; if(dbg){print "R51"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1026 !_#_! ==> orgbody_      orgplay_ орган  о́рган ... орга́н ...
xgrp="x1026";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="власти дыхания здравоохранения зрения обоняния осязания порядка правопорядка самоуправления слуха управления чувств";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[52]++; if(dbg){print "R52"}; continue };
 #
 cst="внутренний государственный местный официальный полицейский половой руководящий советский союзный судебный федеральный хватательный чувствительный \
      электровосприимчивый";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[53]++; if(dbg){print "R53"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1027 !_#_! ==> sw_1em_d_2ez_v_  sw_em_dz_     парку  па́рку  парку́
xgrp="x1027";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[54]++; if(dbg){print "R54", "sw_em_d_f"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[55]++; if(dbg){print "R55", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[56]++; if(dbg){print "R56", "sw_ez_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1028 !_#_! ==> pq_kr_em_     pl_kr_em_   проклят  про́клят  прокля́т
xgrp="x1028";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[57]++; if(dbg){print "R57", "pq_kr_em_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1029 !_#_! ==> pq_kr_es_     pl_kr_es_   проклято  про́клято  прокля́то
xgrp="x1029";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="будет буду будь было оно стало ты я";
 if ( w(-1,cst)||suw_edsrim(-1) && s(-1) )
 { l[i]=omo1; R[58]++; if(dbg){print "R58"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1030 !_#_! ==> pq_kr_ez_     pl_kr_ez_   проклята  про́клята  прокля́та
xgrp="x1030";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="будет будь была она стала ты я";
 if ( w(-1,cst)||suw_edmuim(-1) && s(-1) )
 { l[i]=omo1; R[59]++; if(dbg){print "R59"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1031 !_#_! ==> pq_kr_mn_     pl_kr_mn_   прокляты  про́кляты  прокля́ты
xgrp="x1031";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="будут будь были вы мы они стали";
 if ( w(-1,cst)||suw_edmuim(-1) && s(-1) )
 { l[i]=omo1; R[60]++; if(dbg){print "R60"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1032 !_#_! ==> ghost_        parfume_   духами  ду́хами  духа́ми
xgrp="x1032";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="добрыми злыми лесными подземными светлыми темными";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[61]++; if(dbg){print "R61"}; continue };
 #
 cst="благоухание благоухать вонь вонять запах запахнуть пользоваться";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[62]++; if(dbg){print "R62"}; continue };
 cst="дешевыми дорогими женскими модными мужскими тошнотворными";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[63]++; if(dbg){print "R63"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1033 !_#_! ==> ghost_        parfume_  духах  ду́хах  духа́х
xgrp="x1033";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="добрых злых лесных подземных светлых темных тысячи";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[64]++; if(dbg){print "R64"}; continue };
 #
 cst="дешевых дорогих женских модных мужских тошнотворных";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[65]++; if(dbg){print "R65"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1034 !_#_! ==> ghost_        parfume_  духи  ду́хи  духи́
xgrp="x1034";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="добрые злые лесные подземные светлые темные";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[66]++; if(dbg){print "R66"}; continue };
 #
 cst="дешевые дорогие женские модные мужские тошнотворные";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[67]++; if(dbg){print "R67"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1035 !_#_! ==> ghost_        parfume_  духов  ду́хов  духо́в
xgrp="x1035";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="вонь добрых злых лесных подземных светлых темных тысяч";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[68]++; if(dbg){print "R68"}; continue };
 cst="впустить вызвать вызывать выпускать выпустить выпусть заклинатель заклинать призвание призывать укротитель укротить укрощать";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[69]++; if(dbg){print "R69"}; continue };
 #
 cst="дешевых дорогих женских модных мужских тошнотворных";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[70]++; if(dbg){print "R70"}; continue };
 cst="аромат благоухание вонь вонять запах изготовление пользоваться флакон шлейф";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[71]++; if(dbg){print "R71"}; continue };
 if ( wc(-2,cst) &&
       q(-1,"mest_ro prl_ro") && s(-2,-1) )
 { l[i]=omo2; R[72]++; if(dbg){print "R72"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1036 !_#_! ==> dare_        sweep_  смели  сме́ли  смели́
xgrp="x1036";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( gl_in(-2) &&
          w(-1,"не") && s(-2,-1) )
 { l[i]=omo1; R[73]++; if(dbg){print "R73"}; continue };
 if ( gl_in(1) && s(0) )
 { l[i]=omo1; R[74]++; if(dbg){print "R74"}; continue };
 cst="даже лишь";
 if ( w(1,cst) &&
  gl_in(2) && s(0,1) )
 { l[i]=omo1; R[75]++; if(dbg){print "R75"}; continue };
 #
 if ( pre_ro(1) &&
           q(2,"suw_ro") && s(0,1) )
 { l[i]=omo2; R[76]++; if(dbg){print "R76"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1037 !_#_! ==> sw_ez_r_      zalt_     одуш-неодуш (мн.ч. оба) белки  бе́лки  белки́
xgrp="x1037";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[77]++; if(dbg){print "R77", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1038 !_#_! ==> sw_ez_r_      zalt_    неодуш. дрючки  дрю́чки  дрючки́
xgrp="x1038";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="дрючки") {
   if ( w(-1,"штучки") && sc(-1,"-") )
   { l[i]=omo1; R[78]++; if(dbg){print "R78"}; continue };
 };

 if ( sw_ez_r_f() )
 { l[i]=omo1; R[79]++; if(dbg){print "R79", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1039 !_#_! ==> sw_ez_r_      zalt_     лады  ла́ды  лады́
xgrp="x1039";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( qxs(-1,"на","все") )
 { l[i]=omo2; R[80]++; if(dbg){print "R80", "sw_ez_r_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[81]++; if(dbg){print "R81", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1040 !_#_! ==> sw_ez_r_      zalt_     заморозки  заморо́зки  за́морозки
xgrp="x1040";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[82]++; if(dbg){print "R82", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1041 !_#_! ==> pointer_      shooter_     стрелки  стре́лки  стрелки́ (формы мн.ч., морфологически неразличимые никак)
xgrp="x1041";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="датчик детектор диск индикатор прибор счётчик циферблат часы";
 if ( bw(1,cst) && s(0) )
 { l[i]=omo1; R[83]++; if(dbg){print "R83"}; continue };
 if ( pre_pr(1) &&
          bw(2,cst) && s(0,1) )
 { l[i]=omo1; R[84]++; if(dbg){print "R84"}; continue };
 if ( (q(1,"qik_ro")||ba(1,"_numeral")) &&
      bw(2,cst) && s(0,1) )
 { l[i]=omo1; R[85]++; if(dbg){print "R85"}; continue };
 #
 if ( bw(-1,"меткий") && s(-1) )
 { l[i]=omo2; R[86]++; if(dbg){print "R86"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[87]++; if(dbg){print "R87", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1042 !_#_! ==> sw_ez_r_      zalt_     стрелок  стре́лок  стрело́к
xgrp="x1042";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( name_im_sy(1) && s(0) )
 { l[i]=omo1; R[88]++; if(dbg){print "R88"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[89]++; if(dbg){print "R89", "sw_em_i_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[90]++; if(dbg){print "R90", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1043 !_#_! ==> sw_ez_r_      zalt_     стрелка  стре́лка  стрелка́
xgrp="x1043";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[91]++; if(dbg){print "R91", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[92]++; if(dbg){print "R92", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[93]++; if(dbg){print "R93", "sw_em_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1044 !_#_! ==> sw_ez_r_      zalt_     стрелке  стре́лке  стрелке́
xgrp="x1044";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[94]++; if(dbg){print "R94", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[95]++; if(dbg){print "R95", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[96]++; if(dbg){print "R96", "sw_ez_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1045 !_#_! ==> sw_ez_r_      zalt_     стрелку  стре́лку  стрелку́
xgrp="x1045";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[97]++; if(dbg){print "R97", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[98]++; if(dbg){print "R98", "sw_ez_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1046 !_#_! ==> stola_      table_     стола  сто́ла  стола́
xgrp="x1046";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="стола") {
   if ( q(-1,"prl_edzeim prq_edzeim mest_pedzeim") && s(-1) )
   { l[i]=omo1; R[99]++; if(dbg){print "R99"}; continue };
 };
 if(iwrd=="столе") {
   if ( q(-1,"prl_edzeda prq_edzeda mest_pedzeda") && s(-1) )
   { l[i]=omo1; R[100]++; if(dbg){print "R100"}; continue };
 };
 if(iwrd=="столу") {
   if ( q(-1,"prl_edzevi prq_edzevi mest_pedzevi") && s(-1) )
   { l[i]=omo1; R[101]++; if(dbg){print "R101"}; continue };
 };
 if(iwrd=="столы") {
   if ( q(-1,"prl_edzero prq_edzero mest_pedzero") && s(-1) )
   { l[i]=omo1; R[102]++; if(dbg){print "R102"}; continue };
 };

 # стол - по дефолту, стола - "одежда" - добавлять при обнаружении
 l[i]=omo2; R[103]++; if(dbg){print "R103", "table_"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1047 !_#_! ==> m2_1pl_kr_es_2nar_     nar_     полно  по́лно  полно́
xgrp="x1047";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( w(-1,"полным") && sc(-1,"-") )
 { l[i]=omo2; R[104]++; if(dbg){print "R104", "sw_em_d_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1048 !_#_! ==> mest_ems_p_     pl_kr_em_     нем  нём  не́м
xgrp="x1048";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="в на о об по при";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[105]++; if(dbg){print "R105"}; continue };

 l[i]=omo2; R[106]++; if(dbg){print "R106"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1049 !_#_! ==> aufrenn_  einrenn_   забегать забе́гать забега́ть и производные
xgrp="x1049";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="вбок вверх влево вниз вперед вправо";
 if ( w(1,cst) && s(0) )
 { l[i]=omo2; R[107]++; if(dbg){print "R107"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1050 !_#_! ==> disappear_  divide_   делись  де́лись  дели́сь
xgrp="x1050";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( wb(-5,-1,"куда никуда они вы мы") && s(wbn,-1) )
 { l[i]=omo1; R[108]++; if(dbg){print "R108"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1051 !_#_! ==> hday_  noon_   полудне  полудне́  полу́дне
xgrp="x1051";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="езды лету пути ходьбы";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[109]++; if(dbg){print "R109"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1052 !_#_! ==> hday_  noon_   полудню  полудню́  полу́дню
xgrp="x1052";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="езды лету пути ходьбы";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[110]++; if(dbg){print "R110"}; continue };
 if ( w(-1,"к") && s(-1) )
 { l[i]=omo2; R[111]++; if(dbg){print "R111"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1053 !_#_! ==> hday_  noon_   полудня  полудня́  полу́дня
xgrp="x1053";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"suw_ro") && s(0) )
 { l[i]=omo1; R[112]++; if(dbg){print "R112"}; continue };
 if ( q(-1,"pre_ro preph_ro") && s(-1) )
 { l[i]=omo2; R[113]++; if(dbg){print "R113"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1054 !_#_! ==> gl_bued1e_  gl_naed1e_   признаюсь  призна́юсь  признаю́сь
xgrp="x1054";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( p(-1) && p(0) )
 { l[i]=omo1; R[114]++; if(dbg){print "R114"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1055 !_#_! ==> mill_  wind_  ветряная  ветряна́я  ве́тряная
xgrp="x1055";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="двигатель мельница турбина установка";
 if ( bw(1,cst) && s(0) )
 { l[i]=omo1; R[115]++; if(dbg){print "R115"}; continue };
 if ( bw(1,"оспа") && s(0) )
 { l[i]=omo2; R[116]++; if(dbg){print "R116"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1056 !_#_! ==> mehl_  pain_  мука  мука́  му́ка
xgrp="x1056";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="белая каменный качественный косный низносортный овсяный пшеничный ржаной серая солёный сырой";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[117]++; if(dbg){print "R117"}; continue };

 cst="внутренний душевный звенящий истинный мучительный настоящий невыносимый немыслимый нестерпимый острый подлинный сильный страшный сущий ужасающий";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[118]++; if(dbg){print "R118"}; continue };
 if ( q(1,"mest_da suw_da") &&
      w(2,"с") &&
      q(3,"mest_tv suw_tv") && s(0,2) )
 { l[i]=omo2; R[119]++; if(dbg){print "R119"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1057 !_#_! ==> mehl_  pain_  (sw_ez_rz_  sw_mn_iv_)  муки  муки́  му́ки
xgrp="x1057";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="белая каменный качественный косный низносортный овсяный пшеничный ржаной серая солёный сырой";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[120]++; if(dbg){print "R120"}; continue };

 cst="внутренний душевный звенящий изнурительный истинный мучительный настоящий невыносимый немыслимый нестерпимый острый подлинный сильный страшный сущий ужасающий";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[121]++; if(dbg){print "R121"}; continue };
 #
 if ( sw_ez_z_f() )
 { l[i]=omo1; R[122]++; if(dbg){print "R122", "sw_ez_z_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[123]++; if(dbg){print "R123", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[124]++; if(dbg){print "R124", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[125]++; if(dbg){print "R125", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1058 !_#_! ==> atmen_  croak_  дохнуть  дохну́ть  до́хнуть
xgrp="x1058";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="вонь перегар смрад тепло холод";
 if ( q(1,"suw_tv") && bw(1,cst) && s(0) )
 { l[i]=omo1; R[126]++; if(dbg){print "R126"}; continue };

#cst="";
#if ( bw(-1,cst) && s(-1) )
#{ l[i]=omo2; R[127]++; if(dbg){print "R127"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1059 !_#_! ==> cowards_  trunks_  трусы  тру́сы  трусы́
xgrp="x1059";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#cst="вонь перегар смрад тепло холод";
#if ( q(1,"suw_tv") && bw(1,cst) && s(-1) )
#{ l[i]=omo1; R[128]++; if(dbg){print "R128"}; continue };

#cst="";
#if ( bw(-1,cst) && s(-1) )
#{ l[i]=omo2; R[129]++; if(dbg){print "R129"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1060 !_#_! ==> afraid_  shake_  трусить  тру́сить  труси́ть
xgrp="x1060";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#cst="вонь перегар смрад тепло холод";
#if ( q(1,"suw_tv") && bw(1,cst) && s(-1) )
#{ l[i]=omo1; R[130]++; if(dbg){print "R130"}; continue };

#cst="";
#if ( bw(-1,cst) && s(-1) )
#{ l[i]=omo2; R[131]++; if(dbg){print "R131"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1061 !_#_! ==> circum_  okrug_  окружной  окру́жной  окружно́й
xgrp="x1061";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="администратор инспектор начальник прокурор совет суд";
 if ( bw(1,cst) && s(0) )
 { l[i]=omo2; R[132]++; if(dbg){print "R132"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1062 !_#_! ==> domain_  furnace_  доменный  доме́нный  до́менный
xgrp="x1062";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 cst="печь производство технология";
 if ( bw(1,cst) && s(0) )
 { l[i]=omo2; R[133]++; if(dbg){print "R133"}; continue };
 #
 cst="владение организация структура";
 if ( q(1,"prl_any") && bw(1,cst) && s(0) )
 { l[i]=omo1; R[134]++; if(dbg){print "R134"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1063 !_#_! ==> word_hyphdef_  (default_)
xgrp="x1063";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="полна полно полны";
 if ( sc(0,"-") && w(1,cst) )
 { l[i]=omo1; R[135]++; if(dbg){print "R135"}; continue };

 l[i]=omo2; R[136]++; if(dbg){print "R136"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1064 !_#_! ==> poduwam_  zalt_  душам  душа́м  ду́шам
xgrp="x1064";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="беседовать говорить побеседовать поговорить";
 if ( w(-1,"по") && qb(-5,-2,"gl_in gl_ed gl_mn deep gl_poed gl_pomn prq_any") &&
     bw(qbn,cst) && s(qbn,-1) )
 { l[i]=omo1; R[137]++; if(dbg){print "R137"}; continue };
 if ( w(-1,"по") && vvb(-5,-2) && qb(vvn-5,vvn,"gl_in gl_ed gl_mn deep gl_poed gl_pomn prq_any") &&
     bw(qbn,cst) && s(-1) )
 { l[i]=omo1; R[138]++; if(dbg){print "R138"}; continue };

 l[i]=omo2; R[139]++; if(dbg){print "R139"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1065 !_#_! ==> pore_  time_  порах  по́рах  пора́х
xgrp="x1065";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( qxs(-1,"на","первых") )
 { l[i]=omo2; R[140]++; if(dbg){print "R140"}; continue };

 l[i]=omo1; R[141]++; if(dbg){print "R141"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1066 !_#_! ==> regiment_  shelf_  полках  полка́х  по́лках
xgrp="x1066";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if(iwrd=="полках") {
   if ( w(-2,"на") &&
        q(-1,"prl_mnpr prq_mnpr") && s(-2,-1) )
   { l[i]=omo2; R[142]++; if(dbg){print "R142"}; continue };
   if ( w(-1,"на") && s(-1) )
   { l[i]=omo2; R[143]++; if(dbg){print "R143"}; continue };
 };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1067 !_#_! ==> sw_ez_r_      zalt_    пары  па́ры  пары́
xgrp="x1067";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="влюбленные крепкие супружеские";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[144]++; if(dbg){print "R144"}; continue };
 cst="гулять идти кружиться танцевать";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[145]++; if(dbg){print "R145"}; continue };
 #
 cst="зловонные серные химические ядовитые";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[146]++; if(dbg){print "R146"}; continue };

 if ( sw_ez_r_f() )
 { l[i]=omo1; R[147]++; if(dbg){print "R147", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1068 !_#_! ==> eye_    peephole_    глазки  гла́́зки  глазки́
xgrp="x1068";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="бегать блестеть";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[148]++; if(dbg){print "R148"}; continue };
 cst="блестящий голубой злобный злой красный крошечный маленький поросячий свиной сонный цепкий";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[149]++; if(dbg){print "R149"}; continue };
 #
 cst="пуговка щёлочка";
 if ( sc(0,"-") &&
      bw(1,cst) )
 { l[i]=omo1; R[150]++; if(dbg){print "R150"}; continue };

 if ( q(1,"isname") && s(0) )
 { l[i]=omo1; R[151]++; if(dbg){print "R151"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1069 !_#_! ==> holey_    honst_    честной  честно́й  че́стной
xgrp="x1069";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="честная") {
   if ( w(-1,"мать") && s(-1) )
   { l[i]=omo1; R[152]++; if(dbg){print "R152"}; continue };
 };
 #
 if ( bw(-1,"весь") &&
      bw(1,"народ компания") && s(-1,0) )
 { l[i]=omo1; R[153]++; if(dbg){print "R153"}; continue };
 #
 l[i]=omo2; R[154]++; if(dbg){print "R154"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1070 !_#_! ==> cursed_    damned_    проклятый  про́клятый  прокля́тый (полная форма)
xgrp="x1070";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( bw(1,"душа") && s(0) )
 { l[i]=omo1; R[155]++; if(dbg){print "R155"}; continue };

 if(iwrd=="проклятого") {
   if ( q(1,"suw_edmuro suw_edsrro name_ro_sy") && s(0) )
   { l[i]=omo2; R[156]++; if(dbg){print "R156"}; continue };
 };
 if(iwrd=="проклятое") {
   if ( q(1,"suw_edsrim") && s(0) )
   { l[i]=omo2; R[157]++; if(dbg){print "R157"}; continue };
 };
 if(iwrd=="проклятом") {
   if ( q(1,"suw_edmupr suw_edsrpr") && s(0) )
   { l[i]=omo2; R[158]++; if(dbg){print "R158"}; continue };
 };
 if(iwrd=="проклятому") {
   if ( q(1,"suw_edmuda suw_edsrda") && s(0) )
   { l[i]=omo2; R[159]++; if(dbg){print "R159"}; continue };
 };
 if(iwrd=="проклятой") {
   if ( q(1,"suw_edzeda suw_edzero suw_edzetv suw_edzepr") && s(0) )
   { l[i]=omo2; R[160]++; if(dbg){print "R160"}; continue };
 };
 if(iwrd=="проклятою") {
   if ( q(1,"suw_edzetv") && s(0) )
   { l[i]=omo2; R[161]++; if(dbg){print "R161"}; continue };
 };
 if(iwrd=="проклятую") {
   if ( q(1,"suw_edzeim") && s(0) )
   { l[i]=omo2; R[162]++; if(dbg){print "R162"}; continue };
 };
 if(iwrd=="проклятые") {
   if ( w(-1,"как") && s(-1) && (p(0)||q_w(1,"pre_any")) )
   { l[i]=omo2; R[163]++; if(dbg){print "R163"}; continue };
   if ( q(1,"suw_mnim") && s(0) )
   { l[i]=omo2; R[164]++; if(dbg){print "R164"}; continue };
 };
 if(iwrd=="проклятый") {
   if ( q(1,"suw_edmuim") && s(0) )
   { l[i]=omo2; R[165]++; if(dbg){print "R165"}; continue };
 };
 if(iwrd=="проклятым") {
   if ( q(1,"suw_mnda") && s(0) )
   { l[i]=omo2; R[166]++; if(dbg){print "R166"}; continue };
 };
 if(iwrd=="проклятыми") {
   if ( q(1,"suw_mntv") && s(0) )
   { l[i]=omo2; R[167]++; if(dbg){print "R167"}; continue };
 };
 if(iwrd=="проклятых") {
   if ( q(1,"suw_mnro") && s(0) )
   { l[i]=omo2; R[168]++; if(dbg){print "R168"}; continue };
 };
 #
 if ( bw(-1,"это этого") && s(-1) )
 { l[i]=omo2; R[169]++; if(dbg){print "R169"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1071 !_#_! ==> cursed_    damned_    проклят  про́клят  прокля́т (краткая форма)
xgrp="x1071";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( bw(-1,"быть") && s(-1) )
 { l[i]=omo1; R[170]++; if(dbg){print "R170"}; continue };
 if ( bw(-2,"быть") &&
       q(-1,"mest_im") && s(-2,-1) )
 { l[i]=omo1; R[171]++; if(dbg){print "R171"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1072 !_#_! ==> pincer_    tick_    клещи  кле́щи  клещи́
xgrp="x1072";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="железные стальные";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[172]++; if(dbg){print "R172"}; continue };
#if ( bw(-2,cst) &&
#      q(-1,"pre_vi") && s(-2,-1) )
#{ l[i]=omo1; R[173]++; if(dbg){print "R173"}; continue };

 if ( sw_em_v_f() )
 { l[i]=omo1; R[174]++; if(dbg){print "R174", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1073 !_#_! ==> combo_   deep_na_   попадя   по́падя  попадя́
xgrp="x1073";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #

 if ( qxs(-1,"кто где что когда","ни") )
 { l[i]=omo1; R[175]++; if(dbg){print "R175"}; continue };

 if ( q(1,"pre_vi") )
 { l[i]=omo2; R[176]++; if(dbg){print "R176"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1074 !_#_! ==> must_     needs_  должно  должно́  до́лжно
xgrp="x1074";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(-2,"gl_poed gl_pomn") &&
      w(-1,"как что") && s(-2,-1) )
 { l[i]=omo2; R[177]++; if(dbg){print "R177"}; continue };
 if ( q(-2,"mest_da suw_da") &&
      q(-1,"gl_in") && s(-2,-1) && p(1) )
 { l[i]=omo2; R[178]++; if(dbg){print "R178"}; continue };

 l[i]=omo1; R[179]++; if(dbg){print "R179"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1075 !_#_! ==> knead_     remember_  помните  помни́те  по́мните
xgrp="x1075";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"pre_any") && s(0) )
 { l[i]=omo2; R[180]++; if(dbg){print "R180"}; continue };
 if ( p(-1) && p(0) )
 { l[i]=omo2; R[181]++; if(dbg){print "R181"}; continue };
 if ( w(-1,"не") && s(-1) && p(0) )
 { l[i]=omo2; R[182]++; if(dbg){print "R182"}; continue };
 if ( w(1,"же") && s(0) && p(-1) && p(1) )
 { l[i]=omo2; R[183]++; if(dbg){print "R183"}; continue };
 if ( q(1,"mest_3e") && s(0) && p(-1) && p(1) )
 { l[i]=omo2; R[184]++; if(dbg){print "R184"}; continue };
 #
 if ( q(-4,"gl_poed gl_pomn gl_povzmn") &&
      w(-3,"что") &&
      q(-2,"gl_ed gl_nemn gl_vzmn gl_pemn gl_pnmn") &&
      w(-1,"и") && s(-4,-1) )
 { l[i]=omo2; R[185]++; if(dbg){print "R185"}; continue };
 #
 if ( qxs(-1,"так","что вот") )
 { l[i]=omo2; R[186]++; if(dbg){print "R186"}; continue };
 if ( w(-2,"а да") &&
      w(-1,"вы") && s(-2,-1) && Q_w(1,"mest_da suw_da") )
 { l[i]=omo2; R[187]++; if(dbg){print "R187"}; continue };
 if ( w(-2,"вы") &&
      w(-1,"только лучше") && s(-2,-1) )
 { l[i]=omo2; R[188]++; if(dbg){print "R188"}; continue };
 if ( w(-3,"вы") &&
      q(-2,"mest_vi suw_vi") &&
      w(-1,"не") && s(-3,-1) && p(0,"?") )
 { l[i]=omo2; R[189]++; if(dbg){print "R189"}; continue };

 if ( wb(-5,-1,"будто где если зачем когда коли которого которую которые который которых куда насколько небось откуда пока почему пошто сколько что") &&
      (q(wbn-1,"sz qast")||p(wbn-1)||sc(wbn-1,"[pv]")) && s(wbn,-1) )
 { l[i]=omo2; R[190]++; if(dbg){print "R190"}; continue };
 #
 if ( wb(-5,-2,"как") &&
       w(wbn-1,"бы долго же") && s(wbn,-1) )
 { l[i]=omo2; R[191]++; if(dbg){print "R191"}; continue };
 #
 if ( wb(-5,-1,"вы") && s(wbn,-1) )
 { l[i]=omo2; R[192]++; if(dbg){print "R192"}; continue };
 #
 if ( sc(0,"?") )
 { l[i]=omo2; R[193]++; if(dbg){print "R193"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1076 !_#_! ==> equals_    zalt_  равно  равно́  ра́вно
xgrp="x1076";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"а") && w(1,"и") && s(-1,0) )
 { l[i]=omo2; R[194]++; if(dbg){print "R194"}; continue };
 if ( qxs(1,"как","и") )
 { l[i]=omo2; R[195]++; if(dbg){print "R195"}; continue };

 l[i]=omo1; R[196]++; if(dbg){print "R196"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1077 !_#_! ==> settled_    universe_  вселенная  вселённая  вселе́нная
xgrp="x1077";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="город дом квартира комната тело хата человек";
 if ( w(1,"в") && p(-1) &&
     bw(2,cst) &&
suw_any(3) && s(0,2) )
 { l[i]=omo1; R[197]++; if(dbg){print "R197"}; continue };

 l[i]=omo2; R[198]++; if(dbg){print "R198"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1078 !_#_! ==> poop_    which_  каком  ка́ком  како́м
xgrp="x1078";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( w(1,"кверху") && s(0) )
 { l[i]=omo1; R[199]++; if(dbg){print "R199"}; continue };

 cst="либо нибудь то";
 if ( sL(0,"-") && w(1,cst) )
 { l[i]=omo2; R[200]++; if(dbg){print "R200"}; continue };
#if ( sL(0,"-") && w(1,"то") )
#{ l[i]=omo2; l[i+1]=gensub(/^(.+)$/,"\xcc\xa0\\1\xcc\xa0",1,l[i+1]); R[201]++; if(dbg){print "R201"}; continue };

 l[i]=omo2; R[202]++; if(dbg){print "R202"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1079 !_#_! ==> land_    hyph_  россия  росси́я  ро́ссия
xgrp="x1079";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="бело ново старо черно";
 if ( sL(-1,"-") && w(-1,cst) && cap(-1) && cap(0) )
 { l[i]=omo2; R[203]++; if(dbg){print "R203"}; continue };

 l[i]=omo1; R[204]++; if(dbg){print "R204"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1080 !_#_! ==> color_    hyph_  белым   бе́лым  белы́м
xgrp="x1080";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="бело черно";
 if ( sR(1,"-") && w(1,cst) )
 { l[i]=omo2; R[205]++; if(dbg){print "R205"}; continue };

 l[i]=omo1; R[206]++; if(dbg){print "R206"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x1111 !_#_! ==> vsje_    vsyo_   все  все́  всё
 #    переработка функции
 #    файл ext/x1111.awk

 x1111_f() # если подключена "старая" функция "все", то выйти

 #--------------------------------------------------------------------------------------

###   x2001 !_#_! ==> deep_na_      mest_ez_i_   моя  мо́я  моя́
xgrp="x2001";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( suw_edzeim(1) && Q(1,"suw_edzevi") && s(0) )
 { l[i]=omo2; R[207]++; if(dbg){print "R207"}; continue };
 if ( p(-1) && sc(1,"—") )
 { l[i]=omo2; R[208]++; if(dbg){print "R208"}; continue };
 if ( suw_edzeim(1) && s(0) && p(1,",") )
 { l[i]=omo2; R[209]++; if(dbg){print "R209"}; continue };
 if ( suw_edzeim(1) && s(0) && sc(-1,"—") )
 { l[i]=omo2; R[210]++; if(dbg){print "R210"}; continue };
 if ( name_im_sy(1) && s(0) )
 { l[i]=omo2; R[211]++; if(dbg){print "R211"}; continue };
 if ( q(1,"suw_edzeim nar_spos") &&
     qf(2,6,"gl_ed prl_kred_ze gl_paedze") && s(0,qfn-1) )
 { l[i]=omo2; R[212]++; if(dbg){print "R212"}; continue };
 if ( p(-1) && p(0) )
 { l[i]=omo2; R[213]++; if(dbg){print "R213"}; continue };
 if ( q(-2,"mest_im suw_im") && s(-2,-1) &&
      w(-1,"и или да да") &&
           suw_edzeim(1) && s(-2,0) )
 { l[i]=omo2; R[214]++; if(dbg){print "R214"}; continue };
 if ( p(-3) &&
         nar_step(-2) && s(-2,-1) &&
      w(-1,"не") && p(0) )
 { l[i]=omo2; R[215]++; if(dbg){print "R215"}; continue };
 if ( p(-2) && suw_edzeim(-1) && p(0) && s(-1) )
 { l[i]=omo2; R[216]++; if(dbg){print "R216"}; continue };
 if ( suw_edzeim(-1) &&
              qf(1,5,"gl_ed prl_kred_ze gl_paedze") && s(-1,qfn-1) )
 { l[i]=omo2; R[217]++; if(dbg){print "R217"}; continue };
 if ( q(-1,"prl_edzeim prq_edzeim prl_kred_ze gl_ed mest_im") &&
           suw_edzeim(1) && s(-1,0) )
 { l[i]=omo2; R[218]++; if(dbg){print "R218"}; continue };
 if ( q(1,"prl_edzeim prq_edzeim prl_kred_ze") && s(0) )
 { l[i]=omo2; R[219]++; if(dbg){print "R219"}; continue };
 if ( p(0)||q_w(1,"pre_any") )
 { l[i]=omo2; R[220]++; if(dbg){print "R220"}; continue };

 cst="вот и как не но она это";

 if ( w(-1,cst) &&
           suw_edzeim(1) && s(0) && p(1) )
 { l[i]=omo2; R[221]++; if(dbg){print "R221"}; continue };
 if ( p(-2) &&  w(-1,cst) && s(-1) && p(0) )
 { l[i]=omo2; R[222]++; if(dbg){print "R222"}; continue };

 cst="";

 if ( mest_im(-2) && q(-1,"suw_im") && s(-2) && z(-1) &&
     suw_edim(1) && s(0) && p(1) )
 { l[i]=omo2; R[223]++; if(dbg){print "R223"}; continue };
 if ( suw_edim(1) && s(0) && p(1) &&
       mest_im(2) && q(3,"suw_im") && s(2) && p(3) )
 { l[i]=omo2; R[224]++; if(dbg){print "R224"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[225]++; if(dbg){print "R225"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[226]++; if(dbg){print "R226"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2002 !_#_! ==> deep_na_      sw_1em_r_2ez_i_  туша  туша́  ту́ша
xgrp="x2002";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[227]++; if(dbg){print "R227", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[228]++; if(dbg){print "R228", "sw_em_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[229]++; if(dbg){print "R229"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[230]++; if(dbg){print "R230"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2003 !_#_! ==> deep_na_      sw_em_r_
xgrp="x2003";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[231]++; if(dbg){print "R231", "sw_em_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[232]++; if(dbg){print "R232"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[233]++; if(dbg){print "R233"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2004 !_#_! ==> deep_na_      sw_em_vr_
xgrp="x2004";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[234]++; if(dbg){print "R234", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[235]++; if(dbg){print "R235", "sw_em_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[236]++; if(dbg){print "R236"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[237]++; if(dbg){print "R237"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2005 !_#_! ==> deep_na_      sw_es_r_   горя  горя́  го́ря
xgrp="x2005";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[238]++; if(dbg){print "R238", "sw_es_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[239]++; if(dbg){print "R239"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[240]++; if(dbg){print "R240"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2006 !_#_! ==> deep_na_      sw_ez_i_
xgrp="x2006";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[241]++; if(dbg){print "R241", "sw_ez_i_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[242]++; if(dbg){print "R242"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[243]++; if(dbg){print "R243"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2007 !_#_! ==> deep_pa_      sw_em_iv_
xgrp="x2007";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[244]++; if(dbg){print "R244", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[245]++; if(dbg){print "R245", "sw_em_v_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[246]++; if(dbg){print "R246"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[247]++; if(dbg){print "R247"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2008 !_#_! ==> deep_pa_      sw_em_r_
xgrp="x2008";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[248]++; if(dbg){print "R248", "sw_em_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[249]++; if(dbg){print "R249"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[250]++; if(dbg){print "R250"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2009 !_#_! ==> deep_pa_      sw_ez_i_
xgrp="x2009";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[251]++; if(dbg){print "R251", "sw_ez_i_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[252]++; if(dbg){print "R252"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[253]++; if(dbg){print "R253"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2010 !_#_! ==> deep_pa_      sw_mn_r_
xgrp="x2010";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[254]++; if(dbg){print "R254", "sw_mn_r_f"}; continue };
 #
 if ( p(-1) && q(1,"mest_vi prl_vi prq_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[255]++; if(dbg){print "R255"}; continue };
 if ( p(-1) && q(1,"suw_vi mest_vi") && s(0) )
 { l[i]=omo1; R[256]++; if(dbg){print "R256"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2011 !_#_! ==> gl_ed1e_      m2_1sw_em_d_2pl_ez_t_
xgrp="x2011";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[257]++; if(dbg){print "R257", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[258]++; if(dbg){print "R258", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2012 !_#_! ==> gl_ed1e_      mest_ez_v_  мою  мо́ю  мою́   свою
xgrp="x2012";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="свою") {
   if ( w(1,"ка") && sL(0,"-") )
   { l[i]=omo1; R[259]++; if(dbg){print "R259"}; continue };

   l[i]=omo1; R[260]++; if(dbg){print "R260"}; continue # свою́
 };
 #
 if ( pre_vi(-1) &&
           q(1,"prl_edvi prq_edvi") &&
    suw_edvi(2) && s(-1,1) )
 { l[i]=omo2; R[261]++; if(dbg){print "R261"}; continue };
 if ( pre_vi(-1) &&
    suw_edvi(1) && s(-1,0) )
 { l[i]=omo2; R[262]++; if(dbg){print "R262"}; continue };
 #
 if ( qb(-3,-1,"gl_pe deep_pe gl_pned gl_pnmn gl_pein gl_pnin deep_pn") &&
     qir(qbn+1,-1,"nar_any mest_da mest_tv suw_da suw_tv") )
 { l[i]=omo2; R[263]++; if(dbg){print "R263", "gl_ed1e_f"}; continue };
 #
#if ( gl_ed1e_f() )
#{ l[i]=omo1; R[264]++; if(dbg){print "R264", "gl_ed1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2013 !_#_! ==> gl_ed1e_      qip_ez_v_
xgrp="x2013";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[265]++; if(dbg){print "R265", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2014 !_#_! ==> gl_ed1e_      sw_1em_d_2ez_v_
xgrp="x2014";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[266]++; if(dbg){print "R266", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[267]++; if(dbg){print "R267", "sw_ez_v_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[268]++; if(dbg){print "R268", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2015 !_#_! ==> gl_ed1e_      sw_1em_v_2ez_vd_
xgrp="x2015";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(1,"suw_ro") && s(0) )
 { l[i]=omo2; R[269]++; if(dbg){print "R269"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[270]++; if(dbg){print "R270", "sw_ez_d_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[271]++; if(dbg){print "R271", "sw_em_v_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[272]++; if(dbg){print "R272", "sw_ez_v_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[273]++; if(dbg){print "R273", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2016 !_#_! ==> gl_ed1e_      sw_em_d_
xgrp="x2016";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="тону") {
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo2; R[274]++; if(dbg){print "R274"}; continue };
 };
 if ( gl_in(1) && s(0) )
 { l[i]=omo1; R[275]++; if(dbg){print "R275"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[276]++; if(dbg){print "R276", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[277]++; if(dbg){print "R277", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2017 !_#_! ==> gl_ed1e_      sw_em_dr_
xgrp="x2017";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="толку") {
   if ( w(-1,"что") && s(-1) )
   { l[i]=omo2; R[278]++; if(dbg){print "R278"}; continue };
   if ( w(1,"от") &&
        q(2,"mest_vi suw_vi") && s(0,1) )
   { l[i]=omo2; R[279]++; if(dbg){print "R279"}; continue };
 };
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[280]++; if(dbg){print "R280", "sw_em_d_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[281]++; if(dbg){print "R281", "sw_em_r_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[282]++; if(dbg){print "R282", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2018 !_#_! ==> gl_ed1e_      sw_em_iv_
xgrp="x2018";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[283]++; if(dbg){print "R283", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[284]++; if(dbg){print "R284", "sw_em_v_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[285]++; if(dbg){print "R285", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2019 !_#_! ==> gl_ed1e_      sw_ems_d_
xgrp="x2019";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[286]++; if(dbg){print "R286", "sw_em_d_f"}; continue };
 #
 if ( sw_es_d_f() )
 { l[i]=omo2; R[287]++; if(dbg){print "R287", "sw_es_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[288]++; if(dbg){print "R288", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2020 !_#_! ==> gl_ed1e_      sw_em_t_
xgrp="x2020";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[289]++; if(dbg){print "R289", "sw_em_t_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[290]++; if(dbg){print "R290", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2021 !_#_! ==> gl_ed1e_      sw_es_d_
xgrp="x2021";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="утру") {
   if ( w(-1,"к") && s(-1) )
   { l[i]=omo1; R[291]++; if(dbg){print "R291"}; continue };
 };
 #
 if ( sw_es_d_f() )
 { l[i]=omo2; R[292]++; if(dbg){print "R292", "sw_es_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[293]++; if(dbg){print "R293", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2022 !_#_! ==> gl_ed1e_      sw_ez_t_
xgrp="x2022";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[294]++; if(dbg){print "R294", "sw_ez_t_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[295]++; if(dbg){print "R295", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2023 !_#_! ==> gl_ed1e_      sw_ez_v_
xgrp="x2023";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="веду") {
   if ( w(-1,"себя") && s(-1) )
   { l[i]=omo1; R[296]++; if(dbg){print "R296"}; continue };
   if ( w(1,"себя") && s(0) )
   { l[i]=omo1; R[297]++; if(dbg){print "R297"}; continue };
   if ( qxs(1,"я","вот","к")||
        qxs(1,"я","к") )
   { l[i]=omo1; R[298]++; if(dbg){print "R298"}; continue };
 };
 if(iwrd=="уйму") {
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo2; R[299]++; if(dbg){print "R299"}; continue };
 };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[300]++; if(dbg){print "R300", "sw_ez_v_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[301]++; if(dbg){print "R301", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2024 !_#_! ==> gl_ed1e_      sw_mn_d_
xgrp="x2024";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_d_f() )
 { l[i]=omo2; R[302]++; if(dbg){print "R302", "sw_mn_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[303]++; if(dbg){print "R303", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2025 !_#_! ==> gl_ed3e_      pl_kr_em_
xgrp="x2025";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#if ( gl_ed3e_f() )
#{ l[i]=omo1; R[304]++; if(dbg){print "R304"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo2; R[305]++; if(dbg){print "R305", "pl_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2026 !_#_! ==> gl_ed3e_      sw_em_iv_
xgrp="x2026";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_ed3e_f() )
 { l[i]=omo1; R[306]++; if(dbg){print "R306", "gl_ed3e_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[307]++; if(dbg){print "R307", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[308]++; if(dbg){print "R308", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2027 !_#_! ==> gl_ed3e_      sw_mn_r_
xgrp="x2027";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_ed3e_f() )
 { l[i]=omo1; R[309]++; if(dbg){print "R309", "gl_ed3e_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[310]++; if(dbg){print "R310", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2028 !_#_! ==> gl_inf_       sw_1ez_dpr_2mn_iv_
xgrp="x2028";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="вести") {
   if ( w(-1,"себя") && s(-1) )
   { l[i]=omo1; R[311]++; if(dbg){print "R311"}; continue };
   if ( w(1,"себя") && s(0) )
   { l[i]=omo1; R[312]++; if(dbg){print "R312"}; continue };
   if ( w(1,"о об") && s(0) )
   { l[i]=omo2; R[313]++; if(dbg){print "R313"}; continue };
 };
 #
 if ( gl_inf_f() )
 { l[i]=omo1; R[314]++; if(dbg){print "R314", "gl_inf_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[315]++; if(dbg){print "R315", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[316]++; if(dbg){print "R316", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[317]++; if(dbg){print "R317", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[318]++; if(dbg){print "R318", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[319]++; if(dbg){print "R319", "sw_mn_v_f"}; continue };


 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2029 !_#_! ==> gl_inf_       sw_ez_iv_
xgrp="x2029";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="подать") {
   if ( w(-1,"рукой") && s(-1) )
   { l[i]=omo1; R[320]++; if(dbg){print "R320"}; continue };
 };
 #
 if ( gl_inf_f() )
 { l[i]=omo1; R[321]++; if(dbg){print "R321", "sw_ez_i_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[322]++; if(dbg){print "R322", "sw_ez_i_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[323]++; if(dbg){print "R323", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2030 !_#_! ==> gl_mn1e_      mest_ems_p_
xgrp="x2030";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[324]++; if(dbg){print "R324", "gl_mn1e_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2031 !_#_! ==> gl_mn1e_      pl_ems_p_
xgrp="x2031";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[325]++; if(dbg){print "R325", "gl_mn1e_f"}; continue };
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo2; R[326]++; if(dbg){print "R326", "pl_em_p_f()||pl_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2032 !_#_! ==> gl_mn1e_      pl_kr_em_   несовершенный вид
xgrp="x2032";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="переходим") {
   cst="в из на под через";
   if ( w(1,cst) && s(0) )
   { l[i]=omo1; R[327]++; if(dbg){print "R327"}; continue };
 };
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[328]++; if(dbg){print "R328", "gl_mn1e_f"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo2; R[329]++; if(dbg){print "R329", "pl_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2033 !_#_! ==> gl_mn1e_      pq_kr_em_    совершенный вид
xgrp="x2033";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[330]++; if(dbg){print "R330", "gl_mn1e_f"}; continue };
 #
 if ( pq_kr_em_f() )
 { l[i]=omo2; R[331]++; if(dbg){print "R331", "pq_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2034 !_#_! ==> gl_mn1e_      sw_em_iv_
xgrp="x2034";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[332]++; if(dbg){print "R332", "gl_mn1e_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[333]++; if(dbg){print "R333", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[334]++; if(dbg){print "R334", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2035 !_#_! ==> gl_mn1e_      sw_em_t_
xgrp="x2035";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[335]++; if(dbg){print "R335", "gl_mn1e_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[336]++; if(dbg){print "R336", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2036 !_#_! ==> gl_mn1e_      sw_es_t_
xgrp="x2036";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[337]++; if(dbg){print "R337", "gl_mn1e_f"}; continue };
 #
 if ( sw_es_t_f() )
 { l[i]=omo2; R[338]++; if(dbg){print "R338", "sw_es_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2037 !_#_! ==> gl_mn1e_      sw_mn_r_
xgrp="x2037";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[339]++; if(dbg){print "R339", "gl_mn1e_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[340]++; if(dbg){print "R340", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2038 !_#_! ==> gl_mn2e_      gl_pomn_
xgrp="x2038";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn2e_f() )
 { l[i]=omo1; R[341]++; if(dbg){print "R341", "gl_mn2e_f"}; continue };
 #
 if ( gl_pomn_f() )
 { l[i]=omo2; R[342]++; if(dbg){print "R342", "gl_pomn_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2039 !_#_! ==> gl_mn2e_      m2_1sw_em_p_2gl_pomn_
xgrp="x2039";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn2e_f() )
 { l[i]=omo1; R[343]++; if(dbg){print "R343", "gl_mn2e_f"}; continue };
 #
 if ( gl_pomn_f() )
 { l[i]=omo2; R[344]++; if(dbg){print "R344", "gl_pomn_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[345]++; if(dbg){print "R345", "sw_em_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2040 !_#_! ==> gl_mn2e_      sw_em_p_
xgrp="x2040";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn2e_f() )
 { l[i]=omo1; R[346]++; if(dbg){print "R346", "gl_mn2e_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[347]++; if(dbg){print "R347", "sw_em_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2041 !_#_! ==> gl_mn2e_      sw_ez_dp_
xgrp="x2041";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[348]++; if(dbg){print "R348", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[349]++; if(dbg){print "R349", "sw_ez_p_f"}; continue };
 #
 if ( gl_mn2e_f() )
 { l[i]=omo1; R[350]++; if(dbg){print "R350", "gl_mn2e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2042 !_#_! ==> gl_mn3e_      pq_kr_em_
xgrp="x2042";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pq_kr_em_f() )
 { l[i]=omo2; R[351]++; if(dbg){print "R351", "pq_kr_em_f"}; continue };
 #
 if ( gl_mn3e_f() )
 { l[i]=omo1; R[352]++; if(dbg){print "R352", "gl_mn1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2043 !_#_! ==> gl_mn3e_      sw_mn_r_
xgrp="x2043";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[353]++; if(dbg){print "R353", "sw_mn_r_f"}; continue };
 #
 if ( gl_mn3e_f() )
 { l[i]=omo1; R[354]++; if(dbg){print "R354", "gl_mn1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2044 !_#_! ==> gl_mn3e_      sw_mn_vr_
xgrp="x2044";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[355]++; if(dbg){print "R355", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[356]++; if(dbg){print "R356", "sw_mn_r_f"}; continue };
 #
 if ( gl_mn3e_f() )
 { l[i]=omo1; R[357]++; if(dbg){print "R357", "gl_mn1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2045 !_#_! ==> gl_paedmu_pe_	  m2_1pl_kr_em_2gl_paedmu_ne_  умел  умёл  уме́л
xgrp="x2045";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"prl_kred_sr nar_spos") &&
  gl_in(2) && s(0,1) )
 { l[i]=omo2; R[358]++; if(dbg){print "R358"}; continue };
 if ( gl_in(1) && s(0) )
 { l[i]=omo2; R[359]++; if(dbg){print "R359"}; continue };
 if ( pl_kr_em_f() )
 { l[i]=omo2; R[360]++; if(dbg){print "R360", "pl_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2046 !_#_! ==> gl_paedmu_    pl_kr_em_  смел  смёл  сме́л
xgrp="x2046";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"не") &&
     qf(1,3,"gl_in") && s(-1,qfn-1) )
 { l[i]=omo2; R[361]++; if(dbg){print "R361"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo2; R[362]++; if(dbg){print "R362", "pl_kr_em_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2047 !_#_! ==> gl_paedmu_    sw_1em_i_2mn_r_
xgrp="x2047";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[363]++; if(dbg){print "R363", "gl_paedmu_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[364]++; if(dbg){print "R364", "sw_em_i_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[365]++; if(dbg){print "R365", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2048 !_#_! ==> gl_paedmu_    sw_1em_iv_2mn_r_
xgrp="x2048";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[366]++; if(dbg){print "R366", "gl_paedmu_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[367]++; if(dbg){print "R367", "sw_mn_r_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[368]++; if(dbg){print "R368", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[369]++; if(dbg){print "R369", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2049 !_#_! ==> gl_paedmu_    sw_em_i_
xgrp="x2049";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="осел") {
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo2; R[370]++; if(dbg){print "R370"}; continue };
 };
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[371]++; if(dbg){print "R371", "gl_paedmu_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[372]++; if(dbg){print "R372", "sw_em_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2050 !_#_! ==> gl_paedmu_    sw_em_iv_
xgrp="x2050";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
#if ( weq(iwrd,"берег") && q(1,"suw_ro") && Q(1,"suw_vi") && s(0) )
#{ print l[i+1] >> "_sw.txt"; R[373]++; if(dbg){print "R373"}; }; continue
 #
 cst0="берег варю вести весь водила гвозди государя дел дела дело день для дождя души душу еду запас коли коля минут мой мою начала начало осени переднюю покой почту \
       при разлив рубило рыло свей сей тай тони умело царя шлем";
 if ( qfv(1,4,"gl_ed gl_mn gl_vzmn deep gl_po",cst0) && s(0,qfn-1) &&
     !(se(0,"-")&&veq(qfn,1)) && Q(qfn,"isname") &&
      qir(1,qfn-1,"prl_kred_sr nar_spos nar_mest nar_step qast_any mod_any suw_tv mest_tv prl_tv isname") && s(0,qfn-1) )
 {  l[i]=omo2; R[374]++; if(dbg){print "R374"}; continue };
 if ( qbv(-4,-1,"gl_ed gl_mn gl_vzmn deep gl_po",cst0) && s(qbn,-1) && !(se(-1,"-")&&veq(qbn,-1)) && Q_w(qbn,"isname") &&
      qir(qbn+1,-1,"prl_kred_sr nar_spos nar_mest nar_step qast_any mest_im prl_edmuim suw_tv mest_tv prl_tv isname") && s(qbn,-1) )
 {  l[i]=omo2; R[375]++; if(dbg){print "R375"}; continue };

 cst0="вести знать честь";
 if ( qf(1,4,"gl_in") && !(se(0,"-")&&veq(qfn,1)) && W(qfn,cst0) && Q(qfn,"isname") &&
     qir(1,qfn-1,"prl_kred_sr nar_spos nar_mest nar_step qast_any mod_any") && s(0,qfn-1) )
 {  l[i]=omo2; R[376]++; if(dbg){print "R376"}; continue };
 if ( qb(-4,-1,"gl_in") && !(se(-1,"-")&&veq(qbn,-1)) && W(qbn,cst0) &&
     qir(qbn+1,-1,"prl_kred_sr nar_spos nar_mest nar_step qast_any mest_im prl_edmuim isname") && s(qbn,-1) )
 {  l[i]=omo2; R[377]++; if(dbg){print "R377"}; continue };

 if ( qb(-4,-1,"prq_edmuim") &&
     qir(qbn+1,-1,"prl_kred_sr nar_spos nar_mest nar_step qast_any mest_im prl_edmuim suw_tv prl_tv mest_tv") && s(qbn,-1) )
 {  l[i]=omo2; R[378]++; if(dbg){print "R378"}; continue };
 #
 cst="замер запах обмер перемер погреб";
 if( weq(iwrd,cst) ) {
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo2; R[379]++; if(dbg){print "R379"}; continue };
 };
 cst="берег отсек погреб";
 if( weq(iwrd,cst) ) {
    cst="близко недалеко рядом";
   if ( w(1,cst) && s(0) )
   { l[i]=omo2; R[380]++; if(dbg){print "R380"}; continue };
   if ( wfa(1,4,"_coast_suw-ro") && s(0,wfn-1) &&
        qir(1,wfn-1,"prl_ro mest_ro prq_ro") )
   { l[i]=omo2; R[381]++; if(dbg){print "R381"}; continue };
 };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[382]++; if(dbg){print "R382", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[383]++; if(dbg){print "R383", "sw_em_v_f"}; continue };
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[384]++; if(dbg){print "R384", "gl_paedmu_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2051 !_#_! ==> gl_paedmu_	sw_mn_r_
xgrp="x2051";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[385]++; if(dbg){print "R385", "sw_mn_r_f"}; continue };
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[386]++; if(dbg){print "R386", "gl_paedmu_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2052 !_#_! ==> gl_paedmu_    sw_mn_vr_
xgrp="x2052";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[387]++; if(dbg){print "R387", "gl_paedmu_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[388]++; if(dbg){print "R388", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[389]++; if(dbg){print "R389", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2053 !_#_! ==> gl_paedsr_    sw_es_iv_
xgrp="x2053";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="начало") {
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[390]++; if(dbg){print "R390"}; continue };
   if ( q(1,"prl_kred_sr prq_kred_sr") && s(0) && Q_w(2,"gl_in") )
   { l[i]=omo2; R[391]++; if(dbg){print "R391"}; continue };
   if ( q(1,"suw_ro") && s(0) )
   { l[i]=omo2; R[392]++; if(dbg){print "R392"}; continue };
 };
 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[393]++; if(dbg){print "R393", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[394]++; if(dbg){print "R394", "sw_es_v_f"}; continue };
 #
 if ( gl_paedsr_f() )
 { l[i]=omo1; R[395]++; if(dbg){print "R395", "gl_paedsr_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2054 !_#_! ==> m2_1sw_es_r_2gl_paedze_  sw_mn_iv_  дела   де́ла   дела́
xgrp="x2054";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qxs(-1,"для","пользы") )
 { l[i]=omo1; R[396]++; if(dbg){print "R396"}; continue };
 if ( wb(-5,-1,"как") && s(wbn,-1) )
 { l[i]=omo2; R[397]++; if(dbg){print "R397"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[398]++; if(dbg){print "R398", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[399]++; if(dbg){print "R399", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[400]++; if(dbg){print "R400", "sw_mn_v_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[401]++; if(dbg){print "R401", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2055 !_#_! ==> gl_paedze_    sw_1es_r_2mn_iv_
xgrp="x2055";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="начала") {
   if ( w(-2,"с до") &&
        w(-1,"самого") && s(-2,-1) )
   { l[i]=omo2; R[402]++; if(dbg){print "R402"}; continue };
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[403]++; if(dbg){print "R403"}; continue };
   if ( (suw_edzeim(1)||w(1,"она")) && s(0) )
   { l[i]=omo1; R[404]++; if(dbg){print "R404"}; continue };
 };
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[405]++; if(dbg){print "R405", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[406]++; if(dbg){print "R406", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[407]++; if(dbg){print "R407", "sw_mn_v_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[408]++; if(dbg){print "R408", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2056 !_#_! ==> gl_paedze_    sw_em_i_
xgrp="x2056";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[409]++; if(dbg){print "R409", "sw_em_i_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[410]++; if(dbg){print "R410", "gl_paedze_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2057 !_#_! ==> gl_paedze_    sw_em_r_
xgrp="x2057";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[411]++; if(dbg){print "R411", "sw_em_r_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[412]++; if(dbg){print "R412", "gl_paedze_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2058 !_#_! ==> gl_pamn_      gl_poed_
xgrp="x2058";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="попали") {
   if ( wb(-5,-1,"как куда никуда они вы мы") && s(wbn,-1) )
   { l[i]=omo1; R[413]++; if(dbg){print "R413"}; continue };
   if ( q(1,"pre_vi") && s(0) )
   { l[i]=omo1; R[414]++; if(dbg){print "R414", "gl_pamn_f"}; continue };
 };
 if(iwrd=="дели") {
   if ( wb(-5,-1,"куда никуда они вы мы") && s(wbn,-1) )
   { l[i]=omo1; R[415]++; if(dbg){print "R415"}; continue };
 };
 if(iwrd=="пили") {
   cst="вино виски водки воду какао кофе минералку пиво самогон сок чай";
   if ( w(1,cst) && s(0) )
   { l[i]=omo1; R[416]++; if(dbg){print "R416"}; continue };
 };
 #
 if ( w(1,"под") && s(0) )
 { l[i]=omo1; R[417]++; if(dbg){print "R417", "gl_pamn_f"}; continue };
 if ( q(-1,"mest_da suw_da") && s(-1) )
 { l[i]=omo1; R[418]++; if(dbg){print "R418", "gl_pamn_f"}; continue };

 if ( wb(-5,-1,"пока если когда") && s(wbn,-1) )
 { l[i]=omo1; R[419]++; if(dbg){print "R419"}; continue };
 #
 if ( gl_pamn_f() )
 { l[i]=omo1; R[420]++; if(dbg){print "R420", "gl_pamn_f"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo2; R[421]++; if(dbg){print "R421", "gl_poed_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2059 !_#_! ==> gl_pamn_      nar_mest_
xgrp="x2059";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_pamn_f() )
 { l[i]=omo1; R[422]++; if(dbg){print "R422", "gl_pamn_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2060 !_#_! ==> gl_pamn_      sw_1ez_dpr_2mn_iv_
xgrp="x2060";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_pamn_f() )
 { l[i]=omo1; R[423]++; if(dbg){print "R423", "gl_pamn_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[424]++; if(dbg){print "R424", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[425]++; if(dbg){print "R425", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[426]++; if(dbg){print "R426", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[427]++; if(dbg){print "R427", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[428]++; if(dbg){print "R428", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2061 !_#_! ==> gl_pamn_      sw_1ez_r_2mn_iv_
xgrp="x2061";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_pamn_f() )
 { l[i]=omo1; R[429]++; if(dbg){print "R429", "gl_pamn_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[430]++; if(dbg){print "R430", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[431]++; if(dbg){print "R431", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[432]++; if(dbg){print "R432", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2062 !_#_! ==> gl_pamn_      sw_ez_dpr_  устали  уста́ли  у́стали
xgrp="x2062";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"без") && s(-1) )
 { l[i]=omo2; R[433]++; if(dbg){print "R433"}; continue };
 #
 if ( gl_pamn_f() )
 { l[i]=omo1; R[434]++; if(dbg){print "R434", "gl_pamn_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2063 !_#_! ==> gl_poed_      mest_ez_dprt_  нашей  наше́й  на́шей
xgrp="x2063";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[435]++; if(dbg){print "R435"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[436]++; if(dbg){print "R436", "gl_poed_f"}; continue };
 #
 if ( q(-1,"pre_da pre_pr pre_ro pre_tv") &&
      q(1,"suw_edzeda suw_edzepr suw_edzero suw_edzetv prl_edzeda prl_edzepr prl_edzero prl_edzetv") && s(-1,0) )
 { l[i]=omo2; R[437]++; if(dbg){print "R437"}; continue };
 if ( q(-1,"pre_da pre_pr pre_ro pre_tv prl_srav prl_edzevi") && s(-1) && (p(0)||q_w(1,"pre_any sz_iili name_ro_sy isname")) )
 { l[i]=omo2; R[438]++; if(dbg){print "R438"}; continue };
 if ( q(1,"suw_edzeda suw_edzepr suw_edzero suw_edzetv prl_edzeda prl_edzepr prl_edzero prl_edzetv") && s(0) )
 { l[i]=omo2; R[439]++; if(dbg){print "R439"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2064 !_#_! ==> gl_poed_pamn_	sw_1ez_dpr_2mn_iv_  отмели  отмели́  о́тмели
xgrp="x2064";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[440]++; if(dbg){print "R440"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[441]++; if(dbg){print "R441", "gl_poed_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[442]++; if(dbg){print "R442", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[443]++; if(dbg){print "R443", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[444]++; if(dbg){print "R444", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[445]++; if(dbg){print "R445", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[446]++; if(dbg){print "R446", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2065 !_#_! ==> gl_poed_      sw_1em_n_2ez_dpr_3mn_iv_
xgrp="x2065";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[447]++; if(dbg){print "R447"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[448]++; if(dbg){print "R448", "gl_poed_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[449]++; if(dbg){print "R449", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[450]++; if(dbg){print "R450", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[451]++; if(dbg){print "R451", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[452]++; if(dbg){print "R452", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[453]++; if(dbg){print "R453", "sw_mn_v_f"}; continue };


 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2066 !_#_! ==> gl_poed_      sw_1ez_dpr_2mn_iv_
xgrp="x2066";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 cst="гати грани дрожи заводи копи крепи моли пади топи";
 if ( p(-1) && sc(0,"!") && w(0,cst) )
 { l[i]=omo1; R[454]++; if(dbg){print "R454"}; continue };
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[455]++; if(dbg){print "R455"}; continue };

 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[456]++; if(dbg){print "R456", "gl_poed_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[457]++; if(dbg){print "R457", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[458]++; if(dbg){print "R458", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[459]++; if(dbg){print "R459", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[460]++; if(dbg){print "R460", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[461]++; if(dbg){print "R461", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2067 !_#_! ==> gl_poed_      sw_1ez_r_2mn_iv_3es_n_  суши  суши́  су́ши
xgrp="x2067";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[462]++; if(dbg){print "R462"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[463]++; if(dbg){print "R463", "gl_poed_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[464]++; if(dbg){print "R464", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[465]++; if(dbg){print "R465", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[466]++; if(dbg){print "R466", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2068 !_#_! ==> sw_em_d_      m2_1sw_em_l_2pl_kr_ez_  сыру  сы́ру  сыру́
xgrp="x2068";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
#if ( q(-1,"pre_any") && s(-1) )
#{ l[i]=omo2; R[467]++; if(dbg){print "R467"}; continue };
##
#if ( gl_poed_f() )
#{ l[i]=omo1; R[468]++; if(dbg){print "R468", "gl_poed_f"}; continue };
##
#if ( sw_mn_i_f() )
#{ l[i]=omo2; R[469]++; if(dbg){print "R469", "sw_mn_i_f"}; continue };
##
#if ( sw_mn_v_f() )
#{ l[i]=omo2; R[470]++; if(dbg){print "R470", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2069 !_#_! ==> gl_poed_      sw_1ez_r_2mn_iv_
xgrp="x2069";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[471]++; if(dbg){print "R471"}; continue };
 if(iwrd=="пищи") {
   if ( bw(-1,"запас") && s(-1) )
   { l[i]=omo2; R[472]++; if(dbg){print "R472"}; continue };
 };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[473]++; if(dbg){print "R473", "gl_poed_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[474]++; if(dbg){print "R474", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[475]++; if(dbg){print "R475", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[476]++; if(dbg){print "R476", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2070 !_#_! ==> gl_poed_      sw_1mn_iv_2gl_pamn_
xgrp="x2070";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[477]++; if(dbg){print "R477"}; continue };
 if ( wb(-5,-1,"пока если когда") && s(wbn,-1) )
 { l[i]=omo2; R[478]++; if(dbg){print "R478"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[479]++; if(dbg){print "R479", "gl_poed_f"}; continue };
 #
 if ( gl_pamn_f() )
 { l[i]=omo2; R[480]++; if(dbg){print "R480", "gl_pamn_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[481]++; if(dbg){print "R481", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[482]++; if(dbg){print "R482", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2071 !_#_! ==> gl_poed_      sw_em_i_
xgrp="x2071";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[483]++; if(dbg){print "R483"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[484]++; if(dbg){print "R484", "gl_poed_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[485]++; if(dbg){print "R485", "sw_em_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2072 !_#_! ==> gl_poed_      sw_es_dpr_
xgrp="x2072";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[486]++; if(dbg){print "R486"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[487]++; if(dbg){print "R487", "gl_poed_f"}; continue };
 #
 if ( sw_es_d_f() )
 { l[i]=omo2; R[488]++; if(dbg){print "R488", "sw_es_d_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[489]++; if(dbg){print "R489", "sw_es_p_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[490]++; if(dbg){print "R490", "sw_es_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2073 !_#_! ==> gl_poed_      sw_es_n_  веди  веди́  ве́ди
xgrp="x2073";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[491]++; if(dbg){print "R491"}; continue };
 if ( q(1,"mest_vi") &&
      q(2,"nar_spos prl_kred_sr") && s(0,1) )
 { l[i]=omo1; R[492]++; if(dbg){print "R492", "gl_poed_f"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[493]++; if(dbg){print "R493", "gl_poed_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2074 !_#_! ==> sw_es_r_    sw_mn_i_
xgrp="x2074";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[494]++; if(dbg){print "R494"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[495]++; if(dbg){print "R495", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[496]++; if(dbg){print "R496", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2075 !_#_! ==> gl_poed_      sw_ez_iv_  казни  казни́  ка́зни
xgrp="x2075";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[497]++; if(dbg){print "R497"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[498]++; if(dbg){print "R498", "gl_poed_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2076 !_#_! ==> gl_poed_      sw_ez_r_
xgrp="x2076";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[499]++; if(dbg){print "R499"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[500]++; if(dbg){print "R500", "gl_poed_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[501]++; if(dbg){print "R501", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2077 !_#_! ==> gl_poed_      sw_ez_t_
xgrp="x2077";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[502]++; if(dbg){print "R502"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[503]++; if(dbg){print "R503", "gl_poed_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[504]++; if(dbg){print "R504", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2078 !_#_! ==> gl_poed_      sw_mn_i_
xgrp="x2078";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[505]++; if(dbg){print "R505"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[506]++; if(dbg){print "R506", "gl_poed_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[507]++; if(dbg){print "R507", "sw_mn_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2079 !_#_! ==> gl_poed_      sw_mn_iv_
xgrp="x2079";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[508]++; if(dbg){print "R508"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[509]++; if(dbg){print "R509", "gl_poed_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[510]++; if(dbg){print "R510", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[511]++; if(dbg){print "R511", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2080 !_#_! ==> gl_poed_      sw_mn_r_
xgrp="x2080";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[512]++; if(dbg){print "R512"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[513]++; if(dbg){print "R513", "gl_poed_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[514]++; if(dbg){print "R514", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2081 !_#_! ==> gl_pomn_      sw_em_p_
xgrp="x2081";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-1,"pre_any") && s(-1) )
 { l[i]=omo2; R[515]++; if(dbg){print "R515"}; continue };
 #
 if ( gl_pomn_f() )
 { l[i]=omo1; R[516]++; if(dbg){print "R516", "gl_pomn_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[517]++; if(dbg){print "R517", "sw_em_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2082 !_#_! ==> m2_1gl_mn1e_2pq_kr_em_   sw_em_t_
xgrp="x2082";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[518]++; if(dbg){print "R518", "gl_mn1e_f"}; continue };
 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[519]++; if(dbg){print "R519", "pq_kr_em_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[520]++; if(dbg){print "R520", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2083 !_#_! ==> m2_1gl_mn1e_2qik_d_      sw_mn_r_
xgrp="x2083";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn1e_f() )
 { l[i]=omo1; R[521]++; if(dbg){print "R521", "gl_mn1e_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[522]++; if(dbg){print "R522", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2084 !_#_! ==> m2_1gl_poed_2nar_spos_   sw_ez_t_  порой  поро́й  по́рой
xgrp="x2084";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[523]++; if(dbg){print "R523", "gl_poed_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[524]++; if(dbg){print "R524", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2085 !_#_! ==> m2_1nar_kaq_2pred_ro_	   sw_em_t_
xgrp="x2085";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(-2,"suw_im") &&
     bw(-1,"идти") && s(-2,-1) )
 { l[i]=omo2; R[525]++; if(dbg){print "R525", "sw_em_t_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[526]++; if(dbg){print "R526", "sw_em_t_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2086 !_#_! ==> m2_1nar_vrem_2pred_ro_   sw_em_p_     после   по́сле   после́
xgrp="x2086";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sos(-20,-2) && Qb(son+1,-1,"pre_pr") )
 { l[i]=omo1; R[527]++; if(dbg){print "R527"}; continue };

 if ( w(-2,"самого") &&
      q(-1,"prl_edmuro") &&
      q(1,"suw_edro name_ro_sy isname") && s(-2,0) )
 { l[i]=omo1; R[528]++; if(dbg){print "R528"}; continue };
 if ( w(-2,"самой") &&
      q(-1,"prl_edzeda") &&
      q(1,"suw_edro name_ro_sy isname") && s(-2,0) )
 { l[i]=omo1; R[529]++; if(dbg){print "R529"}; continue };
 if ( p(-1) )
 { l[i]=omo1; R[530]++; if(dbg){print "R530"}; continue };
 if ( q(-1,"gl_in") && s(-1) )
 { l[i]=omo1; R[531]++; if(dbg){print "R531"}; continue };
 cst="а и но ну однако по уж";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[532]++; if(dbg){print "R532"}; continue };
 if ( q(1,"qik_ro") &&
      q(2,"qik_ro suw_mnro") && s(0,1) )
 { l[i]=omo1; R[533]++; if(dbg){print "R533"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[534]++; if(dbg){print "R534", "sw_em_p_f"}; continue };
 #
 if ( q(1,"suw_ro prl_ro mest_ro") )
 { l[i]=omo1; R[535]++; if(dbg){print "R535"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2087 !_#_! ==> m2_1pl_srav_2gl_poed_	   pl_ez_dprt_  свежей  свеже́й  све́жей
xgrp="x2087";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sc(-1,"-") )
 { l[i]=omo2; R[536]++; if(dbg){print "R536"}; continue };
 if ( sc(0,"-") )
 { l[i]=omo2; R[537]++; if(dbg){print "R537"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[538]++; if(dbg){print "R538", "gl_poed_f"}; continue };
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[539]++; if(dbg){print "R539", "pl_srav_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo2; R[540]++; if(dbg){print "R540", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo2; R[541]++; if(dbg){print "R541", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo2; R[542]++; if(dbg){print "R542", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo2; R[543]++; if(dbg){print "R543", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2088 !_#_! ==> m2_1pl_srav_2gl_poed_	   sw_ez_t_  бурей  буре́й  бу́рей
xgrp="x2088";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[544]++; if(dbg){print "R544", "gl_poed_f"}; continue };
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[545]++; if(dbg){print "R545", "pl_srav_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[546]++; if(dbg){print "R546", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2089 !_#_! ==> m2_1sw_em_d_2gl_ed1e_	   pl_ez_dprt_
xgrp="x2089";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[547]++; if(dbg){print "R547", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[548]++; if(dbg){print "R548", "gl_ed1e_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo2; R[549]++; if(dbg){print "R549", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo2; R[550]++; if(dbg){print "R550", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo2; R[551]++; if(dbg){print "R551", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo2; R[552]++; if(dbg){print "R552", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2090 !_#_! ==> m2_1sw_em_d_2gl_ed1e_	   sw_em_l_
xgrp="x2090";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[553]++; if(dbg){print "R553", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[554]++; if(dbg){print "R554", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[555]++; if(dbg){print "R555", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2091 !_#_! ==> m2_1sw_em_d_2gl_poed_	   pl_ez_dprt_
xgrp="x2091";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[556]++; if(dbg){print "R556", "gl_poed_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[557]++; if(dbg){print "R557", "sw_em_d_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo2; R[558]++; if(dbg){print "R558", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo2; R[559]++; if(dbg){print "R559", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo2; R[560]++; if(dbg){print "R560", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo2; R[561]++; if(dbg){print "R561", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2092 !_#_! ==> m2_1sw_em_l_2gl_ed1e_	   sw_em_dz_
xgrp="x2092";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_z_f() )
 { l[i]=omo2; R[562]++; if(dbg){print "R562", "sw_em_z_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[563]++; if(dbg){print "R563", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[564]++; if(dbg){print "R564", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[565]++; if(dbg){print "R565", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2093 !_#_! ==> gl_poed_	   sw_1ez_dprz_2mn_iv_
xgrp="x2093";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qw_(-1,"pre_any sz_iili")||q_w(1,"pre_any sz_iili") )
 { l[i]=omo2; R[566]++; if(dbg){print "R566"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo2; R[567]++; if(dbg){print "R567", "sw_em_z_f"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[568]++; if(dbg){print "R568", "gl_poed_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[569]++; if(dbg){print "R569", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[570]++; if(dbg){print "R570", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[571]++; if(dbg){print "R571", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[572]++; if(dbg){print "R572", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[573]++; if(dbg){print "R573", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2094 !_#_! ==> m2_1sw_em_p_2nar_vrem_   pl_srav_  уже  уже́  у́же
xgrp="x2094";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qxs(1,"в","плечах талии обхвате окружности диаметре") )
 { l[i]=omo2; R[574]++; if(dbg){print "R574"}; continue };
 if ( w(-3,"на") &&
      q(-2,"qin_im qik_im") &&
      q(-1,"suw_ro") &&
      q(1,"suw_ro") && s(-3,0) )
 { l[i]=omo2; R[575]++; if(dbg){print "R575"}; continue };
 #
 cst="о об обо про с со через";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[576]++; if(dbg){print "R576"}; continue };
 cst="некуда нельзя нет никого никому никто ничего ничто";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[577]++; if(dbg){print "R577"}; continue };
 if ( q(1,"nar_vrem nar_step nar_mest nar_spos nar_nar") && s(0) )
 { l[i]=omo1; R[578]++; if(dbg){print "R578"}; continue };
 if ( w(1,"не") &&
      q(2,"prl_im prq_im mest_im") &&
      q(3,"suw_im prl_im") && s(0,2) )
 { l[i]=omo1; R[579]++; if(dbg){print "R579"}; continue };
 if ( w(1,"не") &&
      q(2,"suw_im") && s(0,1) )
 { l[i]=omo1; R[580]++; if(dbg){print "R580"}; continue };
 if ( q(1,"prl_im prq_im mest_im") &&
      q(2,"suw_im prl_im") && s(0,1) )
 { l[i]=omo1; R[581]++; if(dbg){print "R581"}; continue };
 if ( q(1,"suw_im prl_srav") && s(0) )
 { l[i]=omo1; R[582]++; if(dbg){print "R582"}; continue };
 if ( q(1,"prl_vi prq_vi mest_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[583]++; if(dbg){print "R583"}; continue };
 if ( q(1,"prl_tv prq_tv mest_tv") &&
      q(2,"suw_tv prl_tv") && s(0,1) )
 { l[i]=omo1; R[584]++; if(dbg){print "R584"}; continue };
 if ( q(1,"suw_tv") && s(0) )
 { l[i]=omo1; R[585]++; if(dbg){print "R585"}; continue };
 if ( (w(1,"не все")||q(1,"prl_kred_sr")) &&
       q(2,"gl_in gl_ed gl_mn gl_vzmn deep prq_kred prq_krmn prl_kred prl_krmn") && s(0,1) )
 { l[i]=omo1; R[586]++; if(dbg){print "R586"}; continue };
 if ( q(1,"gl_in gl_ed gl_mn gl_vzmn deep prq_kred prq_krmn prl_kred prl_krmn") && s(0) )
 { l[i]=omo1; R[587]++; if(dbg){print "R587"}; continue };
 if ( q(1,"qik_im qin_im") &&
      q(2,"suw_mnro qik_im qik_vi qip_edvi qip_mnvi") && s(0,1) )
 { l[i]=omo1; R[588]++; if(dbg){print "R588"}; continue };
 if ( q(1,"qi_duom qi_duoz") &&
      q(2,"suw_edro") && s(0,1) )
 { l[i]=omo1; R[589]++; if(dbg){print "R589"}; continue };
 if ( q(1,"pre_pr") &&
      q(2,"prl_pr mest_pr prq_pr") &&
      q(3,"suw_pr suw_edme") && s(0,2) )
 { l[i]=omo1; R[590]++; if(dbg){print "R590"}; continue };
 if ( q(1,"pre_pr") &&
      q(2,"suw_pr suw_edme") && s(0,1) )
 { l[i]=omo1; R[591]++; if(dbg){print "R591"}; continue };
 if ( q(-1,"mest_im suw_im") &&
      q(1,"mest_da suw_da mest_vi suw_vi mest_3e") &&
      q(2,"gl_in gl_ed gl_mn gl_vzmn deep") && s(-1,1) )
 { l[i]=omo1; R[592]++; if(dbg){print "R592"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[593]++; if(dbg){print "R593", "sw_em_p_f"}; continue };
 #
 if ( pl_srav_f() )
 { l[i]=omo2; R[594]++; if(dbg){print "R594", "pl_srav_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2095 !_#_! ==> m2_1sw_em_p_2pl_ems_p_   sw_es_t_
xgrp="x2095";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[595]++; if(dbg){print "R595", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_es_t_f() )
 { l[i]=omo2; R[596]++; if(dbg){print "R596", "sw_es_t_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[597]++; if(dbg){print "R597", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2096 !_#_! ==> m2_1sw_em_r_2pl_kr_em_r_   pl_kr_ez_  бела бе́ла бела́
xgrp="x2096";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[598]++; if(dbg){print "R598", "sw_em_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo2; R[599]++; if(dbg){print "R599", "pl_kr_ez_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2097 !_#_! ==> m2_1sw_em_t_2pl_ems_p_   sw_em_iv_
xgrp="x2097";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[600]++; if(dbg){print "R600", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo1; R[601]++; if(dbg){print "R601", "sw_em_t_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[602]++; if(dbg){print "R602", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[603]++; if(dbg){print "R603", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2098 !_#_! ==> m2_1sw_es_p_2pl_ems_p_   sw_es_t_
xgrp="x2098";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[604]++; if(dbg){print "R604", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_es_t_f() )
 { l[i]=omo2; R[605]++; if(dbg){print "R605", "sw_es_t_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo1; R[606]++; if(dbg){print "R606", "sw_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2099 !_#_! ==> m2_1sw_ez_dp_2nar_napr_  sw_es_ivp_  горе  горе́  го́ре
xgrp="x2099";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 prex=1

 if ( w(-1,"на") && s(-1) && p(-2) && p(0) )
 { R[607]++; if(dbg){print "R607", "stopper"}; continue };
 if ( w(-1,"на") && s(-1) && p(-2) && bfa(1,3,"_gl_dvizh") && s(0,bfn-1) )
 { R[608]++; if(dbg){print "R608", "stopper"}; continue };

 if ( bw(-2,"воздеть") && w(-1,"руки") && s(-2,-1) )
 { l[i]=omo1; R[609]++; if(dbg){print "R609"}; continue };
 if ( w(-1,"на") && s(-1) && (qw_(-2,"mest_da suw_da")||q_w(1,"mest_da suw_da")) )
 { l[i]=omo2; R[610]++; if(dbg){print "R610"}; continue };

 if ( z(0) &&
      q(1,"otsz_edzevi otsz_edzero") )
 { l[i]=omo1; R[611]++; if(dbg){print "R611"}; continue };
 if ( z(0) &&
      q(1,"otsz_edsrvi") )
 { l[i]=omo2; R[612]++; if(dbg){print "R612"}; continue };
 if ( z(0) && s(1) && s(1) &&
      q(1,"pre_tv pre_ro pre_da pre_pr") &&
      q(2,"otsz_edzero") )
 { l[i]=omo1; R[613]++; if(dbg){print "R613"}; continue };
 if ( z(0) && s(1) && s(1) &&
      q(1,"pre_vi") &&
      q(2,"otsz_edzevi") )
 { l[i]=omo1; R[614]++; if(dbg){print "R614"}; continue };
 if ( z(0) && s(1) &&
      q(1,"pre_vi pre_ro") &&
      q(2,"otsz_edsrvi") )
 { l[i]=omo2; R[615]++; if(dbg){print "R615"}; continue };

 if ( sw_es_i_f() )
 { l[i]=omo2; R[616]++; if(dbg){print "R616", "sw_es_i_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[617]++; if(dbg){print "R617", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo1; R[618]++; if(dbg){print "R618", "sw_ez_p_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[619]++; if(dbg){print "R619", "sw_es_p_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[620]++; if(dbg){print "R620", "sw_es_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2100 !_#_! ==> m2_1sw_ez_l_2gl_poed_pamn_      sw_1ez_dpr_2mn_iv_
xgrp="x2100";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[621]++; if(dbg){print "R621", "gl_poed_f"}; continue };
 #
 if ( sw_ez_l_f() )
 { l[i]=omo1; R[622]++; if(dbg){print "R622", "sw_ez_l_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[623]++; if(dbg){print "R623", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[624]++; if(dbg){print "R624", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[625]++; if(dbg){print "R625", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[626]++; if(dbg){print "R626", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[627]++; if(dbg){print "R627", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2101 !_#_! ==> m2_1sw_ez_l_2gl_poed_    sw_1ez_dprz_2mn_iv_
xgrp="x2101";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="кости") {
   cst="выиграть игра играть проиграть проиграться";
   if ( w(-1,"в") && bw(-2,cst) && s(-2,-1) )
   { l[i]=omo2; R[628]++; if(dbg){print "R628"}; continue };
 };
 if ( pre_any(-1) && W(-1,"в на") && s(-1) )
 { l[i]=omo2; R[629]++; if(dbg){print "R629"}; continue };
 if ( pre_any(-3) && W(-3,"в на") &&
      suw_any(-2) &&
      sz_iili(-1) && s(-3,-1) )
 { l[i]=omo2; R[630]++; if(dbg){print "R630"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[631]++; if(dbg){print "R631", "gl_poed_f"}; continue };
 #
 if ( sw_ez_l_f() )
 { l[i]=omo1; R[632]++; if(dbg){print "R632", "sw_ez_l_f"}; continue };
 #
 if ( sw_ez_z_f() )
 { l[i]=omo2; R[633]++; if(dbg){print "R633", "sw_ez_z_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[634]++; if(dbg){print "R634", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[635]++; if(dbg){print "R635", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[636]++; if(dbg){print "R636", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[637]++; if(dbg){print "R637", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[638]++; if(dbg){print "R638", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2102 !_#_! ==> m2_1sw_ez_r_2gl_poed_	   sw_mn_iv_
xgrp="x2102";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="души") {
   if ( w(1,"не") && bw(2,"чаять") && s(0,1) )
   { l[i]=omo1; R[639]++; if(dbg){print "R639"}; continue };
   if ( w(1,"в") && q(2,"mest_pr suw_pr name_pr_sy") && w(3,"не") && bw(4,"чаять") && s(0,3) )
   { l[i]=omo1; R[640]++; if(dbg){print "R640"}; continue };
 };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[641]++; if(dbg){print "R641", "gl_poed_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[642]++; if(dbg){print "R642", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[643]++; if(dbg){print "R643", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[644]++; if(dbg){print "R644", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2103 !_#_! ==> m2_1sw_ez_t_2nar_spos_   pl_1em_iv_2dprt_ez_  дорогой  доро́гой  дорого́й
xgrp="x2103";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( p(-1) && p(0) )
 { l[i]=omo2; R[645]++; if(dbg){print "R645"}; continue };
 cst="ваш мой наш свой твой";
 if ( (w(-1,cst)||q(-1,"prl_edmuim") ) && s(-1) )
 { l[i]=omo2; R[646]++; if(dbg){print "R646"}; continue };
 if ( (w(1,cst)||q(1,"prl_edmuim isname") ) && s(0) && p(-1) && p(1) )
 { l[i]=omo2; R[647]++; if(dbg){print "R647"}; continue };
 cst="очень слишком черезчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[648]++; if(dbg){print "R648"}; continue };
 if ( q(1,"titul name_im_sy isname") && s(0) && p(1) )
 { l[i]=omo2; R[649]++; if(dbg){print "R649"}; continue };
 cst="мой наш";
 if ( (w(1,cst)||q(1,"titul")) &&
       q(2,"titul name_im_sy isname") && s(0,1) )
 { l[i]=omo2; R[650]++; if(dbg){print "R650"}; continue };
 if ( q(1,"suw_edmuim suw_noedmuim suw_edzeda suw_edzero suw_edzetv") && s(0) && p(1) )
 { l[i]=omo2; R[651]++; if(dbg){print "R651"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo1; R[652]++; if(dbg){print "R652", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2104 !_#_! ==> m2_1sw_mn_iv_2deep_na_   sw_es_r_  моря  моря́  мо́ря
xgrp="x2104";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[653]++; if(dbg){print "R653", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[654]++; if(dbg){print "R654", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[655]++; if(dbg){print "R655", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2105 !_#_! ==> gl_paedze_    sw_es_r_
xgrp="x2105";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[656]++; if(dbg){print "R656", "sw_es_r_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[657]++; if(dbg){print "R657", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2106 !_#_! ==> m2_1sw_mn_iv_2gl_poed_+(sw_ez_r_)      sw_ez_dpr_  мочи  мочи́  мо́чи
xgrp="x2106";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qxs(-1,"что","было есть") )
 { l[i]=omo2; R[658]++; if(dbg){print "R658"}; continue };
 if ( qxs(-1,"изо со","всей") )
 { l[i]=omo2; R[659]++; if(dbg){print "R659"}; continue };
 if ( w(1,"нет") && s(0) && p(1) )
 { l[i]=omo2; R[660]++; if(dbg){print "R660"}; continue };
 if ( w(-1,"не") &&
      q(1,"suw_ro") && s(-1,0) )
 { l[i]=omo1; R[661]++; if(dbg){print "R661"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[662]++; if(dbg){print "R662", "gl_poed_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[663]++; if(dbg){print "R663", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[664]++; if(dbg){print "R664", "sw_mn_v_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[665]++; if(dbg){print "R665", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[666]++; if(dbg){print "R666", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[667]++; if(dbg){print "R667", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2107 !_#_! ==> m2_1sw_mn_iv_2pl_ez_i_   sw_es_r_
xgrp="x2107";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[668]++; if(dbg){print "R668", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[669]++; if(dbg){print "R669", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[670]++; if(dbg){print "R670", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2108 !_#_! ==> m2_1sw_mn_iv_2pl_kr_mn_  sw_ez_r_
xgrp="x2108";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[671]++; if(dbg){print "R671", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[672]++; if(dbg){print "R672", "sw_mn_v_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[673]++; if(dbg){print "R673", "sw_ez_r_f"}; continue };
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[674]++; if(dbg){print "R674", "pl_krmn_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2109 !_#_! ==> m2_1sw_mn_r_2gl_poed_    sw_ez_t_
xgrp="x2109";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[675]++; if(dbg){print "R675", "gl_poed_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[676]++; if(dbg){print "R676", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo1; R[677]++; if(dbg){print "R677", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2110 !_#_! ==> m2_1sw_mn_r_2pl_kr_em_   sw_em_iv_
xgrp="x2110";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo1; R[678]++; if(dbg){print "R678", "sw_mn_r_f"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[679]++; if(dbg){print "R679", "pl_kr_em_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[680]++; if(dbg){print "R680", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[681]++; if(dbg){print "R681", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2111 !_#_! ==> m3_1sw_em_i_2pl_em_iv_3pl_ez_dprt_     sw_ez_t_
xgrp="x2111";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[682]++; if(dbg){print "R682", "sw_em_i_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[683]++; if(dbg){print "R683", "sw_ez_t_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo1; R[684]++; if(dbg){print "R684", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo1; R[685]++; if(dbg){print "R685", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo1; R[686]++; if(dbg){print "R686", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo1; R[687]++; if(dbg){print "R687", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2112 !_#_! ==> m3_1sw_ez_dpr_2sw_mn_iv_3gl_pamn_	 sw_ez_l_   да'ли дали'
xgrp="x2112";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( isname(0) && isname(-1) && wc(-1,"^сальвадор") && s(-1) )
 { l[i]=omo2; R[688]++; if(dbg){print "R688"}; continue };
 #
 if ( w(-1,"в") && (-1) )
 { l[i]=omo2; R[689]++; if(dbg){print "R689"}; continue };
 #
 if ( w(-2,"в") &&
      q(-1,"prl_edpr") && s(-2,-1) )
 { l[i]=omo2; R[690]++; if(dbg){print "R690"}; continue };
 #
 if ( name_any_sy(0) )
 { l[i]=omo2; R[691]++; if(dbg){print "R691"}; continue };
 #
 l[i]=omo1; R[692]++; if(dbg){print "R692"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2113 !_#_! ==> mest_d_       sw_ez_v_   кому +дефис
xgrp="x2113";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="либо нибудь никому то";
#if ( sL(0,"-") && w(1,cst) )
#{ l[i]=gensub(/(.)$/,"\\1\xcc\x81",1,l[i]); sep[i]=gensub(/-/,"-\xcc\xa0",1,sep[i]); R[693]++; if(dbg){print "R693"}; continue };
#if ( sL(-1,"-") && w(-1,"кое") )
#{ l[i]=gensub(/(.)$/,"\\1\xcc\x81",1,l[i]); R[694]++; if(dbg){print "R694"}; continue };
 if ( sL(0,"-") && w(1,cst) )
 { l[i]=omo1; R[695]++; if(dbg){print "R695"}; continue };
 if ( sL(-1,"-") && w(-1,"кое") )
 { l[i]=omo1; R[696]++; if(dbg){print "R696"}; continue };
 if ( sc(0,"?") )
 { l[i]=omo1; R[697]++; if(dbg){print "R697"}; continue };

 #
 if ( w(-1,"в") && s(-1) )
 { l[i]=omo2; R[698]++; if(dbg){print "R698"}; continue };
 if ( q(-1,"prl_edzevi prq_edzevi mest_edzevi") && s(-1) )
 { l[i]=omo2; R[699]++; if(dbg){print "R699"}; continue };

 # всё остальное
 l[i]=omo1; R[700]++; if(dbg){print "R700"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2114 !_#_! ==> mezd_	        sw_mn_p_
xgrp="x2114";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_p_f() )
 { l[i]=omo2; R[701]++; if(dbg){print "R701", "sw_mn_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2115 !_#_! ==> nar_pre_combo_  sw_1ez_r_2mn_iv_
xgrp="x2115";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[702]++; if(dbg){print "R702", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[703]++; if(dbg){print "R703", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[704]++; if(dbg){print "R704", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2116 !_#_! ==> nar_spos_     pl_kr_es_
xgrp="x2116";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(-1,"gl_ed gl_mn gl_po deep") && s(-1) )
 { l[i]=omo1; R[705]++; if(dbg){print "R705", "sw_mn_v_f"}; continue };
 if ( q(1,"gl_ed gl_mn gl_po deep prl_kred prl_krmn prq_krmn prq_kred") && s(0) )
 { l[i]=omo1; R[706]++; if(dbg){print "R706", "sw_mn_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2117 !_#_! ==> nar_spos_     sw_em_d_
xgrp="x2117";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[707]++; if(dbg){print "R707", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2118 !_#_! ==> nar_spos_     sw_em_t_
xgrp="x2118";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[708]++; if(dbg){print "R708", "sw_em_t_f"}; continue };

 if(iwrd=="целиком")
 { l[i]=omo1; R[709]++; if(dbg){print "R709", "nar_spos_"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2119 !_#_! ==> nar_vrem_     pl_ez_dprt_
xgrp="x2119";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 #
 if ( pl_ez_d_f() )
 { l[i]=omo2; R[710]++; if(dbg){print "R710", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo2; R[711]++; if(dbg){print "R711", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo2; R[712]++; if(dbg){print "R712", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo2; R[713]++; if(dbg){print "R713", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2120 !_#_! ==> nar_vrem_     sw_em_t_   потом  пото́м  по́том
xgrp="x2120";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="вонять истекать обливаться пахнуть провонять провоняться пропахнуть пропитать пропитаться пропитывать пропитываться";
 if ( bw(-1,cst) && q(-1,"gl_ed gl_mn gl_vzmn deep prq_any") && s(-1) )
 { l[i]=omo2; R[714]++; if(dbg){print "R714"}; continue };
 if ( bw(-1,cst) && prq_any(-1) && s(-1) )
 { l[i]=omo2; R[715]++; if(dbg){print "R715"}; continue };
 if ( p(-2) &&
      w(-1,"а и но однако") && s(-1) )
 { l[i]=omo1; R[716]++; if(dbg){print "R716"}; continue };
 if ( p(-1) )
 { l[i]=omo1; R[717]++; if(dbg){print "R717"}; continue };
 if ( qxs(1,"и","кровью") )
 { l[i]=omo2; R[718]++; if(dbg){print "R718"}; continue };

 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[719]++; if(dbg){print "R719", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2121 !_#_! ==> phrase_       pl_1ems_t_2mn_d_
xgrp="x2121";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2122 !_#_! ==> phrase_       sw_em_r_   следа  следа́  сле́да
xgrp="x2122";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"без ни") && s(-1) )
 { l[i]=omo1; R[720]++; if(dbg){print "R720"}; continue };
 if ( w(-3,"не") &&
     (q(-2,"gl_ed gl_in gl_mn gl_poed gl_pomn deep")||w(-2,"нет")) &&
      w(-1,"и никакого") && s(-3,-1) )
 { l[i]=omo1; R[721]++; if(dbg){print "R721"}; continue };
 #
  l[i]=omo2; R[722]++; if(dbg){print "R722"}; continue;

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2123 !_#_! ==> phrase_       sw_em_vr_    < хера хрена >
xgrp="x2123";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"ни на") && s(-1) )
 { l[i]=omo1; R[723]++; if(dbg){print "R723"}; continue };
 if ( w(-1,"с") && w(1,"ли") s(-1,0) )
 { l[i]=omo1; R[724]++; if(dbg){print "R724"}; continue };
 #
 l[i]=omo2; R[725]++; if(dbg){print "R725"}; continue;
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2124 !_#_! ==> phrase_		sw_mn_iv_
xgrp="x2124";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[726]++; if(dbg){print "R726", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[727]++; if(dbg){print "R727", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2125 !_#_! ==> pl_1em_iv_2ez_dprt_    sw_ez_t_
xgrp="x2125";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sc(-1,"-") )
 { l[i]=omo1; R[728]++; if(dbg){print "R728"}; continue };
 if ( q(1,"suw_edzeda suw_edzero suw_edzetv suw_edzepr suw_edmuim suw_edmuvi") && s(0) )
 { l[i]=omo1; R[729]++; if(dbg){print "R729"}; continue };

 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[730]++; if(dbg){print "R730", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2126 !_#_! ==> pl_em_iv_		sw_mn_r_
xgrp="x2126";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[731]++; if(dbg){print "R731", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2127 !_#_! ==> pl_em_iv_		sw_mn_vr_
xgrp="x2127";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[732]++; if(dbg){print "R732", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[733]++; if(dbg){print "R733", "sw_mn_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

 ###   x2128 !_#_! ==> pre_r_		sw_es_n_      изо  и́зо  изо́
 xgrp="x2128";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
 {makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="всех дня лба льда ржи рта";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[734]++; if(dbg){print "R734"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2129 !_#_! ==> pl_ems_d_		sw_em_d_
xgrp="x2129";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[735]++; if(dbg){print "R735", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2130 !_#_! ==> pl_ems_p_		sw_em_iv_
xgrp="x2130";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[736]++; if(dbg){print "R736", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[737]++; if(dbg){print "R737", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[738]++; if(dbg){print "R738", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2131 !_#_! ==> pl_ems_p_		sw_ems_t_
xgrp="x2131";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[739]++; if(dbg){print "R739", "pl_em_p_f()||pl_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2132 !_#_! ==> pl_ems_p_		sw_em_t_
xgrp="x2132";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[740]++; if(dbg){print "R740", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[741]++; if(dbg){print "R741", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2133 !_#_! ==> pl_ems_p_		sw_es_t_
xgrp="x2133";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[742]++; if(dbg){print "R742", "pl_em_p_f()||pl_es_p_f"}; continue };
 #
 if ( sw_es_t_f() )
 { l[i]=omo2; R[743]++; if(dbg){print "R743", "sw_es_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2134 !_#_! ==> pl_ems_t_		sw_em_t_
xgrp="x2134";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[744]++; if(dbg){print "R744", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2135 !_#_! ==> pl_es_iv_		pl_srav_
xgrp="x2135";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sc(-1,"-") )
 { l[i]=omo2; R[745]++; if(dbg){print "R745"}; continue };
 if ( sc(0,"-") )
 { l[i]=omo2; R[746]++; if(dbg){print "R746"}; continue };
 #
 if ( pl_es_i_f() )
 { l[i]=omo1; R[747]++; if(dbg){print "R747", "pl_es_i_f"}; continue };
 #
 if ( pl_es_v_f() )
 { l[i]=omo1; R[748]++; if(dbg){print "R748", "pl_es_v_f"}; continue };
 #
 if ( pl_srav_f() )
 { l[i]=omo2; R[749]++; if(dbg){print "R749", "pl_srav_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2136 !_#_! ==> pl_ez_dprt_   sw_1em_iv_2ez_t_
xgrp="x2136";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[750]++; if(dbg){print "R750", "sw_ez_t_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[751]++; if(dbg){print "R751", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[752]++; if(dbg){print "R752", "sw_em_v_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo1; R[753]++; if(dbg){print "R753", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo1; R[754]++; if(dbg){print "R754", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo1; R[755]++; if(dbg){print "R755", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo1; R[756]++; if(dbg){print "R756", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2137 !_#_! ==> pl_ez_dprt_   sw_ez_t_
xgrp="x2137";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[757]++; if(dbg){print "R757", "sw_ez_t_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo1; R[758]++; if(dbg){print "R758", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo1; R[759]++; if(dbg){print "R759", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo1; R[760]++; if(dbg){print "R760", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo1; R[761]++; if(dbg){print "R761", "pl_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2138 !_#_! ==> pl_ez_dprt_   sw_mn_r_
xgrp="x2138";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[762]++; if(dbg){print "R762", "sw_mn_r_f"}; continue };
 #
 if ( pl_ez_d_f() )
 { l[i]=omo1; R[763]++; if(dbg){print "R763", "pl_ez_d_f"}; continue };
 #
 if ( pl_ez_p_f() )
 { l[i]=omo1; R[764]++; if(dbg){print "R764", "pl_ez_p_f"}; continue };
 #
 if ( pl_ez_r_f() )
 { l[i]=omo1; R[765]++; if(dbg){print "R765", "pl_ez_r_f"}; continue };
 #
 if ( pl_ez_t_f() )
 { l[i]=omo1; R[766]++; if(dbg){print "R766", "pl_ez_t_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2139 !_#_! ==> pl_ez_i_		sw_1es_r_2mn_iv_
xgrp="x2139";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[767]++; if(dbg){print "R767", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[768]++; if(dbg){print "R768", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[769]++; if(dbg){print "R769", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2140 !_#_! ==> pl_ez_i_		sw_es_r_
xgrp="x2140";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[770]++; if(dbg){print "R770", "sw_es_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2141 !_#_! ==> pl_ez_i_		sw_mn_i_
xgrp="x2141";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[771]++; if(dbg){print "R771", "sw_mn_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2142 !_#_! ==> pl_ez_t_		sw_1em_d_2ez_t_
xgrp="x2142";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[772]++; if(dbg){print "R772", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[773]++; if(dbg){print "R773", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2143 !_#_! ==> pl_ez_v_		sw_es_d_
xgrp="x2143";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_ez_v_f() )
 { l[i]=omo1; R[774]++; if(dbg){print "R774", "pl_ez_v_f"}; continue };
 #
 if ( sw_es_d_f() )
 { l[i]=omo2; R[775]++; if(dbg){print "R775", "sw_es_d_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2144 !_#_! ==> pl_kr_em_		sw_em_i_
xgrp="x2144";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[776]++; if(dbg){print "R776", "pl_kr_em_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[777]++; if(dbg){print "R777", "sw_em_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2145 !_#_! ==> pl_kr_em_		sw_em_iv_
xgrp="x2145";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"pre_ro pre_pr pre_vi") && s(0) )
 { l[i]=omo1; R[778]++; if(dbg){print "R778"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[779]++; if(dbg){print "R779", "pl_kr_em_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[780]++; if(dbg){print "R780", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[781]++; if(dbg){print "R781", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2146 !_#_! ==> pl_kr_em_		sw_em_t_  знаком  знако́м  зна́ком
xgrp="x2146";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="быть оказаться стать";
 if ( bw(-1,cst) &&
       q(1,"prl_ro") &&
       q(2,"suw_ro") && s(-1,1) )
 { l[i]=omo2; R[782]++; if(dbg){print "R782"}; continue };
 if ( bw(-1,cst) &&
       q(1,"suw_ro") && s(-1,0) )
 { l[i]=omo2; R[783]++; if(dbg){print "R783"}; continue };

 if (q(1,"gl_in gl_ed gl_mn deep") && s(0) )
 { l[i]=omo2; R[784]++; if(dbg){print "R784"}; continue };
 if ( pre_tv(-2) &&
           q(-1,"mest_tv suw_tv") && s(-2,-1) )
 { l[i]=omo1; R[785]++; if(dbg){print "R785"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[786]++; if(dbg){print "R786", "sw_em_t_f"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[787]++; if(dbg){print "R787", "pl_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2147 !_#_! ==> pl_kr_em_		sw_mn_r_
xgrp="x2147";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="дорог") {
   cst="перекрёсток прокладка";
   if ( bw(-1,cst) && s(-1) )
   { l[i]=omo2; R[788]++; if(dbg){print "R788"}; continue };
 };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[789]++; if(dbg){print "R789", "pl_kr_em_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[790]++; if(dbg){print "R790", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2148 !_#_! ==> pl_kr_em_		sw_mn_vr_ готов  гото́в  го́тов
xgrp="x2148";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( bb(-5,-1,"быть") && s(bbn,-1) )
 { l[i]=omo1; R[791]++; if(dbg){print "R791"}; continue };
 if ( qf(1,3,"gl_in") && s(0,qfn-1) )
 { l[i]=omo1; R[792]++; if(dbg){print "R792"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[793]++; if(dbg){print "R793", "pl_kr_em_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[794]++; if(dbg){print "R794", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[795]++; if(dbg){print "R795", "sw_mn_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2149 !_#_! ==> pl_kr_es_		sw_es_iv_
xgrp="x2149";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="добро") {
   if ( w(1,"пожаловать") && s(0) )
   { l[i]=omo2; R[796]++; if(dbg){print "R796"}; continue };
 };

 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[797]++; if(dbg){print "R797", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[798]++; if(dbg){print "R798", "sw_es_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2150 !_#_! ==> pl_kr_ez_		sw_1es_r_2mn_iv_
xgrp="x2150";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[799]++; if(dbg){print "R799", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[800]++; if(dbg){print "R800", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[801]++; if(dbg){print "R801", "sw_mn_v_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[802]++; if(dbg){print "R802", "pl_kr_ez_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2151 !_#_! ==> pl_kr_ez_		sw_em_r_
xgrp="x2151";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[803]++; if(dbg){print "R803", "sw_em_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[804]++; if(dbg){print "R804", "pl_kr_ez_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2152 !_#_! ==> pl_kr_ez_		sw_em_vr_
xgrp="x2152";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[805]++; if(dbg){print "R805", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[806]++; if(dbg){print "R806", "sw_em_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[807]++; if(dbg){print "R807", "pl_kr_ez_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2153 !_#_! ==> pl_kr_ez_		sw_es_r_
xgrp="x2153";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[808]++; if(dbg){print "R808", "sw_es_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[809]++; if(dbg){print "R809", "pl_kr_ez_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2154 !_#_! ==> pl_kr_ez_		sw_ez_i_
xgrp="x2154";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[810]++; if(dbg){print "R810", "sw_ez_i_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[811]++; if(dbg){print "R811", "pl_kr_ez_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2155 !_#_! ==> pl_kr_mn_		sw_1ez_r_2mn_iv_  дороги  дороги́  дороги́
xgrp="x2155";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[812]++; if(dbg){print "R812", "pl_krmn_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[813]++; if(dbg){print "R813", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[814]++; if(dbg){print "R814", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[815]++; if(dbg){print "R815", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2156 !_#_! ==> pl_kr_mn_		sw_ez_r_
xgrp="x2156";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[816]++; if(dbg){print "R816", "sw_ez_r_f"}; continue };
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[817]++; if(dbg){print "R817", "pl_krmn_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2157 !_#_! ==> pl_kr_mn_		sw_mn_i_
xgrp="x2157";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[818]++; if(dbg){print "R818", "sw_mn_i_f"}; continue };
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[819]++; if(dbg){print "R819", "pl_krmn_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2158 !_#_! ==> pl_kr_mn_		sw_mn_iv_
xgrp="x2158";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[820]++; if(dbg){print "R820", "pl_krmn_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[821]++; if(dbg){print "R821", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[822]++; if(dbg){print "R822", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2159 !_#_! ==> pl_srav_		sw_1ez_t_2mn_r_
xgrp="x2159";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[823]++; if(dbg){print "R823", "pl_srav_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[824]++; if(dbg){print "R824", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[825]++; if(dbg){print "R825", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2160 !_#_! ==> pl_srav_		sw_em_p_
xgrp="x2160";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[826]++; if(dbg){print "R826", "pl_srav_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[827]++; if(dbg){print "R827", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2161 !_#_! ==> pl_srav_		sw_ez_t_
xgrp="x2161";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[828]++; if(dbg){print "R828", "pl_srav_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[829]++; if(dbg){print "R829", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2162 !_#_! ==> pl_srav_		sw_mn_r_
xgrp="x2162";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[830]++; if(dbg){print "R830", "pl_srav_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[831]++; if(dbg){print "R831", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2163 !_#_! ==> pq_ems_p_		sw_em_t_
xgrp="x2163";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[832]++; if(dbg){print "R832", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2164 !_#_! ==> pq_kr_em_		pq_kr_em_
xgrp="x2164";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2165 !_#_! ==> pq_kr_em_		sw_1em_iv_2mn_vr_
xgrp="x2165";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[833]++; if(dbg){print "R833", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[834]++; if(dbg){print "R834", "sw_em_v_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[835]++; if(dbg){print "R835", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[836]++; if(dbg){print "R836", "sw_mn_r_f"}; continue };
 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[837]++; if(dbg){print "R837", "pq_kr_em_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2166 !_#_! ==> pq_kr_em_		sw_em_iv_
xgrp="x2166";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[838]++; if(dbg){print "R838", "pq_kr_em_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[839]++; if(dbg){print "R839", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[840]++; if(dbg){print "R840", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2167 !_#_! ==> pq_kr_em_		sw_mn_r_
xgrp="x2167";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pq_kr_em_f() )
 { l[i]=omo1; R[841]++; if(dbg){print "R841", "pq_kr_em_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[842]++; if(dbg){print "R842", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2168 !_#_! ==> pq_kr_ez_		sw_em_r_
xgrp="x2168";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[843]++; if(dbg){print "R843", "pl_kr_ez_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[844]++; if(dbg){print "R844", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2169 !_#_! ==> pq_kr_ez_		sw_ez_i_
xgrp="x2169";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[845]++; if(dbg){print "R845", "pl_kr_ez_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[846]++; if(dbg){print "R846", "sw_ez_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2170 !_#_! ==> pq_kr_mn_		sw_1ez_r_2mn_i_
xgrp="x2170";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[847]++; if(dbg){print "R847", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[848]++; if(dbg){print "R848", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2171 !_#_! ==> pq_kr_mn_		sw_1ez_r_2mn_iv_
xgrp="x2171";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[849]++; if(dbg){print "R849", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[850]++; if(dbg){print "R850", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[851]++; if(dbg){print "R851", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2172 !_#_! ==> pq_kr_mn_		sw_mn_iv_
xgrp="x2172";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[852]++; if(dbg){print "R852", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[853]++; if(dbg){print "R853", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2173 !_#_! ==> pre_combo_    sw_mn_d_
xgrp="x2173";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( ismark(-1,"Yco") && s(-1) && p(0) )
 { l[i]=omo1; R[854]++; if(dbg){print "R854", "sw_mn_d_f"}; continue };
 #
 if ( sw_mn_d_f() )
 { l[i]=omo2; R[855]++; if(dbg){print "R855", "sw_mn_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2174 !_#_! ==> predik_       sw_ez_dp_
xgrp="x2174";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[856]++; if(dbg){print "R856", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[857]++; if(dbg){print "R857", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2175 !_#_! ==> pred_tv_      sw_em_iv_   перед  пе́ред  перёд
xgrp="x2175";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( name_tv_sy(1) && s(0) )
 { l[i]=omo1; R[858]++; if(dbg){print "R858"}; continue };
 if ( wc(1,"им$ ом$ ой$ ами$ ими$ ыми$ ями$") && s(0) )
 { l[i]=omo1; R[859]++; if(dbg){print "R859"}; continue };
 if ( q(-1,"suw_im") && wc(1,"им$ ом$ ой$ ами$ ими$ ыми$") && s(-1,0) )
 { l[i]=omo1; R[860]++; if(dbg){print "R860"}; continue };
 if ( isname(1) &&
      isname(2) && wc(2,"им$ ом$ ой$ ами$ ими$ ыми$") && s(0,1) )
 { l[i]=omo1; R[861]++; if(dbg){print "R861"}; continue };

 #
 if ( q(1,"prl_tv prq_tv mest_tv mest_mn mest_3e") &&
      q(2,"suw_tv prl_tv prq_tv mest_tv") && s(0,1) )
 { l[i]=omo1; R[862]++; if(dbg){print "R862"}; continue };
 if ( q(1,"suw_tv prl_tv mest_tv") && s(0) )
 { l[i]=omo1; R[863]++; if(dbg){print "R863"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[864]++; if(dbg){print "R864", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[865]++; if(dbg){print "R865", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2176 !_#_! ==> qast_		sw_es_p_
xgrp="x2176";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[866]++; if(dbg){print "R866", "sw_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2177 !_#_! ==> qip_ez_dprt_		sw_ez_t_    пятой  пя́той  пято́й
xgrp="x2177";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qb(-5,-1,"pre_pr") && s(qbn,0) &&
       q(1,"suw_edzepr") &&
     qir(qbn+1,-1,"prl_edzepr qik_im") )
 { l[i]=omo1; R[867]++; if(dbg){print "R867"}; continue };
 if ( pre_pr(-1) && s(-1) && (p(0)||q_w(1,"pre_any")) )
 { l[i]=omo1; R[868]++; if(dbg){print "R868"}; continue };
 cst="авеню долей доли минутой поправке поправки поправкой секундой части частью";
 if ( w(1,cst) && s(-0) )
 { l[i]=omo1; R[869]++; if(dbg){print "R869"}; continue };
 if ( q(-1,"qik_im qip_da") && ds(-1) )
 { l[i]=omo1; R[870]++; if(dbg){print "R870"}; continue };
 if ( q(-2,"qip_da") && q(-1,"sz_iili") && s(-2,-1) )
 { l[i]=omo1; R[871]++; if(dbg){print "R871"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[872]++; if(dbg){print "R872", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2178 !_#_! ==> sw_1em_d_2ez_v_		sw_em_l_
xgrp="x2178";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="ладу") {
   if ( w(-1,"в") && s(-1) )
   { l[i]=omo2; R[873]++; if(dbg){print "R873"}; continue };
 };
 if(iwrd=="пару") {
   if ( q(1,"suw_edne") && s(0) )
   { l[i]=omo1; R[874]++; if(dbg){print "R874"}; continue };
 };
 #
 if ( suw_mnro(1) && s(0) )
 { l[i]=omo1; R[875]++; if(dbg){print "R875"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[876]++; if(dbg){print "R876", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[877]++; if(dbg){print "R877", "sw_ez_v_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[878]++; if(dbg){print "R878", "sw_em_l_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2179 !_#_! ==> sw_1em_d_2ez_v_		sw_es_n_
xgrp="x2179";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[879]++; if(dbg){print "R879", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[880]++; if(dbg){print "R880", "sw_ez_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2180 !_#_! ==> sw_1em_l_2ez_v_		sw_em_d_
xgrp="x2180";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="полу") {
   if ( sc(0,"-") )
   { l[i]=omo2; R[881]++; if(dbg){print "R881"}; continue };
   if ( w(-1,"до по с") && s(-1) )
   { l[i]=omo2; R[882]++; if(dbg){print "R882"}; continue };
 };
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[883]++; if(dbg){print "R883", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[884]++; if(dbg){print "R884", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[885]++; if(dbg){print "R885", "sw_ez_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2181 !_#_! ==> sw_1em_l_2ez_v_		sw_em_dz_
xgrp="x2181";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"с") && s(-1) )
 { l[i]=omo2; R[886]++; if(dbg){print "R886", "sw_em_z_f"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo2; R[887]++; if(dbg){print "R887", "sw_em_z_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[888]++; if(dbg){print "R888", "sw_em_d_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[889]++; if(dbg){print "R889", "sw_em_l_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[890]++; if(dbg){print "R890", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2182 !_#_! ==> sw_1em_p_2es_ivp_		sw_ez_dp_
xgrp="x2182";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo1; R[891]++; if(dbg){print "R891", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo1; R[892]++; if(dbg){print "R892", "sw_es_v_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[893]++; if(dbg){print "R893", "sw_em_p_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo1; R[894]++; if(dbg){print "R894", "sw_es_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[895]++; if(dbg){print "R895", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[896]++; if(dbg){print "R896", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2183 !_#_! ==> sw_1em_p_2ez_dp_		sw_es_n_
xgrp="x2183";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="пике") {
   if ( q(-2,"pre_pr") &&
        q(-1,"prl_edsrpr prq_edsrpr") && s(-2,-1) )
   { l[i]=omo2; R[897]++; if(dbg){print "R897"}; continue };
   if ( q(-2,"pre_vi preph_vi") &&
        q(-1,"prl_edsrvi prq_edsrvi") && s(-2,-1) )
   { l[i]=omo2; R[898]++; if(dbg){print "R898"}; continue };
   cst="войти входить вывести выйти выходить";
   if ( bw(-3,cst) &&
         q(-2,"suw_vi") &&
         w(-1,"в из") && s(-3,-1) )
   { l[i]=omo2; r[1230]++; if(dbg){print "r1230"}; continue };
   if ( bw(-2,cst) &&
         w(-1,"в из") && s(-2,-1) )
   { l[i]=omo2; r[1230]++; if(dbg){print "r1230"}; continue };
 };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[899]++; if(dbg){print "R899", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[900]++; if(dbg){print "R900", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo1; R[901]++; if(dbg){print "R901", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2184 !_#_! ==> sw_1em_p_2ez_d_		sw_ez_p_
xgrp="x2184";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[902]++; if(dbg){print "R902", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[903]++; if(dbg){print "R903", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[904]++; if(dbg){print "R904", "sw_ez_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2185 !_#_! ==> sw_1em_r_2ez_i_		sw_mn_iv_
xgrp="x2185";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[905]++; if(dbg){print "R905", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[906]++; if(dbg){print "R906", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[907]++; if(dbg){print "R907", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[908]++; if(dbg){print "R908", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2186 !_#_! ==> sw_1em_r_2phrase_		sw_mn_i_
xgrp="x2186";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[909]++; if(dbg){print "R909", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[910]++; if(dbg){print "R910", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2187 !_#_! ==> sw_1ems_d_2ez_v_		sw_em_l_  миру  ми́ру  миру́
xgrp="x2187";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 # && wmark("Yme",lc(-1)) -- глагол с меткой "включение локатива" _gl_yes_locative
 if ( sw_em_l_f() )
 { l[i]=omo2; R[911]++; if(dbg){print "R911"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[912]++; if(dbg){print "R912", "sw_em_d_f"}; continue };
 #
 if ( sw_es_d_f() )
 { l[i]=omo1; R[913]++; if(dbg){print "R913", "sw_es_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo1; R[914]++; if(dbg){print "R914", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2188 !_#_! ==> sw_1ems_n_2ez_r_	sw_mn_iv_   виски  ви́ски  виски́
xgrp="x2188";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1

 if ( q(-3,"gl_peed gl_pemn deep_pe") &&
      q(-2,"mest_vi suw_odedvi suw_odmnvi") &&
 pre_vi(-1) && s(-3,-1) )
 { l[i]=omo2; R[915]++; if(dbg){print "R915"}; continue };
 if ( p(-1) && p(0) )
 { l[i]=omo1; R[916]++; if(dbg){print "R916"}; continue };
 if ( bba(-5,-1,"_gl_whisky") && s(bbn,-1) )
 { l[i]=omo1; R[917]++; if(dbg){print "R917"}; continue };
 if ( pre_tv(1) &&
           w(2,"льдом содовой") && s(0,1) )
 { l[i]=omo1; R[918]++; if(dbg){print "R918"}; continue };

 if ( bba(-5,-1,"_gl_viski") && s(bbn,-1) )
 { l[i]=omo2; R[919]++; if(dbg){print "R919"}; continue };
 if ( bfa(1,5,"_gl_viski") && s(0,bfn-1) )
 { l[i]=omo2; R[920]++; if(dbg){print "R920"}; continue };
 if ( q(1,"gl_vzmn") && s(0) )
 { l[i]=omo2; R[921]++; if(dbg){print "R921"}; continue };

 #
 if ( sw_es_z_f()||sw_em_i_f()||sw_es_i_f()||sw_em_v_f()||sw_es_v_f()||sw_em_r_f()||sw_es_r_f()||
      sw_em_d_f()||sw_es_d_f()||sw_em_t_f()||sw_es_t_f()||sw_em_p_f()||sw_es_p_f()||sw_ez_r_f() )
 { l[i]=omo1; R[922]++; if(dbg){print "R922"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[923]++; if(dbg){print "R923", "sw_mn_i_f"}; continue };
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[924]++; if(dbg){print "R924", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2189 !_#_! ==> sw_1em_vr_2ez_i_		sw_mn_iv_
xgrp="x2189";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[925]++; if(dbg){print "R925", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[926]++; if(dbg){print "R926", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[927]++; if(dbg){print "R927", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[928]++; if(dbg){print "R928", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[929]++; if(dbg){print "R929", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2190 !_#_! ==> sw_emz_r_		sw_mn_iv_  главы головы  главы́ головы́  гла́вы го́ловы
xgrp="x2190";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[930]++; if(dbg){print "R930", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[931]++; if(dbg){print "R931", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[932]++; if(dbg){print "R932", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[933]++; if(dbg){print "R933", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2191 !_#_! ==> sw_1es_n_2ez_r_		sw_mn_iv_
xgrp="x2191";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_z_f()||sw_es_i_f()||sw_es_v_f()||sw_es_r_f()||sw_es_d_f()||sw_es_t_f()||sw_es_p_f()||sw_ez_r_f() )
 { l[i]=omo1; R[934]++; if(dbg){print "R934", "sw_es_z_f()||sw_es_i_f()||sw_es_v_f()||sw_es_r_f()||sw_es_d_f()||sw_es_t_f()||sw_es_p_f()||sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[935]++; if(dbg){print "R935", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[936]++; if(dbg){print "R936", "sw_mn_v_f"}; continue };


 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2192 !_#_! ==> sw_1es_rz_2mn_iv_		sw_ez_i_
xgrp="x2192";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[937]++; if(dbg){print "R937", "sw_ez_i_f"}; continue };
 #
 if ( sw_es_z_f() )
 { l[i]=omo1; R[938]++; if(dbg){print "R938", "sw_es_z_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[939]++; if(dbg){print "R939", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[940]++; if(dbg){print "R940", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[941]++; if(dbg){print "R941", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2193 !_#_! ==> sw_1ez_dp_2mn_iv_		sw_ez_rl_
xgrp="x2193";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[942]++; if(dbg){print "R942", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[943]++; if(dbg){print "R943", "sw_ez_p_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[944]++; if(dbg){print "R944", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[945]++; if(dbg){print "R945", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2194 !_#_! ==> sw_1ez_dpr_2mn_iv_	        sw_ez_l_
xgrp="x2194";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="связи") {
   if ( w(-1,"в") && w(1,"с") && s(-1,0) )
   { l[i]=omo2; R[946]++; if(dbg){print "R946"}; continue }
   else
   { l[i]=omo1; R[947]++; if(dbg){print "R947"}; continue };
 };
 #
 if ( sw_ez_l_f() )
 { l[i]=omo2; R[948]++; if(dbg){print "R948", "sw_ez_l_f"}; continue };

 #
 l[i]=omo1; R[949]++; if(dbg){print "R949"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2195 !_#_! ==> sw_1ez_dr_2mn_iv_		sw_ez_p_
xgrp="x2195";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[950]++; if(dbg){print "R950", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[951]++; if(dbg){print "R951", "sw_mn_v_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[952]++; if(dbg){print "R952", "sw_ez_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2196 !_#_! ==> sw_1ez_drp_2mn_iv_		sw_ez_l_
xgrp="x2196";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_l_f() )
 { l[i]=omo2; R[953]++; if(dbg){print "R953", "sw_ez_l_f"}; continue };

 #
 l[i]=omo1; R[954]++; if(dbg){print "R954"}; continue

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2197 !_#_! ==> sw_1ez_i_2mn_iv_		sw_em_r_
xgrp="x2197";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[955]++; if(dbg){print "R955", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[956]++; if(dbg){print "R956", "sw_ez_i_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[957]++; if(dbg){print "R957", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[958]++; if(dbg){print "R958", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2198 !_#_! ==> sw_1ez_i_2mn_iv_		sw_es_r_
xgrp="x2198";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[959]++; if(dbg){print "R959", "sw_es_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[960]++; if(dbg){print "R960", "sw_ez_i_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[961]++; if(dbg){print "R961", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[962]++; if(dbg){print "R962", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2199 !_#_! ==> sw_1ez_p_2mn_iv_		sw_ez_drl_  груди  гру́ди  груди́
xgrp="x2199";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"его") && s(-1) )
 { l[i]=omo2; R[963]++; if(dbg){print "R963"}; continue };
 #
 if ( sw_ez_l_f() )
 { l[i]=omo2; R[964]++; if(dbg){print "R964", "sw_ez_l_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[965]++; if(dbg){print "R965", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[966]++; if(dbg){print "R966", "sw_ez_r_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo1; R[967]++; if(dbg){print "R967", "sw_ez_p_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[968]++; if(dbg){print "R968", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[969]++; if(dbg){print "R969", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2200 !_#_! ==> sw_1mn_r_2pl_kr_em_		sw_em_iv_
xgrp="x2200";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[970]++; if(dbg){print "R970", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[971]++; if(dbg){print "R971", "sw_em_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo1; R[972]++; if(dbg){print "R972", "sw_mn_r_f"}; continue };
 #
 if ( pl_kr_em_f() )
 { l[i]=omo1; R[973]++; if(dbg){print "R973", "pl_kr_em_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2201 !_#_! ==> sw_em_iv_		sw_mn_d_
xgrp="x2201";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_d_f() )
 { l[i]=omo2; R[974]++; if(dbg){print "R974", "sw_mn_d_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[975]++; if(dbg){print "R975", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[976]++; if(dbg){print "R976", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2202 !_#_! ==> sw_em_dl_		sw_ez_v_
xgrp="x2202";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[977]++; if(dbg){print "R977", "sw_ez_v_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[978]++; if(dbg){print "R978", "sw_em_d_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[979]++; if(dbg){print "R979", "sw_em_l_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2203 !_#_! ==> sw_em_dp_		sw_em_l_
xgrp="x2203";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#if ( ismark(-1,"Ykl") && notsym(-1,unxy) && s(-1) )
#{ l[i-1]=gensub(/([АЕЁИОУЫЭЮЯаеёиоуыэюя])/,"\\1\xcc\x81",1,l[i-1]); l[i]=gensub(/^(.)/,"\xcc\xa0\\1\xcc\xad",1,l[i]); R[980]++; if(dbg){print "R980"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[981]++; if(dbg){print "R981", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[982]++; if(dbg){print "R982", "sw_em_d_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[983]++; if(dbg){print "R983", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2204 !_#_! ==> sw_em_dz_		sw_em_l_
xgrp="x2204";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#if ( ismark(-1,"Ykl") && notsym(-1,unxy) && s(-1) )
#{ l[i-1]=gensub(/([АЕЁИОУЫЭЮЯаеёиоуыэюя])/,"\\1\xcc\x81",1,l[i-1]); l[i]=gensub(/^(.)/,"\xcc\xa0\\1\xcc\xad",1,l[i]); R[984]++; if(dbg){print "R984"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[985]++; if(dbg){print "R985", "sw_em_z_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[986]++; if(dbg){print "R986", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[987]++; if(dbg){print "R987", "sw_em_d_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2205 !_#_! ==> sw_em_d_		sw_em_k_
xgrp="x2205";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[988]++; if(dbg){print "R988", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2206 !_#_! ==> sw_em_d_		sw_em_l_
xgrp="x2206";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="мозгу") {
   if ( w(-1,"за") && s(-1) )
   { l[i]=omo2; R[989]++; if(dbg){print "R989"}; continue };
 };
 #
#if ( ismark(-1,"Ykl") && notsym(-1,unxy) && s(-1) )
#{ l[i-1]=gensub(/([АЕЁИОУЫЭЮЯаеёиоуыэюя])/,"\\1\xcc\x81",1,l[i-1]); l[i]=gensub(/^(.)/,"\xcc\xa0\\1\xcc\xad",1,l[i]); R[990]++; if(dbg){print "R990"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[991]++; if(dbg){print "R991", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[992]++; if(dbg){print "R992", "sw_em_d_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2207 !_#_! ==> sw_em_d_		sw_em_p_
xgrp="x2207";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[993]++; if(dbg){print "R993", "sw_em_p_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[994]++; if(dbg){print "R994", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2208 !_#_! ==> sw_em_d_		sw_em_v_
xgrp="x2208";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[995]++; if(dbg){print "R995", "sw_em_v_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[996]++; if(dbg){print "R996", "sw_em_d_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2209 !_#_! ==> sw_em_d_		sw_ez_d_
xgrp="x2209";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[997]++; if(dbg){print "R997", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[998]++; if(dbg){print "R998", "sw_ez_d_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2210 !_#_! ==> sw_em_d_		sw_ez_v_
xgrp="x2210";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[999]++; if(dbg){print "R999", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1000]++; if(dbg){print "R1000", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2211 !_#_! ==> deep_pa_   sw_em_i_
xgrp="x2211";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[1001]++; if(dbg){print "R1001", "sw_em_i_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2212 !_#_! ==> sw_em_dz_		sw_em_l_
xgrp="x2212";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[1002]++; if(dbg){print "R1002", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[1003]++; if(dbg){print "R1003", "sw_em_d_f"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[1004]++; if(dbg){print "R1004", "sw_em_z_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2213 !_#_! ==> sw_em_dz_		sw_ez_v_
xgrp="x2213";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[1005]++; if(dbg){print "R1005", "sw_em_z_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[1006]++; if(dbg){print "R1006", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1007]++; if(dbg){print "R1007", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2214 !_#_! ==> sw_em_i_		sw_em_t_
xgrp="x2214";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1008]++; if(dbg){print "R1008", "sw_em_i_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[1009]++; if(dbg){print "R1009", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2215 !_#_! ==> sw_em_i_		sw_em_vr_
xgrp="x2215";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1010]++; if(dbg){print "R1010", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[1011]++; if(dbg){print "R1011", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1012]++; if(dbg){print "R1012", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2216 !_#_! ==> sw_em_i_		sw_mn_r_   одушевленные
xgrp="x2216";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="черт") {
   cst="где зачем как когда кто куда насколько сколько че что";
   if ( qxs(1,"знает",cst) )
   { l[i]=omo1; R[1013]++; if(dbg){print "R1013"}; continue };
   if ( q(-2,"prl_edim prl_kred") && w(-1,"как") && zs(-2) && s(-1) )
   { l[i]=omo1; R[1014]++; if(dbg){print "R1014"}; continue };
   if ( q(1,"mest_vi mest_3e") && w(2,cst) && s(0,1) )
   { l[i]=omo1; R[1015]++; if(dbg){print "R1015"}; continue };
   if ( w(1,"с") && q(2,"mest_tv mest_3e isname suw_tv") && s(0,1) )
   { l[i]=omo1; R[1016]++; if(dbg){print "R1016"}; continue };
   if ( p(-1) && p(0) )
   { l[i]=omo1; R[1017]++; if(dbg){print "R1017"}; continue };
   cst="взять дернуть драть знать побрать подрать";
   if ( bf(1,4,cst) && s(0,bfn-1) &&
       qia(1,bfn-1,"qast_by","mest_vi mest_3e mest_it") )
   { l[i]=omo1; R[1018]++; if(dbg){print "R1018"}; continue };
   if ( q(-1,"mest_tv mest_3e prl_tv") && s(-1) )
   { l[i]=omo2; R[1019]++; if(dbg){print "R1019"}; continue };
 };
 #
 if ( name_im_sy(1) && s(0) )
 { l[i]=omo1; R[1020]++; if(dbg){print "R1020"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1021]++; if(dbg){print "R1021", "sw_em_i_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1022]++; if(dbg){print "R1022", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2217 !_#_! ==> sw_em_i_		sw_mn_vr_
xgrp="x2217";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( Q(-1,"suw_ro") && p(-1) && p(0) )
 { l[i]=omo1; R[1023]++; if(dbg){print "R1023"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1024]++; if(dbg){print "R1024", "sw_em_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1025]++; if(dbg){print "R1025", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1026]++; if(dbg){print "R1026", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2218 !_#_! ==> sw_em_iv_		sw_em_t_
xgrp="x2218";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[1027]++; if(dbg){print "R1027", "sw_em_t_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1028]++; if(dbg){print "R1028", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1029]++; if(dbg){print "R1029", "sw_em_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2219 !_#_! ==> sw_em_iv_		sw_mn_p_
xgrp="x2219";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1030]++; if(dbg){print "R1030", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1031]++; if(dbg){print "R1031", "sw_em_v_f"}; continue };
 #
 if ( sw_mn_p_f() )
 { l[i]=omo2; R[1032]++; if(dbg){print "R1032", "sw_mn_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2220 !_#_! ==> sw_em_iv_		sw_mn_r_
xgrp="x2220";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="округ") {
   if ( name_im_sy(1) && s(0) )
   { l[i]=omo1; R[1033]++; if(dbg){print "R1033"}; continue };
 };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1034]++; if(dbg){print "R1034", "sw_mn_r_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1035]++; if(dbg){print "R1035", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1036]++; if(dbg){print "R1036", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2221 !_#_! ==> sw_em_iv_		sw_mn_vr_
xgrp="x2221";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 if(iwrd=="белок") {
   cst="охота охотиться";
   if ( bw(-2,cst) &&
    pre_vi(-1) && s(-2,-1) )
   { l[i]=omo2; R[1037]++; if(dbg){print "R1037"}; continue };
 };
 if ( qxs(-1,"что","за") )
 { l[i]=omo1; R[1038]++; if(dbg){print "R1038"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1039]++; if(dbg){print "R1039", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1040]++; if(dbg){print "R1040", "sw_em_v_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1041]++; if(dbg){print "R1041", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1042]++; if(dbg){print "R1042", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2222 !_#_! ==> sw_em_l_		sw_ems_dz_
xgrp="x2222";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[1043]++; if(dbg){print "R1043", "sw_em_d_f"}; continue };
 #
 if ( sw_es_d_f() )
 { l[i]=omo2; R[1044]++; if(dbg){print "R1044", "sw_es_d_f"}; continue };
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[1045]++; if(dbg){print "R1045", "sw_em_l_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2223 !_#_! ==> sw_em_n_		sw_em_p_
xgrp="x2223";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[1046]++; if(dbg){print "R1046", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2224 !_#_! ==> sw_em_n_		sw_mn_iv_
xgrp="x2224";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1047]++; if(dbg){print "R1047", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1048]++; if(dbg){print "R1048", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2225 !_#_! ==> gl_paedze_	sw_1es_r_2mn_iv_   начала  начала́  нача́ла
xgrp="x2225";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( w(-2,"с до") &&
      w(-1,"самого") && s(-2,-1) )
 { l[i]=omo2; R[1049]++; if(dbg){print "R1049"}; continue };

 if ( gl_in(1) && s(0) )
 { l[i]=omo1; R[1050]++; if(dbg){print "R1050"}; continue };
 if ( w(1,"было") &&
     (q(2,"gl_in isname")||w(2,"он")) && s(0,1) )
 { l[i]=omo1; R[1051]++; if(dbg){print "R1051"}; continue };
 if ( sc(-1,"—") &&
 (isname(1)||suw_edmuim(1)||w(1,"он")) && s(0) )
 { l[i]=omo1; R[1052]++; if(dbg){print "R1052"}; continue };

 if ( q(1,"prl_kred_sr nar_spos") && Q(-1,"pre_ro preph_ro") &&
  gl_in(2) && s(0,1) )
 { l[i]=omo1; R[1053]++; if(dbg){print "R1053"}; continue };
 if ( (suw_edzeim(1)||w(1,"она")) && s(0) )
 { l[i]=omo1; R[1054]++; if(dbg){print "R1054"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[1055]++; if(dbg){print "R1055", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1056]++; if(dbg){print "R1056", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1057]++; if(dbg){print "R1057", "sw_mn_v_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[1058]++; if(dbg){print "R1058", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2226 !_#_! ==> sw_em_p_		sw_em_t_
xgrp="x2226";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1059]++; if(dbg){print "R1059", "sw_em_p_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[1060]++; if(dbg){print "R1060", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2227 !_#_! ==> sw_em_p_		sw_es_iv_
xgrp="x2227";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[1061]++; if(dbg){print "R1061", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[1062]++; if(dbg){print "R1062", "sw_es_v_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1063]++; if(dbg){print "R1063", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2228 !_#_! ==> sw_em_p_		sw_es_n_
xgrp="x2228";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1064]++; if(dbg){print "R1064", "sw_em_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2229 !_#_! ==> sw_em_p_		sw_es_p_     сти́ле  стиле́
xgrp="x2229";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1065]++; if(dbg){print "R1065", "sw_em_p_f"}; continue };
 #
#if ( sw_es_p_f() )
#{ l[i]=omo2; R[1066]++; if(dbg){print "R1066"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2230 !_#_! ==> sw_em_p_		sw_ez_dp_
xgrp="x2230";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 if(iwrd=="дружке") {
   if ( qxs(-1,"друг")||
        qxs(-1,"друг","на по ко") )
   { l[i]=omo2; R[1067]++; if(dbg){print "R1067"}; continue };
 };

 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1068]++; if(dbg){print "R1068", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1069]++; if(dbg){print "R1069", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1070]++; if(dbg){print "R1070", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2231 !_#_! ==> sw_em_q_		sw_em_r_
xgrp="x2231";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_q_f() )
 { l[i]=omo1; R[1071]++; if(dbg){print "R1071", "sw_em_q_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1072]++; if(dbg){print "R1072", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2232 !_#_! ==> sw_em_r_		sw_es_ivr_
xgrp="x2232";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[1073]++; if(dbg){print "R1073", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[1074]++; if(dbg){print "R1074", "sw_es_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1075]++; if(dbg){print "R1075", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2233 !_#_! ==> sw_em_r_		sw_ez_i_
xgrp="x2233";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1076]++; if(dbg){print "R1076", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1077]++; if(dbg){print "R1077", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2234 !_#_! ==> sw_em_r_		sw_mn_i_
xgrp="x2234";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1078]++; if(dbg){print "R1078", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1079]++; if(dbg){print "R1079", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2235 !_#_! ==> sw_em_r_		sw_mn_iv_
xgrp="x2235";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="бока") {
   cst="намять отлёживать поцарапать";
   if ( bw(1,cst) && s(0) )
   { l[i]=omo2; R[1080]++; if(dbg){print "R1080"}; continue };
 };
 if(iwrd=="вечера") {
   cst="минут часов";
   if ( (w(-1,cst)||q(-1,"qi_ed qi_mn")) && s(-1) )
   { l[i]=omo1; R[1081]++; if(dbg){print "R1081"}; continue };
 };
 if(iwrd=="года") {
   if ( (q(1,"qi_duom")||wc(1,"[234][^0-9]*$")) && s(0) )
   { l[i]=omo1; R[1082]++; if(dbg){print "R1082"}; continue };
 };
 if(iwrd=="города") {
   if ( w(-1,"смелость") && w(1,"берёт берет") && s(-1,0) )
   { l[i]=omo2; R[1083]++; if(dbg){print "R1083"}; continue };
 };
 if(iwrd=="рода") {
   if ( w(1,"племени") && sc(0,"-") )
   { l[i]=omo1; R[1084]++; if(dbg){print "R1084"}; continue };
 };
 if(iwrd=="роста") {
   if ( w(1,"в") && q(2,"mest_pr suw_pr") && s(0,1) )
   { l[i]=omo1; R[1085]++; if(dbg){print "R1085"}; continue };
 };
 if(iwrd=="веса") {
   if ( w(1,"в") && q(2,"mest_pr suw_pr") && s(0,1) )
   { l[i]=omo1; R[1086]++; if(dbg){print "R1086"}; continue };
 };
 if(iwrd=="шенкеля") {
   if ( wb(-3,-1,"дать дал дала дав задать задал задала") && s(wbn,-1) )
   { l[i]=omo2; R[1087]++; if(dbg){print "R1087"}; continue };
 };
 #
 if ( pre_ro(-1) && Q(-1,"pre_im pre_vi") && s(-1) )
 { l[i]=omo1; R[1088]++; if(dbg){print "R1088"}; continue };
 if ( q(-1,"pre_im pre_vi") && Q(-1,"pre_ro") && s(-1) )
 { l[i]=omo2; R[1089]++; if(dbg){print "R1089"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1090]++; if(dbg){print "R1090", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1091]++; if(dbg){print "R1091", "sw_mn_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1092]++; if(dbg){print "R1092", "sw_em_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2236 !_#_! ==> sw_ems_p_		sw_es_iv_
xgrp="x2236";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[1093]++; if(dbg){print "R1093", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[1094]++; if(dbg){print "R1094", "sw_es_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2237 !_#_! ==> sw_ems_r_		sw_mn_iv_  века  ве́ка  века́
xgrp="x2237";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 if ( sc(-1,"[^-]\\s?[IVXLCM]+\\s$") && W(-1,"и или да") )
 { l[i]=omo1; R[1095]++; if(dbg){print "R1095"}; continue };
 if ( sc(-1,"[-]\\s?[IVXLCM]+\\s$") || sz_iili(-1) )
 { l[i]=omo2; R[1096]++; if(dbg){print "R1096"}; continue };

 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1097]++; if(dbg){print "R1097", "sw_em_r_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1098]++; if(dbg){print "R1098", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1099]++; if(dbg){print "R1099", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1100]++; if(dbg){print "R1100", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2238 !_#_! ==> sw_em_t_		sw_ems_p_
xgrp="x2238";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[1101]++; if(dbg){print "R1101", "sw_em_p_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[1102]++; if(dbg){print "R1102", "sw_es_p_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo1; R[1103]++; if(dbg){print "R1103", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2239 !_#_! ==> sw_em_t_		sw_es_p_
xgrp="x2239";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo1; R[1104]++; if(dbg){print "R1104", "sw_em_t_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[1105]++; if(dbg){print "R1105", "sw_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2240 !_#_! ==> m2_1nar_spos_2sw_em_t_		sw_mn_r_
xgrp="x2240";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="хором") {
   if ( q(-1,"gl_mn gl_vzmn gl_pomn deep") && ba(-1,"_gl_talk") && s(-1) )
   { l[i]=omo1; R[1106]++; if(dbg){print "R1106"}; continue };
   if ( q(1,"gl_mn gl_vzmn gl_pomn deep") && ba(1,"_gl_talk") && s(0) )
   { l[i]=omo1; R[1107]++; if(dbg){print "R1107"}; continue };
 };
 #
 if ( nar_spos_f() )
 { l[i]=omo1; R[1108]++; if(dbg){print "R1108", "nar_spos_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo1; R[1109]++; if(dbg){print "R1109", "sw_em_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1110]++; if(dbg){print "R1110", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2241 !_#_! ==> sw_em_vr_		sw_ez_i_
xgrp="x2241";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="черта") {
   if ( w(-1,"ни") &&
      Q_w(1,"suw_ro mest_ro") && s(-1) )
   { l[i]=omo2; R[1111]++; if(dbg){print "R1111"}; continue };
   if ( w(-1,"ни") &&
        q(1,"prl_edro") && s(-1) )
   { l[i]=omo2; R[1112]++; if(dbg){print "R1112"}; continue };
   if ( w(-1,"на") &&
        q(1,"mest_da suw_da") && s(-1,0) )
   { l[i]=omo2; R[1113]++; if(dbg){print "R1113"}; continue };
   if ( qxs(1,"с","два") )
   { l[i]=omo1; R[1114]++; if(dbg){print "R1114"}; continue };
   cst="натуры характера";
   if ( wf(1,3,cst) && s(0,wfn-1) &&
       qir(1,bfn-1,"mest_3e mest_ro prl_ro") )
   { l[i]=omo2; R[1115]++; if(dbg){print "R1115"}; continue };
 };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1116]++; if(dbg){print "R1116", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1117]++; if(dbg){print "R1117", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1118]++; if(dbg){print "R1118", "sw_em_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2242 !_#_! ==> sw_em_vr_		sw_mn_i_  < одушевленные! >
xgrp="x2242";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="господа") {
   if ( p(-1) && p(0) )
   { l[i]=omo2; R[1119]++; if(dbg){print "R1119"}; continue };
   cst="бога нашего";
   if ( w(1,cst) && s(0) )
   { l[i]=omo1; R[1120]++; if(dbg){print "R1120"}; continue };
   if ( suw_odmnim(1) && s(0) )
   { l[i]=omo2; R[1121]++; if(dbg){print "R1121"}; continue };
 };
 #
 if ( name_im_sy(1) &&
         sz_iili(2) &&
      name_im_sy(3) && s(0,2) )
 { l[i]=omo2; R[1122]++; if(dbg){print "R1122"}; continue };
 #
 if ( q(1,"name_vi_sy name_ro_sy") && s(0) )
 { l[i]=omo1; R[1123]++; if(dbg){print "R1123"}; continue };

 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1124]++; if(dbg){print "R1124", "sw_em_r_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1125]++; if(dbg){print "R1125", "sw_em_v_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1126]++; if(dbg){print "R1126", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2243 !_#_! ==> sw_em_vr_		sw_mn_iv_
xgrp="x2243";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_v_f() )
 { l[i]=omo1; R[1127]++; if(dbg){print "R1127", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1128]++; if(dbg){print "R1128", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1129]++; if(dbg){print "R1129", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1130]++; if(dbg){print "R1130", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2244 !_#_! ==> gl_paedmu_	sw_mn_r_  начал  на́чал  нача́л
xgrp="x2244";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
   if ( q(1,"mest_vi mest_3e") &&
    gl_in(2) && s(0,1) )
   { l[i]=omo1; R[1131]++; if(dbg){print "R1131"}; continue };
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[1132]++; if(dbg){print "R1132"}; continue };
   if ( (w(1,"было")||q(1,"prl_kred_sr mest_da suw_da")) &&
        (q(2,"gl_in name_im_sy isname")||w(2,"он")) && s(0,1) )
   { l[i]=omo1; R[1133]++; if(dbg){print "R1133"}; continue };
   if ( sc(-2,"—") &&
         q(-1,"nar_spos nar_kaq nar_vrem prl_kred_sr") &&
        (q(1,"suw_edmuim name_im_sy isname")||w(1,"он")) && s(-1,0) )
   { l[i]=omo1; R[1134]++; if(dbg){print "R1134"}; continue };
   if ( sc(-1,"—") &&
        (q(1,"suw_edmuim name_im_sy isname prl_edmuim")||w(1,"он")||sc(1,"[A-Za-z]+")) && s(0) )
   { l[i]=omo1; R[1135]++; if(dbg){print "R1135"}; continue };
   if ( q(1,"pre_vi preph_vi") &&
        q(2,"suw_vi prl_vi prq_vi mest_vi") && s(0,1) )
   { l[i]=omo1; R[1136]++; if(dbg){print "R1136"}; continue };
   if ( q(1,"pre_ro preph_ro") &&
        q(2,"suw_ro prl_ro prq_ro mest_ro") && s(0,1) )
   { l[i]=omo1; R[1137]++; if(dbg){print "R1137"}; continue };
   if ( q(1,"pre_tv preph_tv") &&
        q(2,"suw_tv prl_tv prq_tv mest_tv") && s(0,1) )
   { l[i]=omo1; R[1138]++; if(dbg){print "R1138"}; continue };
   if ( pre_pr(1) &&
             q(2,"suw_pr prl_pr prq_pr mest_pr") && s(0,1) )
   { l[i]=omo1; R[1139]++; if(dbg){print "R1139"}; continue };
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[1140]++; if(dbg){print "R1140"}; continue };
   if ( (q(-1,"suw_edmuim name_im_sy isname")||w(-1,"он")) &&
         q(1,"suw_vi") && s(-1,0) )
   { l[i]=omo1; R[1141]++; if(dbg){print "R1141"}; continue };

 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[1142]++; if(dbg){print "R1142", "gl_paedmu_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1143]++; if(dbg){print "R1143", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2245 !_#_! ==> sw_es_d_		sw_ez_t_
xgrp="x2245";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_d_f() )
 { l[i]=omo1; R[1144]++; if(dbg){print "R1144", "sw_es_d_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[1145]++; if(dbg){print "R1145", "sw_ez_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2246 !_#_! ==> sw_es_d_		sw_ez_v_
xgrp="x2246";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_d_f() )
 { l[i]=omo1; R[1146]++; if(dbg){print "R1146", "sw_es_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1147]++; if(dbg){print "R1147", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2247 !_#_! ==> sw_es_i_		sw_es_v_
xgrp="x2247";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo1; R[1148]++; if(dbg){print "R1148", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[1149]++; if(dbg){print "R1149", "sw_es_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2248 !_#_! ==> sw_es_iv_		sw_es_p_
xgrp="x2248";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1

 if(iwrd=="крыльце") {
   if ( w(-1,"на") && s(-1) )
   { l[i]=omo2; R[1150]++; if(dbg){print "R1150"}; continue };
 };
 #
 if ( sw_es_i_f() )
 { l[i]=omo1; R[1151]++; if(dbg){print "R1151", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo1; R[1152]++; if(dbg){print "R1152", "sw_es_v_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo2; R[1153]++; if(dbg){print "R1153", "sw_es_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2249 !_#_! ==> sw_es_n_		sw_ez_dp_
xgrp="x2249";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1154]++; if(dbg){print "R1154", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1155]++; if(dbg){print "R1155", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2250 !_#_! ==> sw_es_n_		sw_ez_p_
xgrp="x2250";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1156]++; if(dbg){print "R1156", "sw_ez_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2251 !_#_! ==> sw_es_n_		sw_ez_v_
xgrp="x2251";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1157]++; if(dbg){print "R1157", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2252 !_#_! ==> sw_es_p_		sw_ez_dp_
xgrp="x2252";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_p_f() )
 { l[i]=omo1; R[1158]++; if(dbg){print "R1158", "sw_es_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1159]++; if(dbg){print "R1159", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1160]++; if(dbg){print "R1160", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2253 !_#_! ==> sw_es_rz_		sw_ez_i_
xgrp="x2253";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_z_f() )
 { l[i]=omo1; R[1161]++; if(dbg){print "R1161", "sw_es_z_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1162]++; if(dbg){print "R1162", "sw_es_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1163]++; if(dbg){print "R1163", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2254 !_#_! ==> sw_es_r_      sw_mn_iv_
xgrp="x2254";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="утра") {
   cst="до минут от с часов";
   if ( (w(-1,cst)||q(-1,"qi_ed qi_mn nar_vrem")) && s(-1) )
   { l[i]=omo1; R[1164]++; if(dbg){print "R1164"}; continue };
 };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1165]++; if(dbg){print "R1165", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1166]++; if(dbg){print "R1166", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1167]++; if(dbg){print "R1167", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2255 !_#_! ==> sw_em_r_		sw_mn_iv_  цвета  цве́та  цвета́
xgrp="x2255";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( ( suw_mnim(-2)||(suw_mnim(-3) && q(-2,"name_ro_sy isname")) && s(-3)) &&
               w(-1,"были") &&
               q(1,"prl_ro suw_ro prq_ro suw_edne") && s(-2,0) )
 { l[i]=omo1; R[1168]++; if(dbg){print "R1168"}; continue };
 cst="был была было";
 if ( (suw_any(-1)||w(-1,cst)) && Q(-1,"prl_mnim") &&
             q(1,"prl_ro suw_ro prq_ro suw_edne") && s(-1,0) )
 { l[i]=omo1; R[1169]++; if(dbg){print "R1169"}; continue };
 cst="был была было";
 if ( (suw_any(-1)||w(-1,cst)) && Q(-1,"prl_mnim") &&
            qf(1,5,"suw_ro suw_edne") && s(-1,qfn-1) )
 { l[i]=omo1; R[1170]++; if(dbg){print "R1170"}; continue };
 if ( muk_edmuro(-2) &&
               q(-1,"mest_im suw_im") && s(-2,-1) )
 { l[i]=omo1; R[1171]++; if(dbg){print "R1171"}; continue };
 if ( prl_any(-1) && z(-1) &&
            q(1,"mest_ro prl_ro prq_ro") &&
            q(2,"suw_ro") && s(0,1) )
 { l[i]=omo1; R[1172]++; if(dbg){print "R1172"}; continue };
 if ( prl_any(-1) && z(-1) &&
            q(1,"suw_ro") && s(0) )
 { l[i]=omo1; R[1173]++; if(dbg){print "R1173"}; continue };
 #
 if ( pre_ro(-1) && Q(-1,"pre_im pre_vi") && s(-1) )
 { l[i]=omo1; R[1174]++; if(dbg){print "R1174"}; continue };
 if ( q(-1,"pre_im pre_vi") && Q(-1,"pre_ro") && s(-1) )
 { l[i]=omo2; R[1175]++; if(dbg){print "R1175"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1176]++; if(dbg){print "R1176", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1177]++; if(dbg){print "R1177", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1178]++; if(dbg){print "R1178", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2256 !_#_! ==> sw_ez_iv_		sw_mn_r_
xgrp="x2256";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1179]++; if(dbg){print "R1179", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2257 !_#_! ==> sw_ez_r_		sw_mn_i_
xgrp="x2257";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1180]++; if(dbg){print "R1180", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1181]++; if(dbg){print "R1181", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2258 !_#_! ==> sw_ez_r_      sw_mn_iv_
xgrp="x2258";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="весны") {
   if ( bw(-1,"гончая") && s(-1) )
   { l[i]=omo1; R[1182]++; if(dbg){print "R1182"}; continue };
 };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1183]++; if(dbg){print "R1183", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1184]++; if(dbg){print "R1184", "sw_mn_v_f"}; continue };
 #
 cst="деньги";
 if ( W(0,cst) && sw_ez_r_f() )
 { l[i]=omo1; R[1185]++; if(dbg){print "R1185", "sw_ez_r_f"}; continue };

#if ( wc(-1,"[ео]й$ [ео]йся$") && s(-1) )
#{ l[i]=omo1; R[1186]++; if(dbg){print "R1186"}; continue };
#if ( wc(-1,"[иы]е$ [иы]еся$") && s(-1) )
#{ l[i]=omo2; R[1187]++; if(dbg){print "R1187"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2259 !_#_! ==> sw_ez_r_		sw_mn_v_
xgrp="x2259";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1188]++; if(dbg){print "R1188", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1189]++; if(dbg){print "R1189", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2260 !_#_! ==> sw_ez_t_		sw_ez_v_
xgrp="x2260";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo1; R[1190]++; if(dbg){print "R1190", "sw_ez_t_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1191]++; if(dbg){print "R1191", "sw_ez_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2261 !_#_! ==> sw_ez_t_		sw_mn_r_
xgrp="x2261";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo1; R[1192]++; if(dbg){print "R1192", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1193]++; if(dbg){print "R1193", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2262 !_#_! ==> sw_ez_t_		sw_mn_vr_
xgrp="x2262";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo1; R[1194]++; if(dbg){print "R1194", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1195]++; if(dbg){print "R1195", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1196]++; if(dbg){print "R1196", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2263 !_#_! ==> sw_mn_p_		sw_mn_r_
xgrp="x2263";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_p_f() )
 { l[i]=omo1; R[1197]++; if(dbg){print "R1197", "sw_mn_p_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1198]++; if(dbg){print "R1198", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2264 !_#_! ==> sw_mn_p_      sw_mn_vr_
xgrp="x2264";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_p_f() )
 { l[i]=omo1; R[1199]++; if(dbg){print "R1199", "sw_mn_p_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1200]++; if(dbg){print "R1200", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1201]++; if(dbg){print "R1201", "sw_mn_r_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2265 !_#_! ==> mest_1ems_t_2mn_d_       mest_ems_p_
xgrp="x2265";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="во на о обо при";
 if ( wb(-5,-1,cst) && s(wbn,-1) &&
     qir(wbn+1,-1,"mest_pr prl_pr") )
 { l[i]=omo2; R[1202]++; if(dbg){print "R1202"}; continue };
 #
 if ( !(vex(wbn) && s(wbn,-1)) )
 { l[i]=omo1; R[1203]++; if(dbg){print "R1203"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2266 !_#_! ==> m2_1mest_es_r_2souz_     mest_es_p_    чем  че́м  чём
xgrp="x2266";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="в на о об по при";
 if ( !(w(-2,"не") && s(-2)) &&
        w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1204]++; if(dbg){print "R1204"}; continue };
 #
 if ( tolower(l[i])==iwrd )
 { l[i]=omo1; R[1205]++; if(dbg){print "R1205"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2267 !_#_! ==> qip_iv_       sw_mn_vr_    сорок  со́рок  соро́к
xgrp="x2267";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"suw_mnro suw_mnsq qi_ed qi_mn") && s(0) )
 { l[i]=omo1; R[1206]++; if(dbg){print "R1206"}; continue };
 if ( q(-1,"suw_mnro suw_mnsq qi_ed qi_mn") && s(-1) )
 { l[i]=omo1; R[1207]++; if(dbg){print "R1207"}; continue };
 if ( q(-2,"qi_ed qi_mn") &&
      w(-1,"или") && s(-2,-1) )
 { l[i]=omo1; R[1208]++; if(dbg){print "R1208"}; continue };
 if ( w(1,"или") &&
      q(2,"qi_ed qi_mn") && s(0,1) )
 { l[i]=omo1; R[1209]++; if(dbg){print "R1209"}; continue };
 cst="за по под";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1210]++; if(dbg){print "R1210"}; continue };

 cst="в за на под";
 if ( suw_mnro(-2) &&
             w(-1,cst) && s(-2,-1) )
 { l[i]=omo1; R[1211]++; if(dbg){print "R1211"}; continue };

 if ( qxs(1,"с","половиной четвертью небольшим") )
 { l[i]=omo1; R[1212]++; if(dbg){print "R1212"}; continue };
 if ( q(-1,"gl_pein gl_peed gl_pemn gl_popeed gl_popemn deep_pe") && s(-1) )
 { l[i]=omo1; R[1213]++; if(dbg){print "R1213"}; continue };

 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1214]++; if(dbg){print "R1214", "sw_mn_r_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1215]++; if(dbg){print "R1215", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2268 !_#_! ==> qip_dprt_     sw_ez_i_   сорока  сорока́  соро́ка
xgrp="x2268";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 #
 cst="более менее около";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1216]++; if(dbg){print "R1216"}; continue };
 if ( pre_pr(-1) &&
           q(1,"suw_mnpr qik_pr") && s(-1,0) )
 { l[i]=omo1; R[1217]++; if(dbg){print "R1217"}; continue };
 if ( q(-2,"qik_ro") &&
      q(-1,"sz_iili") && s(-2,-1) )
 { l[i]=omo1; R[1218]++; if(dbg){print "R1218"}; continue };
 if ( q(-1,"suw_mnro suw_mnsq qik_ro") && s(-1) )
 { l[i]=omo1; R[1219]++; if(dbg){print "R1219"}; continue };
 if ( q(1,"suw_mnro suw_mnsq qik_ro") && s(0) )
 { l[i]=omo1; R[1220]++; if(dbg){print "R1220"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1221]++; if(dbg){print "R1221", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2269 !_#_! ==> mest_ems_d_   sw_em_d_   тому  тому́  то́му
xgrp="x2269";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="как что чтоб чтобы";
 if ( z(0) &&
     (q(1,"muk_ed muk_mn mest_ed mest_mn")||w(1,cst)) )
 { l[i]=omo1; R[1222]++; if(dbg){print "R1222"}; continue };

 if ( q(-1,"mod_ed mod_mn mod_bz gl_in") &&
      q(1,"gl_in") && s(-1,0) )
 { l[i]=omo1; R[1223]++; if(dbg){print "R1223"}; continue };

 if ( prl_any(-2) &&
       pre_da(-1) &&
            z(0) && s(-2,-1) )
 { l[i]=omo1; R[1224]++; if(dbg){print "R1224"}; continue };
 if ( sz_iili(1) &&
            q(2,"mest_da") && s(0,1) )
 { l[i]=omo1; R[1225]++; if(dbg){print "R1225"}; continue };
 if ( pre_da(-1) &&
          (q(1,"suw_edmuda suw_edsrda")||w(1,"же")) && s(-1,0) )
 { l[i]=omo1; R[1226]++; if(dbg){print "R1226"}; continue };
 if ( pre_da(-1) &&
          (q(1,"suw_edmuda suw_edsrda")||w(1,"же")) && s(-1,0) )
 { l[i]=omo1; R[1227]++; if(dbg){print "R1227"}; continue };
 if ( w(1,"же") &&
      q(2,"suw_edmuda suw_edsrda") && s(0,1) )
 { l[i]=omo1; R[1228]++; if(dbg){print "R1228"}; continue };
 if ( q(-1,"suw_ro qik_im suw_vi") &&
      w(1,"назад") && s(-1) )
 { l[i]=omo1; R[1229]++; if(dbg){print "R1229"}; continue };

 cst="подобный";
 if (  bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[1230]++; if(dbg){print "R1230"}; continue };
 if (  bw(1,cst) && s(0) )
 { l[i]=omo1; R[1231]++; if(dbg){print "R1231"}; continue };
 #
 if ( q(-1,"prl_edmuda") && s(-1) )
 { l[i]=omo2; R[1232]++; if(dbg){print "R1232", "sw_em_d_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2270 !_#_! ==>	deep_na_    pre_combo_  судя судя́ су́дя
xgrp="x2270";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(1,"по") && s(0) )
 { l[i]=omo2; R[1233]++; if(dbg){print "R1233"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2271 !_#_! ==> m2_1sw_ez_i_2predik_     sw_ez_i_  пора  пора́  по́ра
xgrp="x2271";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qf(1,3,"gl_in") && s(0,qfn-1) )
 { l[i]=omo1; R[1234]++; if(dbg){print "R1234"}; continue };
 if ( mest_da(-1) )
 { l[i]=omo1; R[1235]++; if(dbg){print "R1235"}; continue };
 if ( p(-1)||p(0) )
 { l[i]=omo1; R[1236]++; if(dbg){print "R1236"}; continue };
 if ( q(-1,"gl_paedze") )
 { l[i]=omo1; R[1237]++; if(dbg){print "R1237"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2272 !_#_! ==> m2_1pl_kr_ez_2sw_mn_iv_  sw_es_r_  права  права́  пра́ва
xgrp="x2272";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if ( q(-4,"gl_pein gl_peed gl_pemn deep_pe prq_pe gl_pnin gl_pned gl_pnmn deep_pn prq_pn") &&
      q(-3,"suw_vi") &&
         suw_edro(-2) && sz_iili(-1) && s(-4,-1) )
 { l[i]=omo1; R[1238]++; if(dbg){print "R1238"}; continue };
 if ( qxs(-1,"как","при","этом") )
 { l[i]=omo1; R[1239]++; if(dbg){print "R1239"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[1240]++; if(dbg){print "R1240", "sw_es_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[1241]++; if(dbg){print "R1241", "pl_kr_ez_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[1242]++; if(dbg){print "R1242", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[1243]++; if(dbg){print "R1243", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2273 !_#_! ==> samogo1_ samogo2_   самого  са́мого  самого́
xgrp="x2273";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="посыльного раненого травмированного";
 if (  w(1,cst) && s(0) )
 { l[i]=omo2; R[1244]++; if(dbg){print "R1244"}; continue };

 if ( q(1,"prl_edmuro") && s(0) && (p(1)||q_w(2,"pre_any sz_iili")) && Q(1,"suw_odedro") )
 { l[i]=omo1; R[1245]++; if(dbg){print "R1245"}; continue };
 if ( w(-3,"у") &&
      q(-2,"mest_ro") &&
      w(-1,"у") && s(-3,-1) )
 { l[i]=omo2; R[1246]++; if(dbg){print "R1246"}; continue };
 if ( qxs(-1,"того этого","же")||
      ww_(-1,"того этого") )
 { l[i]=omo1; R[1247]++; if(dbg){print "R1247"}; continue };
 #
 cst="меня себя тебя";
 if ( (w(1,cst)||q(1,"gl_mn gl_ed muk_edmuro")) && s(0) && Q(1,"suw_any") )
 { l[i]=omo2; R[1248]++; if(dbg){print "R1248"}; continue };
 if ( w(1,"не") &&
     (w(2,cst)||q(2,"gl_mn gl_ed muk_edmuro")) && s(0,1) && Q(2,"suw_any") )
 { l[i]=omo2; R[1249]++; if(dbg){print "R1249"}; continue };

 if ( w(1,"его") && s(0) && p(1) )
 { l[i]=omo2; R[1250]++; if(dbg){print "R1250"}; continue };

 cst="меня него себя тебя";
 if ( (w(-1,cst)||muk_edmuro(-1)) && s(-1) )
 { l[i]=omo2; R[1251]++; if(dbg){print "R1251"}; continue };
 if ( (w(-1,"его")||muk_edmuro(-1)) && (p(0)||q_w(1,"sz_iili pre_any")) && s(-1) )
 { l[i]=omo2; R[1252]++; if(dbg){print "R1252"}; continue };
 #
 cst="высокого низкого толстого тонкого умного хитрого храброго худого";
 if ( w(1,cst) &&
      q(2,"name_ro_sy isname") && s(0,1) )
 { l[i]=omo1; R[1253]++; if(dbg){print "R1253"}; continue };
 if ( q(1,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro mest_vi mest_ro") &&
      q(2,"name_ro_sy isname") && s(0,1) )
 { l[i]=omo2; R[1254]++; if(dbg){print "R1254"}; continue };
 if ( q(1,"name_ro_sy isname") && s(0) )
 { l[i]=omo2; R[1255]++; if(dbg){print "R1255"}; continue };
 if ( q(1,"suw_odedro") && s(0) && Q(1,"prl_edro") )
 { l[i]=omo2; R[1256]++; if(dbg){print "R1256"}; continue };
 if ( q(1,"prl_edmuro prl_edsrro") && z(1) && s(0) &&
      w(2,"самого") &&
      q(3,"prl_edmuro prl_edsrro") && s(2,3) )
 { l[i]=omo1; R[1257]++; if(dbg){print "R1257"}; continue };
 if ( q(1,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro") &&
sz_iili(2) &&
      q(3,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro") && s(0,2) )
 { l[i]=omo1; R[1258]++; if(dbg){print "R1258"}; continue };
 if ( q(-2,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro") &&
sz_iili(-1) &&
      q(1,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro") && s(-2,0) )
 { l[i]=omo1; R[1259]++; if(dbg){print "R1259"}; continue };
 if ( q(1,"prl_edmuro prl_edsrro prq_edmuro prq_edsrro mest_vi mest_ro") &&
      q(2,"suw_edmuro suw_edsrro pre_any prl_edmuro prl_edsrro") && s(0,1) && Q(2,"isname") )
 { l[i]=omo1; R[1260]++; if(dbg){print "R1260"}; continue };
 if ( q(1,"prl_edmuro prl_edsrro mest_vi mest_ro") && s(0) && (p(1)||q_w(2,"sz_iili pre_any")) && Q(1,"suw_odedro") )
 { l[i]=omo1; R[1261]++; if(dbg){print "R1261"}; continue };
 if ( q(1,"prq_edmuro prq_edsrro") && s(0) && (p(1)||q_w(2,"pre_any")) )
 { l[i]=omo2; R[1262]++; if(dbg){print "R1262"}; continue };
 #
 if ( mest_vi(1) && s(0) )
 { l[i]=omo2; R[1263]++; if(dbg){print "R1263"}; continue };
 if ( pre_ro(-2) && W(-2,"с") &&
     mest_ro(-1) && s(-2,-1) && !(q(1,"suw_ro") && s(0)) )
 { l[i]=omo2; R[1264]++; if(dbg){print "R1264"}; continue };
 if ( pre_ro(-1) &&
         (q_(1,swn_edmu_ro)||q_(1,swn_edsr_ro)||mest_ro(1)) && s(-1,0) )
 { l[i]=omo1; R[1265]++; if(dbg){print "R1265"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2274 !_#_! ==> samoe1_ samoe2_     самое  са́мое  самоё
xgrp="x2274";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qxs(-1,"то это","же")||
      ww_(-1,"то это") )
 { l[i]=omo1; R[1266]++; if(dbg){print "R1266"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer
###   x2275 !_#_! ==> samoy1_ samoy2_     самой  са́мой  само́й
xgrp="x2275";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
#cst="природе стуже сути форме";
#if ( w(-1,"по") &&
#      w(1,cst) && s(-1,0) )
#{ l[i]=omo2; R[1267]++; if(dbg){print "R1267"}; continue };
 cst="высоте глубине глубинке гуще середине середке чаще";
 if ( w(-1,"в") &&
      w(1,cst) && s(-1,0) )
 { l[i]=omo1; R[1268]++; if(dbg){print "R1268"}; continue };

 #
 cst="возле до у";
 if ( w(-1,cst) &&
      q(1,"suw_noedro suw_nomnro") && s(-1,0) )
 { l[i]=omo1; R[1269]++; if(dbg){print "R1269"}; continue };
 cst="в о по";
 if ( w(-1,cst) &&
      q(1,"suw_noedpr suw_nomnpr") && s(-1,0) )
 { l[i]=omo2; R[1270]++; if(dbg){print "R1270"}; continue };
 if ( w(-1,"перед") &&
      q(1,"suw_noedtv suw_nomntv") && s(-1,0) )
 { l[i]=omo1; R[1271]++; if(dbg){print "R1271"}; continue };

 if ( q(1,"prl_edzeda") && s(0) && (p(1)||q_w(2,"pre_any sz_iili")) && Q(1,"suw_odedda") )
 { l[i]=omo1; R[1272]++; if(dbg){print "R1272"}; continue };
 if ( w(-3,"у") &&
      q(-2,"mest_ro") &&
      w(-1,"у") && s(-3,-1) )
 { l[i]=omo2; R[1273]++; if(dbg){print "R1273"}; continue };
 if ( qxs(-1,"той этой","же")||
      ww_(-1,"той этой") )
 { l[i]=omo1; R[1274]++; if(dbg){print "R1274"}; continue };
 #
 cst="ей себе себя тебе";
 if ( (w(1,cst)||q(1,"gl_mn gl_ed muk_edzeda")) && s(0) && Q(1,"suw_any") )
 { l[i]=omo2; R[1275]++; if(dbg){print "R1275"}; continue };
 if ( w(1,"ее") && p(1) && s(0) )
 { l[i]=omo2; R[1276]++; if(dbg){print "R1276"}; continue };
 cst="ей меня мне нее себе себя тебе тебя";
 if ( (w(-1,cst)||muk_edzeda(-1)) && s(-1) )
 { l[i]=omo2; R[1277]++; if(dbg){print "R1277"}; continue };
 if ( (w(-1,"ее")||muk_edzeda(-1)) && (p(0)||q_w(1,"sz_iili pre_any")) && s(-1) )
 { l[i]=omo2; R[1278]++; if(dbg){print "R1278"}; continue };


 #
 if ( q(-2,"muk_edzeda muk_edzero muk_edzetv muk_edzepr") &&
      w(-1,"же") && s(-2,-1) )
 { l[i]=omo1; R[1279]++; if(dbg){print "R1279"}; continue };
 if ( muk_edzeda(-1) && s(-1) )
 { l[i]=omo1; R[1280]++; if(dbg){print "R1280"}; continue };

 cst="вашей его ее их нашей своей твоей";
 if ( w(-1,"по и") &&
      w(1,cst) &&
      q(2,"suw_edzeda suw_edzero suw_edzetv suw_edzepr") && s(-1,1) )
 { l[i]=omo2; R[1281]++; if(dbg){print "R1281"}; continue };
 #
 if ( q(1,"prl_edzeda prl_edzero prl_edzetv") && z(1) && s(0) &&
      w(2,"самой") &&
      q(3,"prl_edzeda prl_edzero prl_edzetv") && s(2,3) )
 { l[i]=omo1; R[1282]++; if(dbg){print "R1282"}; continue };
 if ( q(1,"prl_edzeda prl_edzero prl_edzetv qik_tv") &&
      q(2,"prl_edzeda prl_edzero prl_edzetv") &&
      q(3,"suw_edzeda suw_edzero suw_edzetv suw_edzepr pre_any") && s(0,2) )
 { l[i]=omo1; R[1283]++; if(dbg){print "R1283"}; continue };
 if ( q(1,"prl_edzeda prl_edzero prl_edzetv mest_da") &&
      q(2,"suw_edzeda suw_edzero suw_edzetv suw_edzepr pre_any") && s(0,1) )
 { l[i]=omo1; R[1284]++; if(dbg){print "R1284"}; continue };
 if ( q(1,"prl_edzeda prl_edzero prl_edzetv") &&
mest_3e(2) &&
      q(3,"suw_edzeda suw_edzero suw_edzetv suw_edzepr pre_any") && s(0,2) )
 { l[i]=omo1; R[1285]++; if(dbg){print "R1285"}; continue };
 if ( q(1,"prl_edzeda prl_edzero prl_edzetv") &&
      q(2,"gl_need gl_nemn gl_vzmn") &&
      q(3,"suw_im") && s(0,2) )
 { l[i]=omo1; R[1286]++; if(dbg){print "R1286"}; continue };
 #
 if ( q(1,"prl_edzeda") &&
sz_iili(2) &&
      w(3,"самой") &&
      q(4,"prl_edzeda") && s(0,3) )
 { l[i]=omo1; R[1287]++; if(dbg){print "R1287"}; continue };
 #
 if ( q(1,"name_pr_sy isname") && s(0) )
 { l[i]=omo2; R[1288]++; if(dbg){print "R1288"}; continue };
 if ( q(-1,"pre_da preph_da") &&
     q_(1,swn_edze_pr) && s(-1,0) )
 { l[i]=omo1; R[1289]++; if(dbg){print "R1289"}; continue };

 if ( q(1,"prl_edzetv prq_edzetv") && s(0) && p(1) )
 { l[i]=omo1; R[1290]++; if(dbg){print "R1290"}; continue };
 if ( q(1,"suw_tv") &&
      q(2,"gl_pein gl_peed gl_pemn deep_pe prq_pe") && s(0,1) )
 { l[i]=omo2; R[1291]++; if(dbg){print "R1291"}; continue };
 if ( q(1,"suw_tv") &&
     bw(2,"быть") &&
      q(3,"prq_pe") && s(0,2) )
 { l[i]=omo2; R[1292]++; if(dbg){print "R1292"}; continue };


 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2276 !_#_! ==> samom1_ samom2_     самом  са́мом  само́м
xgrp="x2276";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 # индивидуальные слова
 cst = "верху виду деле зените конце краю начале низу носу разгаре расцвете сердце центре углу"
 if ( pre_pr(-1) &&
           w(1,cst) && s(-1,0) )
 { l[i]=omo1; R[1293]++; if(dbg){print "R1293"}; continue };
 if ( pre_pr(-1) &&
           q(1,"prl_edmupr prq_edmupr") &&
           w(2,cst) && s(-1,1) )
 { l[i]=omo1; R[1294]++; if(dbg){print "R1294"}; continue };
 if ( pre_pr(-1) && s(-1) &&
         ((w(1,"ли же") && s(0,1))||(w(1,"то") && se(0,"-") && s(1))) &&
           w(2,cst) )
 { l[i]=omo1; R[1295]++; if(dbg){print "R1295"}; continue };

 cst = "сигнале действии городе принципе путешествии селении селе смысле человечестве народе корабле шаттле"
 if ( pre_pr(-1) &&
           w(1,cst) && s(0) )
 { l[i]=omo2; R[1296]++; if(dbg){print "R1296"}; continue };

 if ( q(1,"prl_edmupr") && s(0) && (p(1)||q_w(2,"pre_any sz_iili")) && Q(1,"suw_odedpr") )
 { l[i]=omo1; R[1297]++; if(dbg){print "R1297"}; continue };
 cst="мне нем себе тебе";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1298]++; if(dbg){print "R1298"}; continue };
 if ( (w(1,cst)||muk_edmupr(1)) && s(0) )
 { l[i]=omo2; R[1299]++; if(dbg){print "R1299"}; continue };

 if ( q(1,"name_pr_sy isname") && s(0) )
 { l[i]=omo2; R[1300]++; if(dbg){print "R1300"}; continue };
 if ( muk_edmupr(-1) && s(-1) )
 { l[i]=omo1; R[1301]++; if(dbg){print "R1301"}; continue };
 #
 if ( q(1,"prl_edmupr prl_edsrpr") && z(1) && s(0) &&
      w(2,"самом") &&
      q(3,"prl_edmupr prl_edsrpr") && s(2,3) )
 { l[i]=omo1; R[1302]++; if(dbg){print "R1302"}; continue };
 if ( q(1,"prl_edmupr prl_edsrpr") &&
sz_iili(2) &&
      w(3,"самом") &&
      q(4,"prl_edmupr prl_edsrpr") && s(0,3) )
 { l[i]=omo1; R[1303]++; if(dbg){print "R1303"}; continue };
 if ( q(1,"prl_edmupr prl_edsrpr mest_vi mest_pr") &&
      q(2,"suw_edmupr suw_edsrpr pre_any") && s(0,1) )
 { l[i]=omo1; R[1304]++; if(dbg){print "R1304"}; continue };
 if ( q(1,"prl_edmupr prl_edsrpr mest_vi mest_pr") &&
mest_3e(2) &&
      q(3,"suw_edmupr suw_edsrpr pre_any") && s(0,2) )
 { l[i]=omo1; R[1305]++; if(dbg){print "R1305"}; continue };
 #
 if ( pre_pr(-1) &&
         (q_(1,swn_edmu_pr)||q_(1,swn_edsr_pr)) && s(-1,0) )
 { l[i]=omo1; R[1306]++; if(dbg){print "R1306"}; continue };
 #
 if ( muk_edmupr(-2) &&
               w(-1,"же") && s(-2,-1) )
 { l[i]=omo1; R[1307]++; if(dbg){print "R1307"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2277 !_#_! ==> samomu1_ samomu2_   самому  са́мому  самому́
xgrp="x2277";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="обществу";
 if ( q(1,"mest_3e") &&
      w(2,cst) && s(0) )
 { l[i]=omo2; R[1308]++; if(dbg){print "R1308"}; continue };
 if ( w(1,cst) && s(0) )
 { l[i]=omo2; R[1309]++; if(dbg){print "R1309"}; continue };
 #
 if ( w(-1,"к") &&
      q(1,"suw_noedmuda suw_noedsrda") && s(-1,0) )
 { l[i]=omo1; R[1310]++; if(dbg){print "R1310"}; continue };
 #
 if ( q(1,"prl_edmuda") && s(0) && (p(1)||q_w(2,"pre_any sz_iili")) && Q(1,"suw_odedda") )
 { l[i]=omo1; R[1311]++; if(dbg){print "R1311"}; continue };

 cst="ему мне себе тебе";
 if ( (w(1,cst)||muk_edmuda(1)) && s(0) )
 { l[i]=omo2; R[1312]++; if(dbg){print "R1312"}; continue };
 if ( (w(-1,cst)||muk_edmuda(-1)) &&
suw_edda(1) && s(-1,0) )
 { l[i]=omo1; R[1313]++; if(dbg){print "R1313"}; continue };
 if ( (w(-1,cst)||muk_edmuda(-1)) && s(-1) )
 { l[i]=omo2; R[1314]++; if(dbg){print "R1314"}; continue };

 #
 if ( q(1,"prl_edmuda prl_edsrda") && z(1) && s(0) &&
      w(2,"самому") &&
      q(3,"prl_edmuda prl_edsrda") && s(2,3) )
 { l[i]=omo1; R[1315]++; if(dbg){print "R1315"}; continue };
 if ( q(1,"prl_edmuda prl_edsrda mest_da") &&
      q(2,"prl_edmuda prl_edsrda mest_da") &&
      q(3,"suw_edmuda suw_edsrda") && s(0,2) )
 { l[i]=omo1; R[1316]++; if(dbg){print "R1316"}; continue };
 if ( q(1,"prl_edmuda prl_edsrda mest_da") &&
      q(2,"suw_edmuda suw_edsrda pre_any") && s(0,1) )
 { l[i]=omo1; R[1317]++; if(dbg){print "R1317"}; continue };
 #
 if ( q(-1,"pre_da preph_da") &&
    (q_(1,swn_edmu_da)||q_(1,swn_edsr_da)) && s(-1,0) )
 { l[i]=omo1; R[1318]++; if(dbg){print "R1318"}; continue };
 #
 if ( muk_edmuda(-2) &&
               w(-1,"же") && s(-2,-1) )
 { l[i]=omo1; R[1319]++; if(dbg){print "R1319"}; continue };
 if ( q(1,"suw_odedmuda suw_odedsrda suw_odmnda name_da_sy isname") && s(0) && Q(1,"prl_da") )
 { l[i]=omo2; R[1320]++; if(dbg){print "R1320"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2278 !_#_! ==> sw_1es_rz_2ez_i_   sw_mn_iv_  вина  вина́  ви́на
xgrp="x2278";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_z_f() )
 { l[i]=omo1; R[1321]++; if(dbg){print "R1321", "sw_es_z_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[1322]++; if(dbg){print "R1322", "sw_ez_i_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1323]++; if(dbg){print "R1323", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1324]++; if(dbg){print "R1324", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1325]++; if(dbg){print "R1325", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2279 !_#_! ==> m2_1nar_step_2qin_iv_  pl_kr_es_
xgrp="x2279";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="мал мало мальски маля помалу";
 if ( sc(0,"-") && w(1,cst) )
 { l[i]=omo1; R[1326]++; if(dbg){print "R1326"}; continue };
 #
 if ( qxs(-1,"как и","будто") )
 { l[i]=omo1; R[1327]++; if(dbg){print "R1327"}; continue };
 if ( q(-1,"mest_da suw_da") )
 { l[i]=omo1; R[1328]++; if(dbg){print "R1328"}; continue };
 #
 cst="где как какой кого кто ли того что";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1329]++; if(dbg){print "R1329"}; continue };
 #
 cst="какой один";
 if ( bw(1,cst) && s(0) )
 { l[i]=omo1; R[1330]++; if(dbg){print "R1330"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2280 !_#_! ==> m2_1sw_ez_i_2deep_na_	sw_em_r_  душа  душа́  ду́ша
xgrp="x2280";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_i_f() )
 { l[i]=omo1; R[1331]++; if(dbg){print "R1331", "sw_ez_i_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1332]++; if(dbg){print "R1332", "sw_em_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2281 !_#_! ==> gl_paedze_    sw_ez_i_  жила  жила́  жи́ла
xgrp="x2281";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( w(1,"была") && sc(0,"-") )
 { l[i]=omo1; R[1333]++; if(dbg){print "R1333"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1334]++; if(dbg){print "R1334", "sw_ez_i_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[1335]++; if(dbg){print "R1335", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2282 !_#_! ==> m2_1nar_vopr_2souz_	prl_ems_vr_  отчего  отчего́  о́тчего
xgrp="x2282";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( !(suw_edro(1) && s(0)) )
 { l[i]=omo1; R[1336]++; if(dbg){print "R1336"}; continue };
 #
 if ( w(1,"дома") && s(0) )
 { l[i]=omo2; R[1337]++; if(dbg){print "R1337"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2283 !_#_! ==> m2_1sw_em_r_2nar_mest_   sw_mn_iv_  дома  до́ма  дома́
xgrp="x2283";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="быть находиться оставаться остаться пребывать проводить сидеть спать";
 if ( bw(-1,cst) &&  s(-1) )
 { l[i]=omo1; R[1338]++; if(dbg){print "R1338"}; continue };

 if ( q(-2,"mest_vi mest_3e suw_vi") &&
      q(-1,"gl_pemn gl_pnmn") &&
      q(1,"mest_edvi suw_vi") && s(-2,0) )
 { l[i]=omo1; R[1339]++; if(dbg){print "R1339"}; continue };
 if ( q(1,"mest_vi mest_3e suw_vi") &&
      q(2,"mod_mn") &&
      q(3,"gl_in") && s(0,2) )
 { l[i]=omo1; R[1340]++; if(dbg){print "R1340"}; continue };
 if ( q(1,"mest_vi mest_3e suw_vi") &&
      q(2,"nar_vrem nar_spos") &&
      q(3,"mod_mn") &&
      q(4,"gl_in") && s(0,3) )
 { l[i]=omo1; R[1341]++; if(dbg){print "R1341"}; continue };

 if ( q(-1,"gl_in gl_ed gl_mn gl_po gl_vzed gl_vzmn deep") && bam(-1,"_gl_static _gl_talk") && s(-1) )
 { l[i]=omo1; R[1342]++; if(dbg){print "R1342"}; continue };
 if ( q(-1,"gl_nein gl_need gl_nemn gl_ponemn gl_poneed gl_povzmn gl_vzmn deep_ne") && s(-1) )
 { l[i]=omo1; R[1343]++; if(dbg){print "R1343"}; continue };
 if ( q(-2,"gl_nein gl_need gl_nemn gl_ponemn gl_poneed gl_povzmn gl_vzmn deep_ne") &&
      w(-1,"как") && s(-2,-1) )
 { l[i]=omo1; R[1344]++; if(dbg){print "R1344"}; continue };
 if ( q(-2,"mest_mnim suw_mnim") && Q(-2,"gl_mn") &&
      q(-1,"prl_krmn") && s(-2,-1) )
 { l[i]=omo1;; R[1345]++; if(dbg){print "R1345"}; continue };
 if ( q(1,"mest_im suw_im") &&
      q(2,"gl_peed gl_pemn gl_popeed gl_popemn") &&
      q(3,"prl_da mest_da") &&
      q(4,"prl_vi") &&
      q(5,"suw_vi name_vi_sy isname") && s(0,4) && p(-1) )
 { l[i]=omo1; R[1346]++; if(dbg){print "R1346"}; continue };
 if ( q(1,"mest_im suw_im") &&
      q(2,"gl_peed gl_pemn gl_popeed gl_popemn") &&
      q(3,"prl_da mest_da") &&
      q(4,"suw_vi name_vi_sy isname") && s(0,3) && p(-1) )
 { l[i]=omo1; R[1347]++; if(dbg){print "R1347"}; continue };
 if ( q(1,"mest_im suw_im") &&
      q(2,"gl_peed gl_pemn gl_popeed gl_popemn") &&
      q(3,"prl_vi") &&
      q(4,"suw_vi name_vi_sy isname") && s(0,3) && p(-1) )
 { l[i]=omo1; R[1348]++; if(dbg){print "R1348"}; continue };
 if ( q(1,"mest_im suw_im") &&
      q(2,"gl_peed gl_pemn gl_popeed gl_popemn") &&
      q(3,"suw_vi name_vi_sy isname") && s(0,2) && p(-1) )
 { l[i]=omo1; R[1349]++; if(dbg){print "R1349"}; continue };

 #
 if ( q(-2,"mest_im suw_im name_im_sy isname") && Q(-2,"prl_im") &&
      w(-1,"не же ведь") && s(-2,-1))
 { l[i]=omo1; R[1350]++; if(dbg){print "R1350"}; continue };
 #
 if ( prq_mnim(-3) &&
        pre_ro(-2) &&
             q(-1,"suw_ro mest_ro") && s(-3,-1))
 { l[i]=omo2; R[1351]++; if(dbg){print "R1351"}; continue };
 if ( pre_ro(-2) &&
           q(-1,"suw_ro mest_ro") && s(-2,-1))
 { l[i]=omo1; R[1352]++; if(dbg){print "R1352"}; continue };
 if ( w(1,"у") &&
      q(2,"suw_ro mest_ro") && s(0,1))
 { l[i]=omo1; R[1353]++; if(dbg){print "R1353"}; continue };
 #
 cst="вы кто мы он она оно ты я";
 if ( ( w(-1,cst)||mest_edim(-1)||q_(-1,mst_ed_mu_im)) && s(-1))
 { l[i]=omo1; R[1354]++; if(dbg){print "R1354"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1355]++; if(dbg){print "R1355", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1356]++; if(dbg){print "R1356", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1357]++; if(dbg){print "R1357", "sw_mn_v_f"}; continue };

 if ( w(-1,"как") && s(-1) && p(0) )
 { l[i]=omo1; R[1358]++; if(dbg){print "R1358"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2284 !_#_! ==>   gl_ed1e_     pl_ez_v_  целую  целу́ю  це́лую
xgrp="x2284";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="армию борозду бутылку вечность галактику горку гору группу деревню историю квартиру колонку колонну корзину кружку кучу неделю ночь пачку планету пригоршню \
      расу свинью секунду стену страницу страну сумку тонну цивилизацию чашку эскадрилью";
 if ( w(1,cst) && s(0))
 { l[i]=omo2; R[1359]++; if(dbg){print "R1359"}; continue };
 #
 if ( pl_ez_v_f() )
 { l[i]=omo2; R[1360]++; if(dbg){print "R1360", "pl_ez_v_f"}; continue };
 #
 if ( suw_mnvi(1) && s(0) )
 { l[i]=omo1; R[1361]++; if(dbg){print "R1361"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[1362]++; if(dbg){print "R1362", "gl_ed1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2285 !_#_! ==> bolshaya1_ bolshaya2_   большая  бо́льшая  больша́я
xgrp="x2285";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда много намного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1363]++; if(dbg){print "R1363"}; continue };
 cst="половина часть";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1364]++; if(dbg){print "R1364"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1365]++; if(dbg){print "R1365"}; continue };
 #
 cst="весьма довольно достаточно очень самая слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1366]++; if(dbg){print "R1366"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2286 !_#_! ==> bolshie1_  bolshie2_   большие  бо́льшие  больши́е
xgrp="x2286";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда много намного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1367]++; if(dbg){print "R1367"}; continue };
 cst="половины части";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1368]++; if(dbg){print "R1368"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1369]++; if(dbg){print "R1369"}; continue };
 #
 cst="весьма довольно достаточно очень самые слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1370]++; if(dbg){print "R1370"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2287 !_#_! ==> bolshim1_  bolshim2_   большим  бо́льшим  больши́м
xgrp="x2287";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда много намного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1371]++; if(dbg){print "R1371"}; continue };
 cst="половинам частям";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1372]++; if(dbg){print "R1372"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1373]++; if(dbg){print "R1373"}; continue };
 if ( pre_tv(-2) &&
           w(-1,"чем тем еще") &&
           q(1,"suw_tv") && s(-2,0) )
 { l[i]=omo1; R[1374]++; if(dbg){print "R1374"}; continue };
 #
 cst="весьма довольно достаточно очень самым слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1375]++; if(dbg){print "R1375"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2288 !_#_! ==> bolshimi1_  bolshimi2_   большими  бо́льшими  больши́ми
xgrp="x2288";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда много намного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1376]++; if(dbg){print "R1376"}; continue };
 cst="половинами частями";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1377]++; if(dbg){print "R1377"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1378]++; if(dbg){print "R1378"}; continue };
 #
 cst="весьма довольно достаточно очень самыми слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1379]++; if(dbg){print "R1379"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2289 !_#_! ==> bolshih1_  bolshih2_   больших  бо́льших  больши́х
xgrp="x2289";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда намного";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1380]++; if(dbg){print "R1380"}; continue };
 cst="половин частей";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1381]++; if(dbg){print "R1381"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1382]++; if(dbg){print "R1382"}; continue };
 #
 cst="весьма довольно достаточно много несколько очень самых слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1383]++; if(dbg){print "R1383"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2290 !_#_! ==> bolshuu1_  bolshuu2_   большую  бо́льшую  большу́ю
xgrp="x2290";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="значительно куда много намного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1384]++; if(dbg){print "R1384"}; continue };
 cst="половину часть";
 if ( wy(1,"его ее их") && w(1+wyn,cst) && s(0) )
 { l[i]=omo1; R[1385]++; if(dbg){print "R1385"}; continue };
 if ( z(0) && w(1,"чем") )
 { l[i]=omo1; R[1386]++; if(dbg){print "R1386"}; continue };
 #
 cst="весьма довольно достаточно очень самую слишком чересчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1387]++; if(dbg){print "R1387"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2291 !_#_! ==> sw_ez_vr_      sw_mn_iv_  методы  мето́ды  ме́тоды
xgrp="x2291";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1388]++; if(dbg){print "R1388", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1389]++; if(dbg){print "R1389", "sw_mn_v_f"}; continue };
 prex=1
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1390]++; if(dbg){print "R1390", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2292 !_#_! ==> gl_1poed_2inf_  sw_1ez_dpr_2mn_iv_  < извести повести >
xgrp="x2292";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="извести") {
   if ( q(1,"mest_vi suw_vi") && s(0) )
   { l[i]=omo1; R[1391]++; if(dbg){print "R1391"}; continue };
 };
 if(iwrd=="повести") {
   if ( q(1,"gl_in mest_vi suw_vi") && s(0) )
   { l[i]=omo1; R[1392]++; if(dbg){print "R1392"}; continue };
 };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[1393]++; if(dbg){print "R1393", "gl_poed_f"}; continue };
 #
#if ( gl_in_f() )
#{ l[i]=omo1; R[1394]++; if(dbg){print "R1394"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1395]++; if(dbg){print "R1395", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1396]++; if(dbg){print "R1396", "sw_ez_p_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[1397]++; if(dbg){print "R1397", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1398]++; if(dbg){print "R1398", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1399]++; if(dbg){print "R1399", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2293 !_#_! ==> sw_em_rz_		sw_mn_iv_  хлеба  хле́ба  хлеба́
xgrp="x2293";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pre_ro(-1) && Q(-1,"pre_im pre_vi") && s(-1) )
 { l[i]=omo1; R[1400]++; if(dbg){print "R1400"}; continue };
 if ( q(-1,"pre_im pre_vi") && Q(-1,"pre_ro") && s(-1) )
 { l[i]=omo2; R[1401]++; if(dbg){print "R1401"}; continue };
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[1402]++; if(dbg){print "R1402", "sw_em_z_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1403]++; if(dbg){print "R1403", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1404]++; if(dbg){print "R1404", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1405]++; if(dbg){print "R1405", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2294 !_#_! ==> sw_es_rz_      sw_mn_iv_
xgrp="x2294";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_z_f() )
 { l[i]=omo1; R[1406]++; if(dbg){print "R1406", "sw_es_z_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1407]++; if(dbg){print "R1407", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1408]++; if(dbg){print "R1408", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1409]++; if(dbg){print "R1409", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2295 !_#_! ==> sw_es_r_		sw_ez_i_ уха  у́ха  уха́
xgrp="x2295";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( bw(-1,"мочка") && s(-1) )
 { l[i]=omo1; R[1410]++; if(dbg){print "R1410", "sw_es_r_f"}; continue };
 #
 if ( sw_es_r_f() )
 { l[i]=omo1; R[1411]++; if(dbg){print "R1411", "sw_es_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1412]++; if(dbg){print "R1412", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2296 !_#_! ==> sw_ez_rz_      sw_mn_iv_
xgrp="x2296";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="колы") {
   cst="кока нюка перри";
   if ( w(-1,cst) && se(-1,"-") )
   { l[i]=omo1; R[1413]++; if(dbg){print "R1413"}; continue };
 };
 if(iwrd=="земли") {
   if ( w(-1,"матери") && se(-1,"-") )
   { l[i]=omo1; R[1414]++; if(dbg){print "R1414"}; continue };
 };
 #
 if ( sw_ez_z_f() )
 { l[i]=omo1; R[1415]++; if(dbg){print "R1415", "sw_ez_z_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1416]++; if(dbg){print "R1416", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1417]++; if(dbg){print "R1417", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1418]++; if(dbg){print "R1418", "sw_mn_v_f"}; continue };

 if ( wc(-1,"[ео]й$ [ео]йся$") && s(-1) )
 { l[i]=omo1; R[1419]++; if(dbg){print "R1419"}; continue };
 if ( wc(-1,"[иы]е$ [иы]еся$") && s(-1) )
 { l[i]=omo2; R[1420]++; if(dbg){print "R1420"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2297 !_#_! ==> sw_em_i_		m3_sw_1em_iv_2mn_r_3deep_   пристав  при́став  приста́в
xgrp="x2297";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 # 3 сущ. им.п.: +при́став (од.), -приста́в (неод.), -приста́ва (неод.)
 #
 if ( w(1,"к как") && s(0) )
 { l[i]=omo2; R[1421]++; if(dbg){print "R1421"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo1; R[1422]++; if(dbg){print "R1422", "sw_em_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2298 !_#_! ==> gl_paedmu_	sw_mn_r_
xgrp="x2298";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[1423]++; if(dbg){print "R1423"}; continue };
   if ( w(1,"было") &&
       (q(2,"gl_in isname")||w(2,"он")) && s(0,1) )
   { l[i]=omo1; R[1424]++; if(dbg){print "R1424"}; continue };
   if ( sc(-1,"—") &&
   (isname(1)||suw_edmuim(1)||w(1,"он")) && s(0) )
   { l[i]=omo1; R[1425]++; if(dbg){print "R1425"}; continue };
   if ( q(1,"pre_vi preph_vi") &&
        q(2,"suw_vi prl_vi prq_vi mest_vi") && s(0,1) )
   { l[i]=omo1; R[1426]++; if(dbg){print "R1426"}; continue };
   if ( q(1,"pre_ro preph_ro") &&
        q(2,"suw_ro prl_ro prq_ro mest_ro") && s(0,1) )
   { l[i]=omo1; R[1427]++; if(dbg){print "R1427"}; continue };
   if ( q(1,"pre_tv preph_tv") &&
        q(2,"suw_tv prl_tv prq_tv mest_tv") && s(0,1) )
   { l[i]=omo1; R[1428]++; if(dbg){print "R1428"}; continue };
   if ( pre_pr(1) &&
             q(2,"suw_pr prl_pr prq_pr mest_pr") && s(0,1) )
   { l[i]=omo1; R[1429]++; if(dbg){print "R1429"}; continue };
   if ( gl_in(1) && s(0) )
   { l[i]=omo1; R[1430]++; if(dbg){print "R1430"}; continue };

 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[1431]++; if(dbg){print "R1431", "gl_paedmu_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1432]++; if(dbg){print "R1432", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2299 !_#_! ==> sw_em_rz_		sw_ez_i_   лука  лу́ка  лука́
xgrp="x2299";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_z_f() )
 { l[i]=omo1; R[1433]++; if(dbg){print "R1433", "sw_em_z_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1434]++; if(dbg){print "R1434", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1435]++; if(dbg){print "R1435", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2300 !_#_! ==> gl_poed_      sw_1ez_rz_2mn_iv_
xgrp="x2300";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="пищи") {
   cst="запас приём производство";
   if ( bw(-1,cst) && s(-1) )
   { l[i]=omo2; R[1436]++; if(dbg){print "R1436"}; continue };
 };
 if ( q(-2,"pre_any preph_any") &&
      q(-1,"suw_any") && s(-2,-1) )
 { l[i]=omo2; R[1437]++; if(dbg){print "R1437"}; continue };
 #
 if ( gl_poed_f() )
 { l[i]=omo1; R[1438]++; if(dbg){print "R1438", "gl_poed_f"}; continue };
 #
 if ( sw_ez_z_f() )
 { l[i]=omo2; R[1439]++; if(dbg){print "R1439", "sw_ez_z_f"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo2; R[1440]++; if(dbg){print "R1440", "sw_ez_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1441]++; if(dbg){print "R1441", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo2; R[1442]++; if(dbg){print "R1442", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2301 !_#_! ==> gl_poed_   sw_1ez_rz_2mn_iv_  пошло  пошло́  по́шло
xgrp="x2301";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="быть выглядеть звучать смотреться";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[1443]++; if(dbg){print "R1443", "gl_paedsr_f"}; continue };
 cst="достаточнош немного слишком черезчур";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1444]++; if(dbg){print "R1444", "gl_paedsr_f"}; continue };
 if ( q(-2,"prl_kred_sr") &&
sz_iili(-1) && s(-2,-1) )
 { l[i]=omo2; R[1445]++; if(dbg){print "R1445", "gl_paedsr_f"}; continue };

 #
 if ( qxs(-1,"если","на","то")||
      qxs(-1,"если","бы","что-то")||
      qxs(-1,"если","уж","на","то") )
 { l[i]=omo1; R[1446]++; if(dbg){print "R1446"}; continue };
 if ( qxs(1,"не","так")||
      qxs(1,"на","перекосяк") )
 { l[i]=omo1; R[1447]++; if(dbg){print "R1447"}; continue };
 if ( q(1,"pre_vi preph_vi") &&
      q(2,"suw_vi") && s(0,1) )
 { l[i]=omo1; R[1448]++; if(dbg){print "R1448"}; continue };

 if ( gl_paedsr_f() )
 { l[i]=omo1; R[1449]++; if(dbg){print "R1449", "gl_paedsr_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2302 !_#_! ==> sw_em_p_		sw_ez_dp_ одуш-неодуш.
xgrp="x2302";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 #
 if ( w(-1,"на") && s(-1) )
 { l[i]=omo2; R[1450]++; if(dbg){print "R1450", "sw_ez_d_f"}; continue };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1451]++; if(dbg){print "R1451", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1452]++; if(dbg){print "R1452", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1453]++; if(dbg){print "R1453", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2303 !_#_! ==> sw_em_p_		sw_ez_dp_ неодуш.
xgrp="x2303";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 if(iwrd=="кружке") {
   cst="вина воды жидкости молока пива сока эля";
   if ( w(1,cst) && s(0) )
   { l[i]=omo2; R[1454]++; if(dbg){print "R1454"}; continue };
 };
 if(iwrd=="полке") {
   if ( w(-1,"на") && s(-1) )
   { l[i]=omo2; R[1455]++; if(dbg){print "R1455"}; continue };
 };
 if(iwrd=="жаре") {
   if ( w(-1,"на по") && s(-1) )
   { l[i]=omo2; R[1456]++; if(dbg){print "R1456"}; continue };
 };
 if(iwrd=="носке") {
   if ( w(-1,"в на") && s(-1) )
   { l[i]=omo1; R[1457]++; if(dbg){print "R1457"}; continue };
 };
 if(iwrd=="спине") {
   prex=0
   if ( sw_em_p_f() )
   { l[i]=omo2; R[1458]++; if(dbg){print "R1458", "sw_em_p_f"}; continue };
   prex=1
 };
 #
 if ( sw_em_p_f() )
 { l[i]=omo1; R[1459]++; if(dbg){print "R1459", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo2; R[1460]++; if(dbg){print "R1460", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1461]++; if(dbg){print "R1461", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2304 !_#_! ==> sw_em_d_		sw_ez_v_
xgrp="x2304";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[1462]++; if(dbg){print "R1462", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1463]++; if(dbg){print "R1463", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2305 !_#_! ==> sw_em_d_		sw_ez_v_
xgrp="x2305";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[1464]++; if(dbg){print "R1464", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo2; R[1465]++; if(dbg){print "R1465", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2306 !_#_! ==> sw_em_r_		sw_ez_i_
xgrp="x2306";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1466]++; if(dbg){print "R1466", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1467]++; if(dbg){print "R1467", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2307 !_#_! ==> pl_ems_p_		sw_em_t_   другом  друго́м  дру́гом
xgrp="x2307";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 cst="быть стать являться";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo2; R[1468]++; if(dbg){print "R1468"}; continue };
 if ( bw(-2,cst) &&
       q(-1,"mest_3e") && s(-1) )
 { l[i]=omo2; R[1469]++; if(dbg){print "R1469"}; continue };

 #
 if ( w(-1,"друг") && s(-1) )
 { l[i]=omo2; R[1470]++; if(dbg){print "R1470", "sw_em_t_f"}; continue };
 if ( q(-2,"suw_tv") &&
sz_iili(-1) && s(-2,-1) )
 { l[i]=omo2; R[1471]++; if(dbg){print "R1471", "sw_em_t_f"}; continue };
 #
 if ( sw_em_p_f()||sw_es_p_f()||pl_em_p_f()||pl_es_p_f() )
 { l[i]=omo1; R[1472]++; if(dbg){print "R1472", "sw_em_p_f||sw_es_p_f||pl_em_p_f||pl_es_p_f"}; continue };
 #
 if ( sw_em_t_f() )
 { l[i]=omo2; R[1473]++; if(dbg){print "R1473", "sw_em_t_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2308 !_#_! ==> m3_nar_1srav_2vrem_3pre_ro_  pl_es_iv_  позднее  поздне́е  по́зднее
xgrp="x2308";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[1474]++; if(dbg){print "R1474", "pl_srav_f"}; continue };
 #
 cst="значительно куда лишь много намного немного несколько";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1475]++; if(dbg){print "R1475"}; continue };
 if ( nar_vrem_f() )
 { l[i]=omo1; R[1476]++; if(dbg){print "R1476", "nar_vrem_f"}; continue };
 #
 if ( pl_es_i_f() )
 { l[i]=omo2; R[1477]++; if(dbg){print "R1477", "pl_es_i_f"}; continue };
 #
 if ( pl_es_v_f() )
 { l[i]=omo2; R[1478]++; if(dbg){print "R1478", "pl_es_v_f"}; continue };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2309 !_#_! ==> m2_1sw_em_d_2gl_ed1e_  sw_em_l_  берегу  берегу́  бе́регу
xgrp="x2309";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_l_f() )
 { l[i]=omo2; R[1479]++; if(dbg){print "R1479", "sw_em_l_f"}; continue };
 #
 if ( sw_em_d_f() )
 { l[i]=omo1; R[1480]++; if(dbg){print "R1480", "sw_em_d_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[1481]++; if(dbg){print "R1481", "gl_ed1e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2310 !_#_! ==> sw_emz_dp_	sw_ez_dp_  буре  бу́ре  буре́
xgrp="x2310";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 prex=1
 #
 if ( sw_ez_d_f() )
 { l[i]=omo1; R[1482]++; if(dbg){print "R1482", "sw_ez_d_f"}; continue };
 #
 if ( sw_em_p_f() )           ##_footer
 { l[i]=omo1; R[1483]++; if(dbg){print "R1483", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo2; R[1484]++; if(dbg){print "R1484", "sw_ez_p_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2311 !_#_! ==> nar_spos_	 pl_ems_p_  добром  добро́м  до́бром
xgrp="x2311";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"прошу") && s(-1) )
 { l[i]=omo1; R[1485]++; if(dbg){print "R1485"}; continue };
 #
 if ( pl_em_p_f() )
 { l[i]=omo2; R[1486]++; if(dbg){print "R1486", "sw_ez_d_f"}; continue };
 #
 if ( pl_es_p_f() )
 { l[i]=omo2; R[1487]++; if(dbg){print "R1487", "sw_em_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2312 !_#_! ==> pl_ez_dprt_	pl_srav_  горячей  горя́чей  горяче́й
xgrp="x2312";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( pl_ez_d_f()||pl_ez_p_f()||pl_ez_r_f()||pl_ez_t_f() )
 { l[i]=omo1; R[1488]++; if(dbg){print "R1488", "sw_ez_d_f"}; continue };
 #
 if ( pl_srav_f() )
 { l[i]=omo2; R[1489]++; if(dbg){print "R1489", "sw_em_p_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2313 !_#_! ==> gl_paedmu_	sw_mn_r_
xgrp="x2313";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"prl_ro") &&
      q(2,"suw_ro") && s(0) )
 { l[i]=omo2; R[1490]++; if(dbg){print "R1490"}; continue };
 if ( q(1,"suw_ro") && s(0) )
 { l[i]=omo2; R[1491]++; if(dbg){print "R1491"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1492]++; if(dbg){print "R1492", "sw_mn_r_f"}; continue };
 #
 if ( gl_paedmu_f() )
 { l[i]=omo1; R[1493]++; if(dbg){print "R1493", "gl_paedmu_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2314 !_#_! ==> deep_na_     pl_ez_i_  такая  та́кая  така́я
xgrp="x2314";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"suw_edzeim prl_edzeim") && s(0) )
 { l[i]=omo2; R[1494]++; if(dbg){print "R1494"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2315 !_#_! ==> word_hyphdef_  deep_na_  какая  кака́я  ка́кая
xgrp="x2315";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
#if ( sL(0,"-") && ismark(1,"YHYF") && w(1,"то") )
#{ l[i]=omo1; l[i+1]=gensub(/^(.+)$/,"\xcc\xa0\\1\xcc\xa0",1,l[i+1]); R[1495]++; if(dbg){print "R1495"}; continue };
 if ( sL(0,"-") )
 { l[i]=omo1; R[1496]++; if(dbg){print "R1496"}; continue };
 #
 if ( pl_ez_i_f() )
 { l[i]=omo1; R[1497]++; if(dbg){print "R1497", "pl_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                           ##_footer

###   x2316 !_#_! ==> m2_1nar_kaq_2pl_kr_es_  sw_es_iv_  далеко  далеко́  далёко
xgrp="x2316";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 cst="быть стать являться";
 if ( bw(-1,cst) && s(-1) )
 { l[i]=omo1; R[1498]++; if(dbg){print "R1498"}; continue };
 if ( q(-1,"nar_step") && s(-1) )
 { l[i]=omo1; R[1499]++; if(dbg){print "R1499"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                           ##_footer

###   x2317 !_#_! ==> m2_1sw_em_r_2pl_kr_ez_		sw_ez_i_  пола  по́ла  пола́
xgrp="x2317";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1500]++; if(dbg){print "R1500", "sw_em_r_f"}; continue };
 #
 if ( pl_kr_ez_f() )
 { l[i]=omo1; R[1501]++; if(dbg){print "R1501", "pl_kr_ez_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1502]++; if(dbg){print "R1502", "sw_ez_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2318 !_#_! ==> m2_1sw_ez_r_2pl_kr_mn_		sw_mn_iv_  полы  по́лы  полы́
xgrp="x2318";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"из-под") && s(-1) )
 { l[i]=omo2; R[1503]++; if(dbg){print "R1503"}; continue };
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1504]++; if(dbg){print "R1504", "sw_ez_r_f"}; continue };
 #
 if ( pl_krmn_f() )
 { l[i]=omo1; R[1505]++; if(dbg){print "R1505", "pl_krmn_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo2; R[1506]++; if(dbg){print "R1506", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2319 !_#_! ==> sw_em_t_		sw_mn_r_  фибром  фи́бром  фибро́м
xgrp="x2319";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_t_f() )
 { l[i]=omo1; R[1507]++; if(dbg){print "R1507", "sw_em_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo2; R[1508]++; if(dbg){print "R1508", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2320 !_#_! ==> sw_od_ne_		mest_mn_i_  они  о́ни  они́
xgrp="x2320";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="они") {
   l[i]=omo2; R[1509]++; if(dbg){print "R1509"}; continue # они́
 };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2321 !_#_! ==> sw_ez_t_		mest_ems_t_  собой  со́бой  собо́й
xgrp="x2321";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="собой") {
   l[i]=omo2; R[1510]++; if(dbg){print "R1510"}; continue # они́
 };
 #
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2322 !_#_! ==> pred_vt_		sw_ne_  обо  о́бо  обо́
xgrp="x2322";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"mest_vi mest_pr") && s(0) )
 { l[i]=omo1; R[1511]++; if(dbg){print "R1511"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2323 !_#_! ==> gl_ed1e_		mest_ems_p_  своем  сво́ем  своё́м
xgrp="x2323";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qb(-3,-1,"pre_pr") && s(qbn,-1) &&
     qir(qbn+1,-1,"prl_edpr mest_pr suw_edmupr suw_edsrpr") )
 { l[i]=omo2; R[1512]++; if(dbg){print "R1512"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2324 !_#_! ==> gl_poed_		sw_em_iv_  случай  случа́й  слу́чай
xgrp="x2324";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(-1,"prl_edvi mest_vi mest_3e") && s(-1) )
 { l[i]=omo2; R[1513]++; if(dbg){print "R1513"}; continue };
 if ( qb(-4,-1,"pre_vi") && s(qbn,-1) &&
     qir(qbn+1,-1,"prl_edvi mest_vi mest_3e") )
 { l[i]=omo2; R[1514]++; if(dbg){print "R1514"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x2325 !_#_! ==> mest_mn_iv_		sw_ne_  те  те́  тё́
xgrp="x2325";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( qf(1,4,"suw_mnvi") && s(0,qfn-1) &&
     qir(1,qfn-1,"prl_mnvi mest_mnvi mest_3e prq_mnvi") )
 { l[i]=omo1; R[1515]++; if(dbg){print "R1515"}; continue };
 if ( w(1,"же") && s(0) )
 { l[i]=omo1; R[1516]++; if(dbg){print "R1516"}; continue };
 if ( w(1,"что которые которым которыми которых кто кого кому") && z(0) )
 { l[i]=omo1; R[1517]++; if(dbg){print "R1517"}; continue };
 if ( q(1,"prl_mnim mest_mnim qis_im qik_im") && s(0) )
 { l[i]=omo1; R[1518]++; if(dbg){print "R1518"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3001 !_#_! ==> gl_paedze_    sw_em_r_   sw_mn_iv_
xgrp="x3001";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1519]++; if(dbg){print "R1519", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo3; R[1520]++; if(dbg){print "R1520", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo3; R[1521]++; if(dbg){print "R1521", "sw_mn_v_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[1522]++; if(dbg){print "R1522", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3002 !_#_! ==> gl_paedze_    sw_es_r_   sw_mn_iv_
xgrp="x3002";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[1523]++; if(dbg){print "R1523", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo3; R[1524]++; if(dbg){print "R1524", "sw_mn_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo3; R[1525]++; if(dbg){print "R1525", "sw_mn_v_f"}; continue };
 #
 if ( gl_paedze_f() )
 { l[i]=omo1; R[1526]++; if(dbg){print "R1526", "gl_paedze_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3003 !_#_! ==> nar_napr_     sw_ez_t_   sw_mn_r_
xgrp="x3003";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[1527]++; if(dbg){print "R1527", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo3; R[1528]++; if(dbg){print "R1528", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3004 !_#_! ==> m2_1sw_mn_i_2deep_na_    sw_em_vr_     sw_ez_i_
xgrp="x3004";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[1529]++; if(dbg){print "R1529", "sw_mn_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[1530]++; if(dbg){print "R1530", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1531]++; if(dbg){print "R1531", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo3; R[1532]++; if(dbg){print "R1532", "sw_ez_i_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3005 !_#_! ==> gl_ed1e_      sw_em_d_   sw_ez_v_
xgrp="x3005";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_d_f() )
 { l[i]=omo2; R[1533]++; if(dbg){print "R1533", "sw_em_d_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo3; R[1534]++; if(dbg){print "R1534", "sw_ez_v_f"}; continue };
 #
 if ( gl_ed1e_f() )
 { l[i]=omo1; R[1535]++; if(dbg){print "R1535", "gl_ed1e_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3006 !_#_! ==> pl_es_iv_     sw_es_iv_  sw_es_p_
xgrp="x3006";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_i_f() )
 { l[i]=omo2; R[1536]++; if(dbg){print "R1536", "sw_es_i_f"}; continue };
 #
 if ( sw_es_v_f() )
 { l[i]=omo2; R[1537]++; if(dbg){print "R1537", "sw_es_v_f"}; continue };
 #
 if ( sw_es_p_f() )
 { l[i]=omo3; R[1538]++; if(dbg){print "R1538", "sw_es_p_f"}; continue };
 #
 if ( pl_es_i_f() )
 { l[i]=omo1; R[1539]++; if(dbg){print "R1539", "pl_es_i_f"}; continue };
 #
 if ( pl_es_v_f() )
 { l[i]=omo1; R[1540]++; if(dbg){print "R1540", "pl_es_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3007 !_#_! ==> sw_em_r_      sw_ez_i_   sw_mn_v_  округа  о́круга  окру́га  округа́
xgrp="x3007";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( bw(-1,"совет") && s(-1) )
 { l[i]=omo1; R[1541]++; if(dbg){print "R1541"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo1; R[1542]++; if(dbg){print "R1542", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_i_f() )
 { l[i]=omo2; R[1543]++; if(dbg){print "R1543", "sw_ez_i_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo3; R[1544]++; if(dbg){print "R1544", "sw_mn_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3008 !_#_! ==> sw_em_l_    sw_em_r_     sw_ez_v_
xgrp="x3008";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_l_f() )
 { l[i]=omo1; R[1545]++; if(dbg){print "R1545", "sw_em_l_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1546]++; if(dbg){print "R1546", "sw_em_r_f"}; continue };
 #
 if ( sw_ez_v_f() )
 { l[i]=omo3; R[1547]++; if(dbg){print "R1547", "sw_ez_v_f"}; continue };
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3009 !_#_! ==> gl_ed3e_  sw_em_iv_  sw_mn_r_
xgrp="x3009";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_ed3e_f() )
 { l[i]=omo1; R[1548]++; if(dbg){print "R1548", "gl_ed3e_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo3; R[1549]++; if(dbg){print "R1549", "sw_mn_r_f"}; continue };
 #
 if ( sw_em_i_f() )
 { l[i]=omo2; R[1550]++; if(dbg){print "R1550", "sw_em_i_f"}; continue };
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[1551]++; if(dbg){print "R1551", "sw_em_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3010 !_#_! ==> gl_mn2e_      sw_em_p_   sw_ez_dp_
xgrp="x3010";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_em_p_f() )
 { l[i]=omo2; R[1552]++; if(dbg){print "R1552", "sw_em_p_f"}; continue };
 #
 if ( sw_ez_d_f() )
 { l[i]=omo3; R[1553]++; if(dbg){print "R1553", "sw_ez_d_f"}; continue };
 #
 if ( sw_ez_p_f() )
 { l[i]=omo3; R[1554]++; if(dbg){print "R1554", "sw_ez_p_f"}; continue };
 #
 if ( gl_mn2e_f() )
 { l[i]=omo1; R[1555]++; if(dbg){print "R1555", "gl_mn2e_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3011 !_#_! ==> heal_1bud_2pov_  gl_pomn_ gl_mn2e_  выходите  вы́ходите  выходи́те  выхо́дите
xgrp="x3011";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( gl_mn2e_f() )
 { l[i]=omo3; R[1556]++; if(dbg){print "R1556", "gl_mn2e_f"}; continue };
 #
 if ( gl_pomn_f() )
 { l[i]=omo2; R[1557]++; if(dbg){print "R1557", "gl_pomn_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3012 !_#_! ==> sw_mn_iv_  sw_es_r_  sw_em_r_  лета  лета́  ле́та  лёта
xgrp="x3012";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_es_r_f() )
 { l[i]=omo2; R[1558]++; if(dbg){print "R1558", "sw_es_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo1; R[1559]++; if(dbg){print "R1559", "sw_mn_i_f"}; continue };
 if ( sw_mn_v_f() )
 { l[i]=omo1; R[1560]++; if(dbg){print "R1560", "sw_mn_v_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3013 !_#_! ==> sw_1ez_r_2ez_mn_iv_  sw_mn_iv_number_  sw_mn_iv_troop_  четы  четы́  чёты  че́ты
xgrp="x3013";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( sw_ez_r_f() )
 { l[i]=omo1; R[1561]++; if(dbg){print "R1561", "sw_ez_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3014 !_#_! ==> gl_export_  gl_smear_  pq_kr_em_  вывозим  выво́зим  вы́возим  вывози́м
xgrp="x3014";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3015 !_#_! ==> gl_carryout_  gl_nurture_  pq_kr_em_  выносим  выно́сим  вы́носим  выноси́м
xgrp="x3015";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3016 !_#_! ==> hyphany_word_  icon_  image_  образной  обра́зной  о́бразной  образно́й
xgrp="x3016";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sc(-1,"-") )
 { l[i]=omo1; R[1562]++; if(dbg){print "R1562"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3017 !_#_! ==> deep_na_  sw_em_vr_  sw_mn_i_  слеса́ря  слесаря́  сле́саря
xgrp="x3017";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( sw_em_v_f() )
 { l[i]=omo2; R[1563]++; if(dbg){print "R1563", "sw_em_v_f"}; continue };
 #
 if ( sw_em_r_f() )
 { l[i]=omo2; R[1564]++; if(dbg){print "R1564", "sw_em_r_f"}; continue };
 #
 if ( sw_mn_i_f() )
 { l[i]=omo3; R[1565]++; if(dbg){print "R1565", "sw_mn_i_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x3018 !_#_! ==> pl_srav_  sw_ez_t_  sw_mn_vr_  сепара'тней  сепаратнёй  сепаратне'й
xgrp="x3018";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2 _nohyphback
 #
 if ( pl_srav_f() )
 { l[i]=omo1; R[1566]++; if(dbg){print "R1566", "pl_srav_f"}; continue };
 #
 if ( sw_ez_t_f() )
 { l[i]=omo2; R[1567]++; if(dbg){print "R1567", "sw_ez_t_f"}; continue };
 #
 if ( sw_mn_v_f() )
 { l[i]=omo3; R[1568]++; if(dbg){print "R1568", "sw_mn_v_f"}; continue };
 #
 if ( sw_mn_r_f() )
 { l[i]=omo3; R[1569]++; if(dbg){print "R1569", "sw_mn_r_f"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4700 !_#_! ==> cost_         stand_   стоит  сто́ит  стои́т
xgrp="x4700";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 if(iwrd=="стоит") {
   if ( q(1,"prl_ro mest_ro") &&
        q(2,"suw_ro") && s(0,1) && Q(1,"suw_edim") )
   { l[i]=omo1; R[1570]++; if(dbg){print "R1570"}; continue };
   if ( q(1,"suw_ro") && s(0) && Q(1,"suw_edim") )
   { l[i]=omo1; R[1571]++; if(dbg){print "R1571"}; continue };
 };
 #
 if ( w(1,"того") && z(1) &&
      w(2,"чтобы") )
 { l[i]=omo1; R[1572]++; if(dbg){print "R1572"}; continue };
 #
 if (  qxs(-1,"один одно","другого")||
       qxs(-1,"одна","другой")||
       qxs(-1,"мало","что")||
       qxs(-1,"чего-то кое-чего","и да")||
       qxs(-1,"ничего что столько лучше","не")||
       qxs(-1,"друг","друга") )
 { l[i]=omo1; R[1573]++; if(dbg){print "R1573"}; continue };
 #
 if (  qxs(1,"один","другого")||
       qxs(1,"в","зависимости","от")||
       qxs(1,"ни","копейки гроша цента")||
       qxs(1,"по","колено щиколотку пояс горло шею подбородок уши брови","в")||
       qxs(1,"мало","что")||
       qxs(1,"друг","друга")  )
 { l[i]=omo1; R[1574]++; if(dbg){print "R1574"}; continue };
 #
 if ( narph_kaq(1) &&
              q(xwn+1,"qik_im qik_edim") &&
              q(xwn+2,"suw_mnro") && ba(xwn+2,"_geld") && s(0,xwn+1) )
 { l[i]=omo1; R[1575]++; if(dbg){print "R1575"}; continue };
 if ( q(1,"qik_im qik_edim") &&
      q(2,"suw_ro") && ba(2,"_geld") && s(0,1) )
 { l[i]=omo1; R[1576]++; if(dbg){print "R1576"}; continue };
 if ( q(-1,"mest_it suw_im") &&
      q(1,"suw_im") && ba(1,"_geld") && s(-1,0) )
 { l[i]=omo1; R[1577]++; if(dbg){print "R1577"}; continue };
 if ( q(1,"prl_ro mest_ro") &&
      q(2,"suw_ro") && s(0,1) && Q(1,"suw_im") )
 { l[i]=omo1; R[1578]++; if(dbg){print "R1578"}; continue };
 if ( q(1,"suw_ro") && s(0) && Q(1,"suw_im") )
 { l[i]=omo1; R[1579]++; if(dbg){print "R1579"}; continue };
 if ( w(1,"по") &&
      q(2,"qik_im qik_edim") &&
      q(3,"suw_ro") && ba(3,"_geld") && s(0,3) )
 { l[i]=omo1; R[1580]++; if(dbg){print "R1580"}; continue };
 #
 if ( p(-2) && w(-1,"не") && s(-1) && p(0) )
 { l[i]=omo1; R[1581]++; if(dbg){print "R1581"}; continue };
 if ( p(-1) && w(1,"ли") && s(0) && p(1) )
 { l[i]=omo1; R[1582]++; if(dbg){print "R1582"}; continue };
 if ( p(-2) && w(-1,"а но не") &&
      w(1,"ли") && s(-1,0) && p(1) )
 { l[i]=omo1; R[1583]++; if(dbg){print "R1583"}; continue };
 cst="кое-чего чего чего-нибудь чего-то";
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1584]++; if(dbg){print "R1584"}; continue };
 #
 cst="более больше денег дешево дорого дорогого мало менее меньше многого недорого немало немногого побольше поменьше того";
 if ( w(1,cst) && s(0) )
 { l[i]=omo1; R[1585]++; if(dbg){print "R1585"}; continue };
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo1; R[1586]++; if(dbg){print "R1586"}; continue };
 if ( q(1,"mest_mnro prl_mnro") &&
      w(2,"денег") && s(0,1) )
 { l[i]=omo1; R[1587]++; if(dbg){print "R1587"}; continue };
 #
 if ( q(-1,"mest_it") &&
      w(1,"риска") && s(-1,0) )
 { l[i]=omo1; R[1588]++; if(dbg){print "R1588"}; continue };
 #
 cst="больше дешево дорого меньше";
 if ( q(1,"prl_kred_sr nar_step") &&
      w(2,cst) && s(0,1) )
 { l[i]=omo1; R[1589]++; if(dbg){print "R1589"}; continue };
 #
 cst="боком впереди выше лицом ниже позади сбоку сзади слева снизу спиной справа столбом";
 if ( w(1,cst) && s(0) )
 { l[i]=omo2; R[1590]++; if(dbg){print "R1590"}; continue };
 if ( w(-1,cst) && s(-1) )
 { l[i]=omo2; R[1591]++; if(dbg){print "R1591"}; continue };
 #
 if ( qb(-5,-1,"gl_in") && s(qbn,-1) &&
     qir(qbn+1,-1,"qast_any nar_kaq nar_spos nar_step nar_vrem") )
 { l[i]=omo1; R[1592]++; if(dbg){print "R1592"}; continue };
 #
 if ( qf(1,5,"gl_in") && s(0,qfn-1) &&
     qir(1,qfn-1,"qast_any nar_kaq nar_spos nar_step nar_vrem") )
 { l[i]=omo1; R[1593]++; if(dbg){print "R1593"}; continue };
 #
 if ( q(-1,"nar_mest nar_spos nar_kaq") && s(-1) )
 { l[i]=omo2; R[1594]++; if(dbg){print "R1594"}; continue };
 if ( q(1,"nar_mest nar_spos nar_kaq") && s(0) )
 { l[i]=omo2; R[1595]++; if(dbg){print "R1595"}; continue };
 #
 if ( pre_ro(1) &&
           q(2,"suw_ro prl_ro prq_ro mest_ro") && s(0,1) )
 { l[i]=omo2; R[1596]++; if(dbg){print "R1596"}; continue };
 if ( pre_ro(-2) &&
           q(-1,"suw_ro") &&
           q(1,"suw_im") && s(-2,0) )
 { l[i]=omo2; R[1597]++; if(dbg){print "R1597"}; continue };
 if ( pre_ro(-2) &&
           q(-1,"suw_ro") &&
           q(1,"prl_im prq_im mest_im") &&
           q(2,"suw_im") && s(-2,1) )
 { l[i]=omo2; R[1598]++; if(dbg){print "R1598"}; continue };
 #
 if ( pre_pr(1) &&
           q(2,"suw_edme") && s(0,1) )
 { l[i]=omo2; R[1599]++; if(dbg){print "R1599"}; continue };
 if ( pre_pr(1) &&
           q(2,"prl_edpr") &&
           q(3,"suw_edme") && s(0,2) )
 { l[i]=omo2; R[1600]++; if(dbg){print "R1600"}; continue };
 #
 if ( pre_pr(1) &&
           q(2,"suw_pr prl_pr prq_pr mest_pr") && s(0,1) )
 { l[i]=omo2; R[1601]++; if(dbg){print "R1601"}; continue };
 if ( pre_pr(-2) &&
           q(-1,"suw_pr") &&
           q(1,"suw_im") && s(-2,0) )
 { l[i]=omo2; R[1602]++; if(dbg){print "R1602"}; continue };
 if ( pre_pr(-2) &&
           q(-1,"suw_pr") &&
           q(1,"prl_im prq_im mest_im") &&
           q(2,"suw_im") && s(-2,1) )
 { l[i]=omo2; R[1603]++; if(dbg){print "R1603"}; continue };
 #
 if ( pre_tv(1) &&
           q(2,"suw_tv prl_tv prq_tv mest_tv") && s(0,1) )
 { l[i]=omo2; R[1604]++; if(dbg){print "R1604"}; continue };
 if ( pre_tv(-2) &&
           q(-1,"suw_tv") &&
           q(1,"suw_im") && s(-2,0) )
 { l[i]=omo2; R[1605]++; if(dbg){print "R1605"}; continue };
 if ( pre_tv(-2) &&
           q(-1,"suw_tv") &&
           q(1,"prl_im prq_im mest_im") &&
           q(2,"suw_im") && s(-2,1) )
 { l[i]=omo2; R[1606]++; if(dbg){print "R1606"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4701 !_#_! ==> comeout_    heal_    выходить  выходи́ть  вы́ходить
xgrp="x4701";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(1,"pre_vi") &&
      q(2,"suw_vi prl_vi prq_vi mest_vi") && s(0,1) )
 { l[i]=omo1; R[1607]++; if(dbg){print "R1607"}; continue };
 if ( q(1,"pre_ro") &&
      q(2,"suw_ro prl_ro prq_ro mest_ro") && s(0,1) )
 { l[i]=omo1; R[1608]++; if(dbg){print "R1608"}; continue };
 if ( q(1,"pre_da") &&
      q(2,"suw_da prl_da prq_da mest_da") && s(0,1) )
 { l[i]=omo1; R[1609]++; if(dbg){print "R1609"}; continue };
 if ( pre_pr(1) &&
           q(2,"suw_pr suw_edme prl_pr prq_pr mest_pr") && s(0,1) )
 { l[i]=omo1; R[1610]++; if(dbg){print "R1610"}; continue };
 if ( p(-1) && z(0) )
 { l[i]=omo1; R[1611]++; if(dbg){print "R1611"}; continue };


 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4702 !_#_! ==> know_    lead_    введение  ве́дение  веде́ние
xgrp="x4702";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 cst="быть находиться передавать передаваться передать";
 if ( w(-2,"в") &&
      q(-1,"mest_vi mest_pr") &&
      q(0,"suw_vi suw_pr") &&
      q(1,"suw_ro") &&
     bw(2,cst) && s(-2,1) )
 { l[i]=omo1; R[1612]++; if(dbg){print "R1612"}; continue };
 if ( w(-2,"в") &&
      q(-1,"mest_vi mest_pr") &&
      q(0,"suw_vi suw_pr") &&
     bw(1,cst) && s(-2,0) )
 { l[i]=omo1; R[1613]++; if(dbg){print "R1613"}; continue };
 #
 if ( prl_kred_sr(1) &&
                q(2,"prl_ro prq_ro mest_ro") &&
                q(3,"prl_ro prq_ro mest_ro suw_ro") && s(0,2) )
 { l[i]=omo2; R[1614]++; if(dbg){print "R1614"}; continue };
 if ( q(1,"prl_ro prq_ro mest_ro") &&
      q(2,"suw_ro") && s(0,1) )
 { l[i]=omo2; R[1615]++; if(dbg){print "R1615"}; continue };
 if ( q(1,"suw_ro") && s(0) )
 { l[i]=omo2; R[1616]++; if(dbg){print "R1616"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4703 !_#_! ==> temp_    time_    временной  вре́менной  временно́й
xgrp="x4703";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( w(-1,"пространственно") && se(-1,"-") )
 { l[i]=omo2; R[1617]++; if(dbg){print "R1617"}; continue };
 #
 if(iwrd=="временной") {
   if ( q(1,"suw_edmuim suw_edmuvi") && s(0) )
   { l[i]=omo2; R[1618]++; if(dbg){print "R1618"}; continue };
 };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4704 !_#_! ==> disperse_  herumlauf_    разбегаться  разбега́ться  разбе́гаться
xgrp="x4704";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( q(0,"gl_in") && q(-1,"mod_ed mod_bz mod_mn") && s(-1) )
 { l[i]=omo1; R[1619]++; if(dbg){print "R1619"}; continue };
 if ( q(0,"gl_navzmn") && q(1,"gl_namn gl_navzmn") && z(0) )
 { l[i]=omo1; R[1620]++; if(dbg){print "R1620"}; continue };
 if ( q(0,"gl_pavzmn") && q(1,"gl_pamn") && z(0) )
 { l[i]=omo1; R[1621]++; if(dbg){print "R1621"}; continue };
 if ( q(0,"gl_buvzmn") && q(1,"gl_bumn") && z(0) )
 { l[i]=omo1; R[1622]++; if(dbg){print "R1622"}; continue };
 if ( q(0,"gl_povzmn") )
 { l[i]=omo1; R[1623]++; if(dbg){print "R1623"}; continue };
 if ( pre_pr(1) &&
           q(2,"prl_ro prq_ro") &&
           q(3,"suw_ro") && s(0,2) )
 { l[i]=omo1; R[1624]++; if(dbg){print "R1624"}; continue };
 if ( pre_ro(1) &&
           q(2,"suw_ro") && s(0,1) )
 { l[i]=omo1; R[1625]++; if(dbg){print "R1625"}; continue };
 if ( pre_pr(1) &&
           q(2,"prl_pr prq_pr") &&
           q(3,"suw_pr") && s(0,2) )
 { l[i]=omo1; R[1626]++; if(dbg){print "R1626"}; continue };
 if ( pre_pr(1) &&
           q(2,"suw_pr") && s(0,1) )
 { l[i]=omo1; R[1627]++; if(dbg){print "R1627"}; continue };
 if ( pre_pr(-2) &&
           q(-1,"suw_pr") && s(-2,-1) )
 { l[i]=omo1; R[1628]++; if(dbg){print "R1628"}; continue };
 if ( z(0) &&
      w(1,"как словно") &&
      q(2,"suw_im") && s(1) )
 { l[i]=omo1; R[1629]++; if(dbg){print "R1629"}; continue };
 if ( z(0) &&
      w(1,"как словно") &&
      q(2,"prl_im") &&
      q(3,"suw_im") && s(1,2) )
 { l[i]=omo1; R[1630]++; if(dbg){print "R1630"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4705 !_#_! ==> sink_   stomp_    упопать  упопа́ть  упо́пать
xgrp="x4705";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4706 !_#_! ==> arrest_    drive_   привод   приво́д  при́вод
xgrp="x4706";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if ( bw(-1,"главный") && s(-1) )
 { l[i]=omo2; R[1631]++; if(dbg){print "R1631"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4707 !_#_! ==> castle_    lock_   замок  за́мок  замо́к
 #    замка  замкам  замками  замках  замке  замки  замков  замком  замку  замок
 #    файл ext/x4707.awk

 x4707_f()
 #--------------------------------------------------------------------------------------

###   x4708 !_#_! ==> castle_    lock_   замоковый  за́моковый  замо́ковый
xgrp="x4708";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
#if ( bw(-1,"главный") && s(-1) )
#{ l[i]=omo2; R[1632]++; if(dbg){print "R1632"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer
 #--------------------------------------------------------------------------------------

###   x4709 !_#_! ==> palate_    sky_    небо  нёбо  не́бо
 #    небо неба небу небом небе
 #    файл ext/x4709.awk

 x4709_f()
 #--------------------------------------------------------------------------------------

###   x4718 !_#_! ==> pl_any_    pl_dear_   любой   любо́й  любо́й
xgrp="x4718";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
 if(iwrd=="любом") {
   if ( q(-1,"pre_pr") && qf(1,3,"suw_edmupr suw_edsrpr") && s(-1,qfn-1) &&
      qir(1,qfn-1,"prl_edmupr prq_edmupr mest_3e") )
   { l[i]=omo2; R[1633]++; if(dbg){print "R1633"}; continue };
   if ( q(-1,"pre_pr") && w(1,"из") && s(-1,0) )
   { l[i]=omo2; R[1634]++; if(dbg){print "R1634"}; continue };
 };

 if(iwrd=="любое") {
   if ( qf(1,3,"suw_edsrvi") && s(0,qfn-1) &&
       qir(1,qfn-1,"prl_edsrvi prq_edsrvi mest_edsrvi mest_3e") )
   { l[i]=omo2; R[1635]++; if(dbg){print "R1635"}; continue };
   if ( q(-1,"pre_vi") && s(-1) )
   { l[i]=omo2; R[1636]++; if(dbg){print "R1636"}; continue };
 };
 if(iwrd=="любую") {
   if ( qf(1,3,"suw_edzevi") && s(0,qfn-1) &&
       qir(1,qfn-1,"prl_edzevi prq_edzevi mest_edzevi mest_3e") )
   { l[i]=omo2; R[1637]++; if(dbg){print "R1637"}; continue };
   if ( q(-1,"pre_vi") && s(-1) )
   { l[i]=omo2; R[1638]++; if(dbg){print "R1638"}; continue };
 };
 if ( w(1,"из") && s(0) )
 { l[i]=omo2; R[1639]++; if(dbg){print "R1639"}; continue };

 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x4719 !_#_! ==> medium_    wednesday_   среду   среду́  сре́ду
xgrp="x4719";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
 #
   if ( wa(-1,"_medium_v_suw-vi") && s(-1) )
   { l[i]=omo1; R[1640]++; if(dbg){print "R1640"}; continue };

   cst="дисперсии потерь";
   if ( qxs(1,"без",cst) )
   { l[i]=omo1; R[1641]++; if(dbg){print "R1641"}; continue };
   cst="анизотропией дисперсией изображением нелинейностью неоднородностями откликом параметрами потерями трением";
   if ( w(1,"с со") && wf(2,4,cst) && s(0,wfn-1) &&
      qir(1,wfn-1,"prl_edtv") )
   { l[i]=omo1; R[1642]++; if(dbg){print "R1642"}; continue };
   cst="афферентации голода обитания программирования";
   if ( wf(1,3,cst) && s(0,wfn-1) &&
       qir(1,wfn-1,"prl_edro") )
   { l[i]=omo1; R[1643]++; if(dbg){print "R1643"}; continue };
   cst="активированную благоприятную воспринимаемую вызывающую захватывающую позволяющую пригодную свободную";
   if ( z(0) && w(1,cst) )
   { l[i]=omo1; R[1644]++; if(dbg){print "R1644"}; continue };
   cst="ввести поместить разместить";
   if ( wb(-4,-1,"в") && s(wbn-1,0) &&
        bw(wbn-1,cst) &&
       qir(wbn+1,-1,"prl_edvi") )
   { l[i]=omo1; R[1645]++; if(dbg){print "R1645"}; continue };

   #
   l[i]=omo2; R[1646]++; if(dbg){print "R1646"}; continue;
 }; book[b]=joinpat(l,sep,nf) };};                                ##_footer

###   x9999 !_#_! ==> forced_       none_
#xgrp="x9999";for(wrd in omap[xgrp]){omakevars(xgrp);for(y=1;y<=wln;y++)        # header1
#{makebookvars();for(i in wpos){makewposvars();if(tolower(l[i])!=iwrd)continue; # header2
##

#l[i]=omo1; R[1647]++; if(dbg){print "R1647"}; continue;

#}; book[b]=joinpat(l,sep,nf) };};                                ##_footer


### THE_x_END !_#_!

# вывести изменённую строку

for (i in book) { print book[i] }

if ( dbgstat ) { DO_DEBUG(Z,"Z") };

if ( catch_file && length(wCAT) > 0 ) { for (i in wCAT) { print i >> catch_file } }

  }
###_END_###


