#!/bin/bash

SOURCE="rsync://ftp.jaist.ac.jp/pub/Linux/ubuntu"
DEST="/var/spool/apt-mirror/mirror/ftp.jaist.ac.jp/ubuntu"
RSYNC_OPTS="-rtlHv --delete-after --delay-updates --copy-links --safe-links --max-delete=1000 --delete-excluded --exclude=.*"

focal="focal focal-updates focal-backports focal-security focal-proposed"
bionic="bionic bionic-updates bionic-backports bionic-security bionic-proposed"
REPOS="${focal} ${bionic}"

for repo in $REPOS; do
    ${RSYNC} ${SOURCE}/dists/${repo}/main/i18n/       ${TARGET}/dists/${repo}/main/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/restricted/i18n/ ${TARGET}/dists/${repo}/restricted/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/universe/i18n/   ${TARGET}/dists/${repo}/universe/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/multiverse/i18n/ ${TARGET}/dists/${repo}/multiverse/i18n/
done

for repo in $REPOS; do
    for d in main restricted universe multiverse; do
        echo "Syncing $repo/$d/i18n ..."
        rsync $RSYNC_OPTS ${SOURCE}/dists/${repo}/${d}/i18n/     ${DEST}/dists/${repo}/${d}/i18n/
        echo
    done
done

exit 0
