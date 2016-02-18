# vimconfig_bundle
vim config for linux devices driver development  
配置文件是隐藏文件

# 一、配置前注意：
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
	  	

# 二、配置步骤：

	1)进入vimconfig_bundle/目录。（脚本中会利用目录下到config.sh获取用户名和用户组）
	2)输入sudo ./config.sh  
		自动完成配置。（自动备份原来配置，自动配置.vimrc和.bashrc以及.vim，自动安装vundle和vundle管理到插件)  

注意：  
	(a)插件更新  
	若vundle管理的插件安装不成功，也可手动安装：  
	打开vim，底行模式命令：  
		:BundleList 查看要安装的插件  
		:BundleInstall 安装插件  
	不在vundle中管理的插件(~/.vim/plugin/下的)更新(使用getscriptPlugin.vim)：  
	打开vim，底行模式命令:  
	:GetScripts  
	或普通模式下,gs  

	(b)配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。

	(c)测试：
        vi a.c
        输入main后，按tab键看是否成功自动补全。

# 三、vim使用说明
	151208

## 1、插件及功能列表
    vundle  插件管理  
	TagList  
    NERDTree  
    MRU  
    LookupFile  
	bufexplorer  
    用vimgrep搜索光标所在的单词  
    生成 tags  
	生成 filename tags  
	生成 cscope的数据库  
	vimdiff  
	ZoomWinPlugin  窗口缩放插件  
	SnipMate  代码片段补全  
	superTab  代码自动补全  

	vundle插件列表截图：
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/vim-plugin_vundle.png)

## 2、快捷键说明 
	vim打开在源码目录打开文件后  
	普通模式下：  
	F2    打开TagList  
	F3    打开NERDTree  
	F4    打开MRU  
	F5    打开LookupFile  
	F6    用vimgrep搜索光标所在的单词  
	F7    生成tags  
	F8    生成filename tags(tags.fn)  
	F9    生成cscope的数据库  
	,mt   生成tags.usertype文件(tags.ut)
	F12	  实现递归查找上级目录中的ctags和cscope并自动载入，向上查找包含当前目录在内的5级目录  
	(F10/F11系统占用)

### 说明：
	1)修改源码时，自动补全依赖于tags，需要在源码kernel/uboot目录下分别生成tags文件；
	2)使用vim打开文件按下F5后的界面:  
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/F5-Lookup_File.png)
	3)使用vim打开文件按下F3和F4后的界面:  
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/F3-F4-NERDtree-MRU.png)

## 3、tags和cscope生成及使用方法
### 1)tags和cscope库文件的生成
#### 方法一：
	在要生成库的目录下打开3个vim，普通模式下，分别按F7、F8、F9 ；等待生成结束即可
 
#### 方法二：
##### kernel/下只生成与arm架构有关的 :（kernel中建议用方法二）  
   	(1)生成tags文件：   
   		make tags ARCH=arm
   	
   	(2)生成cscope的库   
   		make cscope ARCH=arm  
   		
##### u-boot64/下生成tags  
   	ctags -R  
	cscope -Rbq  
		
	注意：
		在生成tags和cscope前已打开的文件不能跟踪代码，重新打开即可；
		
### 2)tags和cscope使用方法
#### (1)ctags用法：
##### 用于跟踪源码
	跟踪代码：Ctrl+]  
	回退：	Ctrl+t
	
#### (2)cscoe用法：
##### 普通模式下，光标在要查找的符号上，快速按下以下对应快捷键。
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
## 4、hlud.vim -- 生成tags.usertype文件(,mt)
	先按F7生成tags数据库，再按 ,mt (mytype)生成tags.usertype文件(tags.ut)  
	让自己定义的类型、函数以不同的颜色显示  

## 5、TagList(按F2)
	基于ctags,分割窗口显示当前的代码结构概览		

### 1)底行模式打开:
	:TlistOpen   打开并将焦点置于标签列表窗口
	:TlistClose  关闭标签列表窗口
	:TlistToggle 切换标签列表窗口状态（打开--关闭），标签列表窗口是否获得焦点取决于其他配置

### 2)在TagList窗口操作：
	回车键： 跳到光标所在标记的定义处
	o: 新建一个水平分割窗口（上部），跳到标记定义处
	p: 预览标记定义（焦点仍然在taglist窗口）
	空格: 在底行显示标记的原型（如函数原型）
	u: 更新标记列表（比如源文件新增一个函数，保存后，在taglist窗口按u）
	d: 删除光标所在的taglist文件
	x: 放大/缩小taglist窗口
	[[: 将光标移到前一个文件的起点
	]]: 将光标移到后一个文件的起点
	+: 展开标记
	-: 折叠
	*: 全部展开
	=: 全部折叠
	s: 选择排序字段
	q: 退出taglist窗口

 
## 6、NERDTree --用于文件浏览(按F3)
	列出当前路径的目录树。  
	浏览项目的总体目录结构和创建删除重命名文件或文件名。  
	内核中_defconfig  .mk等文件可用nerd tree 打开

