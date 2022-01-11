#!/bin/sh
#Author: Omar BOUYKOURNE  <omarbpixel@gmail.com>
#42login: obouykou

echo "starting backup service every 5 minutes for mariadb database.."

while true;
do
	# start a backup every 5 min
	date=$(date '+%Y-%m-%d %H:%M:%S')
	dir_name="backup_${date}"
	mkdir "/backup/$dir_name"
	cp -Rf /db_volume/* /backup/"${dir_name}"
	echo "backup done at $date"
	sleep 300
done

exit 0
