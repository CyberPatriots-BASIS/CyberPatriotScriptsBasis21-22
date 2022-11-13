#! /bin/bash

function f_lynis {
    

    if !  dpkg -l | grep git; then
        read -p -r "Git isn't installed. Install? Y/n >" gitInstallYesNo

        if [ "$gitInstallYesNo" == Y ]; then 
            apt-get install git
        else   
            echo "Script: $SCRIPT_NUM ::: Git not installed and installation denied by user"
            return
        fi
    fi

    echo "Script: [$SCRIPT_NUM] ::: Installing lynis"
    git clone https://github.com/CISOfy/lynis
    
    
    cd lynis || return
    echo "Script: [$SCRIPT_NUM] ::: Running lynis, echo is off, reference lynis log"
    ./lynis audit system >> "../lynis-$(hostname --short)-$(date +%y%m%d%H%M).log"
    ((SCRIPT_NUM++))
}