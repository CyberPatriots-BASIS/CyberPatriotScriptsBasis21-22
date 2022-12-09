#! /bin/bash

function main {
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
    readonly VSFTPDCONF

    for s in ./scripts/[0-9_]*; do
        [[ -f $s ]] || break

        source "$s"
    done

    


    f_prechecks
    f_firewall
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
    f_resolvedconf
    f_ctrlaltdel

    read -p "Configure ssh? [y/n]: " a
		if [ $a = y ]
		then
            f_sshconfig
            f_sshdconfig
		else
            break;
        fi
    read -p "Configure FTP? [y/n]: " b
        if [ $b = y ]
        then
            f_ftpconfig
        else
            break;
        fi
    read -p "Configure HTTP? [y/n]: " c
    	if [ $c = y ]
	    then
	        echo -c "Must be implemented"
	    else
	        break;
	    fi

    f_cron
    f_auditd
    f_disablemod
    f_rhosts
    f_users
    f_servicedisable
    f_rkhunter
    f_clamav
    f_apport
    f_lockroot
    f_postfix
    f_usbguard
    f_kernel
    f_sudo
    f_psad
    f_searchusers
    f_admin
    f_linpeas
    f_lynis
}

LOGFILE="hardening-$(hostname --short)-$(date +%y%m%d).log"
echo "[HARDENING LOG - $(hostname --fqdn) - $(date +"%d-%t-%y-%T")]" >> "$LOGFILE"

sudo apt update
sudo apt install dos2unix
dos2unix ./linux_ubuntu.sh
dos2unix linux_ubuntu.cfg
for f in ./scripts/*.sh
do
    dos2unix $f
done
main "$@" | tee -a "$LOGFILE"
