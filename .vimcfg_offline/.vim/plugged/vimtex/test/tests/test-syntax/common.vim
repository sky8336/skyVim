set nocompatible
let &rtp = '../../..,' . &rtp
let &rtp .= ',../../../after'
filetype plugin on
syntax enable

set nomore

let g:tex_flavor = 'latex'

nnoremap q :qall!<cr>

" Use a more colorful colorscheme
colorscheme morning

function! SynNames()
  return join(vimtex#syntax#stack(), ' -> ')
endfunction

if empty($INMAKE)
  augroup Testing
    autocmd!
    autocmd CursorMoved * echo SynNames()
  augroup END
endif
