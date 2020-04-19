" stripTrailing.vim - Vim SetTitle function.
"
" Copyright (c) 2019 sky8336. All Rights Reserved.
"
" Maintainer: sky8336 <1919592995@qq.com>
"    Created: 2019-08-24
"------------------------------
" LastChange: 2020-04-19
"    Version: v0.0.3
"""""""""""""""""""""""""""""""""""""""""""""""""""""

function! WhitespaceStripTrailing()
	let previous_search=@/
	let previous_cursor_line=line('.')
	let previous_cursor_column=col('.')
	%s/\s\+$//e
	let @/=previous_search
	call cursor(previous_cursor_line, previous_cursor_column)
endfunction

" whitespace  去除文件的行尾空白, issue: macro
"autocmd BufWritePre *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.sh,*.py call WhitespaceStripTrailing()

autocmd WinLeave,BufLeave *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.sh,*.py call WhitespaceStripTrailing()
