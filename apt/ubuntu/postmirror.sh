#!/bin/bash

RSYNC="rsync --recursive --times --links --hard-links --delete --delete-after"
SOURCE="rsync://ftp.jaist.ac.jp/pub/Linux/ubuntu"
TARGET="/var/spool/apt-mirror/mirror/ftp.jaist.ac.jp/ubuntu"

focal="focal focal-updates focal-backports focal-security focal-proposed"
bionic="bionic bionic-updates bionic-backports bionic-security bionic-proposed"
REPOS="${focal} ${bionic}"

for repo in $REPOS; do
    ${RSYNC} ${SOURCE}/dists/${repo}/main/i18n/       ${TARGET}/dists/${repo}/main/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/restricted/i18n/ ${TARGET}/dists/${repo}/restricted/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/universe/i18n/   ${TARGET}/dists/${repo}/universe/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/multiverse/i18n/ ${TARGET}/dists/${repo}/multiverse/i18n/
done
