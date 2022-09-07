# Утилита для:
# - сортировки строк типа cst="стр3 стр1 стр2" в строки cst="стр1 стр2 стр3"
# - выравнивание условий в if-конструкции
# 
# Для приведения в порядок скриптов awk с их списками вариантов поисковых строк:
# 
#   awk -f beautify.awk deomo.awk > deomo.awk_sorted
#   или
#   ./hclean.awk -ord  -- "причесать" все скрипты
#
# Последняя версия файла находится тут: https://github.com/Balamoote/tts-scripts
function sortchunk(chunk, sep,     ret, charr, chars, i, chnum)
{        split(chunk, charr, sep); for ( i in charr ) { chars[charr[i]] = charr[i] }; chnum = asort(chars);
         ret = chars[1]; for ( i = 2; i <= chnum; i++ ) { ret = ret sep chars[i] }; return ret }
function wrap(text,wr,pad,   qu, wy, nx) { pad = sprintf("%" pad "s","");
         while (text) { qu = match(text, / |$/); wy += qu
            if (wy > wr) { nx = nx " \\\n" pad; wy = qu-1 } else if (nx) nx = nx FS;
            nx = nx substr(text,1,qu-1); text = substr(text,qu+1) }; return nx
}
BEGIN { 
        PROCINFO["sorted_in"]="@ind_num_asc"
        RS = "\n";
#       reg  = "^\\s*cst[0-9]*=\x22[-А-ЯЁёа-я0-9 ]+\x22;$";
        reg  = "^\\s*cst[0-9]*=\x22[^\x22]+\x22;$";
#       reg_ = "^\\s*cst[0-9]*=\x22[-А-ЯЁёа-я0-9 ]+\x22$";
        reg_ = "^\\s*cst[0-9]*=\x22[^\x22]+\x22$";
        ifreg= "^\\s*if[ !(]*[A-Za-z_0-9]+\\("; 
        LW = 160;
      }
{ 
  if ($0 ~ /^\s+cst[0-9]*=\x22[^\\"]+\\$/) {
     num++; book[num] = gensub(/\\$/," ","g", $0);
     while ($0 ~ /\\$/) {
           getline;
           book[num] = book[num] " " gensub(/\\$/," ","g", $0);
                        };

     } else {  num++; book[num] = $0 };

# print substr($0,sl,1)
# num++; book[num] = $0
}

END {

 for (i in book) {

   gsub(/\s*$/,"",book[i]);

   # Блок сортировки строк cst
   b = book[i];
   if (b ~ reg_ ) { b = b ";" };
   if (b ~ reg  ) {

        match( b, /cst[0-9]*=\x22/ );
        sp = RSTART+RLENGTH
        fp = length(b) - 1
        chunk = sortchunk(substr(b, sp, fp-sp), " ");
        chunk = wrap(chunk,LW,sp-1)
        
        book[i] = substr(b, 1, sp-1) chunk substr(b, fp);

    };

    # Блок выравнивания условий внутри if-конструкции
    b = book[i]; 
    if (b ~ ifreg && iffy == "" && bracket == "" && b !~ "{.*$") { match(b,ifreg); bracket = RSTART+RLENGTH-1; iffy = 1; continue };
    if (b ~ /{/ ) { bracket=iffy=pad=RSTART=RLENGTH=""; continue };

    if ( iffy == 1 && b !~ /^\s*{/ ) {
       if ( bracket ) { 
           sub(/^\s*/,"",b);
           match( b, /^\s*[!( ]*[a-zA-Z_0-9]+\(/ );
           lfun = RSTART+RLENGTH-1;
           lpad = bracket-lfun;
           if ( lpad >= 0 ) { pad  = sprintf("%" lpad "s","") } else {
                              pad  = sprintf("%" lfun "s","") };
           book[i] = pad b;
       };
     };
       
  };

  for(i in book) { print book[i] };

}
