" vimtex - LaTeX plugin for Vim
"
" Maintainer: Karl Yngve Lervåg
" Email:      karl.yngve@gmail.com
"

function! vimtex#include#expr() abort " {{{1
  call s:visited.timeout()
  let l:fname = substitute(v:fname, '^\s*\|\s*$', '', 'g')

  "
  " Check if v:fname matches exactly
  "
  if filereadable(l:fname)
    return s:visited.check(l:fname)
  endif

  "
  " Parse \include or \input style lines
  "
  let l:file = s:input(l:fname, 'tex')
  for l:candidate in [l:file, l:file . '.tex']
    if filereadable(l:candidate)
      return s:visited.check(l:candidate)
    endif
  endfor

  "
  " Parse \bibliography or \addbibresource
  "
  let l:candidate = s:input(l:fname, 'bib')
  if filereadable(l:candidate)
    return s:visited.check(l:candidate)
  endif

  "
  " Search for file with kpsewhich
  "
  if g:vimtex_include_search_enabled
    for l:file in s:gather_candidates(l:fname)
      let l:candidate = s:kpsewhich_find(l:file)
      if !empty(l:candidate)
        return s:visited.check(l:candidate)
      endif
    endfor
  endif

  return s:visited.check(l:fname)
endfunction

" }}}1

function! s:input(fname, type) abort " {{{1
  let [l:lnum, l:cnum] = searchpos(g:vimtex#re#{a:type}_input, 'bcn', line('.'))
  if l:lnum == 0 | return a:fname | endif

  let l:cmd = vimtex#cmd#get_at(l:lnum, l:cnum)
  let l:file = join(map(
        \   get(l:cmd, 'args', [{}]),
        \   "get(v:val, 'text', '')"),
        \ '')
  let l:file = substitute(l:file, '^\s*"\|"\s*$', '', 'g')
  let l:file = substitute(l:file, '\\space', '', 'g')

  return l:file
endfunction

" }}}1
function! s:gather_candidates(fname) abort " {{{1
  " Split input list on commas, and if applicable, ensure that the entry that
  " the cursor is on is placed first in the queue
  let l:files = split(a:fname, '\s*,\s*')
  let l:current = expand('<cword>')
  let l:index = index(l:files, l:current)
  if l:index >= 0
    call remove(l:files, l:index)
    let l:files = [l:current] + l:files
  endif

  " Add file extensions to create the final list of candidate files
  let l:candidates = []
  for l:file in l:files
    if !empty(fnamemodify(l:file, ':e'))
      call add(l:candidates, l:file)
    else
      call extend(l:candidates, map(split(&l:suffixesadd, ','), 'l:file . v:val'))
    endif
  endfor

  return l:candidates
endfunction

" }}}1
function! s:kpsewhich_find(fname) abort " {{{1
  if !has_key(s:kpsewhich_cache, a:fname)
    let l:file = vimtex#kpsewhich#find(a:fname)
    if filereadable(l:file)
      let s:kpsewhich_cache[a:fname] = l:file
    else
      let s:kpsewhich_cache[a:fname] = ''
    endif
  endif
  return s:kpsewhich_cache[a:fname]
endfunction

" }}}1

let s:visited = {
      \ 'time' : 0,
      \ 'list' : [],
      \}
function! s:visited.timeout() abort dict " {{{1
  if localtime() - self.time > 1
    let self.time = localtime()
    let self.list = [expand('%:p')]
  endif
endfunction

" }}}1
function! s:visited.check(fname) abort dict " {{{1
  if index(self.list, fnamemodify(a:fname, ':p')) < 0
    call add(self.list, fnamemodify(a:fname, ':p'))
    return a:fname
  endif

  return ''
endfunction

" }}}1

let s:kpsewhich_cache = {}
