#!/bin/bash

IS_RUNNING=`ps auxww | grep NotificationCenter | egrep -v grep`

if [ -z "${IS_RUNNING}" ]; then
  echo "NotificationCenter not running, enabling..."
  launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
  open /System/Library/CoreServices/NotificationCenter.app
else
  echo "Started NotificationCenter ..."
fi

echo "Done."
