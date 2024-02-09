" init.vim

set encoding=utf-8
scriptencoding utf-8

if has('vim_starting')
  if &compatible | set nocompatible | endif
endif

if filereadable(expand('~/.vim_profile'))
  execute 'source' fnameescape(expand('~/.vim_profile'))
endif

" Text Editor {{{1

" Encoding
set fileencoding=utf-8
set fileencodings=utf-8
if exists('+termencoding')
  set termencoding=utf-8
endif

" The default and of line character
set fileformats=unix,dos,mac

" Enable file type plugins
filetype plugin on
filetype indent on

" Enable syntax highlight
syntax enable

" Auto-indent spaces with C in vim
set autoindent
set cindent
set smartindent

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Display line numbers on the left
set number
set norelativenumber
set signcolumn=no

set linebreak
set textwidth=500
set wrap

if exists('+colorcolumn')
  let g:rulers = get(g:, 'rulers', [])
  execute 'set colorcolumn=' . join(g:rulers, ',')
endif

" 1}}}

" Workbench {{{1

if has('gui_running')
  set guioptions=Mc!
  set guitablabel=%M\ %t

  if has('mac') || has('macunix')
    silent! set guifont=IBM\ Plex\ Mono:h11,Hack:h11,Source\ Code\ Pro:h11,Menlo:h11
    set transparency=2
    " Use option (alt) as meta key
    set macmeta
  elseif has('win16') || has('win32')
    silent! set guifont=IBM\ Plex\ Mono:h11,Hack:h11,Source\ Code\ Pro:h11,Menlo:h11
  elseif has('gui_gtk2')
    silent! set guifont=IBM\ Plex\ Mono\ 11,Hack\ 11,Source\ Code\ Pro\ 11,Menlo\ 11
  elseif has('unix')
    silent! set guifont=Monospace\ 11
  endif
endif

if &term =~ '256color'
  if !has('gui_running') | set t_Co=256 | endif
  set t_ut=
endif

if exists('+termguicolors') && $TERM_PROGRAM !=# 'Apple_Terminal' && $USER isnot 'root'
  let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Mode settings
