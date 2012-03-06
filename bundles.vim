set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 " original repos on github
 Bundle 'mileszs/ack.vim'
 Bundle 'ddollar/nerdcommenter'
 Bundle 'ervandew/supertab'
 Bundle 'vim-scripts/bufkill.vim'
 Bundle 'majutsushi/tagbar'
 Bundle 'altercation/vim-colors-solarized'
 Bundle 'kien/ctrlp.vim'
 Bundle 'rdeits/vim-markdown-preview'
 Bundle 'vim-scripts/YankRing.vim'
 Bundle 'tpope/vim-fugitive'
 Bundle 'rygwdn/rope-omni'
 Bundle 'vim-scripts/The-NERD-tree'
 Bundle 'rdeits/minibufexpl.vim'
 " vim-scripts repos
 " Bundle 'L9'
 " Bundle 'FuzzyFinder'
 " non github repos
 Bundle 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex'
 " " Bundle 'git://git.wincent.com/command-t.git'
 " " ...

filetype plugin indent on     " required! 
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..
