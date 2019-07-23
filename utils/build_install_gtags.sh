#!/bin/bash
#
# build_install_gtags.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>
#
# History:
#    2019/07/23 - [Eric MA] Created file
#

gtags_ver=global-6.6
gtags_pkg=$gtags_ver.tar.gz

install_dependency_packages()
{
	# install dependency
	sudo apt build-dep global
	sudo apt install libncurses5-dev libncursesw5-dev
}

get_source_pkg()
{
	#sudo apt-get install global

	get source
	wget https://ftp.gnu.org/pub/gnu/global/$gtags_pkg
	tar -zxvf $gtags_pkg
}

build_install_gtags()
{
	cd $gtags_ver
	./configure
	make
	sudo make install
}


gtags_main()
{
	#install_dependency_packages
	#get_source_pkg
	build_install_gtags
}

gtags_main "$@"
