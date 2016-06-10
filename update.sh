#!/bin/bash

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

	#函数名、运算符、括号等高亮
	# 执行install.sh时是2016-06-26 10:48:05 之前的配置的,打开以下两行执行update.sh
	#cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim73/syntax/c.vim
	#cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim74/syntax/c.vim
}

#instal new plugin
function install_new_plugin()
{
	echo "====== install new plugin now ! ======"
	vim +BundleInstall +qall
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

get_start_time_and_dir_path
check_network
update_vimcfg
bakup_vimrc
update_vimrc
install_new_plugin
echo_install_time
