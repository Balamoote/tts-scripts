function cmp_apostrophe(i1, v1, i2, v2) {
    # Находим позицию апострофа в каждой строке
    pos1 = index(i1, "'")
    pos2 = index(i2, "'")
    
    # Если одна строка содержит апостроф, а другая нет, строка с апострофом идет раньше
    if (pos1 && !pos2) return -1
    if (!pos1 && pos2) return 1
    
    # Если обе строки содержат апостроф, сравниваем их позиции
    if (pos1 && pos2) {
        if (pos1 < pos2) return -1  # Апостроф в i1 ближе к началу
        if (pos1 > pos2) return 1   # Апостроф в i2 ближе к началу
    }
    
    # Если апострофы на одной позиции или их нет, используем системную сортировку
    return (i1 < i2 ? -1 : (i1 > i2 ? 1 : 0))
}

BEGIN {
    PROCINFO["sorted_in"] = "@ind_str_asc"  # Сортировка строк
    FS = "[ _=]+"
}

{
    for (i = 3; i <= NF; i++) { oma[$2][$i] };

    s0=$0; gsub("ё","е",$0); gsub("'","",$0);
    for (i = 3; i <= NF; i++) { if ($2 != $i) print s0 >> "_error_OMOs" };

}

END {
    for (i in oma) {
        out = "_" i "="
        save_sort = PROCINFO["sorted_in"]  # сохраняем текущую сортировку строк
        PROCINFO["sorted_in"] = "cmp_apostrophe"  # временно меняем на кастомную для строки
        for (j in oma[i]) 
            out = out " " j
        PROCINFO["sorted_in"] = save_sort  # восстанавливаем сортировку для строк
        print out
    }
}
