"======== Vundle ===========================
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"--------- Plugins -----------

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Valloric/YouCompleteMe'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'powerline/fonts'

"-----------------------------
call vundle#end()            " required
filetype plugin indent on    " required

"========= NERDTree =========================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = 'v'


"========= YouCompleteMe =====================
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_select_completion = ['<C-j>', '<S-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<S-k>', '<Up>']

command CppCheckOn let g:ycm_show_diagnostics_ui=1
command CppCheckOff let g:ycm_show_diagnostics_ui=0

"========= UltiSnip =========================
set rtp+=~/.vim/custom
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir = "~/.vim/custom/Snips"
let g:UltiSnipsSnippetDirectories = ["Snips"]
let g:UltiSnipsEnableSnipMate = 0

let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsListSnippets  = "<C-Space>"
let g:UltiSnipsJumpForwardTrigger =  "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

let g:UltiSnipEditSplit = "normal"

"========= Airline ===========================
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''


"========= Vim Costom Settings ================
set shell=/bin/bash
syntax enable
syntax on
colo wombat256
set cindent
set cursorline
"set cursorcolumn
set number
set incsearch		" search when you type
set laststatus=2	" always show the status line
filetype plugin on

"--------------- key mappings -----------
map <C-n> :NERDTreeToggle<CR>
map <S-l> :tabN<CR>
map <S-h> :tabp<CR>
map <F2> :tabnew<CR>
map <F3> :tabclose<CR>
map <C-f> :e .<CR>

"inoremap <BS> <C-O>:call DelBracket()<CR><BS>

"-------------- user functinos----------
"let s:brackets = { ')': '(', ']': '[', '}': '{' }
"function DelBracket()
"	let l:line = getline(".")
"	let l:currentChar = l:line[col(".")-1]
"	if index([")","]","}"], l:currentChar) != -1 && s:brackets[l:currentChar] == l:line[col(".")-2]
"		call feedkeys("\<C-O>x",'n')
"	end
"endfunction