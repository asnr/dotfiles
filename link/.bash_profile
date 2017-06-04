## Shell variables ##

# Add Postgres.app (v9.4) SQL command line tools to PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Add yarn to PATH
export PATH="$PATH:`yarn global bin`"

# Add python bin to path (really just for the aws CLI tool)
export PATH="$PATH:~/Library/Python/2.7/bin/"

# See `man bash`
export HISTCONTROL=$HISTCONTROL:ignoredups
export HISTIGNORE=$HISTIGNORE:fg

# Make `ls` colour output, see `man ls`
export CLICOLOR=1

export EDITOR=vim


## Shell config ##

# Enable ⌃+O (ctrl+O): execute command and bring up the next command in
# the history file
stty discard undef

# Enable ^+s (ctrl+s): forward-search-history
stty -ixon -ixoff


## Miscellaneous ##

# From Xin Guo
function setjdk() {
	export JAVA_HOME=`/usr/libexec/java_home -v $@`
}
# Default java version is 8
setjdk 1.8

# Setup for virtualenvwrapper, as outlined in
#   https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# Setup for RVM
source ~/.profile


## Interactive shell tools ##

# shell is interactive <=> $PS1 is set
if [ ${PS1+isset} == 'isset' ]; then
  # Setup liquidprompt (as installed by homebrew)
  if [ -f /usr/local/share/liquidprompt ]; then
    . /usr/local/share/liquidprompt
  fi

  # Setup autojump (as installed by homebrew)
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && \
    . $(brew --prefix)/etc/profile.d/autojump.sh
fi


## Aliases and functions ##

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Keep functions in separate file that way shells spawned by vim can evalaute
# just those. Evaluating all of .bash_profile is too slow.
[ -f ~/.bash_functions ] && . ~/.bash_functions


## Load RVM functions at end because that's where RVM put them :/ ##

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
