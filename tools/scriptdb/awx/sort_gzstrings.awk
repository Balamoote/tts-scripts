BEGIN {

  PROCINFO["sorted_in"]="@ind_num_asc";
  pad = 3;
  max_len = 170;
  padding = sprintf("%" pad "s", "");

}{
  line=current_len=""; delete words;
    if ( NF > 3 && $NF == "[=" ) {
      print $1 "    " $2 " " $3 " [=";
      do { getline;
        for ( i=1; i<=NF; i++) { if ($i != "=]") words[$i] }
      } while ( $NF != "=]");
      for (word in words) {
        if (current_len + length(word) + ( current_len > 0 ? 1 : 0 ) > max_len ) {
            print line;
            line = padding word;
            current_len = length(line)
        } else {
            line = ( current_len > 0 ) ? line " " word : padding word;
            current_len += length(word) + ( current_len > 0 ? 1 : 0);
          };}
       if ( line != "" ) print line "\n" padding "=]\n";
    }
    else {
      if ( line != "" ) print $0
    }
  }
