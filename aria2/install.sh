#!/bin/sh

set -eu

echo "[*] Creating user aria2 if not exists..."
if ! id aria2 &>/dev/null; then
    sudo useradd -r -s /usr/sbin/nologin aria2
    echo "[+] User aria2 created."
else
    echo "[=] User aria2 already exists."
fi

echo "[*] Preparing"
mkdir -p /home/share/aria2/downloads 
chmod -R 777 /home/share/aria2/downloads
mkdir -p /var/lib/aria2 && touch /var/lib/aria2/aria2.session
chown -R aria2:aria2 /var/lib/aria2

echo "[*] Installing service file..."
install -m644 ./aria2.service /etc/systemd/system/aria2.service

echo "[*] Installing aria2 config..."
install -Dm644 ./etc/aria2/aria2.conf /etc/aria2/aria2.conf

echo "[*] Installing helper scripts..."
install -Dm755 ./usr/local/bin/aria2c-iptables-setup.sh /usr/local/bin/aria2c-iptables-setup.sh
install -Dm755 ./usr/local/bin/aria2c-iptables-cleanup.sh /usr/local/bin/aria2c-iptables-cleanup.sh

echo "[*] Reloading systemd..."
systemctl daemon-reload

echo "[*] Enabling service..."
systemctl enable aria2.service

echo "[+] Installation complete. You can now start the service:"
echo "    sudo systemctl start aria2c.service"
