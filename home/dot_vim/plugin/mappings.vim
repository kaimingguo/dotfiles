" mappings.vim

" vint: -ProhibitAbbreviationOption
let s:save_cpo = &cpo
set cpo&vim
" vint: +ProhibitAbbreviationOption

" Keyboard shortcuts
nnoremap ; :
vnoremap ; :

""
" Multiple line increase/Decrease indent in visual mode
vnoremap < <gv
vnoremap > >gv

""
" Ctrl+c as Esc
nnoremap <C-c> <esc>
inoremap <C-c> <esc>
vnoremap <C-c> <esc>
snoremap <C-c> <esc>
xnoremap <C-c> <esc>
cnoremap <C-c> <esc>
onoremap <C-c> <esc>
lnoremap <C-c> <esc>
tnoremap <C-c> <esc>

""
" Yank entire buffer
nnoremap yg :0,$ y<cr>

""
" Select entire buffer
nnoremap yv ggVG

""
" Copy the current line like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

""
" Smart way to move between window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

""
" Create newlines without entering insert mode
nnoremap go o<esc>k
nnoremap gO O<esc>j

""
" Move visual block
vnoremap <silent> J :m '>+1<cr>gv=gv'
vnoremap <silent> K :m '<-2<cr>gv=gv'

""
" Inserts the path of the currently edited file into a command
cnoremap <C-p> <C-r>=expand('%:p:%h') . '/'<cr>

""
" Clear current search highlight
nnoremap <silent> <leader>/ :nohlsearch<cr>

""
" Set working directory
nnoremap <leader>. :lcd %:p:h<cr>

""
" Split window vertically or horizontally and switch to the new split
nnoremap <silent> <leader>ss :split<bar>:wincmd j <cr>:wincmd =<cr>
nnoremap <silent> <leader>sv :vsplit<bar>:wincmd l <cr>:wincmd =<cr>

""
" Highlight search word under cursor without jumping to next
noremap <leader>h *<C-o>

""
" Swap windows
nnoremap <silent>sx :wincmd x<cr>

""
" Equal size windows
nnoremap <silent>s= :wincmd =<cr>

""
" Do not move on *
nnoremap <silent>* :let stay_star_view=winsaveview()<cr>
      \ *:call winrestview(stay_star_view)<cr>

""
" Press esc key to exit terminal mode
tnoremap <esc> <C-\><C-n>

nnoremap [q :cprevious<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
nnoremap [l :lnext<cr>
nnoremap ]l :lprevious<cr>
nnoremap [b :bnext<cr>
nnoremap ]b :bprevious<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>
nnoremap [t :tabnext<cr>
nnoremap ]t :tabprevious<cr>
nnoremap [T :tabfirst<cr>
nnoremap ]T :tablast<cr>

noremap t :edit<space>
noremap <S-t> :tabedit<space>
noremap <leader>t :edit <C-r>=expand('%:p:h') . '/'<cr>
noremap <leader><S-t> :tabedit <C-r>=expand('%:p:h') . '/'<cr>

noremap <silent> <leader>x :Bclose<cr>
noremap <silent> <leader><S-x> :tabclose<cr>

""
" Type 'dts' in insert mode to expand to datastamp.
"
" > dts<space> || dts<esc>
" -- replace to --
" 01/07/2021 17:57:04 CST
"
" Reference: https://vim.fandom.com/wiki/insert_current_date_or_time
let g:dts_format = get(g:, 'dts_format', '%Y/%m/%d %H:%M:%S %Z')
iabbrev dts <C-r>=strftime(g:dts_format)<cr>

" vint: -ProhibitAbbreviationOption
let &cpo = s:save_cpo
unlet s:save_cpo
" vint: +ProhibitAbbreviationOption

" vim: set tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=78 :
" vim: set fileencoding=utf-8 filetype=vim foldenable foldmethod=marker :
