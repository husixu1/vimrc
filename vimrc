"======== vim-plug ===========================
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')
"--------- Post-buildup hooks-----
function! InstallFont(info)
	if a:info.status == 'installed' || a:info.force
		!bash ./install.sh
	endif
endfunction

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.force
		!python ./install.py --clang-completer
	endif
endfunction
"--------- plugs -----------------

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'powerline/fonts'

Plug 'Yggdroot/indentLine'
" visual --AAAA
"               VVVV-- function 

Plug 'vim-syntastic/syntastic'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'easymotion/vim-easymotion'

"----------------------------------
call plug#end()            " required
filetype plugin indent on    " required

"========= NERDTree =========================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeWinSize = 31
let g:NERDTreeDirArrowCollapsible = '▼'


"========= YouCompleteMe =====================
let g:ycm_global_ycm_extra_conf = '~/.vim/custom/.ycm_extra_conf.py'
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
let g:airline#extensions#whitespace#enabled = 1

"======== indentLine =========================
let g:loaded_indentLine = 1
let g:indentLine_enabled = 1
let g:indentLine_char = '│'
let g:indentLine_setConceal = 0

"======== Syntastic ===========================
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
	\ "mode": "active",
	\ "active_filetypes": ["c", "cpp", "python", "shell"],
	\ "passive_filetypes": [] }

"========= Vim Costom Settings ================
set shell=/bin/bash

"----- appearence ------
colo wombat256
set cursorline
"set cursorcolumn
set number
set relativenumber
set incsearch		" search when you type
set laststatus=2	" always show the status line

"----- behaviour -------
syntax enable
syntax on
set tabstop=4
set shiftwidth=4
set smartindent

filetype plugin on

"--------------- key mappings -----------
" nerdTree toggle
map <C-n> :NERDTreeTabsToggle<CR>

" tab operation
map <F2> :tabn<CR>
map <F3> :tabp<CR>
map <F4> <C-w>T
map <S-l> :tabnew<CR>
map <S-h> :tabclose<CR>

" file finder
map <C-f> :e .<CR>

