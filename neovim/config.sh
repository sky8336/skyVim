#!/bin/bash
# ~/.config/nvim/init.vim
cp nvim/ ~/.config/ -rf
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall
