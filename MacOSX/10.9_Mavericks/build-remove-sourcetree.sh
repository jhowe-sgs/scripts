#!/bin/bash
sudo pkgbuild \
	--version 2014121001 \
	--identifier org.seattlegirlsschool.remove-sourcetree \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Remove_SourceTree.app \
	--scripts /Users/jhowe/Desktop/github/scripts/MacOSX/10.9_Mavericks/Remove_SourceTree/scripts \
	"/Users/jhowe/Desktop/__Apps/Remove_SourceTree.pkg"
