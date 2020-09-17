source common.vim

silent edit test-minted.tex

if empty($INMAKE) | finish | endif

" Minted inside \paragraphs (#1537)
call vimtex#test#assert(vimtex#syntax#in('javaScopeDecl', 72, 3))

" Newminted on unrecognized languages (#1616)
call vimtex#test#assert(vimtex#syntax#in('texZoneMintedLog', 112, 1))
call vimtex#test#assert(vimtex#syntax#in('texZoneMintedShellsession', 116, 1))

" Doing :e should not destroy nested syntax and similar
call vimtex#test#assert(vimtex#syntax#in('pythonFunction', 38, 5))
edit
call vimtex#test#assert(vimtex#syntax#in('pythonFunction', 38, 5))

quit!
