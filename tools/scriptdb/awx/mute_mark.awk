# взять вывод statrep.awk и отметить несработавшие правила Z R V и т.д.
# использовать с результатом работы скрипта ../statrep.awk
# Пример: awk -f mute_mark.awk zamok.awk > zamok_1.awk , после чего искать по #mute -- это не сработавшие правила
BEGIN {
   cmd = "cat _z.txt";
   while ((cmd|getline) > 0) {

         em[substr($1,2)] = $3

#     if ($3 == "empty"  ) { em[substr($1,2)] };
 
  }}

  {

#   targ = gensub(/^.*V\[([0-9]+)\]\+\+;.*$/,"\\1","g",$0)
#   targ = gensub(/^.*R\[([0-9]+)\]\+\+;.*$/,"\\1","g",$0)
    targ = gensub(/^.*Z\[([0-9]+)\]\+\+;.*$/,"\\1","g",$0)

    if ( targ in em ) {
      if ( em[targ] == "empty" ) { print $0, "#mute" }
      else { print $0, "#hit_" em[targ] };
    } else { print $0 };

    }
