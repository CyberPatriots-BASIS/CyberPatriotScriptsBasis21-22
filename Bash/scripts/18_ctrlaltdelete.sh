#! /bin/bash

function f_ctrlaltdel {
  echo "[$SCRIPT_COUNT] Ctrl-alt-delete"

  systemctl mask ctrl-alt-del.target

  sed -i 's/^#CtrlAltDelBurstAction=.*/CtrlAltDelBurstAction=none/' "$SYSTEMCONF"

  if [[ $VERBOSE == "Y" ]]; then
    systemctl status ctrl-alt-del.target --no-pager
    echo
  fi

  ((SCRIPT_COUNT++))
}