"
"
"
"

" GENERAL SETTINGS: {{{1
set number	" 显示行号

" color
hi IncSearch            ctermfg=DarkYellow      ctermbg=Black  cterm=bold
hi Search               ctermfg=Black           ctermbg=Yellow cterm=bold


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
