#! /bin/bash


if ! ps -p $$ | grep -si bash; then
    echo "Please run with bash. If not possible, this script cannot run"
    exit 1
fi

if ! [ -x "$(command -v systemctl)" ]; then
    echo "Systemctl is needed to run this script. Exiting."
    exit 1
fi

function main {

    ARPLOCATION="$(command -v arp)"
    WLOCATION="$(command -v w)"
    SERVERIP="$(ip route | grep '^default' | awk '{print $9}')"

    source ./linux-ubuntu.cfg

    readonly USERNAMES
    readonly CURRENTUSER
    readonly SSH_GROUPS
    readonly SSH_PORT
    readonly SYSCTL_CONF
    readonly NTPSERVERPOOL
    readonly USERNAMES
    readonly CURRENTUSER
    readonly ADDUSER
    readonly AUDITDCONF
    readonly AUDITRULES
    readonly COMMONPASSWD
    readonly COMMONACCOUNT
    readonly COMMONAUTH
    readonly COREDUMPCONF
    readonly DEFAULTGRUB
    readonly DISABLEFS
    readonly DISABLEMOD
    readonly DISABLENET
    readonly JOURNALDCONF
    readonly LIMITSCONF
    readonly LOGINDCONF
    readonly LOGINDEFS
    readonly LOGROTATE
    readonly PAMLOGIN
    readonly PSADCONF
    readonly PSADDL
    readonly RESOLVEDCONF
    readonly RKHUNTERCONF
    readonly RSYSLOGCONF
    readonly SECURITYACCESS
    readonly SSHFILE
    readonly SSHDFILE
    readonly SYSCTL
    readonly SYSTEMCONF
    readonly TIMESYNCD
    readonly UFWDEFAULT
    readonly USERADD
    readonly USERCONF
    readonly ARPLOCATION
    readonly WLOCATION
    readonly SERVERIP

    for s in ./scripts/[0-9_]*; do
    [[ -f $s ]] || break

    source "$s"
    done

    


    f_prechecks
    f_firewall
    f_lynis
    f_netprocdisable
    f_badfsdisable
    f_systemdconfig
    f_timesyncd
    f_prelink
    f_aptget
    f_aptget_clean
    f_aptget_configure
    f_loginconf
    f_hosts
    f_sysctl
    f_package_install
    f_package_remove
    f_adduser
    f_rootaccess
    f_password
    f_ctrlaltdel
    f_sshconfig
    f_cron
    f_auditd
    f_disablemod
    f_rhosts
    f_users
    f_rkhunter
    f_apport
    f_lockroot
    f_postfix
    f_usbguard
    f_kernel
    f_sudo
    f_psad
    f_searchusers
}

LOGFILE="hardening-$(hostname --short)-$(date +%y%m%d).log"
echo "[HARDENING LOG - $(hostname --fqdn) - $(LANG=C date)]" >> "$LOGFILE"

main "$@" | tee -a "$LOGFILE"
