#!/bin/bash

if [ ${EUID} -ne 0 ]; then
	echo
	echo "Use the Force Luke..."
	echo
	exit 1
fi

echo "Working on Alfred..."
rm -rf /Applications/SGS\ Applications/Utilities/Alfred.app
mv Alfred.app /Applications/SGS\ Applications/Utilities

echo "Working on Aperture..."
rm -rf /Applications/Aperture.app
mv Aperture.app /Applications

echo "Working on Arduino..."
rm -rf /Applications/SGS\ Applications/Programming\ Apps/Arduino.app
mv Arduino.app /Applications/SGS\ Applications/Programming\ Apps

echo "Working on Battery Health Monitor..."
rm -rf /Applications/SGS\ Applications/Utilities/Battery\ Health\ Monitor.app
mv Battery\ Health\ Monitor.app /Applications/SGS\ Applications/Utilities

echo "Working on Burn..."
rm -rf /Applications/SGS\ Applications/Utilities/CD-DVD\ Tools/Burn.localized
mv Burn.localized /Applications/SGS\ Applications/Utilities/CD-DVD\ Tools

echo "Working on Celtz..."
rm -rf /Applications/SGS\ Applications/Screenplay\ Apps/Celtx.app
mv Celtx.app /Applications/SGS\ Applications/Screenplay\ Apps

echo "Working on coconutBattery..."
rm -rf /Applications/SGS\ Applications/Utilities/coconutBattery.app
mv coconutBattery.app /Applications/SGS\ Applications/Utilities

echo "Working on Deeper..."
rm -rf /Applications/SGS\ Applications/SysAdmin/Deeper.app
mv Deeper.app /Applications/SGS\ Applications/SysAdmin

echo "Working on Dropbox..."
rm -rf /Applications/SGS\ Applications/Cloud\ Apps/Dropbox.app
mv Dropbox.app /Applications/SGS\ Applications/Cloud\ Apps

echo "Working on EasyWMV..."
rm -rf /Applications/SGS\ Applications/Media\ Converters/EasyWMV.app
mv EasyWMV.app /Applications/SGS\ Applications/Media\ Converters

echo "Working on Final Cut Pro..."
rm -rf /Applications/Final\ Cut\ Pro.app
mv Final\ Cut\ Pro.app /Applications

echo "Working on Firefox..."
rm -rf /Applications/SGS\ Applications/Internet\ Browsers/Firefox.app
mv Firefox.app /Applications/SGS\ Applications/Internet\ Browsers

echo "Working on Flux..."
rm -rf /Applications/SGS\ Applications/Utilities/Flux.app
mv Flux.app /Applications/SGS\ Applications/Utilities

echo "Working on Github..."
rm -rf /Applications/SGS\ Applications/Programming\ Apps/GitHub.app
mv GitHub.app /Applications/SGS\ Applications/Programming\ Apps

echo "Working on Google Chrome..."
rm -rf /Applications/SGS\ Applications/Internet\ Browsers/Google\ Chrome.app
mv Google\ Chrome.app /Applications/SGS\ Applications/Internet\ Browsers

echo "Working on Google Earth..."
rm -rf /Applications/SGS\ Applications/GIS\ Apps/Google\ Earth.app
mv Google\ Earth.app /Applications/SGS\ Applications/GIS\ Apps

echo "Working on HandBrake..."
rm -rf /Applications/SGS\ Applications/Media\ Converters/HandBrake.app
mv HandBrake.app /Applications/SGS\ Applications/Media\ Converters

echo "Working on iProcrastinate..."
rm -rf /Applications/SGS\ Applications/Task\ Management/iProcrastinate.app
mv iProcrastinate.app /Applications/SGS\ Applications/Task\ Management

echo "Working on Kindle..."
rm -rf /Applications/SGS\ Applications/eBook\ Apps/Kindle.app
mv Kindle.app /Applications/SGS\ Applications/eBook\ Apps

echo "Working on Learn Pixelmator..."
rm -rf /Applications/Learn\ \-\ Pixelmator\ 2\ Edition.app
mv Learn\ \-\ Pixelmator\ 2\ Edition.app /Applications

