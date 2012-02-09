set nocompatible
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#helptags()
call pathogen#infect()

set ruler
syntax on

" Set encoding
set encoding=utf-8

set list listchars=tab:\ \ ,trail:·

" Searching
set nohlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*.pyc,*.doc,*.mp3,*.mp4,*.png,*.jpg,*.epub

" Friendlier mappings for saving and quitting
map <M-s> :w<CR>
imap <M-s> <esc>:w<cr>i
map <M-w> :q<CR>
imap <M-w> <esc>:q<cr>i

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" NERDTree configuration
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Hammer<CR>
endfunction

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype on
filetype plugin on
filetype indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Show (partial) command in the status line
set showcmd

let g:NERDTreeShowBookmarks=1
let g:NERDTreeShowHidden=1
let g:NERDTreeChDirMode=2


" Turn off the stupid bell
set noerrorbells
set visualbell
set t_vb=

" Turn on line numbers
set number

" Hide invisible characters
set invlist

" Display as much of the last line as possible
set display+=lastline

" Turn on spellcheck
set spell

"Make the arrow and movement keys wrap around lines
set whichwrap+=<,>,h,l,[,]

" Ignore case in search by default
set ic
set smartcase
set textwidth=0
set wrap
set linebreak

" Tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
" set textwidth=80
set smarttab
" set expandtab
" set nosmartindent

" Tell Vim to always use the system clipboard for yank, delete, and paste
set clipboard=unnamed

" Use f5 to 'refresh' the file
map <F5> :e %<cr>
imap <F5> <Esc>:e %<cr>

set noswapfile
set nobackup

" MRU Most recently used file configuration
let MRU_Max_Entries = 1000

function Outline()
	set ft=outline
endfunction

function EndOutline()
	filetype detect
endfunction

map <F2> :call Outline()<cr>
imap <F2> <Esc>:call Outline()<cr>a

map <S-F2> :call EndOutline()<cr>
imap <S-F2> <Esc>:call EndOutline()<cr>a

" Function to replace a block of python code with its own output
if has("python")
python << EOL
import vim, StringIO,sys
def PyExecReplace(line1,line2):
  r = vim.current.buffer.range(int(line1),int(line2))
  redirected = StringIO.StringIO()
  sys.stdout = redirected
  exec('\n'.join(r) + '\n')
  sys.stdout = sys.__stdout__
  output = redirected.getvalue().split('\n')
  r[:] = output[:-1] # the -1 is to remove the final blank line
  redirected.close()
EOL
command -range Pyer python PyExecReplace(<f-line1>,<f-line2>)
endif
" Convert outline format to LaTeX
command Texify !python $HOME/.vim/scripts/texify.py % 

" Calculate the number of screen lines needed to display a file with folds at
" the given fold_level. This is used to set the initial fold level of a file
" in order to display the entire file on screen if possible without closing
" any unnecessary folds.
function! ScreenLines(fold_level)
	let line_num = 1
	let screen_lines = 0
	let prev_fold_level = 0
	let cur_fold_level = 0
	let buf_length = line("$")
	while line_num <= buf_length
		let fold_expr = foldlevel(line_num)
		let prev_fold_level = cur_fold_level
		let cur_fold_level = fold_expr
		if (cur_fold_level <= a:fold_level) || ((cur_fold_level != prev_fold_level) && (prev_fold_level <= a:fold_level))
 			let screen_lines = screen_lines + 1
		endif
	    let line_num = line_num+1
   endwhile
   return screen_lines
endfunction

" Increase the fold level until the entire file will fit on the screen or
" foldlevel reaches 10, whichever comes first. 
function! FoldToScreen()
	let ndx = 0
	set foldlevel=0
	while ndx < 10
		let ndx = ndx + 1
		if ScreenLines(ndx) > &lines
			break
		endif
		set foldlevel+=1
	endwhile
endfunction

" autocmd BufWinEnter * call FoldToScreen()

" " Configuration for vim-latex
" " IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" " can be called correctly.
set shellslash
" 
" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" 
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

noremap <C-left> :call PrevBuffer()<CR>
noremap <C-right> :call NextBuffer()<CR>

function NextBuffer()
	if &buftype!='nofile'
		bnext
	endif
