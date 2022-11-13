#! /bin/bash

function f_rootaccess {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: root access"

  if ! grep -E '^+\s:\sroot\s:\s127.0.0.1$|^:root:127.0.0.1' "$SECURITYACCESS"; then
    sed -i 's/^#.*root.*:.*127.0.0.1$/+:root:127.0.0.1/' "$SECURITYACCESS"
  fi

  echo "console" > /etc/securetty



  echo "Script: [$SCRIPT_NUM] ::: Mask debug-shell"

  systemctl mask debug-shell.service
  systemctl stop debug-shell.service
  systemctl daemon-reload


  echo "Script: [$SCRIPT_NUM] ::: Restrict access to su"

  if ! grep -q 'auth required' /etc/pam.d/su; then
    echo "auth required pam_wheel.so" > /etc/pam.d/su
  fi
  ((SCRIPT_NUM++))
}