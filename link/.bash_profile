# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

if [ "$(uname)" = "Darwin" ]; then
    # Ideally we would define BREW_PREFIX=$(brew --prefix), but at this stage
    # the brew binary isn't in PATH.
    if [ "$(uname -m)" = "arm64" ]; then
        BREW_PREFIX=/opt/homebrew
    else  # assume $(uname -m) = "x86_64"
        BREW_PREFIX=/usr/local
    fi

    # The order of /etc/paths isn't the same on my macs, force homebrew
    # binaries forward.
    export PATH="$BREW_PREFIX/bin:$PATH"

    # The macOS version of openssl is old, prefer the homebrew version.
    export PATH="$BREW_PREFIX/opt/openssl/bin:$PATH"

    # To customise keybindings for less, we need to use the homebrew version.
    # Make man also use this version of less, instead of the system version.
    [ -f "$BREW_PREFIX/bin/less" ] && export PAGER="$BREW_PREFIX/bin/less"

    # Autojump directory changing
    [[ -s $BREW_PREFIX/etc/profile.d/autojump.sh ]] && \
        . $BREW_PREFIX/etc/profile.d/autojump.sh

    # z directory changing
    [[ -s $BREW_PREFIX/etc/profile.d/z.sh ]] && \
        . $BREW_PREFIX/etc/profile.d/z.sh

    export PATH="$PATH:/Library/TeX/texbin"

    # Add postgres CLI tools to PATH. Prefer those installed via
    #   $ brew install libpq
    # over those installed by Postgres.app
    export PATH="$PATH:$BREW_PREFIX/opt/libpq/bin"
    export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

    # Add python bin to path (the AWS CLI tool made me do it)
    export PATH="$PATH:~/Library/Python/2.7/bin"

    # Update PATH for the Google Cloud SDK.
    [ -f "$HOME/.local/google-cloud-sdk/path.bash.inc" ] && \
        . "$HOME/.local/google-cloud-sdk/path.bash.inc"

    # Enable shell command completion for gcloud.
    [ -f "$HOME/.local/google-cloud-sdk/completion.bash.inc" ] && \
        . "$HOME/.local/google-cloud-sdk/completion.bash.inc"

    # From Xin Guo
    # Set the JDK version
    function setjdk() {
        /usr/libexec/java_home >/dev/null 2>&1 && \
            export JAVA_HOME=`/usr/libexec/java_home -v $@`
    }

    alias utc2epoch="gdate +'%s' --utc --date"

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

    # z directory changing
    [[ -s ~/.local/bin/z.sh ]] && . ~/.local/bin/z.sh

    alias utc2epoch="date +'%s' --utc --date"
fi

# For the executables linked by go.sh. Eventually will want go.sh to link
# these into /usr/local/bin on macs but this will do for now.
export PATH="~/.local/bin:$PATH"

# Needed by doom-emacs
export PATH="~/.emacs.d/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Commented out because `yarn global bin` started to take a long time (maybe
# after a brew update?) and its output /opt/homebrew/bin was already in PATH
# anyway.
#   command -v yarn >/dev/null 2>&1 && export PATH="$PATH:`yarn global bin`"

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
if [ -d "${HOME}/.kube/config.d" ]; then
  for f in $(find "${HOME}/.kube/config.d" -type f); do
      export KUBECONFIG="$KUBECONFIG:$f"
  done
fi

if [ -f ~/.fzf.bash ]; then
    source ~/.fzf.bash
    export FZF_DEFAULT_OPTS='--bind ctrl-n:down,ctrl-e:up'
fi


## Interactive shell tools ##

# shell is interactive <=> $PS1 is set
if [ ${PS1+isset} = 'isset' ]; then

  if [ -n "$ZSH_VERSION" ]; then
     setopt PROMPT_SUBST
     PROMPT_NEWLINE=$'\n'
     PROMPT="%F{blue}%D{%b %f %T}%f %F{245}on%f %F{blue}%m%f %F{245}as%f %F{blue}%n%f %F{245}in%f %B%F{blue}%~%f%b${PROMPT_NEWLINE}%F{blue}$%f "

     # Add newline to before prompts except for the first prompt
     precmd() {
         precmd() {
             print ""
         }
     }

     # Lots of "emacs" bindings like ctrl-r for reverse search, opt+b for jump
     # backward one word, opt+del for delete last word, etc. I'm surprised this
     # is not the default zsh.
     bindkey -e

     if [ "$(uname)" = "Darwin" ]; then
         bindkey "^[[3~" delete-char  # bind fn+delete
     fi

  elif [ -n "$BASH_VERSION" ]; then
      # "\001" = "\[", "\002" = "\]" and "\033" = "\e"
      PRIM_FONT="\001\033[01;94m\002"  # light magenta, bold
      SEC_FONT="\001\033[94m\002" # light magenta
      TER_FONT="\001\033[38;5;245m\002" # light grey
      WARN_FONT="\001\033[01;91m\002" # light red
      F_END="\001\033[m\002"

      recalculate_prompt () {
          # Cheers liquidprompt for the mad predicates
          if [[ "${VIRTUAL_ENV-}${CONDA_DEFAULT_ENV-}" = ?* ]]; then
              if [[ -n "${VIRTUAL_ENV-}" ]]; then
                  PY_VENV_PROMPT=" ${TER_FONT}py${F_END} ${WARN_FONT}${VIRTUAL_ENV##*/}${F_END}"
              else
                  PY_VENV_PROMPT=" ${TER_FONT}conda${F_END} ${WARN_FONT}${CONDA_DEFAULT_ENV##*/}${F_END}"
              fi
          else
              PY_VENV_PROMPT=
          fi

          # Old versions of bash (e.g. v3.2.57, the default bash for macOS Terminal
          # app) break slightly with this PS1 value (it's the '\W' that does it).
          # After running a reverse-i-search (ctrl-r), the cursor position will
          # appear in the wrong position of the line. To fix this on macOS install a
          # new version of bash using 'brew install bash' and then in Terminal
          # preferences set "Shells open with" to that binary's absolute path.
          PS1="${SEC_FONT}\D{%b %d %T}${F_END} ${TER_FONT}on${F_END} ${SEC_FONT}\h${F_END} ${TER_FONT}as${F_END} ${SEC_FONT}\u${F_END}${PY_VENV_PROMPT} ${TER_FONT}in${F_END} ${PRIM_FONT}\w${F_END}${SEC_FONT}\n\$ ${F_END}"


          if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
              PS1_NEWLINE_LOGIN=true
          else
              PS1="\n$PS1"
          fi
      }

      # Preserve the existing PROMPT_COMMAND because z needs it to work.
      # Note that 3rd party tools (e.g. z) may insert strings into
      # PROMPT_COMMAND; these need to be preserved. Those strings may or may not be
      # terminated with a ";". Add one if it isn't present while ensuring that a
      # double semicolon ";;" doesn't occur, as this invalid bash.
      # Warning: this code will break if $PROMPT_COMMAND has spaces after a
      # final semicolon.
      if [ -n "$PROMPT_COMMAND" ]; then
          PROMPT_COMMAND="${PROMPT_COMMAND%;};"
      fi
      PROMPT_COMMAND="${PROMPT_COMMAND} recalculate_prompt"
  fi
fi

if command -v rustup >/dev/null 2>&1 || command -v cargo >/dev/null 2>&1; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if command -v go >/dev/null 2>&1; then
    export PATH="$PATH:$(go env GOPATH)/bin"
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
