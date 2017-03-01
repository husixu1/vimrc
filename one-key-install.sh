#!/bin/bash

# _check necessary commands
command -v vim > /dev/null 2>&1 || echo >&2 "vim not exist"
command -v python > /dev/null 2>&1 || echo >&2 "python not exist"
command -v curl > /dev/null 2>&1 || echo >&2 "curl not found"

echo "your \$HOME dir is $HOME"
[ -d "$HOME/.vim" ] || echo "$HOME/.vim not exist, creating one ... "; mkdir -p "$HOME/.vim"
[ -d "$HOME/.vim" ] || echo "$HOME/.vim/autoload not exist, creating one ..."; mkdir -p "$HOME/.vim/autoload"


# move files
echo 'input your system (currently support "Linux" and Termux):'
read -r System

echo "let g:System_=\'$System\'" >> "$HOME/.vimrc"

echo ./vimrc >> "$HOME/.vimrc"
cp -r ./custom "$HOME/.vim/custom"

# install vim-plug
[ -f "$HOME/.vim/autoload/plug.vim" ] || curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[ -f "$HOME/.vim/autoload/plug.vim" ] || echo "vim-plug download failed, please change the url or download manually ... "; exit

vim +PlugInstall

# install clewn
cd ./clewn-1.15 || echo "clewn-1.15 not exist"; exit
export vimdir="$HOME/.vim"
./configure --prefix="HOME/.vim"
./make && make install

