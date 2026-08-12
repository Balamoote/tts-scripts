function stoar(string, arrto, sepr,    k) {         # добавить в массив arrto элементы строки string
                split(string, artmp, sepr); for (k in artmp) {if(artmp[k]) {arrto[artmp[k]]}; };}
BEGIN {

  RUUC     = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]+"
  RUUC_    = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ]"
  patword  = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb00-9]+"
  patword_ = "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя\xcc\x81\xcc\xa0\xcc\xa3\xcc\xa4\xcc\xad\xcc\xb00-9 ]+"
  rulc     = "[абвгдеёжзийклмнопрстуфхцчшщъыьэюя]+"
  rulcs    = "[ абвгдеёжзийклмнопрстуфхцчшщъыьэюя-]+"
  rulcr    = "[][ ^$.+\x5c?*|xабвгдеёжзийклмнопрстуфхцчшщъыьэюя0-9-]+"
  rulc_    = "[абвгдеёжзийклмнопрстуфхцчшщъыьэюя]"
  rulcst   = "((\"" rulcs "\")|(cst[0-9]?)|(cst_[a-z]+))"

  isfun    = "[a-zA-Z_0-9]+"
  nofun    = "[^a-zA-Z_0-9]"
  funpat   = nofun isfun "\\("
  ids      = "(ispa_abst|ispa_any|ispa_food|ispa_liquid|ispa_liquid|ispa_loose|ispa_solid|hsw4edro|hsw4mnro|usw4edim|usw4edda|usw4edtv|usw4edvi|usw4edro|usw4edpr|gl4pa|gl4dOma)"
  n=m      = "(([-0-9+*_a-zA-Z]+)|([A-Z]\\[\"[A-z_+-]+\"\\]([-+][0-9])?))"
# n=m      = "([-0-9+_a-z]+)|([A-Z]\\[\"[a-z_+-]+\"\\]([-+][0-9])?)"
  varpat   = "(([A-Z]\\[\"[A-z_+-]+\"\\])|([A-Z]\\[[a-z_]+\\])|([a-z_+0-9-]+))"
  varpat1  = "(([-+_0-9a-z]+)|(\"[_a-z]+\")|([A-Z]\\[\"[A-z_+-]+\"\\])|([A-Z]\\[\"[A-z_+-]+\"\\]([-+][0-9]+)?))"
  varpat2  = "(([A-Z]\\[\"[A-z_+-]+\"\\])|([A-Z]\\[[a-z_]+\\])|([A-z_+0-9-]+)|(\"" rulcs "\"))"
  strvals  = "^((cst[0-9]?)|(cst_[a-z]+)|(pre_[a-z]+))$"

#funcs["readfile"]="file";
#funcs["joinpat"]="array,seps,nuf"    #joinpat(array, seps, nuf,    ret, i, k)
#funcs["pusha"]="arr,arrto"    #pusha(arr, arrto,    k)
#funcs["abs"]="n"
#funcs["stoar"]="string,arrto,sepr"    #stoar(string, arrto, sepr,    k)
#funcs["stotar"]="string,arrto,sepr"    #stotar(string, arrto, sepr,    k)
#funcs["sto2xw"]="string,arrto"    #sto2xw(string, arrto,   j,k)
#funcs["sto3xw"]="string,arrto"    #sto3xw(string, arrto,   j,k)
#funcs["stoid"]="string1,string2,wid"    #stoid(string1, string2,wid,    k,j)
#funcs["atoid"]="string,arr,wid"    #atoid(string, arr,wid,    k,j)
#funcs["sanit"]="string,sepin,sepout"    #sanit(string, sepin, sepout,   j,k,ret)
#funcs["hyphback"]="hystring"
#funcs["hyphbphy"]="hystring"
#funcs["splitline"]="instring"    #splitline(instring,    ret)
#funcs["splitlinephy"]="instring"    #splitlinephy(instring,    ret)
#funcs["regwpart"]="word,part"    #regwpart(word, part,    ret)
#funcs["getwpos"]="word"    #getwpos(word,    n)
#funcs["regwpos"]="word"    #regwpos(word,    n)
#funcs["arrpack"]="n,array"    #arrpack(n, array,   i, ret)
#omakevars(xklass)
#makebookvars()
#makebookvars_nohyphback()
#makewposvars()

