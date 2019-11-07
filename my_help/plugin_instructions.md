# plugin instructions
- LastChange: 2019-11-07
-    Version: V0.0.06

## vim-plug 命令
    :PlugStatus		- 	检查状态
    :PlugInstall	-   安装之前在配置文件中声明的插件。
    :PlugUpdate		-   更新插件
	更新插件后，按下 d 查看更改。或者，你可以之后输入 :PlugDiff

审查插件
有时，更新的插件可能有新的 bug 或无法正常工作。要解决这个问题，你可以简单地回滚有问题的插件。<br/>
输入 :PlugDiff 命令，然后按回车键查看上次 :PlugUpdate的更改，并在每个段落上按 X 将每个插件回滚到更新前的前一个状态。

删除一个插件删除或注释掉你以前在你的 vim 配置文件中添加的 plug 命令, 然后
	:PlugClean		-   删除插件

    :PlugUpgrade	-   升级vim-plug本身


## C/C++ 符号索引 {{{1
	ags.o.fn、tags和cscope, gtags生成及使用方法
	DIY 一套超越市面上任何编辑器（vscode，emacs，vscode）体验的最强静态符号索引系统。

`,f9`  生成ctags和cscope for c<br/>
`,f8`  生成ctags和cscope for c++<br/>

`,9f`  autoload ctags和cscope<br/>
### 1)tags.o.fn、tags和cscope库文件的生成 {{{2
 
	cindex 终端生成ctags索引文件tags  

#### kernel/下只生成与arm架构有关的 :  
	打开vim窗口，按F9,会生成tags.o.fn,并自动根据当前目录在kernel/或linux-stable使用make生成ctags和  
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
		
### 2)tags和cscope使用方法 {{{2
#### (1)ctags用法：
##### 用于跟踪源码
	在vim窗口跟踪光标所在变量或函数等:  
	跟踪代码：Ctrl+]  
	回退：	Ctrl+t
	使用tags查找符号:  
		:tag xxx  

	在终端直接查找:  
		vi -t 变量或函数名  

	tags在当前目录或vi自动向上查找的目录层级(7级)范围内  
	
#### (2)cscoe用法：
##### 普通模式下，光标在要查找的符号上，快速按下以下对应快捷键。
	在当前窗口跳转:  

		,sc	 查找调用本函数的函数  
		,sd	 查找本函数调用的函数  

		,sg	 查找函数、宏、枚举等定义 (类似c tags的功能)  
		,ss	 查找C语言符号(函数名、宏、枚举值等)出现的地方  
		
		,sf	 查找并打开文件 (类似vim的find功能)  
		,si	 查找包含本文件的文件  

		,se	 查找egrep模式 (相当于egrep功能，但查找速度快多了)  
		,st	 查找指定的字符串  

	跳转时，打开一个垂直分割窗口(第一次跳转时使用):  
		命令中的s变成v, 即:  
		,vc  
		,vd  
		...  

	底行模式中输入要查找的变量，字符串或文件等:  
		命令中的s变成f, 即:  
		,fc   
		,fd  
		...  

	注意：
		按的慢，如按下,s停顿后，会删除一个字符进入插入模式，只依次需按Esc u即可恢复（回到普通模式，撤销）。

	回退按：  
		Ctrl+t

### Gtags
	传统 ctags 系统虽和 vim 结合紧密，但只能查定义无法查引用，
	cscope 能查引用，但只支持 C 语言，C++都不支持，况且常年不更新。
	ctags 由于使用文本格式存储数据，虽用了二分查找，但打开 Linux Kernel 
	这样的大项目时，查询会有卡顿的感觉。
#### GTagsGNU GLOBAL）比起 ctags 主要的优点
    a. 不但能查定义，还能查引用
	b. 原生支持 6 种语言（C，C++，Java，PHP4，Yacc，汇编）
	c. 扩展支持 50+ 种语言（包括 go/rust/scala 等，基本覆盖所有主流语言）
	d. 使用性能更好的本地数据库存储符号，而不是 ctags 那种普通文本文件
	e. 支持增量更新，每次只索引改变过的文件
	f. 多种输出格式，能更好的同编辑器相集成

### 
	'ludovicchabant/vim-gutentags'


## 2、tagbar(,f1) {{{1
note: ,f1 中的f 指的是小写字母f

### tagbar
	基于ctags,分割窗口显示当前的代码结构概览		
    更适合面向对象语言使用的显示函数列表插件  

    :Tagbar	打开  
	:help tagbar


#### 在tagbar 窗口有效的映射:
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

#### tagbar比taglist优化了的地方:  
	1)支持头文件的函数列表显示  
	细心的读者可能会发现，tagbar对函数的可见级别也是做了区分的，分别用+ – # 并配合着色来做了区分  
	2)对面向对象的支持更好  
	taglist虽然也会列出类列表，但是整体还是很不直观  
	3)自动根据文件修改时间来重建  
	taglist在这一点上体验就很不好，其实明明可以通过这种时间戳的方式来实现  
 
