" Start without the toolbar
set guioptions-=T

" Default gui color scheme
" set background=dark
" color ir_black
" colorscheme desert-mod
" let moria_style='dark'
" let g:moria_monochrome=0
" color moria
set background=dark
let g:solarized_contrast='high'
color solarized
set cursorline

runtime NERD_tree_config.vim

" Map backspace to d (to delete characters) in visual mode
vnoremap <BS> ""di

" Use visual mode, not select mode, when selecting with the mouse
set selectmode=

set t_vb=
