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
set showbreak=�

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

" Search results to new buffer window
nnoremap <F3> :redir @a<cr>:g//<cr>:redir END<cr>:new<cr>:put! a<cr><cr>

" Search and replace word under cursor
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Carriage return
nnoremap <c-cr> i<cr><esc>

" Fast editing and sourcing of the .vimrc
noremap <leader>ev :e! $MYVIMRC<cr>
noremap <leader>sv :so $MYVIMRC<cr>

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Press i to enter insert mode, and jj to exit.
:inoremap jj <Esc>

" Show the cursorline
:set cursorline

" echo hexadecimal number to decimal
nnoremap <leader>h :echo 0x<c-r><c-w><cr>

" Don't use Octal or Hex numbering when autoin(de)crement
set nrformats=

" Use unnamed clipboard to facilitate Copy/Past -> y="*y
set clipboard=unnamed

" Use <c-n> to navigate to next buffer
nnoremap <c-n> :bn<cr>
nnoremap <a-n> :bp<cr>

" => VIM user interface
" set 0 lines to the cursors - when moving vertical..
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
nnoremap <leader>c :call NextColor(0)<cr>

" Set current favourite colorscheme
:colorscheme xoria256

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
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<cr>
vnoremap <silent> # :call VisualSearch('b')<cr>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<cr>
noremap <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" => Buffers, Windows
" Smart way to move btw. windows
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Close the current buffer
noremap <leader>bd :Bclose<cr>

" Close all the buffers (No warnings)
noremap <leader>ba :1,300 bd!<cr>

" Tab configuration
noremap <leader>tn :tabnew<cr>
noremap <leader>te :tabedit
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <c-tab> :tabn<cr>

" When pressing <leader>cd switch to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>

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

" Open files in vertical/horizontal window
":nnoremap gfv :vertical wincmd f<cr>
":nnoremap gfh :wincmd f<cr>

nnoremap <silent> <Leader>df :call DiffToggle()<CR>

function! DiffToggle()
    if &diff
        diffoff
    else
        diffthis
    endif
:endfunction

" => Statusline
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ [%{HasPaste()}%F%m%r%h\%w]\ [Line:\ %l/%L:%c]\ [Format=%{&ff}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [CWD:\ %r%{getcwd()}%h]

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


" => bufExplorer
nnoremap <leader>b :BufExplorer<cr>

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
