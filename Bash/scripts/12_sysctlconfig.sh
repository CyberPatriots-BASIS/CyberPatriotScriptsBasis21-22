#! /bin/bash

function f_sysctl {
  echo "Script: [$SCRIPT_NUM] ::: Configure $SYSCTL"

  cp "$SYSCTL_CONF" "$SYSCTL"

  sed -i '/net.ipv6.conf.eth0.accept_ra_rtr_pref/d' "$SYSCTL"

  for n in $($ARPBIN -n -a | awk '{print $NF}' | sort | uniq); do
    echo "net.ipv6.conf.$n.accept_ra_rtr_pref = 0" >> "$SYSCTL"
  done

  chmod 0600 "$SYSCTL"
  systemctl restart systemd-sysctl

  ((SCRIPT_COUNT++))
}