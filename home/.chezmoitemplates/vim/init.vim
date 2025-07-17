" -*- mode: vim -*-
" vi: set ft=vim :

set encoding=utf-8
scriptencoding utf-8

" -------------
" Compatibility
" -------------

" set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
if has('vim_starting')
  " set compatiblity to vim only
  if &compatible | set nocompatible | endif
endif

" Load user-specific settings if file exists
if filereadable(expand('$HOME/.vim_profile'))
  execute 'source' fnameescape(expand('$HOME/.vim_profile'))
endif

" Initialize base requirements
let g:mapleader = get(g:, 'mapleader', "\<Space>")
let mapleader = g:mapleader

" -----------
" Text Editor
" -----------

" Encoding and file formats
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,cp936,latin1,cp950
if exists('+termencoding')
  set termencoding=utf-8
endif
set fileformats=unix,dos,mac

" File type detection and syntax
filetype plugin indent on
syntax enable

" Indentation (optimized for C++)
set autoindent
set cindent
set smartindent

" Line display and navigation
set number
set norelativenumber
set scrolloff=8
set sidescrolloff=8
set wrap
if has('linebreak')
  set linebreak
  set breakindent
endif

" Color column for code style
if exists('+colorcolumn')
  let g:rulers = get(g:, 'rulers', [])
  silent execute 'set colorcolumn=' . join(g:rulers, ',')
endif

" Search configuration
set incsearch
set ignorecase
set smartcase
set hlsearch
set wrapscan

" Text editing behavior
set nojoinspaces
set backspace=indent,eol,start
set showmatch
set matchtime=2

" auto-formatting
set formatoptions=tcqrn1
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j " Delete comment characters when joining commented lines
endif

"----------
" Workbench
" ---------

" GUI Settings
if has('gui_running')
  set guioptions=Mc!
  set guitablabel=%M\ %t

  " Cross-platform font configuration (with CJK support)
  if has('mac') || has('macunix')
    silent! set guifont=JetBrains\ Mono:h12,IBM\ Plex\ Mono:h12,PingFang\ TC:h12,Hack:h12
    set transparency=2
    set macmeta
  elseif has('win16') || has('win32')
    silent! set guifont=JetBrains_Mono:h12,IBM_Plex_Mono:h12,Microsoft_JhengHei:h12,Hack:h12
  elseif has('gui_gtk2')
    silent! set guifont=JetBrains\ Mono \12,IBM\ Plex\ Mono \12,Noto\ Sans\ CJK\ TC\ 12,Hack\ 12
  elseif has('unix')
    silent! set guifont=Monospace \12,Noto\ Sans\ CJK\ TC\ 12
  endif
endif

" Terminal color support
if &term =~? '256color'
  if !has('gui_running') | set t_Co=256 | endif
  set t_ut=
endif

" True color support
if exists('+termguicolors') && $TERM_PROGRAM !=# 'Apple_Terminal' && $USER isnot# 'root'
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Buffer and tab behavior
set switchbuf=useopen,usetab,newtab
set showtabline=2
set laststatus=2
set cmdheight=1
set ruler
set showmode

" Window spliting
set splitright
set splitbelow

" Visual and sound settings
set noerrorbells
set novisualbell
set t_vb=

" --------
" Features
" --------

set history=500

" Command line completion
set wildmode=longest:full,full
let s:wild_ignore = [
      \ '*/.svn', '*/.git', '*/.hg',
      \ '*.o', '*.obj', '*.exe', '*.dll', '*.so', '*.dylib',
      \ '*.pyc', '*.pyo', '*.class', '*.jar',
      \ '*.swp', '*.swo', '*~',
      \ '*.png', '*.jpg', '*.jpeg', '*.gif', '*.bmp', '*.ico',
      \ '*/node_modules', '*/__pycache__',
      \ ]
if exists('g:wild_ignore')
  call extend(s:wild_ignore, g:wild_ignore)
endif
silent execute 'set wildignore+=' . join(uniq(sort(s:wild_ignore)), ',')
unlet s:wild_ignore

" File handling
set autoread
set autowrite
set lazyredraw
set magic

" Backup and swap files
set nobackup
set noswapfile
set nowritebackup
if has('persistent_undo')
  set undofile
  let s:cache_dir = exists('*stdpath') ? stdpath('cache') :
        \ has('win32') || has('win64') ? expand('$LOCALAPPDATA/Temp/vim') :
        \ !empty($XDG_CACHE_HOME) ? expand('$XDG_CACHE_HOME/vim') :
        \ has('win32unix') && !empty($TEMP) ? expand('$TEMP/vim') :
        \ expand('$HOME/.cache/vim')
  execute 'set undodir=' . expand(fnamemodify(s:cache_dir, ':r') . '/undo')
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
  unlet s:cache_dir
endif

" Timing
set notimeout
set ttimeout
set ttimeoutlen=100
set updatetime=300

" Buffer management
set hidden
set confirm

" Regular expressions
set regexpengine=0

" Mouse support
set mouse=a
set mousehide

" Clipboard integration
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif

" Terminal mouse support
if has('mouse_sgr') | set ttymouse=sgr | endif

" Diff options
if has('patch-8.1.0360')
  set diffopt+=internal,algorithm:patience
endif

" Grep configuration
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep\ --hidden\ --smart-case
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Load end user-specific settings if file exists
if filereadable(expand('$HOME/.vim_after'))
  execute 'source' fnameescape(expand('$HOME/.vim_after'))
endif
