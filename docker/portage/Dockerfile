FROM archlinux/base:latest
MAINTAINER Taichi MIYA <tmiya@protonmail.ch>

ARG context

RUN pacman -Syyu --noconfirm rsync

COPY entrypoint.sh /sbin/entrypoint.sh
COPY ${context}/mirror.conf /opt/mirror.conf

RUN chmod +x /sbin/entrypoint.sh

ENTRYPOINT /sbin/entrypoint.sh
