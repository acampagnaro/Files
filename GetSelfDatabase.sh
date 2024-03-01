#!/bin/bash
# This script will attempt to download and restore the latest backup from aws S3; Should run as root.

# remove old files
rm "/home/ubuntu/filesToRestore/*"

# gets last backup
lastBackupName="$(/usr/bin/aws s3 ls s3://$BACKUP_BUCKET | grep $CUSTOMER | tail -1 | sed 's/.*\(backup-\([a-zA-Z -_0-9]*.zip\)\)/\1/')";
lastBackupAddress="s3://$BACKUP_BUCKET/$lastBackupName"

# Downloads last backup
/usr/bin/aws s3 cp $lastBackupAddress /home/ubuntu/filesToRestore

# Unzips backup
unzip -j -o -d /home/ubuntu/filesToRestore "/home/ubuntu/filesToRestore/$lastBackupName"

# make sure permissions are okay
chmod 666 /home/ubuntu/filesToRestore/*;
chown ubuntu:ubuntu /home/ubuntu/filesToRestore/*

# remove backup zip
rm "/home/ubuntu/filesToRestore/$lastBackupName"
