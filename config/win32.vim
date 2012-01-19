" Create nice MSWindows behavior for things like copy/paste.
runtime mswin.vim
" Windows font setting
set guifont=Consolas:h11:cANSI
set lines=60
cd $HOME
map <M-/> <plug>NERDCommenterToggle<CR>
imap <M-/> <Esc><plug>NERDCommenterToggle<CR>i
