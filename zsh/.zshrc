###############################################################################
# Extras                                                                      #
###############################################################################

# Source extra configs if available (not committed to git)
[ -e "${HOME}/.config/zsh/extra.zsh" ] && . "${HOME}/.config/zsh/extra.zsh"

###############################################################################
# Exports                                                                     #
###############################################################################

# Set term env var for kitty
export TERM=xterm-256color

# Make neovim the default editor
export EDITOR="nvim"

# Omit duplicates and commands that begin with a space from history
export HISTCONTROL="ignoreboth"

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages
export LESS_TERMCAP_md="${yellow}"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr
export PYTHONIOENCODING="UTF-8"

# Set python history file to ~/.cache
export PYTHON_HISTORY="${HOME}/.cache/python_history"

# Write `less` history file to ~/.cache
export LESSHISTFILE="${HOME}/.cache/lesshst"

# Set zsh history file to ~/.cache
export HISTFILE="${HOME}/.cache/zsh_history"

# Set node repl history file to ~/.cache
export NODE_REPL_HISTORY="${HOME}/.cache/.node_repl_history"

# Set gem/bundle install locaion
export GEM_HOME="${HOME}/.local/share/gem"
export BUNDLE_USER_HOME="${HOME}/.local/share/bundle"

# Set nvm install location
export NVM_DIR="${HOME}/.local/share/nvm"

# Set fzf install location
export FZF_PATH="${HOME}/.local/share/fzf"

# Set go location
export GOPATH="${HOME}/.local/share/go"

# Set gpg location
export GNUPGHOME="${HOME}/.local/share/gnupg"

# Set rust locations
export CARGO_HOME="${HOME}/.local/share/cargo"
export RUSTUP_HOME="${HOME}/.local/share/rustup"
export PATH="${RUSTUP_HOME}:${PATH}"

# Set docker location
export DOCKER_CONFIG="${HOME}/.config/docker"

# Set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] && [[ ":${PATH}:" != *":${HOME}/.local/bin:"* ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Add zsh-fzf to bin
export PATH="${HOME}/.config/zsh/plugins/zsh-fzf/bin:${PATH}"

###############################################################################
# Terminal Specific                                                           #
###############################################################################

if [[ -n "$KITTY_WINDOW_ID" ]]; then
  alias light="kitten @set-colors --all /Users/ppanda/.config/kitty/themes/latte.conf"
  alias dark="kitten @set-colors --all /Users/ppanda/.config/kitty/themes/mocha.conf"
fi

###############################################################################
# OS Specific                                                                 #
###############################################################################

if [ $(uname -s) = 'Darwin' ]; then

  # Set pnpm home
  export PNPM_HOME="/Users/${USER}/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac

  # Homebrew security and privacy settings
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_NO_INSECURE_REDIRECT=1
  export HOMEBREW_CASK_OPTS=--require-s

  # Add Homebrew to path
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Use GNU find instead of macos
  PATH=$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH

  # Avoid issues with `gpg` as installed via Homebrew.
  # https://stackoverflow.com/a/42265848/96656
  export GPG_TTY=$TTY

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

###############################################################################
# Plugins & Tweaks                                                            #
###############################################################################

# Define plugin directory
plugdir="${HOME}/.config/zsh/plugins"

# Lazy-load plugins
. "${plugdir}/zsh-defer/zsh-defer.plugin.zsh"
zsh-defer . "${plugdir}/zsh-autosuggestions/zsh-autosuggestions.zsh"
zsh-defer . "${plugdir}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
zsh-defer . "${plugdir}/zsh-nvm/zsh-nvm.plugin.zsh"
zsh-defer . "${plugdir}/zsh-fzf/fzf-zsh-plugin.plugin.zsh"

# Configure prompt
fpath+="${plugdir}/pure"
autoload -U promptinit; promptinit
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:prompt:success color green
zstyle :prompt:pure:prompt:error color magenta
prompt pure

# De-duplicate history
HISTSIZE=1000000
SAVEHIST=1000000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt extended_history

# Case-insensitive completion
autoload -U compinit && compinit
zstyle ':completion*' matcher-list 'm:{a-z}={A-Za-z}'

# Vim keybindings
bindkey -v
bindkey ^R history-incremental-search-backward
bindkey ^s history-incremental-search-forward

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
