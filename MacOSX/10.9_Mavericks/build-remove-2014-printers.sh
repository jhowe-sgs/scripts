#!/bin/bash
sudo pkgbuild \
	--version 201507211250 \
	--identifier org.seattlegirlsschool.remove-2014-printers \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Remove_2014_Printers.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Remove_2014_Printers/scripts \
	"/Users/jhowe/Desktop/__Apps/Remove_2014_Printers.pkg"
