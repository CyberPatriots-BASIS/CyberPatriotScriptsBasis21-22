function f_ftpconfig {
    ((SCRIPT_NUM++))
    echo "Script: [$SCRIPT_NUM]: Configuring $VSFTPDCONF to be as secure as possible"

    sed -i 's/anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd.conf

    read -p "Would you like to have local users access the server? [y/n] >" localusers
    if [ $localusers = y] 
        sed -i 's/local_enable=.*/local_enable=YES/' /etc/vsftpd.conf
    fi

    read -p "Would you like to have uploads enabled? [y/n] >" uploads
    if [ $uploads = y] 
        sed -i 's/#write_enable=.*/write_enable=YES/' /etc/vsftpd.conf
    fi

	sed -i 's/#chroot_local_user=.*/chroot_local_user=YES/' /etc/vsftpd.conf 
    sed -i 's/#listen=*/listen=NO' /etc/vsftpd.conf
    sed -i 's/listen_ipv6=*/listen_ipv6=YES' /etc/vsftpd.conf
    sed -i 's/ssl_enable=*/ssl_enable=YES' /etc/vsftpd.conf
    
}