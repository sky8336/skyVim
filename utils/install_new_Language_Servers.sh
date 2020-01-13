#!/bin/bash
#
# Filename: install_new_Language_Servers.sh
#
# Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
#
# History:
#    2020/01/13 - [eric] Created file
#
# Maintainer: eric <eric@email.com>
#    Created: 2020-01-13
# LastChange: 2020-01-13
#    Version: v0.0.2
#

source ~/.bashrc

sudo apt-get install python3-venv

progress_log()
{
	echo -e [$1%] $2
}

language=(
	c
	py
	sh
)

install_lsp()
{
	num=${#language[@]}

	local cur_prog=0
	local prog=$cur_prog
	local step=$(echo 100/$num |bc)
	local let i=0

	progress_log $prog "====== install language server(num=$num) now ! ======"

	while [[ $i -lt $num ]]; do
		if [[ -d ${language[i]} ]]; then
			log_str="[${language[i]}] Language Server already exist. "
		else
			if [[ -d "/usr/local/vim" ]]; then
				/usr/local/vim/bin/vim main.${language[i]} +LspInstallServer +qall
			else
				vim main.${language[i]} +LspInstallServer +qall
			fi

			log_str="install language[$i] Language Server: ${language[i]} ... done"
			sleep 1
		fi
		let prog+=$step
		progress_log "$prog" "$log_str"
		let i++
	done

	progress_log "100" "install language[$i]: ${language[i]} ... done"
}

install_lsp
