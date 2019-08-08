#!/bin/bash
#
# install_vim-autoformat_tools.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/08/08 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2019-08-08
# LastChange: 2019-08-08
#    Version: v0.0.01
#

#vim-autoformat常用工具:
#分别是astyle（支持C, C++, C++/CLI, Objective‑C, C#和Java）;
#clang-format（支持C, C++,和Objective-C ）;
#python-pep8,python3-pep8,python-autopep8和yapf（Google开发的Python格式化工具）

sudo apt install astyle clang-format python-pep8 python3-pep8 python-autopep8 yapf  --allow-unauthenticated
