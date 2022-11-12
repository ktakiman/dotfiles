#!/bin/bash

#------------------------------------------------------------------------------
# clone dotfiles repo
#------------------------------------------------------------------------------
DOTFILEDIR=~/.dotfiles
if [ ! -d $DOTFILEDIR ]; then
  mkdir $DOTFILEDIR
  cd $DOTFILEDIR
  git clone https://github.com/ktakiman/dotfiles .
fi

#------------------------------------------------------------------------------
# install dotfiles under ~
#------------------------------------------------------------------------------

# don't have any yet :)

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

ln -s "${DOTFILEDIR}/xdg_config/nvim" ~/.config/

# setup packer.nvim
PACKERDIR=~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir -p $PACKERDIR
git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKERDIR

PACKERONLY=1 
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