# функции обработки слов: сбор слов для записи в отдельный файл
funcs["getBF"]=n ",.+"                                                       #getBF(n,file,   itmz, k)
funcs["getBFb"]=n "," m ",.+"                                                #getBFb(n,m,file,    k, ret)
funcs["getBFf"]=n "," m ",.+"                                                #getBFf(n,m,file,    k, ret)
funcs["getBFx"]=n "," m ",.+"                                                #getBFx(n,m,file,   sw,kw, k,j, ret)
# функции обработки сепараторов
funcs["p"]=n "(,\"([…,.:;!?—]|(\\[[…,.:;!?—]+\\]))\")?"                      #p(n,wl,    ret)
funcs["s"]=n "((," m ")|((," m ")?,\"\\[?[…,.:;!?—]+\\]?\"))?"                        #s(n,m,sym,    pkt,el,k,sw,ret)
funcs["sL"]=n ",\"\\[?.\\]?\""                                               #sL(n,wl,    ret)
funcs["sR"]=n ",\"\\[?.\\]?\""                                               #sR(n,wl,    ret)
funcs["z"]=n                                                                 #z(n,    el, ret)
funcs["zs"]=n                                                                #zs(n,  el, ret)
funcs["dz"]=n                                                                #ds(n,  el, ret)
funcs["sc"]=n ",((\".+\")|(cst[0-9]?))"                                      #sc(n, sym,    el, ret)
funcs["sv"]=n ",\".+\""                                                      #sv(n, sym,    el, ret)
funcs["se"]=n ",\".+\""                                                      #se(n, sym,    el, ret)
funcs["sq"]=n "," m ",\"(.|(\\[.+\\]))\""                                    #sq(n, m, pu,   k, ret)
funcs["sQ"]=n "," m ",\".+\""                                                #sQ(n, m, pu,   k, ret)
# функции обработки диапазона сепараторов
funcs["qsf"]=n "," m ",((\"(.|(\\[.+\\]))\")|(vvpat))"                       #qsf(n, m, sym,   k, stps, ret)
funcs["qsb"]=n "," m ",\".\""                                                #qsb(n, m, sym,   k, ret)
funcs["sos"]=n "," m                                                         #sos(n, m,   stps,k,ret)
funcs["eos"]=n "," m                                                         #eos(n, m,   stps,k,ret)
funcs["vv"]=n "," m                                                          #vv(n,m,    k, ret)
funcs["vvb"]=n "," m                                                         #vvb(n,m,    k, ret)
# функции обработки слов
funcs["lc"]=n                                                                #lc(n,   ret)
funcs["lcne"]=n                                                              #lcne(n,   ret)
funcs["q_"]=n ",[_a-z]+"                                                     #q_(n, array,    el, ret)
funcs["qb_"]=n "," m ",[_a-z3]+"                                             #qb_(n,m, array,    k, ret)
funcs["qf_"]=n "," m ",[_a-z3]+"                                             #qf_(n,m, array,    k, ret)
funcs["q"]=n ",((\"[ _a-z3]+\")|(cst[0-9]+)|(pre_[a-z]+))"                   #q(n, alist,   itmz,k,wd, ret)
funcs["q_ist"]=n ",((\"[ _a-z3]+\")|(cst[0-9]+)|(pre_[a-z]+))"               #q_ist(n, alist,   itmz,k,wd, ret)
funcs["q_w"]=n ",\"[ _a-z3]+\""                                              #q_w(n, alist,    itmz,k,wd, ret)
funcs["qw_"]=n ",\"[ _a-z3]+\""                                              #qw_(n, alist,    itmz,k,wd, ret)
funcs["qy"]=n ",\"[ _a-z3]+\""                                               #qy(n, alist,    itmz,k,wd, ret)
funcs["Qist"]=n ",\"[ _a-z]+\""                                              #Qist(n, alist,    itmz,k,wd, ret)
funcs["Q"]=n ",\"[ _a-z3]+\""                                                #Q(n, alist,    itmz,k,wd, ret)
funcs["Qw_"]=n ",\"[ _a-z3]+\""                                              #Qw_(n, alist,    itmz,k,wd, ret)
funcs["Q_w"]=n ",\"[ _a-z3]+\""                                              #Q_w(n, alist,    itmz,k,wd, ret)
funcs["id_"]=n ",\"" ids "\""                                                #id_(n, wl,   itmz,k, ret)
funcs["id"]=n ",\"" ids "\""                                                 #id(n, wl,    ret)
funcs["idf"]=n "," m ",\"" ids "\""                                          #idf(n,m, wl,    k, ret)
funcs["idb"]=n "," m ",\"" ids "\""                                          #idb(n,m, wl,    k, ret)
funcs["qm"]=n ",\"[a-z _3]+\",((\"[- _a-z0-9]+\")|(str_[a-z_]+))"    #qm(n, isclass, wl,    ret)
funcs["qq"]=n "," m                                                          #qq(n, m,    ret)
funcs["bqq"]=n "," m                                                         #bqq(n, m,   k,itmz1,itmz2, ret)
funcs["qb"]=n "," m ",\"[a-z _3]+\""                                         #qb(n,m, isclass,    k, ret)
funcs["qb_ist"]=n "," m ",\"[a-z _3]+\""                                     #qb_ist(n,m, isclass,    k, ret)
funcs["qB"]=n "," m ",\"[a-z _3]+\",\"[a-z_3]+\""                            #qB(n,m, isclass, notclass,    k, ret)
funcs["seek"]=n "," m ",\"[a-z _3]+\",\"[a-z _3]+\""                         #seek(n,m, isclass, notclass,    k, ret)
funcs["qfba"]=n "," m ",\"[a-z _3]+\",\"[a-z _-]+\""                         #seek(n,m, isclass, notclass,    k, ret)
funcs["qbba"]=n "," m ",\"[a-z _3]+\",\"[a-z _3-]+\""                         #seek(n,m, isclass, notclass,    k, ret)
funcs["qf"]=n "," m ",\"[a-z _3]+\""                                         #qf(n,m, isclass,    k, ret)
funcs["qir"]=n "," m ",((\"[a-z_ 3]+\")|(cst[0-9]?)|(cst_[a-z]+))"           #qir(n,m, isclass,    k, ret)
funcs["qia"]=n "," m ",\"[a-z_ 3]+\",\"[a-z_ 3]+\""                          #qia(n,m, isclass1, isclass,    el,k,ret)
funcs["qiz"]=n "," m ",\"[a-z_ 3]+\",\"[a-z_ 3]+\""                          #qiz(n,m, isclass, isclass1,    el,k,ret)
funcs["wir"]=n "," m "," rulcst                                              #wir(n,m, wl,    k, ret)
funcs["wia"]=n "," m "," rulcst "," rulcst                                   #wia(n,m, wl1, wl,    el,k,ret)
funcs["wiz"]=n "," m "," rulcst "," rulcst                                   #wiz(n,m, wl, wl1,    el,k,ret)
funcs["wiq"]=n "," m "," rulcst ",((\"[a-z_ 3]+\")|(cst[0-9]?))"             #wiq(n,m, wl, isclass,    el,k,ret)
funcs["qiw"]=n "," m ",((\"[a-z_ 3]+\")|(cst[0-9]?))," rulcst                #qiw(n,m, isclass, wl,    el,k,ret)
funcs["qF"]=n "," m ",\"[a-z _3]+\",\"[a-z _3]+\""                           #qF(n,m, isclass, notclass,    k, ret)
funcs["Qb"]=n "," m ",\"[a-z _3]+\""                                         #Qb(n,m, isclass,    k, ret)
funcs["Qf"]=n "," m ",\"[a-z _3]+\""                                         #Qf(n,m, isclass,    k, ret)
#funcs["Qif"]=n "," m ",\"[a-z _3]+\""                                              #Q1f(n,m, isclass,    k, ret)
funcs["Qb_"]=n ",\"[_a-z3]+\""                                                   #Qb_(n, array,    k, ret)
funcs["Qf_"]=n ",\"[_a-z3]+\""                                                   #Qf_(n, array,    k, ret)
funcs["Q_"]=n ",\"[_a-z3]+\""                                                    #Q_(n, array,    ret)
funcs["isname"]=n                                                            #isname(n,    wd, el, en, es, ret)
funcs["isacro"]=n                                                            #isacro(n,    wd, el, en, ret)
funcs["cap"]=n                                                               #cap(n,    ret)
funcs["w2x"]=n ",\"[_a-z]+\""                                                #w2x(n,wl,    w1,w2,j,k, ret)
funcs["w3x"]=n ",\"[_a-z]+\""                                                #w3x(n,wl,    w1,w2,w3,j,k, ret)
funcs["bw"]=n "," rulcst                                                     #bw(n,wl,    itmz,k, ret)
funcs["mbba"]=n "," m ",\"[-_A-z0-9]+\""                                     #mbba(n,m,wl,  w1,  itmz1,itmz2,k, ret)
funcs["mwba"]=n "," m ",\"[-_A-z0-9]+\""                                     #mwba(n,m,wl,  itmz,w1,k, ret)
funcs["mwwa"]=n "," m ",\"[-_A-z0-9]+\""                                     #mwwa(n,m,wl,  itmz,w1,k, ret)
funcs["bf"]=n "," m ",(\"" rulcs "\")|(cst[0-9]?)"                           #bf(n,m,wl,   itmz,j,k, ret)
funcs["bb"]=n "," m ",(\"" rulcs "\")|(cst[0-9]?)"                           #bb(n,m,wl,   itmz,j,k, ret)
funcs["bam"]=n ",\"[- _A-z0-9]+\""                                           #bam(n,wl,    itmz1,k, ret)
funcs["ba"]=n ",((\"[-_A-z0-9]+\")|([_a-z]+))"                               #ba(n,wl,     itmz,k, ret)
funcs["bfa"]=n "," m ",((\"[-_A-z0-9]+\")|(str_lock|str_castle))"            #bfa(n,m,wl,   itmz,j,k, ret)
funcs["bba"]=n "," m ",((\"[-_A-z0-9]+\")|(str_lock|str_castle))"           #bba(n,m,wl,     itmz,k, ret)
funcs["bba2"]=n "," m ",\"[-_A-z0-9]+\""                                     #bba2(n,m,wl,    itmz,k, ret)
funcs["Xw"]=n ",\"[_A-z]+\""                                                 #Xw(n,wl,           ret)
funcs["xw"]=n ",\"[_A-z]+\""                                                 #xw(n,wl,           ret)
funcs["digits"]=n
funcs["roman"]=n
funcs["w"]=n "," rulcst                                                      #w(n, wl,    itmz, ret)
funcs["wy"]=n "," rulcst                                                     #wy(n, wl,    itmz, ret)
funcs["hwy"]=n "," rulcst                                                    #hwy(n, wl,    itmz, ret)
funcs["wa"]=n ",\"[-A-z_]+\""                                                #wa(n, wl,    ret)
funcs["ww_"]=n "," rulcst                                                    #ww_(n, wl,    itmz, ret)
funcs["w_w"]=n ",\"" rulcst                                                  #w_w(n, wl,    itmz, ret)
funcs["wist"]=n ",\"" patword_ "\""                                           #wist(n, wl,    itmz, ret)
funcs["gist"]=n "," m                                                        #gist(n, m,    wd, istomo,  ret)
funcs["wc"]=n ",((\"" rulcr "( " rulcr "){0,}\")|(cst[0-9]?))"               #wc(n, wl,    itmz, k, lk, ret)
funcs["jme"]=n ",((\"" rulc "\")|(cst[0-9]?)),cst[0-9]?"                     #jme(n, p1, p2,    itmz1, itmz2, jwordz, jword, k, j, ret)
funcs["wme"]=n ",p1,p2"                                                      #wme(n, p1, p2,    itmz1, itmz2, jwordz, jword, k, j, ret)
funcs["wma"]=n ",\"[-_a-z]+\",cst[0-9]?"                                     #wma(n, p1, p2,    itmz2, jwordz, jword, k, j, ret)
funcs["Wc"]=n ",((\"" rulcr "( " rulcr "){0,}\")|(cst[0-9]?))"               #Wc(n, wl,    itmz, k, lk, ret)
funcs["W"]=n "," rulcst                                                      #W(n, wl,    itmz, ret)
funcs["Ww_"]=n ",\"" rulcs "\""                                              #Ww_(n, wl,    itmz, ret)
funcs["W_w"]=n ",\"" rulcs "\""                                              #W_w(n, wl,    itmz, ret)
funcs["wb"]=n "," m ",(\"\\^?" rulcs "\\$?\")|cst[0-9]?"                     #wb(n,m, wl,    itmz, k, ret)
funcs["wb2"]=n "," m ",(\"\\^?" rulcs "\\$?\")|cst[0-9]?"                    #wb2(n,m, wl,    itmz, k, ret)
funcs["wba"]=n "," m ",\"[-_a-z0-9]+\""                                      #wba(n,m, wl,    k, ret)
funcs["wb_raw"]=n "," m ",\"" patword "\""                                   #wb_raw(n,m, wl,    itmz, k, ret)
funcs["wf"]=n "," m ",(\"\\^?" rulcs "\\$?\")|cst[0-9]?"                     #wf(n,m, wl,    itmz, k, ret)
funcs["wf2"]=n "," m ",(\"\\^?" rulcs "\\$?\")|cst[0-9]?"                    #wf2(n,m, wl,    itmz, k, ret)
funcs["wfa"]=n "," m ",\"[-_a-z0-9]+\""                                      #wfa(n,m, wl,    k, ret)
funcs["exf"]=n ",\".+\""                                                     #exf(n, wl,    itmz, itmz1, k, lk, ret)
funcs["exf_"]=n ",\".+\""                                                    #exf_(n, wl,    itmz, itmz1, k, lk, ret)
funcs["exb"]=n ",\".+\""                                                     #exb(n, wl,    itmz, itmz1, k, lk, ret)
funcs["exb_"]=n ",\".+\""                                                    #exb_(n, wl,    itmz, itmz1, k, lk, ret)
funcs["phs"]=n ",\".+\""                                                     #phs(n, wl,    itmz, k, lk, cnt, ret)
funcs["phf"]=n ",\".+\""                                                     #phf(n, wl,    itmz, k, lk, cnt, ret)
#funcs["wmark"]="mrk,wl"                                                     #wmark(mrk,wl,    itmz,k,el,vmrk, ret)
funcs["ismark"]=n ",\"[a-zA-Z_]+\""                                          #ismark(n,mrk,    itmz,k,el,vmrk, ret)
funcs["notmark"]=n ",\"[a-zA-Z_]+\""                                         #notmark(n,mrk,    itmz,k,el,vmrk, ret)
funcs["notsym"]=n ",((\"[a-zA-Z_]+\")|unxy)"                                 #notsym(n,sym,    ret)
funcs["qxs"]=n "(,((\"" rulcs "\")|(cst[0-9]?))){1,5}"                       #qxs(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret)
funcs["qxw"]=n "(,((\"" rulcs "\")|(cst[0-9]?))){1,5}"                       #qxw(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret)
funcs["qaw"]=n "(,((\"" rulcs "\")|(cst[0-9]?))){1,5}"                       #qaw(n,a0,b0,c0,d0,e0,      a_,b_,c_,d_,e_,sw,ret)
funcs["qxd"]=n "(,((\"" rulcs "\")|(cst[0-9]?))){1,3}"                       #qxd(n,a0,b0,c0,      a_,b_,c_,sw,ret)

