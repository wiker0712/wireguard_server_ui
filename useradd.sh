#!/bin/bash
# 인자 순서: 1: userName, 2: serverIp, 3: clientIp
userName=$1
serverIp=$2
clientIp=$3

mkdir -p /config/$userName
wg genkey | tee /config/$userName/privatekey-$userName | wg pubkey > /config/$userName/publickey-$userName
wg genpsk > /config/$userName/presharedkey-$userName
cat << EOF > /config/$userName/$userName.conf
[Interface]
Address = $clientIp
PrivateKey = $(cat /config/$userName/privatekey-$userName)
ListenPort = 51820
DNS = 10.13.13.1

[Peer]
PublicKey = $(cat /config/server/publickey-server)
PresharedKey = $(cat /config/$userName/presharedkey-$userName)
Endpoint = $serverIp:51820
AllowedIPs = 0.0.0.0/0
EOF
qrencode -o /config/$userName/$userName.png < /config/$userName/$userName.conf
cat << EOF >> /config/wg_confs/wg0.conf
[Peer]
# $userName 클라이언트 설정
PublicKey = $(cat /config/$userName/publickey-$userName)
PresharedKey = $(cat /config/$userName/presharedkey-$userName)
AllowedIPs = $clientIp
EOF
wg-quick down wg0 && wg-quick up wg0
