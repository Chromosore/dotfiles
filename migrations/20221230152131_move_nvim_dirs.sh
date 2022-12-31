#!/bin/sh
if [ -d ~/.local/share/nvim/ -a -d ~/.local/state/nvim/ ]; then
	mv ~/.local/share/nvim/{swap,backup,undo} ~/.local/state/nvim/
fi
