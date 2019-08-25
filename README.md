# skyVim - 一键安装超漂亮的vim配置
vim config for linux devices driver development and C development，C++, python/shell development<br/>

+ 工具就是生产力，打造利器, 提高效率…  
+ 针对vim8.1更新配置...
+ 记得点击右上角star…    


## 一 、Install and update {{{1

### 配置前注意: {{{2
	1)执行脚本会安装packages和vim, 指的是 vim+ctags+cscope+ranger  
	ranger:命令行文件管理器;命令行输入ranger回车打开。默认使用vim打开文件，支持代码跟踪。 

	2)在~/.bashrc中末尾会追加一行"source ~/.bashrc_my"。  
	第一次安装时，执行install.sh ,以后若更新本配置，执行update.sh快速更新   

>如果想安装截至到2016.04.27之前某个节点的配置需要注意:  
>执行脚本前，注意自己的~/.bashrc文件尾部是否添加过java配置等方面内容。  
>如果有，在执行完sudo ./install.sh后，在执行脚本备份的~/.bakvim/.bashrc中将其追加到新的~/.bashrc尾部即可。  
>因为此日期之前，会替换.bashrc,此日期之后，不再替换.bashrc

### 一键安装配置步骤 {{{2
	目前插件管理默认使用vim-plug
	Vim-plug 是一个自由、开源、速度非常快的、极简的 vim 插件管理器。
	它可以并行地安装或更新插件。你还可以回滚更新。它创建浅层克隆最小化磁盘空间
	使用和下载时间。它支持按需加载插件以加快启动时间。
	其他值得注意的特性是支持分支/标签/提交、post-update 钩子、支持外部管理的插件等。

#### install {{{3
`sudo ./install.sh`
查看帮助, 可跳过其中一些步骤，如果以前安装过.安装package（tools）可能会慢点
`sudo ./install.sh 0`
全自动安装vim，相关工具，配置vim， 配置git使用vim编辑
`sudo ./install.sh 4`
跳过安装package和vim,适合第二次以后的安装。用vim-plug后只需要3分钟

+ 联网情况, 第一次全安装可能几分钟，与网速有关.
+ 不联网情况比较快.

##### 注意：  
###### (a)插件更新    
####### 若vim-plug 管理的插件安装不成功，可执行update.sh脚本或手动安装:
	打开vim，底行模式命令：  
		:PlugStatus		查看插件状态
		:PlugInstall
####### vim-plug 命令
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

####### 如果仅仅想添加某个插件，或者恢复到之前的某个插件
	  可以通过gitk来查看修改记录，单独安装配置需要的插件即可。 
###### (b)配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。

###### (c)测试：
        vi a.c  
        输入main后，按tab键看是否成功自动补全。 

#### update {{{3
	cd skyVim
	sudo ./update.sh

	一键更新.vimrc及插件和帮助文件
	最短耗时不到1分钟，一般很快(3~90s)  

## 二 温馨提示：{{{1
     (1) 有问题或改善建议等，欢迎提issue，我们可以一起完善一个流畅的工作流利器…    
	 (2) 配置在使用过程中可能会有变化,release 的tag 可以作为回退某一版的标记…    
	 (3) 有更好的插件或需求及使用方法总结，可以留言的…
     (4) ubuntu 系统自带vim是vim.tiny，迷你版，.vimrc 有一些命令不支持，不过install.sh会自动安装完整版vim    
	 (5) 你配置文件是.开头的隐藏文件，如.vimrc等,可以参考修改  

