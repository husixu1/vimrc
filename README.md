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

* either-> create your own .ycm\_extra\_conf.py and put it in ~/.vim/custom
* or-----> use the ycm\_extra\_conf.py in this repo insted (do not have to change anything)

### Clewn installation

#### on Linux
* cd to clewn-1.5 dir
* run `export vimdir=<your vim dir>` 
* run `./configure --prefix=<build dir>`
* run `make && make install`

#### on Termux
* cd to clewn-1.5 dir
* run `export vimdir=<your vim dir>` 
* run `autoconf`
* run `./configure --prefix=<build dir>`
* add `#define USE_GETCWD` to the first line of misc.c
* change the fist line of `script/install-sh` accordingly
* run `make && make install`