### 1)在NERDTree中选中目录，按ma，新建文件或者目录
	o       在已有窗口中打开文件、目录或书签，并跳到该窗口  
	go      在已有窗口中打开文件、目录或书签，但不跳到该窗口  
	t       在新 Tab 中打开选中文件/书签，并跳到新 Tab  
	T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab  
	i       split 一个新窗口打开选中文件，并跳到该窗口  
	gi      split 一个新窗口打开选中文件，但不跳到该窗口  
	s       vsplit 一个新窗口打开选中文件，并跳到该窗口  
	gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口  
	!       执行当前文件  
	O       递归打开选中结点下的所有目录  
	x       合拢选中结点的父目录  
	X       递归合拢选中结点下的所有目录  
	e       Edit the current dif  

	双击    相当于 NERDTree-o  
	中键    对文件相当于 NERDTree-i，对目录相当于 NERDTree-e  

	D       删除当前书签

	P       跳到根结点  
	p       跳到父结点  
	K       跳到当前目录下同级的第一个结点  
	J       跳到当前目录下同级的最后一个结点  
	k       跳到当前目录下同级的前一个结点  
	j       跳到当前目录下同级的后一个结点  

	C       将选中目录或选中文件的父目录设为根结点  
	u       将当前根结点的父目录设为根目录，并变成合拢原根结点  
	U       将当前根结点的父目录设为根目录，但保持展开原根结点  
	r       递归刷新选中目录  
	R       递归刷新根结点  
	m       显示文件系统菜单 #！！！然后根据提示进行文件的操作如新建，重命名等  
	cd      将 CWD 设为选中目录  

	I       切换是否显示隐藏文件  
	f       切换是否使用文件过滤器  
	F       切换是否显示文件  
	B       切换是否显示书签  

	q       关闭 NerdTree 窗口  
	?       切换是否显示 Quick Help	  

## 7、MRU -- Most Recently Used 最近打开文件列表(按F4)
###1) 打开一个新窗口，显示最新打开的文件列表。
    :MRU
        在该命令后加空格，然后TAB或者Ctrl+D会自动补全。
        在文件列表中选择后，
        Enter：	会在当前窗口打开，
        o：	可以在新窗口打开该文件，
        v：	可以只读打开，
        t：	会在新的tab打开。

###2) 打开符合vim正则的文件列表
    :MRU vim
        打开文件名中包含vim的文件
        	
## 8、LookupFile -- 文件搜索用(按F5)
	tags.fn 用于文件搜索,包含项目中所有文件名  
	tab键开始扫描  
	ctrl+o:	水平分割窗口打开  

	注意：  
	Lookupfile插件需要genutils支持,提供一些通用的函数，供其它的脚本使用.  

### 1)查找文件，
    在打开的缓冲区中查找，
    按目录查找。
#### (1)项目文件查找

	按F5或输入:LookupFile
	在当前窗口上方打开文件查找窗口，开始输入文件名（至少4个字符）。
    文件名可以使用vim的正则表达式。
	按两下F5窗口消失

    CTRL-N ：向上选择
    CTRL-P ：向下选择
	或者用上、下光标键 在下拉列表中选择文件。
    
	选中文件后，按回车，在当前窗口中打开此文件。
	ctrl+o:	水平分割窗口打开


#### (2)缓冲区查找

	同时打开许多文件。在众多buffer中切换到自己所要的文件。  
    按缓冲区名字查找缓冲区，输入缓冲区的名字（可以是正则表达式 ），  
	匹配的缓冲区列在下拉列表中，同时还会列出该缓冲区内文件的路径。  
				
    :LUBufs  
    输入缓冲区的名字，在你输入的过程中，符合条件的缓冲区就显示在下拉列表中了，
	选中所需缓冲区后，按回车，就会切换你所选的缓冲区。  


#### (3)目录浏览
    :LUWalk  
    打开lookupfile窗口，输入目录。  
    lookupfile会在下拉列表中列出这个目录中的所有子目录及文件供选择，如果选择了目录，就会显示这个目录下的子目录和文件；  
    如果选择了文件，就在vim中打开这个文件。  
    需要输入绝对路径？  


	LUPath和LUArgs两个功能。感兴趣的朋友读一下lookupfile的手册。	

## 9、vimgrep(按F6)
	在打开vim的目录下递归搜索.c 和 .h 文件

### 1)在底行模式
	:vimgrep 

	在路径和文件名符合{file}的所有文件中,查找符合{pattern}的字符串：  
	:vimgrep     /{pattern}/[g][j]     {file} ...  
	:copen    打开quickfix列表查看结果，回车打开对应文件 

### 2)QuickFix 窗口操作：
	:copen    打开quickfix
	:cclose    关闭quickfix
	:cc    是在转到当前查找到的位置
	:cn    转到下一个位置
	:cp    转到前一个位置

