" Automatic formatting of comments
" set formatoptions+=ac
set formatoptions-=t

syn match matlabComment			"%.*$"	contains=matlabTodo,matlabTab,@Spell
" MT_ADDON - correctly highlights words after '...' as comments
syn match matlabComment			"\.\.\..*$"	contains=matlabTodo,matlabTab,@Spell
syn region matlabMultilineComment	start=+%{+ end=+%}+ contains=matlabTodo,matlabTab,@Spell


syn region matlabString			start=+'+ end=+'+	oneline skip=+''+ contains=@Spell
