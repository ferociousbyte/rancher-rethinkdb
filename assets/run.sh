#!/bin/bash

uuid=$(curl -s "http://rancher-metadata/2015-12-19/self/container/uuid/")
args="--bind all"

while read -r line; do
    id=$(echo $line | grep -oP '[0-9](?=\=)')
    hostname=$(echo $line | grep -oP '(?<=\=).+')

    if [ $(curl -s "http://rancher-metadata/2015-12-19/self/service/containers/$id/uuid/") != "$uuid" ]; then
        args="$args --join $hostname"
    fi
done < <(curl -s 'http://rancher-metadata/2015-12-19/self/service/containers/')

exec "rethinkdb" "$args"

