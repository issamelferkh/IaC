#!/bin/sh

if [ ! -f "/var/lib/mysql/ib_buffer_pool" ];
then
	/etc/init.d/mariadb setup
	/etc/init.d/mariadb start

	mysql -u ${MYSQL_ROOT} < /var/lib/mysql/wp.sql
	rm /var/lib/mysql/wp.sql
	mysql -u ${MYSQL_ROOT} -e "CREATE USER '${DATABASE_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
	mysql -u ${MYSQL_ROOT} -e "CREATE DATABASE wordpress;"
	mysql -u ${MYSQL_ROOT} -e "GRANT ALL PRIVILEGES ON *.* TO '${DATABASE_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
	mysql -u ${MYSQL_ROOT} -e "CREATE USER '${DATABASE_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"
	mysql -u ${MYSQL_ROOT} -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${DATABASE_USER}'@'%' IDENTIFIED BY '${DB_USER_PASS}';"

	mysql -u ${MYSQL_ROOT} -e "ALTER USER '${DATABASE_USER}'@'localhost' IDENTIFIED BY '${DB_USER_PASS}';"
	mysql -u ${MYSQL_ROOT} -e "ALTER USER '${MYSQL_ROOT}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
	sed -i 's/skip-networking/# skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
fi
rc-service mariadb start
rc-service mariadb stop
/usr/bin/mariadbd --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib/mariadb/plugin --user=mysql --pid-file=/run/mysqld/mariadb.pid