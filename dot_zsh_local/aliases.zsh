### General ###
alias c=clear
alias ld='ls -ld */'
alias lda='ls -ld */ .*/ 2>/dev/null'
alias ldh='ls -ld .*/'
alias lf='ls -lAh | grep -v "^d" | grep -v " \."'
alias lfa='ls -lAh | grep -v "^d"'
alias lfh='ls -lAhd .[^.]* | grep -v "^d"'

## Docker ##
alias dc='docker compose'
alias dsta='docker start'
alias dsto='docker stop'
alias dstoa='docker stop $(docker ps -a -q)'
alias dps='docker ps'

## Git ###
alias ga='git add'
alias gb='git branch'
alias gbvv='git branch -vv'
alias gf='git fetch'
alias gcam='git commit -am'
alias glo='git log --oneline'
alias glp='git log --pretty=format:"%C(#D33682)%h %Cred%cs %C(#6C71C4)%cn %C(#2AA198)%s %C(#CB4B16)" --date=format:"%I-%M-%S"'
alias gnb='git switch -c'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gsw='git switch'
alias g-='git switch -'

### Navigation ###
alias cdg='cd ~/Gitrepository'
alias cdh='cd ~'
alias fd=fdfind

### Open File ###
alias za='nano ~/.zsh_local/aliases.zsh'


### Linux ###
alias sau='sudo apt update'
alias alug='apt list --upgradable'
alias saug='sudo apt upgrade'

### Exercism ###
alias es='exercism submit'
