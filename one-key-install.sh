#!/bin/bash

# makedepend
tools=(vim git python curl gdb automake autoconf make)

echo 'input your system (currently support "Linux" and "Termux"):'
read -r System
case $System in
	"Linux")
		;;
	"Termux")
		;;
	*)
		echo "System unidentified"
		exit 1
		;;
esac

# _check necessary tools
for tool in ${tools[*]}
do
	command -v $tool > /dev/null 2>&1 || { echo >&2 "$tool does not exist"; exit 0; }
done

echo "your \$HOME dir is $HOME, starting installation? [y/N]: "
read -r ans
if [[ ans != "y" ]]
then
	echo "Abort"
	exit 0
fi

# create directories
[ -d "$HOME/.vim" ] \
|| echo "$HOME/.vim not exist, creating one ... "; mkdir -p "$HOME/.vim" \
|| { echo "cannot create directory"; exit 1; }

[ -d "$HOME/.vim" ] \
|| echo "$HOME/.vim/autoload not exist, creating one ..."; mkdir -p "$HOME/.vim/autoload" \
|| exit 1

# move files
echo "let g:System_='$System'" >> "$HOME/.vimrc"
cat ./vimrc >> "$HOME/.vimrc"

cp -r ./custom "$HOME/.vim/custom"
cp -r ./colors "$HOME/.vim/colors"

# install vim-plug
[ -f "$HOME/.vim/autoload/plug.vim" ] \
|| curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
|| { echo "vim-plug download failed, please change the url or download manually ... "; exit 0; }

[ -f "$HOME/.vim/autoload/plug.vim" ] \
|| { echo "vim-plug download failed, please change the url or download manually ... "; exit 0; }

vim +PlugInstall

