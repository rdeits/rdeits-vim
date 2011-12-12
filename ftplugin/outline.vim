" call Outline()

set fo-=t
set fo+=cro
set commentstring="* %s"
" set comments=b:*
inoremap <buffer> } <Space><BS><Esc>>>A
inoremap <buffer> { <Space><BS><Esc><<A

syn match Comment "\*.*$"
