# Vim Configuration Files

VimL: Opinionated Vim Configuration

## Vim Requirements

The distribution is designed to work with Vim >= 8.1 (neovim >= 0.3.8).

This also requires `python`, `git` support.

### Plugins Requirements

Use `pack` to management plug-ins.

- `vimwiki`: requirement `pandoc` to generate HTML file.

## Configuration

You can add `~/.vim_profile` to set up variables and `~/.vim_after`
overwrite default configuration.

### Sample

Add the rules:

```
" add to ~/.vim_profile
let g:rulers = [80, 100]
```

Auto toggle appearance mode in macOS:

```
" add to ~/.vim_after
try
  if exists('+termguicolors') && $TERM_PROGRAM !=# 'Apple_Terminal' && $USER !=# 'root'
    let &t_8f = "\<esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
catch
endtry

if has('autocmd')
  augroup auto_toggle_appearance
    autocmd!
    autocmd VimEnter,InsertLeave * :call <sid>ToggleAppearanceMode()
  augroup END
endif

function! s:ToggleAppearanceMode(...) abort
  let g:colors_name = get(g:, 'colors_name', '')
  if g:colors_name is# '' | return | endif
  
  let l:mode = 'dark'
  if has('mac') && has('macunix')
    if $TERM_PROGRAM isnot# 'Apple_Terminal' && exists('$LC_TERMINAL')
      return
    endif
  endif
  
  if has('mac') && system('defaults read -g AppleInterfaceStyle') !~# '^Dark'
    let l:mode = 'light'
  endif
  
  try
    if g:colors_name is# 'ayu' | let g:ayucolor = l:mode | endif
    execute 'set background=' . l:mode
    execute 'silent! colorscheme ' . g:colors_name
  catch
  endtry
  
  if !exists('g:loaded_lightline') | return | endif
  try
    if g:colors_name =~# 'wombat\|solarized\|ayu\|jellybeans\|Tomorrow'
      let g:lightline.colorscheme = substitute(substitute(g:colors_name, '-', '_', 'g'), '256.*', '', '') .
            \ (g:colors_name ==# 'ayu' ? '_' . &background : '')
	    
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
    endif
  catch
  endtry
endfunction
```

## Mappings

The leader key use `,`, so when ever you see `<leader>` it meas `,` key.

## Extensions

### Vimwiki

<!-- TODO: Use vimwiki_default configuration sample here. -->