### 本vim配置为:  {{{2
    适用于linux 内核/驱动开发的vim配置;  
	适用于c/c++的应用编程的vim配置;  
	适用于shell/python编程的vim配置;  

    当然，很多优秀的ide也可以很强大，我用vim的原因如下:
		(1) 不希望来回拿鼠标点击来打断工作流… 
		(2) 对熟练的项目，可以减少拿鼠标浪费的时间  
		(3) 对于代码修改，控制非预期的修改，比如带来多余的行尾空格，空行，对齐问题等,
			这些小问题会影响git 查看修改时迅速找到关键修改点.
			所以在我的vim里会保存时去掉行尾空格。
		(4) 在git下有修改时，行号左侧会显示+-~,来分别表示新增，减少，和变更的提示，方便看到自己改了哪些代码，
		我非常喜欢和依赖这个功能，这让我对自己的修改做到心中有数  
		(5) vim8.1 以后，因为异步及terminal的加入，vim将会变得更先进和现代化，vim使用越久受益越多
		(6) vim 的三种编辑模式，是vim特别的地方，可以保证我在家代码的时候，儿子过来乱点鼠标或键盘，不会输入过多无用字符;
			并且即使输入字符，也可以借助左侧提示的变化来方便恢复，只需要按几次u既可以...
		(7) 感谢开源精神，开源免费及大批爱好者的分享及提高使得vim在现代编辑器中依然占有一席之地
		(8) vim 原生功能及插件，是vim的两翼，让工具更强大.


### 帮助说明 {{{2
	,hm 打开本README.md  
	,hd  打开my_help/文件夹(directory)，可选择打开需要的帮助文件,如下:  
		git_command.txt  git使用整理  
		git_push.txt     git提交代码相关流程及命令  
		vim_command.txt  vim基本命令及使用技巧  
	vih 命令行输入，快速打开my_help/帮助目录
	vidc 'vi ~/.vim/my_help/debug_cmd.txt'
	vigc 'vi ~/.vim/my_help/git_command.txt'
	vigp 'vi ~/.vim/my_help/git_push.txt'
	vilc 'vi ~/.vim/my_help/linux_command.txt'
	vivc 'vi ~/.vim/my_help/vim_command.txt'
	exchkey : 交换 Caps_Lock 和 Escape 键  

## 三、vim使用说明 {{{1
### 1、插件列表 plugin_list {{{2
	目前在用插件及历史使用过的插件列表  
	[X] - 已不用
	<插件类型>
#### 插件管理  
    vim-plug  插件管理  

#### Display tags of a file ordered by scope
	tagbar  

####  tree explorer   
	NERDTree  
	vim-nerdtree-tabs	-   NERDTree and tabs together in Vim, painlessly  
	nerdtree-git-plugin
#### 注释
	The-NERD-Commenter

#### 文件管理    
	VimExplorer  

#### 窗口管理  
	ZoomWinPlugin  窗口缩放插件  

#### 最近打开文件  
    MRU  

#### 文件搜索  
	ctrlP + ctrlp-funky		[x]		<interface>
	leaderf		<interface>

#### Buffer Explorer   
	bufexplorer  

#### 关键词搜索  
    用vimgrep搜索光标所在的单词  

#### tags 和 cscope 数据库  
    生成 tags  
	生成 cscope的数据库  

#### 代码片段补全
	UltiSnips + vim-snippets [代替SnipMate]

#### 自动补全插件  
	AutoComplPop + OmniCppComplete  

#### C Call-Tree Explorer  
	CCTree

#### 目录和文件比较  
	DirDiff.vim		- 	run vim-diff on two directories recursively  
	vimdiff  		-   starting diff mode
	vim-dirdiff

#### git 相关  
	vim-fugitive
	vim-gitgutter
	gitv
#### 
	tpope/vim-surround

####
	undotree

#### 语法检测
	syntastic

#### Pairs of handy bracket mappings
	vim-unimpaired

#### 表格与画图  
	tablify 	-   turns simple structured data into nice-looking tables
	DrawIt
#### 
	asyncrun.vim

#### 
	echofunc.vim	[X 已不用]

#### airline
vim-airline<br/>
vim-airline-themes<br/>

