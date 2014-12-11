#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.$LC_NAME \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/$NAME.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/$NAME/scripts \
	"/Users/jhowe/Desktop/__Apps/$NAME.pkg"
