FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-mirror

COPY mirror.list /etc/apt/mirror.list
COPY postmirror.sh /var/spool/apt-mirror/var/postmirror.sh

RUN chmod +x /var/spool/apt-mirror/var/postmirror.sh

ENTRYPOINT /usr/bin/apt-mirror
