function f_servicedisable {
    local services=cups.service openvpn.service pure-ftpd.service rexec.service rsync.service rsyslog.service telnet.service vsftpd.service""
    for service in $services; do
        read -p "Would you like to disable $service? [y/n] >" yesNo
        if [ yesNo = "y" ]  
            systemctl disable $service
        fi
    done
}