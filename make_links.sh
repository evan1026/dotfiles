#!/bin/bash

THIS_DIR="$(dirname $0)"

THIS_DIR_RELATIVE="$(realpath --relative-to="$HOME" "$THIS_DIR")"
for file in .bashrc .bash_aliases .vimrc .tmux.conf .tmux_powerline.conf .gitconfig .bash_completion; do
	if [ -e "$HOME/$file" -a ! -L "$HOME/$file" ]; then
		mv "$HOME/$file" "$HOME/$file.old"
	fi
	ln -snf "$THIS_DIR_RELATIVE/$file" "$HOME/$file"
done

THIS_DIR_RELATIVE="$(realpath --relative-to="$HOME/.config" "$THIS_DIR")"
ln -snf "$THIS_DIR_RELATIVE/powerline" "$HOME/.config/powerline"
ln -snf "$THIS_DIR_RELATIVE/i3" "$HOME/.config/i3"

powerline_location=$(pip3 show powerline-status | grep Location: | awk '{print $2}')
ln -snf "$powerline_location/powerline/bindings/bash/powerline.sh" "$HOME/.config/powerlinebash.sh"

ln -snf "$THIS_DIR_RELATIVE/nvim" "$HOME/.config/nvim"
