#!/bin/bash
# This script will attempt to download and restore clear databases from aws S3; Should run as root.

# remove old files
rm "/home/ubuntu/filesToRestore/*"

# Downloads fresh database
aws s3 cp s3://risc-clinic-bases-limpas/bases-linux/ /home/ubuntu/filesToRestore --recursive;

# make sure permissions are okay
chmod 666 /home/ubuntu/filesToRestore/*;
chown ubuntu:ubuntu /home/ubuntu/filesToRestore/*
