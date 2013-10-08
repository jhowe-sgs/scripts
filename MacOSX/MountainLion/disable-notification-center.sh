#!/bin/bash

IS_RUNNING=`ps auxww | grep NotificationCenter | egrep -v grep`

if [ -n "${IS_RUNNING}" ]; then
  echo "Found NotificationCenter, disabling..."
  launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
  killall NotificationCenter
else
  echo "Did not find NotificationCenter running..."
fi

echo "Done."
