#!/bin/bash
mv gost /usr/bin/gost
chmod -R 777 /usr/bin/gost
mkdir -p /etc/gost
mv config.yaml /etc/gost/ && chmod -R 777 /etc/gost/*
chmod -R 777 gost.service && mv gost.service /usr/lib/systemd/system 
systemctl enable gost && systemctl restart gost
