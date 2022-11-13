#! /bin/bash

function f_usbguard {
  
  echo "Script: [$SCRIPT_NUM] ::: Enable usbguard"

  apt-get install --no-install-recommends usbguard

  usbguard generate-policy > /tmp/rules.conf
  install -m 0600 -o root -g root /tmp/rules.conf /etc/usbguard/rules.conf

  systemctl enable usbguard.service
  systemctl start usbguard.service
((SCRIPT_NUM++))
}