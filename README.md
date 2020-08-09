# Joe's Dotfiles
Forked from Mathias Bynens

## Installation: Using Git & bootstrap script

You can clone the repository wherever you want (I prefer mine in `~/Code/github/dotfiles`). The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/yuzhoumo/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

## Installation: Without using Git

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/yuzhoumo/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE}
```

To update later on, just run that command again.

## MacOS Configuration

Important: Firefox Profiles and Chromium Application Support files must be provided in `macos/assets/firefox/Profiles` and `macos/assets/ungoogled-chromium/Chromium` as well as BetterDiscord Application Support files in `macos/assets/betterdiscord/BetterDiscord`.

Apply settings and install apps for macOS using the following:

```bash
sh macos/setup.sh
```

Manually configured settings:

```
System Preferences > General > Uncheck "Allow Handoff between this Mac and your iCloud devices"
System Preferences > Security & Privacy > FileVault > Turn on FileVault
System Preferences > Security & Privacy > Privacy > Configure as needed
System Preferences > Extensions > Uncheck unecessary extensions
System Preferences > Siri > Uncheck "Enable Ask Siri"
Menu Bar > Finder > Preferences > Sidebar > Uncheck recents, Uncheck iCloud Drive, Check home directory
Menu Bar > Finder > Reorder favorites (top to bottom): home, desktop, downloads, applications, airdrop
```

## Miscellaneous

Specify the `$PATH`:

If `~/.path` exists, it will be sourced along with the other files, before any feature testing takes place.

Add custom commands without creating a new fork:

If `~/.extra` exists, it will be sourced along with the other files.
