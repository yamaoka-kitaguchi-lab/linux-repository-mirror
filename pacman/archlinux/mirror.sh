#!/bin/bash

# SOURCE='rsync://ftp.jaist.ac.jp/pub/Linux/ArchLinux/'
# SOURCE='rsync://ftp.nara.wide.ad.jp/pub/Linux/archlinux/'
SOURCE='rsync://jpn.mirror.pkgbuild.com/'
DEST='/var/spool/pacman-mirror'
REPOS='iso core extra community multilib extra-staging community-staging multilib-staging extra-testing community-testing multilib-testing staging'
RSYNC_OPTS="-rtlHq --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"
RSYNC_EXCLUDE_OPT=""
EXCLUDE_FILE="/exclude.txt"
PATH='/usr/bin'

if [[ -e "$EXCLUDE_FILE" ]] ; then
    RSYNC_EXCLUDE_OPT="--exclude-from=$EXCLUDE_FILE"
fi

for REPO in $REPOS ; do
    echo "Syncing $REPO"
    rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT ${SOURCE}/${REPO} ${DEST}
done

exit 0
