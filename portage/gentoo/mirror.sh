#!/bin/bash

MIRROR_U_SRC='rsync://rsync.jp.gentoo.org/gentoo-portage/'
MIRROR_I_SRC='rsync://ftp.iij.ad.jp/pub/linux/gentoo/'
MIRROR_U_DEST='/var/spool/portage-mirror/gentoo-portage'
MIRROR_I_DEST='/var/spool/portage-mirror/gentoo'

RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"
RSYNC_EXCLUDE_OPT=""
EXCLUDE_FILE="/exclude.txt"
PATH='/usr/bin'

if [[ -e "$EXCLUDE_FILE" ]] ; then
    RSYNC_EXCLUDE_OPT="--exclude-from=$EXCLUDE_FILE"
fi

echo "Step 1 of 2: Syncing rsync mirror ..."
rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT $MIRROR_U_SRC $MIRROR_U_DEST

echo "Step 2 of 2: Syncing source mirror ..."
rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT $MIRROR_S_SRC $MIRROR_S_DEST

exit 0
