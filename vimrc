" Maintainer:	Tang
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
	set history=500		" keep 500 lines of command line history
	set ruler		" show the cursor position all the time
	set showcmd		" display incomplete commands
	set incsearch		" do incremental searching

	" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
	" let &guioptions = substitute(&guioptions, "t", "", "g")

	" Don't use Ex mode, use Q for formatting
	map Q gq

	" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
	" so that you can undo CTRL-U after inserting a line break.
	inoremap <C-U> <C-G>u<C-U>

	" In many terminal emulators the mouse works just fine, thus enable it.
	if has('mouse')
	  set mouse=a
	endif

	" Switch syntax highlighting on, when the terminal has colors Also switch
	" on highlighting the last used search pattern.
	if &t_Co > 2 || has("gui_running")
	  syntax on
	  set hlsearch
	endif

	" Only do this part when compiled with support for autocommands.
	if has("autocmd")

	  " Enable file type detection.
	  " Use the default filetype settings, so that mail gets 'tw' set to 72,
	  " 'cindent' is on in C files, etc.
	  " Also load indent files, to automatically do language-dependent indenting.
	  filetype plugin indent on

	  " Put these in an autocmd group, so that we can delete them easily.
	  augroup vimrcEx
	  au!

	  " For all text files set 'textwidth' to 78 characters.
	  autocmd FileType text setlocal textwidth=120

	  " When editing a file, always jump to the last known cursor position.
	  " Don't do it when the position is invalid or when inside an event handler
	  " (happens when dropping a file on gvim).
	  " Also don't do it when the mark is in the first line, that is the default
	  " position when opening a file.
	  autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") <= line("$") |
		\   exe "normal! g`\"" |
		\ endif

	  augroup END

	else

	  set autoindent		" always set autoindenting on

	endif " has("autocmd")

	" Convenient command to see the difference between the current buffer and the
	" file it was loaded from, thus the changes you made.
	" Only define it when not defined already.
	if !exists(":DiffOrig")
	  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
			  \ | wincmd p | diffthis
	endif


"=================================================== basic setting
"=================================================== basic setting
"=================================================== basic setting
let mapleader = ";"
syntax on
set nu
set showmatch
set tabstop=4
set incsearch
set background=dark
set shiftwidth=4
set autoindent
set cindent
filetype plugin indent on
filetype plugin on
"=================================================== basic setting
"设置搜索结果高亮显示
set hlsearch
" 高亮字符，让其不受100列限制
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
match OverLength '\%101v.*'
"设置记录的历史操作列表
set history=200
"=================================================== basic setting VIM
set swapfile
set dir=~/.vim/tmp
set backupdir=~/.vim/tmp
"set nobackup       #no backup files
"set nowritebackup  #only in case you don't want a backup file while editing
"set noswapfile     #no swap files
"=================================================== basic setting
"
"============================= fold 
"use zc to fold, zo to open it, & zn to expand all  map zc to zl
"set foldmethod 
"set foldenable
"set fdm=indent
"set fdm=syntax
"set fdm=indent
"set fdm=expr
"set fdm=diff
"set fdm=maker
"set fdm=manual
autocmd FileType c,cpp  setl fdm=syntax | setl fen
nmap zl zc

"==================================================================
"============================= for tags and Tlist
set tags=/Users/ctang/.vim/tags
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Auto_Open=0
let Tlist_Use_SingleClick=1
" 这项必须设定，否则出错,配置taglist的ctags路径
" 不同时显示多个文件的 tag ，只显示当前文件的
" 如果 taglist 窗口是最后一个窗口，则退出 vim
" "让当前不被编辑的文件的方法列表自动折叠起来 
"let Tlist_File_Fold_Auto_Close=1
"     "把taglist窗口放在屏幕的右侧，缺省在左侧 
     let Tlist_Use_Right_Window=1 
"      "显示taglist菜单
      let Tlist_Show_Menu=1
"       "启动vim自动打开taglist
"  let Tlist_Auto_Open=1 


