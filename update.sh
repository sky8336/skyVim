#!/bin/bash
#
# updates.sh
#
# Copyright (C) 2016-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2016/04/27 - [Eric MA] Created file
#
# Maintainer: Eric MA <eric@email.com>
#    Created: 2016-04-27
# LastChange: 2019-11-11
#    Version: v0.0.36
#

blue_log()
{
	color_blue='\E[1;34m'
	color_reset="\e[00m"
	echo -e "${color_blue}$1${color_reset}" 1>&2
}

logo_path=./utils/.logo
logo_files=($(ls $logo_path | awk '{print $1}'))

show_logo()
{
	cur_second=`date +%S`
	logo_num=${#logo_files[@]}
	index=$((10$cur_second%$logo_num))
	#echo "logo_num:$logo_num"
	cat $logo_path/${logo_files[index]}
}

# used for step2
global_variables_setup()
{
	vim_plug_dir=~/.vim/autoload
	# we use vim-plug as plugin manager by default

	your_name=$(echo $HOME | awk -F '/' '{print $3}')

	skyvim_path=$(pwd)
	repo_name=$(echo $skyvim_path | awk -F '/'  '{print $NF}')


	# sudo 权限执行，会使得包括.git目录下的变更文件变成root用户和用户组,影响git
	# 操作, 如导致git add -A和git commit -s要加sudo; 这里都恢复普通用户
	username=`ls -l ../ | grep $repo_name | awk '{print $3}'`
	groupname=`ls -l ../ | grep $repo_name | awk '{print $4}'`
	echo "repo name: $repo_name"
	echo "dir_path: $skyvim_path"

	echo "username=$username"
	echo "groupname=$groupname"

}

#
# utils functions
#
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
		echo -e "${color_failed}>>> Error: Remove you root privileges!"
		echo -e "Please input \"./update.sh\"${color_reset}"
		exit
	else
		echo "You have normal privileges!"
	fi
}

#获取开始时间和路径
function get_start_time()
{
	start_time=$(date +"%s")
}

