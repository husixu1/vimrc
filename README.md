# ABOUT

this is an vim config specified for Linux and Termux (an terminal simulator on Android and iOS)
to use it, follow the instructions below

# TO USE THIS CONFIG

## auto-installation

run `./deploy.<platform>.sh` WITHOUT root privilige.

<platform> can be archlinux or termux

## manual-installation

* put all directories into your .vim dir
* put vimrc in your home dir
* rename it to .vimrc
* run `curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
* run `vim +PlugInstall`

*use fonts for powerline in terminal vim to display airline arrows correctly*

*disable devicons plugin if you don't need it, otherwise install nerd-fonts patch*

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
|Agit                  |C-a             |ShowAgit                    |
|VimShell              |C-s             |ShowVimShell                |
|EasyMotion            |\\              |EasyMotionLeader(ELeader)   |
|                      |\<ELeader\>s    |searchOneLetter             |
|                      |\<ELeader\>S    |searchMoreLetters           |
|                      |\<ELeader\>j    |searchUp                    |
|                      |\<ELeader\>k    |searchDown                  |
|AnyFold(vim buildin)  |zm,zM           |foldMore, foldMax           |
|                      |zr,zR           |reduceFold, unfoldAll       |
|                      |zc,zC           |closeFold, closeFoldRecurse |
|                      |zo,zO           |openFold, openFoldRecurse   |
|ConqueGdb             |\<Leader\>r     |ConqueGdb\_Run              |
|                      |\<Leader\>c     |ConqueGdb\_Continue         |
|                      |\<Leader\>n     |ConqueGdb\_Next             |
|                      |\<Leader\>s     |ConqueGdb\_Step             |
|                      |\<Leader\>p     |ConqueGdb\_Print            |
|                      |\<Leader\>b     |ConqueGdb\_ToggleBreak      |
|                      |\<Leader\>d     |ConqueGdb\_DeleteBreak      |
|                      |\<Leader\>f     |ConqueGdb\_Finish           |
|                      |\<Leader\>t     |ConqueGdb\_Backtrace        |
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

## YCM config

* either-> create your own .ycm\_extra\_conf.py and put it in ~/.vim/custom
* or-----> use the ycm\_extra\_conf.py in this repo insted (do not have to change anything)

* in the ~/.vim/plugged/YouCompleteMe dir, run `python install.py --help` for help (usually if you only want C-family complete, run `python install.py --clang-completer`; and in Termux, run `python install.py --clang-completer --system-libclang`)

* once YCM functions normally, it's better to froze it from updating(add 'frozen' to ycm config in .vimrc). Updating YCM is somehow possible to cause a staring failure (fixable, though).

#### known issues:
* if Ycm didn't function normally, run :YcmDebugInfo and see corresponding file for debug info
* if YCM SUFFERS AN SHUTDOWN, PLEASE RECOMPILE THE YCM CORE：
* if you have run vim +PlugUpdate, YCM CORE might be too old to use, and should be recompiled manually
* sometimes use system libclang fix the problem (and it's a must for Temux users)
* if libtinfo missing, install it (from AUR for archlinux users), link it to a correct filename according to the debug info, and recompile ycm core
* if libtinfo is still missing after the yaourt installation, install ncurses5-compat-libs from yaourt
