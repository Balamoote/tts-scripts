BEGIN {

  formcount = 3
  deepcount = 1
  maxcount  = 6

PROCINFO["sorted_in"]="@ind_str_asc"
cmd="rm _*.txt 2>/dev/null"
system(cmd); close(cmd);
  }
{

if ( $3 ~ "#" ) { split($3, arr, "#");
  bf[arr[1]]++; bf[arr[2]]++;
  deep[arr[1]]; deep[arr[2]];

  if ( $2 ~ /^прл_/ ) { deep[arr[1]]++; deep[arr[2]]++ };

# if ( $2 ~ /^прч_/ ) {
#   if ( $2 ~ /_2вид_непер_воз_наст/ )    { prq01[arr[1]]++; prq01[arr[2]]++ };
#   if ( $2 ~ /_2вид_непер_воз_прош/ )    { prq02[arr[1]]++; prq02[arr[2]]++ };
#   if ( $2 ~ /_2вид_непер_наст/ )        { prq03[arr[1]]++; prq03[arr[2]]++ };
#   if ( $2 ~ /_2вид_непер_прош/ )        { prq04[arr[1]]++; prq04[arr[2]]++ };
#   if ( $2 ~ /_2вид_перех_наст/ )        { prq05[arr[1]]++; prq05[arr[2]]++ };
#   if ( $2 ~ /_2вид_перех_прош/ )        { prq06[arr[1]]++; prq06[arr[2]]++ };
#   if ( $2 ~ /_2вид_перех_страд_наст/ )  { prq07[arr[1]]++; prq07[arr[2]]++ };
#   if ( $2 ~ /_2вид_перех_страд_прош/ )  { prq08[arr[1]]++; prq08[arr[2]]++ };
#   if ( $2 ~ /_2вид_перне_наст/ )        { prq09[arr[1]]++; prq09[arr[2]]++ };
#   if ( $2 ~ /_2вид_перне_прош/ )        { prq10[arr[1]]++; prq10[arr[2]]++ };
#   if ( $2 ~ /_несов_непер_воз_наст/ )   { prq11[arr[1]]++; prq11[arr[2]]++ };
#   if ( $2 ~ /_несов_непер_воз_прош/ )   { prq12[arr[1]]++; prq12[arr[2]]++ };
#   if ( $2 ~ /_несов_непер_наст/ )       { prq13[arr[1]]++; prq13[arr[2]]++ };
#   if ( $2 ~ /_несов_непер_прош/ )       { prq14[arr[1]]++; prq14[arr[2]]++ };
#   if ( $2 ~ /_несов_перех_наст/ )       { prq15[arr[1]]++; prq15[arr[2]]++ };
#   if ( $2 ~ /_несов_перех_прош/ )       { prq16[arr[1]]++; prq16[arr[2]]++ };
#   if ( $2 ~ /_несов_перех_страд_наст/ ) { prq17[arr[1]]++; prq17[arr[2]]++ };
#   if ( $2 ~ /_несов_перех_страд_прош/ ) { prq18[arr[1]]++; prq18[arr[2]]++ };
#   if ( $2 ~ /_несов_перне_наст/ )       { prq19[arr[1]]++; prq19[arr[2]]++ };
#   if ( $2 ~ /_несов_перне_прош/ )       { prq20[arr[1]]++; prq20[arr[2]]++ };
#   if ( $2 ~ /_сов_непер_воз_прош/ )     { prq21[arr[1]]++; prq21[arr[2]]++ };
#   if ( $2 ~ /_сов_непер_прош/ )         { prq22[arr[1]]++; prq22[arr[2]]++ };
#   if ( $2 ~ /_сов_непер_страд_прош/ )   { prq23[arr[1]]++; prq23[arr[2]]++ };
#   if ( $2 ~ /_сов_перех_прош/ )         { prq24[arr[1]]++; prq24[arr[2]]++ };
#   if ( $2 ~ /_сов_перех_страд_прош/ )   { prq25[arr[1]]++; prq25[arr[2]]++ };
#   if ( $2 ~ /_сов_перне_прош/ )         { prq26[arr[1]]++; prq26[arr[2]]++ };

# }

  } else {

  bf[$3]++;
  deep[$3]
  if ( $2 ~ /^prl_/ ) { deep[$3]++ };

# if ( $2 ~ /^прч_/ ) {
#   if ( $2 ~ /_2вид_непер_воз_наст/ )    { prq01[$3]++ };
#   if ( $2 ~ /_2вид_непер_воз_прош/ )    { prq02[$3]++ };
#   if ( $2 ~ /_2вид_непер_наст/ )        { prq03[$3]++ };
#   if ( $2 ~ /_2вид_непер_прош/ )        { prq04[$3]++ };
#   if ( $2 ~ /_2вид_перех_наст/ )        { prq05[$3]++ };
#   if ( $2 ~ /_2вид_перех_прош/ )        { prq06[$3]++ };
#   if ( $2 ~ /_2вид_перех_страд_наст/ )  { prq07[$3]++ };
#   if ( $2 ~ /_2вид_перех_страд_прош/ )  { prq08[$3]++ };
#   if ( $2 ~ /_2вид_перне_наст/ )        { prq09[$3]++ };
#   if ( $2 ~ /_2вид_перне_прош/ )        { prq10[$3]++ };
#   if ( $2 ~ /_несов_непер_прош/ )       { prq14[$3]++ };
#   if ( $2 ~ /_несов_перех_наст/ )       { prq15[$3]++ };
#   if ( $2 ~ /_сов_непер_прош/ )         { prq22[$3]++ };
#   if ( $2 ~ /_сов_непер_страд_прош/ )   { prq23[$3]++ };

#   if ( $2 ~ /_несов_непер_воз_прош/ )   { prq12[$3]++ };
#   if ( $2 ~ /_несов_перех_прош/ )       { prq16[$3]++ };
#   if ( $2 ~ /_несов_перне_наст/ )       { prq19[$3]++ };
#   if ( $2 ~ /_несов_непер_воз_наст/ )   { prq11[$3]++ };
#   if ( $2 ~ /_несов_непер_наст/ )       { prq13[$3]++ };
#   if ( $2 ~ /_несов_перех_страд_наст/ ) { prq17[$3]++ };
#   if ( $2 ~ /_несов_перех_страд_прош/ ) { prq18[$3]++ };
#   if ( $2 ~ /_несов_перне_прош/ )       { prq20[$3]++ };
#   if ( $2 ~ /_сов_непер_воз_прош/ )     { prq21[$3]++ };
#   if ( $2 ~ /_сов_перех_прош/ )         { prq24[$3]++ };
#   if ( $2 ~ /_сов_перех_страд_прош/ )   { prq25[$3]++ };
#   if ( $2 ~ /_сов_перне_прош/ )         { prq26[$3]++ };

# }

}

  }

  END {

for (j=1;j<=maxcount;j++) {
   for ( i in bf ) { if (bf[i] == j) printf("%s\n", i) >> "_" j ".txt"  }

 }
#  for ( i in deep ) { if (deep[i] < deepcount) printf("%s\n", i) >> "_deep.txt" }
    
#  for ( i in prq01 ) { if (prq01[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_непер_воз_наст.\\{-}",    i, prq01[i])  }
#  for ( i in prq02 ) { if (prq02[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_непер_воз_прош.\\{-}",    i, prq02[i])  }
#  for ( i in prq03 ) { if (prq03[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_непер_наст.\\{-}",        i, prq03[i])  }
#  for ( i in prq04 ) { if (prq04[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_непер_прош.\\{-}",        i, prq04[i])  }
#  for ( i in prq05 ) { if (prq05[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перех_наст.\\{-}",        i, prq05[i])  }
#  for ( i in prq06 ) { if (prq06[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перех_прош.\\{-}",        i, prq06[i])  }
#  for ( i in prq07 ) { if (prq07[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перех_страд_наст.\\{-}",  i, prq07[i])  }
#  for ( i in prq08 ) { if (prq08[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перех_страд_прош.\\{-}",  i, prq08[i])  }
#  for ( i in prq09 ) { if (prq09[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перне_наст.\\{-}",        i, prq09[i])  }
#  for ( i in prq10 ) { if (prq10[i] <= formcount) printf("%s %s%s %s\n", i, "_2вид_перне_прош.\\{-}",        i, prq10[i])  }
#  for ( i in prq11 ) { if (prq11[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_непер_воз_наст.\\{-}",   i, prq11[i])  }
#  for ( i in prq12 ) { if (prq12[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_непер_воз_прош.\\{-}",   i, prq12[i])  }
#  for ( i in prq13 ) { if (prq13[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_непер_наст.\\{-}",       i, prq13[i])  }
#  for ( i in prq14 ) { if (prq14[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_непер_прош.\\{-}",       i, prq14[i])  }
#  for ( i in prq15 ) { if (prq15[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перех_наст.\\{-}",       i, prq15[i])  }
#  for ( i in prq16 ) { if (prq16[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перех_прош.\\{-}",       i, prq16[i])  }
#  for ( i in prq17 ) { if (prq17[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перех_страд_наст.\\{-}", i, prq17[i])  }
#  for ( i in prq18 ) { if (prq18[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перех_страд_прош.\\{-}", i, prq18[i])  }
#  for ( i in prq19 ) { if (prq19[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перне_наст.\\{-}",       i, prq19[i])  }
#  for ( i in prq20 ) { if (prq20[i] <= formcount) printf("%s %s%s %s\n", i, "_несов_перне_прош.\\{-}",       i, prq20[i])  }
#  for ( i in prq21 ) { if (prq21[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_непер_воз_прош.\\{-}",     i, prq21[i])  }
#  for ( i in prq22 ) { if (prq22[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_непер_прош.\\{-}",         i, prq22[i])  }
#  for ( i in prq23 ) { if (prq23[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_непер_страд_прош.\\{-}",   i, prq23[i])  }
#  for ( i in prq24 ) { if (prq24[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_перех_прош.\\{-}",         i, prq24[i])  }
#  for ( i in prq25 ) { if (prq25[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_перех_страд_прош.\\{-}",   i, prq25[i])  }
#  for ( i in prq26 ) { if (prq26[i] <= formcount) printf("%s %s%s %s\n", i, "_сов_перне_прош.\\{-}",         i, prq26[i])  }
cmd="wc -l _*.txt"
system(cmd); close(cmd);

    }
