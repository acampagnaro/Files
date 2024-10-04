#!/bin/bash
# This scipt runs every 30 minutes to get and apply updates. Use with CAUTION!
# Este script executa a cada 30 minutos buscando e aplicando atualizações. Use com CUIDADO!

# Setup cron
echo "0 0-23/12 * * * wget -qO- https://gitlab.com/Gugabit/tools/-/raw/main/server-scripts/backupScript.sh | /bin/bash >> /home/ubuntu/logs/backup.log" >> mycron
echo "0-59/30 * * * * wget -qO- https://gitlab.com/Gugabit/tools/-/raw/main/server-scripts/getUpdates.sh | /bin/bash >> /home/ubuntu/logs/update.log" >> mycron
echo "0-59/10 * * * * wget -qO- https://gitlab.com/Gugabit/tools/-/raw/main/server-scripts/logStatus.sh | /bin/bash" >> mycron
echo "5 3 * * * reboot" >> mycron

crontab mycron
rm mycron
crontab -l
