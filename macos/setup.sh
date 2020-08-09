#!/usr/bin/env bash

# Full installation of dotfiles and other configurations

cd "$(dirname "$0")"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install command-line and GUI applications
sh assets/brew.sh

# Install python pip3 modules
sh assets/python.sh

# Configure Browsers
sh assets/firefox/firefox.sh
sh assets/ungoogled-chromium/chromium.sh

# Install BetterDiscord
sh assets/betterdiscord/betterdiscord.sh

# Configure macOS dock
./.dock

# Configure macOS settings
./.macOS

# Set Wallpaper
sh wallpaper/wallpaper.sh
