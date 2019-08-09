#!/bin/bash

#set color
function set_color()
{
	color_failed="\e[0;31m"
	color_success="\e[0;32m"
	color_reset="\e[00m"
}

#检查root权限
function check_root_privileges()
{
	if [ $UID -eq 0 ]; then
		echo "You have root privileges!"
	else
		echo -e "${color_failed}>>> Error: You don't have root privileges!"
		echo -e "Please input \"sudo ./update.sh\"${color_reset}"
		exit
	fi
}

#获取开始时间和路径
function get_start_time_and_dir_path()
{
	start_time=$(date +"%s")
	vimcfig_bundle_dir_path=$(pwd)
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
		echo -e "${color_failed}>>> Error: Network connection is unavailable! "
		echo -e "Please check your Internet connection.${color_reset}"
		echo
		exit
	fi
}

function update_vimcfg()
{
	echo "====== git pull ======"
	git pull
}

#备份OS中vimrc
function bakup_vimrc()
{
	echo "====== Bakup your vimrc ! ======"
	cp $HOME/.vimrc $HOME/.bakvim
	cp $HOME/.vim/README.md $HOME/.bakvim
	cp $HOME/.vim/my_help/ $HOME/.bakvim -a
	cp $HOME/.vim/colors/ $HOME/.bakvim -a
}

update_bashrc_my()
{

	/usr/local/vim/bin/vim --version | grep "Vi IMproved 8.1" --color
	if [ $? -eq 0 ]; then
		echo "Vi IMproved 8.1 has been installed!"
		vim_version="v8.1"
	else
		echo "vim version is not v8.1"
	fi

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
	source ~/.bashrc
}


# 更新vimrc
function update_vimrc()
{
	echo "====== Config your vim now ! ======"
	cp ./.vimrc $HOME
	cp ./README.md $HOME/.vim
	cp ./my_help/ $HOME/.vim -a
	cp ./.vim/colors/ $HOME/.vim -a

	##追加到.bashrc,不会覆盖.bashrc原有配置
	#cat $vimcfig_bundle_dir_path/.self_mod/.bashrc_append >> ~/.bashrc
	cp $vimcfig_bundle_dir_path/.self_mod/.bashrc_append ~/.bashrc_my


	if [[ -d "/usr/local/vim" ]]; then
		# which we built from source
		update_bashrc_my

		local vim_syntax_c=/usr/local/vim/share/vim/vim81/syntax/c.vim
		grep "my_vim_highlight_config" ${vim_syntax_c}
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> ${vim_syntax_c}
		fi
	else
		#函数名、运算符、括号等高亮
		grep "my_vim_highlight_config" /usr/share/vim/vim74/syntax/c.vim
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim74/syntax/c.vim
		fi

		grep "my_vim_highlight_config" /usr/share/vim/vim73/syntax/c.vim
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim73/syntax/c.vim
		fi
	fi

	var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE" --color)
	systemVersion='DISTRIB_RELEASE=18.04'
	if [ $var == $systemVersion ]; then
		echo "using default .vimrc"
	else
		echo "DISTRIB_RELEASE is not 18.04, maybe 16.04"
		sed -i "s/let ubuntu18_04 = 1/let ubuntu18_04 = 0/" ~/.vimrc
	fi
}

update_package()
{
	# TODO
	echo "install some package using script in utils"
}

#instal new plugin
function install_new_plugin()
{
	echo "====== install new plugin now ! ======"
	vim +BundleInstall +qall
	vim +BundleClean +qall
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
        echo -n -e "${color_success}#### update completed successfully! "
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

set_color
check_root_privileges
get_start_time_and_dir_path
check_network
update_vimcfg
bakup_vimrc
update_vimrc
update_package
install_new_plugin
echo_install_time