# логические функции проверки переменных -- для лучшей читаемости. Только,если переменная не равна "" (0)
funcs["v2s"]=varpat                                                          #v2s(var,         ret)
funcs["vge"]=varpat "," n                                                    #vge(var,  val,   ret)
funcs["vle"]=varpat "," n                                                    #vle(var,  val,   ret)
funcs["vgt"]=varpat "," n                                                    #vgt(var,  val,   ret)
funcs["vlt"]=varpat "," n                                                    #vlt(var,  val,   ret)
funcs["veq"]=varpat "," varpat1                                              #veq(var,  val,   ret)
funcs["vgl"]=varpat "," n "," m                                              #vgl(var,v1,v2,   ret)
funcs["vxt"]=varpat ",[-+_0-9a-z]+,[-+_0-9a-z]+"                             #vxt(var,v1,v2,   ret)
funcs["vex"]=varpat                                                          #vex(var,         ret)
funcs["vem"]=varpat                                                          #vem(var,         ret)
funcs["v2v"]="[-+_0-9a-z]+,[-+_0-9a-z]+"                                     #v2v(v1,v2        ret)
funcs["weq"]=varpat2 "," varpat2                                             #weq(var,  val,   ret)

funcs["vsyo_sy"]=n
funcs["vsje_sy"]=n
funcs["name_im_sy"]=n
funcs["name_vi_sy"]=n
funcs["name_ro_sy"]=n
funcs["name_da_sy"]=n
funcs["name_tv_sy"]=n
funcs["name_pr_sy"]=n
funcs["name_any_sy"]=n
funcs["sw_es_r_sy"]=n
funcs["sw_mn_i_sy"]=n
funcs["sw_mn_v_sy"]=n
funcs["isSing_sy"]=n
funcs["isPlur_sy"]=n

