#!/bin/bash

THIS_DIR="$(dirname $0)"

THIS_DIR_RELATIVE="$(realpath --relative-to="$HOME" "$THIS_DIR")"
for file in .bashrc .bash_aliases .vimrc .tmux.conf .tmux_powerline.conf .gitconfig; do
	if [ -e "$HOME/$file" ]; then
		mv "$HOME/$file" "$HOME/$file.old"
	fi
	ln -snf "$THIS_DIR_RELATIVE/$file" "$HOME/$file"
done

THIS_DIR_RELATIVE="$(realpath --relative-to="$HOME/.config" "$THIS_DIR")"
ln -snf "$THIS_DIR_RELATIVE/powerline" "$HOME/.config/powerline"
ln -snf "$THIS_DIR_RELATIVE/i3" "$HOME/.config/i3"
ln -snf "$THIS_DIR_RELATIVE/nvim" "$HOME/.config/nvim"