echo "Working on LibreOffice..."
rm -rf /Applications/SGS\ Applications/Office\ Apps/LibreOffice.app
mv LibreOffice.app /Applications/SGS\ Applications/Office\ Apps

echo "Working on Motion..."
rm -rf /Applications/Motion.app
mv Motion.app /Applications

echo "Working on OnyX..."
rm -rf /Applications/SGS\ Applications/SysAdmin/OnyX.app
mv OnyX.app /Applications/SGS\ Applications/SysAdmin

echo "Working on OpenOffice..."
rm -rf /Applications/SGS\ Applications/Office\ Apps/OpenOffice.org.app
mv OpenOffice.org.app /Applications/SGS\ Applications/Office\ Apps

echo "Working on PDF Converter Free..."
rm -rf /Applications/SGS\ Applications/Utilities/PDF\ Converter\ Free.app
mv PDF\ Converter\ Free.app /Applications/SGS\ Applications/Utilities

echo "Working on PDF OCR X..."
rm -rf /Applications/SGS\ Applications/OCR\ Apps/PDF\ OCR\ X.app
mv PDF\ OCR\ X.app /Applications/SGS\ Applications/OCR\ Apps

echo "Working on Picassa..."
rm -rf /Applications/SGS\ Applications/Picture\ Apps/Picasa.app
mv Picasa.app /Applications/SGS\ Applications/Picture\ Apps

echo "Working on Pixelmator..."
rm -rf /Applications/Pixelmator.app
mv Pixelmator.app /Applications

echo "Working on Postbox..."
rm -rf /Applications/SGS\ Applications/E-Mail/Postbox.app
mv Postbox.app /Applications/SGS\ Applications/E-Mail

echo "Working on Skitch..."
rm -rf /Applications/SGS\ Applications/Utilities/Image\ Capture/Skitch.app
mv Skitch.app /Applications/SGS\ Applications/Utilities/Image\ Capture

echo "Working on SourceTree..."
rm -rf /Applications/SGS\ Applications/Programming\ Apps/SourceTree.app
mv SourceTree.app /Applications/SGS\ Applications/Programming\ Apps

echo "Working on Sparrow..."
rm -rf /Applications/SGS\ Applications/E-Mail/Sparrow.app
mv Sparrow.app /Applications/SGS\ Applications/E-Mail

echo "Working on TextWrangler..."
rm -rf /Applications/SGS\ Applications/Editors/TextWrangler.app
mv TextWrangler.app /Applications/SGS\ Applications/Editors

echo "Working on The Unarchiver..."
rm -rf /Applications/SGS\ Applications/SysAdmin/The\ Unarchiver.app
mv The\ Unarchiver.app /Applications/SGS\ Applications/SysAdmin

echo "Working on Thunderbird..."
rm -rf /Applications/SGS\ Applications/E-Mail/Thunderbird.app
mv Thunderbird.app /Applications/SGS\ Applications/E-Mail

echo "Working on Typist..."
rm -rf /Applications/SGS\ Applications/Typing\ Apps/Typist.app
mv Typist.app /Applications/SGS\ Applications/Typing\ Apps

echo "Working on VLC..."
rm -rf /Applications/SGS\ Applications/Media\ Players/VLC.app
mv VLC.app /Applications/SGS\ Applications/Media\ Players

echo "Working on XRG..."
rm -rf /Applications/SGS\ Applications/SysAdmin/XRG.app
mv XRG.app /Applications/SGS\ Applications/SysAdmin

defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool YES

defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add 'sgsadmin'

chown -R sgsadmin:staff /Applications/SGS\ Applications

xattr -dr com.apple.quarantine /Applications

#Adobe
#Apache Open Office
#DivX Plus.pkg
#Flip4Mac WMV.mpkg
#Google Earth Web Plug-in.plugin
#Install Adobe Flash Player.app
#Silverlight.pkg
#digitaleditions_x86.pkg
#munkitools-0.8.2.1475.0.mpkg
#prey-0.5.3-mac.dmg
