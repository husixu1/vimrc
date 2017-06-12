#!/bin/bash

# makedepend
tools=(vim git python curl gdb automake autoconf make)

System=Termux

# _check necessary tools
for tool in ${tools[*]}
do
	if ! command -v $tool > /dev/null 2>&1
	then
		echo >&2 "$tool does not exist, install? [y/N]"
		read -r ans
		case $ans in
			"y")
				apt install $tool || { echo "$tool installation failed. exiting ... "; exit 1; }
				;;
			*)
				exit 1
				;;
		esac
	fi
done

echo "your \$HOME dir is $HOME, starting installation ... "

# create directories
[ -d "$HOME/.vim" ] \
|| echo "$HOME/.vim not exist, creating one ... "; mkdir -p "$HOME/.vim" \
|| { echo "cannot create directory"; exit 1; }

[ -d "$HOME/.vim" ] \
|| echo "$HOME/.vim/autoload not exist, creating one ..."; mkdir -p "$HOME/.vim/autoload" \
|| exit 1

# move files
echo "let g:System_='$System'" >> "$HOME/.vimrc"
cat ./vimrc | sed -n {5~1p} >> "$HOME/.vimrc"

cp -r ./custom "$HOME/.vim/custom"
cp -r ./colors "$HOME/.vim/colors"

# install vim-plug
[ -f "$HOME/.vim/autoload/plug.vim" ] \
|| curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
|| { echo "vim-plug download failed, please change the url or download manually ... "; exit 0; }

[ -f "$HOME/.vim/autoload/plug.vim" ] \
|| { echo "vim-plug download failed, please change the url or download manually ... "; exit 0; }

vim +PlugInstall

