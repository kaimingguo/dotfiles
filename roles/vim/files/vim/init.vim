" $vimrc: init.vim,v 1.0 12/29/2020 02:30:40 CST augustin Exp $

"-
" Copyright 2020 Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.
"

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
if has('vim_starting')
  " Set compatibility to vim only.
  if &compatible | set nocompatible | endif
endif

" Initialize base requirements
if !has('g:mapleader')
  " Use [,] as leader required before loading plugins.
  let mapleader=','
  let g:mapleader=','
endif

let $VIM_PATH =
  \ get(g:, 'vim_path',
  \   exists('*stdpath') ? stdpath('config') :
  \   !empty($VIM_PATH) ? expand($VIM_PATH) :
  \   fnamemodify(resolve(expand('<sfile>:p')), ':h')
  \ )

let g:cache_path =
  \ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '$HOME/.cache')) . '/vim'

if &runtimepath !~# expand($VIM_PATH)
  execute 'set runtimepath^=' . $VIM_PATH
endif

execute 'source' fnameescape(expand($VIM_PATH) . '/core/basic.vim')

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 expandtab filetype=vim :
