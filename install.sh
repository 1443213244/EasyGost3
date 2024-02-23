#!/bin/bash

# 检查 /gost.yaml 是否存在
if [ -f "/gost.yaml" ]; then
    echo "/gost.yaml 文件已存在，脚本退出。"
    exit 1
fi

# 移动并设置权限
mv gost /usr/bin/gost && chmod 755 /usr/bin/gost
mv config.yaml /gost.yaml && chmod 644 /gost.yaml
mv gost.service /usr/lib/systemd/system/gost.service && chmod 644 /usr/lib/systemd/system/gost.service

# 启用并重启服务
systemctl enable gost && systemctl restart gost