funcs["preph_vi"]=n
funcs["preph_da"]=n
funcs["preph_ro"]=n
funcs["preph_tv"]=n
funcs["preph_any"]=n
funcs["mqast_srav"]=n
funcs["mqast"]=n

for (i in funcs) { funcs[i] = "^" funcs[i] "$" }

# Функции, вызывающие ф-ции принадлежности к классу
fun_fl["Q"]=2
fun_fl["Q_"]=2
fun_fl["Q_w"]=2
fun_fl["Qb_"]=2
fun_fl["Qf_"]=2
fun_fl["Qw_"]=2
fun_fl["q"]=2
fun_fl["q_w"]=2
fun_fl["qm"]=2
fun_fl["qw_"]=2
fun_fl["qy"]=2

fun_fl["Qb"]=3
fun_fl["Qf"]=3
fun_fl["qb"]=3
fun_fl["qf"]=3
fun_fl["qir"]=3
fun_fl["qiw"]=4
fun_fl["wiq"]=4

fun_fl["qB"]=4
fun_fl["qF"]=4
fun_fl["qia"]=4
fun_fl["qiz"]=4
fun_fl["seek"]=4
fun_fl["qfba"]=3
fun_fl["qbba"]=3

fun_fl["Qist"]=fun_is["Qist"]=2
fun_fl["q_ist"]=fun_is["q_ist"]=2
fun_fl["qb_ist"]=fun_is["qb_ist"]=3


