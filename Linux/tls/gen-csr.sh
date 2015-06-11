#!/bin/bash

if [ -z "${1}" ]; then
	echo "I need a domain"
	exit 1
else
	D="${1}"
fi

TS=`date +%Y.%m`

for d in $D; do
        if [ ! -d ${TS}/$d ]; then
                mkdir -p ${TS}/$d
        fi
        pushd ${TS}/$d
        openssl req -new -newkey rsa:2048 -nodes -sha256 -out $d.sha256.csr -keyout $d.key
        popd
done
