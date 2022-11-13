function f_clamav {
    sudo apt install clamav
    udo apt-get install chkrootkit
    sudo clamav
    sudo freshclam
    sudo clamscan -r --bell -i /home/
    sudo chkrootkit
    sudo apt-get install clamtk -y
    echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
}