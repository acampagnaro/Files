#!/bin/bash

function logStuff {
	df
	echo "---break----------------------------------------------------"
	ls -lh /var/opt/mssql/data/
	echo "---break----------------------------------------------------"
	systemctl status mssql-server
}

DATA="$(logStuff)"

curl --location --request POST "https://spitzer-monitor.herokuapp.com/status-set/$CUSTOMER" \
--header 'Content-Type: application/json' \
--data-raw "{\"status\":\"$DATA\"}"
