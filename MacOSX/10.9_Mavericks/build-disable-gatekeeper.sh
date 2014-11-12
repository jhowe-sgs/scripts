#!/bin/bash
sudo pkgbuild \
	--version 2014111101 \
	--identifier org.seattlegirlsschool.disable_gatekeeper \
	--install-location /Applications \
	--component /Users/jhowe/Desktop/DisableGateKeeper.app \
	--scripts /Users/jhowe/Desktop/Projects/github/jhowe-sgs/scripts/MacOSX/10.9_Mavericks/DisableGateKeeper/scripts \
	"/Users/jhowe/Desktop/DisableGateKeeper.pkg"
