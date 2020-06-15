#!/usr/bin/env bash

# Set MacOS wallpaper

cd "$(dirname "$0")"
cp wallpaper.jpg ${HOME}/Pictures/wallpaper.jpg

osascript -e "tell application \"Finder\" to set desktop picture to \"${HOME}/Pictures/wallpaper.jpg\" as POSIX file"