#!/bin/sh
#Author: Omar BOUYKOURNE  <omarbpixel@gmail.com>
#42login: obouykou


# setup wordpress files if they don't exist or the dir is empty
if ! ls www/wordpress > /dev/null 2>&1 || [ -z "$(ls -A www/wordpress/)" ];
then
	echo 'Setup wordpress ..'
	sed -i "s|wp_db_name|${WORDPRESS_DB_NAME}|" /wordpress/wp-config.php &&\
	sed -i "s|wp_db_user|${WORDPRESS_DB_USER}|" /wordpress/wp-config.php &&\
	sed -i "s|wp_db_password|${WORDPRESS_DB_PASSWORD}|" /wordpress/wp-config.php &&\
	sed -i "s|wp_db_host|${WORDPRESS_DB_HOST}|" /wordpress/wp-config.php &&\
	sed -i "s|wp_table_prefix|${WORDPRESS_TABLE_PREFIX}|" /wordpress/wp-config.php
	mv /wordpress/* /www/wordpress
fi

rm -rf /wordpress

# running php-fpm7 in forground 
echo 'running php-fpm as a forground process'
php-fpm7 -F -R