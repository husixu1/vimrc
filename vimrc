"%%%%% DO NOT MODIFY THIS PART %%%%%%
let g:System_='Linux'
"let g:System_='Termux'
"%%%%% ONLY COMMENT/ UNCOMMENT %%%%%%

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"%%%%%%%%% Vim Plugin Settings %%%%%%%%%%%%%%%
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

"%%%%%%%%% vim-plug %%%%%%%%%%%%%%%%%%%%%%%%%%
set nocompatible              " required

let g:plug_threads = 8
let g:plug_timeout = 60
let g:plug_retries = 2
let g:plug_window = 'vertical topleft new'

"%%%%%%%%% Post-update hooks %%%%%%%%%%%%%%%%%
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

function! InstallPillow(info)
    if a:info.status == 'installed' || a:info.force
        if g:System_ == 'Linux'
            !sudo pip install pillow
        elseif g:System_ == 'Termux'
            !pip install pillow
        endif
    endif
endfunction

"%%%%%%%%% plugs %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
Plug 'Valloric/YouCompleteMe', { 'frozen':1 , 'do': function('BuildYCM') } "need compile if auto compile failed
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
Plug 'pseewald/vim-anyfold'

Plug 'farmergreg/vim-lastplace'
Plug 'mbbill/undotree'

Plug 'cohama/agit.vim'

Plug 'Chiel92/vim-autoformat'
Plug 'vim-scripts/DoxygenToolkit.vim', { 'for': 'c,cpp,python,javascript' }

Plug 'Shougo/vimproc', { 'do':function('BuildVimProc') }        "vimshell dependency
Plug 'Shougo/vimshell.vim'
Plug 'vim-scripts/Conque-GDB'
"Plug 'ashisha/image.vim', { 'do':function('InstallPillow') }    "needs pillow (pip install pillow) [problematic]

Plug 'dyng/ctrlsf.vim'                                          "needs ack installed (pacman -S ack)
Plug 'ronakg/quickr-preview.vim'
Plug 'vim-scripts/a.vim'
Plug 'craigemery/vim-autotag'

Plug 'Chiel92/vim-autoformat'
" --------------- functional
" language support ---------

Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'mtscout6/vim-tagbar-css', { 'for': 'css' }
Plug 'lvht/tagbar-markdown', {'for': 'markdown'}                "needs php in $PATH
"Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
"Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex,latex'}
Plug 'lervag/vimtex', {'for': 'tex,latex'}
"Plug 'vim-scripts/bash-support.vim'
Plug 'shime/vim-livedown', { 'for': 'markdown'}                 "needs npm install -g livedown
Plug 'sheerun/vim-polyglot'

call plug#end()            " required
filetype plugin indent on  " required

"%%%%%%%%% NERDTree %%%%%%%%%%%%%%%%%%%%%%%%%%
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
if g:System_ == 'Linux'
    let g:NERDTreeWinSize = 31
elseif g:System_ == 'Termux'
    let g:NERDTreeWinSize = 21
endif
let g:NERDTreeDirArrowCollapsible = '▼'


"%%%%%%%%% YouCompleteMe %%%%%%%%%%%%%%%%%%%%%
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

"%%%%%%%%% UltiSnip %%%%%%%%%%%%%%%%%%%%%%%%%%
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

"%%%%%%%%% Airline %%%%%%%%%%%%%%%%%%%%%%%%%%%
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

"%%%%%%%% Undo Tree %%%%%%%%%%%%%%%%%%%%%%%%%%
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_HelpLine = 0

"%%%%%%%% vim-indent guides%%%%%%%%%%%%%%%%%%%
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 1

"%%%%%%%% Syntastic %%%%%%%%%%%%%%%%%%%%%%%%%%
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_cpp_check_header = 1
let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "passive_filetypes": ["asm", "tex"] }
"let g:syntastic_cpp_checkers=['clang_check']
let g:syntastic_cpp_gcc_quiet_messages= {
    \ "regex":  "No such file or directory" }
let g:syntastic_c_gcc_quiet_messages= {
    \ "regex":  "No such file or directory" }

"%%%%%% AutoPair %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:AutoPairsShortcutFastWrap = '<C-w>'

"%%%%%% Easymotion %%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:EasyMotion_move_highlight = 0
"let g:EasyMotion_do_mapping = 0 "disable default mapping to avoid conflict

"%%%%%% incsearch %%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:incsearch#auto_nohlsearch = 1
let g:incsearch#separate_highlight = 1
let g:incsearch#magic = '\v' " very magic, but do not cause probablility problem

