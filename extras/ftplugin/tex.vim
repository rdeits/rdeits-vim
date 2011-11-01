" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
" set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Word wrap
setlocal formatoptions+=twa

" Define a custom command for saving and compiling
map <Leader>lc :w<CR>:call Tex_RunLaTeX()<CR>

" Specify a viewer for mac
if has('macunix')
	let g:Tex_ViewRule_pdf='Skim.app'
endif
