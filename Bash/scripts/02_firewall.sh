#! /bin/bash

function f_firewall {
    ((SCRIPT_NUM++))


    echo "Script: [$SCRIPT_NUM] ::: Installing UFW "
    if ![apt list | grep ufw] then
      read -r -p "UFW is not installed. Would you like it installed? Y/N > " ufwYesNo
    fi

    if [ ufwYesNo == "Y" ]; then
        apt install -y ufw
    else 
        echo "Script: [$SCRIPT_NUM] ::: UFW installation denied by user"

        return
    fi

    echo "Script: [$SCRIPT_NUM] ::: Editing rules for UFW"
    ufw --force enable
    sed -i '/^COMMIT/i -A ufw-before-output -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT' /etc/ufw/before.rules
    sed -i '/^COMMIT/i -A ufw-before-output -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT' /etc/ufw/before.rules
    sed -i '/^COMMIT/i -A ufw6-before-output -p icmpv6 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT' /etc/ufw/before6.rules
    sed -i '/^COMMIT/i -A ufw6-before-output -p icmpv6 -m state --state ESTABLISHED,RELATED -j ACCEPT' /etc/ufw/before6.rules
    sed -i '/^COMMIT/i -A FORWARD -j LOG --log-tcp-options --log-prefix "[UFW FORWARD]"' /etc/ufw/after.rules
    sed -i '/^COMMIT/i -A FORWARD -j LOG --log-tcp-options --log-prefix "[UFW FORWARD]"' /etc/ufw/after6.rules
    sed -i '/^COMMIT/i -A FORWARD -j LOG --log-tcp-options --log-prefix "[UFW FORWARD]"' /etc/ufw/before.rules
    sed -i '/^COMMIT/i -A FORWARD -j LOG --log-tcp-options --log-prefix "[UFW FORWARD]"' /etc/ufw/before6.rules
    sed -i '/^COMMIT/i -A INPUT -j LOG --log-tcp-options --log-prefix "[UFW INPUT]"' /etc/ufw/after.rules
    sed -i '/^COMMIT/i -A INPUT -j LOG --log-tcp-options --log-prefix "[UFW INPUT]"' /etc/ufw/after6.rules
    sed -i '/^COMMIT/i -A INPUT -j LOG --log-tcp-options --log-prefix "[UFW INPUT]"' /etc/ufw/before.rules
    sed -i '/^COMMIT/i -A INPUT -j LOG --log-tcp-options --log-prefix "[UFW INPUT]"' /etc/ufw/before6.rules

    ufw allow in on lo
    ufw allow out on lo
    ufw deny in 127.0.0.0/8
    ufw deny out ::1

    ufw logging on
    ufw reload

    read -p "Would you like UFW to be verbose? Y/n > " verboseUFWYesNo
    if [ "$verboseUFWYesNo" == "Y" ]; then
        ufw status verbose
    else
        echo "Script: [$SCRIPT_NUM] ::: UFW not verbose"
    fi

    
}