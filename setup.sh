#!/bin/bash

#------------------------------------------------------------------------------
# clone dotfiles repo 
# (this part is redundant since I need to clone the repo first to have this file
#  on the target marchine)
#------------------------------------------------------------------------------
DOTFILEDIR=~/.dotfiles
if [ ! -d $DOTFILEDIR ]; then
  mkdir $DOTFILEDIR
  cd $DOTFILEDIR
  git clone https://github.com/ktakiman/dotfiles .
fi

#------------------------------------------------------------------------------
# setup dotfiles under ~
#------------------------------------------------------------------------------

# .bashrc
echo "source ${DOTFILEDIR}/home/.bashrc" >> ~/.bashrc

# .gitconfig
printf "[include]\n\tpath=${DOTFILEDIR}/home/.gitconfig" >> ~/.gitconfig

#------------------------------------------------------------------------------
# setup nvim
#------------------------------------------------------------------------------
command -v nvim
if [ $? != 0 ];then
  echo "installing nvim..."
  source setup-nvim.sh
  # check it again
  command -v nvim
  if [ $? != 0 ];then
    echo "failed to install nvim"
    exit 1
  fi
fi

mkdir -p ~/.config/nvim
# packer creates a file under ~/.config/nvim/plugin/ so not symlinking 
ln -s "${DOTFILEDIR}/xdg_config/nvim/init.lua" ~/.config/nvim/
ln -s "${DOTFILEDIR}/xdg_config/nvim/lua" ~/.config/nvim/

# setup packer.nvim
PACKERDIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir -p $PACKERDIR
git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKERDIR

PACKERONLY=1 nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