set cscopequickfix=s-,c-,d-,i-,t-,e-
cs add /home/tang/vim73/cscope.out /home/tang/vim73
"=====================set for colorschrme
syntax enable
if has('gui_running')
set background=light
else
set background=dark
endif
"colorscheme desertEx
let g:solarized_menu=1
"colorscheme solarized
"==================================================================
"                                                           taglist
let Tlist_Use_LEFT_Window=1 "default
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1
"let g:winManagerWindowLayout=’FileExplorer’
nmap tl :Tlist<cr>
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_WinHeight=100
let Tlist_WinWidth=30
let Tlist_Use_Singleclick=1
let Tlist_Use_Right_Window=0
let Tlist_Show_Menu=1
"let Tlist_Max_Submenu_Iterms=20
"let Tlist_Max_Tag_Length=10
inoremap <C-]>             <C-X><C-]>
inoremap <C-F>             <C-X><C-F>
inoremap <C-D>             <C-X><C-D>
inoremap <C-L>             <C-X><C-L>
inoremap <C-P>             <C-N><C-P>
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "<C-N><C-P>" 
set autowrite
set showmode
set smarttab
set title
"==================================================================
set mouse=a
"set mouse=na
"set mouse=h
"set mouse=c
"==================================================================
"用tab补全 codecomplete use qq(ee)  instead
let g:completekey = "qq"   "hotkey
fun! KeywordComplete()
let left = strpart(getline('.'), col('.') - 2, 1)
if left =~ "^$"
	return "\<Tab>"
elseif left =~ ' $'
	return "\<Tab>"
elseif left =~ '\<Tab>$'
	return "\<Tab>"
elseif left =~ '	$'
	return "\<Tab>"
elseif left=~'=$'
	return "\<Tab>"
else
	return "\<C-N>"
endfun
inoremap <silent> <Tab> <C-R>=KeywordComplete()<CR>
"===========================
"set for emenu
source $VIMRUNTIME/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
nmap ;em :emenu <C-Z>
"================================================================
"                                            set for omniComplete
set completeopt=menu
fun! OmniComplete()
let left = strpart(getline('.'), col('.') - 2, 1)
if left =~ "^$"
	return ""
elseif left =~ ' $'
	return ""
else
	return "\<C-x>\<C-o>"
endfun
inoremap <silent> <S-Tab> <C-R>=OmniComplete()<CR>
"turn on Omni completion
autocmd FileType c set ofu=ccomplete#Complete
"autocmd FileType php set ofu=phpcomplete#CompletePHP
"autocmd FileType python set ofu=pythoncomplete#Complete
"autocmd FileType javascript set ofu=javascriptcomplete#CompleteJS
"autocmd FileType html set ofu=htmlcomplete#CompleteTags
"autocmd FileType css set ofu=csscomplete#CompleteCSS
"autocmd FileType xml set ofu=xmlcomplete#CompleteTags
"===============================================
"================================ map for c program
nm t; ggO#include<stdio.h><esc>
nm tb o#include<stdlib.h><esc>
nm ts o#include<string.h><esc>
nm tm o#include<math.h><esc>
nm tt o#include<time.h><esc>
nm ti o#include<ifunction.h><esc>
"==============================================================  for VIM
set modifiable " for the buffer
nmap mm :w<cr>
nmap qa :qa<cr>
nmap q! :q!<cr>
nmap <backspace> i<backspace><esc>l
nmap <leader>p o<esc>0i#===================================================<space>
nmap <leader>u o<esc>0i#---------------------------------------------------<space>
"=================================================== for the arrows
"                只要是屏幕显示出的行，你都可以用它们在其中上下移动
map <Up> gk
map <Down> gj
nmap <leader>r :reg<cr>
"================================ map for c.vim
nm z; \cfr 
im z; \cfr 
nm c; \rc  
im c; \rc  
nm rr \rr
nm ra \ra 
nm fm \im 
"=================================================== to run the current c or cpp code
"=================================================== for c.vim
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
nmap cn :cn<cr><cr><cr>
nmap cp :cp<cr><cr><cr>
"nmap <leader>cp :cp<cr>
nmap <leader>cw :cw 10<cr>
nmap c<space> :cclose<cr><cr>  " to close the buffer window
nmap <leader><space> :copen
nmap de !!date<cr> 
"nmap ;p o<esc>0i//====================================================<esc>d$o<esc>xxi<tab>
"

