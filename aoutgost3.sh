#!/bin/bash

function setDns(){
    ip=$(curl http://ip.sb)
    dns=$(curl http://yifei.cool:8080/jeecg-boot/servic/getDns?ip=$ip)
    dnss=($(echo $dns | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}'))
    echo -e "nameserver ${dnss[0]}
nameserver ${dnss[1]}" >/etc/resolv.conf
}


function setMtu(){
    file=/etc/sysconfig/network-scripts/ifcfg-eth0
    mtu=$(grep MTU $file)
    if [ -z $mtu ]; then
        echo "MTU=1500" >> $file
    else
        sed -i "s/$mtu/MTU=1500/" $file
    fi
    systemctl  restart network
}

function installGost3(){
    setMtu
    setDns
    systemctl disable wgrest
	git clone https://github.com/1443213244/EasyGost3.git
	cd EasyGost3
	sudo bash install.sh
}

installGost3
