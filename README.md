# ABOUT

this is an vim config specified for Linux and Termux (an terminal simulator on Android and iOS)
to use it, follow the instructions below

# TO USE THIS CONFIG

## external dependency
| package          | depends on                                    |
|-----------------:|:----------------------------------------------|
| vim-devicons     | nerd-font in system font path                 |
| vim-fugitive     | git                                           |
| vim-merginal     | git                                           |
| tagbar           | ctags                                         |
| DoxygenToolKit   | doxygen                                       |
| ctrlsf           | ack/silver                                    |
| Conque-GDB       | gdb                                           |
| vim-autoformat   | any formatter (astyle clang-format ... )      |
| tagbar-markdown  | php                                           |
| vimtex           | texlive; vim built with +clientserver         |
| tagbar-markdown  | php                                           |
| vim-livedown     | livedown (node pack, npm install -g livedown) |

## auto-installation
auto-installation is unstable thus removed.

~~run `./deploy.<platform>.sh` WITHOUT root privilige.~~

~~<platform> can be archlinux or termux~~

## manual-installation

* put all directories into your .vim dir
* put vimrc in your home dir
* rename it to .vimrc
* run `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
* run `vim +PlugInstall`

*use fonts for powerline in terminal vim to display airline arrows correctly*

*the installation of powerline/fonts might be very slow*

## frequently-used key mappings
|plugin                |key             |mapping                     |
|---------------------:|:--------------:|----------------------------|
|Global                |;               |\<Leader\>                  |
|                      |                |                            |
|Nerdtree              |C-n             |NerdTreeTabsToggle          |
|Vim-indent-guides     |C-\\            |IndentGuidesToggle          |
|Tagbar                |C-t             |TagBarToggle                |
|Syntastic             |C-c             |SyntasticReset              |
|YouCompleteMe         |S-j,C-j,Down    |NextCompletion              |
|                      |S-k,C-k,Up      |PreviousCompletion          |
|                      |C-Space         |OmniCompletion              |
|                      |\<Leader\>ji    |GotoInclude                 |
|                      |\<Leader\>jd    |GotoDefinition              |
|                      |\<Leader\>jD    |GotoDeclaration             |
|UltiSnip              |Tab             |UltiSnipTrigger             |
|AutoPair              |C-w             |AutoPairsFastWarp           |
|DoxygenToolkit        |S-m             |GenerateDox                 |
|Agit                  |C-g             |ShowAgit                    |
|VimShell              |C-s             |ShowVimShell                |
|EasyMotion            |\<Leader\>      |EasyMotionLeader(ELeader)   |
|                      |\<ELeader\>s    |searchOneLetter             |
|                      |\<ELeader\>S    |searchMoreLetters           |
|                      |\<ELeader\>j    |searchUp                    |
|                      |\<ELeader\>k    |searchDown                  |
|AnyFold(vim buildin)  |zm,zM           |foldMore, foldMax           |
|                      |zr,zR           |reduceFold, unfoldAll       |
|                      |zc,zC           |closeFold, closeFoldRecurse |
|                      |zo,zO           |openFold, openFoldRecurse   |
|RainbowParentheses    |F9              |LoadRainbowParentheses      |
|                      |F10             |ToggleRainbowParentheses    |
|ConqueGdb             |\<Leader\>      |ConqueGdbLeader(GLeader)    |
|                      |\<GLeader\>r    |ConqueGdb\_Run              |
|                      |\<GLeader\>c    |ConqueGdb\_Continue         |
|                      |\<GLeader\>n    |ConqueGdb\_Next             |
|                      |\<GLeader\>s    |ConqueGdb\_Step             |
|                      |\<GLeader\>p    |ConqueGdb\_Print            |
|                      |\<GLeader\>b    |ConqueGdb\_ToggleBreak      |
|                      |\<GLeader\>d    |ConqueGdb\_DeleteBreak      |
|                      |\<GLeader\>f    |ConqueGdb\_Finish           |
|                      |\<GLeader\>t    |ConqueGdb\_Backtrace        |
|Quickr-preveiew       |\<Leader\>space |QuickfixPreview             |
|UndoTree              |\<Leader\>u     |ToggleUndoTree              |
|CtrlSF                |\<Leader\>/     |CtrlSFPrompt                |
|vimtex                |C-q             |QueryPackageDocument        |
|Buildin               |F1              |PasteToggle                 |
|                      |F2              |NewTab                      |
|                      |F3              |CloseCurrentTab             |
|                      |F4              |MakeCurrentWindowATab       |
|                      |C-f             |OpenFileFinder              |
|                      |S-l             |NextTab                     |
|                      |S-h             |PreviousTab                 |
|                      |C-l             |MoveTabRight                |
|                      |C-h             |MoveTabLeft                 |
|                      |\<Leader\>C-]   |CtagJumpAndOpenInNewWindow  |
|                      |z/              |ToggleAutoHighlight         |
|                      |C-q             |QueryInZeal(zeal required)  |
|                      |                |                            |

## frequently used commands

|plugin                |command         |decription                  |
|---------------------:|:--------------:|----------------------------|
|vim-plug              |:PlugUpdate     |Update Plugins              |
|                      |:PlugClean      |Clean Unused Plugins        |
|                      |:PlugInstall    |Install Plugins             |
|                      |:PlugUpgrade    |Upgrade Vim-plug Itself     |
|ConqueGdb             |:Gdb            |Start ConqueGdb             |
|Syntastic             |:SyntasticCheck |Start SyntasticCheck        |
|                      |:SyntasticToggle|Toggle SyntasticCheck       |
|                      |:SyntasticToggle|Toggle SyntasticCheck       |
|YouCompleteMe         |:YcmDebugInfo   |When Ycm Has Some Problems  |
|LivedownPreview       |:MarkdownPreview|view markdown in browser    |
|                      |                |                            |

## YCM config

* either-> create your own .ycm\_extra\_conf.py and put it in ~/.vim/custom
* or-----> use the ycm\_extra\_conf.py in this repo insted (do not have to change anything)

* in the ~/.vim/plugged/YouCompleteMe dir, run `python install.py --help` for help (usually if you only want C-family complete, run `python install.py --clang-completer`; and in Termux, run `python install.py --clang-completer --system-libclang`)

* once YCM functions normally, it's better to froze it from updating(add 'frozen' to ycm config in .vimrc). Updating YCM is somehow possible to cause a staring failure (fixable, though).

#### known issues:
* if Ycm didn't function normally, run :YcmDebugInfo and see corresponding file for debug info.
* if Ycm suffers an shutdown, please recompile the ycm core.
* sometimes use system libclang fix the problem (and it's essential for Temux users)
* if libtinfo missing, install it (from AUR for archlinux users), link it to a correct filename according to the debug info, and recompile ycm core
* if libtinfo is still missing after the yaourt installation, install ncurses5-compat-libs from AUR