"%%%%%% TagBar %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:tagbar_left = 0
let g:tagbar_iconchars = ['▶', '▼']
"autocmd VimEnter * nested :call tagbar#autoopen(1)
"autocmd BufEnter * nested :call tagbar#autoopen(1)

"%%%%%% ConqueGdb %%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:ConqueGdb_SrcSplit = 'left'
let g:ConqueGdb_Leader = '\'
let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r'
let g:ConqueGdb_Continue = g:ConqueGdb_Leader . 'c'
let g:ConqueGdb_Next = g:ConqueGdb_Leader . 'n'
let g:ConqueGdb_Step = g:ConqueGdb_Leader . 's'
let g:ConqueGdb_Print = g:ConqueGdb_Leader . 'p'
let g:ConqueGdb_ToggleBreak = g:ConqueGdb_Leader . 'b'
let g:ConqueGdb_DeleteBreak = g:ConqueGdb_Leader . 'd'
let g:ConqueGdb_Finish = g:ConqueGdb_Leader . 'f'
let g:ConqueGdb_Backtrace = g:ConqueGdb_Leader . 't'

"%%%%%% AnyFold %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filetype plugin indent on   " required
syntax on                   " required
let g:anyfold_activate = 1
let g:anyfold_identify_comments = 0
let g:anyfold_fold_toplevel = 0
set foldlevel=0
set foldlevelstart=10

"%%%%%% Rainbow Parentheses %%%%%%%%%%%%%%%%%%
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

"%%%%%% Doxygen Toolkit %%%%%%%%%%%%%%%%%%%%%%
let g:DoxygenToolkit_commentType = "C++"

"%%%%%% CtrlSF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:ctrlsf_mapping = {
    \ "open"    : ["<CR>", "o"],
    \ "openb"   : "O",
    \ "split"   : "<C-O>",
    \ "vsplit"  : "",
    \ "tab"     : "t",
    \ "tabb"    : "T",
    \ "popen"   : "p",
    \ "popenf"  : "P",
    \ "quit"    : "q",
    \ "next"    : "<C-J>",
    \ "prev"    : "<C-K>",
    \ "pquit"   : "q",
    \ "loclist" : "",
    \ "chgmode" : "M",
    \ }

"%%%%%% Livedown %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"let g:livedown_browser = "firefox"

"%%%%%% VimTex %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
let g:vimtex_doc_handlers = ['VimTexDocHandler']
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_mappings_enabled = 0
let g:tex_flavor = 'latex'
let g:vimtex_compiler_latexmk = {
    \ 'backend' : 'process',
    \ 'background' : 1,
    \ 'build_dir' : 'output',
    \ 'callback' : 1,
    \ 'continuous' : 1,
    \ 'executable' : 'latexmk',
    \ 'options' : [
    \   '-pdf',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
"%%%%%%%%% Vim Custom Settings %%%%%%%%%%%%%%%
"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if g:System_ == 'Linux'
    set shell=/bin/bash
elseif g:System_ == 'Termux'
    set shell=/data/data/com.termux/files/usr/bin/bash
endif
set term=screen-256color

"%%%%%% Appearence %%%%%%%%%%%%%%%%%%%%%%%%%%%
colo wombat256
set cursorline
"set cursorcolumn
set number
set relativenumber
set incsearch        " search when you type
set hlsearch
set laststatus=2     " always show the status line

" load the doxygen syntax and use enhanced highlight
let g:load_doxygen_syntax = 1
"let g:doxygen_enhanced_color = 1

"%%%%%% Behaviour %%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
set backspace=indent,eol,start

" autoremove trailing whitespace when saving
autocmd BufWritePre * %s/\s\+$//e

" search ctags in parent dir if not found
set tag=./tags;

" autodetect filetype
autocmd BufRead,BufNewFile *.ASM setfiletype asm
filetype plugin on

"%%%%%% Key Mappings %%%%%%%%%%%%%%%%%%%%%%%%%
let g:mapleader = ';'
let g:maplocalleader = ';'
nnoremap <Leader><Leader> :

" toggle paste mode
set pastetoggle=<F1>

" nerdTree toggle
nnoremap <C-n> :NERDTreeTabsToggle<CR>

" tagbar toggle
nnoremap <C-t> :TagbarToggle<CR>

" identGuide Show
nnoremap <C-\> <Plug>IndentGuidesToggle

" Syntastic reset
nnoremap <C-c> :SyntasticReset<CR>

" DoxygenToolKit nnoremap
nnoremap <S-m> :Dox<CR>

" agit show
nnoremap <C-g> :Agit<CR>

" VimShell
nnoremap <C-s> :VimShell<CR>

" file finder
nnoremap <C-f> :e .<CR>

" undo tree toggle
nnoremap <Leader>u :UndotreeToggle<CR>

" CtrlSF quick search
nmap <Leader>/ <Plug>CtrlSFPrompt

" rainbow parentheses toggle
nnoremap <F9> :RainbowParenthesesLoadRound<CR>
            \:RainbowParenthesesLoadSquare<CR>
            \:RainbowParenthesesLoadBraces<CR>
            \:RainbowParenthesesLoadChevrons<CR>
nnoremap <F10> :RainbowParenthesesToggle<CR>

" tab operation
nnoremap <S-l> :tabn<CR>
nnoremap <S-h> :tabp<CR>
nnoremap <C-S-l> :tabm+1<CR>
nnoremap <C-S-h> :tabm-1<CR>
nnoremap <F4> <C-w>T
nnoremap <F2> :tabnew<CR>
nnoremap <F3> :tabclose<CR>

" you complete me jump
nnoremap <Leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <Leader>jD :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>jd :YcmCompleter GoToDefinition<CR>

" ctag goto definition/declaration
nnoremap <Leader><C-]> <C-w><C-]><C-w>T

