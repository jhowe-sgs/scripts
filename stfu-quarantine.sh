#!/bin/sh

if [ ${EUID} -ne 0 ]; then
	echo
	echo "You need to use the force Luke!"
	echo "Continue to train, young Jedi Warrior"
	echo
	echo "I hunger"
	echo "Rawwwrrrrr"
	echo "I am Sinistar"
	echo
	exit 1
fi

echo
echo "Files: Killing it..."
find /Applications -type f -exec xattr -d com.apple.quarantine {} \;

echo
echo "Dirs: Killing it..."
find /Applications -type d -exec xattr -d com.apple.quarantine {} \;

echo
echo "Defaults: Setting it..."
defaults write com.apple.LaunchServices LSQuarantine -bool NO

echo
echo "Dead men tell no tales"
reboot
