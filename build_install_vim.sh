#!/bin/bash

vim80_c_vim="/usr/share/vim/vim80/syntax/c.vim"
vim74_c_vim="/usr/share/vim/vim74/syntax/c.vim"
vim73_c_vim="/usr/share/vim/vim73/syntax/c.vim"

#获取开始时间和路径
function get_start_time_and_dir_path()
{
	start_time=$(date +"%s")
	vimcfig_bundle_dir_path=$(pwd)
	color_failed="\e[0;31m"
	color_success="\e[0;32m"
	color_reset="\e[00m"
	echo "dir_path: $vimcfig_bundle_dir_path"
}

#shell脚本下载数据时，先检测网络的畅通性
function check_network()
{
	#超时时间
	timeout=5

	#目标网站
	target=www.baidu.com

	#获取响应状态码
	ret_code=`curl -I -s --connect-timeout $timeout $target -w %{http_code} | tail -n1`

	if [ "x$ret_code" = "x200" ]; then
		#网络畅通
		echo -e "====== The Internet is connected ! ======"
	else
		#网络不畅通
		echo
		echo -e "${color_failed}>>> Error: the connection is lost ! "
		echo -e "Please check your Internet connection.${color_reset}"
		echo
		exit
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

	if which apt-get > /dev/null
	then
		sudo apt-get install -y ctags build-essential cmake python-dev python3-dev fontconfig git
		var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE")
		#systemVersion='DISTRIB_RELEASE=16.04'

                # fix issue: vim: error while loading shared libraries: libruby-2.3.so.2.3: cannot open shared object file: No such file or directory
                systemVersion='DISTRIB_RELEASE=18.04'
		if [ $var == $systemVersion ]
		then
			sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
				libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
				libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
				python3-dev ruby-dev lua5.1 lua5.1-dev
			sudo apt-get remove -y vim vim-runtime gvim
			sudo apt-get remove -y vim-tiny vim-common vim-gui-common vim-nox

			sudo rm -rf ~/vim
			sudo rm -rf /usr/share/vim/vim74
			sudo rm -rf /usr/share/vim/vim80

			git clone https://github.com/vim/vim.git ~/vim
			cd ~/vim
			./configure --with-features=huge \
				--enable-multibyte \
				--enable-rubyinterp \
				--enable-pythoninterp \
				--with-python-config-dir=/usr/lib/python2.7/config \
				--enable-perlinterp \
				--enable-luainterp \
				--enable-gui=gtk2 --enable-cscope --prefix=/usr
			make VIMRUNTIMEDIR=/usr/share/vim/vim80
			sudo make install
			cd -
			add_hilight_code_to_c_vim $vim80_c_vim
		else
			sudo apt-get install -y vim
		fi
	elif which yum > /dev/null
	then
		sudo yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel git
	fi

	ln /usr/bin/vim /usr/bin/vi
}

#echo install time
function echo_install_time()
{
    end_time=$(date +"%s")
    tdiff=$(($end_time-$start_time))
    hours=$(($tdiff / 3600 ))
    mins=$((($tdiff % 3600) / 60))
    secs=$(($tdiff % 60))
    echo
	echo -n -e "${color_success}#### install completed successfully! "
    if [ $hours -gt 0 ] ; then
        echo -n -e "($hours:$mins:$secs (hh:mm:ss))"
    elif [ $mins -gt 0 ] ; then
        echo -n -e "($mins:$secs (mm:ss))"
    elif [ $secs -gt 0 ] ; then
        echo -n -e "($secs seconds)"
    fi
    echo -e " ####${color_reset}"
    echo
}

get_start_time_and_dir_path
check_network
#build_and_install_vim
build_vim_by_source
echo_install_time
