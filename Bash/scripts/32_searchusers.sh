#! /bin/bash

function f_searchusers {
    echo "Script: [$SCRIPT_NUM] ::: Searching for users"
    echo "$USERNAMES"
    echo -n "Do you wish to add a user [y/n]?" 
    read response
    if [ $response = "y" ];
        then 
        echo -n "Enter username to add:"
        read name
        sudo adduser $name
        echo "User added:" $name
    fi

    for i in $(ls /home);
    do 
        echo "Delete user " ${i/} "[y/n]?"
        read input
        if [ $input = "y" ];
        then
            sudo deluser --remove-home $i
        fi
    done
    ((SCRIPT_NUM++))
}