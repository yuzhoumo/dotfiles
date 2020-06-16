# Joe's Dotfiles
Forked from Mathias Bynens

## Full Installation

Important: Firefox and Chromium Application Support folders must be provided in `init/firefox` and `init/ungoogled-chromium` as well as BetterDiscord files in `init/BetterDiscord` (See .gitignore for details).

### Run the setup script

```bash
./setup.sh
```

### Manually configure settings
```
System Preferences > General > Uncheck "Allow Handoff between this Mac and your iCloud devices"
System Preferences > Security & Privacy > FileVault > Turn on FileVault
System Preferences > Security & Privacy > Privacy > Configure as needed
System Preferences > Extensions > Uncheck unecessary extensions
System Preferences > Siri > Uncheck "Enable Ask Siri"
Menu Bar > Finder > Preferences > Sidebar > Uncheck recents, Uncheck iCloud Drive, Check home directory
Menu Bar > Finder > Reorder favorites (top to bottom): home, desktop, downloads, applications, airdrop
```

## Individual Components

### Installing applications

```bash
./brew.sh
```

### Setting macOS defaults

```bash
./.macos
```

### Configuring macOS dock

```bash
./.dock
```

### Using Git & bootstrap script

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

### Git-free install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/yuzhoumo/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE-MIT.txt}
```

To update later on, just run that command again.

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing takes place.

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files.
