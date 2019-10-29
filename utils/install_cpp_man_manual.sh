#!/bin/bash
#
# install_cpp_man_manual.sh
#
# Copyright (C) 2018-2023 eric  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/10/29 - [eric] Created file
#
# Maintainer: eric <eric@email.com>
#    Created: 2019-10-29
# LastChange: 2019-10-29
#    Version: v0.0.01
#

libstdcpp_version=libstdc++-api.20140403.man
cpp_man_pkg=${libstdcpp_version}.tar.bz2
cpp_man_link=ftp://gcc.gnu.org/pub/gcc/libstdc++/doxygen/${cpp_man_pkg}

download_path=~/Downloads
dest_path=/usr/share/man

if [[ ! -d  ${download_path} ]]; then
	mkdir ${download_path}
fi

# download man manual
wget -P ${download_path} ${cpp_man_link}

cd ${download_path}
#.tar.bz2   格式解压
tar -jxvf ${cpp_man_pkg} -C ${download_path}

sudo cp -dpRf ${download_path}/${libstdcpp_version}/man3 ${dest_path}

