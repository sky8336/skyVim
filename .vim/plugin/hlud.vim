" hlud.vim - highlight user definitions, such as types functions defines...
" LastChange: 2011-01-04
" Maintainer: Jeffy Du <jeffy.du@163.com>
"
" License:    This file is placed in the public domain

if exists('loaded_hlud')
	finish
endif
let loaded_hlud = 1

" save cpo
let s:save_cpo = &cpo
set cpo&vim

" flag for tags type
" "d" - macro define
" "e" - enum item
" "f" - function
let s:HLUDFlag = ['d', 'e', 'f', 'g', 'p', 's', 't', 'u']
let s:HLUDType = []

" file for save HLUD tags data
let s:HLUD_TagsFile = 'tags.ut'

" Initialize stript
function! HLUDInit(TagFilename)
	if filereadable(a:TagFilename)
		let s:HLUDType = readfile(a:TagFilename)
	else
		for idx in range(0, len(s:HLUDFlag))
			let s:HLUDType = add(s:HLUDType, '_________X ')
		endfor
	endif
endfunction

" get tag data by tag flag
function! HLUDGetTags(flag)
	let s:idx = index(s:HLUDFlag, a:flag)
	if s:idx != -1
		return s:HLUDType[s:idx]
	else
		return '_________X '
	endif
endfunction

" highlight tags data
function! HLUDColor()
	exec 'syn keyword cUserTypes ' . HLUDGetTags('t') . HLUDGetTags('u') . 
				\HLUDGetTags('s') . HLUDGetTags('g')
	exec 'syn keyword cUserDefines ' . HLUDGetTags('d') . HLUDGetTags('e')
	exec 'syn keyword cUserFunctions ' . HLUDGetTags('f') . HLUDGetTags('p')
	exec 'hi cUserTypes ctermfg=green'
	exec 'hi cUserDefines ctermfg=red'
	exec 'hi cUserFunctions ctermfg=magenta'
endfunction

" sync tag data
function! HLUDSync()
	" if tag file is not exist, do nothing.
	if !filereadable("tags")
		echo "err: no tags file"
		return
	endif

	" parse tag file line by line.
	echo "Generate usertype tags..."
	for line in readfile("tags")
		" parse tag flag
		let s:idx = stridx(line, ';"' . "\t")
		if s:idx != -1
			let s:flag = strpart(line, s:idx+3, 1)

			" parse and save flag
			let s:idx = index(s:HLUDFlag, s:flag)
			if s:idx != -1
				let s:HLUDType[s:idx] = s:HLUDType[s:idx] . matchstr(line, '^\<\h\w*\>') . ' '
			endif
		endif
	endfor
	echon "done"

	" write tags data to file.
	call writefile(s:HLUDType, s:HLUD_TagsFile)

	" highlight tags
	call HLUDColor()
endfunction

autocmd BufEnter,FileType c,cpp call HLUDColor()

call HLUDInit(s:HLUD_TagsFile)

let &cpo = s:save_cpo
