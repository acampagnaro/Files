#!/bin/bash
# Script Para Backup De banco De Dados SQL Server + SQLCMD Para Amazon AWS

# Nomes Dos Bancos Que Serão Efetuados Os Backups Separados Por Espaço
declare -a BANCO_NOMES=()

echo "$(date)"
# Inicio Do Backup
for Key in ${BANCO_NOMES[@]};
	do echo "Backup $Key"; /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$DB_PASSWORD" -Q "BACKUP DATABASE $Key TO DISK = N'/var/opt/mssql/data/backups/$Key.bak' WITH NAME = '$Key'";
done

# Compactação .ZIP
sudo rm /home/ubuntu/backup/backup.zip
sudo zip -r /home/ubuntu/backup/backup.zip /var/opt/mssql/data/backups

# Upload Para Bucket AWS S3
sudo aws s3 cp /home/ubuntu/backup/backup.zip s3://$BACKUP_BUCKET/backup-$CUSTOMER-$(date +%Y%m%d-%H%M).zip

sudo reboot
