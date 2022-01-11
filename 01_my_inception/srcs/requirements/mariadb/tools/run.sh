#!/bin/sh
#Author: Omar BOUYKOURNE  <omarbpixel@gmail.com>
#42login: obouykou


if ! ls /var/lib/mysql/ib_buffer_pool > /dev/null 2>&1 ; 
then
	echo "Setup MySQL .."
	/etc/init.d/mariadb setup 1>/dev/null && \
	service mariadb start 1>/dev/null
	# delete anonymous user from mysql users
	mysql -u root -e "delete from mysql.user where user=''" 1>/dev/null && \
	mysql -u root -e "flush privileges" 1>/dev/null && \
	mysql -u root -e "create user '${MYSQL_USER_USERNAME}'@'%' identified by '${MYSQL_USER_PASSWORD}'" 1>/dev/null && \
	mysql -u root -e "create database wordpress" 1>/dev/null && \
	mysql -u root -e "grant all privileges on *.* to '${MYSQL_USER_USERNAME}'@'%'" 1>/dev/null && \
	mysql -u root -e "flush privileges" 1>/dev/null && \
	mysql -u root < /wordpress.sql && \
	mysql -u root -e "alter user 'root'@'localhost' identified by '${MYSQL_ROOT_PASSWORD}'"
	service mariadb stop 1>/dev/null
fi

/bin/rm -rf /wordpress.sql
sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

service mariadb start 1>/dev/null
service mariadb stop 1>/dev/null

echo "Starting MariaDB .."
cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
