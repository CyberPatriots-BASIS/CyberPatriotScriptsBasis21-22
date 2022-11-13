function f_clamav {
    
  echo "Script: [$SCRIPT_NUM] ::: clamav"
    sudo apt install clamav
    udo apt-get install chkrootkit
    sudo clamav
    sudo freshclam
    sudo clamscan -r --bell -i /home/
    sudo chkrootkit
    sudo apt-get install clamtk -y
    echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
    ((SCRIPT_NUM++))
}