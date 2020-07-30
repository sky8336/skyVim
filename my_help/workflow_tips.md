# workflow tips
- LastChange: 2020-07-30
-    Version: V0.0.9

## vim 窗口中操作:  

### 源码跟踪：{{{1
	见 1、tags.o.fn、tags和cscope生成及使用方法  

	cscope
	ctags  

	函数调用视图: CCTree  
	ctrl-\+F9  
	ctrl-\+<	调用函数  

### 源码预览{{{1

### 查找文件{{{1
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

### 查找字符串{{{1
	1.cscope 查找：  
		查找指定的字符串	,st	 
		查找字符串			,se  
	2.vimgrep 查找:  
		在当前文件父目录下的.c和.h中搜索光标所在的单词    				F6  
		在状态行显示的相对路径父目录下.c和.h中递归搜索光标所在的单词    Ctrl+F6  
		在底行输入指定路径path/*.c 搜索                                 ,F6  
		在当前文件父目录下的.c和.h中搜索//gj双斜杠中填写的关键字 		Ctrl-\+F6   


### 查找变量和函数{{{1
	1.cscope 正则查找  
		正则查找变量或函数    ,fe pattern   
	2.cscope 查找:  
		,sc  
		,sd  
		,sg  
		,ss  
	3.vimgrep 查找:  
	    见查找字符串  
### 窗口布局 | 多文件编辑{{{1
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

### vim 与终端交互 | 执行bash 命令  {{{1
		vim 和终端切换: ctrl+z  <--> fg  

	在终端直接查找:  
		vi -t 变量或函数名  
		Man xxx  

ga命令可以查看，当前光标所在位置的字符的编码，将显示在屏幕下方。（参见：h ga）

## 复制粘贴问题{{{1  
### 复制  
	,mv -> 鼠标选中 -> 鼠标右键copy  
	,mv 是:set mouse=v 的映射，visual mode 可以用鼠标复制，可以需要复制的时候，切换成visual mode,   
	复制完后，再通过,ma 切换成鼠标模式；  此时可复制状态栏上的文件名等信息

### 粘贴：  
	当粘贴时，有时会文本乱掉，不能保持原来的格式， 通过设置paste模式后再粘贴，可以保持格式不乱。  
	即,p 后粘贴；粘贴完后,np 退出粘贴模式。  

### 单独按g+ctrl+a，命令行会现实ascii码和hex值  

### `:r !cmd`
写makefile 等文件时，需要复制多个文件名到文件中，可以用`:r !ls 路径`将<br/>
文件名显示到光标所在位置，然后再复制就方便了，也方便检查手敲的文件名是否错误<br/>
(相同名字会高亮)<br/>

:r !ls<br/>

### 文本对象 {{{1
### textobject

文本对象, 是进行快速编辑的基础秘诀. 将一个单词, 句子, 段落当成一个对象看待, 可以进行快速选中/替换/删除等操作

有一篇文章解释得很清楚 Vim Text Objects: The Definitive Guide:
<https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/>

#### 简单说明

命令格式:  操作+范围+对象

#### 对象

w  -  word单词
s  -  sentence句子
p  -  paragraph段落
' " ) ] } > 等成对的
t  -  Tag标签

#### 范围

i  -  在里面
a  -  所有, 包括成对的引号等

#### 操作

d  -  删除
v  -  选中
c  -  替换

例子, |代表光标位置

123(a|bc)456

di)   删除引号内的内容   => 123()456
da)   删除引号内容, 包括引号  => 123456
vi)   选中引号内内容 abc
....

### textobject增强

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

`ciw`, 改写光标所处的单词, 改写后，在下一个单词上按`.`重复上次命令，可多次改写
`cw` 改写光标开始处的当前单词

### vim原生快捷键 - 备忘 {{{1
	q:		- 	command line
	p		-   复制到光标字符后
	P		-   复制到光标字符前
	`:b 文件名` 或 `:b 文件名中部分字母` , 按table键补全，打开buffer
	中的文件(最近打开的文件)
	
`CTRL-W gf`     Open a new tab page and edit the file name under the cursor.
                See CTRL-W_gf.

`CTRL-W gF`     Open a new tab page and edit the file name under the cursor
                and jump to the line number following the file name.
                See CTRL-W_gF.
`{count}gt`       Go to tab page {count}.  The first tab page has number one.

## vim8.1: 新特性{{{1  
### 1) 支持在 Vim 窗口中运行终端  
		打开	-	<F8> or ,f8 or :vert term
		关闭	-	ctrl+w+q  
		切换	-	ctrl+w+h/j/k/l  
		:help terminal  

#### Opening a vertical terminal in Vim 8.1:  
	You can use the :vert[ical] command modifier:  
	:vert term  
	:vertical works with any command that splits a window, for example:  
	:vert copen  
	:vert help vert  

### 2) 使用新的终端调试器插件在 Vim 中进行调试  
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

#### termdebug 模式 - GDB调试  

	加载termdebug插件	-	:packadd termdebug  
	打开termdebug 模式	-	:Termdebug  

	gcc -g  

#### example:  
	command:  
	```
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
	Let's use the mouse: click on the "Next" button in the window toolbar.  
	You will see the highlighting move as the  
	debugger executes a line of source code.  
	```



#### 检测到的错误会被捕获并加到一个 quickfix 列表, 因此你可以直接跳转到问题的成因.
	左上窗口运行 gdb, 在这里你可以键入任何 gdb 命令.
	左下窗口在它自己的终端运行 debug 过的程序, 以便它不会干扰 gdb 命令.
	在右侧, 一个窗口显示源代码, 在那里所有 Vim 命令可被用于导航和做改动.
	一个红色记号指示出一个断点, 而当前执行行用蓝色背景高亮.
	在窗口顶部的一个工具条可用于单步调试代码而不改变焦点.
	一个气球（Vim中的弹出窗口——译者注）为在鼠标指针下的符号显示信息.

## tools {{{1
- hs 共享当前目录，可以通过web打开来下载文件.
- mhs 共享当前目录，可以通过web打开来上传或下载文件

具体:<br/>
在要共享的目录下输入hs或mhs，在浏览器地址栏输入 `your_ip:8000`,<br/>
即可下载，或上传文件<br/>
如果关闭共享，可以fg后，按ctrl+c 中断hs或mhs起的httpserver<br/>

## git tag {{{1
	v1.0.4_release_for_v7.4_v8.0	
	--	这个tag之前的配置，在vim7.4及vim8.0上测试过。这个tag之后的版本，主要在vim8.1上测试j

## man {{{1
### man Page中查找C++函数
http://www.cplusplus.com/info/ <br/>
man 命名空间::头文件<br/>
通常地: <br/>
- man std::头文件
- man std::函数名
- man std::类名
如，查找std::cout 函数，需要现查找man std::iostream，再找到cout函数

## 其他快捷键
,hp: 查看当前行和git 暂存之间的改动
-: 已打开过的文件的buffer

## help
```shell
nmap <space>hm :tabnew ~/.vim/README.md<cr>
nmap <space>hd :tabnew ~/.vim/my_help/<cr>
nmap <space>hu :tabnew ~/.vim/my_help/ubuntu<cr>
nmap <space>hk :tabnew ~/.vim/my_help/key_map.txt<cr>
nmap <space>sn :tabnew ~/.vim/plugged/vim-snippets/snippets/cpp.snippets<cr>
nmap <space>sc :tabnew ~/.vim/plugged/vim-snippets/snippets/c.snippets<cr>
```
## snippet 补全
比如输入switch后，按tab键，补全switch语句。在SELECT模式下直接输入来替换第一个
位置内容，输入完成后按ctrl+j跳到下一个可编辑区域，按ctrl+k跳到上一个可编辑区域