## 3、NERDTree--文件浏览(按F4)和VimExplorer--文件管理器(按,F4) {{{1
	
### NERDTree --用于文件浏览(按F4)
  列出当前路径的目录树。  
  浏览项目的总体目录结构和创建删除重命名文件或文件名。  
  内核中_defconfig  .mk等文件可用nerd tree 打开

#### 1)在NERDTree中选中目录，按ma，新建文件或者目录
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

#### vim-nerdtree-tabs.vim 
	  打开的各个文件共享一个 NERDTree  

#### nerdtree-git-plugin.vim
	  在 NERDTree 中显示 git 信息  

	  Modified  : "✹",  
	  Staged    : "✚",  
	  Untracked : "✭",  
	  Renamed   : "➜",  
	  Unmerged  : "═",  
	  Deleted   : "✖",  
	  Dirty     : "✗",  
	  Clean     : "✔︎",  
	  Unknown   : "?"  

### VimExplorer --文件管理器(按,F4)
	按,F4会在当前目录打开（状态栏显示的顶级目录）;Q 退出  
	可以执行很多文件操作，如复制，删除，移动，预览，搜索等  

	:VE  启动VimExplorer,然后会询问你开始的文件夹。  
	:VE [directory]  另一种启动方式(tab键或ctrl-d能自动补全路径)  
	将会在一个新的tab中打开:有两个窗口，一个是目录树，一个是文件  

#### 快捷键：
##### Tree Panel Hotkeys
	?    help，打开帮助文件
	回车或双击    toggleNode,开关节点。开关/切换到当前节点  
	r    刷新树形目录窗口  
	f    查看选中/喜欢的文件夹列表  
	F    添加当前光标下的文件夹到选中/喜欢的列表中。如果当前光标下没有路径，使用当前工作路径  
	b    查看浏览历史  
	t    开关文件窗口  
	<bs>    即Backspace键，退回上级目录  
	Ctrl+tab    切换到文件窗口  
	Ctrl+g    切换到另一个路径，底行输入路径。  
	Q    退出 VimExplorer  

##### File Panel Hotkeys
	?    帮助  
	回车/双击    进入目录，或者打开文件通过默认关联规则  
	r    刷新  
	t    开关树形目录窗口  
	i    切换排序模式(type/data/file/extension)  
	+f    创建新文件，底行输入文件名。Esc取消  
	+d    创建新目录  
	Ctrl+tab    切换到树形目录窗口   
	Q    退出  
	H    显示隐藏文件开关  
	g/    搜索  
	m{a-z}    将当前路径放入寄存器(a-z),退出后不保持    
	'{a-z}    跳转到寄存器(a-z)中的路径  
	J    查看寄存器中的路径  
	鼠标右键    普通模式下的文件窗口上下文菜单  
	Backspace    回退到上一级目录  
	Ctrl+i    gotoForward   
	Ctrl+o    gotoBackward  
	f    查看选中的文件夹列表  
	F	添加当前光标下的文件夹到选中的列表中。如果当前光标下没有路径，使用当前工作路径  
	b    查看浏览历史  
	Ctrl+g    切换到其他路径   
	R    重命名当前光标下的文件  
	yy    复制光标下的文件   
	xx    剪切光标下的文件  
	yl    显示剪切板  
	dd    删除光标下文件到回收站  
	DD    强制删除光标下文件  
	u     打开预览  
	U     关闭预览  
	<s-space>    shift+空格，向上移动光标并标记/取消标记  
	空格    标记/取消标记并向下移动光标  
	Ctrl+左单击  标记或取消标记  
	Mr    通过正则表达式标记，在底行输入   
	Mv    标记所有的vim文件  
	Md    标记所有的目录  
	Me    标记所有的可执行文件  
	Mc    取消所有标记  
	sd    删除标记的文件到回收站  
	sD    强制删除标记的文件  
	sy    复制标记的文件  
	sx    剪切标记的文件  
	se    编辑每一个标记的文件，在分开的tab中  
	p     粘贴  
	=     比较两个文件  
	e     编辑文件在新tab中  
	;r    Open Renamer  
	;c    从当前路径开始一个shell; exit返回  
	;e    开始其他的文件管理器(nautilus,konquer,explorer.exe),默认nautilus打开光标所在目录  
	
###### Visual Mode Hotkeys
	空格    标记文件  
	d     删除文件到回收站  
	D     强制删除文件  
	y     复制文件  
	x     剪切文件  
	e     在新tab中查看文件  


## 4、MRU -- Most Recently Used 最近打开文件列表(按F4) {{{1
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
		
		,m : 在底行输入字符串，如工程名，匹配字符串  

###2) 打开符合vim正则的文件列表
    :MRU vim
        打开文件名中包含vim的文件,指定只显示匹配vim的文件  
        	
