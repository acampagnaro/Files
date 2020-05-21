#!/bin/bash
# Script Para Backup De banco De Dados SQL Server + SQLCMD Para Amazon AWS

# Exibe a data para fins de organizaç~ao no arquivo de log
echo " "
echo "-----------------------------------------------------------------------------"
echo "------------------- $(date) -------------------"

# Inicio Do Backup
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$DB_PASSWORD" -Q "\
	DECLARE @name VARCHAR(50) \
	DECLARE @path VARCHAR(256) \
	DECLARE @fileName VARCHAR(256) \
	DECLARE @fileDate VARCHAR(20) \
	SET @path = '/var/opt/mssql/data/backups/' \
	DECLARE db_cursor CURSOR FOR \
	SELECT name \
	FROM master.dbo.sysdatabases \
	WHERE name NOT IN ('master','model','msdb','tempdb') \
	OPEN db_cursor \
	FETCH NEXT FROM db_cursor INTO @name \
	WHILE @@FETCH_STATUS = 0 \
	BEGIN \
		SET @fileName = @path + @name + '.bak' \
		BACKUP DATABASE @name TO DISK = @fileName \
		FETCH NEXT FROM db_cursor INTO @name \
	END \
	CLOSE db_cursor \
	DEALLOCATE db_cursor";

# Compactação .ZIP
sudo rm /home/ubuntu/backup/backup.zip
sudo zip -r /home/ubuntu/backup/backup.zip /var/opt/mssql/data/backups

# Upload Para Bucket AWS S3
sudo aws s3 cp /home/ubuntu/backup/backup.zip s3://$BACKUP_BUCKET/backup-$CUSTOMER-$(date +%Y%m%d-%H%M).zip

# Reinicia o servidor ao fim do backup
sudo reboot
