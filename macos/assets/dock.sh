#!/usr/bin/env bash

function add_app_to_dock {
  # adds an application to macOS Dock
  # usage: add_app_to_dock "Application Name" 
  # example add_app_to_dock "Terminal"

  app_name="${1}"
  launchservices_path="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
  app_path=$(${launchservices_path} -dump | grep -o "/.*${app_name}.app" | grep -v -E "Backups|Caches|TimeMachine|Temporary|/Volumes/${app_name}" | uniq | sort | head -n1)
  if open -Ra "${app_path}"; then
      echo "$app_path added to the Dock."
      defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>${app_path}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  else
      echo "ERROR: $1 not found." 1>&2
  fi
}

function add_spacer_to_dock {
  # adds an empty space to macOS Dock

  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'
}

function clear_dock {
  # removes all persistent icons from macOS Dock

  defaults write com.apple.dock persistent-apps -array
}

function reset_dock {
  # reset macOS Dock to default settings

  defaults write com.apple.dock; killall Dock
}

# WARNING: permanently clears existing dock
clear_dock

add_app_to_dock "System Preferences"
add_app_to_dock "Bitwarden"
add_app_to_dock "Standard Notes"
add_app_to_dock "Signal"
add_app_to_dock "Discord"
add_app_to_dock "Slack"
add_app_to_dock "Chromium"
add_app_to_dock "Tor Browser"
add_app_to_dock "Firefox"
add_app_to_dock "Thunderbird"
add_app_to_dock "Music"
add_app_to_dock "Ledger Live"
add_app_to_dock "VSCodium"
add_app_to_dock "Terminal"
add_app_to_dock "Calendar"

killall Dock
