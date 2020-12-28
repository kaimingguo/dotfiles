" $vimrc: core/basic.vim,v 1.0 12/29/2020 02:02:24 CST augustin Exp $

"-
" Copyright 2020 Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.
"

" AUTO COMMANDS {{{

if has('autocmd')
  augroup auto_custom_settings
    " Clear the auto command group so we don't define it multiple times idea
    " from: http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
    autocmd!

    " When editing a file, always jump to the last current position this
    " must be after the uncompress command
    autocmd BufReadPost * if line("\"") > 1 && line("'\"") <= line('$') |
      \ execute "normal! g'\"" | endif

    " Resize splits when the window resized
    " from: https://bitbuck.org/sjl/dotfiles/src/tip/vim/vimrc
    autocmd VimResized * :wincmd =

    " Disable visualbell
    autocmd GUIEnter * set visualbell t_vb=

    " The PC is fast enough, do syntax highlight syncing from start unless
    " 200 lines
    autocmd BufEnter * :syntax sync maxlines=200
  augroup END

  augroup auto_make_settings
    autocmd!
    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
  augroup END
endif

" }}}

" GENERNAL {{{

" Sets how many lines of history vim has to remember
set history=2048

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific
filetype indent plugin on

" Set to auto read when a file is change from the outside
set autoread

" }}}

" VIM USER INTERFACE {{{

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
set langmenu=en
exec 'source ' . $VIMRUNTIME . '/delmenu.vim'
exec 'source ' . $VIMRUNTIME . '/menu.vim'

" Better command-line completion
set wildmenu

" ignore compiled files
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" Display line numbers on the left
set number

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Highlight search results
set hlsearch

" Vim loves to redraw the screen during things it probably doesn't need
" to--like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros
set lazyredraw

" For regular expressions turn magic on
set magic

" With `showmatch`, when your cursor moves over a parenthesis-like
" character, the matching one will be highlighted as well
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=5

" No annoying sound on errors
set noerrorbells visualbell t_vb=

" Color the 80th column differently as a wrapping guide
if exists('+colorcolumn')
  set colorcolumn=80
endif

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" }}}

" COLORS AND FONTS {{{

" Enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Force 256 color mode if available
if $TERM =~ '-256color'
  set t_Co=256
  set t_ut=
endif

" }}}

" FILES AND BACKUPS {{{

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" }}}

" TEXT, TAB, AND INDENT RELATED {{{

" Yanks go on clipboard instead
if has('clipboard')
  if has('unnamedplus')
    " when possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else
    " on macOS and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" Linebreak on 500 characters
set linebreak
set textwidth=500

" Use multiple of shiftwidth when indenting with '<' nad '>'
set shiftround

" Auto-indent spaces with C in vim
set autoindent
set cindent

" }}}

" MOVING AROUND, TABS AND BUFFERS {{{

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" }}}

" STATUS LINE {{{

" display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" always display the status line, even if only one window is displayed
set laststatus=2

" set the command window height to 2 lines, to avoid many cases of having to
" `press <Enter> to continue`
set cmdheight=2

" default status line format
set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P

" }}}

" MISC {{{

" Enable mouse in normal/visual mode only
set mouse=nv

" Hiden when characters are typed
set mousehide

if has('*mouse_sgr')
  set ttymouse=sgr
endif

" }}}

" PLATFORM OPTIONS {{{

" Set extra options when running in GUI mode
if has('gui_running')
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
  set tm=500
endif

if has('mac') || has('macunix')
  if has('gui_running')
    if has('gui_mac') || has('gui_macvim')
      set guifont=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
      set transparency=7
    endif
    " use option (alt) as meta key
    set macmeta
  endif
elseif has('win16') || has('win32')
  set guifont=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has('gui_gtk2')
  set guifont=IBM\ Plex\ Mono\ 14,Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has('unix')
  set guifont=Monospace\ 11
endif

" }}}

" HELPER FUNCTION AND COMMANDS {{{

" No one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" silently execute an external command
" No 'Press Any Key to Contiue BS'
" From: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
command! -nargs=1 SilentCmd
  \ | execute ':silent !' . <q-args>
  \ | execute ':redraw!'

""
" @private
" Don't close window, when deleting a last buffer.
function! s:BufClose() abort
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

""
" @private
" Quick spelling fix (first item in z= list)
function! s:QuickSpellingFix() abort
  if &spell
    normal 1z=
  else
    " Enable spelling mode and do the correction
    set spell
    normal 1z=
    set nospell
  endif
endfunction
command! QuickSpellingFix call <sid>QuickSpellingFix()

""
" @private
" Paste using paste mode, keeps indentation in source.
function! s:PasteWithPasteMode() abort
  if &paste
    normal p
  else
    " Enable paste mode and paste the text, then disable paste mode.
    set paste
    normal p
    set nopaste
  endif
endfunction
command! PasteWithPasteMode call <sid>PasteWithPasteMode()

" }}}

" vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2 textwidth=78 :
" vim: set foldenable foldmethod=marker filetype=vim :
