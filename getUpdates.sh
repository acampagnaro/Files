#!/bin/bash
# This scipt runs every 30 minutes to get and apply updates. Use with CAUTION!
# Este script executa a cada 30 minutos buscando e aplicando atualizações. Use com CUIDADO!


echo "0 0-23/12 * * * wget -qO- https://raw.githubusercontent.com/Gugabit/Files/master/backupScript.sh | sh >> /home/ubuntu/logs/backup.log" >> mycron	
echo "0-59/30 * * * * wget -qO- https://raw.githubusercontent.com/Gugabit/Files/master/getUpdates.sh | sh >> /home/ubuntu/logs/update.log" >> mycron	
echo "0-59/10 * * * * wget -qO- https://raw.githubusercontent.com/Gugabit/Files/master/logStatus.sh | sh" >> mycron	
echo "5 3 * * * sudo reboot" >> mycron	
crontab mycron	
rm mycron	
crontab -l
