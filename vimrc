"%%%%% DO NOT MODIFY THIS PART %%%%%%
let g:System_ = 'Linux'
"let g:System_ = 'Termux'
"%%%%% ONLY COMMENT/ UNCOMMENT %%%%%%

"==============================================
"========= Vim Plugin Settings ================
"==============================================

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

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'powerline/fonts', { 'do': function('InstallFont') }
Plug 'idanarye/vim-merginal'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'kien/rainbow_parentheses.vim'

" visual -------------------
" --------------- functional

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'majutsushi/tagbar'

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

Plug 'vim-syntastic/syntastic'
Plug 'Valloric/YouCompleteMe', { 'frozen':1 , 'do': function('BuildYCM') }
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'pseewald/vim-anyfold'

Plug 'farmergreg/vim-lastplace'

Plug 'cohama/agit.vim'

Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'c,cpp,python,javascript' }

Plug 'Shougo/vimproc', { 'do':function('BuildVimProc') }        "vimshell dependency
Plug 'Shougo/vimshell.vim'
Plug 'vim-scripts/Conque-GDB'
Plug 'ashisha/image.vim', { 'do':function('InstallPillow') }    "needs pillow (pip install pillow)

" --------------- functional
" language support ---------

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'mtscout6/vim-tagbar-css', { 'for': 'css' }
"Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex,latex'}
"Plug 'vim-scripts/bash-support.vim'

call plug#end()            " required
filetype plugin indent on  " required
"----------------------------------

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
let g:syntastic_cpp_check_header = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["c", "cpp", "python", "shell"],
    \ "passive_filetypes": ["asm", "tex"] }
"let g:syntastic_cpp_checkers=['clang_check']
let g:syntastic_cpp_gcc_quiet_messages= {
    \ "regex":  "No such file or directory" }
let g:syntastic_c_gcc_quiet_messages= {
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
let g:anyfold_activate = 1
let g:anyfold_identify_comments = 0
let g:anyfold_fold_toplevel = 0
set foldlevel=0
set foldlevelstart=10

"====== Rainbow Parentheses ===================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

"==============================================
"========= Vim Custom Settings ================
"==============================================
if g:System_ == 'Linux'
    set shell=/bin/bash
elseif g:System_ == 'Termux'
    set shell=/data/data/com.termux/files/usr/bin/bash
endif
set term=screen-256color

"====== Appearence ============================
colo wombat256
set cursorline
"set cursorcolumn
set number
set relativenumber
set incsearch        " search when you type
set hlsearch
set laststatus=2    " always show the status line

"====== Behaviour =============================
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

set fileencodings=utf8,cp936,gb18030,big5
set cinoptions=>s,e0,n0,f0,{0,}0,^0,Ls,:s,=s,l0,b0,g0,hs,N-s,E0,ps,t0,is,+s,c3,C0,/0,(2s,us,U0,w0,W0,k0,m0,j0,J0,)20,*70,#0

" load the doxygen syntax
let g:load_doxygen_syntax=1

" autoremove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" autodetect filetype
autocmd BufRead,BufNewFile *.ASM setfiletype asm
filetype plugin on

"====== Key Mappings ==========================
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
map <C-g> :Agit<CR>

" VimShell
map <C-s> :VimShell<CR>

" file finder
map <C-f> :e .<CR>

" rainbow parentheses toggle
map <F9> :RainbowParenthesesLoadRound<CR>
            \:RainbowParenthesesLoadSquare<CR>
            \:RainbowParenthesesLoadBraces<CR>
            \:RainbowParenthesesLoadChevrons<CR>
map <F10> :RainbowParenthesesToggle<CR>

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
map \ <Plug>(easymotion-prefix)
nmap \S <Plug>(incsearch-nohl)<Plug>(easymotion-sn)

nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

"====== Commands ==============================
command! Gdb ConqueGdb
autocmd Filetype c,cpp nnoremap <silent> <C-Q> :!command -v devdocs-desktop && devdocs-desktop "<cword>" > /dev/null 2>&1 &<CR><CR>

"====== Functions =============================
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
