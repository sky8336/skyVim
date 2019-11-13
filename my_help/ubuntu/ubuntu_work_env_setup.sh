#!/bin/bash
#
# ubuntu_work_env_setup.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.
#
# History:
#    2019/11/13 - [Eric MA] Created file
#
# Maintainer: Eric MA <eric@email.com>
#    Created: 2019-11-13
# LastChange: 2019-11-13
#    Version: v0.0.01
#


packages=(
	ranger
	libstdc++6-4.7-doc
	#nautilus-open-terminal
	flameshot # screenshot, usage: flameshot gui &
)

# libstdc++6-4.7-doc: libc++ man page

#安装需要的软件包
function install_packages()
{
	pkg_num=${#packages[@]}

	local let i=0

	echo "====== Install software packages(pkg_num=$pkg_num) now ! ======"

	while [[ $i -lt $pkg_num ]]; do
		sudo apt-get install ${packages[i]} --allow-unauthenticated 2>&1 > /dev/null
		echo "Install packages[$i]: ${packages[i]} ... done"
		let i++
	done

}

main()
{
	install_packages
}

main "$@"
