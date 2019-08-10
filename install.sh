#!/bin/bash

source ./utils.sh

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
opt_num_max=6

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
"`basename $0` $skip_nothing	-	skip_nothing
		`basename $0` $skip_install_packages	-	skip_install_packages
		`basename $0` $skip_install_vim	-	skip_install_vim
		`basename $0` $skip_install_bundle_and_plugin	-	skip_install_bundle_and_plugin
		`basename $0` $skip_install_packages_and_vim	-	skip_install_packages_and_vim [opt$skip_install_packages + opt$skip_install_vim]
		`basename $0` $skip_insatall_packages_vim_bundle_plugin	-	skip_insatall_packages_vim_bundle_plugin [opt$skip_install_packages + opt$skip_install_vim + opt$skip_install_bundle_and_plugin]"
)

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
		echo "====== You have root privileges! ======"
	else
		echo -e "${color_failed}>>> Error: You don't have root privileges!"
		echo -e "Please run \"sudo ./install.sh\"${color_reset}"
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
	#标识网络连接状态
	online=1

	#超时时间
	timeout=9

	#目标网站
	target=www.baidu.com

	#获取响应状态码
	ret_code=`curl -I -s --connect-timeout $timeout $target -w %{http_code} | tail -n1`

	if [ "x$ret_code" = "x200" ]; then
		#网络畅通
		echo -e "====== The Internet is connected ! ======"
	else
		#网络不畅通,安装.vimcfg_offline中版本
		echo
		echo -e "${color_failed}>>> Warnning: Network connection is unavailable! "
		echo -e "Please check your Internet connection."
		echo -e "It will be installed offline，maybe not the latest !${color_reset}"
		online=0
	fi
}

#备份OS中vim的配置
function bakup_vimconfig()
{
	echo "====== Bakup your vimconfig file ! ======"

	if [ -d "${HOME}/.bakvim" ]; then
		rm   -rf $HOME/.bakvim
	fi
	mkdir $HOME/.bakvim

	if [ -d "${HOME}/.vim" ]; then
		cp $HOME/.vim  $HOME/.bakvim -a
	fi

	if [ -d "${HOME}/.vimrc" ]; then
		cp $HOME/.vimrc $HOME/.bakvim
	fi
	if [ -d "${HOME}/.bashrc" ]; then
		cp $HOME/.bashrc $HOME/.bakvim
	fi

	if [ -d "${HOME}/.bashrc_my" ]; then
		cp $HOME/.bashrc_my $HOME/.bakvim
	fi
}

#安装需要的软件包
function install_packages()
{
	echo "====== Install software packages now ! ======"
	echo -n ">> install: exuberant-ctags+cscope+ranger ... "
	apt-get install exuberant-ctags cscope ranger --allow-unauthenticated > /dev/null
	echo "done!"

	# install libc++ man page
	echo -n ">> libstdc++6-4.7-doc ... "
	sudo apt install libstdc++6-4.7-doc --allow-unauthenticated > /dev/null
	echo "done!"

	#echo ">> install: nautilus-open-terminal" #installed by default
	#sudo apt-get install nautilus-open-terminal --allow-unauthenticated > /dev/null

	echo -n ">> install: astyle clang-format python-pep8 python3-pep8 python-autopep8 yapf
ranger ... "
	#vim-autoformat常用工具:
	#分别是astyle（支持C, C++, C++/CLI, Objective‑C, C#和Java）;
	#clang-format（支持C, C++,和Objective-C ）;
	#python-pep8,python3-pep8,python-autopep8和yapf（Google开发的Python格式化工具）
	sudo apt install astyle clang-format python-pep8 python3-pep8 python-autopep8 yapf  --allow-unauthenticated
}

#build vim
function build_vim_from_source()
{
	if which apt-get > /dev/null ; then
		echo -n ">> install ctags build-essential cmake python-dev python3-dev fontconfig git ... "
		sudo apt-get install -y ctags build-essential cmake python-dev \
			python3-dev fontconfig git > /dev/null
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
				python3-dev ruby-dev lua5.1 lua5.1-dev > /dev/null
			echo "done!"

			sudo apt-get remove -y vim vim-runtime gvim > /dev/null
			sudo apt-get remove -y vim-tiny vim-common vim-gui-common vim-nox > /dev/null

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
			if [ ! -d "${HOME}/vim" ]; then
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

			./configure --with-features=huge \
				--enable-multibyte \
				--enable-rubyinterp \
				--enable-pythoninterp \
				--with-python-config-dir=/usr/lib/python2.7/config \
				--enable-perlinterp \
				--enable-luainterp \
				--enable-gui=gtk2 --enable-cscope --prefix=/usr > /dev/null
			echo -n ">> vim: make ... "
			make VIMRUNTIMEDIR=/usr/share/vim/vim81 > /dev/null
			echo "done!"
			echo -n ">> vim: make install ... "
			sudo make install > /dev/null
			echo "done!"
			cd -
		else
			echo ">> instll vim using apt ... "
			sudo apt-get install -y vim > /dev/null
			echo "done!"
		fi
	elif which yum > /dev/null
	then
		sudo yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake \
		python-devel python3-devel git > /dev/null
	fi

}


