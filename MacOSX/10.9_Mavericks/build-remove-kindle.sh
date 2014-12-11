#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.remove-kindle \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Remove_Kindle.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Remove_Kindle/scripts \
	"/Users/jhowe/Desktop/__Apps/Remove_Kindle.pkg"
