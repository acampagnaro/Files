#!/bin/bash
# This script will attempt to download and restore clear databases from aws S3; Should run as root.

# download fresh files
aws s3 cp s3://risc-clinic-bases-limpas/bases-linux/ /home/ubuntu/filesToRestore/ --recursive;

# make sure permissions are okay
chmod 666 /home/ubuntu/filesToRestore/*;

# run retore
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$DB_PASSWORD" -Q " \
USE [master] \
RESTORE DATABASE [Cadastros] FROM DISK = N'/home/ubuntu/filesToRestore/Cadastros.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Integrador_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Integrador_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Cadastros_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Cadastros_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Internacao] FROM DISK = N'/home/ubuntu/filesToRestore/Internacao.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Centrocirurgico] FROM DISK = N'/home/ubuntu/filesToRestore/Centrocirurgico.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Internacao_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Internacao_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Centrocirurgico_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Centrocirurgico_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Laboratorio] FROM DISK = N'/home/ubuntu/filesToRestore/Laboratorio.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Centrocustos] FROM DISK = N'/home/ubuntu/filesToRestore/Centrocustos.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Laboratorio_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Laboratorio_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Centrocustos_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Centrocustos_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Nutricao] FROM DISK = N'/home/ubuntu/filesToRestore/Nutricao.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Clinic] FROM DISK = N'/home/ubuntu/filesToRestore/Clinic.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Nutricao_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Nutricao_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Clinic_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Clinic_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Prescricao] FROM DISK = N'/home/ubuntu/filesToRestore/Prescricao.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Convenios] FROM DISK = N'/home/ubuntu/filesToRestore/Convenios.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Prescricao_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Prescricao_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Convenios_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Convenios_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Radiologia] FROM DISK = N'/home/ubuntu/filesToRestore/Radiologia.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Conveniosex] FROM DISK = N'/home/ubuntu/filesToRestore/Conveniosex.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Radiologia_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Radiologia_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Conveniosex_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Conveniosex_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Sfn] FROM DISK = N'/home/ubuntu/filesToRestore/Sfn.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Enfermagem] FROM DISK = N'/home/ubuntu/filesToRestore/Enfermagem.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Sfn_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Sfn_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Enfermagem_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Enfermagem_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Sus] FROM DISK = N'/home/ubuntu/filesToRestore/Sus.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Estoque] FROM DISK = N'/home/ubuntu/filesToRestore/Estoque.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Sus_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Sus_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Estoque_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Estoque_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Vacinplus] FROM DISK = N'/home/ubuntu/filesToRestore/Vacinplus.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Integrador] FROM DISK = N'/home/ubuntu/filesToRestore/Integrador.bak' WITH FILE = 1, NOUNLOAD, STATS = 5 \
RESTORE DATABASE [Vacinplus_auditoria] FROM DISK = N'/home/ubuntu/filesToRestore/Vacinplus_auditoria.bak' WITH FILE = 1, NOUNLOAD, STATS = 5";
