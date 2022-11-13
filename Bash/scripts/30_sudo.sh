#! /bin/bash

function f_sudo {
  
  echo "Script: [$SCRIPT_NUM] ::: sudo configuration"

  if ! grep -qER '^Defaults.*use_pty$' /etc/sudo*; then
    echo "Defaults use_pty" > /etc/sudoers.d/011_use_pty
  fi

  if ! grep -qER '^Defaults.*logfile' /etc/sudo*; then
    echo 'Defaults logfile="/var/log/sudo.log"' > /etc/sudoers.d/012_logfile
  fi

  if ! grep -qER '^Defaults.*pwfeedback' /etc/sudo*; then
    echo 'Defaults !pwfeedback' > /etc/sudoers.d/013_pwfeedback
  fi

  if ! grep -qER '^Defaults.*visiblepw' /etc/sudo*; then
    echo 'Defaults !visiblepw' > /etc/sudoers.d/014_visiblepw
  fi

  if ! grep -qER '^Defaults.*passwd_timeout' /etc/sudo*; then
    echo 'Defaults passwd_timeout=1' > /etc/sudoers.d/015_passwdtimeout
  fi

  if ! grep -qER '^Defaults.*timestamp_timeout' /etc/sudo*; then
    echo 'Defaults timestamp_timeout=5' > /etc/sudoers.d/016_timestamptimeout
  fi

  find /etc/sudoers.d/ -type f -name '[0-9]*' -exec chmod 0440 {} \;

  if ! grep -qER '^auth required pam_wheel.so' /etc/pam.d/su; then
    echo "auth required pam_wheel.so use_uid group=sudo" >> /etc/pam.d/su
  fi

    sudo -ll > sudoll.log
    echo
((SCRIPT_NUM++))
}