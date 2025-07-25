" -*- mode: vim -*-
" vi: set ft=vim :

" vint: -ProhibitAbbreviationOption
let s:save_cpo = &cpo
set cpo&vim
" vint: +ProhibitAbbreviationOption

function! s:BufClose(...) abort
  let l:current_buf_num = bufnr('%')
  let l:alternate_buf_num = bufnr('#')

  if buflisted(l:alternate_buf_num)
    buffer #
  else
    bnext
  endif

  if bufnr('%') is# l:current_buf_num
    new
  endif

  if buflisted(l:current_buf_num)
    execute('bdelete! ' . l:current_buf_num)
  endif
endfunction
command! Bclose call <sid>BufClose()

" vint: -ProhibitAbbreviationOption
let &cpo = s:save_cpo
unlet s:save_cpo
" vint: +ProhibitAbbreviationOption
