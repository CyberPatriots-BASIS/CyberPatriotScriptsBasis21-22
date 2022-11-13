#! /bin/bash

function f_adduser {
 
  echo "Script: [$SCRIPT_NUM] Configure useradd and adduser to set /bin/false as default shell, home directory permissions to 0750 and lock users 30 days after password expires."

  sed -i 's/DIR_MODE=.*/DIR_MODE=0750/' "$ADDUSER"
  sed -i 's/DSHELL=.*/DSHELL=\/bin\/false/' "$ADDUSER"
  sed -i 's/USERGROUPS=.*/USERGROUPS=yes/' "$ADDUSER"

  sed -i 's/SHELL=.*/SHELL=\/bin\/false/' "$USERADD"
  sed -i 's/^# INACTIVE=.*/INACTIVE=30/' "$USERADD"

  awk -F ':' '{if($3 >= 1000 && $3 <= 65000) print $6}' /etc/passwd | while read -r userhome; do
    chmod 0750 "$userhome"
  done
   ((SCRIPT_NUM++))
}