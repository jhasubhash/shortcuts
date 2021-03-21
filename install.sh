#!/bin/sh
DIRN=${PWD}/"$(dirname "$0")"
#echo $DIRN
cd ~/.oh-my-zsh/custom/
ln -s "${DIRN}/zsh/init.zsh" .

mkdir -p ~/.config/nvim
cd ~/.config/nvim
ln -s "${DIRN}/nvim/*" .

cd $DIRN
