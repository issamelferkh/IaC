FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

EXPOSE 21

#update and install utils
RUN apk add --update vsftpd openssl openssh

#generating an ssl certificate with openssl
RUN echo -e "MA\nKH\nKHOURIBGA\n1337Ltd\nOCP\nOCP SA\nft_services@1337.ma\n" | openssl req \
			-x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out \
			/etc/ssl/private/vsftpd.pem

#edit the vsftpd cofniguration file
RUN echo 'rsa_cert_file=/etc/ssl/private/vsftpd.pem' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'rsa_private_key_file=/etc/ssl/private/vsftpd.pem' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'ssl_enable=YES' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'allow_anon_ssl=NO' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'force_local_data_ssl=YES' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'force_local_logins_ssl=YES' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'ssl_tlsv1=YES' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'ssl_sslv2=NO' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'ssl_sslv3=NO' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'require_ssl_reuse=NO' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'ssl_ciphers=HIGH' >> /etc/vsftpd/vsftpd.conf \
	&& sed -i 's|.*anonymous_enable=YES.*|anonymous_enable=NO|' /etc/vsftpd/vsftpd.conf \
	&& sed -i 's|.*#local_enable=YES.*|local_enable=YES|' /etc/vsftpd/vsftpd.conf \
	&& sed -i 's|.*#write_enable=YES.*|write_enable=YES|' /etc/vsftpd/vsftpd.conf \ 
	&& sed -i 's|.*#chroot_local_user=YES.*|chroot_local_user=YES|' /etc/vsftpd/vsftpd.conf \ 
	&& echo 'allow_writeable_chroot=YES' >> /etc/vsftpd/vsftpd.conf \
	&& echo 'seccomp_sandbox=NO' >> /etc/vsftpd/vsftpd.conf \
	&& echo "pasv_enable=Yes" >> /etc/vsftpd/vsftpd.conf \
	&& echo "pasv_max_port=10100" >> /etc/vsftpd/vsftpd.conf \
	&& echo "pasv_min_port=10100" >> /etc/vsftpd/vsftpd.conf \
	&& echo "pasv_addr_resolve=YES" >> /etc/vsftpd/vsftpd.conf \
	&& echo "pasv_address=127.0.0.1" >> /etc/vsftpd/vsftpd.conf

#copy the necessary files
ADD ./tools/run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT /usr/bin/run.sh
