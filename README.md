# vimconfig_bundle
vim config for linux devices driver development  
大家记得点击右上角的star和watch给个星星支持一下,本配置将持续更新，致力于顺手好用。  

### 温馨提示：
     (1)如有问题，欢迎大家及时提出来，共同进步。  
	 (2)本配置会在摸索过程中不断总结使用方法和优化插件组合,大浪淘沙，随着时间推移将越来越功能完善，以提高效率。  
	 (3)有更好的插件或需求及使用方法总结，记得留言，共同打造属于我们的编辑方案。  

### 本vim配置为:  
    适用于linux 内核/驱动开发的vim配置;  
	适用于c/c++的应用编程的vim配置;  

配置文件是隐藏文件  

# 一、配置前注意：
	1)执行脚本会先安装vim+ctags+cscope+ranger  
	ranger :命令行文件管理器，输入ranger回车即可打开。  

	2)执行脚本前，注意自己的~/.bashrc文件尾部是否添加过java配置等方面内容。如果有，
		在执行完sudo ./install.sh后，在执行脚本备份的~/.bakvim/.bashrc中将其追加到新的~/.bashrc尾部即可。
	  
	3)执行脚本前确保联网。 
	  	

# 二、配置步骤：

	1)进入vimconfig_bundle/目录。（脚本中会利用目录下到install.sh获取用户名和用户组）
	2)输入sudo ./install.sh
		自动完成配置。（自动备份原来配置，自动配置.vimrc和.bashrc以及.vim，自动安装vundle和vundle管理到插件)  
		插件安装过程受网速影响，放在一边，耐心等待安装完自动关闭vim窗口即可。  

### 注意：  
#### (a)插件更新,或仅更新某个功能    
##### 若vundle管理的插件安装不成功，也可手动安装：  
	打开vim，底行模式命令：  
		:BundleList 查看要安装的插件  
		:BundleInstall 安装插件  
##### 如果仅仅想添加某个插件，或者恢复到之前的某个插件
	  可以通过gitk来查看修改记录，单独安装配置需要的插件即可。 
#### (b)配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。

#### (c)测试：
        vi a.c  
        输入main后，按tab键看是否成功自动补全。 

# 三、vim使用说明
### 自己总结的帮助文档打开方式
	,hm :vim窗口，普通模式下打开README.md查看帮助
	,h  :vim窗口，打开my_help文件夹，可选择查看常用帮助，包括git命令，vim命令等
		
## 1、插件及功能列表
    vundle  插件管理  
	tagbar
	VimExplorer
    MRU  
    LookupFile  
	bufexplorer  
	SrcExpl     代码预览  
	trinity.vim  模拟source insight窗口  
    用vimgrep搜索光标所在的单词  
    生成 tags  
	生成 filename tags  
	生成 cscope的数据库  
	vimdiff  
	ZoomWinPlugin  窗口缩放插件  
	SnipMate  代码片段补全  
	superTab  代码自动补全  
	AutoComplPop
	CCTree

	vundle插件列表截图：
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/vim-plugin_vundle.png)


   /** vundle命令 **/  
   Brief help  
   :BundleList          - list configured bundles  
   :BundleInstall(!)    - install(update) bundles  
   :BundleSearch(!) foo - search(or refresh cache first) for foo   
   :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
     
   see :h vundle for more details or wiki for FAQ   
   NOTE: comments after Bundle command are not allowed..  

## 2、快捷键说明 
	vim打开在源码目录打开文件后  

#### 普通模式下：  
	
	F1    帮助:GNOME Terminal Manual
	F2    tagbar开关   
	F3    VimExplorer开关
	F4    打开MRU,在路径列表中，光标在工程名处按shift+*,高亮相应工程，便于选择;
	      :q  退出MRU
	,m    按,m后，将在终端复制的项目名粘贴到底行，按回车后打开MRU，文件路径匹配输入的项目名  
	( Ctrl+F1 ~ Ctrl+F4不可用 )

	F5    LookupFile开关（按2下关）  
	F6    用vimgrep搜索光标所在的单词  
	F7
	F8    
	Ctrl+F8 

	F9    在kernel/目录或linux-stable/目录下，生成filename(tags.fn)及arm平台的tags(tags.fn)和cscope数据库；  
	      否则，通用，生成filename(tags.fn)及tags(tags.fn)和cscope数据库  
	Ctrl+F9	  实现递归查找上级目录中的ctags和cscope并自动载入，向上查找包含当前目录在内的5级目录  
	,mt   生成tags.usertype文件(tags.ut)
	( F10/F11系统占用 )  
	Ctrl+F10   模拟source insight 窗口中的Taglist窗口开关  
	Ctrl+F11   模拟source insight 窗口中的NERDTree窗口开关  
	F12        source insight 模拟窗口 
	Ctrl+F12   模拟source insight 窗口中的Source_Explorer窗口开关


