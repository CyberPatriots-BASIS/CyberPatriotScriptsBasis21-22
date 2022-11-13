function f_resolvedconf {
  echo "[$SCRIPT_COUNT] Systemd/resolved.conf"

  local dnsarray
  local dnslist

  mapfile -t dnsarray < <( grep ^nameserver /etc/resolv.conf | sed 's/^nameserver\s//g' )
  dnslist=${dnsarray[*]}

  if [ ${#dnsarray[@]} -lt 2 ]; then
    dnslist="$dnslist 1.1.1.1"
  fi

  sed -i '/^nameserver/d' /etc/resolv.conf

  for n in $dnslist; do
    echo "nameserver $n" >> /etc/resolv.conf
  done

  if ! [[ -f "$RESOLVEDCONF" ]]; then
    $APT install --no-install-recommends systemd-resolved
  fi

  sed -i "s/^#DNS=.*/DNS=$dnslist/" "$RESOLVEDCONF"
  sed -i "s/^#FallbackDNS=.*/FallbackDNS=1.0.0.1/" "$RESOLVEDCONF"
  sed -i "s/^#DNSSEC=.*/DNSSEC=allow-downgrade/" "$RESOLVEDCONF"
  sed -i "s/^#DNSOverTLS=.*/DNSOverTLS=opportunistic/" "$RESOLVEDCONF"

  sed -i '/^hosts:/ s/files dns/files resolve dns/' /etc/nsswitch.conf

  systemctl daemon-reload

  if [[ $VERBOSE == "Y" ]]; then
    journalctl -r -n10 -u systemd-resolved --no-pager
    echo
  fi

  ((SCRIPT_NUM++))
}