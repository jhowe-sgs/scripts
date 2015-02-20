#!/bin/bash
sudo pkgbuild \
	--version 201502201310 \
	--identifier org.seattlegirlsschool.sgs_firewall_ca_cert \
	--install-location /Applications \
	--component /Users/jhowe/Desktop/__Apps/SGS_Firewall_CA_Cert.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Install_SGS_Firewall_CA_Certificate/scripts \
	"/Users/jhowe/Desktop/__Apps/SGS_Firewall_CA_Cert.pkg"
