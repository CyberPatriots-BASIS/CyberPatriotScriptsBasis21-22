function f_servicedisable {
    
  echo "Script: [$SCRIPT_NUM] ::: Disabling services"
    local services=cups.service openvpn.service pure-ftpd.service rexec.service rsync.service rsyslog.service telnet.service vsftpd.service""
    for service in $services; do
        read -p "Would you like to disable $service? [y/n] >" yesNo
        if [ yesNo = "y" ]  
        then
            systemctl disable $service 2> /dev/null 1>&2
            echo "Script: [$SCRIPT_NUM] ::: Disabled $service"
        fi
    done
}