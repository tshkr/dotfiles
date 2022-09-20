#! /bin/bash

if [ ! -e $HOME/.config ]
then
    mkdir $HOME/.config
fi


SCRIPT_DIR=$(cd $(dirname $0); pwd)


ln -sf ${SCRIPT_DIR}/dot.config/nvim $HOME/.config/
