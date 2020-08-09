#!/usr/bin/env bash

# Import Chromium data

echo Importing Chromium data...

cd "$(dirname "$0")"

# Silently close Chrome
killall Chromium 2>/dev/null

# Replace Chromium data
rm -rf ${HOME}/Library/Application\ Support/Chromium
cp -r Chromium ${HOME}/Library/Application\ Support/Chromium

echo Finished importing Chromium data
