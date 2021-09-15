#! /bin/bash

function f_loginconf {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Creating secure login settings @ /etc/login.defs"
 
  sed -i 's/^.*LOG_OK_LOGINS.*/LOG_OK_LOGINS yes/' "$LOGINDEFS"
  sed -i 's/^UMASK.*/UMASK 077/' "$LOGINDEFS"
  sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS 1/' "$LOGINDEFS"
  sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS 60/' "$LOGINDEFS"
  sed -i 's/DEFAULT_HOME.*/DEFAULT_HOME no/' "$LOGINDEFS"
  sed -i 's/ENCRYPT_METHOD.*/ENCRYPT_METHOD SHA512/' "$LOGINDEFS"
  sed -i 's/USERGROUPS_ENAB.*/USERGROUPS_ENAB no/' "$LOGINDEFS"
  sed -i 's/^# SHA_CRYPT_MIN_ROUNDS.*/SHA_CRYPT_MIN_ROUNDS 10000/' "$LOGINDEFS"
  sed -i 's/^# SHA_CRYPT_MAX_ROUNDS.*/SHA_CRYPT_MAX_ROUNDS 65536/' "$LOGINDEFS"


}