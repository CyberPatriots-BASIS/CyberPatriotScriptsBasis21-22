#! /bin/bash

function f_prelink {
    
  echo "Script: [$SCRIPT_NUM] ::: Prelink"

  if dpkg -l | grep prelink 1> /dev/null; then
    "$(command -v prelink)" -ua 2> /dev/null
    "$APT" purge prelink
  fi

  ((SCRIPT_NUM++))
}