#! /bin/bash

function f_aptget {
  
  echo "Script: [$SCRIPT_NUM] ::: Updating the package index files from their sources"

  apt update

  ##CHANGE TO GREP -i
        echo "$LogTime uss: [$UserName]# Removing hacking tools..." >> output.log
        ##Looks for apache web server
        	dpkg -l | grep apache >> output.log
        	if [ $? -eq 0 ];
        	then
                       	read -p "Do you want apache installed on the system[y/n]: "
        	        if [ $a = n ];
        	        then
      	        	        apt -y purge apache2 >> output.log
			else
            		if [ -e /etc/apache2/apache2.conf ]
				then
					chown -R root:root /etc/apache2
					chown -R root:root /etc/apache
					echo \<Directory \> >> /etc/apache2/apache2.conf
					echo -e ' \t AllowOverride None' >> /etc/apache2/apache2.conf
					echo -e ' \t Order Deny,Allow' >> /etc/apache2/apache2.conf
					echo -e ' \t Deny from all' >> /etc/apache2/apache2.conf
					echo UserDir disabled root >> /etc/apache2/apache2.conf
				else
					##Installs and configures apache
					apt install apache2 -y
						chown -R root:root /etc/apache2
						chown -R root:root /etc/apache
						echo \<Directory \> >> /etc/apache2/apache2.conf
						echo -e ' \t AllowOverride None' >> /etc/apache2/apache2.conf
						echo -e ' \t Order Deny,Allow' >> /etc/apache2/apache2.conf
						echo -e ' \t Deny from all' >> /etc/apache2/apache2.conf
						echo UserDir disabled root >> /etc/apache2/apache2.conf

					##Installs and configures sql
					apt install mysql-server -y

					##Installs and configures php5
					apt install php5 -y
					chmod 640 /etc/php5/apache2/php.ini
				fi
        	fi
	else
        echo "Apache is not installed"
		sleep 1
	fi
        ##Looks for john the ripper
	        dpkg -l | grep john >> output.log
	        if [ $? -eq 0 ];
	        then
        	        echo "JOHN HAS BEEEN FOUND! DIE DIE DIE"
        	        apt -y purge john >> output.log
        	        echo "John has been ripped"
			sleep 1
	        else
                echo "John The Ripper has not been found on the system"
			sleep 1
	        fi
        ##Look for HYDRA
	dpkg -l | grep hydra >>output.log
	if [ $? -eq 0 ];
	then
		echo "HEIL HYDRA"
		apt -y purge hydra >> output.log
	else
		echo "Hydra has not been found."
	fi
        ##Looks for nginx web server
	dpkg -l | grep nginx >> output.log
	if [ $? -eq 0 ];
	then
        	echo "NGINX HAS BEEN FOUND! OHHHH NOOOOOO!"
        	apt -y purge nginx >> output.log
	else
        	echo "NGINX has not been found"
			sleep 1
	fi
        ##Looks for samba
	if [ -d /etc/samba ];
	then
		read -p "Samba has been found on this system, do you want to remove it?[y/n]: " a
		if [ $a = y ];
		then
        echo "$LogTime uss: [$UserName]# Uninstalling samba..." >> output.log
			sudo apt purge -y samba >> output.log
			sudo apt purge -y samba >> output.log
        echo "$LogTime uss: [$UserName]# Samba has been removed." >> output.log
		else
			sed -i '82 i\restrict anonymous = 2' /etc/samba/smb.conf
			##List shares
		fi
	else
		echo "Samba has not been found."
		sleep 1
	fi
        ##LOOK FOR DNS
	if [ -d /etc/bind ];
	then
		read -p "DNS server is running would you like to shut it down?[y/n]: " a
		if [ $a = y ];
		then
			purge -y purge bind9 
		fi
	else
		echo "DNS not found."
		sleep 1
	fi
        ##Looks for FTP
	dpkg -l | grep -i 'vsftpd|ftp' >> output.log
	if [ $? -eq 0 ]
	then	
		read -p "FTP Server has been installed, would you like to remove it?[y/n]: " a
		if [ $a = y ]
		then
			PID = `pgrep vsftpd`
			sed -i 's/^/#/' /etc/vsftpd.conf
			kill $PID
			apt -y purge vsftpd ftp
		else
			sed -i 's/anonymous_enable=.*/anonymous_enable=NO/' /etc/vsftpd.conf
			sed -i 's/local_enable=.*/local_enable=YES/' /etc/vsftpd.conf
			sed -i 's/#write_enable=.*/write_enable=YES/' /etc/vsftpd.conf
			sed -i 's/#chroot_local_user=.*/chroot_local_user=YES/' /etc/vsftpd.conf
		fi
	else
		echo "FTP has not been found."
		sleep 1
	fi
        ##Looks for TFTPD
	dpkg -l | grep tftpd >> output.log
	if [ $? -eq 0 ]
	then
		read -p "TFTPD has been installed, would you like to remove it?[y/n]: " a
		if [ $a = y ]
		then
			apt -y purge tftpd
		fi
	else
		echo "TFTPD not found."
		sleep 1
	fi
        ##Looking for VNC
	dpkg -l | grep -E 'x11vnc|tightvncserver' >> output.log
	if [ $? -eq 0 ]
	then
		read -p "VNC has been installed, would you like to remove it?[y/n]: " a
		if [ $a = y ]
		then
			apt -y purge x11vnc tightvncserver 
		##else
			##Configure VNC
		fi
	else
		echo "VNC not found."
		sleep 1
	fi

        ##Looking for NFS
	dpkg -l | grep nfs-kernel-server >> output.log
	if [ $? -eq 0 ]
	then	
		read -p "NFS has been found, would you like to remove it?[y/n]: " a
		if [ $a = 0 ]
		then
			apt -y purge nfs-kernel-server
		##else
			##Configure NFS
		fi
	else
		echo "NFS has not been found."
		sleep 1
	fi
        ##Looks for snmp
	dpkg -l | grep snmp >> output.log
	if [ $? -eq 0 ]
	then	
		echo "SNMP HAS BEEN LOCATED!"
		apt -y purge snmp
	else
		echo "SNMP has not been found."
		sleep 1
	fi
        ##Looks for sendmail and postfix
	dpkg -l | grep -E 'postfix|sendmail' >> output.log
	if [ $? -eq 0 ]
	then
		echo "Mail servers have been found."
		apt -y purge postfix sendmail
	else
		echo "Mail servers have not been located."
		sleep 1
	fi
        ##Looks xinetd
	dpkg -l | grep xinetd >> output.log
	if [ $? -eq 0 ]
	then
		echo "XINIT HAS BEEN FOUND!"
		apt -y purge xinetd
	else
		echo "XINETD has not been found."
		sleep 1
	fi
	pause

  echo "Script: [$SCRIPT_NUM] ::: Upgrading installed packages"

  apt update && apt upgrade && apt dist-upgrade

}

