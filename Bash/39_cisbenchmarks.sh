function f_cis {
    git clone https://github.com/ovh/debian-cis
    chmod +x ./debian-cis/bin/hardening.sh
    sudo bash ./debian-cis/bin/hardening.sh
}