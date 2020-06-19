#!/bin/bash

DEST='/var/spool/pacman-mirror'
RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"
RSYNC_EXCLUDE_OPT=""
EXCLUDE_FILE="/exclude.txt"
PATH='/usr/bin'

if [[ -e "$EXCLUDE_FILE" ]] ; then
    RSYNC_EXCLUDE_OPT="--exclude-from=$EXCLUDE_FILE"
fi

sync(){
    source /opt/mirror.conf
    if [[ -z "$SOURCE" ]] || [[ -z "$REPOS" ]]; then
        echo "Required variable SOURCE or REPOS does not exist in mirror.conf"
        exit 127
    fi

    for repo in $REPOS ; do
        echo "Syncing $repo ..."
        rsync $RSYNC_OPTS $RSYNC_EXCLUDE_OPT $SOURCE/$repo $DEST
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