# Создать базу функций принадлежности к классу

cst="deep deep_na deep_ne deep_pa deep_pe deep_pn geo_mn geo_sr gl_aux_be gl_bue3 gl_bued gl_bum3 gl_bumn gl_buvzmn gl_ed gl_edsr gl_in gl_mn gl_naed gl_namn \
     gl_naneed gl_navzmn gl_need gl_needge gl_needmu gl_needsr gl_needze gl_nein gl_nemn gl_paed gl_paedmu gl_paedsr gl_paedze gl_pamn gl_paneed gl_pavzmn gl_pe gl_peed \
     gl_peedge gl_peedmu gl_peedsr gl_peedze gl_pein gl_pemn gl_pned gl_pnin gl_pnmn gl_po gl_poed gl_pomn gl_poneed gl_ponemn gl_popeed gl_popemn gl_popned \
     gl_popnmn gl_povzmn gl_vzed gl_vzmn ipa_abst ipa_any ipa_food ipa_gas ipa_liquid ipa_loose ipa_solid isacro isname mcop_any mcop_da mcop_edim mcop_edmu \
     mcop_edmuda mcop_edmuim mcop_edmupr mcop_edmuro mcop_edmutv mcop_edmuvi mcop_edro mcop_edsr mcop_edsrda mcop_edsrim mcop_edsrpr mcop_edsrro mcop_edsrtv \
     mcop_edsrvi mcop_edvi mcop_edze mcop_edzeda mcop_edzeim mcop_edzepr mcop_edzero mcop_edzetv mcop_edzevi mcop_im mcop_mnda mcop_mnim mcop_mnpr mcop_mnro \
     mcop_mntv mcop_mnvi mcop_pr mcop_ro mcop_tv mcop_vi mest_3e mest_any mest_da mest_ed mest_edda mest_edim mest_edmu mest_edmuda mest_edmuim mest_edmupr \
     mest_edmuro mest_edmutv mest_edmuvi mest_edpr mest_edro mest_edsr mest_edsrda mest_edsrim mest_edsrpr mest_edsrro mest_edsrtv mest_edsrvi mest_edtv mest_edvi \
     mest_edze mest_edzeda mest_edzeim mest_edzepr mest_edzero mest_edzetv mest_edzevi mest_im mest_impe mest_it mest_mn mest_mnda mest_mnim mest_mnpr mest_mnro \
     mest_mntv mest_mnvi mest_pedmuda mest_pedmuim mest_pedmupr mest_pedmuro mest_pedmutv mest_pedsrim mest_pedzeda mest_pedzeim mest_pedzero mest_pedzevi mest_pmnda \
     mest_pmnim mest_pmnpr mest_pmnro mest_pmntv mest_pr mest_ro mest_tv mest_vi mest_vip3e mezd mod_any mod_bz mod_dp mod_ed mod_mn muk_da muk_ed muk_edda muk_edim \
     muk_edmuda muk_edmuim muk_edmupr muk_edmuro muk_edmutv muk_edmuvi muk_edpr muk_edro muk_edsrda muk_edsrim muk_edsrpr muk_edsrro muk_edsrtv muk_edsrvi muk_edtv \
     muk_edvi muk_edzeda muk_edzeim muk_edzepr muk_edzero muk_edzetv muk_edzevi muk_im muk_mn muk_mnda muk_mnim muk_mnpr muk_mnro muk_mntv muk_mnvi muk_pr muk_ro \
     muk_tv muk_vi nar_any nar_cel nar_kaq nar_mest nar_napr nar_nar nar_prev nar_priq nar_spos nar_srav nar_step nar_vopr nar_vrem narph_any narph_kaq narph_napr \
     narph_priq narph_spos narph_vrem otsz_any otsz_da otsz_ed otsz_edda otsz_edim otsz_edmuda otsz_edmuim otsz_edmupr otsz_edmuro otsz_edmutv otsz_edmuvi otsz_edpr \
     otsz_edro otsz_edsrda otsz_edsrim otsz_edsrpr otsz_edsrro otsz_edsrtv otsz_edsrvi otsz_edtv otsz_edvi otsz_edzeda otsz_edzeim otsz_edzepr otsz_edzero \
     otsz_edzetv otsz_edzevi otsz_im otsz_mn otsz_mnda otsz_mnim otsz_mnpr otsz_mnro otsz_mntv otsz_mnvi otsz_mu otsz_pr otsz_ro otsz_tv otsz_vi pre_any pre_da \
     pre_im pre_pr pre_ro pre_tv pre_vi predik prem_imvipr prem_rotv prem_vidapr prem_vipr prem_virotv prem_vitv prex_da prex_im prex_pr prex_ro prex_tv prex_vi \
     prl_affix prl_any prl_da prl_ed prl_edda prl_edim prl_edmu prl_edmuda prl_edmuim prl_edmupr prl_edmuro prl_edmutv prl_edmuvi prl_edpr prl_edro prl_edsr \
     prl_edsrda prl_edsrim prl_edsrpr prl_edsrro prl_edsrtv prl_edsrvi prl_edtv prl_edvi prl_edze prl_edzeda prl_edzeim prl_edzepr prl_edzero prl_edzetv prl_edzevi \
     prl_im prl_kred prl_kred_mu prl_kred_sr prl_kred_ze prl_krmn prl_mn prl_mnda prl_mnim prl_mnpr prl_mnro prl_mntv prl_mnvi prl_neiz prl_pr prl_pvedtv prl_pvmntv \
     prl_ro prl_srav prl_tv prl_vi prq_any prq_da prq_ed prq_edda prq_edim prq_edmuda prq_edmuim prq_edmupr prq_edmuro prq_edmutv prq_edmuvi prq_edpr prq_edro \
     prq_edsrda prq_edsrim prq_edsrpr prq_edsrro prq_edsrtv prq_edsrvi prq_edtv prq_edvi prq_edzeda prq_edzeim prq_edzepr prq_edzero prq_edzetv prq_edzevi prq_im \
     prq_kred prq_kred_mu prq_kred_sr prq_kred_ze prq_krmn prq_mn prq_mnda prq_mnim prq_mnpr prq_mnro prq_mntv prq_mnvi prq_pe prq_pn prq_pr prq_ro prq_sd \
     prq_sdedmuro prq_sdedro prq_sdedsrro prq_sdmnim prq_tv prq_vi qast qast_any qast_by qast_cn qast_dt qast_hy qast_lm qast_ne qast_po qast_sg qast_us qi_duom \
     qi_duoz qi_ed qi_mn qik_da qik_edda qik_edim qik_edpr qik_edro qik_edtv qik_edvi qik_im qik_mnda qik_mnim qik_mnpr qik_mnro qik_mntv qik_mnvi qik_pr qik_ro \
     qik_tv qik_vi qin_da qin_im qin_pr qin_ro qin_tv qin_vi qip_da qip_edda qip_edim qip_edpr qip_edro qip_edtv qip_edvi qip_im qip_mnda qip_mnim qip_mnpr qip_mnro \
     qip_mntv qip_mnvi qip_pr qip_ro qip_tv qip_vi qis_da qis_im qis_pr qis_ro qis_tv qis_vi suw_any suw_da suw_ed suw_edda suw_edim suw_edme suw_edmuda suw_edmuim \
     suw_edmume suw_edmupr suw_edmuro suw_edmutv suw_edmuvi suw_edne suw_edpr suw_edro suw_edsrda suw_edsrim suw_edsrpr suw_edsrro suw_edsrvi suw_edtv suw_edvi \
     suw_edzeda suw_edzeim suw_edzeme suw_edzene suw_edzepr suw_edzero suw_edzetv suw_edzevi suw_im suw_mnda suw_mnim suw_mnne suw_mnpr suw_mnro suw_mnsq suw_mntv \
     suw_mnvi suw_noed suw_noedim suw_noedmuda suw_noedmuim suw_noedpr suw_noedro suw_noedsrda suw_noedtv suw_noedvi suw_nomn suw_nomnim suw_nomnpr suw_nomnro \
     suw_nomntv suw_nomnvi suw_odda suw_oded suw_odedda suw_odedim suw_odedmuda suw_odedpr suw_odedro suw_odedsrda suw_odedtv suw_odedvi suw_odim suw_odmn suw_odmnda \
     suw_odmnim suw_odmnro suw_odmnvi suw_odpr suw_odro suw_odtv suw_odvi suw_odzv suw_pr suw_ro suw_tv suw_vi sz sz_i sz_iili titul vvod digits vsyo_sy vsje_sy \
     name_im_sy name_vi_sy name_ro_sy name_da_sy name_tv_sy name_pr_sy name_any_sy sw_es_r_sy sw_mn_i_sy sw_mn_v_sy isSing_sy isPlur_sy preph_vi preph_da cap \
     preph_ro preph_tv preph_any prl_pv_any sz_qto sz_dge sz_kak sz_kogda pre_s mqast_srav suw_mn nes_any nes_da nes_ed nes_edda nes_edim nes_edme nes_edmuda \
     nes_edmuim nes_edmume nes_edmupr nes_edmuro nes_edmutv nes_edmuvi nes_edne nes_edpr nes_edro nes_edsrda nes_edsrim nes_edsrpr nes_edsrro nes_edsrvi nes_edtv \
     nes_edvi nes_edzeda nes_edzeim nes_edzene nes_edzepr nes_edzero nes_edzetv nes_edzevi nes_im nes_mn nes_mnda nes_mnim nes_mnne nes_mnpr nes_mnro nes_mntv \
     nes_mnvi nes_mu nes_noed nes_noedim nes_noedmuda nes_noedmuim nes_noedpr nes_noedro nes_noedsrda nes_noedtv nes_noedvi nes_nomn nes_nomnim nes_nomnpr nes_nomnro \
     nes_nomntv nes_nomnvi nes_ob nes_odda nes_oded nes_odedda nes_odedim nes_odedmuda nes_odedpr nes_odedro nes_odedsrda nes_odedtv nes_odedvi nes_odim nes_odmn \
     nes_odmnda nes_odmnim nes_odmnro nes_odmnvi nes_odpr nes_odro nes_odtv nes_odvi nes_odzv nes_pr nes_ro nes_sr nes_tv nes_vi nes_ze fam_any fam_da fam_dane \
     fam_ed fam_edda fam_edim fam_edmuda fam_edmuim fam_edmupr fam_edmuro fam_edmutv fam_edmuvi fam_edne fam_edpr fam_edro fam_edtv fam_edvi fam_edzeda fam_edzeim \
     fam_edzene fam_edzepr fam_edzero fam_edzetv fam_edzevi fam_im fam_mn fam_mnda fam_mnim fam_mnne fam_mnpr fam_mnro fam_mntv fam_mnvi fam_mu fam_ne fam_pr fam_prne \
     fam_ro fam_rone fam_tv fam_tvne fam_vi fam_vine fam_ze loc_any loc_da loc_ed loc_edda loc_edim loc_edme loc_edmuda loc_edmuim loc_edmume loc_edmupr loc_edmuro \
     loc_edmutv loc_edmuvi loc_edne loc_edpr loc_edro loc_edsrda loc_edsrim loc_edsrpr loc_edsrro loc_edsrvi loc_edtv loc_edvi loc_edzeda loc_edzeim loc_edzene \
     loc_edzepr loc_edzero loc_edzetv loc_edzevi loc_im loc_mn loc_mnda loc_mnim loc_mnne loc_mnpr loc_mnro loc_mntv loc_mnvi loc_mu loc_pr loc_ro loc_sr loc_tv \
     loc_vi loc_ze nam_any nam_da nam_dane nam_ed nam_edda nam_edim nam_edmuda nam_edmuim nam_edmupr nam_edmuro nam_edmutv nam_edmuvi nam_edne nam_edpr nam_edro \
     nam_edtv nam_edvi nam_edzeda nam_edzeim nam_edzene nam_edzepr nam_edzero nam_edzetv nam_edzevi nam_im nam_imne nam_mn nam_mnda nam_mnim nam_mnne nam_mnpr \
     nam_mnro nam_mntv nam_mnvi nam_mu nam_ob nam_odmnda nam_odmnro nam_pr nam_prne nam_ro nam_rone nam_tv nam_tvne nam_vi nam_vine nam_ze nam_zvne org_any org_da \
     org_ed org_edda org_edim org_edmuda org_edmuim org_edmupr org_edmuro org_edmutv org_edmuvi org_edne org_edpr org_edro org_edsrda org_edsrim org_edsrpr \
     org_edsrro org_edsrvi org_edtv org_edvi org_edzeda org_edzeim org_edzene org_edzepr org_edzero org_edzetv org_edzevi org_im org_mn org_mnda org_mnim org_mnne \
     org_mnpr org_mnro org_mntv org_mnvi org_mu org_pr org_ro org_sr org_tv org_vi org_ze pat_any pat_da pat_ed pat_edda pat_edim pat_edmuda pat_edmuim pat_edmupr \
     pat_edmuro pat_edmutv pat_edmuvi pat_edpr pat_edro pat_edtv pat_edvi pat_edzeda pat_edzeim pat_edzepr pat_edzero pat_edzetv pat_edzevi pat_im pat_mn pat_mnda \
     pat_mnim pat_mnpr pat_mnro pat_mntv pat_mnvi pat_mu pat_pr pat_ro pat_tv pat_vi pat_ze suw_odedne suw_noedne lnk_mn";
 stoar(cst,funarr," "); #

