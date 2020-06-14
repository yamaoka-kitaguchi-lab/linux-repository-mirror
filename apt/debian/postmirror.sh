#!/bin/bash

RSYNC="rsync --recursive --times --links --hard-links --delete --delete-after"
SOURCE="rsync://ftp.jp.debian.org/debian"
TARGET="/var/spool/apt-mirror/mirror/ftp.jp.debian.org/debian"

testing="testing testing-updates testing-backports testing-proposed-updates"
bullseye="bullseye bullseye-updates bullseye-backports bullseye-proposed-updates"
buster="buster buster-updates buster-backports buster-proposed-updates"
stretch="stretch stretch-updates stretch-backports stretch-proposed-updates"

REPOS="${testing} ${bullseye} ${buster} ${stretch}"

for repo in $REPOS; do
    ${RSYNC} ${SOURCE}/dists/${repo}/main/i18n/     ${TARGET}/dists/${repo}/main/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/contrib/i18n/  ${TARGET}/dists/${repo}/contrib/i18n/
    ${RSYNC} ${SOURCE}/dists/${repo}/non-free/i18n/ ${TARGET}/dists/${repo}/non-free/i18n/
done
