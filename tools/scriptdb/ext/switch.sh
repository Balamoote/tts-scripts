#!/bin/bash
# При работе с версиями файла позволяет переключать между 2-мя версиями файла.
# Перед запуском удалить $file

file="x4707.awk"          # имя основного файла
file1="x4707_prun.awk"    # имя версии 1
file2="x4707_full.awk"    # имя версии 2
pformat=

if [[ ! -L $file && -e $file ]]; then
   printf "\e[91m%s \e[93m%s \e[36m%s\e[0m\n" "Exit:" $file "is not a symlink"
   exit
fi

if [[ ! -e $file ]]; then
   ln -s $file2 $file
fi

if [[ -L $file && -e $file ]]; then

   base_name=$(basename $(readlink -f $file))
   rm $file
 
   if [[ $base_name = $file1 ]]; then
      ln -s $file2 $file
      printf "\e[36m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n" "Symlink:" $file "<---" $file2
      exit
   fi
  
   if [[ $base_name = $file2 ]]; then
      ln -s $file1 $file
      printf "\e[36m%s \e[93m%s \e[32m%s \e[93m%s\e[0m\n" "Symlink:" $file "<---" $file1
      exit
   fi
fi
