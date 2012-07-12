" Useful shortcuts for annotating SDCs for my CSAIL linguistics project

function AnnotationMode()
	set cursorline
	set cursorcolumn
	set autoindent
	map <buffer> <leader>ad ?answer<CR>A #done<Esc>jzCzjzO:w<CR>
	setlocal foldmethod=indent
	map <buffer> <leader>as $F:la<CR>- - <Esc>o  - []<Esc>i
	map <buffer> <leader>ac jV/\s*assignmentId\\|command<CR>k<M-/>?^\s*-<CR>/^\s*#<CR>ho- - EVENT:<CR><tab><tab><tab>
	" map <buffer> <leader>an /question<CR>j<leader>aq
	map <buffer> <leader>an /question<CR>j/word<CR>llllvf'f'"qy<leader>aq
	map <buffer> <leader>aq <leader>acf: the word<cr>r: refer to<cr>l: What<esc>kk$"qp
	" map <buffer> <leader><leader> /^    - - EVENT:<CR>0<C-v>/#<CR>0klx
	" unmap <buffer> <leader>ascom
	" unmap <buffer> <leader>adef
	" unmap <buffer> <leader>adec
	" unmap <buffer> <leader>adcom
endfunction

autocmd BufNewFile,BufRead *.yaml call AnnotationMode()
