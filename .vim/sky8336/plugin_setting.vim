" plugin_setting.vim - Vim plugin setting.
"
" Copyright (c) 2019 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2019-08-24
"------------------------------
" LastChange: 2019-11-22
"    Version: v0.0.09
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" PLUGIN_SETTINGS begin:
"
if plugin_use_echofunc == 1
	" plugin_setting: echofunc.vim {{{2
	"let g:EchoFuncAutoStartBalloonDeclaration=1
endif

if plugin_use_echodoc == 1
	" plugin_setting:  echodoc {{{2
	let g:echodoc#type = "echo" " Default value
	set noshowmode
	let g:echodoc_enable_at_startup = 1
endif

" code_display plugin_settings {{{1

if plugin_use_vim_cpp_enhanced_highlight == 1
	" plugin_setting:  vim-cpp-enhanced-highlight {{{2
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

"rainbow-parentheses  {{{2
let g:rbpt_colorpairs = [
			\ ['brown',       'RoyalBlue3'],
			\ ['Darkblue',    'SeaGreen3'],
			\ ['darkgray',    'DarkOrchid3'],
			\ ['darkgreen',   'firebrick3'],
			\ ['darkcyan',    'RoyalBlue3'],
			\ ['darkred',     'SeaGreen3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['brown',       'firebrick3'],
			\ ['gray',        'RoyalBlue3'],
			\ ['black',       'SeaGreen3'],
			\ ['darkmagenta', 'DarkOrchid3'],
			\ ['Darkblue',    'firebrick3'],
			\ ['darkgreen',   'RoyalBlue3'],
			\ ['darkcyan',    'SeaGreen3'],
			\ ['darkred',     'DarkOrchid3'],
			\ ['red',         'firebrick3'],
			\ ]
let g:rbpt_max = 40
let g:rbpt_loadcmd_toggle = 0

" plugin_setting: auto-format {{{2
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
	let g:formatdef_allman = '"astyle --style=allman --pad-oper --align-pointer=name --align-reference=name --pad-header"'
	let g:formatters_cpp = ['allman']

	let g:formatdef_my_c = '"astyle --style=linux --pad-oper --align-pointer=name --align-reference=name --pad-header"'
	let g:formatters_c = ['my_c']

else

	"格式化代码也不一定非要安装插件才能实现，因为Vim可以执行外部命令，因此函数调用外
	"部工具来实现代码格式化，比如下面就用函数调用astyle和autopep8来格式化代码
	" FormatCode() Function {{{{3
	map <leader>af :call FormatCode()<CR>
	func! FormatCode()
		exec "w"
		if &filetype == 'c' || &filetype == 'h'
			exec "!astyle --style=linux --pad-oper --align-pointer=name --pad-header --suffix=none %"
		elseif &filetype == 'cpp' || &filetype == 'cc' || &filetype == 'hpp'
			exec "!astyle --style=allman --align-pointer=name --align-reference=name --pad-header --suffix=none %"
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

" integrations plugin_settings {{{1
" plugin_setting: ctrlsf.vim {{{2
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

" plugin_setting: tagbar.vim {{{2
let g:tagbar_left=1
let g:tagbar_ctags_bin='ctags'           "ctags程序的路径
let g:tagbar_width=30                    "窗口宽度的设置
let g:tagbar_sort = 0                    "根据源码中出现的顺序排序
let g:tagbar_show_linenumbers = 2
" 执行vi 文件名，如果是c语言的程序，自动打开tagbar;vimdiff不自动打开tagbar
if &diff == 0
	autocmd VimEnter *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.sh,*.py,*.vimrc nested :call tagbar#autoopen(1)
endif

" plugin_setting: CCtree {{{2
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

" plugin_setting: NERDTree.vim {{{2
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

" plugin_setting:  vim-nerdtree-tabs.vim {{{2
"let g:nerdtree_tabs_autofind=1

"Open NERDTree on gvim/macvim startup
"let g:nerdtree_tabs_open_on_gui_startup = 1

"Open NERDTree on console vim startup
let g:nerdtree_tabs_open_on_console_startup = 0

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

" plugin_setting: nerdtree-git-plugin.vim {{{2
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


"" plugin_setting:  YCM {{{2
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
	" plugin_setting: OmniCppComplete.vim {{{2
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

" language  plugin_setting:  {{{1
" plugin_setting: language: vim-markdown {{{2
" Disable Folding
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_folding_style_pythonic = 1
" Change fold style
"let g:vim_markdown_override_foldtext = 1
" Set header folding level
"let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
"Syntax Concealing
set conceallevel=2
let g:vim_markdown_conceal = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
"Fenced code block languages
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
"Follow named anchors
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_anchorexpr = "'<<'.v:anchor.'>>'"
"Adjust new list item indent
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_no_extensions_in_markdown = 1
"Auto-write when following link
let g:vim_markdown_autowrite = 1
"Do not automatically insert bulletpoints
let g:vim_markdown_auto_insert_bullets = 0


" plugin_setting: vimtex {{{2
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

" plugin_setting: vim-latex-live-preview {{{2
"By default, you need to have evince or okular installed as pdf viewers.
"But you can specify your own viewer by setting:
autocmd Filetype tex setl updatetime=1
let g:livepreview_previewer = 'zathura'
"这个插件配合最好的evince
"let g:livepreview_previewer = 'evince'

" plugin_setting: vim-python-pep8-indent plugin_setting{{{2
let g:python_pep8_indent_multiline_string = 0
let g:python_pep8_indent_hang_closing = 0

"Start Python PEP 8 stuff {{{3
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

" plugin_setting: MRU.vim {{{2

" plugin_setting: undotree.vim {{{2
let g:undotree_WindowLayout = 2


" interface plugin_settings: {{{1
if plugin_use_leaderf == 1
	" plugin_setting: interface: leaderf {{{2
	let g:Lf_ShortcutF = '<c-p>'
	let g:Lf_ShortcutB = '<m-n>'
	noremap m  :LeaderfMru<cr>
	noremap f :LeaderfFunction!<cr>
	noremap b :LeaderfBuffer<cr>
	noremap t :LeaderfTag<cr>
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
	" plugin_setting: interface: ctrlp.vim {{{2
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

" plugin_setting: integrations: BufExplorer.vim 其中有默认配置 {{{2
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


" plugin_setting: interface: vim-gitgutter {{{2
" determines how long (in milliseconds) the plugin will wait after you stop
" typing before it updates the signs.  Vim's default is 4000.  I recommend 100.
set updatetime=100


" plugin_setting: Man.vim {{{2
source $VIMRUNTIME/ftplugin/man.vim

if plugin_use_ultisnips == 1
	" plugin_setting: utilsnips.vim {{{2
	"autocmd FileType * call UltiSnips#FileTypeChanged()
	" 连续按下两次i触发代码补全
	let g:UltiSnipsExpandTrigger="<tab>"
	"let g:UltiSnipsListSnippets="<c-tab>"
	let g:UltiSnipsJumpForwardTrigger="<c-j>"
	let g:UltiSnipsJumpBackwardTrigger="<c-k>"

else
	" plugin_setting: snipMate {{{2
	"let g:snips_author="Du Jianfeng"
	"let g:snips_email="cmdxiaoha@163.com"
	"let g:snips_copyright="SicMicro, Inc"
endif


" plugin_setting: dirdiff.vim {{{2
let g:DirDiffExcludes = "CVS,*.class,*.o"
let g:DirDiffIgnore = "Id:"
" ignore white space in diff
let g:DirDiffAddArgs = "-w"
let g:DirDiffEnableMappings = 1

" plugin_setting: ZoomWinPlugin.vim {{{2
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

" plugin_setting: vim-airline {{{2
"let g:airline_powerline_fonts = 1  " 支持 powerline 字体
"打开tabline功能，显示窗口tab和buffer, 方便查看Buffer和切换"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#hunks#enabled = 1

let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#show_message = 0

"let w:airline_section_c = '%{MyPlugin#function()}'

" plugin_setting: vim-airline-themes {{{2
"let g:airline_theme="bubblegum"
let g:airline_theme="dark"

" plugin_setting: asyncrun {{{2
" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 定位到文件所属项目的目录: 从文件所在目录向上递归，直到找到名为 “.git”, “.svn”, “.hg”或者 “.root”文件或者目录
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

" uncategorized plugin_settings{{{1
" plugin_setting: vim-repl setting {{{2
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

" plugin_setting: vim-translate-me {{{2
let g:vtm_default_mapping=0
let g:vtm_default_to_lang='zh'
let g:vtm_default_engines=['ciba', 'youdao']
"proxy
"let g:vtm_proxy_url = 'socks5://127.0.0.1:1080'
let g:vtm_enable_history=1
let g:vtm_max_history_count=5000
" key_mapping
" <leader>t 翻译光标下的文本，在命令行回显
nmap <silent> <leader>te <Plug>Translate
vmap <silent> <leader>te <Plug>TranslateV

" leader>w 翻译光标下的文本，在窗口中显示
nmap <silent> <leader>tw <Plug>TranslateW
vmap <silent> <leader>tw <Plug>TranslateWV

" leader>r 替换光标下的文本为翻译内容
nmap <silent> <leader>tr <Plug>TranslateR
vmap <silent> <leader>tr <Plug>TranslateRV

" uncategorized_plugin setting end

" other plugin settings {{{1
" plugin_setting: vim-multiple-cursors {{{2
" 多光标选中编辑
" multiplecursors
let g:multi_cursor_exit_from_visual_mode=1
let g:multi_cursor_exit_from_insert_mode=1
let g:multi_cursor_use_default_mapping=0
" Default highlighting (see help :highlight and help :highlight-link)
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
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

" plugin_autocmd {{{1
"plugin_autocmd: rainbow_parentheses.vim {{{2
if plugin_enalbe_rainbow_parentheses == 1
	au VimEnter * RainbowParenthesesToggle
	au Syntax * RainbowParenthesesLoadRound
	au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces
endif
