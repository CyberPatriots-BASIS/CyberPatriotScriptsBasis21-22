#! /bin/bash

function f_kernel {
  
  echo "Script: [$SCRIPT_NUM] ::: Kernel parameters"

  local HASHSIZE
  local LOCKDOWN

  HASHSIZE="/sys/module/nf_conntrack/parameters/hashsize"
  LOCKDOWN="/sys/kernel/security/lockdown"

  if [[ -f "$HASHSIZE" && -w "$HASHSIZE" ]]; then
    echo 1048576 > /sys/module/nf_conntrack/parameters/hashsize
  fi

  if [[ -f "$LOCKDOWN" && -w "$LOCKDOWN" ]]; then
    if ! grep -q 'lockdown=' /proc/cmdline; then
      echo "GRUB_CMDLINE_LINUX=\"\$GRUB_CMDLINE_LINUX lockdown=confidentiality\"" > "$DEFAULTGRUB/99-hardening-lockdown.cfg"
    fi
  fi
  ((SCRIPT_NUM++))
}