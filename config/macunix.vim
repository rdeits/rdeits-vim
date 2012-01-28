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

" Transparency
set transparency=1
set guifont=DejaVu\ Sans\ Mono:h12
