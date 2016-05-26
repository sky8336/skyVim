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
bakup_vimrc
update_vimrc
install_new_plugin
echo_install_time