" incsearch map
nmap n  <Plug>(incsearch-nohl-n)
nmap N  <Plug>(incsearch-nohl-N)
nmap *  <Plug>(incsearch-nohl-*)
nmap #  <Plug>(incsearch-nohl-#)
nmap g* <Plug>(incsearch-nohl-g*)
nmap g# <Plug>(incsearch-nohl-g#)
nmap /  <Plug>(incsearch-forward)
nmap ?  <Plug>(incsearch-backward)
nmap g/ <Plug>(incsearch-stay)

" easymotion
nmap <Leader>  <Plug>(easymotion-prefix)
nmap <Leader>S <Plug>(incsearch-nohl)<Plug>(easymotion-sn)

" vimtex
autocmd Filetype tex        nmap <C-Q> <plug>(vimtex-doc-package)

" auto highlight toggle
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

" document query, require zeal
autocmd Filetype c          nnoremap <silent> <C-Q> :!command -v zeal && zeal "c:<cword>"          > /dev/null 2>&1 &<CR><CR>
autocmd Filetype cpp        nnoremap <silent> <C-Q> :!command -v zeal && zeal "cpp:<cword>"        > /dev/null 2>&1 &<CR><CR>
autocmd Filetype python     nnoremap <silent> <C-Q> :!command -v zeal && zeal "python:<cword>"     > /dev/null 2>&1 &<CR><CR>
autocmd Filetype html       nnoremap <silent> <C-Q> :!command -v zeal && zeal "html:<cword>"       > /dev/null 2>&1 &<CR><CR>
autocmd Filetype javascript nnoremap <silent> <C-Q> :!command -v zeal && zeal "javascript:<cword>" > /dev/null 2>&1 &<CR><CR>


"%%%%%% Commands %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
command! Gdb ConqueGdb
command! MarkdownPreview LivedownPreview
command! AutoHighlightToggle :call AutoHighlightToggle()
command! -nargs=* Make make <args> | cwindow             "open quickfix after make automatically

"%%%%%% Functions %%%%%%%%%%%%%%%%%%%%%%%%%%%%

" Auto highlight toggle
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

" Auto fcitx toggle
if g:System_ == 'Linux'
    let g:input_toggle = 0
    " toggle to en when exit insert move
    function! Fcitx2en()
       let s:input_status = system("fcitx-remote")
       if s:input_status == 2
          let g:input_toggle = 1
          let l:a = system("fcitx-remote -c")
       endif
    endfunction

    " toggle to cn when enter insert mode
    function! Fcitx2zh()
       let s:input_status = system("fcitx-remote")
       if s:input_status != 2 && g:input_toggle == 1
          let l:a = system("fcitx-remote -o")
          let g:input_toggle = 0
       endif
    endfunction

    set ttimeoutlen=100
    "exit insert mode
    autocmd InsertLeave * call Fcitx2en()
    "enter insert mode
    autocmd InsertEnter * call Fcitx2zh()
endif

" vimtex handler
function! VimTexDocHandler(context)
    call vimtex#doc#make_selection(a:context)
    if !empty(a:context.selected)
        execute '!texdoc' a:context.selected '&'
    endif
    return 1
endfunction
