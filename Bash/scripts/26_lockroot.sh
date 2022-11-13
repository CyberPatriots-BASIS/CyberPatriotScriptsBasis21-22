#! /bin/bash

function f_lockroot {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Lock root account"

  usermod -L root
  passwd -l root
}