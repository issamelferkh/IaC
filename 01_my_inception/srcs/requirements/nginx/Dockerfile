FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

EXPOSE 443

#update and install utils
RUN apk update
RUN apk add nginx

#install openssl to generate an ssl certificate with it
RUN apk add openssl
RUN echo -e "MA\nKH\nKHOURIBGA\n1337Ltd\nOCP\nOCP SA\ninception@1337.ma\n" | openssl req \
    -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt >/dev/null 2>&1

#copy the necessary files
ADD ./conf/nginx.conf /etc/nginx/nginx.conf

CMD nginx -g 'daemon off;'
