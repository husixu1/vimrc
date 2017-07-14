"%%%%% DO NOT MODIFY THIS PART %%%%%%
let g:System_ = 'Linux'
"let g:System_ = 'Termux'
"%%%%% ONLY COMMENT/ UNCOMMENT %%%%%%

"======== vim-plug ===========================
set nocompatible              " required

let g:plug_threads = 8
let g:plug_timeout = 60
let g:plug_retries = 2
let g:plug_window = 'vertical topleft new'

"--------- Post-update hooks-----
function! InstallFont(info)
    if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
        !bash ./install.sh
    endif
endfunction this

function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
        if g:System_ == 'Linux'
            !python ./install.py --clang-completer
        elseif g:System_ == 'Termux'
            !python ./install.py --clang-completer --system-libclang
        endif
    endif
endfunction

function! BuildVimProc(info)
    if a:info.status == 'installed' || a:info.force
        !make
    endif
endfunction

function! BuildVimDbgDependency(info)
    if a:info.status == 'installed' || a:info.force
        !sudo pip install dbgp
    endif
endfunction

function! InstallPillow(info)
    if a:info.status == 'installed' || a:info.force
        if g:System_ == 'Linux'
            !sudo pip install pillow
        elseif g:System_ == 'Termux'
            !pip install pillow
        endif
    endif
endfunction

"--------- plugs -----------------
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'powerline/fonts', { 'do': function('InstallFont') }
Plug 'idanarye/vim-merginal'

"Plug 'Yggdroot/indentLine'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'majutsushi/tagbar'

" visual %%%%%%%%%%%%%%%%%%%
" %%%%%%%%%%%%%%% functional

Plug 'vim-syntastic/syntastic'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'Valloric/YouCompleteMe', { 'frozen':1 , 'do': function('BuildYCM') }
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'pseewald/vim-anyfold'

Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'farmergreg/vim-lastplace'

Plug 'cohama/agit.vim'

Plug 'vim-scripts/DoxygenToolkit.vim'

Plug 'Shougo/vimproc', { 'do':function('BuildVimProc') }        "vimshell dependency
Plug 'Shougo/vimshell.vim'
Plug 'vim-scripts/Conque-GDB'
"Plug 'jaredly/vim-debug', { 'do':function('BuildVimDbgDependency') }  "debugger for python and php
"Plug 'vim-scripts/bash-support.vim'
Plug 'ashisha/image.vim', { 'do':function('InstallPillow') }                                        "needs pillow (pip install pillow)
"----------------------------------
call plug#end()            " required
filetype plugin indent on  " required

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
let g:ycm_extra_conf_globlist = ['.']
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_key_list_select_completion = ['<C-j>', '<S-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<S-k>', '<Up>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_complete_in_comments = 1
" disables the check of ycm and uses syntastic insted
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

let g:ycm_error_symbol = "-✗"
let g:ycm_warning_symbol = "-⚠"

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
let g:UltiSnipsListSnippets  = "<S-Space>"
let g:UltiSnipsJumpForwardTrigger =  "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

let g:UltiSnipEditSplit = "normal"

"========= Airline ===========================
set encoding=utf-8
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_close_button = 0
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
"let g:indentLine_loaded = 1
"let g:loaded_indentLine = 1
"let g:indentLine_enabled = 1
"let g:indentLine_char = '│'
"let g:indentLine_leadingSpaceEnabled = 1

"======== vim-indent guides===================
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1

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
let g:syntastic_cpp_gcc_quiet_messages= {
    \ "level": "errors",
    \ "type":   "syntax",
    \ "regex":  "No such file or directory" }
let g:syntastic_c_gcc_quiet_messages= {
    \ "level": "errors",
    \ "type":   "syntax",
    \ "regex":  "No such file or directory" }

"====== AutoPair ==============================
let g:AutoPairsShortcutFastWrap = '<C-w>'

"====== Easymotion ============================
let g:EasyMotion_move_highlight = 0

"====== incsearch =============================
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#separate_highlight = 1
let g:incsearch#magic = '\v' " very magic, but do not cause probablility problem

"====== TagBar ================================
let g:tagbar_left = 0
let g:tagbar_iconchars = ['▶', '▼']
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd BufEnter * nested :call tagbar#autoopen(1)

"====== ConqueGdb =============================
let g:ConqueGdb_SrcSplit = 'left'
let g:ConqueGdb_Leader = '<Leader>'
let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r'
let g:ConqueGdb_Continue = g:ConqueGdb_Leader . 'c'
let g:ConqueGdb_Next = g:ConqueGdb_Leader . 'n'
let g:ConqueGdb_Step = g:ConqueGdb_Leader . 's'
let g:ConqueGdb_Print = g:ConqueGdb_Leader . 'p'
let g:ConqueGdb_ToggleBreak = g:ConqueGdb_Leader . 'b'
let g:ConqueGdb_DeleteBreak = g:ConqueGdb_Leader . 'd'
let g:ConqueGdb_Finish = g:ConqueGdb_Leader . 'f'
let g:ConqueGdb_Backtrace = g:ConqueGdb_Leader . 't'

"====== AnyFold ===============================
filetype plugin indent on   " required
syntax on                   " required
let g:anyfold_activate=1
let g:anyfold_identify_comments = 1
set foldlevel=0
set foldlevelstart=10

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
set incsearch        " search when you type
set hlsearch
set laststatus=2    " always show the status line

"--------------- behaviour -------
syntax enable
syntax on
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wildmode=longest,full
set wildmenu
set showmode

" load the doxygen syntax
let g:load_doxygen_syntax=1

" autoremove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" autodetect filetype
autocmd BufRead,BufNewFile *.ASM setfiletype asm
filetype plugin on

"--------------- key mappings -----
let g:mapleader = ';'
set pastetoggle=<F1>

" nerdTree toggle
map <C-n> :NERDTreeTabsToggle<CR>

" tagbar toggle
map <C-t> :TagbarToggle<CR>

" identGuide Show
map <C-\> <Plug>IndentGuidesToggle

" Syntastic reset
map <C-c> :SyntasticReset<CR>

" DoxygenToolKit map
map <S-m> :Dox<CR>

" agit show
map <C-a> :Agit<CR>

" VimShell
map <C-s> :VimShell<CR>

" file finder
map <C-f> :e .<CR>

" tab operation
map <S-l> :tabn<CR>
map <S-h> :tabp<CR>
map <C-S-l> :tabm+1<CR>
map <C-S-h> :tabm-1<CR>
map <F4> <C-w>T
map <F2> :tabnew<CR>
map <F3> :tabclose<CR>

" you complete me jump
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <leader>jD :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" ctag goto definition/declaration
nnoremap <Leader><C-]> <C-w><C-]><C-w>T

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

"--------------- commands ---------
command Gdb ConqueGdb

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
