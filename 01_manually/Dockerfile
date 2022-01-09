# Debian buster OS
FROM debian:buster

# Installations
RUN apt-get -y update
RUN apt-get -y install nginx \
    mariadb-server \                        
    php-fpm php-mysql \                        
    wget dialog apt-utils \                        
    php php-cgi php-mysqli php-pear php-mbstring php-gettext php-common php-phpseclib php-mysql

# Config
  # Set the working directory for your server.
WORKDIR /var/www/localhost

  # Conf nginx

COPY srcs/nginx.config /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/

COPY ./srcs/admin+wp.sh ./ 
RUN bash ./admin+wp.sh && rm -rf ./admin+wp.sh

COPY ./srcs/config.inc.php /var/www/myserver/phpmyadmin/
COPY ./srcs/wp-config.php /var/www/myserver/wordpress/

# PERMISSIONS]
RUN chown -R www-data:www-data ../**/**                       
RUN chown -R 755 /var/www/myserver                       
RUN chmod -R 755 /var/www/*

# SSL
RUN openssl req -x509 -nodes -days 365 -subj "/C=BE/ST=Belgium/L=your_city/O=your_building/OU=your_office/CN=your_name" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

# CMD
COPY ./srcs/autoindex_off.sh ./
COPY ./srcs/autoindex_on.sh ./
COPY ./srcs/init.sh ./
CMD /bin/bash ./init.sh

EXPOSE 80 443




