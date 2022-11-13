function f_admin {
	
  	echo "Script: [$SCRIPT_NUM] ::: Search for admins"
    for x in $USERNAMES
	do
		read -p "Is $x considered an admin?[y/n]: " a
		if [ $a = y ]
		then
			##Adds to the adm group
			sudo usermod -a -G adm $x

			##Adds to the sudo group
			sudo usermod -a -G sudo $x
		else
			##Removes from the adm group
			sudo deluser $x adm

			##Removes from the sudo group
			sudo deluser $x sudo
		fi
	done
	((SCRIPT_NUM++))
}