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

# update vim to vim7.4
function update_to_vim74()
{
	echo "====== Update vim to vim7.4 ! ======"
	sudo add-apt-repository ppa:fcwu-tw/ppa
	sudo apt-get update
	sudo apt-get install vim -y --force-yes
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
        echo -n -e "${color_success}#### update vim to vim7.4 successfully! "
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
update_to_vim74
echo_install_time
