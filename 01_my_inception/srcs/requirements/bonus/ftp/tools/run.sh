#!/bin/sh
#Author: Omar BOUYKOURNE  <omarbpixel@gmail.com>
#42login: obouykou

# creating user which we will mount the wordpress volume to his home folder
adduser -D "${FTP_USERNAME}" && echo "${FTP_USERNAME}":"${FTP_PASSWORD}" | chpasswd
ssh-keygen -A
chown -R "${FTP_USERNAME}":"${FTP_USERNAME}" /home/"${FTP_USERNAME}"

echo 'starting ftp..'
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf