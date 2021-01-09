#!/bin/bash

if [ ! -e "$HOME/git/z/" ]; then
  echo "================"
  echo "= Installing z ="
  echo "================"
  if [ ! -e "$HOME/git/" ]; then
    mkdir "$HOME/git"
  fi
  cd "$HOME/git"
  git clone git@github.com:rupa/z.git
  cd -
fi

if command -v tmux > /dev/null; then
    printf "" #do nothing
else
    echo "==================="
    echo "= Installing tmux ="
    echo "==================="
    echo "Enter sudo password for apt install tmux"
    sudo apt install tmux
fi

if [ ! -d "$HOME/git/scripts" ]; then
    echo "======================"
    echo "= Installing scripts ="
    echo "======================"
    mkdir -p "$HOME/git/scripts"
    git clone "git@github.com:evan1026/scripts.git" "$HOME/git/scripts"
fi

if [ ! -d "$HOME/git/docopts" ]; then
    echo "======================"
    echo "= Installing docopts ="
    echo "======================"
    mkdir -p "$HOME/git/docopts"
    git clone "git@github.com:docopt/docopts.git" "$HOME/git/docopts"

    sudo apt install python-pip python3-pip
    last_dir="$(pwd)"
    cd "$HOME/git/docopts"
    python setup.py build
    sudo python setup.py install
    cd "$last_dir"

fi

if [ ! -d "$HOME/git/diff-so-fancy" ]; then
    echo "============================"
    echo "= Installing diff-so-fancy ="
    echo "============================"
    mkdir -p "$HOME/git/diff-so-fancy"
    git clone "git@github.com:so-fancy/diff-so-fancy" "$HOME/git/diff-so-fancy"
    mkdir "$HOME/bin"
    ln -s "$HOME/git/diff-so-fancy/diff-so-fancy" "$HOME/bin/diff-so-fancy"
fi

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo "====================="
    echo "= Installing Vundle ="
    echo "====================="
    echo "Enter sudo password to install exuberant-ctags, cmake, clang, python dev headers, inconsolata font, and vim"
    sudo apt install exuberant-ctags cmake clang python-dev python3-dev fonts-inconsolata vim

    git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

    vim +PluginInstall +qall

    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer

fi

if [ -z "$(pip3 list | grep powerline-status)" ]; then
	echo "========================"
	echo "= Installing powerline ="
	echo "========================"
	sudo -H pip3 install powerline-status
	wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
	sudo mv PowerlineSymbols.otf /usr/share/fonts/
	sudo fc-cache -vf
	sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
fi
