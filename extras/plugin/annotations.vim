" Useful shortcuts for annotating SDCs for my CSAIL linguistics project

function AnnotationMode()
	map <buffer> <leader>ad ?answer<CR>A #done<Esc>jzCzjzO
	setlocal foldmethod=indent
	map <buffer> <leader>as F:la<CR>- - <Esc>o  - []<Esc>i
	" unmap <buffer> <leader>ascom
	" unmap <buffer> <leader>adef
	" unmap <buffer> <leader>adec
	" unmap <buffer> <leader>adcom
endfunction

autocmd BufNewFile,BufRead *.yaml call AnnotationMode()
