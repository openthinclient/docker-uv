#!/bin/bash

check () {
   case $1 in
   -f)
     if [ $2 -ne 0 ]; then
         myLogger "1" "$3" "$4"
     else
         myLogger "4" "$3" "$4"
     fi;
     shift
     ;;
    --cf)
     if [ $2 -ne 0 ]; then
         myLogger "1" "$3" "$4"
         exit 1
     else
         myLogger "4" "$3" "$4"
     fi;
     shift
     ;;
   -e)
     if [ -e $2 ]; then
         myLogger "1" "$3" "$4" 
     else
         myLogger "4" "$3" "$4"
     fi;
     shift
     ;;  
   --enc)
     [ ! -e $2 ] && myLogger "2" "$3" "$4" \
     || myLogger "4" "$3" "$4"
     shift
     ;;
   *)     
     printf "not implementet yet\n"
     ;; 
   esac
} 
