#! /bin/bash

function f_password {
    
    echo "Script: [$SCRIPT_NUM] ::: Setting better password policies"

    if ! grep pam_pwhistory.so "$COMMONPASSWD"; then
        sed -i '/the "Primary" block/apassword\trequired\t\t\tpam_pwhistory.so\tremember=5' /etc/pam.d/common-password
    fi


    cp ./config/pwquality.conf /etc/security/pwquality.conf
    chmod 0644 /etc/security/pwquality.conf

    usrInfo=$(awk -F: '{if ($3 >= 1000) print $1}' < /etc/passwd)

    for u in usrInfo
    do
      chage -m 7 $u
      chage -M 60 $u
    done
    
    sed -i 's/try_first_pass sha512.*/try_first_pass sha512 rounds=65536/' "$COMMONPASSWD"
    sed -i 's/nullok_secure//' "$COMMONAUTH"

    apt install libpam-cracklib

    if ! grep retry= "$COMMONPASSWD"; then
      echo 'password requisite pam_pwquality.so retry=3 minlen=8 lcredit=-1 ucredit=-1 dcredit=-1 ocredit=-1' >> "$COMMONPASSWD"
    fi

    if ! grep tally2 "$COMMONAUTH"; then
      sed -i '/^$/a auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900' "$COMMONAUTH"
      sed -i '/pam_tally/d' "$COMMONACCOUNT"
      echo 'account required pam_tally2.so' >> "$COMMONACCOUNT"
    fi

    echo -e "[ i ] Disabling core dumps..."
    cp ./config/limits.conf /etc/security/limits.conf
    overwrite "${YES} Disabled core dumps"

    sed -i 's/pam_lastlog.so.*/pam_lastlog.so showfailed/' "$PAMLOGIN"
    sed -i 's/delay=.*/delay=4000000/' "$PAMLOGIN"
    sudo sed -i '1 s/^/auth optional pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent\n/' /etc/pam.d/common-auth
    sed -i 's/auth\trequisite\t\t\tpam_deny.so\+/auth\trequired\t\t\tpam_deny.so/' /etc/pam.d/common-auth
	        sed -i '$a auth\trequired\t\t\tpam_tally2.so deny=5 unlock_time=1800 onerr=fail' /etc/pam.d/common-auth
	        sed -i 's/sha512\+/sha512 remember=13/' /etc/pam.d/common-password
    hUSER=`cut -d: -f1,3 /etc/passwd | egrep ':[0]{1}$' | cut -d: -f1`
	echo "$hUSER is a hidden user"

  wait
  ((SCRIPT_NUM++))
}