### 说明：
	1)修改源码时，自动补全依赖于tags，需要在源码kernel/uboot目录下分别生成tags文件；
	2)使用vim打开文件按下F2 F5后的界面:  
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/F2-F5-Lookup_File.png)
	3)使用vim打开文件按下F3后的界面:  
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/F3-VimExplorer.png)

## 3、tags.fn、tags和cscope生成及使用方法
### 1)tags.fn、tags和cscope库文件的生成
 
#### kernel/下只生成与arm架构有关的 :  
	打开vim窗口，按F9,会生成tags.fn,并自动根据当前目录在kernel/或linux-stable使用make生成ctags和  
	cscope；若不是kernel或linux-stable目录，则使用ctags和cscope命令来生成  
	放在那里，生成结束会自动关闭窗口  

	也可在终端手动生成：  
   	(1)生成tags文件：   
   		make tags ARCH=arm  
   	
   	(2)生成cscope的库   
   		make cscope ARCH=arm    
   		
#### u-boot64/下生成tags  
    F9  
	或在终端手动生成:  
   	ctags -R  
	cscope -Rbq  
		
#### 注意：
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

## 5、tagbar(按F2)
	基于ctags,分割窗口显示当前的代码结构概览		
    更适合面向对象语言使用的显示函数列表插件  

    :Tagbar	打开  
	:help tagbar


在tagbar 窗口有效的映射:
    回车  跳到光标下的tags  
	p     预览;调到光标下的tag,焦点保留在tagbar窗口  
	P     在预览窗口打开  
	左键单击折叠图标    折叠开关  
	左键双击折叠图标    跳到光标下的tag  
	ctrl+n     跳到下一个顶层tag  
	ctrl+p     跳到上一个顶层tag  
	空格键     在命令行显示当前tag的原型  
	v          Hide tags that are declared non-public. Tags without any  
	visibility information will still be shown.  
	+/zo      打开折叠  
	-/zc      折叠开关  
	o/za      打开或关闭折叠  
	*/zR      打开所有的折叠  
	=/zM      关闭所有的折叠  
	zj        跳到下一个折叠的开始  
	zk        调到上一个折叠的结尾  
	s         切换折叠中tag的排序  
	c         打开|g:tagbar_autoclose| 选项  
	x         放大窗口  
	q         关闭tagbar窗口  

### 简单的列了几点比taglist优化了的地方:  
	1)支持头文件的函数列表显示  
	细心的读者可能会发现，tagbar对函数的可见级别也是做了区分的，分别用+ – # 并配合着色来做了区分  
	2)对面向对象的支持更好  
	taglist虽然也会列出类列表，但是整体还是很不直观  
	3)自动根据文件修改时间来重建  
	taglist在这一点上体验就很不好，其实明明可以通过这种时间戳的方式来实现  
 
## 6、VimExplorer --文件管理器(按F3)
	按F3会在当前目录打开（状态栏显示的顶级目录）  
	可以执行很多文件操作，如复制，删除，移动，预览，搜索等  

	:VE  启动VimExplorer,然后会询问你开始的文件夹。  
	:VE [directory]  另一种启动方式(tab键或ctrl-d能自动补全路径)  
	将会在一个新的tab中打开:有两个窗口，一个是目录树，一个是文件  

## 7、MRU -- Most Recently Used 最近打开文件列表(按F4)
###1) 打开一个新窗口，显示最新打开的文件列表。
    :MRU
        在该命令后加空格，然后TAB或者Ctrl+D会自动补全。
        在文件列表中选择后，
        Enter：	会在当前窗口打开，
        o：	可以在新窗口打开该文件，
        v：	可以只读打开，
        t：	会在新的tab打开。
		u： 更新文件列表（MRU窗口一直打开时有用）  
		q： 退出MRU  
		
		,mr : 直接打开MRU，不会匹配当前工程名  

