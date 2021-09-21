#! /bin/bash

function f_apport {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Disable apport, ubuntu-report and popularity-contest"

  if command -v gsettings 2>/dev/null 1>&2; then
    gsettings set com.ubuntu.update-notifier show-apport-crashes false
  fi

  if command -v ubuntu-report 2>/dev/null 1>&2; then
    ubuntu-report -f send no
  fi

  if [ -f /etc/default/apport ]; then
    sed -i 's/enabled=.*/enabled=0/' /etc/default/apport
    systemctl stop apport.service
    systemctl mask apport.service
  fi

  if dpkg -l | grep -E '^ii.*popularity-contest' 2>/dev/null 1>&2; then
    $APT purge popularity-contest
  fi

  systemctl daemon-reload

}