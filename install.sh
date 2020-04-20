#!/bin/bash
#
# install.sh
#
# Copyright (C) 2016-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2016/02/22 - [Eric MA] Created file
#
# Maintainer: you <your@email.com>
#    Created: 2016-02-22
# LastChange: 2020-04-20
#    Version: v0.0.76
#

source ./common.sh

# show_header specify content
VERSION=1.00
tool_name="vim setup tool"

# global
skip_nothing="0"
skip_install_packages="1"
skip_install_vim="2"
skip_install_bundle_and_plugin="3"
skip_install_packages_and_vim="4"
skip_insatall_packages_vim_bundle_plugin="5"
opt_num_max=$skip_insatall_packages_vim_bundle_plugin

# show_usage Specify content
usage=(
"`basename $0` [options]"
)

options=(
"[0, 1, 2, ..., $opt_num_max]		Specify which step you'd like to skip"
)

ret_codes=(
"0 (not xx), 2 (xx), 3 (unknown), 255 (error)"
)

examples=(
"`basename $0` $skip_nothing - skip_nothing
		`basename $0` $skip_install_packages - skip_install_packages
		`basename $0` $skip_install_vim - skip_install_vim
		`basename $0` $skip_install_bundle_and_plugin - skip_install_bundle_and_plugin
		`basename $0` $skip_install_packages_and_vim - skip_install_packages_and_vim [opt$skip_install_packages + opt$skip_install_vim]
		`basename $0` $skip_insatall_packages_vim_bundle_plugin - skip_insatall_packages_vim_bundle_plugin [opt$skip_install_packages + opt$skip_install_vim + opt$skip_install_bundle_and_plugin]"
)

#####
vim_plug_dir=~/.vim/autoload
# we use vim-plug as plugin manager by default

#备份OS中vim的配置
function bakup_vimconfig()
{
	local prog=$cur_prog
	local cfg_path=$HOME

	if [ -d "${cfg_path}/.bakvim" ]; then
		rm   -rf $cfg_path/.bakvim
	fi
	mkdir $cfg_path/.bakvim

	if [ -d "${cfg_path}/.vim" ]; then
		cp $cfg_path/.vim  $cfg_path/.bakvim -a
	fi

	if [ -f "${cfg_path}/.vimrc" ]; then
		cp $cfg_path/.vimrc $cfg_path/.bakvim
	fi
	if [ -f "${cfg_path}/.bashrc" ]; then
		cp $cfg_path/.bashrc $cfg_path/.bakvim
	fi

	if [ -f "${cfg_path}/.bashrc_my" ]; then
		cp $cfg_path/.bashrc_my $cfg_path/.bakvim
	fi

	if [ -f "$cfg_path/.gitconfig" ]; then
		cp $cfg_path/.gitconfig $cfg_path/.bakvim
	fi

	let prog+=1
	progress_log $prog "Bakup your vimconfig file ! done ..."
	cur_prog=$prog
}

packages=(
	vim
	curl
	exuberant-ctags
	cscope
	astyle
	clang-format
	python-pep8
	python3-pep8
	python-autopep8
	yapf
	xsel  #copy and paste
	silversearcher-ag #for ctrlsf.vim
	ack #for ctrlsf.vim
)
# note
# Google开发的Python格式化工具）
# astyle clang-format python-pep8 python3-pep8 python-autopep8 yapf  --allow-unauthenticated
# vim-autoformat常用工具:
# 分别是astyle（支持C, C++, C++/CLI, Objective‑C, C#和Java）;
# clang-format（支持C, C++,和Objective-C ）;

