#!/bin/sh

if [ -e $HOME/.vim/plugin/MKD.vim ]; then
  echo "Removing old version of vim-markdown-preview ..."
  rm $HOME/.vim/plugin/MKD.vim
  echo "DONE.."
fi

