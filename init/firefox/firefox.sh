#!/usr/bin/env bash

# Import Firefox profiles

echo Importing Firefox profiles...

cd "$(dirname "$0")"
rm -rf ${HOME}/Library/Application\ Support/Firefox
cp -r Firefox ${HOME}/Library/Application\ Support/Firefox

echo Finished importing Firefox profiles
