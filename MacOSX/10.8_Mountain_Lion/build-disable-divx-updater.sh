#!/bin/bash
sudo pkgbuild \
	--version 2013102301 \
	--identifier org.seattlegirlsschool.disable_divx_updater \
	--install-location /Applications \
	--component /Users/serveradmin/Desktop/Disable_DivX_Updater.app \
	--scripts /Users/serveradmin/Desktop/github/scripts/MacOSX/MountainLion/Disable_DivX_Updater/scripts \
	"/Users/serveradmin/Desktop/Disable DivX Updater.pkg"
