#!/bin/bash

DATA="$( (									\
	df;									\
	echo "---break----------------------------------------------------";	\
	ls -l /var/opt/mssql/data/;						\
	echo "---break----------------------------------------------------";	\
	systemctl status mssql-server;						\
	echo "---break----------------------------------------------------";	\
	free;									\
	echo "---break----------------------------------------------------";	\
	uptime;									\
	echo "---break----------------------------------------------------";	\
	cat /etc/hostname;
) | tr '\r\n' ' ')"

curl -k --location --request POST "http://167.99.144.236:8002/aws-monitor/status-set/$CUSTOMER" \
--header 'Content-Type: application/json' \
--data-raw "{\"status\":\"$DATA\"}"
