#!/bin/bash

test_con () {
  for run in {1 .. 5} 
  do
    if ping -q -c 1 -W 1 $1 >/dev/null; then
      myLogger "4" "test_con" "connection"
      break
    else
      myLogger "2" "test_con" "try $run"
    fi;
      myLogger "1" "test_con" "connection"
      exit 1
  done
}
