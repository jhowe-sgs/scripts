#!/bin/bash

CERT=pa-500.crt
CERT_DIR=/tmp

if [ -s ${CERT_DIR}/${CERT} ]; then
	echo "Removing stale CA cert..."
	rm -f ${CERT_DIR}/${CERT}
fi

echo "Creating CA Cert..."

cat > ${CERT_DIR}/${CERT} <<EOF
-----BEGIN CERTIFICATE-----
MIIEFDCCAvygAwIBAgIJAJ/yrfGfnWFEMA0GCSqGSIb3DQEBCwUAMIG5MQswCQYD
VQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHU2VhdHRsZTEM
MAoGA1UEChMDU0dTMR4wHAYDVQQLExVTU0wgRGVjcnlwdGlvbiBQb2xpY3kxJjAk
BgNVBAMTHXBhLTUwMC5zZWF0dGxlZ2lybHNzY2hvb2wub3JnMS0wKwYJKoZIhvcN
AQkBFh5zdXBwb3J0QHNlYXR0bGVnaXJsc3NjaG9vbC5vcmcwHhcNMTUwMjE5MDAx
NDI5WhcNMjUwMjE4MDAxNDI5WjCBuTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
c2hpbmd0b24xEDAOBgNVBAcTB1NlYXR0bGUxDDAKBgNVBAoTA1NHUzEeMBwGA1UE
CxMVU1NMIERlY3J5cHRpb24gUG9saWN5MSYwJAYDVQQDEx1wYS01MDAuc2VhdHRs
ZWdpcmxzc2Nob29sLm9yZzEtMCsGCSqGSIb3DQEJARYec3VwcG9ydEBzZWF0dGxl
Z2lybHNzY2hvb2wub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
z7L68SGWb+A2KMeknNLBBOb//efRvVA5wn+zQxuRSzSdvUln3222pIqfeIdjwBB/
RsoMFAUx+8IDa/7BBrgBoF2D1MbrebTUGLRlWXsJGP0WHoi3/M89yClBc/GGFLlq
av5TaIqjirkmcEp5BwIplj7+HYu1WIEJ3qbEkYGdm0W9TCXrwrlxAuo/SlSBdyhy
2BY7pNonzjnORRV5RZUa+E3RwHlg+P6rASFNA0jLWuoZgKcXlPrx9Fpm+Q4QrwYT
7ooLJpyClILnz3qk3Mf4RBg0r+R4z98bp4wTwljTqmxebH4h8BrZvuqu8GGQ+IeB
aoBgiIg3osrvgBE+oNWI/wIDAQABox0wGzAMBgNVHRMEBTADAQH/MAsGA1UdDwQE
AwICBDANBgkqhkiG9w0BAQsFAAOCAQEAXR+oi1TV6c66nuyzR6MDxbTijz8/Ur/K
Orbos4tQKBzKsFMv4yz4Gij2uMtGaxoyXbUdfOC2Sjqq/iXYSWFv05BHzr7rXBW8
PI/CUJeHBL31o5hPOZf60FO6vpZ5Y/bMlNzemFaH7jwcJp1ys58/yOgcZkKexC9M
sop+6bSbHZoTsfguSVYxNrrukAbitxgcRuo2rpUDbKxnXBV/CM5qVNqXQVRHmZQr
va8gNU0qY5S6Baw1Ek05VwhhffsQXTNQ62Mp4nhU8Y+nHMQYR5jYRT8ssX45y8vr
ZzkKhFepJKgyGQRCfER+GcfadvTcYwnN69Ut7TQ6KkKXoNOcbm8EaQ==
-----END CERTIFICATE-----
EOF

if [ -s ${CERT_DIR}/${CERT} ]; then
	echo "Installing CA Cert..."
	su root -c "sudo security -v add-trusted-cert -d \
		-r trustRoot \
		-k /Library/Keychains/System.keychain \
		/${CERT_DIR}/${CERT}"
	RES=$?
	if [ $RES -ne 0 ]; then
		echo "Error installing CA Cert..."
	else
		echo "CA Cert installed..."
	fi
	echo "Removing CA Cert..."
	srm ${CERT_DIR}/${CERT}
else
	echo "Error! Expected CA Cert file..."
	exit 1
fi
