# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

if [ "$(uname)" = "Darwin" ]; then
    # The order of /etc/paths isn't the same on my macs, one has /usr/local/bin
    # first and the other has it last. Force it forward.
    export PATH="/usr/local/bin:$PATH"

    # The macOS version of openssl is old, prefer the one we get from homebrew
    export PATH="/usr/local/opt/openssl/bin:$PATH"

    # Add Postgres.app (v9.4) SQL command line tools to PATH
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

    # Add python bin to path (the AWS CLI tool made me do it)
    export PATH="$PATH:~/Library/Python/2.7/bin"

    # Autojump directory changing
    [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && \
        . $(brew --prefix)/etc/profile.d/autojump.sh

    # z directory changing
    [[ -s $(brew --prefix)/etc/profile.d/z.sh ]] && \
        . $(brew --prefix)/etc/profile.d/z.sh

    # Setup google cloud SDK autocompletion
    command -v gcloud >/dev/null 2>&1 && \
        . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc && \
        . /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc

    # From Xin Guo
    function setjdk() {
        /usr/libexec/java_home >/dev/null 2>&1 && \
            export JAVA_HOME=`/usr/libexec/java_home -v $@`
    }
    # Default java version is 8
    setjdk 1.8

elif [ "$(uname)" = "Linux" ]; then
    # append to the history file, don't overwrite it. (From ubuntu .bashrc)
    shopt -s histappend

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS. (From ubuntu .bashrc)
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    # (From ubuntu .bashrc)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # enable color support of ls and also add handy aliases.
    # (From ubuntu .bashrc)
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc). (From ubuntu .bashrc)
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi
fi

# Add yarn to PATH
command -v yarn >/dev/null 2>&1 && export PATH="$PATH:`yarn global bin`"

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

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    # Setup for virtualenvwrapper, as outlined in
    #   https://virtualenvwrapper.readthedocs.io/en/latest/install.html#shell-startup-file
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Setup ruby version manager
if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

unset KUBECONFIG
KUBECONFIG="${HOME}/.kube/config"
for f in $(find "${HOME}/.kube/config.d" -type f); do
    export KUBECONFIG="$KUBECONFIG:$f"
done


## Interactive shell tools ##

# shell is interactive <=> $PS1 is set
if [ ${PS1+isset} == 'isset' ]; then
  # Setup liquidprompt (as installed by homebrew).
  # Note that this needs to be loaded *after* any changes to $PROMPT_COMMAND,
  # otherwise the 'display runtime of last command' feature will break and
  # you'll just a timer showing elapsed time since the terminal loaded. See my
  # comments and the last comment by Rycieos in
  # https://github.com/nojhan/liquidprompt/issues/481
  if [ -f /usr/local/share/liquidprompt ]; then
      . /usr/local/share/liquidprompt
  else
      # "\001" = "\[", "\002" = "\]" and "\033" = "\e"
      PRIMARY_FONT="\001\033[01;94m\002"  # light magenta, bold
      SECONDARY_FONT="\001\033[94m\002" # light magenta
      TERTIARY_FONT="\001\033[38;5;245m\002"
      FONT_END="\001\033[m\002"
      # Old versions of bash (e.g. v3.2.57, the default bash for macOS Terminal
      # app) break slightly with this PS1 value (it's the '\W' that does it).
      # After running a reverse-i-search (ctrl-r), the cursor position will
      # appear in the wrong position of the line. To fix this on macOS install a
      # new version of bash using 'brew install bash' and then in Terminal
      # preferences set "Shells open with" to "/usr/local/bin/bash"
      export PS1="\n${SECONDARY_FONT}\h${FONT_END} ${TERTIARY_FONT}as${FONT_END} ${SECONDARY_FONT}\u${FONT_END} ${TERTIARY_FONT}in${FONT_END} ${PRIMARY_FONT}\W${FONT_END}${SECONDARY_FONT}\n\$ ${FONT_END}"
  fi
fi

if command -v rustup >/dev/null 2>&1 || command -v cargo >/dev/null 2>&1; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

## Aliases and functions ##

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Keep functions in separate file that way shells spawned by vim can evaluate
# just those. Evaluating all of .bash_profile is too slow.
[ -f ~/.bash_functions ] && . ~/.bash_functions

# Not version controlled! Contains scripts for the day job.
[ -f ~/.bash_for_work.sh ] && . ~/.bash_for_work.sh

## Load RVM functions at end because that's where RVM put them :/ ##
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