function install_vim()
{
	echo "====== install vim now! ======"
	echo "force enter build_vim_from_source?: $1"
	vim --version | grep "Vi IMproved 8.1" --color
	if [ $? -eq 0 ] && [ $1 -eq 0 ]; then
		echo "Vi IMproved 8.1 has been installed!"
	else
		echo "enter build_vim_from_source"
		build_vim_from_source
	fi

	echo -n ">> install: vim-gnome+xsel ... "
	apt-get install vim-gnome xsel --allow-unauthenticated > /dev/null
	echo "done!"
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
			cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> $1 > /dev/null
		fi
	else
		echo "can not found $1"
	fi
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

		cp ~/.gitconfig ~/.gitconfig.bak
		sed -i "s%^.*editor.*$%\teditor = /usr/local/vim/bin/vim%g" ~/.gitconfig
	fi
	source ~/.bashrc
}

#配置vim
function config_vim()
{
	echo "====== Config your vim now ! ======"
	rm -rf $HOME/.vim/README.mk  $HOME/.vim/colors/ $HOME/.vim/macros/ \
		$HOME/.vim/my_help/ $HOME/.vim/shell/ > /dev/null

	grep -n --color "Maintainer: sky8336" ~/.vimrc
	if [ $? -ne 0 ];then
		echo "remove .vim/ completely"
		rm $HOME/.vim/ -rf
	fi

	if [ $online -eq 1 ];then
		cp ./.vim  $HOME -a
		cp ./.vimrc $HOME

		cp ./README.md $HOME/.vim

	else
		cp ./.vimcfg_offline/.vim  $HOME -a
		cp ./.vimcfg_offline/.vimrc $HOME

	fi
		cp ./my_help/ $HOME/.vim/ -a

	#追加到.bashrc,不会覆盖.bashrc原有配置
	#cat $vimcfig_bundle_dir_path/.self_mod/.bashrc_append >> ~/.bashrc
	cp $vimcfig_bundle_dir_path/.self_mod/.bashrc_append ~/.bashrc_my
	echo "source ~/.bashrc_my" >> ~/.bashrc

	#生成tags文件
	echo "Make tags in /usr/include"
	cd /usr/include
	pwd
	sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q > /dev/null

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
	fi

	vim81_c_vim="/usr/share/vim/vim81/syntax/c.vim"
	vim80_c_vim="/usr/share/vim/vim80/syntax/c.vim"
	vim74_c_vim="/usr/share/vim/vim74/syntax/c.vim"
	vim73_c_vim="/usr/share/vim/vim73/syntax/c.vim"
	vim81_c_vim_usr_local="/usr/local/vim/share/vim/vim81/syntax/c.vim"

	if [ -f "$vim81_c_vim_usr_local" ]; then
		add_hilight_code_to_c_vim $vim81_c_vim_usr_local
	elif [ -f "$vim81_c_vim" ]; then
		add_hilight_code_to_c_vim $vim81_c_vim
	elif [ -f "$vim80_c_vim" ]; then
		add_hilight_code_to_c_vim $vim80_c_vim
	elif [ -f "$vim74_c_vim" ]; then
		add_hilight_code_to_c_vim $vim74_c_vim
	elif [ -f "$vim73_c_vim" ]; then
		add_hilight_code_to_c_vim $vim73_c_vim
	fi
}

#install vundle
function install_vundle_and_plugin()
{
	if [ $online -eq 1 ];then
		echo "====== Install vundle now ! ======"
		if [ ! -d "${HOME}/.vim/vundle" ]; then
			git clone https://github.com/gmarik/vundle.git  ~/.vim/vundle > /dev/null
		fi

		if [[ $vim_in_usr_local -eq 1 ]]; then
			/usr/local/vim/bin/vim +BundleInstall +qall
		else
			vim +BundleInstall +qall
		fi
		cp $vimcfig_bundle_dir_path/.self_mod/.plugin_self-mod/* ~/.vim/bundle/ -rf
	else
		echo
	fi
}

#chown ~/.vim/bundle
function chown_vundle()
{
	if [ $online -eq 1 ];then
		#切换到install.sh所在目录，获取非sudo模式下的username and groupname
		echo "====== ~/.vim/bundle/ change owner: ======"
		cd $vimcfig_bundle_dir_path
		pwd
		username=`ls -l install.sh | cut -d ' ' -f3`
		groupname=`ls -l  install.sh | cut -d ' ' -f4`
		echo "username=$username"
		echo "groupname=$groupname"
		chown -R $username:$groupname ~/.vim/bundle/
		chown -R $username:$groupname ~/.vim/vundle/
	else
		echo
	fi
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

# !!note:y ou can modify force_build_vim to build vim from source
force_build_vim=0

main()
{
	set_color
	check_root_privileges
	get_start_time_and_dir_path

	local skip_pack=0
	local skip_vim=0
	local skip_vundle_plugin=0

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
		skip_vundle_plugin=1
	elif [ "$1" = $skip_install_packages_and_vim ]; then
		blue_log "skip_install_packages_and_vim"
		skip_pack=1
		skip_vim=1
	elif [ "$1" = $skip_insatall_packages_vim_bundle_plugin ]; then
		blue_log "skip_insatall_packages_vim_bundle_plugin"
		skip_pack=1
		skip_vim=1
		skip_vundle_plugin=1
	else
		echo "do nothing"
		exit
	fi


	check_network
	bakup_vimconfig

	if [[ $skip_pack -ne 1 ]]; then
		install_packages
	fi

	if [[ $skip_vim -ne 1 ]]; then
		install_vim ${force_build_vim}
	fi

	config_vim

	if [[ $skip_vundle_plugin -ne 1 ]]; then
		install_vundle_and_plugin
		chown_vundle
	fi
	#install_ycm
	#set_cfg_for_winmanager
	git_config

	echo_install_time
}

main "$@"
