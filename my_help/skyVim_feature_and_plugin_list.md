# skyVim feature and plugin list
- Maintainer: sky8336
-    Created: 2020-01-08
- LastChange: 2020-08-10
-    Version: v0.0.7

## skyVim feature
### 无需插件实现
- [x] 多窗口跳转，自动放大活动窗口
- [x] 括号自动匹配, 满足多数情况使用需求:`', ", (, [, {, <`
- [x] 自动高亮光标所在变量
- [x] 多窗口，只有当前窗口所在行有下划线，非活动窗口无下划线且行号灰色
- [x] insert模式，绝对行号，当前行行号蓝色粗体，其余灰色
  [x] normal模式，相对行号, 当前行行号黄色粗体，其余灰色
- [x] normal/insert 模式下：ctrl+h/j/k/l 在多窗口间跳转
- [x] 插入模式:  jk 快速推出到normal模式并保存
- [x] 80列处红色边界，提醒代码长度
- [x] 自动添加文件头, 支持shell, python, c/cpp/cc/h 文件
  - [x] 添加的头的Filename, LastChange, Version 可以用快捷键更新
    - [ ] TODO: .vimrc title version 自动更新
- [ ] TODO: vim 按ESC 推出插入模式后，自动切换成英文输入法

### 借助插件实现的feature
- [x] ESC 也退出insert 模式，并保存
- [x] 保存时，自动去行尾空格
- [x] 浏览代码时，红色高亮空格和tab键混合的缩进
- [x] 代码跟踪: ctags 和cscope
- [x] 代码补全:
- [x] 代码片段补全
- [x] 脚本 repl 执行环境
- [x] 代码格式化
- [x] Tagbar
- [x] NerdTree
- [x] 多光标编辑
- [x] 画图: DrawIt
- [x] vim-surround
- [x] 注释
- [x] 英文翻译
- [x] markdown 文件通过firefox 预览
- [x] 模糊搜索
- [x] vim-gitgutter
- [x] 弹出热键说明: vim-which-key
- [x] vim-preview: `<F4>`, `,f4`

## todo
1. 按u后，回退到上一个命令，自动保存?
2. 异步语法检查和异步make: 
  - neomake
3. cscope 自动更新？ 或gtag替换？
4. 异步补全框架: 
  - deoplete.nvim
  - YCM
  - coc
  - ncm2
  - asyncomplete
  - neocomplcache
5. vim中快速搜索
6. fuzzy finder
  - leaderf
  - coc
7. popup

## buglist
1. 目前的tagbar 自动打开方式，会导致 vi -O 不能打开两个不同的文件;
	会导致vi a.c +255 不能定位到指定行.

2. sudo ./update.sh 会影响vimcfg_bundle中的git commit -s, 因为sudo 执行了git
pull
3. 经常按某些按键进入debug mode, 即在底行出现以`<` 开始的输入行
  - 需要输入`<finish` 推出


## 插件列表 plugin_list
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


