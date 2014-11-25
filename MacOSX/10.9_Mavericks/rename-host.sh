#!/bin/bash

if [ -z "${1}" ]; then
	echo "Usage: $0 new_hostname"
	exit 1
fi

if [ "${EUID}" != "0" ]; then
	echo "Needs more garlic"
	exit 1
fi

MACHINE="${1}"

echo "Setting Computer Names to ${MACHINE}"

scutil --set ComputerName "${MACHINE}"
scutil --set HostName "${MACHINE}"
scutil --set LocalHostName "${MACHINE}"

echo "All Done!"
