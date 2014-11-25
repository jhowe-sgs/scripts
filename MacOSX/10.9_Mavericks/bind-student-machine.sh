#!/bin/bash

if [ -z "${1}" ]; then
	echo "Usage: $0 hostname_to_bind"
	exit 1
fi

if [ "${EUID}" != "0" ]; then
	echo "Needs more garlic"
	exit 1
fi

MACHINE="${1}"

AD_ADMIN="Administrator"
AD_PASS="SOOPER_SEEKRIT"
AD_DOMAIN="seattlegirlsschool.org"
AD_SHELL="/bin/bash"

OD_ADMIN="diradmin"
OD_PASS="SOOPER_SEEKRIT"
OD_SERVER="saraswati.seattlegirlsschool.org"

echo "Setting Computer Names to ${MACHINE}"

scutil --set ComputerName "${MACHINE}"
scutil --set HostName "${MACHINE}"
scutil --set LocalHostName "${MACHINE}"

echo "Running Active Directory"

dsconfigad \
	-add ${AD_DOMAIN} \
	-username ${AD_ADMIN} \
	-password ${AD_PASS} \
	-computer ${MACHINE} \
	-mobile enable \
	-mobileconfirm disable \
	-localhome enable \
	-useuncpath enable \
	-protocol smb \
	-shell ${AD_SHELL} \
	-authority enable \
	-groups "domain admins,enterprise admins" \
	-alldomains enable \
	-packetsign allow \
	-packetencrypt allow \
	-namespace domain 

echo "Running Open Directory"

dsconfigldap \
	-sfa ${OD_SERVER} \
	-c ${MACHINE} \
	-u ${OD_ADMIN} \
	-p ${OD_PASS} \
	-N

echo "Tweak Managed Software Updates"

GRADE=`echo $MACHINE | cut -d\- -f1`

echo "defaults write /Library/Preferences/ManagedInstalls ClientIdentifier \"${GRADE}th_grade_students\""

defaults write /Library/Preferences/ManagedInstalls ClientIdentifier "${GRADE}th_grade_students"

echo "All Done!"
