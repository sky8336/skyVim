#!/bin/bash
#
# clean_disk.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/08/10 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2019-08-10
# LastChange: 2019-08-10
#    Version: v0.0.01
#

# 移除不再需要的软件包
sudo apt autoremove

# 清理apt cache
# /var/cache/apt
sudo apt autoclean
sudo apt clean

# 清理缩略图缓存
# ~/.cache/thumbanails
rm -rf ~/.cache/thumbnails/*

# 列出当前ubuntu中已经安装的linux kernel
sudo dpkg --list 'linux-image*'*
# 删除手动安装的内核
# 保留至少两个或三个最新版本内核，在无法使用最新内核时急救替代品
# sudo apt remove linux-image-$VERSION

# other tools
# Disk Usage Analyzer
