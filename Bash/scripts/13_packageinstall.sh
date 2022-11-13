#! /bin/bashfunction 


function f_package_install {
   
  echo "Script: [$SCRIPT_NUM] ::: Installing important packages"

  local APPARMOR
  local AUDITD
  local VM

  APPARMOR="apparmor-profiles apparmor-utils libpam-apparmor"
  AUDITD="auditd audispd-plugins"
  VM=""

  if dmesg | grep -i -E "dmi.*vmware"; then
    VM="open-vm-tools"
  fi

  if dmesg | grep -i -E "dmi.*virtualbox"; then
    VM="virtualbox-guest-dkms virtualbox-guest-utils"
  fi

  echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
  echo "postfix postfix/mailname string $(hostname -f)" | debconf-set-selections

  local PACKAGE_INSTALL

  PACKAGE_INSTALL="acct aide-common cracklib-runtime debsums gnupg2 haveged libpam-pwquality libpam-tmpdir needrestart openssh-server postfix psad rkhunter sysstat systemd-coredump tcpd update-notifier-common vlock $APPARMOR $AUDITD $VM"

  for deb_install in $PACKAGE_INSTALL; do
    apt-get install -y --no-install-recommends "$deb_install"
  done

  if [[ -f /etc/default/sysstat ]]; then
    sed -i 's/ENABLED=.*/ENABLED="true"/' /etc/default/sysstat
    systemctl enable sysstat
  fi

 
}

function f_package_remove {
  echo "Script: [$SCRIPT_NUM] ::: Package removal"

  local PACKAGE_REMOVE
  PACKAGE_REMOVE="apport* autofs avahi* beep git pastebinit popularity-contest rsh* rsync talk* telnet* tftp* whoopsie xinetd yp-tools ypbind"

  for deb_remove in $PACKAGE_REMOVE; do
    apt-get --purge "$deb_remove" -y
  done

 ((SCRIPT_NUM++))
}
