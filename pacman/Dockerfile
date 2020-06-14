FROM archlinux/base:latest

COPY mirror.sh /mirror.sh

RUN pacman -Syyu --noconfirm rsync && \
    chmod +x /mirror.sh

ENTRYPOINT /mirror.sh
