FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

COPY mirror.list /etc/apt/mirror.list

RUN apt-get update && \
    apt-get install -y apt-mirror

ENTRYPOINT /usr/bin/apt-mirror
