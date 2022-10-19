#! /bin/bash

if [ ! -e $HOME/.config ]
then
    mkdir $HOME/.config
fi


SCRIPT_DIR=$(cd $(dirname $0); pwd)


git clone --depth 1 \
    https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

ln -sf ${SCRIPT_DIR}/dot.config/nvim $HOME/.config/