"=============================================== set for NERD_Commenter
let g:vimgdb_debug_file = ""
run macros/gdb_mappings.vim
map <F2> :run macros/gdb_mappings.vim<CR>
"================================================ for nerdtree
set encoding=utf-8 
" set map as ;1 to show the encoding
nmap <leader>1 :set<space>fileencoding<cr>
"set fileencoding=ucs-bom,utf-8,cp936	
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=21
"================================================ map for bash-support.vim note
im <leader>ch \cfdh 
nm <leader>ch <leader>cfdh 
imap <leader>kf \cfu
nmap <leader>kf \cfu
imap <leader>kc \ckc
nmap <leader>kc \ckc

"=================================================== command line
nmap <leader>go \su

imap <leader>kh \ch
nmap <leader>kh \ch
imap <leader>kt \ckt
nmap <leader>kt \ckt
imap <leader>kw \ckw
nmap <leader>kw \ckw
imap <leader>kb \ckb
nmap <leader>kb \ckb
imap <leader>kn \ckn
nmap <leader>kn \ckn
"========================================== echo this line
"nmap <leader>ke ^iecho<space>"<esc>A"<esc>0j   
nmap <leader>kr \cr<esc>
imap <leader>ke \ce<esc>
nmap <leader>ke \ce<esc>
imap <leader>kr \cr<esc>
"========================================== showmarks setting
"<Leader>mt   - 打开/关闭ShowMarks插件
"<Leader>mo   - 强制打开ShowMarks插件
"<Leader>mh   - 清除当前行的标记
"<Leader>ma   - 清除当前缓冲区中所有的标记
"<Leader>mm   - 在当前行打一个标记，使用下一个可用的标记名 
"" Enable ShowMarks
nmap mt <leader>mt
nmap mh <leader>mh
"let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1 
" ================================================ set for windows
nmap ;w <C-w><C-w>
" ================================================ set path
set path="/usr/include/"
" ================================================ set for rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ================================================ set for surround
nmap ys' ysW'
nmap ys" ysW"
nmap ys[ ysW[
nmap ys( ysW(
nmap ys{ ysW{

nmap yk" <esc>bi"<esc>A"
imap yk" <esc>bi"<esc>A"
nmap yk[ <esc>bi[<esc>A]
imap yk[ <esc>bi[<esc>A]
imap yk' <esc>bi'<esc>A'
nmap yk' <esc>bi'<esc>A'
nmap yn <esc>bbi"<esc>A"
imap yn <esc>bbi"<esc>A"
"=================================================== for mur.vim
let MRU_Max_Entries = 100
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 1
let MRU_Auto_Close = 1
let MRU_Add_Menu = 1
let MRU_Max_Menu_Entries = 20
let MRU_Max_Submenu_Entries = 15
"set mouse=v
"=================================================== set for python
"pydiction 1.2 python auto complete
"let g:pydiction_location = '/Users/tang/.vim/bundle/pydiction'
"defalut g:pydiction_menu_height == 15
"let g:pydiction_menu_height = 20
"=================================================== press rr to run current *.py
au BufRead *.py map <buffer> rr :w<CR>:!/usr/bin/env python % <CR>
"=================================================== for pathogen.vim
call pathogen#infect()
"=================================================== 
au BufRead *.py map <buffer> rr :w<CR>:!/usr/bin/env python % <CR>
"=================================================== for nerdtree
"Q. How can I open a NERDTree automatically when vim starts up?
autocmd vimenter * NERDTree
autocmd VimEnter * wincmd p " make the consor in the main window
"Q. How can I open a NERDTree automatically when vim starts up if no files
autocmd vimenter * if !argc() | NERDTree | endif
"Q. How can I map a specific key or shortcut to open NERDTree?
"A. Stick this in your vimrc to open NERDTree with Ctrl+n (you can set
"whatever key you want): 
map <leader>f :NERDTreeToggle<CR>
"Q. How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
 "NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1

"==============================================================================
"USAGE                                                      *bufexplorer-usage*

"To start exploring in the current window, use: >
 "\be   or   :BufExplorer   or   Your custom key mapping
""To start exploring in a newly split horizontal window, use: >
 "\bs   or   :BufExplorerHorizontalSplit   or   Your custom key mapping
""To start exploring in a newly split vertical window, use: >
 "\bv   or   :BufExplorerVerticalSplit   or   Your custom key mapping
 "syn keyword cType unit uchar
"============================================================= set for yankring
let g:yankring_enabled = 1
let g:yankring_history_dir='/Users/ctang/.vim/'
nmap <leader>r :YRShow<cr>
let g:yankring_window_use_horiz = 1  " Use vertical split
let g:yankring_window_width = 30
let g:yankring_window_increment = 50

"============================================================= statusline

"==============================================================================
"USAGE                                                      *for MATLAB*
autocmd BufRead *.m map <buffer> rr :w<CR>:!NAME=%; matlab -nodesktop -nosplash -r ${NAME\%.m} <CR>
autocmd FileType m nmap <leader>p o<esc>0i%===================================================<space>
nmap <leader>uu o<esc>0i#---------------------------------------------------<space>
"==============================================================================
"USAGE                                                      *for ncl*
autocmd BufRead *.ncl map <buffer> rr :w<CR>:!/usr/bin/env ncl % <CR>
"==============================================================================
"USAGE                                                      *for ncl*
autocmd BufRead *.gs map <buffer> rr :w<CR>:!/usr/bin/env grads -lbc "run %" <CR>
"grads -lbc "run stdmap.temp.gs"
nmap <leader>99 :!cat % <CR>
set smarttab
"==============================================================================
"USAGE                                                      *for grads file *.gs*
"only 2 spaces
autocmd BufNewFile,BufRead *.html,*.htm,*.css,*.gs set shiftwidth=2 
"==============================================================================
"USAGE                                                      *for Index Guides*
"Indent Guides is a plugin for visually displaying indent levels in Vim
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=22
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=140
let g:indent_guides_start_level=2
let g:indent_guides_guide_size = 1

set ts=4 sw=4 et
" ts = tabstop : how many space = 1 tab
" sw = shiftwidth : how much index
" tabstop=X ts 编辑时一个TAB字符占多少个空格的位置。
" (no)expandtab (no)et
" 是否将输入的TAB自动展开成空格。开启后要输入TAB，需要Ctrl-V<TAB>
" softtabstop=X sts 
" 方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
" (no)smarttab (no)started
" 开启时，在行首按TAB将加入sw个空格，否则加入ts个空格。


" 从第二层开始可视化显示缩进
" " 色块宽度
" " 快捷键 i 开/关缩进可视化
"==============================================================================

""=================================================== for Jedi
"let g:jedi#auto_initialization = 1
""There are also some VIM options (like completeopt and key defaults) which are automatically initialized, but you can skip this:

""let g:jedi#auto_vim_configuration = 0
""If you are a person who likes to use VIM-buffers not tabs, you might want to put that in your .vimrc:

""let g:jedi#use_tabs_not_buffers = 0
""If you are a person who likes to use VIM-splits, you might want to put this in your .vimrc:

"let g:jedi#use_splits_not_buffers = "left"
""This options could be "left", "right", "top", "bottom" or "winwidth". It will decide the direction where the split open.

""Jedi automatically starts the completion, if you type a dot, e.g. str., if you don't want this:

""let g:jedi#popup_on_dot = 0
""Jedi selects the first line of the completion menu: for a better typing-flow and usually saves one keypress.

"let g:jedi#popup_select_first = 0
""Jedi displays function call signatures in insert mode in real-time, highlighting the current argument. The call signatures can be displayed as a pop-up in the buffer (set to 1, the default), which has the advantage of being easier to refer to, or in Vim's command line aligned with the function call (set to 2), which can improve the integrity of Vim's undo history.

"let g:jedi#show_call_signatures = "1"
""Here are a few more defaults for actions, read the docs (:help jedi-vim) to get more information. If you set them to "", they are not assigned.

""NOTE: subject to change!

"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
"let g:jedi#documentation_command = "K"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>y"
""Finally, if you don't want completion, but all the other features, use:

"let g:jedi#completions_enabled = 1
""=================================================== for statistic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
""=================================================== command line argument for py

""------------------------------------------------------------------------------
""  Python_Input : Input after a highlighted prompt    {{{1
""------------------------------------------------------------------------------
function! Python_Input ( promp, text, ... )
    echohl Search																					" highlight prompt
    call inputsave()																			" preserve typeahead
    if a:0 == 0 || empty(a:1)
        let retval	=input( a:promp, a:text )
    else
        let retval	=input( a:promp, a:text, a:1 )
    endif
    call inputrestore()																		" restore typeahead
    echohl None																						" reset highlighting
    let retval  = substitute( retval, '^\s\+', "", "" )		" remove leading whitespaces
    let retval  = substitute( retval, '\s\+$', "", "" )		" remove trailing whitespaces
    return retval
endfunction    " ----------  end of function Python_Input ----------
"
function! PythonCmdLineArguments ()
    let	prompt	= 'Python command line arguments for "'.expand("%").'" : '
    if exists("b:PythonCmdLineArgs")
        let	b:PythonCmdLineArgs= Python_Input( prompt, b:PythonCmdLineArgs )
    else
        let	b:PythonCmdLineArgs= Python_Input( prompt , "" )
    endif
    "return b:PythonCmdLineArgs
    "echo b:PythonCmdLineArgs
    "let b:tssdf='jjjjjjjjjjjj'
    "echo b:tssdf
    "prompt = b:tssdf
endfunction    " ----------  end of function PythonCmdLineArguments ----------

autocmd BufRead *.py map <buffer> ra :!python % $(eval echo 
au BufRead *.py map <buffer> rr :w<CR>:!/usr/bin/env python % <CR>
"autocmd BufRead *.py map <buffer> ra :call PythonCmdLineArguments()<CR>
"au BufRead *.py map <buffer> rr :w<CR>:echo b:PythonCmdLineArgs<CR> 
"au BufRead *.py map <buffer> rr :w<CR>:!/usr/bin/env python % $(:echo b:PythonCmdLineArgs)<CR>
"au BufRead *.py map <buffer> rr :w<CR>:echo b:PythonCmdLineArgs<CR> 
"au BufRead *.py map <buffer> rr :w<CR>:echo system("echo <buffer> b:PythonCmdLineArgs")
"exe "imenu <silent> ".s:BASH_Root.'&Run.Bash\ cmd\.\ line\ &arg\.<Tab>\\rba                  <C-C>:call BASH_BashCmdLineArguments()<CR>'
"


"to set a underline
set cursorline



"It is possible to highlight the entire line permanently (mapped to key \l):
nnoremap <silent> <Leader>l :exe "let m = matchadd('WildMenu','\\%" . line('.') . "l')"<CR>

"Or one could only highlight the word underneath the cursor (mapped to key \h):
nnoremap <silent> <Leader>h :exe "let m=matchadd('WildMenu','\\<\\w*\\%" . line(".") . "l\\%" . col(".") . "c\\w*\\>')"<CR>

"To highlight the words contained in the virtual column (mapped to \c):
nnoremap <silent> <Leader>c :exe "let m=matchadd('WildMenu','\\<\\w*\\%" . virtcol(".") . "v\\w*\\>')"<CR>

"And finally, one can clear the permanent highlights (mapped to \Enter):
nnoremap <silent> <Leader><CR> :call clearmatches()<CR>
"=================================================== for gnuplot v5 in /usr/local/bin/gnuplot
au BufRead *.gps map <buffer> rr :w<CR>:!/usr/local/bin/gnuplot % <CR>



"=================================================== to print with line number
set printoptions=number:y
"set list
"=================================================== for R 
au BufRead *.r map <buffer> rr :w<CR>:!Rscript % <CR>
