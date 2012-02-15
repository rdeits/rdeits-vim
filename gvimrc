if has("gui_macvim")
	" Fullscreen takes up entire screen
	set fuoptions=maxhorz,maxvert

	" Command-Return for fullscreen
	macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

	" Command-Shift-F for Ack
	map <D-F> :Ack<space>

	"Command T config
	macmenu &File.New\ Tab key=<nop>
	map <D-t> :CommandT<CR>
	imap <D-t> <esc>:CommandT<cr>i
    " map <D-t> <Plug>PeepOpen
    " imap <D-t> <esc><Plug>PeepOpen

	" Command-e for ConqueTerm
	map <D-e> :call StartTerm()<CR>

	" Command-/ to toggle comments
	map <D-/> <plug>NERDCommenterToggle<CR>
	imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

	" Adjust viewports to the same size
	" map <Leader>= <C-w>=
	" imap <Leader>= <Esc> <C-w>=
endif

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

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \ 
endfunction

" Nerd tree configuration
" runtime NERD_tree_config.vim

" Map backspace to d (to delete characters) in visual mode
vnoremap <BS> ""di

" Use visual mode, not select mode, when selecting with the mouse
set selectmode=

" MiniBufExplorer config
" hi link MBEVisibleChangedActive Search

set t_vb=
