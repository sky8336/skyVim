" .vimrc - Vim configuration file.
"
" Copyright (c) 2010 Jeffy Du. All Rights Reserved.
"
" Maintainer: Jeffy Du <jeffy.du@gmail.com>
"    Created: 2010-01-01
" LastChange: 2010-04-22

" GENERAL SETTINGS: {{{1
" To use VIM settings, out of VI compatible mode.
set nocompatible
" Enable file type detection.
" filetype plugin indent on
filetype off 
" vundle.vim 插件管理器
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
  
" let Vundle manage Vundle  
"required!   
Bundle 'gmarik/vundle'  
  
" My Bundles here:  /* 插件配置格式 */  
"     
" original repos on github （Github网站上非vim-scripts仓库的插件，按下面格式填写）  
"Bundle 'tpope/vim-fugitive'  
"Bundle 'Lokaltog/vim-easymotion'  
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'tpope/vim-rails.git'  
Bundle 'airblade/vim-gitgutter'
" vim-scripts repos  （vim-scripts仓库里的，按下面格式填写）
"Bundle 'L9' 
"Bundle 'FuzzyFinder'
Bundle 'fugitive.vim'
Bundle 'gitv'
" non github repos   (非上面两种情况的，按下面格式填写)  
"Bundle 'git://git.wincent.com/command-t.git'  
" ...   
  
filetype plugin indent on     " required!   /** vimrc文件配置结束 **/  
"                                           /** vundle命令 **/  
" Brief help  
" :BundleList          - list configured bundles  
" :BundleInstall(!)    - install(update) bundles  
" :BundleSearch(!) foo - search(or refresh cache first) for foo   
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles  
"     
" see :h vundle for more details or wiki for FAQ   
" NOTE: comments after Bundle command are not allowed..  
" vundle setup end
" Syntax highlighting.
syntax on
" Setting colorscheme
color mycolor
" Other settings.
set   autoindent
set   autoread
set   autowrite
set   background=dark
set   backspace=indent,eol,start
set nobackup
set   cindent
set   cinoptions=:0
set   cursorline
set   completeopt=longest,menuone
set noexpandtab
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
"set   statusline=%-10.3n  "buffer number
set   statusline=%-2.2n%<%f\ %h%m%r%=%-4.(%y[%{&fenc}]%l,%c%V%)\ %P
set   mouse=a
set   number
set   pumheight=10
set   ruler
set   scrolloff=5
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
set nowrap

" AUTO COMMANDS: {{{1
" auto expand tab to blanks
"autocmd FileType c,cpp set expandtab
" Restore the last quit position when open file.
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \     exe "normal g'\"" |
    \ endif

" SHORTCUT SETTINGS: {{{1
" Set mapleader
let mapleader=","
" Space to command mode.
nnoremap <space> :
vnoremap <space> :
" Switching between buffers.
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
inoremap <C-h> <Esc><C-W>h
inoremap <C-j> <Esc><C-W>j
inoremap <C-k> <Esc><C-W>k
inoremap <C-l> <Esc><C-W>l

" insert mode 光标移动
" Ctrl + K 插入模式下光标向上移动
" imap <c-k> <Up>
" Ctrl + J 插入模式下光标向下移动
" imap <c-j> <Down>
" Ctrl + H 插入模式下光标向左移动
" imap <c-h> <Left>
" Ctrl + L 插入模式下光标向右移动
" imap <c-L> <Right>

" "cd" to change to open directory.
let OpenDir=system("pwd")
nmap <silent> <leader>cd :exe 'cd ' . OpenDir<cr>:pwd<cr>

" PLUGIN SETTINGS: {{{1
" taglist.vim
let g:Tlist_Auto_Update=1
let g:Tlist_Process_File_Always=1
let g:Tlist_Exit_OnlyWindow=1 "如果taglist窗口是最后一个窗口，则退出vim
let g:Tlist_Show_One_File=1 "不同时显示多个文件的tag，只显示当前文件的
let g:Tlist_WinWidth=25
let g:Tlist_Enable_Fold_Column=0
let g:Tlist_Auto_Highlight_Tag=1
"let Tlist_Show_One_File=0
let g:Tlist_Auto_Open=1

" NERDTree.vim
let g:NERDTreeWinPos="right"
let g:NERDTreeWinSize=25
let g:NERDTreeShowLineNumbers=1
let g:NERDTreeQuitOnOpen=1
"autocmd vimenter * NERDTree "打开vim时自动打开NERDTree
" cscope.vim
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
endif
" OmniCppComplete.vim
"set nocp 
"filetype plugin on 
let g:OmniCpp_DefaultNamespaces=["std"]
let g:OmniCpp_MayCompleteScope=1
let g:OmniCpp_SelectFirstItem=2

" VimGDB.vim
if has("gdb")
	set asm=0
	let g:vimgdb_debug_file=""
	run macros/gdb_mappings.vim
