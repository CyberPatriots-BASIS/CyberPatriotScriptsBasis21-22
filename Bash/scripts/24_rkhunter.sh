#! /bin/bash

function f_rkhunter {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Enable rkhunter"

  sed -i 's/^CRON_DAILY_RUN=.*/CRON_DAILY_RUN="yes"/' "$RKHUNTERCONF"
  sed -i 's/^APT_AUTOGEN=.*/APT_AUTOGEN="yes"/' "$RKHUNTERCONF"

  rkhunter --propupd

}