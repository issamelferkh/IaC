FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

#update and install utils
RUN apk update 1>/dev/null
RUN mkdir /backup

#copy the necessary files
ADD ./tools/run.sh /usr/bin/run.sh
RUN chmod +x /usr/bin/run.sh

ENTRYPOINT /usr/bin/run.sh