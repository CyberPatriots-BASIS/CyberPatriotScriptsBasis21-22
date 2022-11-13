#! /bin/bash

  
function f_postfix {
  
  echo "Script: [$SCRIPT_NUM] ::: Set up Postfix"

  postconf -e disable_vrfy_command=yes
  postconf -e smtpd_banner="\$myhostname ESMTP"
  postconf -e smtpd_client_restrictions=permit_mynetworks,reject
  postconf -e inet_interfaces=loopback-only

  systemctl restart postfix.service
((SCRIPT_NUM++))
}