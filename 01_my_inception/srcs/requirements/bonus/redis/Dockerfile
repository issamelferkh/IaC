FROM alpine:3.14.2
LABEL maintainer="Omar BOUYKOURNE <omarbpixel@gmail.com>"

#update and install redis
RUN apk --update add redis

# start redis cache
CMD redis-server --maxmemory 256mb --maxmemory-policy allkeys-lru --protected-mode no
