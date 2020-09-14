#!/bin/bash

DATA="$( (									\
	df;									\
	echo "---break----------------------------------------------------";	\
	ls -l /var/opt/mssql/data/;						\
	echo "---break----------------------------------------------------";	\
	systemctl status mssql-server;					\
	echo "---break----------------------------------------------------";	\
	free;									\
	echo "---break----------------------------------------------------";	\
	uptime;
) | tr '\r\n' ' ')"

curl -k --location --request POST "https://gugabit-api.herokuapp.com/aws-monitor/status-set/$CUSTOMER" \
--header 'Content-Type: application/json' \
--data-raw "{\"status\":\"$DATA\"}"
