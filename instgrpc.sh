systemctl stop xray.service

cd /etc/xray
mkdir –m777 grpc
cd
read -p "Press Enter to Continue : "
sleep 1

mkdir /etc/xray/grpc
cd /usr/bin


wget -O port-grpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/port-grpc.sh"
chmod +x port-grpc 

wget -O menu-grpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/menu-grpc.sh"
chmod +x menu-grpc
read -p "Press Enter to Continue : "
sleep 1

service squid start
domain=$(cat /root/domain)
uuid=$(cat /proc/sys/kernel/random/uuid)


cat > /etc/systemd/system/vless-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/etc/xray/xray -config /etc/xray/grpc/vlessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF

cat > /etc/systemd/system/vmess-grpc.service << EOF
[Unit]
Description=XRay VMess GRPC Service
Documentation=https://speedtest.net https://github.com/XTLS/Xray-core
After=network.target nss-lookup.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/etc/xray/xray -config /etc/xray/grpc/vmessgrpc.json
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF

read -p "Press Enter to Continue : "
sleep 1

cat > /etc/xray/grpc/vmessgrpc.json << EOF
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 800,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vmessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
EOF

cat > /etc/xray/grpc/vlessgrpc.json << EOF
{
    "log": {
            "access": "/var/log/xray/access5.log",
        "error": "/var/log/xray/error.log",
        "loglevel": "info"
    },
    "inbounds": [
        {
            "port": 880,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "${uuid}"
#vlessgrpc
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "gun",
                "security": "tls",
                "tlsSettings": {
                    "serverName": "${domain}",
                    "alpn": [
                        "h2"
                    ],
                    "certificates": [
                        {
                            "certificateFile": "/etc/xray/xray.crt",
                            "keyFile": "/etc/xray/xray.key"
                        }
                    ]
                },
                "grpcSettings": {
                    "serviceName": "GunService"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "tag": "direct"
        }
    ]
}
EOF


read -p "Press Enter to Continue : "
sleep 1

iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 800 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 800 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 880 -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 653 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport 653 -j ACCEPT


iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl daemon-reload
systemctl enable vmess-grpc
systemctl restart vmess-grpc
systemctl enable vless-grpc
systemctl restart vless-grpc
systemctl restart xray.service

wget -O addgrpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/addgrpc.sh"
wget -O delgrpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/delgrpc.sh"
wget -O cekgrpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/cekgrpc.sh"
wget -O renewgrpc "https://raw.githubusercontent.com/anzclan/addongrpc/main/renewgrpc.sh"

chmod +x addgrpc
chmod +x delgrpc
chmod +x cekgrpc
chmod +x renewgrpc

cd
rm /root/instgrpc.sh
systemctl start xray.service
read -p "Press Enter to Continue : "
sleep 1