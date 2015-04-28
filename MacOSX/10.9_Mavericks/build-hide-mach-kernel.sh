#!/bin/bash
sudo pkgbuild \
	--version 2015042801 \
	--identifier org.seattlegirlsschool.hide_mach_kernel \
	--install-location /Applications/Utilities \
	--component /Users/jhowe/Desktop/__Apps/Hide_Mach_Kernel.app \
	--scripts /Users/jhowe/github/scripts/MacOSX/10.9_Mavericks/Hide_Mach_Kernel/scripts \
	"/Users/jhowe/Desktop/__Apps/Hide_Mach_Kernel.pkg"
