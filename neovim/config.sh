#!/bin/bash
# ~/.config/nvim/init.vim
cp -dpRf nvim/ ~/.config/ -rf

# install nvim plugin
nvim +PlugInstall +qall
