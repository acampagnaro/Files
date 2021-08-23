#!/bin/bash
# Script to install servers-monitor as linux service

SM_INIT_PATH="/home/ubuntu/servers-monitor"

# remove old
sudo /bin/systemctl stop servers-monitor
sudo rm $SM_INIT_PATH

/usr/bin/wget -O "$SM_INIT_PATH" "https://raw.githubusercontent.com/acampagnaro/Files/master/servers-monitor"

sudo chmod +x $SM_INIT_PATH

echo "[Unit]
Description=Monitor server service for SQL servers

[Service]
User=root
WorkingDirectory=/home/ubuntu
EnvironmentFile=/etc/environment
ExecStart=/home/ubuntu/servers-monitor

SuccessExitStatus=0
TimeoutStopSec=10
Restart=on-failure
RestartSec=5

StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=serversmonitorservice

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/servers-monitor.service

sudo /bin/systemctl enable servers-monitor

sudo /bin/systemctl start servers-monitor

sudo ufw allow 8097
