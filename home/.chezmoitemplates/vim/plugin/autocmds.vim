" -*- mode: vim -*-
" vi: set ft=vim :

" vint: -ProhibitAbbreviationOption
let s:save_cpo = &cpo
set cpo&vim
" vint: +ProhibitAbbreviationOption

if has('autocmd')
  augroup auto_custom_settings
    " Clear the auto command group so we don't define it multiple time idea
    " from: http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
    autocmd!

    " When editing a file, always jump to the last current position
    " this must be after the uncompress command
    autocmd BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") |
          \ execute "normal! g'\"" | endif

    " Leave paste mode when leaving insert mode
    autocmd InsertLeave * set nopaste
  augroup END
endif

" vint: -ProhibitAbbreviationOption
let &cpo = s:save_cpo
unlet s:save_cpo
" vint: +ProhibitAbbreviationOption
