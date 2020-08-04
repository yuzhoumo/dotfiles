#!/usr/bin/env bash

# Install BetterDiscord
cd "$(dirname "$0")"

# Silently close Discord
killall Discord 2>/dev/null

# Download and Rename BetterDiscord Injector
curl https://github.com/rauenzi/BetterDiscordApp/archive/injector.zip -O -L
unzip injector.zip
mv BetterDiscordApp-injector BetterDiscord/app
rm -f BetterDiscord/app/LICENSE BetterDiscord/app/README.md

# Replace `app` folder
rm -rf /Applications/Discord.app/Contents/Resources/app
cp -r BetterDiscord/app /Applications/Discord.app/Contents/Resources

# Clear Files
rm -rf BetterDiscord/app injector.zip

# Make Preferences Directory
mkdir -p ~/Library/Preferences/BetterDiscord

# Copy themes and plugins
cp -r BetterDiscord/themes ~/Library/Preferences/BetterDiscord
cp -r BetterDiscord/plugins ~/Library/Preferences/BetterDiscord