cst="ist_any ist_nar_mest ist_nar_napr ist_nar_spos ist_nar_vrem ist_prl_edmuim ist_prl_edmupr ist_prl_edmuvi ist_prl_edsrpr ist_prl_edzeda ist_prl_edzeim \
     ist_prl_edzepr ist_prl_edzero ist_prl_edzetv ist_prl_kred_mu ist_prl_kred_ze ist_prl_krmn ist_suw_da ist_suw_edmuda ist_suw_edmuim ist_suw_edmulo ist_suw_edmune \
     ist_suw_edmupa ist_suw_edmupr ist_suw_edmuro ist_suw_edmusq ist_suw_edmutv ist_suw_edmuvi ist_suw_edmuzv ist_suw_edsrda ist_suw_edsrim ist_suw_edsrne \
     ist_suw_edsrpr ist_suw_edsrro ist_suw_edsrtv ist_suw_edsrvi ist_suw_edsrzv ist_suw_edzeda ist_suw_edzeim ist_suw_edzelo ist_suw_edzepr ist_suw_edzero \
     ist_suw_edzetv ist_suw_edzevi ist_suw_im ist_suw_mnda ist_suw_mnim ist_suw_mnpr ist_suw_mnro ist_suw_mnvi ist_suw_pr ist_suw_ro ist_suw_tv ist_suw_vi";
 stoar(cst,funarr_ist," "); #

}

