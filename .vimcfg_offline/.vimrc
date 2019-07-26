" .vimrc - Vim configuration file.
"
" Copyright (c) 2013 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2016-08-19
" LastChange: 2019-07-26
"    Version: v1.1.18-offline
" Plugin_update: 2019-07-26
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
syntax on "syntax highlighting on

filetype plugin on
au BufRead,BufNewFile *.txt setlocal ft=txt "syntax highlight for txt

" Setting colorscheme{{{2
color mycolor
"colorscheme nslib_color256
if &diff
	"colorscheme blue
	"colorscheme default
	"colorscheme murphy
	"colorscheme peachpuff
	"colorscheme ron
	"colorscheme torte
	"colorscheme elflord
	"colorscheme industry
endif

" termdebug setting {{{2
let g:termdebug_wide = 163

" Other settings.{{{2
set autoindent
set autoread
set autowrite
set background=dark
set backspace=indent,eol,start
set nobackup
set cindent " enable specific indenting for C code
set cinoptions=:0
"set cinoptions+=j1,(0,ws,Ws " enable partial c++11 (lambda) support
" Avoiding "visibility" modifiers indenting in C++
" public, namespace,
set cinoptions+=g0,N-s
"set cinoptions+=L0 "tell vim not to de-indent labels
"set cursorcolumn
set cursorline
set completeopt=longest,menuone
set noexpandtab
set fileencodings=utf-8,gb2312,gbk,gb18030
set fileformat=unix
set foldenable
set foldmethod=marker
set guioptions-=T
set guioptions-=m
set guioptions-=r
set guioptions-=l
set helpheight=10
set helplang=cn
set hidden
set history=100
set hlsearch
set ignorecase
set incsearch
set laststatus=2 "show the status line
set statusline+=[%1*%M%*%-.2n]%.62f%h%r%=\[%-4.(%P:%LL,%c]%<%{fugitive#statusline()}\[%Y\|%{&fenc}\]%)
set mouse=a
set number
set rnu
set pumheight=10
set ruler
set scrolloff=2
set shiftwidth=4
set showcmd
set smartindent
set smartcase
set tabstop=4
set termencoding=utf-8
set textwidth=80
set whichwrap=h,l
set wildignore=*.bak,*.o,*.e,*~
set wildmenu
set wildmode=list:longest,full
set wrap
set t_Co=256

" splitting a window will put the new window below the currentone
" splitting a window will put the new window right of the current on
" set splitbelow
" set splitright

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
		call append(0,"\#!/bin/bash")
		call append(1,"#")
		call append(2,"# ".expand("%:t"))
		call append(3,"#")
		call append(4,"# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(5,"#")
		call append(6,"# History:")
		call append(7,"#    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(8,"#")
		call append(9,"# Maintainer: you <your@email.com>")
		call append(10,"#    Created: ".strftime("%Y-%m-%d"))
		call append(11,"# LastChange: ".strftime("%Y-%m-%d"))
		call append(12,"#    Version: v0.0.01")
		call append(13,"#")
    elseif expand("%:e") == 'py'
        call append(0,"#!/usr/bin/env python")
        call append(1,"# coding=utf-8")
		call append(2,"#")
		call append(3,"# ".expand("%:t"))
		call append(4,"#")
		call append(5,"# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(6,"#")
		call append(7,"# History:")
		call append(8,"#    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(9,"#")
		call append(10,"# Maintainer: you <your@email.com>")
		call append(11,"#    Created: ".strftime("%Y-%m-%d"))
		call append(12,"# LastChange: ".strftime("%Y-%m-%d"))
		call append(13,"#    Version: v0.0.01")
		call append(14,"#")
    elseif expand("%:e") == 'cpp'
		call append(0,"/*")
		call append(1," * ".expand("%:t"))
		call append(2," *")
		call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(4," *")
		call append(5," * History:")
		call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(7," *")
		call append(8," * Maintainer: you <your@email.com>")
		call append(9," *    Created: ".strftime("%Y-%m-%d"))
		call append(10," * LastChange: ".strftime("%Y-%m-%d"))
		call append(11," *    Version: v0.0.01")
		call append(12," *")
		call append(13," */")
		call append(14,"#include <iostream>")
		"call append(line("."), "")
    elseif expand("%:e") == 'cc'
		call append(0,"/*")
		call append(1," * ".expand("%:t"))
		call append(2," *")
		call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(4," *")
		call append(5," * History:")
		call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(7," *")
		call append(8," * Maintainer: you <your@email.com>")
		call append(9," *    Created: ".strftime("%Y-%m-%d"))
		call append(10," * LastChange: ".strftime("%Y-%m-%d"))
		call append(11," *    Version: v0.0.01")
		call append(12," *")
		call append(13," */")
		call append(14,"#include <iostream>")
		"call append(line("."), "")
    elseif expand("%:e") == 'c'
		call append(0,"/*")
		call append(1," * ".expand("%:t"))
		call append(2," *")
		call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(4," *")
		call append(5," * History:")
		call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(7," *")
		call append(8," * Maintainer: you <your@email.com>")
		call append(9," *    Created: ".strftime("%Y-%m-%d"))
		call append(10," * LastChange: ".strftime("%Y-%m-%d"))
		call append(11," *    Version: v0.0.01")
		call append(12," *")
		call append(13," */")
		call append(14,"#include <stdio.h>")
		"call append(line("."), "")
    elseif expand("%:e") == 'h'
		call append(0,"/*")
		call append(1," * ".expand("%:t"))
		call append(2," *")
		call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(4," *")
		call append(5," * History:")
		call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(7," *")
		call append(8," * Maintainer: you <your@email.com>")
		call append(9," *    Created: ".strftime("%Y-%m-%d"))
		call append(10," * LastChange: ".strftime("%Y-%m-%d"))
		call append(11," *    Version: v0.0.01")
		call append(12," *")
		call append(13," */")
		"call append(14, "#ifndef _".tr(toupper(expand("%:r")), "/", "_")."_H")
		"call append(15, "#define _".tr(toupper(expand("%:r")), "/", "_")."_H")
		call append(14, "#ifndef _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
		call append(15, "#define _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
		call append(16, "")
		call append(17, "#endif")
    elseif expand("%:e") == 'hpp'
		call append(0,"/*")
		call append(1," * ".expand("%:t"))
		call append(2," *")
		call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
		call append(4," *")
		call append(5," * History:")
		call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
		call append(7," *")
		call append(8," * Maintainer: you <your@email.com>")
		call append(9," *    Created: ".strftime("%Y-%m-%d"))
		call append(10," * LastChange: ".strftime("%Y-%m-%d"))
		call append(11," *    Version: v0.0.01")
		call append(12," *")
		call append(13," */")
		"call append(14, "#ifndef _".tr(toupper(expand("%:r")), "/", "_")."_H")
		"call append(15, "#define _".tr(toupper(expand("%:r")), "/", "_")."_H")
		call append(14, "#ifndef _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
		call append(15, "#define _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
		call append(16, "")
		call append(17, "#endif")
	endif
	echohl WarningMsg | echo "Successful in adding copyright." | echohl None
endfunc
autocmd BufNewFile * normal G

" insert time
ab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>

" some function definition: {{{1
" thanks to http://vimcasts.org/e/4
function! WhitespaceStripTrailing()
	let previous_search=@/
	let previous_cursor_line=line('.')
	let previous_cursor_column=col('.')
	%s/\s\+$//e
	let @/=previous_search
	call cursor(previous_cursor_line, previous_cursor_column)
endfunction

"{{{3 whitespace  去除文件的行尾空白
autocmd BufWritePre     *.py        call WhitespaceStripTrailing()
autocmd BufWritePre     *.h         call WhitespaceStripTrailing()
autocmd BufWritePre     *.c         call WhitespaceStripTrailing()
autocmd BufWritePre     *.cpp       call WhitespaceStripTrailing()
"}}}

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

" SHORTCUT SETTINGS: mappings{{{1
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

if version >= 800
" [>= vim8.0]]terminal mode mappings
tnoremap <C-h> <C-W>h
tnoremap <C-j> <C-W>j
tnoremap <C-k> <C-W>k
tnoremap <C-l> <C-W>l
endif

" 括号自动补全
inoremap '<TAB> ''<ESC>i
inoremap "<TAB> ""<ESC>i
inoremap <<TAB> <><ESC>i
inoremap (<TAB> ()<ESC>i
inoremap [<TAB> []<ESC>i
inoremap {<TAB> {<CR>}<ESC>O

"设置跳出自动补全的括号
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == '>' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
" 将tab键绑定为跳出括号
inoremap jj <c-r>=SkipPair()<CR>


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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin_manager: vundle_setup {{{1
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on     " required!
" let Vundle manage Vundle: vundle.vim 插件管理器     "required!{{{2
Bundle 'gmarik/vundle'

" plugin select config table {{{2
let ubuntu18_04 = 1

" python 3+
if ubuntu18_04 == 1
	" python > 2.7
	let plugin_use_leaderf = 1
	let plugin_use_ultisnips = 1
else
	" ubuntu16.04 maybe python < 2.7
	let plugin_use_leaderf = 0
	let plugin_use_ultisnips = 0
endif

let plugin_use_neomake = 0
let plugin_use_deoplete = 0
let plugin_use_echodoc = 0
let plugin_use_echofunc = 0
let plugin_use_vim_cpp_enhanced_highlight = 0

"-----------------------
" My Bundles here:  {{{2
" https://vimawesome.com/
" original repos on github （Github仓库插件）{{{3

" language {{{3
Bundle 'tpope/vim-fugitive'
if plugin_use_neomake == 1
	Plugin 'neomake/neomake'
else
	Bundle 'scrooloose/syntastic'
endif
Plugin 'tpope/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
" language end

" completion {{{3
"Bundle 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
"Bundle 'Shougo/neocomplete.vim'
"Plugin 'rstacruz/sparkup'
"Bundle 'neoclide/coc.nvim'
if plugin_use_deoplete == 0
	Bundle 'AutoComplPop'
	Bundle 'OmniCppComplete'
endif
if plugin_use_ultisnips == 1
	Bundle 'SirVer/ultisnips'
	Bundle 'honza/vim-snippets'
else
	Bundle 'msanders/snipmate.vim'
endif
if plugin_use_deoplete == 1
	Plugin 'shougo/deoplete.nvim'
endif
Bundle 'taglist.vim'
" completion end

" code_display {{{3
if plugin_use_vim_cpp_enhanced_highlight == 1
Plugin 'octol/vim-cpp-enhanced-highlight'
endif

" integrations {{{3
Plugin 'gregsexton/gitv'
"Bundle 'gitv'
" integrations end

" interface {{{3
if plugin_use_leaderf == 1
	Plugin 'yggdroot/leaderf'
else
	Bundle 'kien/ctrlp.vim'
	Bundle 'tacahiroy/ctrlp-funky'
endif
Bundle 'jlanzarotta/bufexplorer'
Bundle 'airblade/vim-gitgutter'
Bundle 'mbbill/undotree'
"Plugin 'godlygeek/tabular'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'Xuyuanp/nerdtree-git-plugin'
"Bundle 'vim-airline/vim-airline'
"Bundle 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Bundle 'mru.vim'
Bundle 'ZoomWin'
" interface end

" commands {{{3
Bundle 'majutsushi/tagbar'
Bundle 'skywind3000/asyncrun.vim'
Plugin 'tpope/vim-surround'
"Bundle 'FuzzyFinder'
" commands end

" uncategorized {{{3
Bundle 'hari-rangarajan/CCTree'
Bundle 'will133/vim-dirdiff'
Bundle 'tpope/vim-unimpaired'
Bundle 'Stormherz/tablify'
Bundle 'liuchengxu/vim-which-key'
if plugin_use_echodoc == 1
	Plugin 'shougo/echodoc'
endif
if plugin_use_echofunc == 1
	"Bundle 'echofunc.vim'
	Plugin 'mbbill/echofunc'
endif
Bundle 'genutils'
Bundle 'DrawIt'
" uncategorized end

" other {{{3
"Bundle 'L9'
" other end

" plugin_manager: vundle_setup end


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN_SETTINGS begin: {{{1
"
if plugin_use_echofunc == 1
	" echofunc.vim setting {{{2
	"let g:EchoFuncAutoStartBalloonDeclaration=1
endif

if plugin_use_echodoc == 1
	" echodoc setting {{{2
	let g:echodoc#type = "echo" " Default value
	set noshowmode
	let g:echodoc_enable_at_startup = 1
endif

" code_display {{{2

if plugin_use_vim_cpp_enhanced_highlight == 1
	" vim-cpp-enhanced-highlight setting {{{3
	"Highlighting of class scope is disabled by default. To enable set
	let g:cpp_class_scope_highlight = 1

	"Highlighting of member variables is disabled by default. To enable set
	let g:cpp_member_variable_highlight = 1

	"Highlighting of class names in declarations is disabled by default. To enable set
	let g:cpp_class_decl_highlight = 1

	"There are two ways to highlight template functions. Either
	let g:cpp_experimental_simple_template_highlight = 1

	"which works in most cases, but can be a little slow on large files. Alternatively set
	let g:cpp_experimental_template_highlight = 1

	"Highlighting of library concepts is enabled by
	let g:cpp_concepts_highlight = 1

	"This will highlight the keywords concept and requires as well as all named
	"requirements (like DefaultConstructible) in the standard library.
	"Highlighting of user defined functions can be disabled by
	let g:cpp_no_function_highlight = 1

	"Vim tend to a have issues with flagging braces as errors, see for
	"example https://github.com/vim-jp/vim-cpp/issues/16. A workaround is to set
	let c_no_curly_error=1
endif


" tagbar.vim {{{2
let g:tagbar_left=1
let g:tagbar_ctags_bin='ctags'           "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tagbar_show_linenumbers = 2
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	autocmd VimEnter *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.sh,*.py,*.vimrc nested :call tagbar#autoopen(1)
endif

" taglist.vim {{{2
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1 "如果taglist窗口是最后一个窗口，则退出vim
let g:Tlist_Show_One_File=0 "不同时显示多个文件的tag，只显示当前文件的
let g:Tlist_WinWidth=30
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
let Tlist_Use_Right_Window = 0
if &diff == 0
	"去掉注释:vi时自动打开，vimdiff不自动打开;taglist的自动打开不影响vi a.c +20定位
	"let g:Tlist_Auto_Open=1
endif


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
			\ 'Ignored'   : '☒',
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


if plugin_use_deoplete == 0
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
endif


" MRU.vim {{{2
nmap  <leader>m :MRU

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


" interface: leaderf or ctrlp {{{2
if plugin_use_leaderf == 1
	" interface: leaderf {{{3
	let g:Lf_ShortcutF = '<c-p>'
	let g:Lf_ShortcutB = '<m-n>'
	noremap <c-n> :LeaderfMru<cr>
	noremap <m-p> :LeaderfFunction!<cr>
	noremap <m-n> :LeaderfBuffer<cr>
	noremap <m-m> :LeaderfTag<cr>
	let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

	let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
	let g:Lf_WorkingDirectoryMode = 'Ac'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_CacheDirectory = expand('~/.vim/cache')
	let g:Lf_ShowRelativePath = 0
	let g:Lf_HideHelp = 1
	"let g:Lf_StlColorscheme = 'powerline'
	let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
else
	" interface: ctrlp.vim {{{3
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
endif

" Man.vim {{{2
source $VIMRUNTIME/ftplugin/man.vim

if plugin_use_ultisnips == 1
	" utilsnips.vim {{{2
	"autocmd FileType * call UltiSnips#FileTypeChanged()
	" 连续按下两次i触发代码补全
	let g:UltiSnipsExpandTrigger="<tab>"
	"let g:UltiSnipsListSnippets="<c-tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"

else
	" snipMate {{{2
	"let g:snips_author="Du Jianfeng"
	"let g:snips_email="cmdxiaoha@163.com"
	"let g:snips_copyright="SicMicro, Inc"
endif


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

" vim-airline {{{2
"set laststatus=2  "永远显示状态栏
"let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer

" 使用:AirlineTheme {theme-name}设置主题。
" asyncrun {{{2
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 定位到文件所属项目的目录: 从文件所在目录向上递归，直到找到名为 “.git”, “.svn”, “.hg”或者 “.root”文件或者目录
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" PLUGIN_SETTINGS end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 按键映射 {{{1
" F2 ~ F12 按键映射 {{{2
nmap  <leader>f1 :TagbarToggle<CR>

nmap  <F2> :TlistToggle<cr>
nmap  <leader>f2 :TlistToggle<CR>
"nmap  <F2> :WMToggle<cr>

nmap  <F3> :exec 'MRU' expand('%:p:h')<CR>
nmap  <leader>f3 :exec 'MRU' expand('%:p:h')<CR>

"nmap  <F4> :NERDTreeToggle<cr>
nmap  <F4> :NERDTreeTabsToggle<cr>
nmap  <leader>f4 :NERDTreeTabsToggle<cr>

nmap  <C-\><F4> :NERDTreeTabsFind<CR>
nmap  <leader><F4> :silent! VE .<cr>

"------map_f5------
" nmap  <F5>
"
" ,f5 ,;5 ,\5	:	单个文件相关命令
" 设置 ,f5 打开/关闭 Quickfix 窗口
nnoremap <leader>f5 :call asyncrun#quickfix_toggle(6)<cr>
" 编译单个文件
nnoremap <silent><leader>;5 :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 运行
nnoremap <silent><leader>\5 :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" ,5f ,5; ,5\	:	项目相关命令
" “<root>” 或 “$(VIM_ROOT)”表示项目所在路径，按 ,5f 编译整个项目：
nnoremap <silent><leader>5f :AsyncRun -cwd=<root> make <cr>
" 运行当前项目, makefile 中需要定义怎么 run
nnoremap <silent><leader>5; :AsyncRun -cwd=<root> -raw make run <cr>
" 测试
nnoremap <silent><leader>5\ :AsyncRun -cwd=<root> -raw make test <cr>
"------map_f5------

nmap  <C-F5> :UndotreeToggle<cr>
"nmap  <leader><F5> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'

nmap  <F6> :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>
nmap  <leader>f6 :execute 'vimgrep /'.expand('<cword>').'/gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'<CR>:botright cwindow<CR>

nmap  <C-F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:botright cwindow<cr>
nmap  <leader><F6> :vimgrep /<C-R>=expand("<cword>")<cr>/
nmap  <C-\><F6> :execute 'vimgrep //gj '.expand('%:p:h').'/*.c '.expand('%:p:h').'/*.h'

" F7
nmap  <F7> :SyntasticCheck<CR>
nmap  <leader>f7 :SyntasticCheck<CR>

nmap  <C-F7> :Errors<CR>
nmap  <leader><F7> :lclose<CR>

" quickfix
nmap  <leader>7f :botright copen 10<CR>

" F8
nmap  <C-F8> :vert terminal<CR>
nmap  <leader>f8 :vert terminal<CR>
nmap  <leader>8f :packadd termdebug<CR>:Termdebug<CR>

" f9
nmap  <F9> :call Generate_fntags_tags_cscope()<CR>
nmap  <leader>f9 :call Generate_fntags_tags_cscope()<CR>
nmap  <leader>9f :call AutoLoadCTagsAndCScope()<CR>

nmap <C-F9> :call AutoLoadCTagsAndCScope()<CR>
nmap <C-\><F9> :CCTreeLoadDB cscope.out<CR>

" F10
nmap <C-F10> :bn<CR>
" F11
nmap <C-F11> :bp<CR>

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

" set mouse mode, see :help mouse
nmap <leader>ma :set mouse=a<cr>
nmap <leader>mv :set mouse=v<cr>

" set paste mode
nmap <leader>p :set paste<cr>
nmap <leader>np :set nopaste<cr>

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
