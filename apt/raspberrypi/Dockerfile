FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-mirror rsync

COPY mirror.list /etc/apt/mirror.list

ENTRYPOINT /usr/bin/apt-mirror
