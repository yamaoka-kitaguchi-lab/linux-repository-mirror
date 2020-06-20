#!/bin/bash

## Debian worldwide mirror sites
## https://www.debian.org/mirror/list-full

SOURCE="rsync://hanzubon.jp/debian"
DEST="/var/spool/apt-mirror/mirror/ftp.jp.debian.org/debian"
RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"

testing="testing testing-updates testing-backports testing-proposed-updates"
bullseye="bullseye bullseye-updates bullseye-backports bullseye-proposed-updates"
buster="buster buster-updates buster-backports buster-proposed-updates"
stretch="stretch stretch-updates stretch-backports stretch-proposed-updates"
REPOS="${testing} ${bullseye} ${buster} ${stretch}"

for repo in $REPOS; do
    for d in main contrib non-free; do
        echo "Syncing $repo/$d/i18n ..."
        rsync $RSYNC_OPTS ${SOURCE}/dists/${repo}/${d}/i18n/     ${DEST}/dists/${repo}/${d}/i18n/
        echo

        echo "Syncing $repo/$d/cnf ..."
        rsync $RSYNC_OPTS ${SOURCE}/dists/${repo}/${d}/cnf/     ${DEST}/dists/${repo}/${d}/cnf/
        echo
    done
done

exit 0
