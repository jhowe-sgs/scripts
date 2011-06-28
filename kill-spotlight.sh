#!/bin/sh
echo "FOADIAF Snow Leopard Search!!!!"
sudo mdutil -a -i off
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
sudo killall SystemUIServer
echo "Long Live QuickSilver!!!"
