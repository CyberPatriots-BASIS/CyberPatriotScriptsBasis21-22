#! /bin/bash

function f_systemdconfig {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Editing Systemd config to have most secure settings"

  sed -i 's/^#DumpCore=.*/DumpCore=no/' "/etc/systemd/system.conf"
  sed -i 's/^#CrashShell=.*/CrashShell=no/' "/etc/systemd/system.conf"
  sed -i 's/^#DefaultLimitCORE=.*/DefaultLimitCORE=0/' "/etc/systemd/system.conf"
  sed -i 's/^#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1024/' "/etc/systemd/system.conf"
  sed -i 's/^#DefaultLimitNPROC=.*/DefaultLimitNPROC=1024/' "/etc/systemd/system.conf"
  sed -i 's/^#DefaultLimitCORE=.*/DefaultLimitCORE=0/' "$USERCONF"
  sed -i 's/^#DefaultLimitNOFILE=.*/DefaultLimitNOFILE=1024/' "$USERCONF"
  sed -i 's/^#DefaultLimitNPROC=.*/DefaultLimitNPROC=1024/' "$USERCONF"

  echo "Script: [$SCRIPT_NUM] ::: Reloading systemctl daemon"

  systemctl daemon-reload
((SCRIPT_NUM++))
}