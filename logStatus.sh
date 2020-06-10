#!/bin/bash

logStuff () {
	df -h
	ls -lh /var/opt/mssql/data/
	systemctl status mssql-server
}

logStuff() >> a.log
#rm a.log
