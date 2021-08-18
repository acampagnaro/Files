#!/bin/bash
# Script Para Backup De banco De Dados SQL Server + SQLCMD Para Amazon AWS

# Exibe a data para fins de organizaç~ao no arquivo de log
echo " "
echo "-----------------------------------------------------------------------------"
echo "------------------- $(date) -------------------"

#Exibe espaço no disco
echo "Disk Info: -----------------------------"
df -h
echo " "

HOME="/root/"

# Reduz logs
echo "Reduzindo Logs -----------------------------"
/opt/mssql-tools/bin/sqlcmd -S localhost -U "$DB_USER" -P "$DB_PASSWORD" -Q "\
	DECLARE @NOME_BANCO VARCHAR(50) \
	DECLARE @NOME_CLIENTE VARCHAR(50) \
	DECLARE @SQLEXECUTE VARCHAR(8000) \
	DECLARE @BackupAWS CURSOR \
	  SET @BackupAWS = CURSOR FOR \
	    select \
		a.name, \
		b.tbValor \
	    from sysdatabases as a \
	    left join clinic.dbo.parametros as b \
		on 1 = 1 \
	    where a.name not in ('master', 'tempdb', 'model', 'msdb', 'rdsadmin') and b.tbChave = 'nomecli'; \
	  OPEN @BackupAWS \
	  FETCH NEXT \
	    FROM @BackupAWS INTO @NOME_BANCO, @NOME_CLIENTE \
	  WHILE @@FETCH_STATUS = 0 \
	  BEGIN \
	    SET @SQLEXECUTE = \
	    ' USE ' + @NOME_BANCO + ' \
		  ALTER DATABASE ' + @NOME_BANCO + ' \
		      SET RECOVERY SIMPLE; \
		  DBCC SHRINKFILE (' + @NOME_BANCO + '_log, 1) \
		  ALTER DATABASE ' + @NOME_BANCO + ' \
		      SET RECOVERY FULL \
		  '\
	    EXEC(@SQLEXECUTE) \
	    FETCH NEXT \
	    FROM @BackupAWS INTO @NOME_BANCO, @NOME_CLIENTE \
	  End \
	CLOSE @BackupAWS \
	DEALLOCATE @BackupAWS";

# Exibe tamanho dos arquivos
echo "Files Info: -----------------------------"
ls -lh /var/opt/mssql/data/
echo " "

# Inicio Do Backup
echo "Iniciando backup -----------------------------"
/opt/mssql-tools/bin/sqlcmd -S localhost -U "$DB_USER" -P "$DB_PASSWORD" -Q "\
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

# Changing permissions
sudo chmod 666 /var/opt/mssql/data/backups/*.bak

# Compactação .ZIP
echo "Compactando backup -----------------------------"
sudo zip -r /home/ubuntu/backup/backup.zip /var/opt/mssql/data/backups

# Upload Para Bucket AWS S3
echo 'Starting upload...'
BACKUP_NAME="backup-$CUSTOMER-$(date +%Y%m%d-%H%M).zip"
echo "BACKUP_NAME=$BACKUP_NAME"
sudo /usr/bin/aws s3 cp /home/ubuntu/backup/backup.zip s3://risc-clinic-atualizacoes/$BACKUP_NAME

#Exibe tamanho do backup comprimido
echo "Tamanho do backup comprimido: "
ls -lh /home/ubuntu/backup/

# Deletando backup da maquina
echo "Removendo backup -----------------------------"
sudo rm /var/opt/mssql/data/backups/*
sudo rm /home/ubuntu/backup/backup.zip

# Atualiza hora do ultimo backup
curl --location --request POST "https://aws-monitor.spitzer.io/aws-monitor/update-last-backup/$CUSTOMER"

#sleep 5s
#Atualiza o servidor
#echo "Updating........"
#sudo apt update && sudo apt upgrade
