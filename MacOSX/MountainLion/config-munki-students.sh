#!/bin/sh
defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "http://munki.seattlegirlsschool.org/munki_repo"
defaults write /Library/Preferences/ManagedInstalls ClientIdentifier "student_client"
defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool True
defaults write /Library/Preferences/ManagedInstalls SoftwareUpdateServerURL "http://saraswati.seattlegirlsschool.org:8088/index.sucatalog"
