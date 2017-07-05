#!/bin/bash
# ~/.config/nvim/init.vim
cp nvim/ ~/.config/ -rf

# install nvim plugin
nvim +PlugInstall +qall
