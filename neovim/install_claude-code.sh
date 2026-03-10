#!/bin/bash
#
# Filename: install_claude-code.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2026/03/10 - [Eric MA] Created file
#
# Maintainer: Eric MA <eric@email.com>
#    Created: 2026-03-10
# LastChange: 2026-03-10
#    Version: v0.0.01
#

# 1. 创建用户级别的 npm 全局目录
mkdir -p ~/.npm-global

# 2. 配置 npm 使用这个目录
npm config set prefix '~/.npm-global'

# 3. 将这个目录添加到 PATH
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.bashrc

# 4. 重新加载配置
source ~/.bashrc

# 5. 验证配置是否生效（这一步很重要！）
npm config get prefix
# 应该输出: /home/eric/.npm-global  （而不是 /usr/local）

# 6. 现在安装 claude-code（这次应该成功）
npm install -g @anthropic-ai/claude-code
