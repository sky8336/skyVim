#!/bin/bash
#
# Filename: common.sh
#
# Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/12/31 - [eric] Created file
#
# Maintainer: eric <eric@email.com>
#    Created: 2019-12-31
# LastChange: 2020-08-29
#    Version: v0.0.5
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

build_vim_source_code()
{
	local pkgs=(
		libncurses5-dev
		libgnome2-dev
		libgnomeui-dev
		libgtk2.0-dev
		libatk1.0-dev
		libbonoboui2-dev
		libcairo2-dev
		libx11-dev
		libxpm-dev
		libxt-dev
		python-dev
		python3-dev
		ruby-dev
		lua5.1
		lua5.1-dev
	)

	for item in ${pkgs[@]}
	do
		echo -n ">> install $item ... "
		yes | sudo apt-get --allow-unauthenticated install $item 2>&1 > /dev/null
		echo "done!"
	done


	# vim8.1/vim8.2 config
	local location=/usr/local

	if [ ! -z $1 ]; then
		local commit_id=$1
		git reset --hard ${commit_id}
	fi


	./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
		--enable-pythoninterp --enable-python3interp --enable-luainterp \
		--enable-cscope --enable-gui=gtk3 --enable-perlinterp \
		--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
		--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
		--prefix=$location/vim

	# 编译时相关参数说明:
	# --with-features=huge：支持最大特性
	# --enable-rubyinterp：打开对 ruby 编写的插件的支持
	# --e--enable-pythoninterp：打开对 python 编写的插件的支持
	# --e--enable-python3interp：打开对 python3 编写的插件的支持
	# --e--enable-luainterp：打开对 lua 编写的插件的支持
	# --e--enable-perlinterp：打开对 perl 编写的插件的支持
	# --e--enable-multibyte：打开多字节支持，可以在 Vim 中输入中文
	# --e--enable-cscope：打开对cscope的支持
	# --e--enable-gui=gtk3 表示生成采用 GNOME3 风格的 gvim
	# --e--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ 指定 python 路径
	# --e--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ 指定 python3路径
	# --e--prefix=/usr/local/vim：指定将要安装到的路径

	local major=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $1}' | sed 's/^[ \t]*//g')
	local minor=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $2}')

	echo -n ">> ${FUNCNAME[0]}: make ... "
	make VIMRUNTIMEDIR=$location/vim/share/vim/vim${major}${minor} > /dev/null
}

config_git()
{
	# set merge tool and editor
	# To use vimdiff as default merge tool:
	git config --global merge.tool vimdiff
	git config --global mergetool.prompt false
	if [[ $vim_in_usr_local -eq 1 ]]; then
		git config --global core.editor /usr/local/vim/bin/vim
	else
		git config --global core.editor /usr/bin/vim
	fi
	git config --global push.default simple

	# git d //open files to diff
	git config --global diff.tool vimdiff
	git config --global difftool.prompt false
	git config --global alias.d difftool

	# git lg 列出 git 分支图
	git config --global alias.lg "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
}
