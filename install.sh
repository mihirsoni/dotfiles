#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=".vimrc .zshrc .vim/colors .vim/backups .vim/swaps .vim/undos"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

#download required plugins
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] ; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] ; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

#Smart jumping to directories 
brew install autojump
#tldr for commands man pages.
brew install tldr
brew install howdoi

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/$file ~/$file
done

