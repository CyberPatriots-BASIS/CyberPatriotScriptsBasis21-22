#! /bin/bash

function f_psad {
  
  echo "Script: [$SCRIPT_NUM] ::: Enable psad"

  if ! test -f "$PSADCONF"; then
    echo "$PSADCONF does not exist."

    if ! dpkg -l | grep psad 2> /dev/null 1>&2; then
      echo 'psad package is not installed.'
      sudo apt install psad
    fi

    return
  fi

  echo "127.0.0.1    0;" >> "$PSADDL"
  echo "$SERVERIP    0;" >> "$PSADDL"
  sed -i "s/EMAIL_ADDRESSES             root@localhost;/EMAIL_ADDRESSES             $ADMINEMAIL;/" "$PSADCONF"
  sed -i "s/HOSTNAME                    _CHANGEME_;/HOSTNAME                    $(hostname --fqdn);/" "$PSADCONF"
  sed -i 's/ENABLE_AUTO_IDS             N;/ENABLE_AUTO_IDS               Y;/' "$PSADCONF"
  sed -i 's/DANGER_LEVEL2               15;/DANGER_LEVEL2               15;/' "$PSADCONF"
  sed -i 's/DANGER_LEVEL3               150;/DANGER_LEVEL3               150;/' "$PSADCONF"
  sed -i 's/DANGER_LEVEL4               1500;/DANGER_LEVEL4               1500;/' "$PSADCONF"
  sed -i 's/DANGER_LEVEL5               10000;/DANGER_LEVEL5               10000;/' "$PSADCONF"
  sed -i 's/EMAIL_ALERT_DANGER_LEVEL    1;/EMAIL_ALERT_DANGER_LEVEL    5;/' "$PSADCONF"
  sed -i 's/EMAIL_LIMIT                 0;/EMAIL_LIMIT                 5;/' "$PSADCONF"
  sed -i 's/EXPECT_TCP_OPTIONS             *;/EXPECT_TCP_OPTIONS             Y;/' "$PSADCONF"
  sed -i 's/ENABLE_MAC_ADDR_REPORTING   N;/ENABLE_MAC_ADDR_REPORTING   Y;/' "$PSADCONF"
  sed -i 's/AUTO_IDS_DANGER_LEVEL       5;/AUTO_IDS_DANGER_LEVEL       1;/' "$PSADCONF"
  sed -i 's/ENABLE_AUTO_IDS_EMAILS      ;/ENABLE_AUTO_IDS_EMAILS      Y;/' "$PSADCONF"
  sed -i 's/IGNORE_PORTS             *;/IGNORE_PORTS             NONE;/' "$PSADCONF"
  sed -i 's/IPT_SYSLOG_FILE             \/var\/log\/messages;/IPT_SYSLOG_FILE             \/var\/log\/syslog;/' "$PSADCONF"
  sed -i 's/SIG_UPDATE_URL              http:\/\/www.cipherdyne.org\/psad\/signatures;/SIG_UPDATE_URL              https:\/\/www.cipherdyne.org\/psad\/signatures;/'  "$PSADCONF"

  psad --sig-update
  psad -H
  psad --fw-analyze
((SCRIPT_NUM++))
}