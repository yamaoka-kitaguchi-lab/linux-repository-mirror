#!/bin/bash

# SOURCE='rsync://ftp.jaist.ac.jp/pub/Linux/ArchLinux'
# SOURCE='rsync://ftp.nara.wide.ad.jp/pub/Linux/archlinux'
SOURCE='rsync://jpn.mirror.pkgbuild.com/packages'
DEST='/var/spool/pacman-mirror'
REPOS='iso core extra community multilib community-staging multilib-staging community-testing multilib-testing staging testing pool gnome-unstable kde-unstable lastsync lastupdate'
RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"
RSYNC_EXCLUDE_OPT=""
EXCLUDE_FILE="/exclude.txt"
PATH='/usr/bin'

if [[ -e "$EXCLUDE_FILE" ]] ; then
    RSYNC_EXCLUDE_OPT="--exclude-from=$EXCLUDE_FILE"
fi

for REPO in $REPOS ; do
    echo "Syncing $REPO ..."
    rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT ${SOURCE}/${REPO} ${DEST}
    echo
done

exit 0
