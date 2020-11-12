#!/bin/bash
# This scipt runs every 30 minutes to get and apply updates. Use with CAUTION!
# Este script executa a cada 30 minutos buscando e aplicando atualizações. Use com CUIDADO!

(echo "BACKUP_BUCKET=$BACKUP_BUCKET"; echo "SUBDOMAIN=$(cat /etc/hostname)"; echo "TZ=$TZ"; echo "DB_PASSWORD=$DB_PASSWORD"; echo "CUSTOMER=$(echo "${CUSTOMER//stage/}")") > /etc/environment