" Reference:
" https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI .= "\e[5 q"  " SI = INSERT mode
let &t_SR .= "\e[4 q"  " SR = REPLACE mode
let &t_EI .= "\e[1 q"  " EL = NORMAL mode (ELSE)

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set showtabline=2
catch
endtry

" Always show the status line
set laststatus=2

" Height of the command bar
set cmdheight=1

" Always show current position
set ruler

" 1}}}

" Features {{{1

set wildmenu
set wildmode=list:longest
let s:wild_ignore_files = [
      \ '.svn', '.hg', '.git',
      \ '*~', '*.png', '*.jpg', '*.gif',
      \ ]
if exists('g:wild_ignore_files')
  call extend(s:wild_ignore_files, g:wild_ignore_files)
endif
execute 'set wildignore+=' . join(uniq(sort(s:wild_ignore_files)), ',')
unlet s:wild_ignore_files

set autoread
set nojoinspaces
set splitright
set splitbelow
set lazyredraw
set magic
set showmatch
set matchtime=5
set backspace=eol,start,indent

set nobackup
set noswapfile
set nowritebackup

" Proper search
set incsearch
set ignorecase
set smartcase
set hlsearch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Quickly time out on keycodes, but never time out on mappings
set notimeout
set ttimeout
set ttimeoutlen=200

" Remove the show mode at last line
set noshowmode

" A buffer becomes hidden when it is abandoned
set hidden

" Set regular expression engine automatically
set regexpengine=0

" Enable mouse in normal/visual mode and hidden when typed
set mouse=nv
set mousehide

" Yanks go on clipboard instead
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
  else
    set clipboard=unnamed
  endif
endif

if has('mouse_sgr') | set ttymouse=sgr | endif
if has('printer')
  set printfont=:h10
  set printencoding=utf-8
  set printoptions=paper:letter
endif

try
  set diffopt+=iwhite
  set diffopt+=algorithm:patience
  set diffopt+=indent-heuristic
catch
endtry

if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l%c:%m
endif

" 1}}}

" Extensions {{{1
" ayu-vim {{{2
let g:ayucolor = 'dark'
try
  silent! colorscheme ayu
catch
endtry
" 2}}}
" asyncomplete.vim, vim-lsp {{{2
let g:lsp_format_sync_timeout = 1000
let g:lsp_preview_float = 1
let g:lsp_inlay_hints_enabled = 0
let g:lsp_semantic_enabled = 1
let g:lsp_work_done_progress_enabled = 1

hi! LspErrorHighlight guifg=#dc322f guibg=NONE guisp=#dc322f gui=undercurl cterm=undercurl
hi! LspInfoHighlight guifg=#2aa198 guibg=NONE guisp=#2aa198 gui=undercurl cterm=undercurl
hi! LspWarningHighlight guifg=#b58900 guibg=NONE guisp=#b58900 gui=undercurl cterm=undercurl

if !has('vsvim')
  inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
  inoremap <expr> <C-h> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
  inoremap <expr> <C-y> pumvisible() ? asyncomplete#close_popup() : "\<C-y>"
  inoremap <expr> <C-e> pumvisible() ? asyncomplete#cancel_popup() : "\<C-e>"
  inoremap <expr> <C-j> ("\<C-n>")
  inoremap <expr> <C-k> ("\<C-p>")

  autocmd! CompleteDone * if !pumvisible() | pclose | endif
endif

if has('autocmd')
  augroup auto_lsp_settings
    autocmd!
    autocmd User lsp_buffer_enabled call <sid>OnLspBufferEnabled()
  augroup END
endif

function! s:OnLspBufferEnabled(...) abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nnoremap <buffer> gd <plug>(lsp-definition)
  nnoremap <buffer> gs <plug>(lsp-document-symbol-search)
  nnoremap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nnoremap <buffer> gr <plug>(lsp-reference)
  nnoremap <buffer> gi <plug>(lsp-implementation)
  nnoremap <buffer> gt <plug>(lsp-type-definition)
  nnoremap <buffer> <leader>rn <plug>(lsp-rename)
  nnoremap <buffer> [g <plug>(lsp-previous-diagnostic)
  nnoremap <buffer> ]g <plug>(lsp-next-diagnostic)
  nnoremap <buffer> K <plug>(lsp-hover)
  if has('nvim')
    nnoremap <buffer> <leader>ca :LspCodeAction<cr>
    xnoremap <buffer> <leader>ca :LspCodeAction<cr>
  else
    nnoremap <buffer> <leader>ca :LspCodeAction<cr>
  endif

  nnoremap <buffer> gQ :<C-u>LspDocumentFormat<cr>
  vnoremap <buffer> gQ :LspDocumentRangeFormat<cr>

  if has('autocmd')
    augroup auto_lsp_document_format_sync
      autocmd!
      autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    augroup END
  endif
endfunction
" 2}}}
" ctrlsf.vim {{{2
let g:ctrlsf_auto_focus = {
      \ 'at': 'start'
      \ }

nnoremap <C-f>f <plug>CtrlSFPrompt
vnoremap <C-f>f <plug>CtrlSFVwordPath
vnoremap <C-f>F <plug>CtrlSFVwordExec
nnoremap <C-f>n <plug>CtrlSFCwordPath
nnoremap <C-f>p <plug>CtrlSFPwordPath
nnoremap <C-f>t :CtrlSFToggle<cr>
inoremap <C-f>t <esc>:CtrlSFToggle<cr>
" 2}}}
" lightline.vim {{{2
let g:lightline = {
      \ 'colorscheme': 'ayu_dark',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['lsp_progress'],
      \   ],
      \ },
      \ 'component_function': {
      \   'lsp_progress': 'LightlineLspProgress',
      \ },
      \ }

if has('autocmd')
  augroup auto_lightline_lsp_settings
    autocmd!
    autocmd User lsp_progress_updated call lightline#update()
  augroup END
endif

function! LightlineLspProgress(...) abort
  try
    let l:progress = lsp#get_progress()
    if empty(l:progress) | return '' | endif

    let l:progress = l:progress[len(l:progress) - 1]
    return l:progress['server'] . ': ' . l:progress['message']
  catch
    return ''
  endtry
endfunction
" 2}}}
" vim-easymotion {{{2
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

nnoremap s <plug>(easymotion-sn)
nnoremap S <plug>(easymotion-overwin-f)
noremap <leader>j <plug>(easymotion-j)
noremap <leader>k <plug>(easymotion-k)
" 2}}}
" vimwiki {{{2
let g:vimwiki_global_ext = 0

let g:vimwiki_list = get(g:, 'vimwiki_list', [])
for vimwiki in g:vimwiki_list
  let s:vim_path = exists('*stdpath')
        \ ? stdpath('config')
        \ : fnamemodify(resolve(expand('<sfile>:p')), ':h')

  if !has_key(vimwiki, 'template_path')
    let vimwiki.template_path = s:vim_path . '/templates/'
  endif
  if !has_key(vimwiki, 'custom_wiki2html')
    let vimwiki.custom_wiki2html = s:vim_path . '/scripts/wiki2html.sh'
  endif
endfor
" 2}}}
" 1}}}

if filereadable(expand('~/.vim_after'))
  execute 'source' fnameescape(expand('~/.vim_after'))
endif

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=78 :
" vim: set fileencoding=utf-8 filetype=vim foldenable foldmethod=marker :
