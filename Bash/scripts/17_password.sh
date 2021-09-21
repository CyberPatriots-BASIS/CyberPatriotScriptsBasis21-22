#! /bin/bash

function f_password {
    ((SCRIPT_NUM++))
    echo "Script: [$SCRIPT_NUM] ::: Setting better password policies"

    if ! grep pam_pwhistory.so "$COMMONPASSWD"; then
        sed -i '/the "Primary" block/apassword\trequired\t\t\tpam_pwhistory.so\tremember=5' /etc/pam.d/common-password
    fi


    cp ./config/pwquality.conf /etc/security/pwquality.conf
    chmod 0644 /etc/security/pwquality.conf

    sed -i 's/try_first_pass sha512.*/try_first_pass sha512 rounds=65536/' "$COMMONPASSWD"
    sed -i 's/nullok_secure//' "$COMMONAUTH"

    if ! grep retry= "$COMMONPASSWD"; then
      echo 'password requisite pam_pwquality.so retry=3' >> "$COMMONPASSWD"
    fi

    if ! grep tally2 "$COMMONAUTH"; then
      sed -i '/^$/a auth required pam_tally2.so onerr=fail audit silent deny=5 unlock_time=900' "$COMMONAUTH"
      sed -i '/pam_tally/d' "$COMMONACCOUNT"
      echo 'account required pam_tally2.so' >> "$COMMONACCOUNT"
    fi

    sed -i 's/pam_lastlog.so.*/pam_lastlog.so showfailed/' "$PAMLOGIN"
    sed -i 's/delay=.*/delay=4000000/' "$PAMLOGIN"


}