function f_aptget_clean {
  
  echo "Script: [$SCRIPT_NUM] ::: Removing unused packages"

  apt clean
  apt

  for deb_clean in $(dpkg -l | grep '^rc' | awk '{print $2}'); do
    $APT purge "$deb_clean"
  done
sed -i -e 's/APT::Periodic::Update-Package-Lists.*\+/APT::Periodic::Update-Package-Lists "1";/' /etc/apt/apt.conf.d/10periodic
		sed -i -e 's/APT::Periodic::Download-Upgradeable-Packages.*\+/APT::Periodic::Download-Upgradeable-Packages "0";/' /etc/apt/apt.conf.d/10periodic
  # Remove Hacking Tools

dpkg --get-selections | grep john

dpkg --get-selections | grep crack
# NOTE: CRACKLIB IS GOOD

dpkg --get-selections | grep -i hydra

dpkg --get-selections | grep weplab

dpkg --get-selections | grep pyrit
sudo apt purge qbittorrent 
sudo apt purge utorrent 
sudo apt purge ctorrent 
sudo apt purge ktorrent 
sudo apt purge rtorrent 
sudo apt purge deluge 
sudo apt purge transmission-gtk
sudo apt purge transmission-common 
sudo apt purge tixati 
sudo apt purge frostwise 
sudo apt purge vuze 
sudo apt purge irssi
sudo apt purge talk 
sudo apt purge telnet
	#Remove pentesting
sudo apt purge wireshark 
sudo apt purge nmap 
sudo apt purge john 
sudo apt purge netcat 
sudo apt purge netcat-openbsd 
sudo apt purge netcat-traditional 
sudo apt purge netcat-ubuntu 
sudo apt purge netcat-minimal
	#cleanup	 
sudo apt

}