endif
" LookupFile setting
"let g:LookupFile_TagExpr='"./tags.filename"' "原来的名称不匹配
let g:LookupFile_TagExpr='"./tags.fn"'
let g:LookupFile_MinPatLength=2
let g:LookupFile_PreserveLastPattern=0
let g:LookupFile_PreservePatternHistory=1
let g:LookupFile_AlwaysAcceptFirst=1
let g:LookupFile_AllowNewFiles=0
" Man.vim
source $VIMRUNTIME/ftplugin/man.vim
" snipMate
let g:snips_author="Du Jianfeng"
let g:snips_email="cmdxiaoha@163.com"
let g:snips_copyright="SicMicro, Inc"
" plugin shortcuts
function! RunShell(Msg, Shell)
	echo a:Msg . '...'
	call system(a:Shell)
	echon 'done'
endfunction

" 实现递归查找上级目录中的ctags和cscope并自动载入
function! AutoLoadCTagsAndCScope()
    let max = 5
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
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
endf
" <cr> 回车
nmap  <F2> :TlistToggle<cr>
nmap  <F3> :NERDTreeToggle<cr>
nmap  <F4> :MRU<cr>
nmap  <F5> <Plug>LookupFile<cr>
nmap  <F6> :vimgrep /<C-R>=expand("<cword>")<cr>/ **/*.c **/*.h<cr><C-o>:cw<cr>
nmap  <F7> :call RunShell("Generate tags", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")<cr>
nmap  <F8> :call RunShell("Generate cscope", "cscope -Rbq")<cr>:cs add cscope.out<cr>
nmap  <F9> :call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")<cr>
nmap <F10> :call HLUDSync()<cr>
nmap <F12> :call AutoLoadCTagsAndCScope()<CR>
"call AutoLoadCTagsAndCScope()
"cscope 按键映射
nmap <leader>sa :cs add cscope.out<cr>
nmap <leader>ss :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sc :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<cr><cr>
nmap <leader>se :cs find e <C-R>=expand("<cword>")<cr><cr>
nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>si :cs find i <C-R>=expand("<cfile>")<cr><cr>
nmap <leader>sd :cs find d <C-R>=expand("<cword>")<cr><cr>
"其他映射
nmap <leader>zz <C-w>o
nmap <leader>gs :GetScripts<cr>
",sa 添加cscope.out库
",ss 查找c语言符号（函数名 宏 枚举值）出现的地方
",sg 查找函数/宏/枚举等定义的位置，类似ctags的功能
",sc 查找调用本函数的函数
",st 查找字符串
",se 查找egrep模式
",sf 查找并打开文件，类似vim的find功能
",si 查找包含本文件的文件
",sd 查找本函数调用的函数

"zz  
",gs 自动安装(更新)插件

""""""""""""""""""""""""""""""
" BufExplorer.vim 其中有默认配置
""""""""""""""""""""""""""""""
"   let g:bufExplorerDefaultHelp=0       " Do not show default help.
"   let g:bufExplorerShowRelativePath=1  " Show relative paths.
"   let g:bufExplorerSortBy='mru'        " Sort by most recently used.
"   let g:bufExplorerSplitRight=0        " Split left.
"   let g:bufExplorerSplitVertical=1     " Split vertically.
"   let g:bufExplorerSplitVertSize = 30  " Split width
"   let g:bufExplorerUseCurrentWindow=1  " Open in new window.
" <Leader>be　　全屏方式打来 buffer 列表。
" <Leader>bs　　水平窗口打来 buffer 列表。
" <Leader>bv　　垂直窗口打开 buffer 列表。

" vimdiff hot keys
" if you know the buffer number, you can use hot key like ",2" 
" (press comma first, then press two as quickly as possible) to 
" pull change from buffer number two.set up hot keys:
map <silent><leader>1 :diffget 1<CR>:diffupdate<CR>
map <silent><leader>2 :diffget 2<CR>:diffupdate<CR>
map <silent><leader>3 :diffget 3<CR>:diffupdate<CR>
map <silent><leader>4 :diffget 4<CR>:diffupdate<CR>
""""""""""""""""""""""""""""""""""""
set noswapfile
set tags+=/usr/include/tags
set tags+=./tags
map ta :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

""""""""""""""""""""""""""""""
"实现vim和终端及gedit等之间复制、粘贴的设置
""""""""""""""""""""""""""""""
" 让VIM和ubuntu(X Window)共享一个粘贴板
set clipboard=unnamedplus " 设置vim使用"+寄存器(粘贴板)，"+寄存器是代表ubuntu的粘贴板。
" VIM退出时，运行xsel命令把"+寄存器中的内容保存到系统粘贴板中;需要安装xsel
autocmd VimLeave * call system("xsel -ib", getreg('+'))


""""""""""""""""""""""""""""""
" 编辑文件相关配置
""""""""""""""""""""""""""""""
" 常规模式下输入 cM 清除行尾 ^M 符号
nmap cM :%s/\r$//g<CR>:noh<CR>
" 启用每行超过90列的字符提示（字体变蓝并加下划线）
" au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 90 . 'v.\+', -1)



