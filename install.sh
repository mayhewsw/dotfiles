#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in this folder (dotfiles)
# Based on: http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

# Assume this script is in ./dotfiles

########## Variables

olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_profile bashrc gitconfig gitignore screenrc"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

CURRENT=`pwd`

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/$file
    echo "Creating symlink to $file in home directory."
    ln -s $CURRENT/$file ~/.$file
done

git config --global core.excludesfile ~/.gitignore

wget "http://download.savannah.gnu.org/releases/color-theme/color-theme-6.6.0.tar.gz"
tar xzvf color-theme-6.6.0.tar.gz
mv color-theme-6.6.0/ emacs.d/

# do the same for .emacs.d
echo "Moving current .emacs.d to .emacs.d.old..."
mv ~/.emacs.d ~/.emacs.d.old
echo "Making symlink for current version of .emacs.d..."
ln -s $CURRENT/emacs.d ~/.emacs.d
echo "done"

echo "Installing powerline-shell..."
pip install powerline-shell
