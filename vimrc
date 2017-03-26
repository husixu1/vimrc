let g:System_ = 'Linux'
"let g:System_ = 'Tremux'

"======== vim-plug ===========================
set nocompatible              " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')
"--------- Post-buildup hooks-----
function! InstallFont(info)
	if a:info.status == 'installed' || a:info.force
		!bash ./install.sh
	endif
endfunction this

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.force
		if g:System_ == 'Linux'
			!python ./install.py --clang-completer
		elseif g:System_ == 'Termux'
			!python ./install.py --clang-completer --system-libclang
		endif
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

" visual %%%%%%%%%%%%%%%%%
" %%%%%%%%%%%%%%% function

Plug 'vim-syntastic/syntastic'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'Valloric/YouCompleteMe', { 'frozen':1 , 'do': function('BuildYCM') }
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'farmergreg/vim-lastplace'

"----------------------------------
call plug#end()            " required
filetype plugin indent on    " required

"========= NERDTree =========================
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
if g:System_ == 'Linux'
	let g:NERDTreeWinSize = 31
elseif g:System_ == 'Termux'
	let g:NERDTreeWinSize = 21
endif
let g:NERDTreeDirArrowCollapsible = '▼'


"========= YouCompleteMe =====================
let g:ycm_global_ycm_extra_conf = '~/.vim/custom/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_select_completion = ['<C-j>', '<S-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<S-k>', '<Up>']
let g:ycm_complete_in_comments = 1

let g:ycm_error_symbol = "✗"
let g:ycm_warning_symbol = "⚠"

" Add triggers to ycm for LaTeX-Box autocompletion
let g:ycm_semantic_triggers = {
\  'tex'  : ['{'],
\ }

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
let g:airline#extensions#tabline#show_close_button = 1
if g:System_ == 'Linux'
	let g:airline_powerline_fonts = 1
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
elseif g:System_ == 'Termux'
	let g:airline_powerline_fonts = 0
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols = {}
	let g:airline_symbols.crypt = '🔒'
	let g:airline_symbols.linenr = '␊'
	let g:airline_symbols.linenr = '␤'
	let g:airline_symbols.maxlinenr = '☰'
	let g:airline_symbols.branch = '⎇'
	let g:airline_symbols.paste = 'ρ'
	let g:airline_symbols.spell = 'Ꞩ'
	let g:airline_symbols.notexists = '∄'
	let g:airline_symbols.whitespace = 'Ξ'
endif
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
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_mode_map = {
	\ "mode": "active",
	\ "active_filetypes": ["c", "cpp", "python", "shell"],
	\ "passive_filetypes": ["asm", "tex"] }

"====== AutoPair ==============================
let g:AutoPairsShortcutFastWrap = '<C-w>'

"====== Easymotion ============================
let g:EasyMotion_move_highlight = 0

"====== incsearch =============================
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#separate_highlight = 1
let g:incsearch#magic = '\v' " very magic, but do not cause probablility problem

"==============================================
"========= Vim Custom Settings ================
"==============================================
if g:System_ == 'Linux'
	set shell=/bin/bash
elseif g:System_ == 'Termux'
	set shell=/data/data/com.termux/files/usr/bin/bash
endif
set term=screen-256color

"--------------- appearence ------
colo wombat256
set cursorline
"set cursorcolumn
set number
set relativenumber
set incsearch		" search when you type
set hlsearch
set laststatus=2	" always show the status line

"--------------- behaviour -------
syntax enable
syntax on
set tabstop=4
set shiftwidth=4
set smartindent
set wildmode=longest,full
set wildmenu

" autoremove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e
" autodetect filetype
autocmd BufRead,BufNewFile *.ASM setfiletype asm
filetype plugin on

"--------------- key mappings -----
let g:mapleader = ';'

" nerdTree toggle
map <C-n> :NERDTreeTabsToggle<CR>
map <C-x> :SyntasticReset<CR>

" tab operation
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>
map <F4> <C-w>T
map <F2> :tabnew<CR>
map <F3> :tabclose<CR>

" file finder
map <C-f> :e .<CR>

" you complete me jump
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <leader>jD :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" incsearch map
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" easymotion
map <Leader> <Plug>(easymotion-prefix)
nmap <Leader>S <Plug>(incsearch-nohl)<Plug>(easymotion-sn)

nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

"--------------- functions --------
function! AutoHighlightToggle()
	let @/ = ''
	if exists('#auto_highlight')
		au! auto_highlight
		augroup! auto_highlight
		setl updatetime=4000
		echo 'Highlight current word: off'
		return 0
	else
		augroup auto_highlight
			au!
			au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
		augroup end
		setl updatetime=500
		echo 'Highlight current word: ON'
		return 1
	endif
endfunction
