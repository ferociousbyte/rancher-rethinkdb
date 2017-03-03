#!/bin/bash

url='http://rancher-metadata/2015-12-19'
uuid=$(curl -s "$url/self/container/uuid/")
cmd="rethinkdb --bind all"

while read -r line; do
    id=$(echo $line | grep -oP '[0-9](?=\=)')
    hostname=$(echo $line | grep -oP '(?<=\=).+')

    if [ $(curl -s "$url/self/service/containers/$id/uuid/") != "$uuid" ]; then
        cmd="$cmd --join $hostname"
    fi
done < <(curl -s "$url/self/service/containers/")

echo "$cmd"
echo "----------------------"
$cmd