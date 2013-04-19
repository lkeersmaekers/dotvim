" => Pathogen
runtime bundle/vim-pathogen.git/autoload/pathogen.vim
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Sections:
"    -> Text, tab and indent related
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings

" => Text, tab and indent related
"    Note: Other settings are reset by setting nocp. Make sure it is first to execute
set nocp         " nocompatible
set et           " expandtab
set shiftwidth=2
set sts=2        " softtabstop
set ts=2         " tabstop
set sta          " smarttab
set nowrap
set lbr          " linebreak
set tw=500       " textwidth
set ai           " Auto indent
set si           " Smart indent
set rnu          " Relative to cursor linenumbers
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set showbreak=ª

" Abbreviations
iabbrev @@ lieven@iwega.be
iabbrev ssig <cr>Lieven Keersmaekers<cr>lieven@iwega.be

" Common typo's

" => General
" Sets how many lines of history VIM has to remember
set history=999

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" Search current word under cursor to new buffer window
nnoremap <F3> :redir @a<cr>:silent g//<cr>:redir END<cr>:new<cr>:put! a<cr>

" Grep word and show results in quick-fix window
nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " *.*"<cr>

" Search and replace word under cursor
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Carriage return
nnoremap <c-cr> i<cr><esc>

" Fast editing and sourcing of the .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>

" Replace <esc> with kj
inoremap kj <esc>
" The trick to relearning a mapping is to *force* yourself to use it by *disabling* the old key(s).
inoremap <esc> <nop>

" Show the cursorline
set cursorline

" Don't use Octal or Hex numbering when autoin(de)crement
set nrformats=

" Use unnamed clipboard to facilitate Copy/Past -> y="*y
set clipboard=unnamed

" Use <c-n> to navigate to next buffer
nnoremap <c-n> :bn<cr>
nnoremap <a-n> :bp<cr>

" Populate the prompt with all loaded buffers and wait for a buffer to select
nnoremap <leader>b :ls<cr>:b<space>

" => VIM user interface
" Set 0 lines to the cursors - when moving vertical..
set so=0

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" no sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" maximize current window
noremap <F5> <c-w>_<c-w><Bar>

" Normalize all windows
noremap <F6> <c-w>=

" => Colors and Fonts
syntax enable       "Enable syntax highlighting
set synmaxcol=120   "http://stackoverflow.com/questions/901313/editing-xml-files-with-long-lines-is-really-slow-in-vim-what-can-i-do-to-fix-th

" Fast switch to preferred colorschemes.
nnoremap <leader>sc :SetColors my<cr>
nnoremap <leader>nc :call NextColor(0)<cr>

" Set current favourite colorscheme
colorscheme xoria256

" Set current favourite font
if has ("gui_running")
  if has ("gui_win32")
    set guifont=Consolas:h9:cANSI
    " Likable alternatives
    " set guifont=Courier_New:h10
    " set guifont=Lucida_Console:h9
  endif
endif


" => Files, backups and undo
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
  set undodir=C:\Windows\Temp
  set undofile
catch
endtry

" => Visual mode related

" => Buffers, Windows
" Smart way to move btw. windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l
" Close the current buffer
map <leader>bd :Bclose<cr>
" Close all the buffers (No warnings)
map <leader>ba :1,300 bd!<cr>
" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endfunction
" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry
" Make gf find Delphi files.
set sua+=.pas,.dfm,.dpr
" => Statusline
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=[%{HasPaste()}%F%m%r%h\%w]  " Current file
set statusline+=\ [Line:\ %l/%L:%c]        " Current line/Total lines: Current column
set statusline+=\ [\%03.3b-0x\%02.2B]      " Ascii & Hex value of current char under cursor
set statusline+=\ [%r%{getcwd()}%h]        " Current directory
set statusline+=\ [Format=%{&ff}]          " Encoding

function! HasPaste()
  if &paste
    return 'PASTE MODE  '
  else
    return ''
  endif
endfunction

"Move a line of text using ALT+[jk] or Command+[jk] on mac
nnoremap <m-j> mz:m+<cr>`z
nnoremap <m-k> mz:m-2<cr>`z
vnoremap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" => cTags
"  This will check the current folder for tags file and keep going on directory up all the way to the root folder to
"  find a tags file.
set tags=tags;/

" => NERDTree
"  Open NERDTree using the current file's path as root
nnoremap <leader>nt :NERDTree %:p<cr>

" => Fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gd :Gdiff<cr>

" => Mru
nnoremap <leader>m :MRU<cr>

" Remember 1000 most recently used file names
let MRU_Max_Entries = 1000

" Exclude files using patters
let MRU_Exclude_Files = '\v\.(exe|so|dll|dcu|\~\w*)$|\v[\/]\.(git|hg|svn|dcu|\~\w*)$'

" Change the default window height
let MRU_Window_Height = 15



" => Load local settings
if has('unix') || has('macunix')
  let localvimrc = $HOME . '/.vimrc.local'
else
  let localvimrc = $VIM . '/_vimrc.local'
  if has('win32')
    " MS-Windows
    if $USERPROFILE != ''
      let localvimrc = $USERPROFILE . '\_vimrc.local'
    endif
  endif
endif

if filereadable(glob(localvimrc))
  :exec ":source " . g:localvimrc

  " Fast editing of the local _vimrc.local
  execute ":map <leader>el :e! " . g:localvimrc ."<cr>"
endif

" => Maximize window
if has('gui_running') && has('win32')
  set guioptions-=T
  set guioptions-=m
  au GUIEnter * simalt ~x "Maximize window
endif

vim:fdc=3:fdm=expr:fde=getline(v\:lnum)=~'\".=>'?'>1'\:'1':
