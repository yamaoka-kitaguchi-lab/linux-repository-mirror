FROM ubuntu:latest
MAINTAINER Taichi MIYA <tmiya@protonmail.ch>

ARG context

RUN apt-get update && \
    apt-get install -y apt-mirror rsync

COPY entrypoint.sh /sbin/entrypoint.sh
COPY ${context}/mirror.list /etc/apt/mirror.list
COPY ${context}/postmirror.sh /var/spool/apt-mirror/var/postmirror.sh

RUN chmod +x /sbin/entrypoint.sh && \
    chmod +x /var/spool/apt-mirror/var/postmirror.sh

ENTRYPOINT /sbin/entrypoint.sh
