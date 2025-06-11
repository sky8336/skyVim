#!/bin/bash
#
# Filename: update.sh
#
# Copyright (C) 2016-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2016/04/27 - [Eric MA] Created file
#
# Maintainer: Eric MA <eric@email.com>
#    Created: 2016-04-27
# LastChange: 2021-01-28
#    Version: v0.0.62
#

source ./common.sh

# used for step2
global_variables_setup()
{

	echo "--- ${FUNCNAME[0]}():"
	skyvim_path=$(pwd)
	repo_name=$(echo $skyvim_path | awk -F '/'  '{print $NF}')


	# sudo 权限执行，会使得包括.git目录下的变更文件变成root用户和用户组,影响git
	# 操作, 如导致git add -A和git commit -s要加sudo; 这里都恢复普通用户
	username=`ls -l ../ | grep $repo_name | awk '{print $3}'`
	groupname=`ls -l ../ | grep $repo_name | awk '{print $4}'`
	echo "skyvim_path=$skyvim_path"
	echo "repo_name=$repo_name"

	echo "username=$username"
	echo "groupname=$groupname"

	if [[ ~ = "/root" ]]; then
		your_name=$username
		vim_plug_dir=/home/$your_name/.vim/autoload
		# we use vim-plug as plugin manager by default
	else
		your_name=$(echo $HOME | awk -F '/' '{print $3}')
		vim_plug_dir=~/.vim/autoload
	fi
	echo "your_name=$your_name"
	echo "vim_plug_dir=$vim_plug_dir"
}


#
# update related apis
#

# first step
function update_skyVim
{
	skyvim_path=$(pwd)
	repo_name=$(echo $skyvim_path | awk -F '/'  '{print $NF}')

	echo "====== ${FUNCNAME[0]}(): update $repo_name: git pull ======"

	git_owner=`ls -l .git | grep "ORIG_HEAD" | awk '{print $3}'`
	if [[ $git_owner = "root" ]]; then
		sudo chown -R $username:$groupname ../$repo_name
		sudo chown -R $username:$groupname .git
	fi
	git pull 2>&1 > /dev/null
	echo "${FUNCNAME[0]}(): update $repo_name -- done"
}

#备份OS中vimrc, ..., etc. all related files
function bakup_vimrc()
{
	if [[ $HOME = "/root" ]]; then
		local cfg_path="/home/$username"
	else
		local cfg_path=$HOME
	fi
	local bak_vim=$cfg_path/.bakvim

	echo "====== ${FUNCNAME[0]}(): Bakup your vim cfg in $bak_vim ! ======"
	if [ -d "$bak_vim" ]; then
		sudo chown -R $username:$groupname $bak_vim
		rm -rf $bak_vim
	fi
	mkdir $bak_vim

	if [ -d "${cfg_path}/.vim" ]; then
		sudo chown -R $username:$groupname ${cfg_path}/.vim
		cp -dpRf $cfg_path/.vim  $bak_vim
	fi

	if [ -f "${cfg_path}/.vimrc" ]; then
		sudo chown $username:$groupname ${cfg_path}/.vimrc
		cp $cfg_path/.vimrc $bak_vim
	fi
	if [ -f "${cfg_path}/.bashrc" ]; then
		cp $cfg_path/.bashrc $bak_vim
	fi

	if [ -f "${cfg_path}/.bashrc_my" ]; then
		sudo chown $username:$groupname ${cfg_path}/.bashrc_my
		cp $cfg_path/.bashrc_my $bak_vim
	fi

	if [ -f "$cfg_path/.gitconfig" ]; then
		cp $cfg_path/.gitconfig $bak_vim
	fi

	echo "${FUNCNAME[0]}(): update $repo_name -- done"
}

# 更新vimrc
function update_vimrc()
{
	if [[ $HOME = "/root" ]]; then
		local cfg_path="/home/$username"
	else
		local cfg_path=$HOME
	fi

	echo "====== ${FUNCNAME[0]}(): Config your vim now ! ======"
	if [[ -f $cfg_path/.vim ]]; then
		rm $cfg_path/.vim
	fi

	if [[ ! -d $cfg_path/.vim ]]; then
		mkdir $cfg_path/.vim
	fi

	sudo chown $username:$groupname $cfg_path/.vimrc

	cp ./.vimrc $cfg_path
	cp ./README.md $cfg_path/.vim
	cp ./my_help/ $cfg_path/.vim -dpRf
	cp ./.vim/colors/ $cfg_path/.vim -dpRf
	cp ./.vim/sky8336 $cfg_path/.vim -dpRf
	cp ./.vim/tools $cfg_path/.vim -dpRf

	if [[ ! -f /usr/local/bin/auto_format ]]; then
		sudo cp ./utils/auto_format /usr/local/bin
	fi

	# add your name to the title
	sed -i "s/Eric MA/$your_name/" $cfg_path/.vim/sky8336/setTitle.vim
	sed -i "s/eric/$your_name/" $cfg_path/.vim/sky8336/setTitle.vim

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
		# which vim was built from source
		local_vim_path=/usr/local/vim/share/vim
		update_bashrc_my

		local vi_ver=$(get_built_vim_version)
		if [ "${vi_ver}" = "8.2" ]; then
			local vim_syntax_c="$local_vim_path/vim82/syntax/c.vim"
		elif [ "${vi_ver}" = "8.1" ]; then
			local vim_syntax_c="$local_vim_path/vim81/syntax/c.vim"
		fi

		grep "my_vim_highlight_config" ${vim_syntax_c}
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			sudo sh -c "cat $skyvim_path/.self_mod/highlight_code.vim >> ${vim_syntax_c}"
		fi
	else
		#函数名、运算符、括号等高亮
		share_vim_path=/usr/share/vim

		if [[ -d "$share_vim_path/vim82" ]]; then
			vim_in_usr_share="$share_vim_path/vim82"
		elif [[ -d "share_vim_path/vim81" ]]; then
			vim_in_usr_share="$share_vim_path/vim81"
		elif [[ -d "$share_vim_path/vim80" ]]; then
			vim_in_usr_share="$share_vim_path/vim80"
		elif [[ -d "$share_vim_path/vim74" ]]; then
			vim_in_usr_share="$share_vim_path/vim74"
		fi

		local vim_syntax_c="$vim_in_usr_share/syntax/c.vim"

		grep "my_vim_highlight_config" $vim_syntax_c
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			sudo sh -c "$skyvim_path/.self_mod/highlight_code.vim >> $vim_syntax_c"
		fi

	fi

	var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE" --color)
	#systemVersion='DISTRIB_RELEASE=18.04'
	sys_version=$(echo $var | cut -d'=' -f2)
	result=$(echo "$sys_version > 18" | bc)
	if [ $result -eq 1 ]; then
		echo "DISTRIB_RELEASE=$sys_version: using default .vimrc"
	elif [ $result -eq 0 ]; then
		echo "DISTRIB_RELEASE=$sys_version, not >= 18.04"
		sed -i "s/let ubuntu18_04 = 1/let ubuntu18_04 = 0/" ~/.vim/sky8336/plugin.vim
	fi

	echo "${FUNCNAME[0]}(): config your vim -- done"
}

