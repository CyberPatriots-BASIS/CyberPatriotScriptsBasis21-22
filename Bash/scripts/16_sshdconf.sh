# /bin/bash

function f_sshdconfig {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Configuring $SSHDFILE to be as secure as possible."

  awk '$5 >= 3071' /etc/ssh/moduli > /etc/ssh/moduli.tmp
  mv /etc/ssh/moduli.tmp /etc/ssh/moduli

  cp "$SSHDFILE" "$SSHDFILE-$(date +%s)"

  sed -i '/HostKey.*ssh_host_dsa_key.*/d' "$SSHDFILE"
  sed -i '/KeyRegenerationInterval.*/d' "$SSHDFILE"
  sed -i '/ServerKeyBits.*/d' "$SSHDFILE"
  sed -i '/UseLogin.*/d' "$SSHDFILE"
  sed -i 's/.*X11Forwarding.*/X11Forwarding no/' "$SSHDFILE"
  sed -i 's/.*LoginGraceTime.*/LoginGraceTime 20/' "$SSHDFILE"
  sed -i 's/.*PermitRootLogin.*/PermitRootLogin no/' "$SSHDFILE"
  sed -i 's/.*UsePrivilegeSeparation.*/UsePrivilegeSeparation sandbox/' "$SSHDFILE"
  sed -i 's/.*LogLevel.*/LogLevel VERBOSE/' "$SSHDFILE"
  sed -i 's/.*Banner.*/Banner \/etc\/issue.net/' "$SSHDFILE"
  sed -i 's/.*Subsystem.*sftp.*/Subsystem sftp internal-sftp/' "$SSHDFILE"
  sed -i 's/^#.*Compression.*/Compression no/' "$SSHDFILE"
  sed -i "s/.*Port.*/Port $SSH_PORT/" "$SSHDFILE"

  echo "" >> "$SSHDFILE"

  if ! grep -q "^LogLevel" "$SSHDFILE" 2> /dev/null; then
    echo "LogLevel VERBOSE" >> "$SSHDFILE"
  fi

  if ! grep -q "^PrintLastLog" "$SSHDFILE" 2> /dev/null; then
    echo "PrintLastLog yes" >> "$SSHDFILE"
  fi

  if ! grep -q "^IgnoreUserKnownHosts" "$SSHDFILE" 2> /dev/null; then
    echo "IgnoreUserKnownHosts yes" >> "$SSHDFILE"
  fi

  if ! grep -q "^PermitEmptyPasswords" "$SSHDFILE" 2> /dev/null; then
    echo "PermitEmptyPasswords no" >> "$SSHDFILE"
  fi

  if ! grep -q "^AllowGroups" "$SSHDFILE" 2> /dev/null; then
    echo "AllowGroups $SSH_GRPS" >> "$SSHDFILE"
  fi

  if ! grep -q "^MaxAuthTries" "$SSHDFILE" 2> /dev/null; then
    echo "MaxAuthTries 3" >> "$SSHDFILE"
  else
    sed -i 's/MaxAuthTries.*/MaxAuthTries 3/' "$SSHDFILE"
  fi

  if ! grep -q "^ClientAliveInterval" "$SSHDFILE" 2> /dev/null; then
    echo "ClientAliveInterval 200" >> "$SSHDFILE"
  fi

  if ! grep -q "^ClientAliveCountMax" "$SSHDFILE" 2> /dev/null; then
    echo "ClientAliveCountMax 3" >> "$SSHDFILE"
  fi

  if ! grep -q "^PermitUserEnvironment" "$SSHDFILE" 2> /dev/null; then
    echo "PermitUserEnvironment no" >> "$SSHDFILE"
  fi

  if ! grep -q "^KexAlgorithms" "$SSHDFILE" 2> /dev/null; then
    echo 'KexAlgorithms curve25519-sha256@libssh.org,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256' >> "$SSHDFILE"
  fi

  if ! grep -q "^Ciphers" "$SSHDFILE" 2> /dev/null; then
    echo 'Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr' >> "$SSHDFILE"
  fi

  if ! grep -q "^Macs" "$SSHDFILE" 2> /dev/null; then
    echo 'Macs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256' >> "$SSHDFILE"
  fi

  if ! grep -q "^MaxSessions" "$SSHDFILE" 2> /dev/null; then
    echo "MaxSessions 3" >> "$SSHDFILE"
  else
    sed -i 's/MaxSessions.*/MaxSessions 3/' "$SSHDFILE"
  fi

  if ! grep -q "^UseDNS" "$SSHDFILE" 2> /dev/null; then
    echo "UseDNS no" >> "$SSHDFILE"
  else
    sed -i 's/UseDNS.*/UseDNS no/' "$SSHDFILE"
  fi

  if ! grep -q "^StrictModes" "$SSHDFILE" 2> /dev/null; then
    echo "StrictModes yes" >> "$SSHDFILE"
  else
    sed -i 's/StrictModes.*/StrictModes yes/' "$SSHDFILE"
  fi

  if ! grep -q "^MaxStartups" "$SSHDFILE" 2> /dev/null; then
    echo "MaxStartups 10:30:60" >> "$SSHDFILE"
  else
    sed -i 's/MaxStartups.*/MaxStartups 10:30:60/' "$SSHDFILE"
  fi

  if ! grep -q "^HostbasedAuthentication" "$SSHDFILE" 2> /dev/null; then
    echo "HostbasedAuthentication no" >> "$SSHDFILE"
  else
    sed -i 's/HostbasedAuthentication.*/HostbasedAuthentication no/' "$SSHDFILE"
  fi

  if ! grep -q "^KerberosAuthentication" "$SSHDFILE" 2> /dev/null; then
    echo "KerberosAuthentication no" >> "$SSHDFILE"
  else
    sed -i 's/KerberosAuthentication.*/KerberosAuthentication no/' "$SSHDFILE"
  fi

  if ! grep -q "^GSSAPIAuthentication" "$SSHDFILE" 2> /dev/null; then
    echo "GSSAPIAuthentication no" >> "$SSHDFILE"
  else
    sed -i 's/GSSAPIAuthentication.*/GSSAPIAuthentication no/' "$SSHDFILE"
  fi

  if ! grep -q "^RekeyLimit" "$SSHDFILE" 2> /dev/null; then
    echo "RekeyLimit 512M 1h" >> "$SSHDFILE"
  else
    sed -i 's/RekeyLimit.*/RekeyLimit 512M 1h/' "$SSHDFILE"
  fi

  if ! grep -q "^AllowTcpForwarding" "$SSHDFILE" 2> /dev/null; then
    echo "AllowTcpForwarding no" >> "$SSHDFILE"
  else
    sed -i 's/AllowTcpForwarding.*/AllowTcpForwarding no/' "$SSHDFILE"
  fi

  if ! grep -q "^AllowAgentForwarding" "$SSHDFILE" 2> /dev/null; then
    echo "AllowAgentForwarding no" >> "$SSHDFILE"
  else
    sed -i 's/AllowAgentForwarding.*/AllowTcpForwarding no/' "$SSHDFILE"
  fi

  if ! grep -q "^TCPKeepAlive" "$SSHDFILE" 2> /dev/null; then
    echo "TCPKeepAlive no" >> "$SSHDFILE"
  else
    sed -i 's/TCPKeepAlive.*/TCPKeepAlive no/' "$SSHDFILE"
  fi

  cp "$SSHDFILE" "/etc/ssh/sshd_config.$(date +%y%m%d)"
  grep -v '#' "/etc/ssh/sshd_config.$(date +%y%m%d)" | sort | uniq > "$SSHDFILE"
  rm "/etc/ssh/sshd_config.$(date +%y%m%d)"

  chown root:root "$SSHDFILE"
  chmod 0600 "$SSHDFILE"

  systemctl restart sshd.service

  if [[ $VERBOSE == "Y" ]]; then
    systemctl status sshd.service --no-pager
    echo
  fi

  ((SCRIPT_COUNT++))
}

function f_sshconfig {
  echo "[$SCRIPT_COUNT] $SSHFILE"

  cp "$SSHFILE" "/etc/ssh/ssh_config.$(date +%y%m%d)"

  if ! grep -q "^\s.*HashKnownHosts" "$SSHFILE" 2> /dev/null; then
    sed -i '/HashKnownHosts/d' "$SSHFILE"
    echo "    HashKnownHosts yes" >> "$SSHFILE"
  fi

  sed -i 's/#.*Ciphers .*/    Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes256-ctr/g' "$SSHFILE"
  sed -i 's/#.*MACs .*/    MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256/' "$SSHFILE"
}