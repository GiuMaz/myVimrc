#!/bin/bash
#run in the myvimrc directory to create a symbolic link in the homepage

# force a symbolic link in the home to this vimrc
ln -sf $(pwd)/vimrc ~/.vimrc 
# create directories for tmp files (if necessary)
mkdir -p ~/.vim/swap ~/.vim/undohistory ~/.vim/backup

