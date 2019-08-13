" .vimrc - Vim configuration file.
"
" Copyright (c) 2013 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2013-06-28
"    Install: online
"------------------------------
" LastChange: 2019-08-12
"    Version: v1.1.39
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
" make backspaces more powerfull
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

" function_definition: {{{1

" plugin shortcuts {{{2
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

function! WhitespaceStripTrailing()
	let previous_search=@/
	let previous_cursor_line=line('.')
	let previous_cursor_column=col('.')
	%s/\s\+$//e
	let @/=previous_search
	call cursor(previous_cursor_line, previous_cursor_column)
endfunction

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
		call RunShell("Generate cscope (use cscope)", "cscope -Rbqk -P " . getcwd())
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

" 设置跳出自动补全的括号 {{{2
func SkipPair()
	if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == '>' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
		return "\<ESC>la"
	else
		return "\t"
	endif
endfunc

" Highlight variable under cursor in Vim {{{3
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

" function_definition end
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT_SETTINGS: mapleader{{{1
" Set mapleader
let mapleader=","
" SHORTCUT_SETTINGS end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin_select config table {{{1
let ubuntu18_04 = 1

" python 3+
if ubuntu18_04 == 1
	" python > 2.7
	let plugin_use_leaderf = 1
	let plugin_use_ultisnips = 1
	let plugin_use_autoformat = 1
	let latex_live_preview = 1
else
	" ubuntu16.04 maybe python < 2.7
	let plugin_use_leaderf = 0
	let plugin_use_ultisnips = 0
	let plugin_use_autoformat = 0
	let latex_live_preview = 0
endif

let plugin_use_neomake = 0
let plugin_use_deoplete = 0
let plugin_use_echodoc = 0
let plugin_use_echofunc = 0
let plugin_use_vim_cpp_enhanced_highlight = 0

" select plugin manager: 1:vundle, 0: vim-plug
let plugin_mgr_vundle_enable = 0
" plugin_select end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin web addr: https://vimawesome.com/
" plugin_manager {{{1
if plugin_mgr_vundle_enable == 1
	" plugin_manager: vundle_setup {{{2
	set rtp+=~/.vim/vundle/
	call vundle#rc()

	filetype plugin indent on     " required!
	" let Vundle manage Vundle: vundle.vim 插件管理器: required!
	Bundle 'gmarik/vundle'

	"-----------------------
	" my_vundle_plugins  start:

	" vundle_setup: language {{{3
	Plugin 'tpope/vim-fugitive'
	if plugin_use_neomake == 1
		Plugin 'neomake/neomake'
	else
		Plugin 'scrooloose/syntastic'
	endif
	Plugin 'tpope/vim-markdown'
	Plugin 'scrooloose/nerdcommenter'
	"Plugin 'hynek/vim-python-pep8-indent'
	Plugin 'lervag/vimtex'
	if latex_live_preview == 1
		Plugin 'xuhdev/vim-latex-live-preview'
	endif
	" language end

	" vundle_setup: completion {{{3
	"Plugin 'ervandew/supertab'
	"Plugin 'Valloric/YouCompleteMe'
	"Plugin 'Shougo/neocomplete.vim'
	"Plugin 'rstacruz/sparkup'
	"Plugin 'neoclide/coc.nvim'
	if plugin_use_deoplete == 0
		Plugin 'AutoComplPop'
		Plugin 'OmniCppComplete'
	endif
	if plugin_use_ultisnips == 1
		Plugin 'SirVer/ultisnips'
		Plugin 'honza/vim-snippets'
	else
		Plugin 'msanders/snipmate.vim'
	endif
	if plugin_use_deoplete == 1
		Plugin 'shougo/deoplete.nvim'
	endif
	Plugin 'taglist.vim'
	" completion end

	" vundle_setup: code_display {{{3
	if plugin_use_vim_cpp_enhanced_highlight == 1
		Plugin 'octol/vim-cpp-enhanced-highlight'
	endif

	if plugin_use_autoformat == 1
		Plugin 'chiel92/vim-autoformat'
	endif

	" vundle_setup: integrations {{{3
	Plugin 'gregsexton/gitv'
	"Plugin 'mileszs/ack.vim'
	Plugin 'dyng/ctrlsf.vim'
	"Plugin 'gitv'
	" integrations end

	" vundle_setup: interface {{{3
	if plugin_use_leaderf == 1
		Plugin 'yggdroot/leaderf'
	else
		Plugin 'kien/ctrlp.vim'
		Plugin 'tacahiroy/ctrlp-funky'
	endif
	Plugin 'jlanzarotta/bufexplorer'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'mbbill/undotree'
	"Plugin 'godlygeek/tabular'
	Plugin 'jistr/vim-nerdtree-tabs'
	Plugin 'Xuyuanp/nerdtree-git-plugin'
	"Plugin 'vim-airline/vim-airline'
	"Plugin 'vim-airline/vim-airline-themes'
	Plugin 'scrooloose/nerdtree'
	Plugin 'mru.vim'
	Plugin 'ZoomWin'
	" interface end

	" vundle_setup: commands {{{3
	Plugin 'majutsushi/tagbar'
	Plugin 'skywind3000/asyncrun.vim'
	Plugin 'tpope/vim-surround'
	"Plugin 'FuzzyFinder'
	" commands end

	" vundle_setup: uncategorized {{{3
	Plugin 'hari-rangarajan/CCTree'
	Plugin 'will133/vim-dirdiff'
	Plugin 'tpope/vim-unimpaired'
	Plugin 'Stormherz/tablify'
	Plugin 'liuchengxu/vim-which-key'
	if plugin_use_echodoc == 1
		Plugin 'shougo/echodoc'
	endif
	if plugin_use_echofunc == 1
		"Plugin 'echofunc.vim'
		Plugin 'mbbill/echofunc'
	endif
	Plugin 'genutils'
	Plugin 'DrawIt'
	Plugin 'sillybun/vim-repl'
	Plugin 'voldikss/vim-translate-me'
	" uncategorized end

	" vundle_setup:  other {{{3
	Plugin 'terryma/vim-multiple-cursors'
	"Plugin 'L9'
	" other end
	" my_vundle_plugins end

	" vundle_setup end
else
	" plugin_manager: vim_plug_setup {{{2
	call plug#begin('~/.vim/plugged')

	"---------------------------
	" my_vim_plug_plugins start:

	" vim_plug_setup: language {{{3
	Plug 'tpope/vim-fugitive'
	if plugin_use_neomake == 1
		Plug 'neomake/neomake'
	else
		Plug 'scrooloose/syntastic'
	endif
	Plug 'tpope/vim-markdown'
	Plug 'scrooloose/nerdcommenter'
	"Plug 'hynek/vim-python-pep8-indent'
	Plug 'lervag/vimtex'
	if latex_live_preview == 1
		Plug 'xuhdev/vim-latex-live-preview'
	endif
	" language end

	" vim_plug_setup:  completion {{{3
	"Plug 'ervandew/supertab'
	"Plug 'Valloric/YouCompleteMe'
	"Plug 'Shougo/neocomplete.vim'
	"Plug 'rstacruz/sparkup'
	"Plug 'neoclide/coc.nvim'
	if plugin_use_deoplete == 0
		Plug 'vim-scripts/AutoComplPop'
		Plug 'vim-scripts/OmniCppComplete'
	endif
	if plugin_use_ultisnips == 1
		Plug 'SirVer/ultisnips'
		Plug 'honza/vim-snippets'
	else
		Plug 'msanders/snipmate.vim'
	endif
	if plugin_use_deoplete == 1
		Plug 'shougo/deoplete.nvim'
	endif
	Plug 'vim-scripts/taglist.vim'

	" completion end

	" vim_plug_setup:  code_display {{{3
	if plugin_use_vim_cpp_enhanced_highlight == 1
		Plug 'octol/vim-cpp-enhanced-highlight'
	endif

	if plugin_use_autoformat == 1
		Plug 'chiel92/vim-autoformat'
	endif

	" vim_plug_setup: integrations {{{3
	Plug 'gregsexton/gitv'
	"Plug 'mileszs/ack.vim'
	Plug 'dyng/ctrlsf.vim'
	"Plug 'gitv'
	" integrations end

	" vim_plug_setup: interface {{{3
	if plugin_use_leaderf == 1
		Plug 'yggdroot/leaderf'
	else
		Plug 'kien/ctrlp.vim'
		Plug 'tacahiroy/ctrlp-funky'
	endif
	Plug 'jlanzarotta/bufexplorer'
	Plug 'airblade/vim-gitgutter'
	Plug 'mbbill/undotree'
	"Plug 'godlygeek/tabular'
	Plug 'jistr/vim-nerdtree-tabs'
	Plug 'Xuyuanp/nerdtree-git-plugin'
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	Plug 'scrooloose/nerdtree'
	Plug 'vim-scripts/mru.vim'
	Plug 'vim-scripts/ZoomWin'
	"Plug 'itchyny/lightline.vim'
	" interface end

	" vim_plug_setup:  commands {{{3
	Plug 'majutsushi/tagbar'
	Plug 'skywind3000/asyncrun.vim'
	Plug 'tpope/vim-surround'
	"Plug 'FuzzyFinder'
	" commands end

	" vim_plug_setup: uncategorized {{{3
	Plug 'hari-rangarajan/CCTree'
	Plug 'will133/vim-dirdiff'
	Plug 'tpope/vim-unimpaired'
	Plug 'Stormherz/tablify'
	Plug 'liuchengxu/vim-which-key'
	if plugin_use_echodoc == 1
		Plug 'shougo/echodoc'
	endif
	if plugin_use_echofunc == 1
		"Plug 'echofunc.vim'
		Plug 'mbbill/echofunc'
	endif
	Plug 'vim-scripts/genutils'
	Plug 'vim-scripts/DrawIt'
	Plug 'sillybun/vim-repl'
	Plug 'voldikss/vim-translate-me'
	" uncategorized end

	" vim_plug_setup:  other {{{3
	Plug 'terryma/vim-multiple-cursors'
	"Plug 'L9'
	" other end
	" my_vim_plug_plugins end

	call plug#end()
	" vim_plug_setup end
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN_SETTINGS begin: {{{1
"
if plugin_use_echofunc == 1
	" plugin_setting: echofunc.vim {{{3
	"let g:EchoFuncAutoStartBalloonDeclaration=1
endif

if plugin_use_echodoc == 1
	" plugin_setting:  echodoc {{{3
	let g:echodoc#type = "echo" " Default value
	set noshowmode
	let g:echodoc_enable_at_startup = 1
endif

" code_display plugin_settings {{{2

if plugin_use_vim_cpp_enhanced_highlight == 1
	" plugin_setting:  vim-cpp-enhanced-highlight {{{3
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

" plugin_setting: auto-format {{{3
if plugin_use_autoformat == 1
	"F5自动格式化代码并保存
	noremap <F5> :Autoformat<CR>:w<CR>
	let g:autoformat_verbosemode=1

	"自动格式化代码，针对所有支持的文件
	"au BufWrite * :Autoformat
	"自动格式化python代码
	"au BufWrite *.py :Autoformat

	"在安装了yapf以后，还可以自定义python格式化的风格，

	"默认情况下是pep8，还可以选择google,facebook和chromium
	let g:formatter_yapf_style = 'pep8'

	"针对某种语言指定特定的格式化工具和相应的参数，比如设定以allman(ansi)的风格格式化
	"C/C++代码同时在操作符两边加入空格(即--pad-oper参数)，可以这样写
	let g:formatdef_allman = '"astyle --style=allman --pad-oper"'
	let g:formatters_cpp = ['allman']
	let g:formatters_c = ['allman']

else

	"格式化代码也不一定非要安装插件才能实现，因为Vim可以执行外部命令，因此函数调用外
	"部工具来实现代码格式化，比如下面就用函数调用astyle和autopep8来格式化代码
	" FormatCode() Function {{{{4
	map <leader>af :call FormatCode()<CR>
	func! FormatCode()
		exec "w"
		if &filetype == 'c' || &filetype == 'h'
			exec "!astyle --style=allman --pad-oper --suffix=none %"
		elseif &filetype == 'cpp' || &filetype == 'cc' || &filetype == 'hpp'
			exec "!astyle --style=allman --suffix=none %"
		elseif &filetype == 'perl'
			exec "!astyle --style=gnu --suffix=none %"
		elseif &filetype == 'py'|| &filetype == 'python'
			exec "!autopep8 --in-place --aggressive %"
		elseif &filetype == 'java'
			exec "!astyle --style=java --suffix=none %"
		elseif &filetype == 'jsp'
			exec "!astyle --style=gnu --suffix=none %"
		elseif &filetype == 'xml'
			exec "!astyle --style=gnu --suffix=none %"
		else
			exec "normal gg=G"
			return
		endif
	endfunc
endif

" integrations plugin_settings {{{2
" plugin_setting: ctrlsf.vim {{{3
let g:ctrlsf_absolute_file_path = 1
let g:ctrlsf_ackprg = '/usr/bin/ack'
let g:ctrlsf_auto_close = {
			\ "normal" : 0,
			\ "compact": 0
			\ }
let g:ctrlsf_auto_focus = {
			\ "at" : "done",
			\ "duration_less_than": 1000
			\ }
let g:ctrlsf_case_sensitive = 'no'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_confirm_unsaving_quit = 0
let g:ctrlsf_context = '-B 5 -A 3'
let g:ctrlsf_debug_mode = 1
let g:ctrlsf_default_root = 'project+fw'
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_extra_backend_args = {
			\ 'pt': '--home-ptignore'
			\ }
let g:ctrlsf_extra_root_markers = ['.root', '.git']
let g:ctrlsf_follow_symlinks = 0
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules']
let g:ctrlsf_indent = 2
"let g:ctrlsf_mapping = {
			"\ "openb": { key: "O", suffix: "<C-w>p" },
			"\ "next": "n",
			"\ "prev": "N",
			"\ "openb": "",
			"\ }
let g:ctrlsf_parse_speed = 100
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_selected_line_hl = 'op'
"let g:ctrlsf_toggle_map_key = '\t'
let g:ctrlsf_winsize = '30%'

" ctrlsf-keymaps
vmap     <C-\>f <Plug>CtrlSFVwordPath
vmap     <C-\>f <Plug>CtrlSFVwordExec

"nmap     <C-F>f <Plug>CtrlSFPrompt
nmap     <C-p>f <Plug>CtrlSFPrompt
nmap     <C-\>n <Plug>CtrlSFCwordPath
nmap     <C-\>p <Plug>CtrlSFPwordPath
" open/close window
nnoremap <C-\>o :CtrlSFOpen<CR>
nnoremap <C-\>c :CtrlSFToggle<CR>
inoremap <C-\>c <Esc>:CtrlSFToggle<CR>

" plugin_setting: tagbar.vim {{{3
let g:tagbar_left=1
let g:tagbar_ctags_bin='ctags'           "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tagbar_show_linenumbers = 2
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	autocmd VimEnter *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.sh,*.py,*.vimrc nested :call tagbar#autoopen(1)
endif

" plugin_setting: taglist.vim {{{3
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


" plugin_setting: CCtree {{{3
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

" plugin_setting: NERDTree.vim {{{3
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

" plugin_setting:  vim-nerdtree-tabs.vim {{{3
"let g:nerdtree_tabs_autofind=1

"Open NERDTree on gvim/macvim startup
"let g:nerdtree_tabs_open_on_gui_startup = 1

"Open NERDTree on console vim startup
let g:nerdtree_tabs_open_on_console_startup = 1

"Do not open NERDTree if vim starts in diff mode
let g:nerdtree_tabs_no_startup_for_diff = 1

"On startup - focus NERDTree when opening a directory, focus the file if
"editing a specified file. When set to `2`, always focus file after startup.
let g:nerdtree_tabs_smart_startup_focus = 2

"Open NERDTree on new tab creation (if NERDTree was globally opened by
":NERDTreeTabsToggle)
let g:nerdtree_tabs_open_on_new_tab = 1

"Unfocus NERDTree when leaving a tab for descriptive tab names
let g:nerdtree_tabs_meaningful_tab_names = 1

"Close current tab if there is only one window in it and it's NERDTree
let g:nerdtree_tabs_autoclose = 1

"Synchronize view of all NERDTree windows (scroll and cursor position)
let g:nerdtree_tabs_synchronize_view = 1

"Synchronize focus when switching tabs (focus NERDTree after tab switch
"if and only if it was focused before tab switch)
let g:nerdtree_tabs_synchronize_focus = 1

"When switching into a tab, make sure that focus is on the file window,
"not in the NERDTree window. (Note that this can get annoying if you use
"NERDTree's feature "open in new tab silently", as you will lose focus on the
"NERDTree.)
let g:nerdtree_tabs_focus_on_files = 0

"When starting up with a directory name as a parameter, cd into it
let g:nerdtree_tabs_startup_cd = 1

" plugin_setting: nerdtree-git-plugin.vim {{{3
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


"" plugin_setting:  YCM {{{3
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
	" plugin_setting: OmniCppComplete.vim {{{3
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

	" configure syntastic syntax checking to check on open as well as save
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

" language  plugin_setting:  {{{2
" plugin_setting: vimtex {{{3
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_enabled=1
let g:vimtex_view_automatic=1
let g:vimtex_compiler_latexmk_engines = {
			\ '_'                : '-pdf',
			\ 'pdflatex'         : '-pdf',
			\ 'dvipdfex'         : '-pdfdvi',
			\ 'lualatex'         : '-lualatex',
			\ 'xelatex'          : '-xelatex',
			\ 'context (pdftex)' : '-pdf -pdflatex=texexec',
			\ 'context (luatex)' : '-pdf -pdflatex=context',
			\ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
			\}

" plugin_setting: vim-latex-live-preview {{{3
"By default, you need to have evince or okular installed as pdf viewers.
"But you can specify your own viewer by setting:
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'zathura'
"这个插件配合最好的evince
"let g:livepreview_previewer = 'evince'

" plugin_setting: vim-python-pep8-indent plugin_setting{{{3
let g:python_pep8_indent_multiline_string = 0
let g:python_pep8_indent_hang_closing = 0

"Start Python PEP 8 stuff {{{4
" Number of spaces that a pre-existing tab is equal to.
"au BufRead,BufNewFile *py,*pyw,*.c,*.h set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab
au BufRead,BufNewFile *.py set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
"highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
"au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
"au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix

" Set the default file encoding to UTF-8:
"set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1

" Keep indentation level from previous line:
autocmd FileType python set autoindent

"Folding based on indentation:
"autocmd FileType python set foldmethod=indent
"use space to open folds
"nnoremap <space> za
"Stop python PEP 8 stuff

" language_setting end

" plugin_setting: MRU.vim {{{3

" plugin_setting: undotree.vim {{{3
let g:undotree_WindowLayout = 2

" plugin_setting: BufExplorer.vim 其中有默认配置 {{{3
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


" interface plugin_settings   leaderf or ctrlp {{{2
if plugin_use_leaderf == 1
	" plugin_setting: interface: leaderf {{{3
	let g:Lf_ShortcutF = '<c-p>'
	let g:Lf_ShortcutB = '<m-n>'
	noremap <c-n> :LeaderfMru<cr>
	noremap <m-p> :LeaderfFunction!<cr>
	noremap <m-n> :LeaderfBuffer<cr>
	noremap <m-m> :LeaderfTag<cr>
	let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

	let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
	let g:Lf_WorkingDirectoryMode = 'ac'
	let g:Lf_WindowHeight = 0.30
	let g:Lf_CacheDirectory = expand('~/.vim/cache')
	let g:Lf_ShowRelativePath = 0
	let g:Lf_HideHelp = 1
	"let g:Lf_StlColorscheme = 'powerline'
	let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
else
	" plugin_setting: interface: ctrlp.vim {{{3
	"let g:ctrlp_map = '<c-p>'
	"let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'
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

" plugin_setting: Man.vim {{{3
source $VIMRUNTIME/ftplugin/man.vim

if plugin_use_ultisnips == 1
	" plugin_setting: utilsnips.vim {{{3
	"autocmd FileType * call UltiSnips#FileTypeChanged()
	" 连续按下两次i触发代码补全
	let g:UltiSnipsExpandTrigger="<tab>"
	"let g:UltiSnipsListSnippets="<c-tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"

else
	" plugin_setting: snipMate {{{3
	"let g:snips_author="Du Jianfeng"
	"let g:snips_email="cmdxiaoha@163.com"
	"let g:snips_copyright="SicMicro, Inc"
endif


" plugin_setting: dirdiff.vim {{{3
let g:DirDiffExcludes = "CVS,*.class,*.o"
let g:DirDiffIgnore = "Id:"
" ignore white space in diff
let g:DirDiffAddArgs = "-w"
let g:DirDiffEnableMappings = 1

" plugin_setting: ZoomWinPlugin.vim {{{3
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

" plugin_setting: vim-airline {{{3
"set laststatus=2  "永远显示状态栏
"let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer

" 使用:AirlineTheme {theme-name}设置主题。
" plugin_setting: asyncrun {{{3
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 定位到文件所属项目的目录: 从文件所在目录向上递归，直到找到名为 “.git”, “.svn”, “.hg”或者 “.root”文件或者目录
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" uncategorized plugin_settings{{{2
" plugin_setting: vim-repl setting {{{3
autocmd Filetype python nnoremap <F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3
"customize the key to send code to REPL environment. The default key is <leader>w
let g:sendtorepl_invoke_key = "<leader>w"
"repl_position it controls the location where REPL windows will appear
"0 represents bottom
"1 represents top
"2 represents left
"3 represents right
let g:repl_position = 0
let g:repl_stayatrepl_when_open = 0
let g:repl_program = {
			\    'python': 'python',
			\    'default': 'bash'
			\    }
let g:repl_ipython_version = '7'
let g:repl_exit_commands = {
			\    'python': 'quit()',
			\    'bash': 'exit',
			\    'zsh': 'exit',
			\    'default': 'exit',
			\    }
let g:repl_auto_sends = ['def ', 'class ', 'for ', 'if ', 'while ']
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_console_name = 'ZYTREPL'

" plugin_setting: vim-translate-me {{{3
let g:vtm_default_mapping=0
let g:vtm_default_to_lang='zh'
let g:vtm_default_engines=['ciba', 'youdao']
"proxy
"let g:vtm_proxy_url = 'socks5://127.0.0.1:1080'
let g:vtm_enable_history=1
let g:vtm_max_history_count=5000
" key_mapping
" <leader>t 翻译光标下的文本，在命令行回显
nmap <silent> <leader>t <Plug>Translate
vmap <silent> <leader>t <Plug>TranslateV

" leader>w 翻译光标下的文本，在窗口中显示
nmap <silent> <leader>aw <Plug>TranslateW
vmap <silent> <leader>aw <Plug>TranslateWV

" leader>r 替换光标下的文本为翻译内容
nmap <silent> <leader>ar <Plug>TranslateR
vmap <silent> <leader>ar <Plug>TranslateRV

" uncategorized_plugin setting end

" other plugin settings {{{2
" plugin_setting: vim-multiple-cursors {{{3
" 多光标选中编辑
" multiplecursors
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = 'g<C-a>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-m>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
" vim-multiple-cursors end

" PLUGIN_SETTINGS end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SHORTCUT_SETTINGS: 按键映射 key_mappings {{{1
" command line key_mappings {{{2
cmap jk <ESC>
cmap pi PlugInstall

" alt key_mappings {{{2
" 设置方法:按下ctrl-v 后，输入alt-想设置的键
" vim-autoformat
nnoremap af :Autoformat<CR>

" vimdiff hot keys {{{2
" if you know the buffer number, you can use hot key like ",2"
" (press comma first, then press two as quickly as possible) to
" pull change from buffer number two.set up hot keys:
map <silent><leader>1 :diffget 1<CR>:diffupdate<CR>
map <silent><leader>2 :diffget 2<CR>:diffupdate<CR>
map <silent><leader>3 :diffget 3<CR>:diffupdate<CR>
map <silent><leader>4 :diffget 4<CR>:diffupdate<CR>

" space key_mappings. {{{2
nnoremap <space>e<CR> :e<CR>
nnoremap <space>w<CR> :w<CR>
nnoremap <space>q<CR> :q<CR>
nnoremap <space>q1<CR> :q!<CR>
nnoremap <space>wq<CR> :wq<CR>
nnoremap <space>wa<CR> :wa<CR>
nnoremap <space>qa<CR> :qa<CR>
nnoremap <space>wqa<CR> :wqa<CR>
nnoremap <space>; :
vnoremap <space>; :

nmap  <space>t<CR> :vert terminal<CR>
nmap  <space>td<CR> :packadd termdebug<CR>:Termdebug<CR>
" vim-repl key-mapping
nnoremap <space>r<CR> :REPLToggle<Cr>

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
inoremap js <Esc>:w<CR>

if version >= 800
	" [>= vim8.0]]terminal mode key_mappings
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

" define a shortcut key for enabling/disabling highlighting:
nnoremap  <C-\><F3> :exe "let g:HlUnderCursor=exists(\"g:HlUnderCursor\")?g:HlUnderCursor*-1+1:1"<CR>

map \ :call ShowFuncName()<CR>
nmap  <leader>m :MRU
" SHORTCUT_SETTINGS end
""""""""""""""""""""""""""""""
"实现vim和终端及gedit等之间复制、粘贴的设置 {{{1
""""""""""""""""""""""""""""""
" 让VIM和ubuntu(X Window)共享一个粘贴板
set clipboard=unnamedplus " 设置vim使用"+寄存器(粘贴板)，"+寄存器是代表ubuntu的粘贴板。

" autocmd_setting {{{1
" VIM退出时，运行xsel命令把"+寄存器中的内容保存到系统粘贴板中;需要安装xsel {{{2
autocmd VimLeave * call system("xsel -ib", getreg('+'))


" 启用每行超过80列的字符提示（背景变black） {{{2
highlight MyGroup ctermbg=black guibg=black
au BufWinEnter * let w:m2=matchadd('MyGroup', '\%>' . 80 . 'v.\+', -1)

" Highlight unwanted spaces {{{2
highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t\+\|\t\+\zs \+/

" high light word under cursor {{{2
autocmd CursorMoved * call s:HighlightWordUnderCursor()

" whitespace  去除文件的行尾空白 {{{2
autocmd BufWritePre     *.py        call WhitespaceStripTrailing()
autocmd BufWritePre     *.h         call WhitespaceStripTrailing()
autocmd BufWritePre     *.c         call WhitespaceStripTrailing()
autocmd BufWritePre     *.cpp       call WhitespaceStripTrailing()

