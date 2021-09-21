#! /bin/bash

function f_ctrlaltdel {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Disabling Ctrl-alt-delete"

  systemctl mask ctrl-alt-del.target

  sed -i 's/^#CtrlAltDelBurstAction=.*/CtrlAltDelBurstAction=none/' "$SYSTEMCONF"



}