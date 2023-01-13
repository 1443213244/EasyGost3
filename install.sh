#!/bin/bash
mv gost /usr/bin/gost
chmod -R 777 /usr/bin/gost
mv config.yaml /gost.yaml && chmod -R 777 /gost.yaml
chmod -R 777 gost.service && mv gost.service /usr/lib/systemd/system 
systemctl enable gost && systemctl restart gost
