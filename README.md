流控服务

## 安装
git clone https://gitee.com/esong-network_1/easytraffic-control.git

cd easytraffic-control && chmod a+x *.sh && ./install.sh

## 启动服务
systemctl start easytraffic-control

## 添加流控
curl --location --request POST 'http://ip:81/add' \
--header 'Content-Type: application/json' \
--data-raw '{
    "nic":"eth1",
    "port":1010,
    "bandwidth":10,
    "duration":15
}'

## 删除流控
curl --location --request GET 'http://ip:81/del' \
--header 'Content-Type: application/json' \
--data-raw '{
    "nic":"eth1",
    "port":1010,
    "bandwidth":10,
    "duration":15
}'

## 参数说明
nic: 网卡设备

port: 端口

bandwidth: 带宽

duration: 突发时长