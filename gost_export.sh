#!/bin/bash

function setDns(){
    echo "Setting DNS..."
    ip=$(curl http://ip.sb)
    if [ $? -ne 0 ]; then
        echo "Error retrieving IP address."
        return 1
    fi
    dns=$(curl https://www.yifei.cool:8080/jeecg-boot/servic/getDns?ip=$ip)
    if [ $? -ne 0 ]; then
        echo "Error retrieving DNS servers."
        return 1
    fi
    dnss=($(echo $dns | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}'))
    if [ -z "$dnss" ]; then
        echo "dnss is empty"
        else
            echo -e "nameserver ${dnss[0]}
nameserver ${dnss[1]}" >/etc/resolv.conf
    if [ $? -ne 0 ]; then
        echo "Error writing to resolv.conf."
        return 1
    fi
    fi
    echo "DNS set."
    return 0
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
    cat "services:
- name: service-51468
  addr: :51468
  handler:
    type: relay
    auth:
      username: "123"
      password: "123"
  listener:
    type: tcp
api:
  addr: :8000
  accesslog: true">./config.yaml
    sudo bash install.sh
    sed -i '$d' /etc/rc.d/rc.local
    rm -rf /gost.sh
}

installGost3
