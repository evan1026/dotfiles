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

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

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
fi


export PATH=$PATH:$HOME/bin:/usr/games:$HOME/git/scripts:./
PS1='\n[\[\033[01;33m\]\@ \d\[\033[00m\]] ${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h \[\033[01;32m\]\u \[\033[34m\]\w$(gitPS1Calc) \n\[\033[00m\]\$ '
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

if [ ! -e "$HOME/git/z/" ]; then
  cd "$HOME/git"
  git clone git@github.com:rupa/z.git
  cd -
fi

. $HOME/git/z/z.sh

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
  echo -e "\e[34m$(tmux ls | cut -d : -f 1 | sed ':a;N;$!ba;s/\n/ /g')\e[m"
fi

#if [[ -z $TMUX ]]; then
#    export PREV_TERM=$TERM
#    echo "Enter desired option/profile name:"
#    if [[ $(tmux ls 2>/dev/null) != "" ]]; then
#        echo -e "    \e[32mAvailable profiles:\e[34m" $(tmux ls -F#S) "\e[m"
#    else
#        echo -e "    \e[32mNo available profiles\e[m"
#    fi
#    read PROFILE
#    if [[ $PROFILE = "ssh" ]]; then
#        clear
#        echo "Enter host:"
#        read HOST
#        if [[ $HOST = "me" ]]; then
#            sshme
#        elif [[ $HOST = "joe" ]]; then
#            sshjoe
#        else
#            ssh $HOST
#        fi
#    else
#        if [[ $PROFILE = "" ]]; then
#            if [[ $GUAKE = "1" ]]; then
#                PROFILE="guake"
#            else
#                PROFILE="default";
#            fi
#        fi
#        if [[ -z $DISPLAY && $(tmux ls | grep $PROFILE) = "" ]]; then
#            VALID=false
#            while [[ $VALID = false ]]; do
#                echo "Display? y|n (n): "
#                read RESPONSE
#                if [[ $RESPONSE = "n" || $RESPONSE = "" ]]; then
#                    VALID=true
#                elif [[ $RESPONSE = "y" ]]; then
#                    set_display
#                    VALID=true
#                fi
#            done
#        fi
#        if [[ $PROFILE != "none" ]]; then
#            tmuxt $PROFILE
#        fi
#    fi
#fi

#if [ -f "${HOME}/.gpg-agent-info" ]; then
#    . "${HOME}/.gpg-agent-info"
#   export GPG_AGENT_INFO
#   export SSH_AUTH_SOCK
#fi
#GPG_TTY=$(tty)
#export GPG_TTY
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
#export PATH="/home/$USER/.genymotion:$PATH"

#man() {
#    env \
  #        LESS_TERMCAP_mb=$(printf "\e[1;32m") \
  #        LESS_TERMCAP_md=$(printf "\e[1;32m") \
  #        LESS_TERMCAP_me=$(printf "\e[0m") \
  #        LESS_TERMCAP_se=$(printf "\e[0m") \
  #        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  #        LESS_TERMCAP_ue=$(printf "\e[0m") \
  #        LESS_TERMCAP_us=$(printf "\e[1;31m") \
  #            man "$@"
#}
