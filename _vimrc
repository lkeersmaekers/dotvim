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
nmap <F3> :redir @a<cr>:g//<cr>:redir END<cr>:new<cr>:put! a<cr><cr>

" Search and replace word under cursor
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Carriage return
nnoremap <c-cr> i<cr><esc>

" Fast editing and sourcing of the .vimrc
map <leader>ev :e! $MYVIMRC<cr>
map <leader>sv :so $MYVIMRC<cr>

" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Press i to enter insert mode, and jj to exit.
:imap jj <Esc>

" Show the cursorline
:set cursorline

" echo hexadecimal number to decimal
nnoremap <leader>h :echo 0x<c-r><c-w><cr>

" Don't use Octal or Hex numbering when autoin(de)crement
set nrformats=

" Use unnamed clipboard to facilitate Copy/Past -> y="*y
set clipboard=unnamed

" Use <c-n> to navigate to next buffer
nmap <c-n> :bn<cr>
nmap <a-n> :bp<cr>

" => VIM user interface
" Set 0 lines to the cursors - when moving vertical..
set so=0

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
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

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Maximize current window
noremap <F5> <c-w>_<c-w><Bar>

" Normalize all windows
noremap <F6> <c-w>=

" => Colors and Fonts
syntax enable       "Enable syntax highlighting
set synmaxcol=120   "http://stackoverflow.com/questions/901313/editing-xml-files-with-long-lines-is-really-slow-in-vim-what-can-i-do-to-fix-th

" Fast switch to preferred colorschemes.
map <leader>sc :SetColors my<cr>
map <leader>c :call NextColor(0)<cr>

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
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

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
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers (No warnings)
map <leader>ba :1,300 bd!<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <c-tab> :tabn<cr>

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

" Open files in vertical/horizontal window
":nmap gfv :vertical wincmd f<cr>
":nmap gfh :wincmd f<cr>

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
nmap <m-j> mz:m+<cr>`z
nmap <m-k> mz:m-2<cr>`z
vmap <m-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <m-k> :m'<-2<cr>`>my`<mzgv`yo`z

" => cTags
"  This will check the current folder for tags file and keep going on directory up all the way to the root folder to
"  find a tags file.
set tags=tags;/

" => NERDTree
"  Open NERDTree using the current file's path as root
nmap <leader>nt :NERDTree %:p<cr>

" => Fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>ga :Gwrite<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

" => CtrlP
nmap <leader>f :CtrlP %:p<cr>
nmap <leader>m :CtrlPMRUFiles<cr>

" Set the maximum height of the match window:
let g:ctrlp_max_height = 40

" Set this to 1 to set regexp search as the default:
let g:ctrlp_regexp = 1

" Set this to 1 to disable sorting when searching in MRU mode:
let g:ctrlp_mruf_default_order = 1

" Set this to 0 to show the match window at the top of the screen:
let g:ctrlp_match_window_bottom = 1

" In addition to |'wildignore'|, use this for files and directories you want only
" CtrlP to not show. Use regexp to specify the patterns: >
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|dcu|\~\w*)$',
  \ 'file': '\v\.(exe|so|dll|dcu|\~\w*)$',
  \ }

" Set this to 0 to enable cross-session caching by not deleting the cache files
" upon exiting Vim: >
let g:ctrlp_clear_cache_on_exit = 0

" Set this to 1 to set searching by filename (as opposed to full path) as the
" default: >
let g:ctrlp_by_filename = 1

" Specify an external tool to use for listing files instead of using Vim's
" |globpath()|. Use %s in place of the target directory: >

" Note: Messes up custom_ignore
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d' " Windows

" Specify the number of recently opened files you want CtrlP to remember:
let g:ctrlp_mruf_max = 99

" => bufExplorer
nmap <leader>b :BufExplorer<cr>

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
