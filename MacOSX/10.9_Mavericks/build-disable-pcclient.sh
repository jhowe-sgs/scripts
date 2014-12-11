#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.disable-pcclient \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Disable_PCClient.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Disable_PCClient/scripts \
	"/Users/jhowe/Desktop/__Apps/Disable_PCClient.pkg"
