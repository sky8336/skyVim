#!/bin/bash
#
# common.sh
#
# Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/12/31 - [eric] Created file
#
# Maintainer: eric <eric@email.com>
#    Created: 2019-12-31
# LastChange: 2019-12-31
#    Version: v0.0.01
#

source ./utils.sh

#
# utils functions
#

#获取开始时间和路径
function get_start_time_and_dir_path()
{
	get_start_time
	skyvim_path=$(pwd)
	echo "dir_path: $skyvim_path"
}

online_offline_select()
{
	check_network

	if [[ $online -eq 0  ]]; then
		echo -e "${color_failed}>>> Warnning: Network connection is unavailable! "
		-               echo -e "Please check your Internet connection."
		-               echo -e "It will be installed offline，maybe not the latest !${color_reset}"
	fi
}

assert_online()
{
	check_network
	if [[ $online -eq 0  ]]; then
		echo
		echo -e "${color_failed}>>> Error: Network connection is unavailable! "
		echo -e "Please check your Internet connection.${color_reset}"
		echo
		exit
	fi
}


#
# vim common
#
get_built_vim_version()
{
	vi_major_ver_str="Vi IMproved 8"

	local vi_ver=$(/usr/local/vim/bin/vim --version | \
		grep "$vi_major_ver_str" --color | \
		awk -F '-' '{print $2}' | awk -F '(' '{print $1}' |\
		awk '$1=$1' | awk -F '(' '{print $1}' | awk '{print $3}')

	echo "$vi_ver" #return string
}

update_bashrc_my()
{
	real_vi_ver=$(get_built_vim_version)
	if [[ "${real_vi_ver}" = "8.2" ]]; then
		blue_log "$real_vi_ver has been installed!"
		vim_in_usr_local=1
	elif [[ "$real_vi_ver" = "8.1" ]]; then
		blue_log "$real_vi_ver has been installed!"
		vim_in_usr_local=1
	else
		blue_log "vim 8.1 or v8.2 has not been installed!"
		vim_in_usr_local=0
		return 0
	fi

	if [[ $vim_in_usr_local -eq 1 ]];then
		# add the following to ~/.bashrc_my, replace of alias vi=
		#alias vi='/usr/local/vim/bin/vim'
		if [ -f ~/.bashrc_my ]; then
			sed -i "s%^alias vi=.*$%alias vi='/usr/local/vim/bin/vim'%g" ~/.bashrc_my
			echo "alias vimdiff='/usr/local/vim/bin/vimdiff'" >> ~/.bashrc_my
		else
			echo "alias vi='/usr/local/vim/bin/vim'" >> ~/.bashrc
			echo "alias vimdiff='/usr/local/vim/bin/vimdiff'" >> ~/.bashrc
		fi

		cp ~/.gitconfig ~/.gitconfig.bak
		sed -i "s%^.*editor.*$%\teditor = /usr/local/vim/bin/vim%g" ~/.gitconfig
	fi
	source ~/.bashrc

	echo "update .bashrc_my and .gitconfig -- done"
}

