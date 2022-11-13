#! /bin/bash

function f_rkhunter {
 
  echo "Script: [$SCRIPT_NUM] ::: Enable rkhunter"

  sed -i 's/^CRON_DAILY_RUN=.*/CRON_DAILY_RUN="yes"/' "$RKHUNTERCONF"
  sed -i 's/^APT_AUTOGEN=.*/APT_AUTOGEN="yes"/' "$RKHUNTERCONF"

  rkhunter --propupd
 ((SCRIPT_NUM++))
}