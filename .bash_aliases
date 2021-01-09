alias fucking=sudo
alias dsize="du -sh"
alias pubip="curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'"
alias py='python3'
alias fuck='eval $(thefuck $(fc -ln -1))'
alias gitk='gitk --all'
alias gitkc='git log --graph --abbrev-commit --pretty=oneline --decorate'
alias make='make -j$(grep -c ^processor /proc/cpuinfo)'
alias pip='pip3'
alias vi='nvim'
alias vim='nvim'
alias rm="rm -I"

function mkcd() { mkdir $1; cd $1; }
