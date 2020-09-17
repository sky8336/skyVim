" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#syntax#p#array#load() abort " {{{1
  if has_key(b:vimtex_syntax, 'array') | return | endif
  let b:vimtex_syntax.array = 1

  call vimtex#syntax#p#tabularx#load()
  if !get(g:, 'tex_fast', 'M') =~# 'M' | return | endif

  let l:concealed = has('conceal')
        \ && &enc ==# 'utf-8'
        \ && get(g:, 'tex_conceal', 'd') =~# 'd'

  " Change inline math to improve column specifiers, e.g.
  "
  "   \begin{tabular}{*{3}{>{$}c<{$}}}
  "
  " See: https://en.wikibooks.org/wiki/LaTeX/Tables#Column_specification_using_.3E.7B.5Ccmd.7D_and_.3C.7B.5Ccmd.7D
  syntax clear texMathZoneX
  execute 'syntax region texMathZoneX'
        \ 'matchgroup=Delimiter'
        \ 'start="\([<>]{\)\@<!\$"'
        \ 'skip="\%(\\\\\)*\\\$"'
        \ 'end="\$"'
        \ 'end="%stopzone\>"'
        \ 'contains=@texMathZoneGroup'
        \ (l:concealed ? 'concealends' : '')
endfunction

" }}}1
