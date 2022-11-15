function f_ftpconfig {
    
    echo "Script: [$SCRIPT_NUM]: Configuring $VSFTPDCONF to be as secure as possible"

    sed -i 's/anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd.conf

    read -p "Would you like to have local users access the server? [y/n] >" localusers
    if [ $localusers = y] 
    then
        sed -i 's/local_enable=.*/local_enable=YES/' /etc/vsftpd.conf
    fi

    read -p "Would you like to have uploads enabled? [y/n] >" uploads
    if [ $uploads = y] 
    then
        sed -i 's/#write_enable=.*/write_enable=YES/' /etc/vsftpd.conf
    fi

	sed -i 's/#chroot_local_user=.*/chroot_local_user=YES/' /etc/vsftpd.conf 
    read -p "Would you like to have VSFTPD listen on IPV6 instead of IPV4? [y/n] >" ipv6yesno
    if [ $ipv6yesno = y]
    then
        sed -i 's/#listen=*/listen=NO/' /etc/vsftpd.conf
        sed -i 's/listen_ipv6=*/listen_ipv6=YES/' /etc/vsftpd.conf
    else    
        sed -i 's/#listen=*/listen=YES' /etc/vsftpd.conf
        sed -i 's/listen_ipv6=*/listen_ipv6=NO/' /etc/vsftpd.conf
    fi
    sed -i 's/ssl_enable=*/ssl_enable=YES/' /etc/vsftpd.conf
    sed -i 's/xferlog_enable=*/xferlog_enable=YES/' /etc/vsftpd.conf
    sed -i 's/xferlog_std_format=*/xferlog_std_format=YES/' /etc/vsftpd.conf
    ((SCRIPT_NUM++))
}