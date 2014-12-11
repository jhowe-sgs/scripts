#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.remove-battery-health \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Remove_Battery_Health.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Remove_Battery_Health/scripts \
	"/Users/jhowe/Desktop/__Apps/Remove_Battery_Health.pkg"
