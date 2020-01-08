" SetTitle.vim - Vim SetTitle function.
"
" Copyright (c) 2019 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2019-08-24
"------------------------------
" LastChange: 2020-01-08
"    Version: v0.0.08
"""""""""""""""""""""""""""""""""""""""""""""""""""""

" SetTitle
" script(sh, py, ...) title
func Set_sh_Title()
	let s:first_line = getline(1)
	if s:first_line != "\#!/bin/bash" && s:first_line != "\#!/bin/sh"
		call append(0,"\#!/bin/bash")
	endif
	call append(1,"#")
	call append(2,"# Filename: ".expand("%:t"))
	call append(3,"#")
	call append(4,"# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
	call append(5,"#")
	call append(6,"# History:")
	call append(7,"#    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
	call append(8,"#")
	call append(9,"# Maintainer: Eric MA <eric@email.com>")
	call append(10,"#    Created: ".strftime("%Y-%m-%d"))
	call append(11,"# LastChange: ".strftime("%Y-%m-%d"))
	call append(12,"#    Version: v0.0.01")
	call append(13,"#")
endfunc

func Set_py_Title()
	let s:first_line = getline(1)
	if s:first_line != "#!/usr/bin/env python" && s:first_line != "\#!/usr/bin/python"
		call append(0,"#!/usr/bin/env python")
	endif
	call append(1,"# coding=utf-8")
	call append(2,"#")
	call append(3,"# Filename: ".expand("%:t"))
	call append(4,"#")
	call append(5,"# Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
	call append(6,"#")
	call append(7,"# History:")
	call append(8,"#    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
	call append(9,"#")
	call append(10,"# Maintainer: Eric MA <eric@email.com>")
	call append(11,"#    Created: ".strftime("%Y-%m-%d"))
	call append(12,"# LastChange: ".strftime("%Y-%m-%d"))
	call append(13,"#    Version: v0.0.01")
	call append(14,"#")
endfunc

" c, cpp, title
func Set_c_common_Title()
	call append(0,"/*")
	call append(1," * Filename: ".expand("%:t"))
	call append(2," *")
	call append(3," * Copyright (C) 2018-2023 Eric MA  <eric@company.com>. All Rights Reserved.")
	call append(4," *")
	call append(5," * History:")
	call append(6," *    ".strftime("%Y/%m/%d")." - [Eric MA] Created file")
	call append(7," *")
	call append(8," * Maintainer: Eric MA <eric@email.com>")
	call append(9," *    Created: ".strftime("%Y-%m-%d"))
	call append(10," * LastChange: ".strftime("%Y-%m-%d"))
	call append(11," *    Version: v0.0.01")
	call append(12," *")
	call append(13," */")
endfunc

func Add_macro_define()
	"call append(15, "#ifndef _".tr(toupper(expand("%:r")), "/", "_")."_H")
	"call append(16, "#define _".tr(toupper(expand("%:r")), "/", "_")."_H")
	call append(15, "#ifndef _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
	call append(16, "#define _".substitute(tr(toupper(expand("%:r")), "/", "_"),"\\.._","","g")."_H")
	call append(17, "")
	call append(18, "")
	"call append(19, "#endif")
	call setline(20, "#endif")
endf

func Set_c_Title()
	call Set_c_common_Title()
	call append(14,"#include <stdio.h>")
	"call append(line("."), "")
endfunc

func Set_cpp_Title()
	call Set_c_common_Title()
	call append(14,"#include <iostream>")
	"call append(line("."), "")
endfunc

func Set_h_Title()
	call Set_c_common_Title()
	call append(14, "")
	call Add_macro_define()
	normal G2k
endfunc

func Set_hpp_Title()
	call Set_c_common_Title()
	call append(14, "")
	call Add_macro_define()
	normal G2k
endfunc

" main function
func AddTitle()
	if expand("%:e") == 'sh'
		call Set_sh_Title()
	elseif expand("%:e") == 'py'
		call Set_py_Title()
	elseif expand("%:e") == 'cpp'
		call Set_cpp_Title()
	elseif expand("%:e") == 'cc'
		call Set_cpp_Title()
	elseif expand("%:e") == 'c'
		call Set_c_Title()
	elseif expand("%:e") == 'h'
		call Set_h_Title()
	elseif expand("%:e") == 'hpp'
		call Set_hpp_Title()
	endif
	"echohl WarningMsg | echo "Successful in adding copyright." | echohl None
endfunc


function UpdateScriptTitle()
	normal m'
	execute '/# LastChange\s*:/s@:.*$@\=strftime(": %Y-%m-%d")@'
	normal ''
	normal mk
	execute '/# Filename\s*:/s@:.*$@\=": ".expand("%:t")@'
	execute "noh"
	normal 'k
endfunction

function UpdateProgTitle()
	normal m'
	"execute '/* Last modified\s*:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
	execute '/* LastChange\s*:/s@:.*$@\=strftime(": %Y-%m-%d")@'
	normal ''
	normal mk
	execute '/* Filename\s*:/s@:.*$@\=": ".expand("%:t")@'
	execute "noh"
	normal 'k
endfunction

function VersionInc(line)
	let s:idx = strridx(a:line, 'v')
	let s:major = str2nr(strpart(a:line, s:idx+1, 1), 10)
	let s:minor = str2nr(strpart(a:line, s:idx+3, 1), 10)
	let s:revise = str2nr(strpart(a:line, s:idx+5, 2), 10)

	if s:revise < 99
		let s:revise += 1
	elseif s:minor < 9
		let s:revise = 0
		let s:minor += 1
	elseif s:major < 9
		let s:revise = 0
		let s:minor = 0
		let s:major += 1
	else
		echo "warning: version > 9.9.99!!"
	endif

	"echo "v" s:major s:minor s:revise
	let ver = "v" . s:major . "." . s:minor . "." . s:revise
	"echo ver

	normal gg
	if expand("%:e")=='sh' || expand("%:e") == 'py'
		execute '/#    Version\s*:/s@:.*$@\=": ".ver@'
	elseif expand("%:e") == 'cpp' || expand("%:e") == 'cc' || expand("%:e") == 'c' || expand("%:e") == 'h' || expand("%:e") == 'hpp'
		execute '/*    Version\s*:/s@:.*$@\=": ".ver@'
	endif
	execute "noh"
	normal 'k

	"echo s:major s:minor s:revise
endfunction

function UpdateTitle()
	if expand("%:e")=='sh' || expand("%:e") == 'py'
		call UpdateScriptTitle()
	elseif expand("%:e") == 'cpp' || expand("%:e") == 'cc' || expand("%:e") == 'c' || expand("%:e") == 'h' || expand("%:e") == 'hpp'
		call UpdateProgTitle()
	endif

	let n = 1
	while n<16
		let s:ver_line = getline(n)
		if s:ver_line =~ '^\s*\*\s*Version\s*:\s*\S*.*$' || s:ver_line =~ '^\s*\#\s*Version\s*:\s*\S*.*$'
			call VersionInc(s:ver_line)
			echohl WarningMsg | echo "Updating coryright Successfully !!" | echohl None
			unlet n
			return
		endif
		let n = n+1
	endwhile

endfunction


"create file settings
autocmd BufNewFile *.cpp,*.cc,*.c,*.hpp,*.h,*.sh,*.py exec ":call Additle()"

"新建文件后，自动定位到文件末尾
"autocmd BufNewFile * normal G

nmap <space>at :call AddTitle()<cr>
nmap <space>ut :call UpdateTitle()<cr>
