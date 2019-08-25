# skyVim - 一键安装超漂亮的vim配置

## About skyVim
vim config for linux devices driver development and C development，C++, python/shell development<br/>

+ 工具就是生产力，打造利器, 提高效率…  
+ 针对vim8.1更新配置...
+ 记得点击右上角star…    

- 适用于linux 内核/驱动开发的vim配置;  
- 适用于c/c++的应用编程的vim配置;  
- 适用于shell/python编程的vim配置;  

## 一 、Install and update {{{1

### install {{{2
第一次安装时，执行install.sh ,以后若更新本配置，执行update.sh快速更新   

`sudo ./install.sh`<br/>
查看帮助, 可跳过其中一些步骤，如果以前安装过.安装package（tools）可能会慢点<br/>
`sudo ./install.sh 0`<br/>
全自动安装vim，相关工具，配置vim， 配置git使用vim编辑<br/>
`sudo ./install.sh 4`<br/>
跳过安装package和vim,适合第二次以后的安装。<br/>

+ 联网情况, 第一次全安装可能几分钟，与网速有关.
+ 不联网情况比较快.

#### 注意：  
- (a)插件更新    
	- 若vim-plug 管理的插件安装不成功，可执行update.sh脚本或手动安装:
	打开vim，底行模式命令：  
		:PlugStatus		查看插件状态
		:PlugInstall
	- 如果仅仅想添加某个插件，或者恢复到之前的某个插件
	  可以通过gitk来查看修改记录，单独安装配置需要的插件即可。 
- (b)配置中，已将vim映射为来vi，用vi打开即等同于vim打开来。
- (c)测试：
        vi a.c  
        输入main后，按tab键看是否成功自动补全。 

### update {{{2
	cd skyVim
	sudo ./update.sh

- 一键更新.vimrc及插件和帮助文件
- 最短耗时不到1分钟，一般很快(3~90s)  

## 二 温馨提示：{{{1
- ubuntu 系统自带vim是vim.tiny，迷你版，.vimrc 有一些命令不支持，不过install.sh会自动安装完整版vim    

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
- 插件管理  
	- vim-plug  插件管理  
- Display tags of a file ordered by scope
	- tagbar  

- tree explorer   
	- NERDTree  
	- vim-nerdtree-tabs	-   NERDTree and tabs together in Vim, painlessly  
	- nerdtree-git-plugin
- 注释
	- The-NERD-Commenter

- 文件管理    
	- VimExplorer  

- 窗口管理  
	- ZoomWinPlugin  窗口缩放插件  

- 最近打开文件  
	- MRU  

- 文件搜索  
	- ctrlP + ctrlp-funky		[x]		<interface>
	- leaderf		<interface>

- Buffer Explorer   
	- bufexplorer  

- 关键词搜索  
	- 用vimgrep搜索光标所在的单词  

- tags 和 cscope 数据库  
	- 生成 tags  
	- 生成 cscope的数据库  

- 代码片段补全
	- UltiSnips + vim-snippets [代替SnipMate]

- 自动补全插件  
	- AutoComplPop + OmniCppComplete  

- C Call-Tree Explorer  
	- CCTree

- 目录和文件比较  
	- DirDiff.vim		- 	run vim-diff on two directories recursively  
	- vimdiff  		-   starting diff mode
	- vim-dirdiff

- git 相关  
	- vim-fugitive
	- vim-gitgutter
	- gitv
-  
	- tpope/vim-surround

- 
	- undotree

- 语法检测
	- syntastic

- Pairs of handy bracket mappings
	- vim-unimpaired

- 表格与画图  
	- tablify 	-   turns simple structured data into nice-looking tables
	- DrawIt
- 
	- asyncrun.vim

- 
	- echofunc.vim	[X 已不用]

- statusline plugin
	- vim-airline<br/>
	- vim-airline-themes<br/>

### statusline 
default statusline in .vimrc (when not use plugin)<br/>
	looks like:
	[+1]build_install_vim.sh                       [61%:339L,0][Git(master)][SH|utf-8]

- 状态栏中表示的信息：
  1. 修改未保存时，红色+,保存后消失；[+1]
  2.  buffer id	[+1]
  3. 文件名
  4.  [所在行占总行数百分比: 总行数,光标在一行的位置]
  5. [git 分支信息]， 不是git仓库时不显示
  6. [文本类型|字符编码类型]
  7. 插入模式颜色品红；normal模式白色；
  8. 分屏时，光标不在的窗口状态栏变灰色；


### 2、快捷键说明 {{{2
[快捷键说明](https://github.com/sky8336/skyVim/blob/master/my_help/key_map.md)<br/>


## 四、vim插件使用说明 {{{1
[plugin instructions](https://github.com/sky8336/skyVim/blob/master/my_help/plugin_instructions.md)

## vim Usage: 使用习惯及场景应用 -- 快速使用{{{1   
[workflow tips](https://github.com/sky8336/skyVim/blob/master/my_help/workflow_tips.md)<br/>
[vim command](https://github.com/sky8336/skyVim/blob/master/my_help/vim_command.md)