#安装需要的软件包
function install_packages()
{
	if [[ $online -ne 1 ]]; then
		return 0
	fi
	pkg_num=${#packages[@]}

	local prog=$cur_prog
	local step=5
	local let i=0

	progress_log $prog "====== Install software packages(pkg_num=$pkg_num) now ! ======"

	while [[ $i -lt $pkg_num ]]; do
		if which ${packages[i]} > /dev/null ; then
			local log_str="${packages[i]} already installed."
		else
			sudo apt-get install ${packages[i]} --allow-unauthenticated
			local log_str="Install packages[$i]: ${packages[i]} ... done"
		fi
		let prog+=5
		progress_log $prog "$log_str"
		let i++
	done

	cur_prog=$prog
}

#build vim
function build_vim_from_source()
{
	local cfg_path=$HOME
	if which apt-get > /dev/null ; then
		echo -n ">> install ctags build-essential cmake python-dev python3-dev fontconfig git ... "
		sudo apt-get install -y ctags build-essential cmake python-dev \
			python3-dev fontconfig git 2>&1 > /dev/null
		echo "done!"

		var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE" --color)
		#systemVersion='DISTRIB_RELEASE=16.04'
		systemVersion='DISTRIB_RELEASE=18.04'
		if [ $var == $systemVersion ]; then
			sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE" --color
			echo -n ">> install libncurses5-dev libgnome2-dev libgnomeui-dev "\
				"libgtk2.0-dev libatk1.0-dev libbonoboui2-dev " \
				"libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev "\
				"python3-dev ruby-dev lua5.1 lua5.1-dev ... "
			sudo apt-get install -y libncurses5-dev libgnome2-dev libgnomeui-dev \
				libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
				libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
				python3-dev ruby-dev lua5.1 lua5.1-dev 2>&1 > /dev/null
			echo "done!"

			sudo apt-get remove -y vim vim-runtime gvim 2>&1 > /dev/null
			sudo apt-get remove -y vim-tiny vim-common vim-gui-common vim-nox 2>&1 > /dev/null

			if [ -d "/usr/share/vim/vim74" ]; then
				sudo rm -rf /usr/share/vim/vim74 > /dev/null
			fi

			if [ -d "/usr/share/vim/vim80" ]; then
				sudo rm -rf /usr/share/vim/vim80 > /dev/null
			fi
			if [ -d "/usr/share/vim/vim81" ]; then
				sudo rm -rf /usr/share/vim/vim81 > /dev/null
			fi

			# check if a directory doesn't exist:
			if [ ! -d "${cfg_path}/vim" ]; then
				echo -n ">> clone vim ... "
				git clone https://github.com/vim/vim.git ~/vim > /dev/null
				echo "done! [path: ~/vim]"
			fi

			cd ~/vim
			git remote -v | grep "https://github.com/vim/vim.git" --color

			if [ $? -eq 0 ]; then
				echo "vim source code has been cloned in ${HOME}/vim!"
				git pull > /dev/null
			else
				cd -
				echo -n ">> clone vim ..."
				git clone https://github.com/vim/vim.git /tmp/vim
				echo "done! [path: /tmp/vim]"
				cd /tmp/vim/
			fi

		# vim8.1/vim8.2 config
		./configure --with-features=huge --enable-multibyte --enable-rubyinterp \
			--enable-pythoninterp --enable-python3interp --enable-luainterp \
			--enable-cscope --enable-gui=gtk3 --enable-perlinterp \
			--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ \
			--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ \
			--prefix=/usr/local/vim

			local major=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $1}'| sed 's/^[ \t]*//g')
			local minor=$(git log --graph --decorate --pretty=oneline --abbrev-commit --all | grep "origin/master" | awk -F 'patch' '{print $2}' | awk -F ':' '{print $1}' | awk -F '.' '{print $2}')

			echo -n ">> vim: make ... "
			make VIMRUNTIMEDIR=/usr/share/vim/vim${major}${minor} > /dev/null
			echo "done!"
			echo -n ">> vim: make install ... "
			sudo make install > /dev/null
			echo "done!"
			cd -
		else
			echo ">> instll vim using apt ... "
			sudo apt-get install -y vim 2>&1 > /dev/null
			echo "done!"
		fi
	elif which yum > /dev/null ; then
		sudo yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake \
		python-devel python3-devel git > /dev/null
	fi

}


function install_vim()
{
	local prog=$cur_prog
	local step=5

	progress_log $prog "====== install vim now! ======"
	echo "force enter build_vim_from_source?: $1"
	local vim_ver_str="Vi IMproved 8.2"
	vim --version | grep "$vim_ver_str" --color
	if [ $? -eq 0 ] && [ $1 -eq 0 ]; then
		echo "$vim_ver_str has been installed!"
	else
		local vim_bin_local_path="/usr/local/vim/bin"
		if [ -f "$vim_bin_local_path/vim" ];then
			$vim_bin_local_path/vim --version | grep "$vim_ver_str" --color
			if [ $? -eq 0 ] && [ $1 -eq 0 ]; then
				echo "$vim_ver_str has been installed in /usr/local/vim/!"
			else
				echo "enter build_vim_from_source"
				build_vim_from_source
			fi
		else
			echo "enter build_vim_from_source"
			build_vim_from_source
		fi
	fi

	let prog+=10
	progress_log $prog  "install vim ... done"

	if [[ $online -eq 1 ]]; then
		sudo apt-get install vim-gnome --allow-unauthenticated 2>&1 > /dev/null
	fi
	let prog+=5
	progress_log $prog "install vim-gnome ... done"

	cur_prog=$prog
}

#函数名、运算符、括号等高亮
function add_hilight_code_to_c_vim()
{
	if [ -f $1 ]; then
		grep "my_vim_highlight_config" $1
		if [ $? -eq 0 ]; then
			echo "Found my_vim_highlight_config! $1 have been modified."
		else
			echo "add my_vim_highlight_config to $1 now."
			sudo cat $skyvim_path/.self_mod/highlight_code.vim >> $1 > /dev/null
		fi
	else
		echo "can not found $1"
	fi
}

