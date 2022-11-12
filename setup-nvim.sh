#!/bin/bash

# https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites
# assuming nvim is set up on Ubuntu...
sudo apt install ninja-build gettext libtool autoconf automake cmake g++ pkg-config unzip curl doxygen

BUILDDIR=~/dev/nvim/

mkdir -p $BUILDDIR
cd $BUILDDIR

git clone https://github.com/neovim/neovim .
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo

sudo make install