endfunction

function PrevBuffer()
	if &buftype!='nofile'
		bprevious
	endif
endfunction


" Set leader to , (comma) for easier reaching
let mapleader = ","

" Fuzzyfinder customizations
" map <leader>f :FufFileWithCurrentBufferDir **/<C-M> 
" map <leader><leader> :FufBuffer<C-M>
" map <leader>mr :FufMruFile<C-M>
" map <leader>mm :FufMruFile<C-M>
" let g:fuf_modesDisable = ['mrucmd']


" Command T config
let g:CommandTScanDotDirectories=1
let g:CommandTMaxDepth=10
let g:CommandTMaxFiles=20000
" let g:CommandTMatchWindowAtTop=0
" let g:CommandTMaxHeight=10
" let g:CommandTMatchWindowReverse=1
" let g:CommandTMaxFiles=10000
" let g:CommandTMaxCachedDirectories=5


" Binding for nicer buffer closing
" map <M-w> <Plug>BufKillBd

if has("python")
" This is a nifty function for creating bulleted lists and other things. When
" you press shift-enter at the end of a line, it duplicates everything before
" the first letter or digit on that line onto the next line. 
python << endpython
import vim
import re
def list_newline():
	(row,col) = vim.current.window.cursor
	line = vim.current.buffer[row-1] 
	pattern = re.split(r'[a-zA-Z0-9]',line,1)[0]
	vim.current.buffer[row-1]+="\n"
	vim.current.buffer[row:row] = [pattern]
	vim.current.window.cursor = (row+1,len(pattern))
	vim.command('star!') # enter insert mode
endpython

imap <S-cr> <Esc>:python list_newline()<cr>
map <S-cr> :python list_newline()<cr>
endif

" Generate a handy tasklist
noremap <Leader>tl :noautocmd vimgrep /TODO/j %<CR>:cw<CR>

" MiniBuf Explorer configuration
let g:miniBufExplUseSingleClick = 0
let g:miniBufExplModSelTarget=1
" let g:miniBufExplorerMoreThanOne=3
let g:NERDTreeMouseMode = 2
let g:miniBufExplorerMoreThanOne = 10000


" Tagbar customizatoin
nmap <F8> :TagbarToggle<CR>
let g:tagbar_expand=1

" Supertab configuration
let g:SuperTabDefaultCompletionType="context"
" let g:SuperTabContextDefaultCompletionType="<c-x><c-o>"
set completeopt=longest,menuone
" imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x><c-o>")<cr>

" MiniBufExplorer config
hi link MBEVisibleChangedActive Search

if !has("gui_running")
	let g:solarized_termcolors=256
	set background=dark
	color solarized
end

" Ctrlp configuration
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_mruf_max = 1000
let g:ctrlp_max_files = 3000
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_max_depth = 10
map <leader>f :CtrlP<CR>
map <leader><leader> :CtrlPBuffer<CR>
map <leader>mm :CtrlPMRU<CR>
let g:ctrlp_extensions = ['dir']
map <leader>. :CtrlPDir<CR>

" Python Mode config
if !has("python")
	let g:pymode = 0
endif
let g:pymode_lint_cwindow = 1
let g:pymode_lint_message = 0
let g:pymode_lint_write = 0
let g:pymode_lint_jump = 1
let g:pymode_breakpoint_key = '<leader>br'
let g:pymode_options_other = 0
let g:pymode_doc_key = 'K'
map <C-K> :RopeShowDoc<CR>
map <leader>q :PyLint<CR>

" Faster window switching
map <M-j> :wincmd j<CR>
map <M-h> :wincmd h<CR>
map <M-k> :wincmd k<CR>
map <M-l> :wincmd l<CR>

" Command to do latexmk on a file
function LatexmkTerminal()
	let @@ = "cd " . expand("%:p:h") . "; latexmk -pvc -pdf " . expand("%:t")
	ConqueTermSplit bash
	resize 10
	normal ""p
endfunc
command Latexmk call LatexmkTerminal() 

" OS-specific configurations:
if has("macunix")
	runtime config/macunix.vim
elseif has("gui_gnome")
	runtime config/gui_gnome.vim
elseif has("win32")
	runtime config/win32.vim
endif

