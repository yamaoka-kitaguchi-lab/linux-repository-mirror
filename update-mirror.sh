#!/bin/sh
cd $(dirname $0)
/usr/bin/docker-compose rm -f
/usr/bin/docker-compose up -d pacman-arch pacman-manjaro apt-ubuntu apt-debian apt-raspberrypi
