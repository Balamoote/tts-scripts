BEGIN{

  reg = "(^.* )[drvzxDRVZX](\\[)[0-9]+(\\]\\+\\+; if\\(dbg\\){print \x22)[DRVZX][0-9]+(\x22.*)$"
    
  }{
       if ($0 ~ reg) {
           rule++
           match($0,reg,rega);
           $0 = rega[1] LETT rega[2] rule rega[3] LETT rule rega[4]
           print $0
       } else { print $0 };
    }
