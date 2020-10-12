#!/usr/bin/env bash

# Install BetterDiscord

echo Installing BetterDiscord...

cd "$(dirname "$0")"

# Silently close Discord
killall Discord 2>/dev/null

# Download and Rename BetterDiscord Injector
curl https://github.com/rauenzi/BetterDiscordApp/archive/injector.zip -O -L
unzip injector.zip
mv BetterDiscordApp-injector BetterDiscord/app
rm -f injector.zip BetterDiscord/app/LICENSE BetterDiscord/app/README.md

# Replace `app` folder
rm -rf /Applications/Discord.app/Contents/Resources/app
mv BetterDiscord/app /Applications/Discord.app/Contents/Resources

echo Finished installing BetterDiscord
