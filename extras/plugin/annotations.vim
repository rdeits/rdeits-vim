" Useful shortcuts for annotating SDCs for my CSAIL linguistics project

function AnnotationMode()
	map <leader>ad ?answer<CR>A #done<Esc>jzCjjzO
	set foldmethod=indent
	map <leader>as F:la<CR>- - <Esc>o  - []<Esc>i
	unmap <leader>ascom
endfunction

