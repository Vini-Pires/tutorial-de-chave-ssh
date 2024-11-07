#!/bin/bash

i=0
while [ $i -ne 9 ] ; do
  read -p "teste: " res
  case $res in
    [Yy] ) 
      echo "yes"
      read -p " 1 2" num
      case $num in
        1) echo "Num 1" ;;
        * ) echo "continuando" ; true ;;
      esac
    ;;
    * ) i=9 ; continue ;;
  esac

  echo "Passei"
done

# exa -A
# if [ ! $? = 0 ] ; then
#   echo "Opa"
#   exit 1;
# fi

# echo "Passou?"

# read -p "num" num

# i=0
# while [ $i -lt 4 ]; do echo "conta $i" ; i=$[$i * 2] ; done
# while [ $i -lt 4 ] ;
#   do
#     echo "conta $i";
#     i=$[$i+1];
# done

# case $num in
#   1) echo "um" ;;
#   2) echo "treaux";;
#   3) echo "2";;
#   *) return 1;;
# esac

# t=10
# for i in $(seq 10) ; do
#   result=$(($i * $t))
#   echo "$i * $t = $result"
# done

# for i in 1 2 3 4 5; do
#   echo "counter: $i"
# done
