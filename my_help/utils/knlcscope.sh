#!/bin/bash
#
# cscope.sh
#
# Copyright (C) 2018-2023 Eric MA  <eric@company.com>
#
# History:
#    2019/07/04 - [Eric MA] Created file
#


# if dir is a softlink, / is needed
find `pwd`/ -name "*.[ch]" -o -name "*.cpp" > cscope.files;

arch_list=(x86 alpha arc arm avr32 blackfin c6x cris frv h8300 hexagon ia64 m32r m68k metag microblaze mips mn10300 nios2 openrisc parisc powerpc s390 score sh sparc tile um unicore32 xtensa);
if [[ ! -z $1 && $1 = "x86" ]]; then
	echo "arch is x86"
	arch_list[0]="arm64"
else
	echo "arch is arm64 [default]"
	arch_list[0]="x86"
fi

for arch_item in ${arch_list[@]}
do
	echo "delete arch/${arch_item}"
	sed -i "/arch\/${arch_item}\//d" cscope.files
done


cscope -bR -i cscope.files
#cscope -bkR -i cscope.files

