#!/bin/bash

if [ ! -e "$HOME/git/z/" ]; then
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
    echo "Enter sudo password for apt install tmux"
    sudo apt install tmux
fi

if [ ! -d "$HOME/git/scripts" ]; then
    mkdir -p "$HOME/git/scripts"
    git clone "git@github.com:evan1026/scripts.git" "$HOME/git/scripts"
fi

if [ ! -d "$HOME/git/docopts" ]; then
    mkdir -p "$HOME/git/docopts"
    git clone "git@github.com:docopt/docopts.git" "$HOME/git/docopts"

    sudo apt install python-pip python3-pip
    last_dir="$(pwd)"
    cd "$HOME/git/docopts"
    python setup.py build
    sudo python setup.py install
	cd "$last_dir"

    sudo -H pip3 install powerline-status
fi

if [ ! -d "$HOME/git/diff-so-fancy" ]; then
    mkdir -p "$HOME/git/diff-so-fancy"
    git clone "git@github.com:so-fancy/diff-so-fancy" "$HOME/git/diff-so-fancy"
    mkdir "$HOME/bin"
    ln -s "$HOME/git/diff-so-fancy/diff-so-fancy" "$HOME/bin/diff-so-fancy"
fi

if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
    echo "Enter sudo password to install exuberant-ctags, cmake, clang, python dev headers, inconsolata font, and vim"
    sudo apt install exuberant-ctags cmake clang python-dev python3-dev fonts-inconsolata vim

    git clone "https://github.com/VundleVim/Vundle.vim.git" "$HOME/.vim/bundle/Vundle.vim"

    vim +PluginInstall +qall

    $HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer

    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    sudo mv PowerlineSymbols.otf /usr/share/fonts/
    sudo fc-cache -vf
    sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
fi

if command -v powerline-daemon > /dev/null; then
  powerline-daemon -q
  powerline_location=$(pip3 show powerline-status | grep Location: | awk '{print $2}')
  source "$powerline_location/powerline/bindings/bash/powerline.sh"
fi

