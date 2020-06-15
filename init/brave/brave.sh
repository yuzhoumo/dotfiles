#!/usr/bin/env bash

# Import Brave Browser settings

echo Importing Brave Browser settings...

cd "$(dirname "$0")"
rm -rf ${HOME}/Library/Application\ Support/BraveSoftware
cp -r BraveSoftware ${HOME}/Library/Application\ Support/BraveSoftware

echo Finished importing Brave Browser settings
