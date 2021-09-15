#! /bin/bash

function f_aptget {
  ((SCRIPT_NUM++))
  echo "Script: [$SCRIPT_NUM] ::: Updating the package index files from their sources"

  apt-get update

  

  echo "Script: [$SCRIPT_NUM] ::: Upgrading installed packages"

  apt-get update && apt-get upgrade && apt-get dist-upgrade

}

function f_aptget_clean {
  
  echo "Script: [$SCRIPT_NUM] ::: Removing unused packages"

  apt-get -qq clean
  apt-get -qq autoremove

  for deb_clean in $(dpkg -l | grep '^rc' | awk '{print $2}'); do
    $APT purge "$deb_clean"
  done

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

}