function f_aptget_configure {
  echo "Script: [$SCRIPT_NUM] ::: Configure APT"

  if ! grep '^Acquire::http::AllowRedirect' /etc/apt/apt.conf.d/* ; then
    echo 'Acquire::http::AllowRedirect "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*Acquire::http::AllowRedirect*/Acquire::http::AllowRedirect "false";/g' "$(grep -l 'Acquire::http::AllowRedirect' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^APT::Get::AllowUnauthenticated' /etc/apt/apt.conf.d/* ; then
    echo 'APT::Get::AllowUnauthenticated "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*APT::Get::AllowUnauthenticated.*/APT::Get::AllowUnauthenticated "false";/g' "$(grep -l 'APT::Get::AllowUnauthenticated' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^APT::Periodic::AutocleanInterval' /etc/apt/apt.conf.d/*; then
    echo 'APT::Periodic::AutocleanInterval "7";' >> /etc/apt/apt.conf.d/10periodic
  else
    sed -i 's/.*APT::Periodic::AutocleanInterval.*/APT::Periodic::AutocleanInterval "7";/g' "$(grep -l 'APT::Periodic::AutocleanInterval' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^APT::Install-Recommends' /etc/apt/apt.conf.d/*; then
    echo 'APT::Install-Recommends "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*APT::Install-Recommends.*/APT::Install-Recommends "false";/g' "$(grep -l 'APT::Install-Recommends' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^APT::Get::AutomaticRemove' /etc/apt/apt.conf.d/*; then
    echo 'APT::Get::AutomaticRemove "true";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*APT::Get::AutomaticRemove.*/APT::Get::AutomaticRemove "true";/g' "$(grep -l 'APT::Get::AutomaticRemove' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^APT::Install-Suggests' /etc/apt/apt.conf.d/*; then
    echo 'APT::Install-Suggests "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*APT::Install-Suggests.*/APT::Install-Suggests "false";/g' "$(grep -l 'APT::Install-Suggests' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^Unattended-Upgrade::Remove-Unused-Dependencies' /etc/apt/apt.conf.d/*; then
    echo 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' >> /etc/apt/apt.conf.d/50unattended-upgrades
  else
    sed -i 's/.*Unattended-Upgrade::Remove-Unused-Dependencies.*/Unattended-Upgrade::Remove-Unused-Dependencies "true";/g' "$(grep -l 'Unattended-Upgrade::Remove-Unused-Dependencies' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^Acquire::AllowDowngradeToInsecureRepositories' /etc/apt/apt.conf.d/*; then
    echo 'Acquire::AllowDowngradeToInsecureRepositories "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*Acquire::AllowDowngradeToInsecureRepositories.*/Acquire::AllowDowngradeToInsecureRepositories "false";/g' "$(grep -l 'Acquire::AllowDowngradeToInsecureRepositories' /etc/apt/apt.conf.d/*)"
  fi

  if ! grep '^Acquire::AllowInsecureRepositories' /etc/apt/apt.conf.d/*; then
    echo 'Acquire::AllowInsecureRepositories "false";' >> /etc/apt/apt.conf.d/98-hardening-ubuntu
  else
    sed -i 's/.*Acquire::AllowInsecureRepositories.*/Acquire::AllowInsecureRepositories "false";/g' "$(grep -l 'Acquire::AllowInsecureRepositories' /etc/apt/apt.conf.d/*)"
  fi
	((SCRIPT_NUM++))
}

