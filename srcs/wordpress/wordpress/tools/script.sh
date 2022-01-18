sed -i 's|DATABASE_NAME|'${DATABASE_NAME}'|' /www/wordpress/wp-config.php
sed -i 's|DATABASE_USER|'${DATABASE_USER}'|' /www/wordpress/wp-config.php
sed -i 's|DB_USER_PASS|'${DB_USER_PASS}'|' /www/wordpress/wp-config.php
sed -i 's|DB__HOST|'${DB__HOST}'|' /www/wordpress/wp-config.php

./usr/sbin/php-fpm7 -F -R
