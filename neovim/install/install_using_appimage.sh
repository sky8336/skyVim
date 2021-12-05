#!/bin/bash
#
# Filename: install_using_appimage.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2021/12/05 - [Eric MA] Created file
#
# Maintainer: Eric MA <eric@email.com>
#    Created: 2021-12-05
# LastChange: 2021-12-05
#    Version: v0.0.01
#

# https://github.com/neovim/neovim/releases/tag/v0.6.0

wget https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage
chmod a+x nvim.appimage

# sudo cp nvim.appimage /usr/bin/nvim
