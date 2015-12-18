#!/bin/bash

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m'

myLogger () {
local head='%-10s%-25s%-35s'
    case $1 in
    1)
        head="${head}${Red}%8s${NC}\n"
        printf $head "ERROR:" "func: $2" "expr: $3" "[failed]"
        shift
        ;;
    2)
        head="${head}${Yellow}%8s${NC}\n"
        printf $head "WARNING:" "func: $2" "expr: $3" "[warn]"
        shift
        ;;
    3)
        head="${head}${Yellow}%8s${NC}\n"
        printf $head "INFO:" "func: $2" "expr: $3" "[debug]"
        shift
        ;;
    4)
        head="${head}${Green}%8s${NC}\n"
        printf $head "OK:" "func: $2" "expr: $3" "[OK]"
        shift
        ;;
    *)
        printf "log level not defined"
    ;;
    esac
}
