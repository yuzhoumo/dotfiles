###############################################################################
# OS Specific                                                                 #
###############################################################################

if [ $(uname -s) = 'Darwin' ]; then

  # Homebrew security and privacy settings
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CASK_OPTS=--require-s

  # Add Homebrew sbin to path
  export PATH="/usr/local/sbin:$PATH"

  # Avoid issues with `gpg` as installed via Homebrew.
  # https://stackoverflow.com/a/42265848/96656
  export GPG_TTY=$(tty);

  # Set work directory for git repos
  export CODE_DIR="${HOME}/Code"

  # Set desktop directory
  export DESKTOP_DIR="${HOME}/Desktop"

  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

  # Get local ip address
  alias locip="ipconfig getifaddr en0"

elif grep -q microsoft /proc/version; then

  # Retrieve Windows username and remove \r carriage return
  username=$(powershell.exe /c 'echo $env:UserName' | sed -e 's/\r//g')

  # Set work directory for git repos
  export CODE_DIR="${HOME}/code"

  # Set desktop directory
  export DESKTOP_DIR="/mnt/c/Users/${username}/Desktop"

  # Normalize open for WSL
  alias open="explorer.exe"

else

  # Set work directory for git repos
  export CODE_DIR="${HOME}/Code"

  # Set desktop directory
  export DESKTOP_DIR="${HOME}/Desktop"

  # Set input method to use ibus
  export GTK_IM_MODULE="ibus"
  export QT_IM_MODULE="ibus"
  export SDL_IM_MODULE="ibus"
  export XMODIFIERS="@im=ibus"

  # Set kitty to use ibus
  alias kitty="GLFW_IM_MODULE=ibus command kitty"

  # Get local ip address
  alias locip="hostname -I | awk '{print $1}'"

  # Normalize open for Linux
  alias open="xdg-open"

  # Normalize pbcopy/pbpaste for openSUSE
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clipboard -o"

fi

# Source NIX env and export locales if installed
# https://nixos.wiki/wiki/Locales
[ -d ~/.nix-profile ] && \
  . ~/.nix-profile/etc/profile.d/nix.sh && \
  export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

###############################################################################
# Plugins                                                                     #
###############################################################################

source ${HOME}/.config/zsh/plugins/zsh-defer/zsh-defer.plugin.zsh
zsh-defer source ${HOME}/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
zsh-defer source ${HOME}/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
zsh-defer source ${HOME}/.config/zsh/plugins/zsh-nvm/zsh-nvm.plugin.zsh

# Configure prompt
fpath+=${HOME}/.config/zsh/plugins/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:prompt:error color magenta
prompt pure

###############################################################################
# Exports                                                                     #
###############################################################################

# Set term env var for kitty
export TERM=xterm-256color

# Make neovim the default editor
export EDITOR='nvim'

# Omit duplicates and commands that begin with a space from history
export HISTCONTROL='ignoreboth'

# Prefer US English and use UTF-8
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING='UTF-8'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] && [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

###############################################################################
# Re-Bindings and Shortcuts                                                   #
###############################################################################

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Prompt user by default
alias mv="mv -i"
alias rm="rm -i"

# List all files by default, excluding . and ..
alias ls="command ls -A"

# List all files with trailing slashes for directories
alias l="ls -CF"

# List all files in long human readable format, excluding . and ..
alias ll="ls -lhAF"

# Rebind vim to neovim
alias vim="nvim"

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage
alias grep="grep --color=auto"

# Easier navigation
alias c="clear"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git shortcuts
alias g="git"
alias ga="git add ."
alias gc="git commit -m"
alias status="git status"
alias push="git push"
alias pull="git pull"

# Desktop shortcut
alias desk="cd ${DESKTOP_DIR}"

# Code directory shortcuts
alias yuz="cd ${CODE_DIR}/yuzhoumo"
alias pan="cd ${CODE_DIR}/ppanda"
alias con="cd ${CODE_DIR}/yuzhoumo/configs"
alias dot="cd ${CODE_DIR}/yuzhoumo/dotfiles"
alias syncdot="${CODE_DIR}/yuzhoumo/dotfiles/sync.sh && reload"
alias editvim="vim ${CODE_DIR}/yuzhoumo/dotfiles/nvim/init.lua"
alias editzsh="vim ${CODE_DIR}/yuzhoumo/dotfiles/zsh/.zshrc"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# Trim new lines and copy to clipboard
alias copy="tr -d '\n' | pbcopy"

# Get public IP address
alias pubip="dig +short myip.opendns.com @resolver1.opendns.com"

# Recursively delete MacOS `.DS_Store` files
alias cleands="find . -type f -name '*.DS_Store' -ls -delete"

# Recursively delete MacOS resource forks (files starting with `._`)
alias cleanrf="find . -type f -name '._*' -ls -delete"

# Mirror site for offline browsing using wget
alias mirror="wget --mirror --convert-links --adjust-extension --page-requisites --no-parent"

# Download YouTube video as MP3 audio
alias mp3="yt-dlp --extract-audio --audio-format mp3"

# Download YouTube video as MP4
alias mp4="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4'"

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
  alias "${method}"="lwp-request -m '${method}'"
done

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

###############################################################################
# Functions                                                                   #
###############################################################################

# Note: add unalias before function defs if any conflict exists
# (added due to `alias o=less` being set on openSUSE)

# `o` with no args opens the current directory, otherwise opens given location
alias o >/dev/null 2>&1 && unalias o
function o() {
  if [ $# -eq 0 ]; then
    open .
  else
    open "$@"
  fi
}

# Create a new directory and enter it
alias mkd >/dev/null 2>&1 && unalias mkd
function mkd() {
  mkdir -p "$@" && cd "$_"
}

# Use Git’s colored diff when available
hash git &>/dev/null;
if [ $? -eq 0 ]; then
  alias diff >/dev/null 2>&1 && unalias diff
  function diff() {
    git diff --no-index --color-words "$@"
  }
fi
