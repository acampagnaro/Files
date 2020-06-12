#!/bin/bash

DATA="$( (										\
	df;									\
	echo "---break----------------------------------------------------";	\
	ls -l /var/opt/mssql/data/;						\
	echo "---break----------------------------------------------------";	\
	systemctl status mssql-server;					\
) | tr '\r\n' ' ')"

curl -k --location --request POST "https://spitzer-monitor.herokuapp.com/status-set/$CUSTOMER" \
--header 'Content-Type: application/json' \
--data-raw "{\"status\":\"$DATA\"}"
