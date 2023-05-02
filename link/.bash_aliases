#; -*-sh-*-

alias xv6path='export PATH=/usr/local/xv6/bin:$PATH && echo $PATH'

alias gs="git status"
alias gd="git diff"
alias gl="git log"
alias glo="git log --oneline"
alias ga="git add"
alias gap="git add -p"
alias gc="git commit"
alias gcm="git commit -m"
alias gpu="git push"
alias grp="git pull --rebase"
alias gmp="git pull"
alias gss="git stash"
alias gsp="git stash pop"
alias gbc="git branch --show-current"
alias kshow='echo "kx: $(kubectl config current-context) | ns: $(kubens -c)"'
alias setasnr='git config user.name asnr && git config user.email asnr@users.noreply.github.com && git config --list | grep user'
alias initasnr='git init && setasnr'
[ "$(uname)" = "Darwin" ] && alias pbpretty='pbpaste | jq . | pbcopy'

alias be="bundle exec"

alias kc="kubectl"
# Make kubectl autocomplete work for kc alias. Taken from
#   https://stackoverflow.com/a/52907262/1662788
#
# Currently commented out because kubectl is dog slow, which makes opening a new terminal excruciatingly slow.
#   command -v kubectl >/dev/null 2>&1 && \
#       source <(kubectl completion bash | sed 's/__start_kubectl kubectl/__start_kubectl kc/g')
alias kx="kubectx"

alias ssh_hosts='grep -w -i "Host" ~/.ssh/config | sed s/Host//'
alias psql_hosts='grep "^\[" ~/.pg_service.conf | tr -d []'
