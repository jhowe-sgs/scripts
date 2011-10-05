#!/bin/bash

# blank three 'name' locations
# host
echo "Clearing hostnames"

scutil --set LocalHostName ""
# host? not set
scutil --set HostName ""
# host
scutil --set ComputerName ""

echo -n "Enter new hostname: "
read HOSTNAME

echo "New hostname is ${HOSTNAME}"

scutil --set LocalHostName "${HOSTNAME}"
scutil --set ComputerName "${HOSTNAME}"

# cleanup
echo "Running periodic cleanups"
periodic daily weekly monthly

# Reset local KDC

echo "Clearing KDC from System.keychain"
# Seems this is the most efficient, nuking the com.apple.kerberos.kdc
# Delete the certificate by cleaning a local KDC
security delete-certificate -c "com.apple.kerberos.kdc" /Library/Keychains/System.keychain

# OR bootstrap a new one
# /usr/sbin/systemkeychain -C

# end System.keychain

echo "Deleting local Kerberos Configuration"
# Delete the local Kerberos configuration
dscl . -delete /Config/KerberosKDC

echo "Nuking localKDC lock"
# Kill the file that tells the system NOT to setup a new local KDC
rm /var/db/.configureLocalKDC

echo "Nuking legacy KDC store"
# Delete remnants of previous local KDC
rm -r /var/db/krb5kdc

echo "Creating new local KDC"
# Create a new local KDC
/usr/libexec/configureLocalKDC