## 10、bufexplorer
	在各个buffer 之间切换
	,be 全屏方式打开buffer列表
	,bs 水平窗口打开buffer列表
	,bv 垂直窗口打开buffer列表

	:help bufexplorer 帮助 


## 11、Man命令
	查看C语言帮助文档。安装有C语言和Posix的帮助手册，  
	查看printf函数的帮助文档，  
	:Man 3 printf  

## 12、vim-gitgutter 的使用(160125)
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

### GitGutter 截图
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/GitGutter_screenshot.png)

## 13、gitv 的使用 -- gitk for vim
### 1)浏览模式 Brower mode 
	:Gitv  
    显示当前分支的提交记录  
    类似gitk 功能，左边显示提交信息，右边显示具体修改。  
    退出时，回到原来的窗口  
    
### 2)File mode
	:Gitv!
	显示当前文件的修改

	:Git log
	显示提交信息

#### 按键映射：
	只在gitv browser modes 模式下有效  
	普通模式下:  
		<cr> 回车  
		q  退出  
		s  竖直分割窗口，显示diff信息
		u	更新当前浏览窗口内容

#### Gitv截图
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/Gitv_screenshot.png)

## 14、vimdiff
### 解决 git merge 冲突	
	当合并时出现 merge conflicts 时:
		git mergetool
	vimdiff作为合并工具的界面截图：
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/vimdiff-merge-image.png)

## 15、ZoomWinPlugin.vim
    用于分割窗口的最大化与还原  
	当多窗口时：  
	Ctrl+a :缩放当前vim窗口(在终端内全屏或恢复)  


## 16、SnipMate  代码片段补全
	代码补全快捷键是Tab  
	按Tab按可跳到可选择下一个位置，即c.snippets	中${1},${2}...  
	等表示的位置，输入可直接替换  
	snippets/ 目录存放的是代码模板，可以根据需要修改和添加代码模板
### 代码片段补全例子：  
	可补全到代码见c.snippets  
	a.输入inc后，按Tab键。  
		自动补齐为  #include <stdio.h>  
	b.输入def，按Tab键。  
		自动补齐为   #define  
	c.输入if，按Tab键。  
		自动补齐为   
		if (/* condition */) {  
			/* code */  
		}  
	d.输入for，按Tab键  
		代码自动补齐为   
		for (i = 0; i < count; i++) {  
			/* code */  
		}  
### {} [] () 尖括号  "" '' 等补全:
	输入左半部分，需要补全的时候使用tab，括号里的内容输入完成后tab出去.   
	不需要补全，正常输入即可  
	若用插件自动补全，输入 ( 时显示函数参数的插件就废了  

	注意:
	还不完善，按tab容易跟出代码提示，尚需区分括号补全还是代码补全
	
## 17、AutoComplPop和superTab 代码自动补全
	AutoComplPop:  
	acp.vim插件，实现代码自动提示,不用每次都按键  

	superTab:  
	Tab键自动补全
	shift-Tab 回退选择
## 18、echofunc.vim
	打开一个文件，生成tags数据库，在一个函数实现体中调用另外一个函数。
	当你输入完这个被调用的函数名，在输入左括号的时候在VIM的下方就会显示函数的原型。

## 19、The-NERD-tree --代码注释插件
    可以对多种文件类型的文件进行不同方式地、快速地注释  
    NERD Commenter的常用键绑定(详析:h NERDCommenter):  

    在Normal或者Visual 模式下：  
	,ca，在可选的注释方式之间切换，比如C/C++ 的块注释/* */和行注释//  
	,cc，注释当前行  
	,c，切换注释/非注释状态  
	,cs，以”性感”的方式注释  
	,cA，在当前行尾添加注释符，并进入Insert模式  
	,cu，取消注释  
	Normal模式下，几乎所有命令前面都可以指定行数  
	Visual模式下执行命令，会对选中的特定区块进行注释/反注释  

## 其他
	(a)常规模式下输入 cM 清除行尾 ^M 符号  
	(b)启用每行超过80列的字符提示（字体变蓝并加下划线）(未启用)  
	(c)窗口焦点切换的映射  
		 普通模式或插入模式下：  
		 ctrl+h    焦点移到左边窗口  
		 ctrl+j 		   下边  
		 ctrl+k 		   上边  
		 ctrl+l			   右边  

	(d)插入模式下光标移动(暂时未启用，与当前窗口处于插入模式，窗口焦点切换冲突)：  
		光标向上移动 ctrl+K  
		光标向下移动 ctrl+J  
		光标向左移动 ctrl+H (不生效，哪里映射成了backspace)  
		光标向右移动 ctrl+L  

	(e).bashrc 中更改命令提示行颜色  
	(f)快捷键映射
		空格-> :  
		,cd -> 快速切换到打开VIM时的目录。  
		比如:  
		在"~/project"目录下打开VIM，为了编译"~/project/driver/dma"目录而  
		切换目录":cd driver/dma"，编译完成后可使用",cd"命令切换到"~/project"目录下  
