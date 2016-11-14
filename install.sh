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
		echo -e "Please input \"sudo ./install.sh\"${color_reset}"
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
	timeout=5

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
	rm   -rf $HOME/.bakvim
	mkdir $HOME/.bakvim
	cp $HOME/.vim  $HOME/.bakvim -a
	cp $HOME/.vimrc $HOME/.bakvim
	cp $HOME/.bashrc $HOME/.bakvim
}

#安装需要的软件包
function install_packages()
{
	echo "====== Install software packages now ! ======"
	echo ">> install: vim+exuberant-ctags+cscope+ranger"
	apt-get install vim exuberant-ctags cscope ranger -y --force-yes

	echo ">> install: vim-gnome+xsel"
	apt-get install vim-gnome xsel -y --force-yes
	echo ">> install: nautilus-open-terminal"
	sudo apt-get install nautilus-open-terminal -y --force-yes
}

#build vim
function build_vim_by_source()
{

	if which apt-get > /dev/null
	then
		sudo apt-get install -y ctags build-essential cmake python-dev python3-dev fontconfig git
		var=$(sudo cat /etc/lsb-release | grep "DISTRIB_RELEASE")
		systemVersion='DISTRIB_RELEASE=16.04'
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
		else
			sudo apt-get install -y vim
		fi
	elif which yum > /dev/null
	then
		sudo yum install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel git
	fi

}

#配置vim
function config_vim()
{
	echo "====== Config your vim now ! ======"
	rm -rf $HOME/.vim/README.mk  $HOME/.vim/colors/ $HOME/.vim/macros/ $HOME/.vim/my_help/ $HOME/.vim/shell/

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
	sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q

	#函数名、运算符、括号等高亮
	grep "my_vim_highlight_config" /usr/share/vim/vim80/syntax/c.vim
	if [ $? -eq 0 ]; then
		echo "Found my_vim_highlight_config! c.vim have been modified."
	else
		echo "Not found my_vim_highlight_config! Modify c.vim now."
		cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim80/syntax/c.vim
	fi

	grep "my_vim_highlight_config" /usr/share/vim/vim74/syntax/c.vim
	if [ $? -eq 0 ]; then
		echo "Found my_vim_highlight_config! c.vim have been modified."
	else
		echo "Not found my_vim_highlight_config! Modify c.vim now."
		cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim74/syntax/c.vim
	fi

	grep "my_vim_highlight_config" /usr/share/vim/vim73/syntax/c.vim
	if [ $? -eq 0 ]; then
		echo "Found my_vim_highlight_config! c.vim have been modified."
	else
		echo "Not found my_vim_highlight_config! Modify c.vim now."
		cat $vimcfig_bundle_dir_path/.self_mod/highlight_code.vim >> /usr/share/vim/vim73/syntax/c.vim
	fi
}

#install vundle
function install_vundle_and_plugin()
{
	if [ $online -eq 1 ];then
		echo "====== Install vundle now ! ======"
		git clone https://github.com/gmarik/vundle.git  ~/.vim/bundle/vundle
		vim +BundleInstall +qall
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
	else
		echo
	fi
}

#install ycm
function install_ycm()
{
	cp .ycm_extra_conf.py ~

	cd ~/.vim/bundle/YouCompleteMe
	sudo ./install.py --clang-completer
}

# git config
function git_config()
{
	echo "====== git config ======"
	# set merge tool and editor
	# To use vimdiff as default merge tool:
	git config --global merge.tool vimdiff
	git config --global mergetool.prompt false
	git config --global core.editor /usr/bin/vim
	git config --global push.default simple

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

set_color
check_root_privileges
get_start_time_and_dir_path
check_network
bakup_vimconfig
install_packages
#build_vim_by_source
config_vim
install_vundle_and_plugin
chown_vundle
#install_ycm
#set_cfg_for_winmanager
git_config
echo_install_time
