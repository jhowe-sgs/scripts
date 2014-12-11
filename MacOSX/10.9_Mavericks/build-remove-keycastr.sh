#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.remove-keycastr \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Remove_KeyCastr.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Remove_KeyCastr/scripts \
	"/Users/jhowe/Desktop/__Apps/Remove_KeyCastr.pkg"
