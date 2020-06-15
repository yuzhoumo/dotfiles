#!/usr/bin/env bash

# Install BetterDiscord

cd "$(dirname "$0")"

# Silently close Discord
killall Discord 2>/dev/null

# Replace `app` folder
rm -rf /Applications/Discord.app/Contents/Resources/app
cp -r BetterDiscord/app /Applications/Discord.app/Contents/Resources

# Make Preferences Directory
mkdir -p ~/Library/Preferences/BetterDiscord

# Copy themes and plugins
cp -r assets/BetterDiscord/themes ~/Library/Preferences/BetterDiscord
cp -r assets/BetterDiscord/plugins ~/Library/Preferences/BetterDiscord