## 5、  



## 6、vimgrep(按F6) {{{1
	F6    在当前文件父目录下的.c和.h中搜索光标所在的单词  
	Ctrl+F6    在状态行显示的相对路径父目录下.c和.h中递归搜索光标所在的单词  
	,F6  在底行输入指定路径path/*.c 搜索，  
		 搜索完后输入:cw  打开quickfix搜索结果  
	Ctrl-\+F6   在当前文件父目录下的.c和.h中搜索//gj双斜杠中填写的关键字.
	如搜索是否包含某头文件  

### 1)在底行模式
	:vimgrep 

	在路径和文件名符合{file}的所有文件中,查找符合{pattern}的字符串：  
	:vimgrep     /{pattern}/[g][j]     {file} ...  
	:cw  或 :copen    打开quickfix列表查看结果，回车打开对应文件 

### 2)QuickFix 窗口操作：
	:copen    打开quickfix
	:cclose    关闭quickfix
	:cc    是在转到当前查找到的位置
	:cn    转到下一个位置
	:cp    转到前一个位置

## 7、bufexplorer {{{1

	vi *.c 打开多个文件时，可以用,bv切换buffer  

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

## 8、Man命令 {{{1
	查看C语言帮助文档。安装有C语言和Posix的帮助手册，  
	查看printf函数的帮助文档，  
	:Man 3 printf  

## 9、vim-gitgutter {{{1
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

## 10、gitv 的使用 -- gitk for vim {{{1
### 1)浏览模式 Brower mode 
	:Gitv  
	:Gitv local_branch
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

## 11、Fugitive.vim {{{1
    a git wrapper for Vim - 将git工作流集成到vim中   
    补充了git 的command line 接口，使工作更流畅  

### 以下两种方式均可用于vim下的git提交:  
    git               fugitive       	action  
    :Git add % 	      :Gwrite 	    将当前更改或者新增的文件加入到Git的索引中  
    :Git checkout % 	:Gread 	      使用HEAD中的最新内容替换掉当前文件。已添加到缓存区的改动，不受影响  
    :Git rm % 	      :Gremove    	删除当前文件，并通知vim buffer  
    :Git mv % 	      :Gmove 	      重命名当前文件，并通知vim buffer  

	在vim的command line, % 会扩展为当前文件的绝对路径。  
>http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/

### Browsing past revisions of a file

	The Glog command makes it easy to examine all previous revisions of a file. It does this by loading each revision into its own buffer, and queuing them in the quickfix list in chronological order.

	You can filter the results
	command 						action
	:Glog 							load all previous revisions of the current file into the quickfix list
	:Glog -10 						load the last ten previous revisions of the current file into the quickfix list
	:Glog -10 --reverse 			load the first ten revisions of the current file into the quickfix list (in reverse chronological order)
	:Glog -1 --until=yesterday 		load the last version of the current file that was checked in before midnight last night

>http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/

### Add git branch to status line

Fugitive provides a function that you can add to your statusline, and it will show your current git branch. This example is taken from the fugitive documentation (:help fugitive-statusline):

>set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

###  resolving merge conflicts with vimdiff 
	When git branches are merged, there is always the chance of a conflict arising 
	if a file was modified in both the target and merge branches. You can resolve merge conflicts using a combination of fugitive’s :Gdiff command, and Vim’s built in diffget and diffput. 

>http://vimcasts.org/episodes/fugitive-vim-resolving-merge-conflicts-with-vimdiff/

### working with the git index

The git index is where you put changes that you want to be included in the next commit. If you are used to working with the command line git client, you might think of the index as an abstract concept. But with fugitive, you can actually read the index version of a file into a buffer by running:

:Gedit :path/to/file

If you run :Gedit with no arguments from a working tree file, it will open the index version of that file. You can always open the index version of the current file by running any one of the following:

:Gedit
:Gedit :0
:Gedit :%

>http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/

### 更多参见help  
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

### examples
	  a. vi README.md, 随便复制粘贴两行，人为创造改动
	  b. :Gblame	查看每行最后的提交信息
	  c. :Gstatus   检查仓库当前的状态
	  d. 在分割窗口中显示git status的输出结果，在该行按下-键，用该文件的名字
	  暂存这个文件的提交 ,再按一次取消暂存，这个信息会随着你的操作自动更新.
	  (可以在命令行用git status 查看暂存的情况,或:AsyncRun git status健康 )
	  在输出结果窗口，文件名这一行，按=可以展开看到修改的差异
	  e. 暂存完后，可以用:Gcommit 来提交修改了.Fugitive 会打开另一个分割窗口让
	  你输入提交信息
	  f. :Gstatus 查看结果
	  g. :Gpush 把新的提交推送到远程

#### 更多
	  vim Fugitive 的github 项目主业有很多屏幕录像展示了它的更多功能和工作流  
	  https://vimawesome.com/plugin/fugitive-vim  
https://github.com/tpope/vim-fugitive





## 12、vimdiff {{{1
### 解决 git merge 冲突	
	当合并时出现 merge conflicts 时:
		git mergetool
	vimdiff作为合并工具的界面截图：
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/vimdiff-merge-image.png)

## 13、ZoomWinPlugin.vim {{{1
    用于分割窗口的最大化与还原  
	当多窗口时：  
	Ctrl+a :缩放当前vim窗口(在终端内全屏或恢复)  


## 14、SnipMate  代码片段补全 {{{1
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
>for (i = 0; i < count; i++) {  
>	/* code */  
>}  

