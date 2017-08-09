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
alias setasnr='git config user.name asnr && git config user.email asnr@users.noreply.github.com && git config --list | grep user'
alias initasnr='git init && setasnr'

alias be="bundle exec"

alias ssh_hosts='grep -w -i "Host" ~/.ssh/config | sed s/Host//'