###2) 打开符合vim正则的文件列表
    :MRU vim
        打开文件名中包含vim的文件,指定只显示匹配vim的文件  
        	
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

	回车/双击左键 在当前窗口打开光标下的buffer  
	b             快速切换buffer 用 b<bufnum>.  
	d             关闭buffer  
	D             关闭buffer,?  
	o             在当前窗口打开buffers  
	p             文件名和路径名分开显示的开关  
	q             退出 bufexplorer.  
	r             改变列出的buffers顺序.  
	R             相对和绝对路径开关.  
	s             循环选择以什么顺序列出buffers, buffer number, file name, file extension, most recently used (MRU), or  full path.  
	S             反向循环选择以什么顺序列出buffers  
	u             显示未列入buffers的开关  

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

## 14、Fugitive.vim
    a git wrapper for Vim   
    补充了git 的command line 接口，使工作更流畅  
以下两种方式均可用于vim下的git提交:  
    git               fugitive       	action  
    :Git add % 	      :Gwrite 	    将当前更改或者新增的文件加入到Git的索引中  
    :Git checkout % 	:Gread 	      使用HEAD中的最新内容替换掉当前文件。已添加到缓存区的改动，不受影响  
    :Git rm % 	      :Gremove    	删除当前文件，并通知vim buffer  
    :Git mv % 	      :Gmove 	      重命名当前文件，并通知vim buffer  

在vim的command line, % 会扩展为当前文件的绝对路径。  

    更多参见help  
    :help cmdline-special  
    :help :_%  
    ctlr-n/ctrl-p keyword autocompletion  
    :help 'complete'  
    :help :Git  
    :help :Gwrite  
    :help :Gread  
    :help :Gremove  
    :help :Gmove  
    :help :Gcommit  
    :help :Gblame     
    注意：  
    可参见网址：  
      http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/  



## 15、vimdiff
### 解决 git merge 冲突	
	当合并时出现 merge conflicts 时:
		git mergetool
	vimdiff作为合并工具的界面截图：
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/vimdiff-merge-image.png)

## 16、ZoomWinPlugin.vim
    用于分割窗口的最大化与还原  
	当多窗口时：  
	Ctrl+a :缩放当前vim窗口(在终端内全屏或恢复)  


## 17、SnipMate  代码片段补全
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
	输入左半部分，需要补全的时候使用tab，括号里的内容输入完成后tab出去.(.补全成[])   
	不需要补全，正常输入即可  
	若用插件自动补全，输入 ( 时显示函数参数的插件就废了  

	注意:
	还不完善，按tab容易跟出代码提示，尚需区分括号补全还是代码补全
	
## 18、AutoComplPop、superTab 和OmniCppcomplete代码自动补全
	AutoComplPop:  
	acp.vim插件，在输入的同时实时地查询匹配的关键词 
	superTab:  
	Tab键自动补全后，继续输入即可，按回车会换行。(首次选中不补全，此时按回车补全)  
	shift-Tab 回退选择  

	OmniCppComplete：  
	专为 C/C++ 编写的 OmniComplete 一个补全脚本，根据 Ctags 生成的索引文件进行补全  
	c/c++代码（类的 . , ->, :: 操作符）的自动补全  
	ta :生成专用于c/c++的ctags文件  


## 19、echofunc.vim
	打开一个文件，生成tags数据库，在一个函数实现体中调用另外一个函数。
	当你输入完这个被调用的函数名，在输入左括号的时候在VIM的下方就会显示函数的原型。

## 20、The-NERD-Commenter --代码注释插件
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

## 21、ctrlp.vim
	模糊查找ctrl+p  
	
	ctrl-f    模糊搜索最近打开的文件(MRU)  
	ctrl-p    模糊搜索当前目录及其子目录下的所有文件  

	搜索框出来后, 输入关键字, 然后  
	ctrl + j/k   进行上下选择  
	ctrl + x     在当前窗口水平分屏打开文件  
	ctrl + v     同上, 垂直分屏  
	ctrl + t     在tab中打开  

	Basic Usage  

    Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.  
    Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.  
    Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.  

	Check :help ctrlp-commands and :help ctrlp-extensions for other commands.  
	Once CtrlP is open:  

    Press <F5> to purge the cache for the current directory to get new files, remove deleted files and apply new ignore options.  
    Press <c-f> and <c-b> to cycle between modes.  
    Press <c-d> to switch to filename only search instead of full path.  
    Press <c-r> to switch to regexp mode.  
    Use <c-n>, <c-p> to select the next/previous string in the prompt's history.  
    Use <c-y> to create a new file and its parent directories.  
    Use <c-z> to mark/unmark multiple files and <c-o> to open them.  

	Run :help ctrlp-mappings or submit ? in CtrlP for more mapping help.  

    Submit two or more dots .. to go up the directory tree by one or multiple levels.  
    End the input string with a colon : followed by a command to execute it on the opening file(s):  
    Use :25 to jump to line 25.  
    Use :diffthis when opening multiple files to run :diffthis on the first 4 files.  

#### 借鉴一张图片演示
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/ctrlp.gif)

