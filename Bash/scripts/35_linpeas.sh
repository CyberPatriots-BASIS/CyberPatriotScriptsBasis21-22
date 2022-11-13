function f_linpeas {
    
    
    echo "Script: [$SCRIPT_NUM] ::: linPEAS"
    if !  dpkg -l | grep git; then
        read -p -r "Git isn't installed. Install? Y/n >" gitInstallYesNo

        if [ "$gitInstallYesNo" == Y ]; then 
            apt-get install git
        else   
            echo "Script: $SCRIPT_NUM ::: Git not installed and installation denied by user"
            return
        fi
    fi

    read -p -r "Would you like to run LinPEAS? Y/n >" linPeasYesNo

    if [ "$linPeasYesNo" == Y ]; then  
        curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
        bash ./linpeas.sh
    else
        echo "Script: $SCRIPT_NUM ::: Git not installed and installation denied by user"
        return
    fi
        
((SCRIPT_NUM++))
}