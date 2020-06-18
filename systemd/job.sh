#!/bin/bash
cd $(dirname $0)/..

ONCE_A_DAY=0
[[ $1 == "--once-a-day" ]] && ONCE_A_DAY=1

prepare(){
    local version=$(git rev-parse HEAD)
    git fetch origin master && git reset --hard HEAD
    if [[ $version != $(git rev-parse HEAD) ]]; then
        docker-compose build --no-cache
    fi
    docker-compose rm -f
}

update_mirror(){
    local mirrors="debian raspbian ubuntu archlinux manjaro"
    (( $ONCE_A_DAY == 1 )) && mirrors="gentoo"
    for mirror in mirrors; do
        docker-compose up -d update-$mirror
    done
}

publish_mirror(){
    local domains="all apt pacman portage"
    for domain in domains; do
        docker-compose up -d nginx-$domain
    done
}

prepare
update_mirror
publish_mirror