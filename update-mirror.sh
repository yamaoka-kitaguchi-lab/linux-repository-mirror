#!/bin/sh
cd $(dirname $0)
/usr/bin/docker-compose up -d pacman apt-ubuntu apt-raspberrypi
