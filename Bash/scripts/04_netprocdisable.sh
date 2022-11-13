#! /bin/bash

function f_netprocdisable {
  

  echo "Script: [$SCRIPT_NUM] ::: Disabling all bad network protocols."

  echo "Script: [$SCRIPT_NUM] ::: Disabling \"dccp" "sctp" "rds" "tipc\""

  local NET
  NET="dccp sctp rds tipc"
  for disable in $NET; do
    if ! grep -q "$disable" "$DISABLENET" 2> /dev/null; then
      echo "install $disable /bin/true" >> "$DISABLENET"
    fi
  done

  ((SCRIPT_NUM++))
}