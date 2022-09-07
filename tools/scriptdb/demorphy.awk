# Функции для работы с файлами, которые были обработаны SpaCy или Natasha

# все/всё 
function vsyo_sy(n,    rd,ret) { split(sepphy[i+n],sprs,"#"); rd = sprs[2]
                  if( ( rd~ "@_PRON_|@_DET_|@_ADV_" && rd~ "_Number=Sing_" ) || rd~ "@_PART__@" )                                        {ret=1}else{ret=0}; return ret }
function vsje_sy(n,    rd,ret) { split(sepphy[i+n],sprs,"#"); rd = sprs[2]
                  if( rd~ "@_DET_|@_PRON_" && rd~ "_Number=Plur_" )                                                                      {ret=1}else{ret=0}; return ret }

# имена собственные
function name_im_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~"_Case=Nom_" && rd~"_Number=Sing_")         {ret=1}else{ret=0}; return ret }
function name_vi_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~"_Case=Acc_" && rd~"_Number=Sing_")         {ret=1}else{ret=0}; return ret }
function name_ro_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~/_Case=Gen_|_Case=Acc_/&&rd~"_Number=Sing_"){ret=1}else{ret=0}; return ret }
function name_da_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~"_Case=Dat_" && rd ~"_Number=Sing_")        {ret=1}else{ret=0}; return ret }
function name_tv_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~"_Case=Ins_" && rd~ "_Number=Sing_")        {ret=1}else{ret=0}; return ret }
function name_pr_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_"&&rd~"_Case=Loc_" && rd~ "_Number=Sing_")        {ret=1}else{ret=0}; return ret }
function name_any_sy(n, rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_PROPN_" )                                               {ret=1}else{ret=0}; return ret }


# По падежам...

function sw_es_r_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_NOUN_"&&rd~"_Number=Sing_"&& rd~ "_Case=Gen_")          {ret=1}else{ret=0}; return ret }

#  
function sw_mn_i_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_NOUN_"&&rd~"_Number=Plur_"&& rd~ "_Case=Nom_")          {ret=1}else{ret=0}; return ret }
function sw_mn_v_sy(n,  rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"@_NOUN_"&&rd~"_Number=Plur_"&& rd~ "_Case=Acc_")          {ret=1}else{ret=0}; return ret }

# для обхода ошибок баз spacy единичные функции для противопоставления ОДНОГО признака, где это возможно

function isSing_sy(n,   rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"_Number=Sing_" )                                          {ret=1}else{ret=0}; return ret }
function isPlur_sy(n,   rd,ret) {split(sepphy[i+n],sprs,"#");rd=sprs[2];if(rd~"_Number=Plur_" )                                          {ret=1}else{ret=0}; return ret }



