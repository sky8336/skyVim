#!/bin/bash

# verified on ubuntu 16.04
#sudo add-apt-repository -y ppa:neovim-ppa/unstable

# rm /etc/apt/sources.list.d/neovim-ppa-ubuntu-unstable-bionic.list.
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get -y install neovim

# install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# config neovim
source ./config.sh