### ctrlp的插件ctrlp-funky
	,fu 进入当前文件的函数列表搜索  
	,fU 搜索当前光标下单词对应的函数  

#### 借鉴一张图片演示
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/ctrlp-funky.gif)

## 22、surround.vim
    在字符两边插入或改变各种成对的符号在字符两边插入或改变各种成对的符号：单/双引号;大中小括号等
    快捷键的列表：  
	Normal mode  
	-----------  
	ds  - delete a surrounding  
	cs  - change a surrounding  
	ys  - add a surrounding  
	yS  - add a surrounding and place the surrounded text on a new line + indent it  
	yss - add a surrounding to the whole line  
	ySs - add a surrounding to the whole line, place it on a new line + indent it  
	ySS - same as ySs  

	Visual mode  
	-----------  
	s   - in visual mode, add a surrounding  
	S   - in visual mode, add a surrounding but place text on new line + indent it  

	Insert mode  
	-----------  
	<CTRL-s> - in insert mode, add a surrounding  
	<CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent  
	<CTRL-g>s - same as <CTRL-s>  
	<CTRL-g>S - same as <CTRL-s><CTRL-s>  


## 23、cctree--函数调用视图
	查看函数调用的视图，以树的形式表示出来提供两个方向的视图,  
	这个插件也要生成数据库的，在生成cscope数据库的同时也生成cctree的数据库，  
	但是cctree的数据添加非常缓慢，所以默认打开文件没有添加cctree数据库。  

    快捷键,将光标移到要查询的函数下:  
    Ctrl-\+> 这个函数为头，查看其下的函数调用情况(先按ctrl+\,再按>)  
    Ctrl-\+< 这个函数为尾,查看其上的函数  
    Ctrl-\+w 显示或者关闭cctree窗口  

	cctree窗口提供跳转功能，鼠标双击该函数即可。  

## 24、project -- 项目管理工具
	打开project两种方式：  
	1)vim +Project  
	2)打开vim后，输入：Project  

	\C(导入项目，递归读取子目录)  
	\c(读取当前文件)  

	project窗口下,输入\C（斜杠+大写的C），会出现下面这些信息:  
	Enter the Name of the Entry: ProjectName （项目名称）  
	Enter the Absolute Directory to Load:  ProjectPath （项目路径目录）  
	Enter the CD parameter:  （“.”为当前目录,为空）  
	Enter the File Filter:  (符合条件的源文件，一般为空)  
	此后加载项目，加载比较慢  

	project窗口下，常用命令：  
	\l    (列出所有当前层文件)\L(递归),按任何键停止  
	\w    (关闭当前层文件)\W(递归)  
	\g    (在项目当前层文件搜索)\G(递归)  
	\r    关闭子文件夹并刷新当前文件夹下文件，\R递归打开文件夹并刷新所有文件  
	s     关闭文件夹并创建，S递归打开文件夹并创建  
	\s    将文件在水平打开多个窗口显示，打开或关闭文件夹列表  
	\o    将文件在一个窗口打开，打开或关闭文件夹列表  
	\v    在右窗口显示指针停留在project窗口的文件内容  
	空格  扩大project窗口的宽度，恢复宽度  
	\i    显示文件或文件夹的设置参数，如filter="*"  
	\I    显示文件或文件夹的决对路径和参数  
	\1 - \9，\f1-\f9，\F1-\F9执行指定命令，\0查询1-9命令，\f0查询f1-f9，F1-F9命令  

## 25、srcExpl --代码预览 F8
	F8  打开/关闭代码预览窗口  
	Ctrl+回车：在编辑窗口跳转到Source_Explorer窗口,在Source_Explorer窗口用回车跳转到定义处  
	在编辑窗口打开;  
	空格   在编辑窗口回车，跳转回来  

### trinity.vim -- Ctrl+F8 配合taglist SrcExpl 和NERDTree(内置) 模拟source insight
	Ctrl+F8: 打开/关闭source insight 模拟窗口，左侧taglist ,右侧NERDTree，下侧SrcExpl


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
