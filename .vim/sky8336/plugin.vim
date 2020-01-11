" plugin.vim - Vim plugin manager and setting.
"
" Copyright (c) 2019 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2019-08-24
" LastChange: 2020-01-11
"    Version: v0.0.04
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" function_switch: plugin_select config table {{{1
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


let plugin_enalbe_rainbow_parentheses = 0

let plugin_enable_Qt_highlight_support = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin web addr: https://vimawesome.com/
" plugin_manager {{{1
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
	Plug 'plasticboy/vim-markdown'
	Plug 'scrooloose/nerdcommenter'
	"Plug 'hynek/vim-python-pep8-indent', { 'for': 'python' }
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

	" completion end

	" vim_plug_setup:  code_display {{{3
	if plugin_use_vim_cpp_enhanced_highlight == 1
		Plug 'octol/vim-cpp-enhanced-highlight'
	endif

	if plugin_enable_rainbow_parentheses == 1
		Plug 'kien/rainbow_parentheses.vim'
	endif
	
	if plugin_enable_Qt_highlight_support == 1
		Plug 'vim-scripts/cpp.vim'
	endif


	" Python代码补全插件
	Plug 'davidhalter/jedi-vim', { 'for': 'python' }

	if plugin_use_autoformat == 1
		Plug 'chiel92/vim-autoformat'
	endif

	" vim_plug_setup: integrations {{{3
	Plug 'gregsexton/gitv'
	"Plug 'mileszs/ack.vim'
	Plug 'dyng/ctrlsf.vim'
	"Plug 'jamshedvesuna/vim-markdown-preview'
	Plug 'kannokanno/previm'
	Plug 'tyru/open-browser.vim'
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
	Plug 'jistr/vim-nerdtree-tabs', { 'on':  'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'scrooloose/nerdtree'
	Plug 'vim-scripts/mru.vim'
	Plug 'vim-scripts/ZoomWin'
	Plug 'skywind3000/vim-preview'
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
	Plug '907th/vim-auto-save'
	Plug 'vim-scripts/DoxygenToolkit.vim'
	"Plug 'L9'
	" other end
	" my_vim_plug_plugins end

	call plug#end()
	" vim_plug_setup end


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" load plugin_setting.vim
" sky8336's vim {{{1
" plugin_setting.vim {{{2
if filereadable(expand("$HOME/.vim/sky8336/plugin_setting.vim"))    " 判断文件是否存在"
    "echo 'plugin_setting.vim is exists'
    execute 'source ~/.vim/sky8336/plugin_setting.vim'
else
    "echo 'plugin_setting.vim is not exists'
endif
