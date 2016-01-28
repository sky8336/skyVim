# vimconfig_bundle
vim config for linux devices driver development 
本次vim配置是独家配置，配置文件已经隐藏

输入./config.sh 即可自动完成配置。

注意：1)在配置之前，确保已经安装好vim,
	  即之前做过sudo apt-get install vim 这样的操作,如果没有请先安装vim
	  2)执行脚本前，注意自己的~/.bashrc文件尾部是否添加过java配置等方面内容。如果有，
	  在执行完sudo ./config.sh后，在执行脚本备份的~/.bakvim/.bashrc中将其追加到新的~/.bashrc尾部即可。

配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。
2015-12-03 马宁
*******************************
一、配置vim+ctags+cscope+taglist 
*******************************

        （1）安装vim ctags cscope
                  sudo apt-get install vim ctags cscope

        （2） vimconfig.tar.bz2  拷贝到Ubuntu家目录下解压（或解压后的vimconfig拷贝到家目录）；
                  
        （3）进入解压后的目录，执行sudo ./config.sh
        
                  
        至此，环境配置完毕
测试：
        vi a.c
        输入main后，按tab键看是否成功自动补全。
        
*********************
二、快捷键说明 
********************** 
vim打开在源码目录打开文件后
普通模式下：
F2    打开TagList
F3    打开NERDTree
F4    打开MRU
F5    打开LookupFile
F6    用vimgrep搜索光标所在的单词
F7    生成tags
F8    生成 filename tags
F9    生成cscope的数据库
F10  

说明：
		修改源码时，自动补全依赖于tags，需要在源码kernel/uboot目录下分别生成tags文件；
************************
三、tags和cscope库文件的生成
************************
方法一：
	在要生成库的目录下打开3个vim，普通模式下，分别按F7、F8、F9 ；等待生成结束即可
 
方法二：
   kernel/下只生成与arm架构有关的 :（kernel中建议用方法二）
   	1)生成tags文件： 
   		make tags ARCH=arm
   	
   	2)生成cscope的库 
   		make cscope ARCH=arm
   		
  u-boot64/下生成tags
   	ctags -R
		cscope -Rbq
		
注意：
		在生成tags和cscope前已打开的文件不能跟踪代码，重新打开即可；
		
**************************
tags和cscope使用方法
**************************
用于跟踪源码
ctags用法：
	跟踪代码：Ctrl+t
	回退：	Ctrl+t
	
cscoe用法：
1)普通模式下，光标在要查找的符号上，快速按下以下对应快捷键。
,sc	 查找调用本函数的函数
,sd	 查找本函数调用的函数
,se	 查找egrep模式，相当于egrep功能，但查找速度快多了
,sf	 查找并打开文件，类似vim的find功能
,sg	 查找函数、宏、枚举等定义的位置，类似c tags的功能
,si	 查找包含本文件的文件
,ss	 查找C语言符号，即查找函数名、宏、枚举值等出现的地方
,st	 查找指定的字符串

注意：
	按的慢，如按下,s停顿后，会删除一个字符进入插入模式，只依次需按Esc u即可恢复（回到普通模式，撤销）。

回退按：
		Ctrl+t
		
=============================
马宁 151205		
		
***************************

***************************
常规模式下输入 cM 清除行尾 ^M 符号
启用每行超过80列的字符提示（字体变蓝并加下划线）

实现递归查找上级目录中的ctags和cscope和自动载入
向上查找包含当前目录在内的5级目录，
普通模式下：快捷键F12


窗口切换的映射
ctrl+h    焦点移到左边窗口
ctrl+j
ctrl+k
ctrl+l
当前窗口处于插入模式，窗口焦点切换
也是这个映射 


插入模式下(暂时未启用，与当前窗口处于插入模式，窗口焦点切换冲突)：
光标向上移动 ctrl+K
光标向下移动 ctrl+J
光标向左移动 ctrl+H (不生效，哪里映射成了backspace)
光标向右移动 ctrl+L