### {} [] () 尖括号  "" '' 等补全:
	输入左半部分，需要补全的时候使用tab，括号里的内容输入完成后tab出去.(.补全成[])   
	不需要补全，正常输入即可  
	若用插件自动补全，输入 ( 时显示函数参数的插件就废了  

+	注意:
	还不完善，按tab容易跟出代码提示，尚需区分括号补全还是代码补全
+	括号映射改为括号+tab键，跳出括号保持连按jj
	如下：
>	'+tab
>	"+tab
>	(+tab
>	[+tab
>	{+tab

长时间不按tab, 即保持单括号输入。
	
## 15、YouCompleteMe、AutoComplPop、superTab 和OmniCppcomplete代码自动补全 {{{1
###	YouCompleteMe:
	
### AutoComplPop、superTab 和OmniCppcomplete
	AutoComplPop:  
	acp.vim插件，在输入的同时实时地查询匹配的关键词 
	superTab: [已去掉20160809] 
	Tab键自动补全后，继续输入即可，按回车会换行。(首次选中不补全，此时按回车补全)  
	shift-Tab 回退选择  
	
	去掉superTab后：
	tab键功能：
		(1)缩进一个tab
		(2)代码片段补全，c.snippets中定义。如补全main,for等
	自动补全列表：
		(1)ctrl+n: 下一个
		(2)ctrl+p: 上一个

	OmniCppComplete：  
	专为 C/C++ 编写的 OmniComplete 一个补全脚本，根据 Ctags 生成的索引文件进行补全  
	c/c++代码（类的 . , ->, :: 操作符）的自动补全  
	ta :生成专用于c/c++的ctags文件  


## 16、echofunc.vim {{{1
	打开一个文件，生成tags数据库，在一个函数实现体中调用另外一个函数。
	当你输入完这个被调用的函数名，在输入左括号的时候在VIM的下方就会显示函数的原型。

## 17、The-NERD-Commenter --代码注释插件 {{{1
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

## 18、模糊查找 {{{1
### (1) ctrlp.vim  {{{2
	ctrl+p 打开查找窗口;模糊搜索当前目录及其子目录下的所有文件  
	Esc    退出查找窗口  
	
#### 打开ctrlp查找窗口后:  
	ctrl-f    切换查找方式(Files, Buffers and MRU files)，可模糊搜索最近打开的文件(MRU)  
	vsp 打开其他路径下文件，ctrl+p会从打开文件所在目录开始递归查找文件  
	
	输入关键字, 然后  
	ctrl + j/k   进行上下选择  
	ctrl + o	 can select tab/vertical/horizontal/replace/hidden  
	ctrl + x     在当前窗口水平分屏打开文件  
	ctrl + v     同上, 垂直分屏  
	ctrl + t     在tab中打开  
	ctrl + u 	 删除所有输入  

#### Basic Usage

    Run :CtrlP or :CtrlP [starting-directory] to invoke CtrlP in find file mode.  
    Run :CtrlPBuffer or :CtrlPMRU to invoke CtrlP in find buffer or find MRU file mode.  
    Run :CtrlPMixed to search in Files, Buffers and MRU files at the same time.  

	Check :help ctrlp-commands and :help ctrlp-extensions for other commands.  
##### Once CtrlP is open:

    <F5>   在ctrlp窗口按，为当前目录更新cache: 更新新的文件，移除删除的文件，适应新忽略的选项.  
    <c-f>,<c-b>    在模式之间循环切换.  
    <c-d>   switch to filename only search instead of full path.  
    <c-r>   切换到正则表达式模式(regexp mode).  
    <c-n>, <c-p>  选择提示历史中的下一个/上一个字符串.  
    <c-y>	输入路径和文件名后，按c-y,创建目录及文件，会打开一个垂直窗口用于输入文件内容。  
    <c-z>   标记或取消标记多个文件， <c-o> 垂直分割窗口打开标记的文件.  

	:help ctrlp-mappings   查看映射的帮助  

    Submit two or more dots .. to go up the directory tree by one or multiple levels.  
    End the input string with a colon : followed by a command to execute it on the opening file(s):  
    Use :25 to jump to line 25.  
    Use :diffthis when opening multiple files to run :diffthis on the first 4 files.  

##### 借鉴一张图片演示
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/ctrlp.gif)

#### ctrlp的插件ctrlp-funky
	,fu 进入当前文件的函数列表搜索  
	,fU 搜索当前光标下单词对应的函数  

##### 借鉴一张图片演示
![image](https://github.com/sky8336/vimcfg_bundle/blob/master/vimcfg-images/ctrlp-funky.gif)

### (2) leaderf {{{2
	文件/buffer模糊匹配快速切换	
	a. 提供函数列表，全异步显示, 不用时不占用屏幕空间，将 ALT+P 绑定到 `:LeaderfFunction!` 
		targbar补充，tagbar 可现实变量等更多信息
	b. 支持文件，MRU，Buffer名称搜索

	CTRL+P 在当前项目目录打开文件搜索
	alt+m 打开 MRU 搜索，搜索最近打开的文件
	ALT+f 打开函数搜索，	
	ALT+b 打开 Buffer 搜索  
	alt+t :LeaderfTag<cr>

	<ESC>		退出

	在模糊匹配模式下按 TAB 可以切换到匹配结果窗口用光标 或 Vim 搜索命令进一步筛选，
	匹配结果窗口推出	q

	文件/MRU 模糊匹配对于熟悉的项目效率是最高的
	新的项目，不熟悉文件名,需要文件浏览功能, 参考nerdtree 或 vim-dirvish

	按 i 进入模糊匹配，按TAB切换回列表选择

## 19、surround.vim {{{1
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

### examples   
	Details follow on the exact semantics, but first, consider the following
	examples.  An asterisk (*) is used to denote the cursor position.

	  Old text                  Command     New text ~
	  "Hello *world!"           ds"         Hello world!
	  [123+4*56]/2              cs])        (123+456)/2
	  "Look ma, I'm *HTML!"     cs"<q>      <q>Look ma, I'm HTML!</q>
	  if *x>3 {                 ysW(        if ( x>3 ) {
	  my $str = *whee!;         vllllS'     my $str = 'whee!';

## 20、cctree--函数调用视图 {{{1
	查看函数调用的视图，以树的形式表示出来提供两个方向的视图,  
	这个插件也要生成数据库的，在生成cscope数据库的同时也生成cctree的数据库，  
	但是cctree的数据添加非常缓慢，所以默认打开文件没有添加cctree数据库。  

### 快捷键:
	ctrl-\+F9 : load cscope.out,添加cctree数据库  

	将光标移到要查询的函数下:  
    Ctrl-\+> 这个函数为头，查看其下的函数调用情况(先按ctrl+\,再按>)  
    Ctrl-\+< 这个函数为尾,查看其上的函数  
    Ctrl-\+w 显示或者关闭cctree窗口  

	cctree窗口提供跳转功能:  
	1.鼠标双击该函数  
	2.按Enter  
	3.ctrl+p  

## 21、  

## 22、  


## 23、DirDiff.vim -- 文件夹比较插件 {{{1
### USAGE(使用):
		
    :DirDiff ../something/dir1 /usr/bin/somethingelse/dir2  

### MAPS映射:
#### 在diff窗口使用的命令：
	回车，o  diff open: 打开光标所在的比较文件  
	s        同步当前的diff.  
	         可以选择一个范围（通过visual模式）,并且按s来同步一段范围的差异。  
			 按s后有6种选择：  
			 1. A -> B  
			     复制A来覆盖B  
				 如果A的文件指向一个文件夹，将会递归的复制A来覆盖B   
			 2. B -> A  
			 3. Always A  
			     对选择剩下的项目，像(1)中那样同步  
			 4. Always B  
			 5. Skip  
			     跳过这个diff 条目  
			 6. 取消  
			 
	u    Diff update: 更新比较窗口  
	x    设置排除的图案，用,分开  
	i    设置忽略的图案，用,分开  
	a    为diff设置额外的参数，eg. -w 忽略空白  
	q    退出DirDiff  


	,dg              Diff get: maps to :diffget<CR>
	,dp              Diff put: maps to :diffput<CR>
	,dj              Diff next: (think j for down) 
	,dk              Diff previous: (think k for up)

## 24、undotree -- ctrl+F5 {{{1
	用可视化的树形结构显示vim的历史操作。  
	在undotree窗口按?打开帮助  

## 25、 

## 26、Syntastic --语法检查 {{{1
	:SyntasticCheck    手动检查(F7)  
	:Errors    打开location-list窗口查看错误位置(ctrl+F7)  
	:lclose    关闭(,F7)   
	:SyntasticReset  清空错误列表  
	:SyntasticToggleMode  切换是否激活自动检查  

	不必到location-list窗口跳转到不同的错误，有几个内建的命令  
	如，:lnext  :lprevious
	:help unimpaired   安装unimpaired后，查看这些命令的映射  
	常用命令:  
	[a     :previous
	]a     :next

## 27、man.vim{{{1
	在.vimrc中:
source $VIMRUNTIME/ftplugin/man.vim
$VIMRUNTIME=/usr/share/vim/vim74/

nmap K :Man <cword>
K: 在线参考手册中查找
### linux programmer's Manual
	ctrl-\+a    :Man <cword>  
	ctrl-\+2  :Man 2 <cword>  

## 28、drawit.vim{{{1
Vim画图插件（可在vim中画基本示意图）  
###使用
####1）启动和退出DrawIt:
		,di    启动  
		,ds    关闭  

####2）画图
	在visual block（可视块）模式下，Ctrl-v进入可视块模式。选择一个矩形框，然后:  
		,b    矩形框  
		,e    椭圆  

####3）箭头
		^     上箭头    
		,^    粗大上箭头    
		v     下箭头      
		,v    粗大下箭头  
		>     右箭头  
		,>    粗大右箭头  
		<     左箭头  
		,<    粗大左箭头  

####4）斜线
		PgUp    右上斜线  
		PgDn    右下斜线  
		End     左下斜线  
		Home    左上斜线  

## 29、Tablify.vim(表格转化插件）{{{1
Tablify is a VIM plugin that turns simple structured data into nice-looking tables.  

###Usage
	There is a small list of commands you need to know before starting  
	making tables out of your text. Assuming your <Leader> is ,:  
	,tl or ,tt - turns selected lines into table (left-aligned text)  
	,tc - turns selected lines into table (centered text)  
	,tr - turns selected lines into table (right-aligned text)  
	,tu - convert selected table back into raw text format in case you   
	want to add some changes in it  

	,ta - select formed table with cursor anywhere inside of it (also   
			selects structured text for future tables)  
#### example1
	a. vi ./vimcfg_bundle/test/tablify_test.txt
	b. you can see following line:
		a | b | c| d
		1 | 22 | 333 | 444
	c. select the two line
	d. ,tl or ,tc or ,tu
	e. select the table and ,tu


####Operations with formed and selected table:
	,ts - sort table (column number will be prompted), supports text and  
	numeric sorting  

Every line of your future table is a text line with cells, separated by | symbol   
(or any other symbol you choose forg:tablify_raw_delimiter variable in your .vimrc file).  

####Let's assume we have a few lines of text we would like to see as table:
Artist | Song | Album | Year  
Tool | Useful idiot | Ænima | 1996  
Pantera | Cemetery Gates | Cowboys from Hell | 1990  
Ozzy Osbourne | Let Me Hear You Scream | Scream | 2010  


Now select these lines and press ,tt to make a table:  
+---------------+------------------------+-------------------+------+  
| Artist        | Song                   | Album             | Year |  
+---------------+------------------------+-------------------+------+  
| Tool          | Useful idiot           | Ænima             | 1996 |  
+---------------+------------------------+-------------------+------+  
| Pantera       | Cemetery Gates         | Cowboys from Hell | 1990 |  
+---------------+------------------------+-------------------+------+  
| Ozzy Osbourne | Let Me Hear You Scream | Scream            | 2010 |  
+---------------+------------------------+-------------------+------+  


I bet it was pretty simple. Now you can press u to undo making of table or select table   
and press ,tu to return to the text you're started from. After that you can try ,tc and  
,tr to see what it looks like to have aligned text in table.  

####It is obvious that our table here have some kind of header and it will be great to visually
distinguish it from table data. To do so, just separate the header cells with # symbol (or   
		any other symbol you choose for g:tablify_header_delimiter variable in your.vimrc file):  

Artist # Song # Album # Year  
Tool | Useful idiot | Ænima | 1996  
Pantera | Cemetery Gates | Cowboys from Hell | 1990  
Ozzy Osbourne | Let Me Hear You Scream | Scream | 2010  


And that's what we get after tablification:  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
| Artist        | Song                   | Album             | Year |  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
| Tool          | Useful idiot           | Ænima             | 1996 |  
+---------------+------------------------+-------------------+------+  
| Pantera       | Cemetery Gates         | Cowboys from Hell | 1990 |  
+---------------+------------------------+-------------------+------+  
| Ozzy Osbourne | Let Me Hear You Scream | Scream            | 2010 |  
+---------------+------------------------+-------------------+------+  


There is no problem of making tables out of commonly prefixed text lines, like:  
/**  
 * Artist#Song#Album#Year  
 * Tool|Useful idiot|Ænima|1996  
 * Pantera|Cemetery Gates|Cowboys from Hell|1990  
 * Ozzy Osbourne|Let Me Hear You Scream|Scream|2010  
 *  
 */  


####Multiline cell content is also supported, just place \n where line 
break should occur, and tablify will do the rest:  
Artist # Song # Album # Year  
Pantera | Cemetery Gates | Cowboys from Hell | 1990  
Tool \n (great perfomance)| Useful idiot | Ænima | 1996  
Ozzy Osbourne | Let Me Hear You \n Scream | Scream | 2010  


The sample above transforms to table:  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
| Artist             | Song            | Album             | Year |  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
| Pantera            | Cemetery Gates  | Cowboys from Hell | 1990 |  
+--------------------+-----------------+-------------------+------+  
| Tool               | Useful idiot    | Ænima             | 1996 |  
| (great perfomance) |                 |                   |      |  
+--------------------+-----------------+-------------------+------+  
| Ozzy Osbourne      | Let Me Hear You | Scream            | 2010 |  
|                    | Scream          |                   |      |  
+--------------------+-----------------+-------------------+------+  

###Configuration
Tablify behaviour can be configured on per-buffer basis with the folowing variables:  
g:loaded_tablify - set to 1 to disable loading of the plugin  
b:tablify_headerDelimiter - default value is #, symbol that separates header cells in text  
b:tablify_delimiter - default value is |, symbol that separated value cells in text  
  
b:tablify_vertDelimiter - default value is |, vertical delimiter symbol for filling up table rows  
b:tablify_horDelimiter - default value is -, horizontal delimiter symbol for filling up table rows  
b:tablify_horHeaderDelimiter - default value is ~, horizontal delimiter symbol for filling up tabls header rows  
b:tablify_divideDelimiter - default value is +, symbol at the row/column intersection  

b:tablify_cellLeftPadding - default value is 1, number of spaces used for left cell padding  
b:tablify_cellRightPadding - default value is 1, number of spaces used for right cell padding  

## 30. asyncrun.vim -

### 使用 :AsyncRun 类似！运行各种 shell 命令，只不过是放到后台运行，同时输出（stdout+stderr）重定向到当前 quickfix窗口.
	在 Quickfix 窗口实时看到后台命令的输出。
		比如：后台异步运行编译任务，编译当前文件或者工程:AsyncRun gcc % -o %<
	:AsyncRun g++ -O3 % -o %< -lpthread 
	:AsyncRun make
	:AsyncRun make -f makefile

	在 Vim 里面异步提交工程，并把提交结果实时显示在 Quickfix中：
		:AsyncRun git push origin master

		绑定 F7为异步编译当前文件：
		:noremap <F7> :AsyncRun gcc % -o %< <cr> 命令的参数接受下面这些宏（和vim里面的 expand函数类似）：
		%:p     - File name of current buffer with full path
		%:t     - File name of current buffer without path
		%:p:h   - File path of current buffer without file name
		%:e     - File extension of current buffer
		%:t:r   - File name of current buffer without path and extension
		%       - File name relativize to current directory
		%:h:.   - File path relativize to current directory
		<cwd>   - Current directory
		<cword> - Current word under cursor
		<cfile> - Current file name under cursor
		
		打开quickfix窗口：
		:botright copen 10
		:cclose 关闭F10上
#### 按键绑定
	,f5：打开/关闭底部的 quickfix 窗口
	,;5：单文件, 编译
	,\5：单文件, 运行

	,5f：项目,编译
	,5;：项目, 测试
	,5\：项目：运行

#### example:
##### example1
		a. cd vimcfg_bundle/test/gdb_test/short_connection
		b. vi tcp_client.c
		c. ,f5	//open quickfix list
		d. :AsyncRun make
		f. :AsyncRun make clean
		g. ,f5

##### example2
		a. cd vimcfg_bundle/test/gdb_test/short_connection
		b. vi tcp_client.c
		c. ,f5	//open quickfix list
		d. :AsyncRun make
		f. ,f8 //open terminal
		g. cd terminal && ./tcp_server
		h. cd 'tcp_client.c' window
		i. ,\5 // run tcp_client

## 31. UltiSnips - 代码片段终极解决方案  
	这个补全引擎非常快，而且有非常惊艳的表现，需要配合 vim-snippets 一起使用.
	 UltiSnips 是补全引擎，真正的补全模板在 vim-snippets  
	 连续按下两次i触发代码补全
	 代码片段维护在 vim-snippets 项目里面，~/.vim/bundle/vim-snippets/
	只需要关注其中的 UltiSnips 和 snippets 这两个文件夹，snippets 这里面是 snipMate 格式的补全代码，不推荐使用，新入坑的同学应该始终选择 UltiSnips 格式，因为其更灵活.

###	UltiSnips 风格规则:  
    代码片段以 snippets 代码片段触发的缩写 "代码片段描述" 开始，以 endsnippet 结束
    ${x} 定义了跳转点，使用 <c-j> 和 <c-k> 进行切换(请参看我的配置文件)
    ${0} 比较特殊，它实际上是最后一个跳转点，而不是第一个
    ${x:statement} 其中的 statement 可以替换成默认显示的文本.


## 32、vim-multiple-cursors(多光标选中编辑）{{{1
	配合 ctrlsf 插件, 搜索后多光标直接编辑保存, 简直是重构神器

###example
	(1) vi vimcfg_bundle/test/multiplecursors.c
	(2) 光标放在old_sum上，按ctrl-n,选中当前光标下变量.（按esc 可退出该选中模式）
	(3) 继续按ctrl-n, 选中下一个old_sum, 
	(4) ctrl-m 代替ctrl-p(与搜索插件冲突), 尝试选中后，按<esc>
	(5) 按g+Ctrl-a都选中(先按g,然后ctrl和a连续按,分别按g+ctrl+a显示ascii相关信息)
	(6) 按下列之一编辑`c`, `s`, `I`, `A`

## 33. vim-repl.sh {{{1
### example
	(1) vi vimcfg_bundle/test/vim-repl.sh
	(2) 按,re打开repl窗口
	(3) 按,w 将光标所在行命令发送到repl窗口中执行,执行后光标跳到下一行，可一次执行
	(3) ,re 关闭repl窗口
## 34.ctrlsf-vim {{{1
	reference: https://vimawesome.com/plugin/ctrlsf-vim

## 35. vimtex {{{1
	vim + vimtex + latexmk + zathura
	vimtex is a Vim plugin that provides support for writing LaTeX documents. 
	https://vimawesome.com/plugin/vimtex
	https://blog.csdn.net/richard__ting/article/details/79720784
### help
see :h vimtex

### example
	a. vi vimcfg_bundle/test/tex/1.tex
	b. 输入:LLPStartPreview 然后pdf出现
	c. 更改 1.tex， pdf 实时预览
	d. 退出到terminal,生成pdf: pdflatex 1.tex
	f. 打开pdf: evince 1.pdf

## 36. vim-translate-me 翻译插件 {{{1
支持弹窗(floating & popup)和异步特性
https://vimawesome.com/plugin/vim-translate-me

## 37. vim-airline 和 vim-airline-themes
在顶行显示buffer及对应文件
`:tabnew README.md` 在tab中打开后，顶上1 行显示tab<br/>
`:b 2`	jump buffer号为2的buffer<br/>


## 其他 {{{1
	(a)普通模式下:
		输入 cM 清除行尾 ^M 符号;
		输入 cm 去掉行尾空格;  
		输入 cu 转换成utf-8格式;
		输入 ci 全部缩进对齐  
		输入 cy 全部复制  

	(b)启用每行超过80列的字符提示（字体变蓝并加下划线）(未启用)  
	(c)窗口焦点切换的映射(insert/normal mode)  
		 普通模式或插入模式下：  
		 ctrl+h    焦点移到左边窗口  
		 ctrl+j 		   下边  
		 ctrl+k 		   上边  
		 ctrl+l			   右边  

	(d)插入模式下光标移动：  
		光标向上移动 alt+k  
		光标向下移动 alt+j  
		光标向左移动 alt+h   
		光标向右移动 alt+l  

	(e).bashrc 中更改命令提示行颜色  
	(f)快捷键映射
		空格-> :  
		,cd -> 快速切换到打开VIM时的目录。  
		比如:  
		在"~/project"目录下打开VIM，为了编译"~/project/driver/dma"目录而  
		切换目录":cd driver/dma"，编译完成后可使用",cd"命令切换到"~/project"目录下  
		\   在命令行显示当前行所在的函数名称  
		;   after "fx" in normal mode, press ; repeat the cmd
		:pwd      显示当前路径(相对路径之前的路径)  
		ctrl+g    在底行显示文件相对路径  
		1-ctrl+g  先按1,再按下ctrl+g，在底行显示绝对路径  
	(g) 剪切和复制  
	    (1) 按住shift键，用鼠标选中复制到vim的"*寄存器(状态栏的文件路径也可复制)，  
		    粘贴时输入"*p(或鼠标滚轮)即可复制。  
		(2)	终端选中文字，ctrl+shift+c复制，在vim窗口直接输入p或点击鼠标滚轮即可  

		(3)实现vim和终端及gedit等之间复制、粘贴的设置：  
        既可以复制单行命令到终端，又可以复制多行到gedit打开的文件中。  
   
        vim-->终端/gedit  
                （1）在vim普通模式下，输入yy可复制当前行到"+寄存器。  
                （2）在terminal中：Ctrl-Shift-v，粘贴。  
                     在gedit中ctrl+v粘贴  
        终端/gedit-->vim：  
                （1）在终端选中复制内容，用shift+ctrl+v复制；  
                （2）在vim普通模式下，输入p复制。  

	(h)vim和终端切换  
		ctrl+z : vim切换到后台  
		fg     : 切换回前台  

		:sh    从vim切换到终端运行shell  
		Ctrl + D(or exit)  从终端回到vim(to kill the shell and return to vim)  
		

	(i)改变窗口大小(window-resize)  
		w= : 高度增加5行  
		w- : 高度减小5行  
		w, : 宽度增加5行  
		w. : 宽度减小5行  
		

