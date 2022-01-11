FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

#update and install utils
RUN apk update 1>/dev/null

#download wordpress files
RUN wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz 1>/dev/null && \
	rm -rf latest.tar.gz

#install php7 packages
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json \
	php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath \
	php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
	php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session php7-mbstring \
	php7 php7-opcache php7-zlib 1>/dev/null

RUN apk update

# setup php-fpm
RUN sed -i 's|^listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|' /etc/php7/php-fpm.d/www.conf

#copy wp config and redis cache files
ADD ./conf/wp-config.php /wordpress/wp-config.php
ADD ./tools/redis-cache /wordpress/wp-content/plugins/redis-cache
# make redis cache plugin enabled at start 
ADD ./tools/redis-cache/includes/object-cache.php /wordpress/wp-content

#copy the entrypoint script
ADD ./tools/run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT /usr/bin/run.sh
 
