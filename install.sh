#!/bin/bash 

#备份OS中vim的配置   
function bakup_vimconfig()
{
	echo "====== Bakup your vimconfig file ! ======"
	rm   -rf $HOME/.bakvim
	mkdir $HOME/.bakvim
	cp 	  $HOME/.vim  $HOME/.bakvim -a 
	cp 	  $HOME/.vimrc $HOME/.bakvim 
	cp 	  $HOME/.bashrc $HOME/.bakvim 
}

#配置vim
function config_vim()
{
	echo "====== Config your vim now ! ======"
	rm -rf $HOME/.vim 
	cp ./.vim  $HOME -a 
	cp ./.vimrc $HOME 
	cp ./.bashrc $HOME
	cp ./README.md $HOME/.vim

	#生成tags文件
	sudo cp ctags /bin 
	echo "Make tags in /usr/include"
	cd /usr/include
	pwd
	sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p --fields=+iaS --extra=+q
}

#install vundle
function install_vundle_and_plugin()
{
	echo "====== Install vundle now ! ======"
	git clone https://github.com/gmarik/vundle.git  ~/.vim/bundle/vundle
	vim +BundleInstall +qall
	cp $vimcfig_bundle_dir_path/.vim/bundle_self-define/* ~/.vim/bundle/ -rf
}

#chown ~/.vim/bundle
function chown_vundle()
{
	#切换到install.sh所在目录，获取非sudo模式下的username and groupname
	echo "====== ~/.vim/bundle/ change owner: ======"
	cd $vimcfig_bundle_dir_path 
	pwd
	username=`ls -l install.sh | cut -d ' ' -f3`
	groupname=`ls -l  install.sh | cut -d ' ' -f4`
	echo "username=$username"
	echo "groupname=$groupname"
	chown -R $username:$groupname ~/.vim/bundle/
}

function echo_install_time()
{
    end_time=$(date +"%s")
    tdiff=$(($end_time-$start_time))
    hours=$(($tdiff / 3600 ))
    mins=$((($tdiff % 3600) / 60))
    secs=$(($tdiff % 60))
    echo
        echo -n -e "#### install completed successfully! "
    if [ $hours -gt 0 ] ; then
        echo -n -e "($hours:$mins:$secs (hh:mm:ss))"
    elif [ $mins -gt 0 ] ; then
        echo -n -e "($mins:$secs (mm:ss))"
    elif [ $secs -gt 0 ] ; then
        echo -n -e "($secs seconds)"
    fi
    echo -e " ####"
    echo
}

start_time=$(date +"%s")
vimcfig_bundle_dir_path=$(pwd)
echo $vimcfig_bundle_dir_path
echo "====== Install vim+ctags+cscope now ! ======"
apt-get install vim ctags cscope -y --force-yes
bakup_vimconfig
config_vim
install_vundle_and_plugin
chown_vundle
# To use vimdiff as default merge tool:
git config --global merge.tool vimdiff
git config --global mergetool.prompt false
echo_install_time
