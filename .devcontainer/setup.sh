#!/bin/bash
# Встановлюємо Xray
bash -c "$(curl -L https://github.com)" @ install

# Створюємо базовий конфіг VLESS (WebSocket)
# Замініть UUID на свій (згенеруйте командою 'xray uuid')
cat <<EOF > /usr/local/etc/xray/config.json
{
    "log": { "loglevel": "warning" },
    "inbounds": [{
        "port": 8080,
        "protocol": "vless",
        "settings": {
            "clients": [{"id": "27e1181c-0861-44ad-b019-bdb1f8730b1e"}],
            "decryption": "none"
        },
        "streamSettings": {
            "network": "ws",
            "wsSettings": { "path": "/vless" }
        }
    }],
    "outbounds": [{ "protocol": "freedom" }]
}
EOF

# Запускаємо сервер у фоні
sudo systemctl start xray
