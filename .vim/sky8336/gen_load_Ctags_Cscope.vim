" gen_load_Ctags_Cscope.vim - generate and autoload ctags and cscope.
"
" Copyright (c) 2019 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2019-08-24
"------------------------------
" LastChange: 2019-08-30
"    Version: v0.0.04
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" 生成tags.fn,tags,cscope数据库: 正常生成tags和cscope
fu! Generate_fntags_tags_cscope()
	if getcwd() == $HOME
		let Msg = "$HOME cannot generate tags.fn tags and cscope.out !"
		echo Msg . '  done !'
		return
	endif
	"call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")
	"生成专用于c/c++的ctags文件
	call RunShell("Generate tags (use ctags)", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")
	"生成专用于c的cscope文件
	call RunShell("Generate cscope (use cscope)", "cscope -Rbqk -P " . getcwd())	"this not support c++

	"quit the empty buffer
	if bufname("%") == ""
		q
	endif

	cs add cscope.out
endf

" 生成tags.fn,tags,cscope数据库 for c++
fu! Generate_cpp_tags_cscope()
	if getcwd() == $HOME
		let Msg = "$HOME cannot generate tags.fn tags and cscope.out !"
		echo Msg . '  done !'
		return
	endif
	"call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")
	"生成专用于c/c++的ctags文件
	call RunShell("Generate tags (use ctags)", "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .")

	call RunShell("Generate cscope.files", "find . -name '*.h' -o -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.hpp' > cscope.files")
	call RunShell("Generate cscope for c/c++", "cscope -bkq -i cscope.files")

	"quit the empty buffer
	if bufname("%") == ""
		q
	endif

	cs add cscope.out
endf

"当前目录为kernel或linux-stable,生成kernel中arm平台的tags和cscope，
fu! Generate_kernel_tags_cscope()
	if getcwd() == $HOME
		let Msg = "$HOME cannot generate tags.fn tags and cscope.out !"
		echo Msg . '  done !'
		return
	endif
	"call RunShell("Generate filename tags", "~/.vim/shell/genfiletags.sh")
	call RunShell("Generate kernel tags and cscope (use 'make')", "make tags ARCH=arm && make cscope ARCH=arm")

	"quit the empty buffer
	if bufname("%") == ""
		q
	endif

	cs add cscope.out
endf

" 实现递归查找上级目录中的ctags和cscope并自动载入
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

" cscope add
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

