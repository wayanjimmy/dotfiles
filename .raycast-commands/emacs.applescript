#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Emacs
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Emacs

set appName to "Emacs"

if application appName is running then
  activate application appName
else 
  tell application appName to activate
end if
