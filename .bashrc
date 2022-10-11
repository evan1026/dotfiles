# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

  if [ -f "$HOME/.bash_completion" ]; then
    . "$HOME/.bash_completion"
  fi
fi

export PATH=$PATH:$HOME/bin:/usr/games:$HOME/git/scripts:./:$HOME/go/bin:$HOME/git/docopts:$HOME/.local/bin
PS1='\n[\[\033[01;33m\]\@ \d\[\033[00m\]] ${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h \[\033[01;32m\]\u $([ -n "$CONDA_DEFAULT_ENV" ] && echo "\[\033[01;36m\]($CONDA_DEFAULT_ENV) ")\[\033[34m\]\w$(gitPS1Calc) \n\[\033[00m\]\$ '
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

if [ -e "$HOME/git/z/" ]; then
  . $HOME/git/z/z.sh
fi

function get_xserver (){
  case $TERM in
    xterm )
      XSERVER=$(who am i | awk '{print $NF}' | tr -d ')''(' )
      XSERVER=${XSERVER%%:*}
      ;;
    aterm | rxvt)
      # Find some code that works here. ...
      ;;
  esac
}

function set_display (){
  get_xserver
  if [[ -z ${XSERVER}  || ${XSERVER} == $(hostname) || ${XSERVER} == "unix" ]]; then
    DISPLAY=":0.0"          # Display on local host.
  else
    DISPLAY=${XSERVER}:0.0     # Display on remote host.
  fi

  export DISPLAY
}

if [ -z $TMUX ]; then
  echo ""
  echo -e "\e[92mCurrent tmux profiles:"
  echo -e "\e[34m$(tmux ls 2>/dev/null | cut -d : -f 1 | sed ':a;N;$!ba;s/\n/ /g')\e[m"
fi

#if [ -f "${HOME}/.gpg-agent-info" ]; then
#    . "${HOME}/.gpg-agent-info"
#   export GPG_AGENT_INFO
#   export SSH_AUTH_SOCK
#fi

export GPG_TTY=$(tty)

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
#export PATH="/home/$USER/.genymotion:$PATH"

#eval $(ssh-agent -s)
env=~/.ssh/agent.env.bash
agent_load_env() { test -f "$env" && . "$env" >| /dev/null; }
agent_start() {
  (umask 077; ssh-agent >| "$env")
  . "$env" >| /dev/null;
}
agent_load_env

#agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
  agent_start
fi

unset env

export GOPATH="$HOME/go"

export XDG_CONFIG_HOME="$HOME/.config/"

if command -v powerline-daemon > /dev/null; then
  powerline-daemon -q
  if [ -e "$HOME/.config/powerlinebash.sh" ]; then
    source "$HOME/.config/powerlinebash.sh"
  fi
fi

export CPM_SOURCE_CACHE=$HOME/.cache/CPM
