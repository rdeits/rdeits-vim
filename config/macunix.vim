" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" Make it easier to open the current folder in Finder (mac only)
map <C-o> :cd `dirname %`<cr>:silent !open .<cr>
imap <C-o> <Esc>:cd `dirname %`<cr>:silent !open .<cr>i
" Set path for exuberant ctags utility
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
" Use option as a meta key
set macmeta
imap <M-a> M-a

" LilyPond compilation and editing
filetype off
set runtimepath+=/Applications/LilyPond.app/Contents/Resources/share/lilypond/current/vim/
filetype on

" Mac folder names to ignore (for command-t)
set wildignore+=Desktop,Applications,Downloads,Documents,Games,Movies,Music,Pictures,VirtualMachines

" Transparency
set transparency=1
set guifont=DejaVu\ Sans\ Mono:h12

if has("gui_macvim")
	" Fullscreen takes up entire screen
	set fuoptions=maxhorz,maxvert

	" Command-Return for fullscreen
	macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

	" Command-Shift-F for Ack
	map <D-F> :Ack<space>

	" Command-/ to toggle comments
	map <D-/> <plug>NERDCommenterToggle<CR>
	imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

	" Adjust viewports to the same size
	" map <Leader>= <C-w>=
	" imap <Leader>= <Esc> <C-w>=
endif