#shell脚本下载数据时，先检测网络的畅通性
function check_network()
{
	#超时时间
	timeout=9

	#目标网站
	target=www.baidu.com

	if which curl > /dev/null ; then
		echo "Find curl."
	else
		sudo apt-get install curl --allow-unauthenticated > /dev/null
	fi

	if which curl > /dev/null ; then
		#获取响应状态码
		ret_code=`curl -I -s --connect-timeout $timeout $target -w %{http_code} | tail -n1`
	else
		echo "check your Network, and install curl."
	fi

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

#
# update related apis
#

# first step
function update_vimcfg_bundle()
{
	skyvim_path=$(pwd)
	repo_name=$(echo $skyvim_path | awk -F '/'  '{print $NF}')

	echo "====== update $repo_name: git pull ======"

	chown -R $username:$groupname ../$repo_name
	git pull
	chown -R $username:$groupname ../$repo_name
	echo "update $repo_name -- done"
}

#备份OS中vimrc
function bakup_vimrc()
{
	echo "====== Bakup your vimrc ! ======"
	if [[ ! -d $HOME/.bakvim ]]; then
		mkdir .bakvim
	fi

	if [[ -f $HOME/.vimrc ]]; then
		cp $HOME/.vimrc $HOME/.bakvim
	fi

	if [[ -f $HOME/.vim/README.md ]]; then
		cp $HOME/.vim/README.md $HOME/.bakvim
	fi

	if [[ -d $HOME/.vim/my_help ]]; then
		cp $HOME/.vim/my_help/ $HOME/.bakvim -dpRf
	fi

	if [[ -d $HOME/.vim/colors ]]; then
		cp $HOME/.vim/colors/ $HOME/.bakvim -dpRf
	fi

	if [[ -d $HOME/.vim/sky8336 ]]; then
		cp $HOME/.vim/sky8336 $HOME/.baksky8336 -dpRf
	fi

	echo "update $repo_name -- done"
}

update_bashrc_my()
{

	/usr/local/vim/bin/vim --version | grep "Vi IMproved 8.1" --color
	if [ $? -eq 0 ]; then
		echo "Vi IMproved 8.1 has been installed!"
		vim_version="v8.1"
		vim_in_usr_local=1
	else
		echo "vim version is not v8.1"
		vim_in_usr_local=0
		return 0
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

		cp ~/.gitconfig ~/.gitconfig.update.bak
		sed -i "s%^.*editor.*$%\teditor = /usr/local/vim/bin/vim%g" ~/.gitconfig
	fi
	source ~/.bashrc

	echo ""update .bashrc_my and .gitconfig -- done
}


# 更新vimrc
function update_vimrc()
{
	echo "====== Config your vim now ! ======"
	if [[ -f $HOME/.vim ]]; then
		rm $HOME/.vim
	fi

	if [[ ! -d $HOME/.vim ]]; then
		mkdir $HOME/.vim
	fi

	cp ./.vimrc $HOME
	cp ./README.md $HOME/.vim
	cp ./my_help/ $HOME/.vim -dpRf
	cp ./.vim/colors/ $HOME/.vim -dpRf
	cp ./.vim/sky8336 $HOME/.vim -dpRf
	cp ./.vim/tools $HOME/.vim -dpRf

	# add your name to the title
	sed -i "s/Eric MA/$your_name/" $HOME/.vim/sky8336/setTitle.vim
	sed -i "s/eric/$your_name/" $HOME/.vim/sky8336/setTitle.vim

	##追加到.bashrc,不会覆盖.bashrc原有配置
	#cat $skyvim_path/.self_mod/.bashrc_append >> ~/.bashrc
	cp $skyvim_path/.self_mod/.bashrc_append ~/.bashrc_my
	grep "source ~/.bashrc_my" ~/.bashrc
	if [ $? -eq 0 ]; then
		# "Found! ~/.bashrc have been modified."
		echo
	else
		echo "source ~/.bashrc_my" >> ~/.bashrc
	fi


	if [[ -d "/usr/local/vim" ]]; then
		# which we built from source
		update_bashrc_my

		local vim_syntax_c=/usr/local/vim/share/vim/vim81/syntax/c.vim
		grep "my_vim_highlight_config" ${vim_syntax_c}
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			sudo cat $skyvim_path/.self_mod/highlight_code.vim >> ${vim_syntax_c}
		fi
	else
		#函数名、运算符、括号等高亮
		if [[ -d "/usr/share/vim/vim81" ]]; then
			vim_in_usr_share="/usr/share/vim/vim81"
		elif [[ -d "/usr/share/vim/vim80" ]]; then
			vim_in_usr_share="/usr/share/vim/vim80"
		elif [[ -d "/usr/share/vim/vim74" ]]; then
			vim_in_usr_share="/usr/share/vim/vim74"
		elif [[ -d "/usr/share/vim/vim73" ]]; then
			vim_in_usr_share="/usr/share/vim/vim73"
		fi

		grep "my_vim_highlight_config" $vim_in_usr_share/syntax/c.vim
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			sudo cat $skyvim_path/.self_mod/highlight_code.vim >> $vim_in_usr_share/syntax/c.vim
		fi

	fi

	var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE" --color)
	systemVersion='DISTRIB_RELEASE=18.04'
	if [ $var == $systemVersion ]; then
		echo "using default .vimrc"
	else
		echo "DISTRIB_RELEASE is not 18.04, maybe 16.04"
		sed -i "s/let ubuntu18_04 = 1/let ubuntu18_04 = 0/" ~/.vim/sky8336/plugin.vim
	fi

	echo "config your vim -- done"
}

update_package()
{
	# TODO
	echo "install some package using script in utils"
	cp ./utils/viman /usr/local/bin
}

#instal new plugin
function install_new_plugin()
{
	if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
		echo "====== vim-plug was missing, install now ! ======"
		curl -fLo $vim_plug_dir/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

		chown -R $username:$groupname $vim_plug_dir
	fi

	echo "====== install new plugin now ! ======"
	if [[ $vim_in_usr_local -eq 1 ]]; then
		# vim-plug
		/usr/local/vim/bin/vim +PlugInstall +qall
		#/usr/local/vim/bin/vim +PlugClean +qall
		# Fixme: self mod maybe not used but copy to the directory
		cp $skyvim_path/.self_mod/.plugin_self-mod/plugged/* ~/.vim/plugged/ -rf
	else
		# vim-plug
		vim +PlugInstall +qall
		#vim +PlugClean +qall
	fi
	chown -R $username:$groupname ~/.vim

	if [[ -f ~/.vim_mru_files ]]; then
		chown -R $username:$groupname ~/.vim_mru_files
	fi

	echo "install new plugin -- done"
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

# git config
function git_config()
{
	echo "====== git config ======"
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
	echo "git config -- done"
}

#
update_vimcfg()
{
	global_variables_setup
	bakup_vimrc
	update_vimrc
	update_package
	install_new_plugin
	git_config
}

main()
{
	if [[ -z $1 ]]; then
		echo
		blue_log ">> step1: prepare and update $repo_name repo."
		set_color
		# prepare
		check_root_privileges
		get_start_time
		check_network

		# step1: update $repo_name
		update_vimcfg_bundle
		echo "$repo_name repo update -- done"

		# now update.sh has been updated
		# execure step2 using new script
		sudo ./update.sh 1

		echo_install_time
	elif [[ $1 -eq 1 ]]; then
		echo
		blue_log ">> step2: setup vim config now!"
		# step2: setup vim config
		update_vimcfg
		echo "vim config setup -- done."
		show_logo
	else
		echo "invalid  parameter."
	fi
}

main "$@"
