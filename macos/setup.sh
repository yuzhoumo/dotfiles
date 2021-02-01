#!/usr/bin/env bash

cd "$(dirname "$0")"

# Configure macOS settings
sh assets/macos.sh

# Install Homebrew if it is not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install applications
sh assets/brew.sh

# Install python pip3 modules
sh assets/python.sh

# Install BetterDiscord
sh assets/betterdiscord.sh

# Configure macOS dock
sh assets/dock.sh