#配置vim
function config_vim()
{
	local prog=$cur_prog
	local step=5
	local cfg_path=$HOME

	progress_log $prog "====== Config your vim now ! ======"
	# clean the old .vimrc and .vim/
	if [[ -f $cfg_path/.vim ]]; then
		rm $cfg_path/.vim
	fi

	if [[ ! -d $cfg_path/.vim ]]; then
		mkdir $cfg_path/.vim
	else
		grep -n --color "Maintainer: sky8336" ~/.vimrc
		if [ $? -ne 0 ];then
			echo "remove .vim/ completely"
			rm $cfg_path/.vim/ -rf
		else
			rm -rf $cfg_path/.vim/README.mk  $cfg_path/.vim/colors/ $cfg_path/.vim/macros/ \
				$cfg_path/.vim/my_help/ $cfg_path/.vim/shell/ > /dev/null
		fi
	fi

	# setup new vim config
	cp ./.vimrc $cfg_path

	# add your name to the title
	sed -i "s/Eric MA/$your_name/" $cfg_path/.vim/sky8336/setTitle.vim
	sed -i "s/eric/$your_name/" $cfg_path/.vim/sky8336/setTitle.vim

	if [ $online -eq 1 ];then
		cp ./.vim  $cfg_path -dpRf
	else
		cp ./.vimcfg_offline/.vim  $cfg_path -dpRf
		cp ./.vim/sky8336 $cfg_path/.vim/ -dpRF
		sed -i "s%Install: online$%Install: offline%g" ~/.vimrc
	fi

	if [[ -d $cfg_path/.vim ]]; then
		cp ./README.md $cfg_path/.vim
		cp ./my_help/ $cfg_path/.vim/ -dpRf
	else
		warning_log "where is you $cfg_path/.vim?? check it"
	fi


	#追加到.bashrc,不会覆盖.bashrc原有配置
	#cat $skyvim_path/.self_mod/.bashrc_append >> ~/.bashrc
	cp $skyvim_path/.self_mod/.bashrc_append ~/.bashrc_my

	grep "source ~/.bashrc_my" ~/.bashrc
	if [ $? -eq 0 ]; then
		# "Found! ~/.bashrc have been modified."
		echo
	else
		echo "source ~/.bashrc_my" >> ~/.bashrc
	fi

	#生成tags文件
	let prog+=$step
	progress_log $prog "Make tags in /usr/include"
	cd /usr/include
	pwd
	sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+ianS --extra=+q > /dev/null

	if [[ -d "/usr/local/vim" ]]; then
		# which we built from source
		update_bashrc_my

		local vim_syntax_c=/usr/local/vim/share/vim/vim82/syntax/c.vim
		grep "my_vim_highlight_config" ${vim_syntax_c}
		if [ $? -eq 0 ]; then
			echo "Found! c.vim have been modified."
		else
			echo "Not found! Modify c.vim now."
			sudo cat $skyvim_path/.self_mod/highlight_code.vim >> ${vim_syntax_c}
		fi
	fi

	vim81_c_vim="/usr/share/vim/vim81/syntax/c.vim"
	vim81_c_vim_usr_local="/usr/local/vim/share/vim/vim81/syntax/c.vim"
	vim82_c_vim_usr_local="/usr/local/vim/share/vim/vim82/syntax/c.vim"

	if [ -f "$vim82_c_vim_usr_local" ]; then
		add_hilight_code_to_c_vim $vim82_c_vim_usr_local
	elif [ -f "$vim81_c_vim_usr_local" ]; then
		add_hilight_code_to_c_vim $vim81_c_vim_usr_local
	elif [ -f "$vim81_c_vim" ]; then
		add_hilight_code_to_c_vim $vim81_c_vim
	fi
	let prog+=$step
	progress_log $prog "${FUNCNAME[0]} ... done"
	cur_prog=$prog
}