#### statusline 
##### default statusline in .vimrc
	looks like:
	[+1]build_install_vim.sh                       [61%:339L,0][Git(master)][SH|utf-8]

	状态栏中表示的信息：
		1.修改未保存时，红色+,保存后消失；[+1]
		2. buffer id	[+1]
		3.文件名
		4. [所在行占总行数百分比: 总行数,光标在一行的位置]
		5.[git 分支信息]， 不是git仓库时不显示
		6.[文本类型|字符编码类型]
		7. 插入模式颜色品红；normal模式白色；
			分屏时，光标不在的窗口状态栏变灰色；

	.vimrc:
	set laststatus=2 "show the status line
	set statusline+=[%1*%M%*%-.2n]%.62f%h%r%=\[%-4.(%P:%LL,%c]%<%{fugitive#statusline()}\[%Y\|%{&fenc}\]%)

	" set statusline color {{{2
	" default the statusline to White (black character) when entering Vim
	hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
	" 状态栏颜色配置:插入模式品红色，普通模式White
	if version >= 700
	  "au InsertEnter * hi StatusLine term=reverse ctermbg=3 gui=undercurl guisp=Magenta
	  au InsertEnter * hi StatusLine term=reverse ctermfg=DarkMagenta ctermbg=Black gui=undercurl guisp=Magenta
	  au InsertLeave * hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
	endif

##### statusline plugin
	vim-airline
	vim-airline-themes

### 2、快捷键说明 {{{2
	vim打开在源码目录打开文件后  
	最新快捷键，打开.vimrc,搜索'key_mapping' 和'mapping' 查找

#### leader 即,开头的快捷键 {{{3
#### space 开头的快捷键 {{{3
	在.vimrc 中搜索 space key_mappings
##### 与vim保存退出等相关原生命令相关的映射，仅仅把空格当成:的作用来映射，后面按键顺序一致，保持一贯的习惯。
	目前这些快捷键都以空格开头，后面加两个字母，或加1个字母和空格，如：
	空格+w+<CR>			保存，即:w<CR>
	空格+wq+<CR>				保存后退出
	原生命令的映射，仅仅改动按:的方式为按空格即可。
##### space 开头插件相关
	空格+t+<CR>				打开terminal.<CR> 可以避免因有其他<space>t开头的按键引起的慢
	空格+td+<CR>			打开termdebug. <CR> 同样可以避免慢


	这样设计是为了保持3个按键，使得space开头的快捷键尽可能多。并且空格键不需要移动手指，也方便快捷。
#### 其他方便的快捷键{{{3
	插入模式快速按 js 		切换到normal 模式并保存 
	插入模式快速按 jk 		切换到normal 模式不并保存,因为有时切入normal模式是为了按u恢复

#### F1~F12相关快捷键 {{{3

##### 普通模式下：  
	
	F1    帮助:GNOME Terminal Manual
	F2       
	,F2    tagbar开关   
	F4   NERDTree开关
	,F4    VimExplorer开关
	F3    打开MRU,在路径列表中，光标在工程名处按shift+*,高亮相应工程，便于选择;
	      :q  退出MRU
	,m    按,m后，将在终端复制的项目名粘贴到底行，按回车后打开MRU，文件路径匹配输入的项目名  
	( Ctrl+F1 ~ Ctrl+F4不可用 )

	F5      
	Ctrl+F5 UndotreeToggle  
	,F5   在底行//gj的双斜杠中间输入要查找的关键字，用vimgrep在当前文件父目录下的.c和.h中搜索//中输入的关键字  
	F6    用vimgrep在当前文件父目录下的.c和.h中搜索光标所在的单词    
	Ctrl+F6    用vimgrep在状态行显示的相对路径父目录下.c和.h中递归搜索光标所在的单词  
	,F6    用vimgrep在底行输入的路径文件中搜索光标所在的单词  
	F7
	F8    
	Ctrl+F8 

	F9    在kernel/目录或linux-stable/目录下，生成arm平台的tags和cscope数据库；  
	      否则，通用，生成及tags和cscope数据库  
	Ctrl+F9	  实现递归查找上级目录中的ctags和cscope并自动载入，向上查找包含当前目录在内的5级目录  
	( F10/F11系统占用 )  
	Ctrl+F10   
	Ctrl+F11   
	F12        
	Ctrl+F12   


#### 说明：{{{2
	1)修改源码时，自动补全依赖于tags，需要在源码kernel 和 uboot目录下分别生成tags文件；


## 四、vim插件使用说明 {{{1
	有些插件的快捷键，可以到.vimrc中搜索插件名在设置的地方或key-mappings的地方找快捷键，
		<leader> 映射成,
[plugin instructions](https://github.com/sky8336/skyVim/my_help/plugin_instructions.md)
## vim Usage: 使用习惯及场景应用 -- 快速使用{{{1   

### vim 窗口中操作:  

#### 源码跟踪：{{{2
	见 1、tags.o.fn、tags和cscope生成及使用方法  

	cscope
	ctags  

	函数调用视图: CCTree  
	ctrl-\+F9  
	ctrl-\+<	调用函数  

#### 源码预览{{{2

#### 查找文件{{{2
	1.cscope 查找:  
		查找并打开文件(打开头文件)		  ,sf ,vf    
		底行输入要查找的文件(支持正则)    ,ff    

		查找包含本文件的文件			  ,si ,vi   
		底行输入查找包含本文件的文件  	  ,ff    
	2.ctrlP 查找：  
		模糊查找  crtl+p  
	3.
	4.MRU 查找： 
		最近打开文件列表 F3  
	5.BufExplorer 查找:  
		打开过的buf  ,bv  
	6.利用NERDTree查找  
		不记得文件名查找  

	7.tabf查找:  
		查找当前目录文件并用标签打开    :tabf xxx  

#### 查找字符串{{{2
	1.cscope 查找：  
		查找指定的字符串	,st	 
		查找字符串			,se  
	2.vimgrep 查找:  
		在当前文件父目录下的.c和.h中搜索光标所在的单词    				F6  
		在状态行显示的相对路径父目录下.c和.h中递归搜索光标所在的单词    Ctrl+F6  
		在底行输入指定路径path/*.c 搜索                                 ,F6  
		在当前文件父目录下的.c和.h中搜索//gj双斜杠中填写的关键字 		Ctrl-\+F6   


#### 查找变量和函数{{{2
	1.cscope 正则查找  
		正则查找变量或函数    ,fe pattern   
	2.cscope 查找:  
		,sc  
		,sd  
		,sg  
		,ss  
	3.vimgrep 查找:  
	    见查找字符串  
#### 窗口布局 | 多文件编辑{{{2
	1.窗口分割：  
		sp  
		vsp  
	2.多标签切换  
		:tabnew filename  
		:tabs  显示已打开标签页列表，> 标识当前页， +标识已更改的页面  
		:tabdo 同时在多个标签页中执行命令  
		:tabdo %s/food/drink/g 一次完成对所有文件的替换操作  

	3.bufexplorer使用  
		,bv  

### vim 与终端交互 | 执行bash 命令 
		vim 和终端切换: ctrl+z  <--> fg  

	在终端直接查找:  
		vi -t 变量或函数名  
		Man xxx  

ga命令可以查看，当前光标所在位置的字符的编码，将显示在屏幕下方。（参见：h ga）

### 复制粘贴问题{{{2  
#### 复制  
	,mv -> 鼠标选中 -> 鼠标右键copy  
	,mv 是:set mouse=v 的映射，visual mode 可以用鼠标复制，可以需要复制的时候，切换成visual mode,   
	复制完后，再通过,ma 切换成鼠标模式；  此时可复制状态栏上的文件名等信息

### 粘贴：  
	当粘贴时，有时会文本乱掉，不能保持原来的格式， 通过设置paste模式后再粘贴，可以保持格式不乱。  
	即,p 后粘贴；粘贴完后,np 退出粘贴模式。  

#### 单独按g+ctrl+a，命令行会现实ascii码和hex值  

### 文本对象 {{{2
#### textobject

文本对象, 是进行快速编辑的基础秘诀. 将一个单词, 句子, 段落当成一个对象看待, 可以进行快速选中/替换/删除等操作

有一篇文章解释得很清楚 Vim Text Objects: The Definitive Guide:
<https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/>

##### 简单说明

命令格式:  操作+范围+对象

##### 对象

w  -  word单词
s  -  sentence句子
p  -  paragraph段落
' " ) ] } > 等成对的
t  -  Tag标签

##### 范围

i  -  在里面
a  -  所有, 包括成对的引号等

##### 操作

d  -  删除
v  -  选中
c  -  替换

例子, |代表光标位置

123(a|bc)456

di)   删除引号内的内容   => 123()456
da)   删除引号内容, 包括引号  => 123456
vi)   选中引号内内容 abc
....

#### textobject增强

vim自带了很多文本对象, 但是还可以进一步增强, 例如, 以行l(line)/以文件e(entire file)/以缩进i(indent)

在 k-vim 中, 加了如下的几个文本对象, 这样, 在写python代码时, 你可以很方便的批量选中同一个缩进里面的所有代码块, 即使代码之间有空行.

" text object
" 支持自定义文本对象
Plug 'kana/vim-textobj-user'
" 增加行文本对象: l   dal yal cil
Plug 'kana/vim-textobj-line'
" 增加文件文本对象: e   dae yae cie
Plug 'kana/vim-textobj-entire'
" 增加缩进文本对象: i   dai yai cii - 相同缩进属于同一块
Plug 'kana/vim-textobj-indent'

### vim原生快捷键 - 备忘 {{{2
	q:		- 	command line
	p		-   复制到光标字符后
	P		-   复制到光标字符前
	
### vim8.1: 新特性{{{1  
#### 1) 支持在 Vim 窗口中运行终端  
		打开	-	<F8> or ,f8 or :vert term
		关闭	-	ctrl+w+q  
		切换	-	ctrl+w+h/j/k/l  
		:help terminal  

##### Opening a vertical terminal in Vim 8.1:  
	You can use the :vert[ical] command modifier:  
	:vert term  
	:vertical works with any command that splits a window, for example:  
	:vert copen  
	:vert help vert  

#### 2) 使用新的终端调试器插件在 Vim 中进行调试  
	用新的终端 debugger 插件在 Vim 内部 debugging. 通过ssh连接进行编辑时，打开其他终端是不可能或不现实的, 
	这时这个功能尤其有用. 在旅行时, 我用它来在Vim中修复项目bug.  

	打开	-	,8f		This opens two windows: gdb window and program window
	关闭	-	ctrl-d  
	切换	-	ctrl+w+h/j/k/l  
	:help termdebug  

	The top-left window runs gdb, you can type any gdb command here.
	The bottom-left window runs the debugged program in its own terminal, so that it does not interfere with gdb commands. 
	On the right a window shows the source code, where all the Vim commands can be used to navigate and make changes.
	A red marker indicates a breakpoint and the currently executed line is highlighted with a blue background.
	A toolbar at the top of the window can be used to step through the code without changing focus.
	A balloon shows information for the symbol under the mouse pointer. 

##### termdebug 模式 - GDB调试  

	加载termdebug插件	-	:packadd termdebug  
	打开termdebug 模式	-	:Termdebug  

	gcc -g  

##### example:  
	command:  
	$ cd vimcfg_bundle/test/gdb_test/short_connection    
	$ make    
	$ vi  
	,8f (vim normal mode)  
	gdb window: pwd  
	(1) gdb window: file tcp_server  
	(2) gdb window: list  
		gdb window: list  
		gdb window: list  
	(3) gdb window: break 20  
		gdb window: break 23  
	(4) gdb window: run  
	(5) source window now shows the tcp_server.c file  
	Let's use the mouse: click on the "Next" button in the window toolbar.  You will see the highlighting move as the  
	debugger executes a line of source code.  



##### 检测到的错误会被捕获并加到一个 quickfix 列表, 因此你可以直接跳转到问题的成因.
	左上窗口运行 gdb, 在这里你可以键入任何 gdb 命令.
	左下窗口在它自己的终端运行 debug 过的程序, 以便它不会干扰 gdb 命令.
	在右侧, 一个窗口显示源代码, 在那里所有 Vim 命令可被用于导航和做改动.
	一个红色记号指示出一个断点, 而当前执行行用蓝色背景高亮.
	在窗口顶部的一个工具条可用于单步调试代码而不改变焦点.
	一个气球（Vim中的弹出窗口——译者注）为在鼠标指针下的符号显示信息.

### git tag
	v1.0.4_release_for_v7.4_v8.0	
	--	这个tag之前的配置，在vim7.4及vim8.0上测试过。这个tag之后的版本，主要在vim8.1上测试。
