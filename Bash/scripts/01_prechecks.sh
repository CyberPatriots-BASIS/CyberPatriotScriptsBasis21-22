#! /bin/bash

function f_prechecks {
    SCRIPT_NUM="0"
    

    export TERM=linux
    export DEBIAN_FRONTEND=noninteractive


    if [[ "$EUID" -ne 0 ]] ; then   
        echo "Sorry, this script requires root privileges. Please run with sudo"
        exit 1
    else
        echo "Script: [$SCRIPT_NUM]  ::: Script has root privileges. Continuing"
    fi
    
    

((SCRIPT_NUM++))
}