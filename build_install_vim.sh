#!/bin/bash
#
# build_install_vim.sh
#
# Copyright (C) 2016-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2016/08/17 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2016-08-17
# LastChange: 2020-04-20
#    Version: v0.0.20
#

source ./common.sh

# global
opt_dependent="0"
opt_clone="1"
opt_update="2"
opt_build="3"
opt_install="4"
opt_build_install="5"
opt_clone_build_install="6"
opt_update_build_install="7"
opt_update_bashrc_my="8"
opt_max=$opt_update_bashrc_my

# show_header specify content
VERSION=0.0.17
tool_name="Initcall_debug setup tool"

# show_usage Specify content
usage=(
"`basename $0` [options]
		vim_version: $vim_version
		vim_source: $vim_source"
)

options=(
"[0,1,2,3,..., 7]		Specify which function you'd like to run"
)

ret_codes=(
"0 (not xx), 2 (xx), 3 (unknown), 255 (error)"
)

examples=(
"`basename $0` $opt_dependent - install dependent package
		`basename $0` $opt_clone - git clone vim
		`basename $0` $opt_update - update vim source
		`basename $0` $opt_build - build vim source
		`basename $0` $opt_install - install_vim_built
		`basename $0` $opt_build_install - build and install
		`basename $0` $opt_clone_build_install - clone, build and install
		`basename $0` $opt_update_build_install - update, build and install
		`basename $0` $opt_update_bashrc_my - update .bashrc_my for vim built from source"
)

#modify vim version here
vim_version="v8.2"
vim_source=~/vim

if [[ $vim_version = "v8.1" ]]; then
	new_vim=vim81
elif [[ $vim_version = "v8.2" ]]; then
	new_vim=vim82
fi

newvim_c_vim="/usr/share/vim/$new_vim/syntax/c.vim"

#
# APIs
#


#函数名、运算符、括号等高亮
function add_hilight_code_to_c_vim()
{
	if [ -f $1 ]; then
		grep "my_vim_highlight_config" $1
		if [ $? -eq 0 ]; then
			echo "Found my_vim_highlight_config! $1 have been modified."
		else
			echo "Not found my_vim_highlight_config! Modify $1 now."
			cat $skyvim_path/.self_mod/highlight_code.vim >> $1
		fi
	else
		echo "can not found $1"
	fi
}


#
install_dependent_package()
{
	sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
		libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
		libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
		python3-dev ruby-dev lua5.1 lua5.1-dev
}

#
clone_vim_from_github()
{
	if [[ -d $vim_source ]]; then
		sudo mv $vim_source $vim_source.bak
	fi
	git clone https://github.com/vim/vim.git $vim_source
}

#
update_vim_repo()
{
	check_dir $vim_source
	cd $vim_source
	git pull
	cd -
}

#
build_vim_repo()
{
	cd $vim_source

	if [[ $vim_version = "v8.1" || $vim_version = "v8.2" ]]; then
		blue_log "build $vim_version"
		# vim8.1/vim8.2 config
		./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
			--enable-pythoninterp --enable-python3interp --enable-luainterp \
			--enable-cscope --enable-gui=gtk3 --enable-perlinterp \
			--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
			--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
			--prefix=/usr/local/vim

		local major=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $1}' | sed 's/^[ \t]*//g')
		local minor=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $2}')

		#make VIMRUNTIMEDIR=/usr/local/vim/$new_vim
		make VIMRUNTIMEDIR=/usr/local/vim/share/vim/vim${major}${minor}

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
	else
		error_exit "specify which vim version to build"
	fi

	cd -
}

install_vim_after_built()
{
	cd $vim_source
	sudo make install
	cd -
	update_bashrc_my
}

build_install_vim()
{
	build_vim_repo
	install_vim_after_built
}

clone_build_install_vim()
{
	clone_vim_from_github
	build_install_vim
}

update_build_install_vim()
{
	update_vim_repo
	build_install_vim
}

main()
{
	sudo echo
	set_color
	check_root_privileges
	get_start_time_and_dir_path

	show_logo

	if [ -z "$1" ]; then
		show_header
		show_usage
		warning_log "`basename $0` [opt]: opt should be 0, 1, ..., $opt_max"
		exit
	elif [ "$1" = $opt_dependent ]; then
		blue_log "install dependent package"
		install_dependent_package "$@"
	elif [ "$1" = $opt_clone ]; then
		blue_log "git clone vim"
		clone_vim_from_github "$@"
	elif [ "$1" = $opt_update ]; then
		blue_log "update vim source"
		update_vim_repo "$@"
	elif [ "$1" = $opt_build ]; then
		blue_log "build vim source"
		build_vim_repo "$@"
	elif [ "$1" = $opt_install ]; then
		blue_log "install_vim_built"
		install_vim_after_built "$@"
	elif [ "$1" = $opt_build_install ]; then
		blue_log "build and install"
		build_install_vim "$@"
	elif [ "$1" = $opt_clone_build_install ]; then
		blue_log "clone, build and install"
		clone_build_install_vim "$@"
	elif [ "$1" = $opt_update_build_install ]; then
		blue_log "update, build and install"
		update_build_install_vim "$@"
	elif [ "$1" = $opt_update_bashrc_my ]; then
		blue_log "update .bashrc_my for vim built from source"
		update_bashrc_my "$@"
	else
		echo "do nothing"
		exit
	fi


	check_network

	clone_vim=$1

	show_logo
	echo_execu_time
}

main "$@"
