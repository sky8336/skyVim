#!/bin/bash

# verified on ubuntu 16.04
sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get -y install neovim

# ~/.config/nvim/init.vim
cp nvim/ ~/.config/ -rf
