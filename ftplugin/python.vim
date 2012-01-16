setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=80
setlocal smarttab
setlocal expandtab
setlocal nosmartindent
setlocal formatoptions-=t
setlocal formatoptions+=q
set omnifunc=pythoncomplete

" Execute code with shift+e
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>

" silent !mvim ~/Dropbox/vim/python_shortcuts.txt
