#!/usr/bin/env bash

# Import Chromium settings

echo Importing Chromium settings...

cd "$(dirname "$0")"
rm -rf ${HOME}/Library/Application\ Support/Chromium
cp -r Chromium ${HOME}/Library/Application\ Support/Chromium

echo Finished importing Chromium settings
