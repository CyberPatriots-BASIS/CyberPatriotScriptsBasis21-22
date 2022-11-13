#! /bin/bash

function f_rhosts {
  echo "Script: [$SCRIPT_NUM] ::: Editing .rhosts"

  while read -r hostpasswd; do
    find "$hostpasswd" \( -name "hosts.equiv" -o -name ".rhosts" \) -exec rm -f {} \; 2> /dev/null

  done <<< "$(awk -F ":" '{print $6}' /etc/passwd)"

  if [[ -f /etc/hosts.equiv ]]; then
    rm /etc/hosts.equiv
  fi

  ((SCRIPT_NUM++))
}