#install plguin_mgr: plugin_mgr or vim-plug
function install_plugin_mgr_and_plugin()
{
	local prog=$cur_prog
	local step=5
	local username=$(echo $HOME | awk -F '/' '{print $3}')
	local groupname=${username}

	if [ $online -eq 1 ];then
		if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
			echo "====== Install vim-plug now ! ======"
			if which curl > /dev/null ; then
				echo "Find curl."
			else
				sudo apt-get install curl --allow-unauthenticated 2>&1 > /dev/null
			fi
			curl -fLo $vim_plug_dir/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

			if [ $? -ne 0 ];then
				cp .vimcfg_offline/.vim/autoload/plug.vim ~/.vim/autoload/
			fi
		fi

		if [[ $vim_in_usr_local -eq 1 ]]; then
			# vim-plug
			/usr/local/vim/bin/vim +PlugInstall +qall
		else
			# vim-plug
			vim +PlugInstall +qall
		fi

		# Fixme: self mod maybe not used but copy to the directory
		cp $skyvim_path/.self_mod/.plugin_self-mod/plugged/* ~/.vim/plugged/ -rf
	else
		echo
	fi

	# fix the issues caused by 'sudo' privilege
	if [[ -f ~/.vim_mru_files ]]; then
		chown -R $username:$groupname ~/.vim_mru_files
	fi

	let prog+=$step
	progress_log $prog "${FUNCNAME[0]} ... done"
	cur_prog=$prog
}

#chown ~/.vim/bundle
function chown_plugin_mgr()
{
	local prog=$cur_prog
	local step=1
	if [ $online -eq 1 ];then
		#切换到install.sh所在目录，获取非sudo模式下的username and groupname
		echo "====== ~/.vim/bundle/ change owner: ======"
		cd $skyvim_path
		pwd
		username=`ls -l install.sh | awk '{print $3}'`
		groupname=`ls -l  install.sh | awk '{print $4}'`
		echo "username=$username"
		echo "groupname=$groupname"

		chown -R $username:$groupname ~/.vim
	else
		echo
	fi

	let prog+=$step
	progress_log $prog "${FUNCNAME[0]} ... done"
	cur_prog=$prog
}

#install ycm
function install_ycm()
{
	cp .ycm_extra_conf.py ~

	cd ~/.vim/bundle/YouCompleteMe
	sudo ./install.py --clang-completer > /dev/null
}

# git config
function git_config()
{
	local prog=$cur_prog
	local step=1

	progress_log $prog "====== git config ======"
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

	let prog+=$step
	progress_log $prog "${FUNCNAME[0]} ... done"
	cur_prog=$prog
}

#winmagager添加自动打开和退出功能
function set_cfg_for_winmanager()
{
	echo "====== Set auto open and close WinManager ======"
	echo "if g:AutoOpenWinManager
	\"vim进入时自动执行 ToggleWindowsManager ，然后移动一次窗口焦点
	autocmd VimEnter * nested call s:ToggleWindowsManager()
	\"|2wincmd w
	endif" >> ~/.vim/bundle/winmanager/plugin/winmanager.vim
	patch ~/.vim/bundle/taglist.vim/plugin/taglist.vim < ./.self_mod/.plugin_patch/taglist_vim.patch
}

# !!note:y ou can modify force_build_vim to build vim from source
force_build_vim=0

main()
{
	sudo echo
	set_color
	check_root_privileges
	get_start_time_and_dir_path

	local skip_pack=0
	local skip_vim=0
	local skip_plugin_mgr_plugin=0

	cur_prog=0
	your_name=$(echo $HOME | awk -F '/' '{print $3}')

	show_logo

	if [ -z "$1" ]; then
		show_header
		show_usage
		warning_log "`basename $0` [opt]: opt should be 0, 1, ..., $opt_num_max"
		exit
	elif [ "$1" = $skip_nothing ]; then
		blue_log "skip_nothing"
	elif [ "$1" = $skip_install_packages ]; then
		blue_log "skip_install_packages"
		skip_pack=1
	elif [ "$1" = $skip_install_vim ]; then
		blue_log "skip_install_vim"
		skip_vim=1
	elif [ "$1" = $skip_install_bundle_and_plugin ]; then
		blue_log "skip_install_bundle_and_plugin"
		skip_plugin_mgr_plugin=1
	elif [ "$1" = $skip_install_packages_and_vim ]; then
		blue_log "skip_install_packages_and_vim"
		skip_pack=1
		skip_vim=1
	elif [ "$1" = $skip_insatall_packages_vim_bundle_plugin ]; then
		blue_log "skip_insatall_packages_vim_bundle_plugin"
		skip_pack=1
		skip_vim=1
		skip_plugin_mgr_plugin=1
	else
		echo "do nothing"
		exit
	fi


	online_offline_select
	bakup_vimconfig

	if [[ $skip_pack -ne 1 ]]; then
		install_packages
	fi

	if [[ $skip_vim -ne 1 ]]; then
		install_vim ${force_build_vim}
	fi

	config_vim

	if [[ $skip_plugin_mgr_plugin -ne 1 ]]; then
		install_plugin_mgr_and_plugin
		chown_plugin_mgr
	fi
	#install_ycm
	#set_cfg_for_winmanager
	git_config
	progress_log 100 "install ... done"

	show_logo
	echo_install_time
}

main "$@"
