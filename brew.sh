#!/usr/bin/env bash

# Install command-line and GUI applications using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Turn off analytics.
brew analytics off

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! grep -Fq "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install git
brew install lynx
brew install p7zip
brew install pigz
brew install python
brew install tree
brew install youtube-dl
brew install zopfli

# Tap cask.
brew tap homebrew/cask
brew tap homebrew/cask-versions

# Install cask applications.
brew cask install adobe-creative-cloud
brew cask install atom
brew cask install bitwarden
brew cask install brackets
brew cask install cryptomator
brew cask install deluge
brew cask install discord
brew cask install eloston-chromium
brew cask install firefox
brew cask install flux
brew cask install imageoptim
brew cask install insomnia
brew cask install intellij-idea-ce
brew cask install java
brew cask install keka
brew cask install libreoffice
brew cask install lulu
brew cask install mactex
brew cask install mullvadvpn
brew cask install multimc
brew cask install oversight
brew cask install protonvpn
brew cask install pycharm-ce
brew cask install signal
brew cask install slack
brew cask install standard-notes
brew cask install steam
brew cask install thunderbird
brew cask install tor-browser
brew cask install vlc
brew cask install visual-studio-code

# Remove outdated versions from the cellar.
brew cleanup
