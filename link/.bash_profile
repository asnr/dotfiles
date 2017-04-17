
# Add Postgres.app (v9.4) SQL command line tools to PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Add yarn to PATH
export PATH="$PATH:`yarn global bin`"

# From Xin Guo
function setjdk() {
	export JAVA_HOME=`/usr/libexec/java_home -v $@`
}
# Default java version is 8
setjdk 1.8

function current_keyboard_layout() {
  defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | \
    sed 's:.*\.\([[:alpha:]]*\)$:\1:'
}

function next_keyboard_layout() {
  # Simulate pressing Ctrl+Opt+Space
  # This is very brittle, should try and find a more semantic approach
  osascript -e 'tell application "System Events"' \
            -e 'keystroke space using {control down, option down}' \
            -e 'end tell'
}

function qwerty() {
  local TEMP_VIMRC=~/.vimrc.$(date +"%Y%m%d_%H%M%S").tmp
  sed 's:^\(source .*/map_keys\.vim\)$:" \1:' ~/.vimrc > $TEMP_VIMRC
  mv $TEMP_VIMRC ~/.vimrc

  if test $(current_keyboard_layout) != Australian; then
    next_keyboard_layout
  fi
}

function colemak() {
  local TEMP_VIMRC=~/.vimrc.$(date +"%Y%m%d_%H%M%S").tmp
  sed 's:^" \(source .*/map_keys\.vim\)$:\1:' ~/.vimrc > $TEMP_VIMRC
  mv $TEMP_VIMRC ~/.vimrc

  if test $(current_keyboard_layout) != Colemak; then
    next_keyboard_layout
  fi
}

# Setup for virtualenvwrapper, as outlined in
#   https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# Setup for RVM
source ~/.profile

## Shell config ##

# Enable ⌃+O (ctrl+O): execute command and bring up the next command in
# the history file
stty discard undef

# Enable ^+s (ctrl+s): forward-search-history
stty -ixon -ixoff


## Shell tools ##

# Setup liquidprompt (as installed by homebrew)
if [ -f /usr/local/share/liquidprompt ]; then
	. /usr/local/share/liquidprompt
fi

# Setup autojump (as installed by homebrew)
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh


## Shell variables ##

# See `man bash`
export HISTCONTROL=$HISTCONTROL:ignoredups
export HISTIGNORE=$HISTIGNORE:fg

# Make `ls` colour output, see `man ls`
export CLICOLOR=1


## Aliases ##

if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
