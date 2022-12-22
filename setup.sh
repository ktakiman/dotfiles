#!/bin/bash

#------------------------------------------------------------------------------
# clone dotfiles repo 
# (this part is redundant since I need to clone the repo first to have this file
#  on the target marchine)
#------------------------------------------------------------------------------
DOTFILEDIR=~/.dotfiles
if [ ! -d $DOTFILEDIR ]; then
  git clone https://github.com/ktakiman/dotfiles $DOTFILEDIR
fi

#------------------------------------------------------------------------------
# setup dotfiles under ~
#------------------------------------------------------------------------------

# .bashrc
echo -e "\nsource ${DOTFILEDIR}/home/.bashrc\n" >> ~/.bashrc

# .gitconfig
echo -e "\n[include]\n\tpath=${DOTFILEDIR}/home/.gitconfig" >> ~/.gitconfig

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
if [ -d "$PACKERDIR" ];then
  mkdir -p "$PACKERDIR"
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKERDIR"
fi

PACKERONLY=1 nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

#------------------------------------------------------------------------------
# setup other config (todo: generalize script below so to work with any subfolder and config file)
#------------------------------------------------------------------------------
if [ -d ~/.config/stylua ]; then
  mkdir ~/.config/stylua
fi

ln -s "${DOTFILEDIR}/xdg_config/stylua/.stylua.toml" ~/.config/stylua/



#------------------------------------------------------------------------------
# final step
#------------------------------------------------------------------------------
source ~/.bashrc
