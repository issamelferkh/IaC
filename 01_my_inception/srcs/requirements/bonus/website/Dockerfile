FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

#update and install utils
RUN apk update 1>/dev/null
#install php7 packages
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json \
	php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath \
	php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
	php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session php7-mbstring \
	php7 php7-opcache php7-zlib 1>/dev/null

# add necessary files
ADD ./tools/imgs /imgs
ADD ./tools/index.html /index.html

CMD php -S 0.0.0.0:8090