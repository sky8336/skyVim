#!/bin/bash
#
# install_universal-ctags.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/07/25 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2019-07-25
# LastChange: 2019-07-25
#    Version: v0.0.01
#
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
sudo make install
