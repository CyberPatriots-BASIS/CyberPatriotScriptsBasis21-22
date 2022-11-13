#! /bin/bash

function f_timesyncd {
    

  echo "Script: [$SCRIPT_NUM] ::: Systemd/timesyncd.conf"

  local LATENCY
  local SERVERS
  local SERVERARRAY
  local FALLBACKARRAY
  local TMPCONF

  APPLY="YES"
  CONF="$TIMESYNCD"
  FALLBACKARRAY=()
  FALLBACKSERV=0
  LATENCY="50"
  NUMSERV=0
  SERVERARRAY=()
  SERVERS="4"
  TMPCONF=$(mktemp --tmpdir ntpconf.XXXXX)

  if [[ -z "$NTPSERVERPOOL" ]]; then
    local NTPSERVERPOOL
    NTPSERVERPOOL="0.ubuntu.pool.ntp.org 1.ubuntu.pool.ntp.org 2.ubuntu.pool.ntp.org 3.ubuntu.pool.ntp.org pool.ntp.org"
  fi

  echo "[Time]" > "$TMPCONF"

  PONG="ping -c2"

  # shellcheck disable=2086
  while read -r s; do
    if [[ $NUMSERV -ge $SERVERS ]]; then
      break
    fi

    local PINGSERV
    PINGSERV=$($PONG "$s" | grep 'rtt min/avg/max/mdev' | awk -F "/" '{printf "%.0f\n",$6}')
    if [[ $PINGSERV -gt "1" && $PINGSERV -lt "$LATENCY" ]]; then
      OKSERV=$(nslookup "$s"|grep "name = " | awk '{print $4}'|sed 's/.$//')
      # shellcheck disable=2143
      # shellcheck disable=2243
      # shellcheck disable=2244
      if [[ $OKSERV && $NUMSERV -lt $SERVERS && ! (( $(grep "$OKSERV" "$TMPCONF") )) ]]; then
        echo "$OKSERV has latency < $LATENCY"
        SERVERARRAY+=("$OKSERV")
        ((NUMSERV++))
      fi
    fi
  done <<< "$(dig +noall +answer +nocomments $NTPSERVERPOOL | awk '{print $5}')"

  for l in $NTPSERVERPOOL; do
    if [[ $FALLBACKSERV -le "2" ]]; then
      FALLBACKARRAY+=("$l")
      ((FALLBACKSERV++))
    else
      break
    fi
  done

  if [[ ${#SERVERARRAY[@]} -le "2" ]]; then
    for s in $(echo "$NTPSERVERPOOL" | awk '{print $(NF-1),$NF}'); do
      SERVERARRAY+=("$s")
    done
  fi

  {
    echo "NTP=${SERVERARRAY[*]}"
    echo "FallbackNTP=${FALLBACKARRAY[*]}"
    echo "RootDistanceMaxSec=1"
  } >> "$TMPCONF"

  if [[ $APPLY = "YES" ]]; then
    cat "$TMPCONF" > "$CONF"
    systemctl restart systemd-timesyncd
    rm "$TMPCONF"
  else
    echo "Configuration saved to $TMPCONF."
  fi



  

  ((SCRIPT_NUM++))
}