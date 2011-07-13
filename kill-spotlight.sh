#!/bin/sh
if [ ${EUID} -ne 0 ]; then
  echo
  echo "You don't seem to be an old tree yet... Got root?"
  echo
  exit 1
fi

echo "FOADIAF Snow Leopard Search!!!!"
mdutil -a -i off
launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist
chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
killall SystemUIServer
echo "Long Live QuickSilver!!!"
