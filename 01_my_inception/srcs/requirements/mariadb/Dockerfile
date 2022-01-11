FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

EXPOSE 3306

VOLUME [ "/sys/fs/cgroup" ]

#update and install utils
RUN apk update 1>/dev/null
RUN apk add openrc 1>/dev/null
RUN rc-status 1>/dev/null
RUN touch /run/openrc/softlevel


#install MySQL
RUN apk add mariadb mariadb-client 1>/dev/null

#copy the necessary files
ADD ./tools/run.sh /usr/bin/run.sh
ADD ./tools/wordpress.sql /

RUN chmod +x /usr/bin/run.sh

ENTRYPOINT /usr/bin/run.sh