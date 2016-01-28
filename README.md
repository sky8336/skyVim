# vimconfig_bundle
vim config for linux devices driver development 
配置文件是隐藏文件

=======================================================================
一、配置前注意：
	1)在配置之前，确保已经安装好vim,
	  	即之前做过sudo apt-get install vim 这样的操作,如果没有请先安装vim
	  	
       安装vim+ctags+cscope+taglist
		sudo apt-get install vim ctags cscope

	2)执行脚本前，注意自己的~/.bashrc文件尾部是否添加过java配置等方面内容。如果有，
	  在执行完sudo ./config.sh后，在执行脚本备份的~/.bakvim/.bashrc中将其追加到新的~/.bashrc尾部即可。
	  
	3)160125更新：
	  	增加bundle管理插件，执行脚本前确保联网。bundle用于插件管理，使用bundle安装新的插件。
	  	可利用bundle安装vim-gitgutter插件，gitv插件。	  
	  	vim-gitgutter 可用于查看自己修改的地方。
	  	
=======================================================================

二、配置步骤：

1)进入vimconfig_bundle/目录。（脚本中会利用目录下到config.sh获取用户名和用户组）

2)输入sudo ./config.sh 即可自动完成配置。

3)打开vim，利用vundle安装几个插件
	底行模式命令：
		:BundleList 查看要安装的插件
		:BundleInstall 安装插件
	  
配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。

	测试：
        vi a.c
        输入main后，按tab键看是否成功自动补全。

=======================================================================
三、vim使用说明
151208

-------------------------------
1、插件及功能列表
-------------------------------
    TagList
    NERDTree
    MRU
    LookupFile
    用vimgrep搜索光标所在的单词
    生成tags
    生成 filename tags
    生成cscope的数据库
        
-------------------------------
2、快捷键说明 
-------------------------------
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
F12		实现递归查找上级目录中的ctags和cscope并自动载入，向上查找包含当前目录在内的5级目录，


说明：
		修改源码时，自动补全依赖于tags，需要在源码kernel/uboot目录下分别生成tags文件；
-------------------------------
3、tags和cscope库文件的生成
-------------------------------
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
		
-------------------------------
4、tags和cscope使用方法
-------------------------------
用于跟踪源码
ctags用法：
	跟踪代码：Ctrl+]
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
		
------------------------------- 
5、vim-gitgutter 的使用(160125)
-------------------------------
最左边的标记列:
    波浪线  ：该行相比HEAD修改过，
    红色的减号：这里删除了一行，
    绿色的+号：新增行。

(1)diff区块之间跳转，默认快捷键为 [c 和 ]c
(2)暂存和回退
    暂存 <Leader>hs ,即git add 操作；新改动会和暂存内容对比，暂存后不能回退到之前
    回退修改 <Leader>hr 
(3)查看diff的修改，<Leader>hp ,显示diff差异。
有时没反应，底行模式输入“gitg”点Tab键跟出“GitGutter”，回车执行,即可

-------------------------------  
6、gitv 的使用 -- gitk for vim
------------------------------- 
浏览模式 Brower mode 
	:Gitv
    显示当前分支的提交记录
    类似gitk 功能，左边显示提交信息，右边显示具体修改。
    退出时，回到原来的窗口
    
File mode
	:Gitv!
		显示当前文件的修改

	:Git log
		显示提交信息

按键映射：
	只在gitv browser modes 模式下有效
	普通模式下:
		<cr> 回车
		q  退出
		s 竖直分割窗口，显示diff信息
		u	更新当前浏览窗口内容
-------------------------------
其他
-------------------------------
(a)常规模式下输入 cM 清除行尾 ^M 符号
(b)启用每行超过80列的字符提示（字体变蓝并加下划线）(未启用)
(c)窗口焦点切换的映射
	 普通模式或插入模式下：
		ctrl+h    焦点移到左边窗口
		ctrl+j						下边
		ctrl+k						上边
		ctrl+l						右边

(d)插入模式下光标移动(暂时未启用，与当前窗口处于插入模式，窗口焦点切换冲突)：
	光标向上移动 ctrl+K
	光标向下移动 ctrl+J
	光标向左移动 ctrl+H (不生效，哪里映射成了backspace)
	光标向右移动 ctrl+L

(e).bashrc 中更改命令提示行颜色
