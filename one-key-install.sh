#!/bin/bash

echo 'input your system (currently support "Linux" and "Termux"):'
read -r System
case $System in
	"Linux")
		;;
	"Termux")
		;;
	*)
		echo "System unidentified"
		exit
		;;
esac

# _check necessary commands
command -v vim > /dev/null 2>&1 || echo >&2 "vim not exist"
command -v python > /dev/null 2>&1 || echo >&2 "python not exist"
command -v curl > /dev/null 2>&1 || echo >&2 "curl not found"
command -v gdb > /dev/null 2>&1 || echo >&2 "gdb not found"
command -v automake > /dev/null 2>&1 || echo >&2 "automake not found"
command -v autoconf > /dev/null 2>&1 || echo >&2 "autoconf not found"
command -v make > /dev/null 2>&1 || echo >&2 "make not found"


echo "your \$HOME dir is $HOME"
[ -d "$HOME/.vim" ] || echo "$HOME/.vim not exist, creating one ... "; mkdir -p "$HOME/.vim"
[ -d "$HOME/.vim" ] || echo "$HOME/.vim/autoload not exist, creating one ..."; mkdir -p "$HOME/.vim/autoload"


# move files

echo "let g:System_='$System'" >> "$HOME/.vimrc"
cat ./vimrc >> "$HOME/.vimrc"

cp -r ./custom "$HOME/.vim/custom"
cp -r ./colors "$HOME/.vim/colors"


# install vim-plug
[ -f "$HOME/.vim/autoload/plug.vim" ] || curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
[ -f "$HOME/.vim/autoload/plug.vim" ] || echo "vim-plug download failed, please change the url or download manually ... "; exit

vim +PlugInstall

# install clewn (Termux currently not supported)
if [ "$System" == "Linux" ]
then
	cp -r ./clewn-1.15 ./clewn || echo "clewn 1.15 not exist"; exit
	cd ./clewn || echo "clewn 1.15 not exist"; exit
	export vimdir="$HOME/.vim"
	./configure --prefix="HOME/.vim"
	./make && make install
elif [ "$System" == "Termux" ]
then
	echo "currently can't autobuild clewn on termux, please build it manually following README.md if you want to use it"
fi
