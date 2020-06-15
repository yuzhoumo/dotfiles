#!/usr/bin/env bash

# Install python modules

# Make sure we’re using the latest Homebrew.
brew update

# Install modules
pip3 install matplotlib
pip3 install notebook
pip3 install numpy
pip3 install pandas
pip3 install scipy

# Remove outdated versions from the cellar.
brew cleanup
