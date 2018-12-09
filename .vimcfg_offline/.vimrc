" .vimrc - Vim configuration file.
"
" Copyright (c) 2013 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2013-07-01
" LastChange: 2018-03-15
"    Version: v0.7.8-offline
" major.minor.patch-build.desc (linux kernel format)
"""""""""""""""""""""""""""""""""""""""""""""""""""""


" GENERAL SETTINGS: {{{1
" To use VIM settings, out of VI compatible mode.{{{2
set nocompatible
" Enable file type detection.{{{2
" filetype plugin indent on
filetype on
" Syntax highlighting.{{{2
syntax enable
syntax on

" Setting colorscheme{{{2
color mycolor
"colorscheme nslib_color256

" Other settings.{{{2
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start
set   nobackup
set   cindent
set   cinoptions=:0
set   cursorline
set   completeopt=longest,menuone
set   noexpandtab
set   fileencodings=utf-8,gb2312,gbk,gb18030
set   fileformat=unix
set   foldenable
set   foldmethod=marker
set   guioptions-=T
set   guioptions-=m
set   guioptions-=r
set   guioptions-=l
set   helpheight=10
set   helplang=cn
set   hidden
set   history=100
set   hlsearch
set   ignorecase
set   incsearch
set   laststatus=2 "show the status line
set   statusline+=[%1*%M%*%-.2n]%.62f%h%r%=\[%-4.(%P:%LL,%c]%<%{fugitive#statusline()}\[%Y\|%{&fenc}\]%)
set   mouse=v
set   number
set   pumheight=10
set   ruler
set   scrolloff=2
set   shiftwidth=4
set   showcmd
set   smartindent
set   smartcase
set   tabstop=4
set   termencoding=utf-8
set   textwidth=80
set   whichwrap=h,l
set   wildignore=*.bak,*.o,*.e,*~
set   wildmenu
set   wildmode=list:longest,full
set wrap
set t_Co=256


" AUTO COMMANDS: {{{1
" auto expand tab to blanks
"autocmd FileType c,cpp set expandtab
" Restore the last quit position when open file.{{{2
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" create file settings{{{2
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py exec ":call SetTitle()"
func SetTitle()
	if expand("%:e") == 'sh'
		call setline(1,"\#!/bin/bash")
		call append(line("."), "")
    elseif expand("%:e") == 'py'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "")
    elseif expand("%:e") == 'cpp'
		call setline(1,"#include <iostream>")
		call append(line("."), "")
    elseif expand("%:e") == 'cc'
		call setline(1,"#include <iostream>")
		call append(line("."), "")
    elseif expand("%:e") == 'c'
		call setline(1,"#include <stdio.h>")
		call append(line("."), "")
    elseif expand("%:e") == 'h'
		call setline(1, "#ifndef _".toupper(expand("%:r"))."_H")
		call setline(2, "#define _".toupper(expand("%:r"))."_H")
		call setline(3, "#endif")
    elseif expand("%:e") == 'hpp'
		call setline(1, "#ifndef _".toupper(expand("%:r"))."_H")
		call setline(2, "#define _".toupper(expand("%:r"))."_H")
		call setline(3, "#endif")
	endif
endfunc
autocmd BufNewFile * normal G

" some function definition: {{{1

" set statusline color {{{2
" default the statusline to White (black character) when entering Vim
hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
" 状态栏颜色配置:插入模式品红色，普通模式White
if version >= 700
  "au InsertEnter * hi StatusLine term=reverse ctermbg=3 gui=undercurl guisp=Magenta
  au InsertEnter * hi StatusLine term=reverse ctermfg=DarkMagenta ctermbg=Black gui=undercurl guisp=Magenta
  au InsertLeave * hi StatusLine term=reverse ctermfg=White ctermbg=Black gui=bold,reverse
endif

"" 获取当前路径，将$HOME转化为~,for statusline {{{2
"function! CurDir()
	"let curdir = substitute(getcwd(), $HOME, "~", "g")
	"return curdir
"endfunction

" show function names in command line{{{2
fun! ShowFuncName()
	let lnum = line(".")
	let col = col(".")
	echohl ModeMsg
	echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
	echohl None
	call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map \ :call ShowFuncName()<CR>

""vim窗口的最上面显示当前打开文件的路径和文件名{{{2
"let &titlestring = expand("%:t")
"if &term == "screen"
	"set t_ts=^[k
	"set t_fs=^[\
"endif
"if &term == "screen" || &term == "xterm"
	"set title
"endif
""如果把上面代码中的expand("%:p")换成expand("%:t")将不显示路径只显示文件名。

" 生成tags.fn,tags,cscope数据库: 当前目录为kernel或linux-stable,生成kernel中arm平台的tags和cscope，否则正常生成tags和cscope {{{2
fu! Generate_fntags_tags_cscope()
	if getcwd() == $HOME
		let Msg = "$HOME cannot generate tags.fn tags and cscope.out !"
		echo Msg . '  done !'
		return
	endif
	call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")
    if fnamemodify(expand(getcwd()), ':t:gs?\\?\?') == 'kernel' || fnamemodify(expand(getcwd()), ':t:gs?\\?\?') == 'linux-stable'
        call RunShell("Generate kernel tags and cscope (use 'make')", "make tags ARCH=arm && make cscope ARCH=arm")
    else
		"生成专用于c/c++的ctags文件
        call RunShell("Generate tags (use ctags)", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")
        call RunShell("Generate cscope (use cscope)", "cscope -Rbq -P " . getcwd())
        cs add cscope.out
    endif
    q
endf

" 实现递归查找上级目录中的ctags和cscope并自动载入 {{{2
function! AutoLoadCTagsAndCScope()
    let max = 7
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'cscope.out')
            execute 'cs add ' . dir . 'cscope.out'
            let break = 1
        endif
        if filereadable(dir . 'tags')
            execute 'set tags =' . dir . 'tags'
            let break = 1
        endif
        if break == 1
            "execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf

" cscope add {{{2
if has("cscope")
	set csre
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
	else
		call AutoLoadCTagsAndCScope()
    endif
    set csverb
endif

" SHORTCUT SETTINGS: {{{1
" Set mapleader
let mapleader=","

" Space to command mode. {{{2
nnoremap <space> :
vnoremap <space> :

" Delete key {{{2
nnoremap <C-d> <DELETE>
inoremap <C-d> <DELETE>

" Switching between buffers. {{{2
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l
" switch to normal
inoremap jk <Esc>

" insert mode 光标移动 {{{2
" alt + k 插入模式下光标向上移动
imap k <Up>
" alt + j 插入模式下光标向下移动
imap j <Down>
" alt + h 插入模式下光标向左移动
imap h <Left>
" alt + l 插入模式下光标向右移动
imap l <Right>
"}}}

" "cd" to change to open directory.{{{2
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>


" vundle.vim 插件管理器 {{{1
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on     " required!
" let Vundle manage Vundle     "required!{{{2
Bundle 'gmarik/vundle'

" My Bundles here:  /* 插件配置格式 */{{{2
" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
"Bundle 'ervandew/supertab'
Bundle 'msanders/snipmate.vim'
Bundle 'tpope/vim-surround'
"Plugin 'Valloric/YouCompleteMe'
"Bundle 'Shougo/neocomplete.vim'
Bundle 'majutsushi/tagbar'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'kien/ctrlp.vim'
Bundle 'tacahiroy/ctrlp-funky'
Bundle 'mbbill/VimExplorer',{'on': 'VE'}
"Bundle 'wesleyche/SrcExpl'
"Bundle 'wesleyche/Trinity'
Bundle 'hari-rangarajan/CCTree'
Bundle 'vimplugin/project.vim'
Bundle 'will133/vim-dirdiff'
Bundle 'mbbill/undotree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-unimpaired'
Bundle 'oplatek/Conque-Shell'
"Bundle  'bling/vim-airline'
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'Xuyuanp/nerdtree-git-plugin'

" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）{{{2
"Bundle 'L9'
"Bundle 'FuzzyFinder'
Bundle 'AutoComplPop'
Bundle 'OmniCppComplete'
Bundle 'echofunc.vim'
Bundle 'genutils'
Bundle 'lookupfile'
Bundle 'taglist.vim'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'mru.vim'
Bundle 'ZoomWin'
"Bundle 'winmanager'
"Bundle 'c.vim'
Bundle 'gitv'
Bundle 'DrawIt'
"Bundle 'gdbmgr'

" non github repos   (非上面两种情况的，按下面格式填写){{{2
"Bundle 'git://git.wincent.com/command-t.git'

" vundle setup end


" PLUGIN SETTINGS: {{{1

" tagbar.vim {{{2
let g:tagbar_left=1
let g:tagbar_ctags_bin='ctags'           "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()
endif

" taglist.vim {{{2
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1 "如果taglist窗口是最后一个窗口，则退出vim
let g:Tlist_Show_One_File=1 "不同时显示多个文件的tag，只显示当前文件的
let g:Tlist_WinWidth=30
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
let Tlist_Use_Right_Window = 0
if &diff == 0
	"去掉注释:vi时自动打开，vimdiff不自动打开;taglist的自动打开不影响vi a.c +20定位
	let g:Tlist_Auto_Open=1
endif

"" 设置winmanager.vim {{{2
"" 窗口布局，BufExplorer和FileExplorer共用一个窗口，CTRL+N切换
""let g:winManagerWindowLayout = "TagList|FileExplorer,BufExplorer"
"let g:winManagerWindowLayout = "TagList|BufExplorer,FileExplorer"
"" 0表示主编辑区在窗口右边，1则相反
"let g:defaultExplorer = 0
"let g:bufExplorerMaxHeight=60
"let g:bufExplorerMinHeight=60
"" 保证miniBufExplorer在一个文件时，仍旧保证窗口大小
""let g:miniBufExplorerMoreThanOne = 0
""设置winmanager的宽度，默认为25
"let g:winManagerWidth = 30
"nmap <C-W><C-F> :FirstExplorerWindow<cr>
"nmap <C-W><C-B> :BottomExplorerWindow<cr>
""在进入vim时自动打开winmanager
"let g:AutoOpenWinManager = 1
""}}}

""alrLine Config {{{2
"if !exists('g:airline_symbols')
	"let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
"let g:airline_exclude_filename = []
"let g:Powerline_symbols='fancy'
"let g:airline_powerline_fonts=0
"let Powerline_symbols='fancy'
"let g:bufferline_echo=0
"set laststatus=2
"set t_Co=256
""set fillchars+=stl:\ ,stlnc:\
"set guifont=Lucida_Console:h10

" CCtree {{{2
let g:CCTreeKeyTraceForwardTree = '<C-\>>' "the symbol in current cursor's forward tree
let g:CCTreeKeyTraceReverseTree = '<C-\><'
let g:CCTreeKeyHilightTree = '<C-\>l' " Static highlighting
let g:CCTreeKeySaveWindow = '<C-\>y'
let g:CCTreeKeyToggleWindow = '<C-\>w'
let g:CCTreeKeyCompressTree = 'zs' " Compress call-tree
let g:CCTreeKeyDepthPlus = '<C-\>='
let g:CCTreeKeyDepthMinus = '<C-\>-'
let CCTreeJoinProgCmd = 'PROG_JOIN JOIN_OPT IN_FILES > OUT_FILE'
let  g:CCTreeJoinProg = 'cat'
let  g:CCTreeJoinProgOpts = ""
"let g:CCTreeUseUTF8Symbols = 1
"map <F7> :CCTreeLoadXRefDBFromDisk $CCTREE_DB<cr>

"let g:CCTreeCscopeDb = "cscope.out"
"let g:CCTreeRecursiveDepth = 3
"let g:CCTreeMinVisibleDepth = 3

" NERDTree.vim {{{2
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=30
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0   "目录箭头: 1显示箭头  0传统+-|号
let g:NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 忽略以下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
"autocmd vimenter * NERDTree "打开vim时自动打开NERDTree
" NERDTree是最后一个窗口，它自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"  vim-nerdtree-tabs.vim {{{2
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=0
" always focus file window after startup
let g:nerdtree_tabs_smart_startup_focus=2
"let g:nerdtree_tabs_focus_on_files=1
"let g:nerdtree_tabs_autofind=1

" nerdtree-git-plugin.vim {{{2
" NERDTreeShowGitStatus 为0，不加载git信息;为1,加载，引起打开vim慢（甚至十几秒）
let g:NERDTreeShowGitStatus = 0
let g:NERDTreeIndicatorMapCustom = {
			\ "Modified"  : "✹",
			\ "Staged"    : "✚",
			\ "Untracked" : "✭",
			\ "Renamed"   : "➜",
			\ "Unmerged"  : "═",
			\ "Deleted"   : "✖",
			\ "Dirty"     : "✗",
			\ "Clean"     : "✔︎",
			\ "Unknown"   : "?"
			\ }


"" YCM {{{2
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_error_symbol = '>>'
"let g:ycm_warning_symbol = '>*'
"let g:ycm_seed_identifiers_with_syntax = 1
"let g:ycm_complete_in_comments = 1
"let g:ycm_complete_in_strings = 1
""let g:ycm_cache_omnifunc = 0
"nnoremap <leader>u :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>i :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>o :YcmCompleter GoToInclude<CR>
"nmap <F5> :YcmDiags<CR>

"" ctags
""set tags+=/usr/include/tags
""set tags+=~/.vim/systags
""set tags+=~/.vim/x86_64-linux-gnu-systags
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_semantic_triggers = {}
"let g:ycm_semantic_triggers.c = ['->', '.', ' ', '(', '[', '&',']']
""}}}

" OmniCppComplete.vim {{{2
"set nocp
"filetype plugin on
set completeopt=menu,menuone
let OmniCpp_MayCompleteDot=1    " 打开  . 操作符
let OmniCpp_MayCompleteArrow=1  " 打开 -> 操作符
let OmniCpp_MayCompleteScope=1  " 打开 :: 操作符
let OmniCpp_NamespaceSearch=1   " 打开命名空间
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_DefaultNamespace=["std"]
let OmniCpp_ShowPrototypeInAbbr=1    " 打开显示函数原型
let OmniCpp_SelectFirstItem = 2      " 自动弹出时自动跳至第一个

" configure syntastic syntax checking to check on open as well as save{{{2
let g:syntastic_mode_map = {
			\ "mode": "passive",
			\ "active_filetypes": ["ruby", "php"],
			\ "passive_filetypes": ["puppet"] }
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" VimGDB.vim {{{2
if has("gdb")
	set asm=0
	let g:vimgdb_debug_file=""
	run macros/gdb_mappings.vim
endif

" MRU.vim {{{2
nmap  <leader>m :MRU

" LookupFile setting {{{2
let g:LookupFile_TagExpr='"./tags.o.fn"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0

" undotree.vim {{{2
let g:undotree_WindowLayout = 2

" BufExplorer.vim 其中有默认配置 {{{2
"let g:bufExplorerDefaultHelp=0       " Do not show default help.
"let g:bufExplorerShowRelativePath=1  " Show relative paths.
"let g:bufExplorerSortBy='mru'        " Sort by most recently used.
"let g:bufExplorerSplitRight=0        " Split left.
"let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
"let g:bufExplorerUseCurrentWindow=1  " Open in new window.
"<Leader>be　　全屏方式打来 buffer 列表。
"<Leader>bs　　水平窗口打来 buffer 列表。
"<Leader>bv　　垂直窗口打开 buffer 列表。

"" srcexpl.vim {{{2
"" // The switch of the Source Explorer
"nmap <C-F12> :SrcExplToggle<CR>

"" // Set the height of Source Explorer window
"let g:SrcExpl_winHeight = 8

"" // Set 100 ms for refreshing the Source Explorer
"let g:SrcExpl_refreshTime = 100

"" // Set "Enter" key to jump into the exact definition context
"let g:SrcExpl_jumpKey = "<ENTER>"

"" // Set "Space" key for back from the definition context
"let g:SrcExpl_gobackKey = "<SPACE>"

"" // In order to avoid conflicts, the Source Explorer should know what plugins
"" // except itself are using buffers. And you need add their buffer names into
"" // below listaccording to the command ":buffers!"
"let g:SrcExpl_pluginList = [
			"\ "__Tag_List__",
			"\ "_NERD_tree_"
			"\ ]

"" // Enable/Disable the local definition searching, and note that this is not
"" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
"" // It only searches for a match with the keyword according to command 'gd'
"let g:SrcExpl_searchLocalDef = 1

"" // Do not let the Source Explorer update the tags file when opening
"let g:SrcExpl_isUpdateTags = 0

"" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
"" // create/update a tags file
"let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

"" // Set "<F12>" key for updating the tags file artificially
""let g:SrcExpl_updateTagsKey = "<F12>"

"" // Set "<F7>" key for displaying the previous definition in the jump list
""let g:SrcExpl_prevDefKey = "<F7>"

"" // Set "<F8>" key for displaying the next definition in the jump list
"定义打开关闭winmanager快捷键为F8
"let g:SrcExpl_nextDefKey = "<F8>"
""}}}

"" trinity.vim {{{
"" Open and close all the three plugins on the same time
"nmap <F12>   :TrinityToggleAll<CR>

"" Open and close the srcexpl.vim separately
"nmap <C-F12>   :TrinityToggleSourceExplorer<CR>

"" Open and close the taglist.vim separately
"nmap <C-F10>  :TrinityToggleTagList<CR>

"" Open and close the NERD_tree.vim separately
"nmap <C-F11>  :TrinityToggleNERDTree<CR>


" ctrlp.vim {{{2
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'a'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll)$',
			\ 'link': 'some_bad_symbolic_links',
			\ }
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

" ctrlp-funky.vim
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']

" Man.vim {{{2
source $VIMRUNTIME/ftplugin/man.vim

" snipMate {{{2
let g:snips_author="Du Jianfeng"
let g:snips_email="cmdxiaoha@163.com"
let g:snips_copyright="SicMicro, Inc"

" Conque-Shell.vim {{{2
" 水平分割出一个bash
nnoremap <C-\>b :ConqueTermSplit bash<CR><CR>
" 垂直分割出bash
nnoremap <C-\>vb :ConqueTermVSplit bash<CR><CR>
" 在tab中打开一个bash
nnoremap <C-\>t :ConqueTermTab bash<CR><CR>
" F9:将选中的文本，发送到Conque-Shell的交互程序中

" vimdiff hot keys {{{2
" if you know the buffer number, you can use hot key like ",2"
" (press comma first, then press two as quickly as possible) to
" pull change from buffer number two.set up hot keys:
map <silent><leader>1 :diffget 1<CR>:diffupdate<CR>
map <silent><leader>2 :diffget 2<CR>:diffupdate<CR>
map <silent><leader>3 :diffget 3<CR>:diffupdate<CR>
map <silent><leader>4 :diffget 4<CR>:diffupdate<CR>

" dirdiff.vim {{{2
let g:DirDiffExcludes = "CVS,*.class,*.o"
let g:DirDiffIgnore = "Id:"
" ignore white space in diff
let g:DirDiffAddArgs = "-w"
let g:DirDiffEnableMappings = 1

" project.vim {{{2
" Project1.4.1插件设置
" 切换打开和关闭project窗口
nmap <silent><Leader>t <Plug>ToggleProject
" 插件项目窗口宽度. 默认值: 24
"let g:proj_window_width=24 "//当按空格键 <space> 或者单击鼠标左键/<LeftMouse>时项目窗口宽度增加量,默认值:100
let g:proj_window_increment=24
let g:proj_flags='i' "当选择打开一个文件时会在命令行显示文件名和当前工作路径.
let g:proj_flags='m' "在常规模式下开启 |CTRL-W_o| 和 |CTRL-W_CTRL_O| 映射, 使得当>前缓冲区成为唯一可见的缓冲区, 但是项目窗口仍然可见.
let g:proj_flags='s' "开启语法高亮.
let g:proj_flags='t' "用按 <space> 进行窗口加宽.
let g:proj_flags='c' "设置后, 在项目窗口中打开文件后会自动关闭项目窗口.
let g:proj_flags='F' "显示浮动项目窗口. 关闭窗口的自动调整大小和窗口替换.
let g:proj_flags='L' "自动根据CD设置切换目录.
let g:proj_flags='n' "显示行号.
let g:proj_flags='S' "启用排序.
let g:proj_flags='T' "子项目的折叠在更新时会紧跟在当前折叠下方显示(而不是其底部).
let g:proj_flags='v' "设置后将, 按 /G 搜索时用 :vimgrep 取代 :grep.
let g:proj_run1='!p4 edit %f' "g:proj_run1 ... g:proj_run9 用法.
let g:proj_run3='silent !gvim %f'

" plugin shortcuts {{{2
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

" ZoomWinPlugin.vim {{{2
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

" F2 ~ F12 按键映射 {{{2
nmap  <F2> :TlistToggle<cr>
"nmap  <F2> :WMToggle<cr>
nmap  <leader><F2> :TagbarToggle<CR>
nmap  <F3> :exec 'MRU' expand('%:p:h')<CR>
"nmap  <F4> :NERDTreeToggle<cr>
nmap  <F4> :NERDTreeTabsToggle<cr>
nmap  <C-\><F4> :NERDTreeTabsFind<CR>
nmap  <leader><F4> :silent! VE .<cr>

nmap  <F5> <Plug>LookupFile<cr>
nmap  <C-F5> :UndotreeToggle<cr>
"nmap  <leader><F5> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'
nmap  <F6> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>
nmap  <C-F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:botright cwindow<cr>
nmap  <leader><F6> :vimgrep /<C-R>=expand("<cword>")<cr>/
nmap  <C-\><F6> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'
nmap  <F7> :SyntasticCheck<CR>
nmap  <C-F7> :Errors<CR>
nmap  <leader><F7> :lclose<CR>
"nmap  <F8> :call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")<cr>

nmap  <F9> :call Generate_fntags_tags_cscope()<CR>
nmap <C-F9> :call AutoLoadCTagsAndCScope()<CR>
nmap <C-\><F9> :CCTreeLoadDB cscope.out<CR>
nmap <C-F10> :bn<CR>
nmap <C-F11> :bp<CR>
"<F10> <F11> <F12> 用于Source insight窗口模拟-代码预览;见SrcExpl和trinity(默认不安装，未使用)

" Linux Programmer's Manual
" <C-m> is Enter in quickfix window
nmap <C-\>a :Man <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>2 :Man 2 <C-R>=expand("<cword>")<cr><cr>

"cscope 按键映射及说明 {{{2
nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>


nmap <leader>vs :vert scs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vg :vert scs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vc :vert scs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vt :vert scs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>ve :vert scs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>vf :vert scs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>vi :vert scs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>vd :vert scs find d <C-R>=expand("<cword>")<cr><cr>

nmap <leader>fs :cs find s 
nmap <leader>fg :cs find g 
nmap <leader>fc :cs find c 
nmap <leader>ft :cs find t 
nmap <leader>fe :cs find e 
nmap <leader>ff :cs find f 
nmap <leader>fi :cs find i 
nmap <leader>fd :cs find d 
",sa 添加cscope.out库
",ss 查找c语言符号（函数名 宏 枚举值）出现的地方
",sg 查找函数/宏/枚举等定义的位置，类似ctags的功能
",sc 查找调用本函数的函数
",st 查找字符串
",se 查找egrep模式
",sf 查找并打开文件，类似vim的find功能
",si 查找包含本文件的文件
",sd 查找本函数调用的函数

"其他映射 {{{2
nmap <leader>zz <C-w>o
nmap <leader>hm :tabnew ~/.vim/README.md<cr>
nmap <leader>hd :tabnew ~/.vim/my_help/<cr>
",zz  关闭光标所在窗口之外的其他所有窗口
",hm  tab标签页,打开帮助文档README.md
",hd  tab标签页,打开my_help directory，可选择需要帮助文档

" window-resize {{{2
nmap w= :res +15<CR>
nmap w- :res -15<CR>
nmap w, :vertical res +30<CR>
nmap w. :vertical res -30<CR>

""""""""""""""""""""""""""""""""""""
" {{{2
set noswapfile
set tags+=/usr/include/tags
set tags+=./tags  "引导omnicppcomplete等找到tags文件
"生成专用于c/c++的ctags文件
map ta :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""
"实现vim和终端及gedit等之间复制、粘贴的设置 {{{1
""""""""""""""""""""""""""""""
" 让VIM和ubuntu(X Window)共享一个粘贴板
set clipboard=unnamedplus " 设置vim使用"+寄存器(粘贴板)，"+寄存器是代表ubuntu的粘贴板。
" VIM退出时，运行xsel命令把"+寄存器中的内容保存到系统粘贴板中;需要安装xsel
autocmd VimLeave * call system("xsel -ib", getreg('+'))

""""""""""""""""""""""""""""""
" 编辑文件相关配置 {{{1
""""""""""""""""""""""""""""""
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>

" 删除行尾空格
nmap cm :%s/\s\+$//<CR>:noh<CR>

" 转换成utf-8格式
nmap cu :set fileencoding=utf-8<CR>:noh<CR>

" 全部缩进(indent)对齐
nmap ci ggVG=

" 复制全部
nmap cy ggVGy

" open mouse function
nmap <leader>om :set mouse=a<cr>

" 启用每行超过80列的字符提示（背景变black）
highlight MyGroup ctermbg=black guibg=black
au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

" Highlight variable under cursor in Vim
let g:HlUnderCursor=1
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
	let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

	if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
		"exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
		exe exists("g:HlUnderCursor")?g:HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
	else
		"exe 'match IncSearch /\V\<\>/'
		exe 'match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/'
	endif
endfunction
autocmd CursorMoved * call s:HighlightWordUnderCursor()
" define a shortcut key for enabling/disabling highlighting:
nnoremap  <C-\><F3> :exe "let g:HlUnderCursor=exists(\"g:HlUnderCursor\")?g:HlUnderCursor*-1+1:1"<CR>
