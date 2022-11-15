#! /bin/bash

function f_lockroot {
  
  echo "Script: [$SCRIPT_NUM] ::: Lock root account"

  usermod -s /sbin/nologin root
  ((SCRIPT_NUM++))
}