update_utils()
{
	sudo cp ./utils/viman /usr/local/bin
	sudo cp ./utils/replace /usr/local/bin
}

update_package()
{
	# TODO
	echo "${FUNCNAME[0]}(): install some package using script in utils"
	sudo apt install silversearcher-ag ack --allow-unauthenticated 2>&1 > /dev/null

	if which pip3 > /dev/null ; then
		echo "python3-pip already installed."
	else
		yes | sudo apt --allow-unauthenticated install python3-pip
	fi
	pip3 install --user pynvim

	if which clang > /dev/null ; then
		echo "clang already installed."
	else
		yes | sudo apt --allow-unauthenticated install clang
	fi

	# for coc
	#sudo curl -sL install-node.now.sh/lts | bash
	#sudo curl -o- -L https://yarnpkg.com/install.sh | bash
}

#instal new plugin
function install_new_plugin()
{
	if [[ $HOME = "/root" ]]; then
		local cfg_path="/home/$username"
	else
		local cfg_path=$HOME
	fi

	if [[ ! -d $vim_plug_dir ]]; then
		mkdir $vim_plug_dir
	fi

	if which curl > /dev/null ; then
		echo "Find curl."
	else
		sudo apt-get install curl --allow-unauthenticated 2>&1 > /dev/null
	fi

	if [ ! -f "$cfg_path/.vim/autoload/plug.vim" ]; then
		echo "====== vim-plug was missing, install now ! ======"
		curl -fLo $vim_plug_dir/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		if [ $? -ne 0 ];then
			cp .vim/autoload/plug.vim ~/.vim/autoload/
		fi

		#sudo chown -R $username:$groupname $vim_plug_dir
	fi

	echo "====== ${FUNCNAME[0]}(): install new plugin now ! ======"
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
	#sudo  chown -R $username:$groupname ~/.vim

	if [[ -f ~/.vim_mru_files ]]; then
		sudo chown -R $username:$groupname ~/.vim_mru_files
	fi

	if [[ -f ~/.viminfo ]]; then
		sudo chown $username:$groupname ~/.viminfo
	fi

	echo "${FUNCNAME[0]}(): install new plugin -- done"
}

# git config
function git_config()
{
	echo "====== ${FUNCNAME[0]}(): git config ======"
	config_git
	echo "${FUNCNAME[0]}(): git config -- done"
}

#
update_vimcfg()
{
	global_variables_setup
	bakup_vimrc
	update_vimrc
	update_package
	update_utils
	install_new_plugin
	git_config
}

setup_ubuntu()
{
	# Ubuntu 18.04 实现"Alt+Tab" 和 "Alt+`"不跨工作区
	gsettings set org.gnome.shell.app-switcher current-workspace-only true
}

main()
{
	echo "------ enter ${FUNCNAME[0]}() ------"

	if [[ -z $1 ]]; then
		sudo echo
		blue_log ">> step1: ${FUNCNAME[0]}(): prepare and update $repo_name repo."
		global_variables_setup
		set_color
		# prepare
		check_root_privileges
		get_start_time
		assert_online

		# step1: update $repo_name
		update_skyVim
		echo "$repo_name repo update -- done"
		echo

		# now update.sh has been updated
		# execure step2 using new script
		./update.sh 1

		echo_install_time
	elif [[ $1 -eq 1 ]]; then
		echo
		blue_log ">> step2: ${FUNCNAME[0]}(): setup vim config now!"
		# step2: setup vim config
		update_vimcfg
		setup_ubuntu
		echo -e "vim config setup -- done.\n"
		show_logo
		echo -e "You better execure the following command:\n\t 'source ~/.bashrc'"
		echo "run ./utils/install_new_Language_Servers.sh to install language servers"
	else
		echo "invalid  parameter."
	fi
}

main "$@"
