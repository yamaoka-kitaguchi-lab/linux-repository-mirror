#!/bin/bash

SOURCE='rsync://ftp.tsukuba.wide.ad.jp/manjaro'
DEST='/var/spool/manjaro-mirror'
REPOS='arm-stable arm-testing arm-unstable pool stable-staging stable state testing unstable'
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
