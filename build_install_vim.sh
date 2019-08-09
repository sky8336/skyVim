#!/bin/bash

source ./utils.sh

# global
opt_dependent="0"
opt_clone="1"
opt_update="2"
opt_build="3"
opt_install="4"
opt_build_install="5"
opt_clone_build_install="6"
opt_update_build_install="7"
update_bashrc_my="8"

vim_version="v8.1"
vim_source=~/vim

# show_header specify content
VERSION=0.05
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
"`basename $0` $opt_dependent	-	install dependent package
		`basename $0` $opt_clone	-	git clone vim
		`basename $0` $opt_update	-	update vim source
		`basename $0` $opt_build	-	build vim source
		`basename $0` $opt_install	-	install_vim_built
		`basename $0` $opt_build_install	-	build and install
		`basename $0` $opt_clone_build_install	-	clone, build and install
		`basename $0` $opt_update_build_install	-	update, build and install
		`basename $0` $update_bashrc_my	-	update .bashrc_my for vim built from source"
)

new_vim=vim81
newvim_c_vim="/usr/share/vim/$new_vim/syntax/c.vim"
vim80_c_vim="/usr/share/vim/vim80/syntax/c.vim"
vim74_c_vim="/usr/share/vim/vim74/syntax/c.vim"
vim73_c_vim="/usr/share/vim/vim73/syntax/c.vim"


#
# APIs
#

#获取开始时间和路径
function get_dir_path()
{
	vimcfig_bundle_dir_path=$(pwd)
	#echo "dir_path: $vimcfig_bundle_dir_path"
}

#shell脚本下载数据时，先检测网络的畅通性
function check_network()
{
	#超时时间
	timeout=10

	#目标网站
	target=www.baidu.com

	#获取响应状态码
	ret_code=`curl -I -s --connect-timeout $timeout $target -w %{http_code} | tail -n1`

	if [ "x$ret_code" = "x200" ]; then
		#网络畅通
		pstatus green "connected" "network state"
	else
		#网络不畅通
		pstatus red "the connection is lost" "network state"
		error_exit "${color_failed}the connection is lost !  Please check your Internet connection."
	fi
}


#函数名、运算符、括号等高亮
function add_hilight_code_to_c_vim()
{
	if [ -f $1 ]; then
		grep "my_vim_highlight_config" $1
		if [ $? -eq 0 ]; then
			echo "Found my_vim_highlight_config! $1 have been modified."
		else
			echo "Not found my_vim_highlight_config! Modify $1 now."
			cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> $1
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

	if [[ $vim_version = "v8.0" ]]; then
		blue_log "build $vim_version"

		# vim8.0 config
		./configure --with-features=huge \
			--enable-multibyte \
			--enable-rubyinterp \
			--enable-pythoninterp \
			--with-python-config-dir=/usr/lib/python2.7/config \
			--enable-perlinterp \
			--enable-luainterp \
			--enable-gui=gtk2 --enable-cscope --prefix=/usr

		make VIMRUNTIMEDIR=/usr/share/vim/$new_vim
	elif [[ $vim_version = "v8.1" ]]; then
		blue_log "build $vim_version"
		# vim8.1 config
		./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
			--enable-pythoninterp --enable-python3interp --enable-luainterp \
			--enable-cscope --enable-gui=gtk3 --enable-perlinterp \
			--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
			--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
			--prefix=/usr/local/vim

		#make VIMRUNTIMEDIR=/usr/local/vim/$new_vim
		make VIMRUNTIMEDIR=/usr/local/vim/share/vim/$new_vim

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

update_bashrc_my()
{
	if [[ $vim_version = "v8.1" ]];then
		# add the following to ~/.bashrc_my, replace of alias vi=
		#alias vi='/usr/local/vim/bin/vim'
		if [ -f ~/.bashrc_my ]; then
			sed -i "s%^alias vi=.*$%alias vi='/usr/local/vim/bin/vim'%g" ~/.bashrc_my
			echo "alias vimdiff='/usr/local/vim/bin/vimdiff'" >> ~/.bashrc_my
		else
			cp ~/.bashrc ~/bashrc.bak
			echo "alias vi='/usr/local/vim/bin/vim'" >> ~/.bashrc
			echo "alias vimdiff='/usr/local/vim/bin/vimdiff'" >> ~/.bashrc
		fi

		cp ~/.gitconfig ~/.gitconfig.bak
		sed -i "s%^.*editor.*$%\teditor = /usr/local/vim/bin/vim%g" ~/.gitconfig
	fi
}

install_vim_after_built()
{
	cd $vim_source
	sudo make install
	cd -
	update_bashrc_my
}


# update vim to vim7.4
function build_and_install_vim()
{
	echo "[Need 12 minutes]"
	git clone https://github.com/vim/vim.git

	cd vim
	pwd

	echo "====== configure ======"
	./configure --with-features=huge \
		--enable-rubyinterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--enable-perlinterp=yes \
		--enable-luainterp=yes \
		--enable-gui=gtk2 --enable-cscope --prefix=/usr

	echo "====== make ======"
	sudo make VIMRUNTIMEDIR=/usr/share/vim/vim74
	sudo make install

	vim --version | grep Vi
	cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim74/syntax/c.vim
}

#build vim
function build_vim_by_source()
{
	if which apt-get > /dev/null ; then
		sudo apt-get install -y ctags build-essential cmake python-dev python3-dev fontconfig git
		var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE")
		#systemVersion='DISTRIB_RELEASE=16.04'

                # fix issue: vim: error while loading shared libraries: libruby-2.3.so.2.3: cannot open shared object file: No such file or directory
                systemVersion='DISTRIB_RELEASE=18.04'
		if [ $var == $systemVersion ]; then
			install_dependent_package
			sudo apt-get remove -y vim vim-runtime gvim
			sudo apt-get remove -y vim-tiny vim-common vim-gui-common vim-nox

			#sudo mv /usr/share/vim/vim74 /usr/share/vim/vim74.bak
			#sudo mv /usr/share/vim/vim80 /usr/share/vim/vim80.bak
			sudo mv /usr/share/vim/$new_vim /usr/share/vim/$new_vim.bak

			clone_vim_from_github
			build_vim_repo
			install_vim_after_built
			add_hilight_code_to_c_vim $newvim_c_vim
		else
			sudo apt-get install -y vim
		fi
	elif which yum > /dev/null ; then
		sudo yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel git
	fi

	ln /usr/bin/vim /usr/bin/vi

}


#
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
	set_color
	get_start_time

	get_dir_path

	if [ -z "$1" ]; then
		show_header
		show_usage
		warning_log "`basename $0` [opt]: opt should be 0, 1, ..., 7"
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
	elif [ "$1" = $update_bashrc_my ]; then
		blue_log "update .bashrc_my for vim built from source"
		update_bashrc_my "$@"
	else
		echo "do nothing"
		exit
	fi


	check_network

	clone_vim=$1

	#build_and_install_vim
	#build_vim_by_source
	echo_execu_time
}

main "$@"
