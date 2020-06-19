#!/bin/bash

MIRROR_U_DEST='/var/spool/portage-mirror/gentoo-portage'
MIRROR_I_DEST='/var/spool/portage-mirror/gentoo'
RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"
RSYNC_EXCLUDE_OPT=""
EXCLUDE_FILE="/opt/exclude.txt"
PATH='/usr/bin'

if [[ -e "$EXCLUDE_FILE" ]] ; then
    RSYNC_EXCLUDE_OPT="--exclude-from=$EXCLUDE_FILE"
fi

sync(){
    source /opt/mirror.conf
    if [[ -z "$MIRROR_U_SRC" ]] || [[ -z "$MIRROR_I_SRC" ]] || [[ -z "$MIRROR_I_REPO" ]]; then
        echo "Required variable MIRROR_U_SRC or MIRROR_I_SRC or MIRROR_I_REPO does not exist in mirror.conf"
        exit 127
    fi

    echo "Step 1 of 2: Syncing rsync mirror ..."
    rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT $MIRROR_U_SRC $MIRROR_U_DEST
    echo

    echo "Step 2 of 2: Syncing source mirror ..."
    for repo in $MIRROR_I_REPO; do
        echo "Syncing $repo ..."
        rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT $MIRROR_I_SRC/$repo $MIRROR_I_DEST
        echo 
    done
}

if [[ -e "$SYNC_TIMEOUT_MIN" ]]; then
    echo "CAUTION: This container will be aborted if the update process is not completed within $SYNC_TIMEOUT_MIN minutes."
    timeout $(( $SYNC_TIMEOUT_MIN * 60 )) sync
else
    sync
fi

exit 0
