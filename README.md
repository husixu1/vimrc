# TO USE THIS CONFIG

## auto-installation
---
run `./one-key-install.sh` WITHOUT root privilige

## manual-installation
---

* put all directories into your .vim dir 
* put vimrc in your home dir
* rename it to .vimrc
* run `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
* run `vim +PlugInstall`

### YCM config

either-> create your own .ycm\_extra\_conf.py and put it in ~/.vim/custom
or-----> use the ycm\_extra\_conf.py in this repo insted (do not have to change anything)