{

patsplit($0,fun,funpat,funsep);

for (i in fun) {
   kern=length(fun[i])-2;
   cfun=substr(fun[i],2,kern);

   if (cfun in funcs) {
      endadr=index(funsep[i],")");
      if (substr(funsep[i],endadr-1,1) != "\x5c") { argstr=substr(funsep[i],1,endadr-1); gsub(/,\s+/,",",argstr) };

      if (argstr !~ funcs[cfun]) {
        printf "%s%s%s%s %s%s%s%s %s\n", FILENAME, ":", FNR, ": функция", cfun, "(", argstr, ") != ", funcs[cfun]
        }

      if (cfun in fun_fl){ filn = fun_fl[cfun]; delete zlist; delete zlist3; delete zlist4
        if (cfun in fun_is) {
                    split(argstr,arga,",")
                    args=gensub("\"","","g",arga[filn])
                    inil=split(args,alist," ")
                    for(i in alist) { zlist[alist[i]]
                      if(alist[i] in funarr_ist) {}else{ if (alist[i] !~ strvals) {
                      printf "%s%s%s%s %s%s %s%s %s\n", FILENAME, ":", FNR, ": функция:", cfun, ", ошибка в аргументе", filn,":", alist[i]
                      } } }
                     if (inil != length(zlist)) {printf "%s%s%s%s %s%s\n", FILENAME, ":", FNR, ": функция:", cfun, ", вызовы функций дублируются."}

          }
          else {

              if (filn < 30) {
                        split(argstr,arga,",")
                        args=gensub("\"","","g",arga[filn])
                        inil=split(args,alist," ")
                        for(i in alist) { zlist[alist[i]]
                          if(alist[i] in funarr) {}else{ if (alist[i] !~ strvals) {
                            printf "%s%s%s%s %s%s %s%s %s\n", FILENAME, ":", FNR, ": функция:", cfun, ", ошибка в аргументе", filn,":", alist[i]
                          } } }
                        if (inil != length(zlist)) {printf "%s%s%s%s %s%s\n", FILENAME, ":", FNR, ": функция:", cfun, ", вызовы функций дублируются."}

              }
              else {

                        split(argstr,arga,",")
                        arg3=gensub("\"","","g",arga[3])
                        arg4=gensub("\"","","g",arga[4])
                        inil3=split(arg3,alist3," ")
                        inil4=split(arg4,alist4," ")
                        filn=3;
                        for(i in alist3) { zlist3[alist3[i]]
                          if(alist3[i] in funarr) {}else{ if (alist[i] !~ strvals) {
                            printf "%s%s%s%s %s%s %s%s %s\n", FILENAME, ":", FNR, ": функция:", cfun, ", ошибка в аргументе", filn,":", alist[i]
                          } } }
                        filn=4;
                        for(i in alist4) { zlist4[alist4[i]]
                          if(alist4[i] in funarr) {}else{ if (alist[i] !~ strvals) {
                            printf "%s%s%s%s %s%s %s%s %s\n", FILENAME, ":", FNR, ": функция:", cfun, ", ошибка в аргументе", filn,":", alist[i]
                          } } }
                        if (inil3 != length(zlist3)) {printf "%s%s%s%s %s%s\n", FILENAME, ":", FNR, ": функция:", cfun, ", вызовы функций дублируются в аргументе 3."}
                        if (inil4 != length(zlist4)) {printf "%s%s%s%s %s%s\n", FILENAME, ":", FNR, ": функция:", cfun, ", вызовы функций дублируются в аргументе 4."}

                    }
        }

        }

     }
}

  }
