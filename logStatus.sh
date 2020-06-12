#!/bin/bash

logStuff () {
	df
	echo "---break----------------------------------------------------"
	ls -l /var/opt/mssql/data/
	echo "---break----------------------------------------------------"
	systemctl status mssql-server
}

DATA="$(logStuff | tr '\r\n' ' ')"

curl --location --request POST "https://spitzer-monitor.herokuapp.com/status-set/$CUSTOMER" \
--header 'Content-Type: application/json' \
--data-raw "{\"status\":\"$DATA\"}"
