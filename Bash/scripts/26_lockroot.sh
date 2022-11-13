#! /bin/bash

function f_lockroot {
  
  echo "Script: [$SCRIPT_NUM] ::: Lock root account"

  usermod -L root
  passwd -l root
  ((SCRIPT_NUM++))
}