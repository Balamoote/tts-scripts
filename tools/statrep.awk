# Обработать и отсортировать вывод дебажного массива (см. dbgstat = 0|1 в main.awk и аргументы DO_DEBUG() в конце deomo.awk)
# Пример: awk -f statrep.awk _Z.txt > _z.txt
# Полученный _Z.txt использовать с scriptdb/mute_mark.awk 
{

z=substr($1,1,1);
n=substr($1,2);
a[n] = a[n] + $3

}
END { 
  for (i=1; i<=1402; i++) {
      if ( a[i] ) { print z i, "=", a[i]} else {print z i, "=", "empty" }
  }
 }
