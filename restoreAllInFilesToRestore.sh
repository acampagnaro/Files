#!/bin/bash
# This script will attempt to restore all .bak files in filesToRestore; Should run as root.

# loop over files restauring
FILES="/home/ubuntu/filesToRestore/*"
for f in $FILES
do
  fileName="$(echo "$f" | sed 's/.*\/\([a-zA-Z -_0-9]*\).bak/\1/')"
  
  if [ "$(echo $f | xargs)" = "$fileName" ]; then
    echo "skipping file $f"
    continue
  fi
  echo "processing $fileName"

  # restaures file
  fileNameNoExt="$(echo "$fileName" | sed 's/\([a-zA-Z -_0-9]*\).bak/\1/')"

  /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$DB_PASSWORD" -Q " \
  USE [master] \
  RESTORE DATABASE [$fileNameNoExt] FROM DISK = N'$f' WITH FILE = 1, NOUNLOAD, STATS = 5";
done
