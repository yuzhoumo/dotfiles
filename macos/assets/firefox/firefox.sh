#!/usr/bin/env bash

# Import Firefox profiles

echo Importing Firefox profiles...

cd "$(dirname "$0")"

# Silently close Firefox
killall Firefox 2>/dev/null

# Replace Firefox profiles
rm -rf ${HOME}/Library/Application\ Support/Firefox/Profiles
cp -r Profiles ${HOME}/Library/Application\ Support/Firefox/Profiles

echo Finished importing Firefox profiles
