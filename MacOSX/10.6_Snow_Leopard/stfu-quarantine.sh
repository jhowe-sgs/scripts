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
echo "Apps: Killing it..."
xattr -d -r com.apple.quarantine /Applications

echo
echo "Downloads: Cleaning it..."
xattr -d -r com.apple.quarantine ~/Downloads

echo
echo "Defaults: Setting it..."
defaults write com.apple.LaunchServices LSQuarantine -bool NO

echo
echo "Shhh, my darling"
echo "Dead men tell no tales"
echo
# reboot
