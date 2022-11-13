#! /bin/bash

function f_disablemod {
  
  echo "Script: [$SCRIPT_NUM] ::: Disable misc kernel modules"

  local MOD
  MOD="bluetooth bnep btusb cpia2 firewire-core floppy n_hdlc net-pf-31 pcspkr soundcore thunderbolt usb-midi usb-storage uvcvideo v4l2_common"
  for disable in $MOD; do
    if ! grep -q "$disable" "$DISABLEMOD" 2> /dev/null; then
      echo "install $disable /bin/true" >> "$DISABLEMOD"
    fi
  done
((SCRIPT_NUM++))
}