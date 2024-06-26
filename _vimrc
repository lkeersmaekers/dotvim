" vim: set foldmarker={{{,}}} foldlevel=1 foldmethod=marker foldcolumn=5:"
" Sections: {{{1
"    -> Packages
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
"    -> Editing mappings}}}

" => Packages {{{2
" :helptags ALL to generate help
packadd! editexisting
packadd! matchit

" Updating submodules: https://stackoverflow.com/a/19029685/52598
" git submodule update --init --recursive
" git submodule foreach --recursive git fetch
" git submodule foreach git merge origin master

" => Text, tab and indent related {{{2
"    Note: Other settings are reset by setting nocp. Make sure it is first to execute
set nocp                                                     " nocompatible
set et                                                       " expandtab
set shiftwidth=2
set sts=2                                                    " softtabstop
set ts=2                                                     " tabstop
set sta                                                      " smarttab
set nowrap
set nowrapscan
set lbr                                                      " linebreak
set tw=500                                                   " textwidth
set ai                                                       " Auto indent
set si                                                       " Smart indent
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set ve=all                                                   " Virtual Edit
set nosol                                                    " Start of line (<c-g>G stays in same column)
set diffopt=filler,vertical

" Environment specific settings
if has ("gui_win32")
  set rnu        " Relative to cursor linenumbers
endif
set nu         " Show linnumbers

" Abbreviations
iabbrev @@ lieven@iwega.be
iabbrev ssig <cr>Lieven Keersmaekers<cr>lieven@iwega.be

" Folding methods
let javaScript_fold=1                 " JavaScript
let perl_fold=1                       " Perl
let php_folding=1                     " PHP
let r_syntax_folding=1                " R
let ruby_fold=1                       " Ruby
let sh_fold_enabled=1                 " sh
let vimsyn_folding='af'               " Vim script
let xml_syntax_folding=1              " XML
let g:markdown_fold_style = 'nested'  " Markdown

" Creates 26 new text-objects -- http://stackoverflow.com/a/44109750/52598
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '-', '#' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<cr>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<cr>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<cr>'
    execute 'onoremap a' . char . ' :normal va' . char . '<cr>'
endfor

" => General {{{2
" Sets how many lines of history VIM has to remember
set history=999

" Enable filetype plugin
filetype plugin on
filetype indent on
" The default HTML indent script was changed during the 7.3-7.4 transition and it now requires a few settings to actually work correctly: :help html-indenting.
" http://superuser.com/questions/812302/in-vim-how-do-i-auto-shift-back-a-tab-space-when-closing-a-tag
let g:html_indent_script1 = 'inc'
let g:html_indent_style1  = 'inc'
let g:html_indent_inctags = 'html,body,head,tbody,p,li,dd,dt,h1,h2,h3,h4,h5,h6,blockquote'

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","
let g:maplocalleader = ","

" As ',' is remapped to <leader> and unavailable for reverse search of ';' use '�'
noremap � ,
" Search current word under cursor to new buffer window
nnoremap <F3> :redir! @f<cr>:silent g//<cr>:redir! END<cr>:enew!<cr>:put! f<cr>:let @f=@/<cr>:g/^$/d<cr>:let @/=@f<cr>gg

" Grep word and show results in quick-fix window
nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " *.*"<cr>
if has('win32')
  set grepprg=findstr\ /snip
endif

" Search and replace word under cursor
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i

" Carriage return
nnoremap <c-cr> i<cr><esc>

" Fast editing and sourcing of the .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :so $MYVIMRC<cr>
"
" Fast editing of vimtips
nnoremap <leader>evt :e! $VIMRUNTIME/doc/vimtips.txt<cr>

" Replace <esc> with kj
inoremap kj <esc>
" The trick to relearning a mapping is to *force* yourself to use it by *disabling* the old key(s).
" inoremap <esc> <nop>
" note: disabled because when using :norm, I'd like to use <c-v><esc> combination io kj

" Show the cursorline
set cursorline

" Don't use Octal or Hex numbering when autoin(de)crement
set nrformats=

" Use unnamed clipboard to facilitate Copy/Past -> y="*y
set clipboard=unnamed

" Paste yanked text multiple times
xnoremap p pgvy

" https://stackoverflow.com/a/5563142/52598
" Now a Tab let you go to the next buffer and a Shift-Tab to the previous.
nnoremap <silent><tab> :bnext<cr>
nnoremap <silent><s-tab> :bprevious<cr>

" Populate the prompt with all loaded buffers and wait for a buffer to select
nnoremap <leader>b :ls<cr>:b<space>
nnoremap <leader>vb :ls<cr>:vert sb <space>

" Avoid the cursor keys when recalling commands from history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Switch to hex mode
nnoremap <leader>hex :%!xxd<cr>
nnoremap <leader>nhex :%!xxd -r<cr>

" => VIM user interface {{{2
" Set 0 lines to the cursors - when moving vertical..
set so=0

set wildmenu "Turn on WiLd menu
set wildmode=longest:full,full
set wildignore+=.svn;.idea;*.class

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
nnoremap <F6> <c-w>_<c-w><Bar>

" Normalize all windows
nnoremap <F7> <c-w>=

" Resize windows
nnoremap <kPlus>     :silent resize +2<cr>
nnoremap <kMinus>    :silent resize -2<cr>
nnoremap <kDivide>   :silent vertical resize -2<cr>
nnoremap <kMultiply> :silent vertical resize +2<cr>

" => Colors and Fonts {{{2
syntax enable       "Enable syntax highlighting
set synmaxcol=120   "http://stackoverflow.com/questions/901313/editing-xml-files-with-long-lines-is-really-slow-in-vim-what-can-i-do-to-fix-th

" Fast switch to preferred colorschemes.
nnoremap <leader>sc :SetColors my<cr>
nnoremap <leader>nc :call NextColor(0)<cr>

" Set current favourite font
if has ("gui_running")
  if has ("gui_win32")
    set guifont=Consolas:h10:cANSI
    " Likable alternatives
    " set guifont=Courier_New:h10
    " set guifont=Lucida_Console:h9
    " set guifont=Consolas:h9:cANSI

    " Set current favourite colorscheme
    colorscheme xoria256
    "colorscheme eclipse
    " colorscheme molokai
  endif
else
  colorscheme elflord
  set columns=200
endif

" => Files, backups and undo {{{2
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
try
  set undodir=$TEMP
  set undofile
catch
endtry

" Explore settings. Refresh folder with netrw-ctrl-l
"  fast directory browsing; only obtains directory listings when the directory hasn't been seen before
let g:netrw_fastbrowse=2
" <cr> open file in previous window (like 'P')
let g:netrw_browse_split=4
" 3: tree style listing
let g:netrw_liststyle= 3
" Open browser window in vertical split
nnoremap <leader>br :vert 50sp.<cr>

" Paste current filename
inoremap ,fn <c-r>=expand('%:p')<cr>
nnoremap <leader>fn :put =expand('%:p')<cr>

" Current filename to clipboard
nnoremap <leader>fc :let @*=expand('%:p')<cr>

" => Visual mode related {{{2

" => Buffers, Windows {{{2
" Smart way to move btw. windows
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Close the current buffer
noremap <leader>bd :Bclose<cr>
" Close all the buffers (No warnings)
noremap <leader>ba :%bd!<cr>
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
" => Statusline {{{2
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

" => cTags {{{2
"  This will check the current folder for tags file and keep going one directory up all the way to the root folder to
"  find a tags file.
set tags=tags;/
" https://stackoverflow.com/a/6349262/52598
" Create tags. You can then use :tag <filename> to jump to the file
" https://gist.github.com/MarkBorcherding/914528#gistcomment-1948571
execute ":nnoremap <leader>ct :! ctags -R --extra=f --options=" . $VIMRUNTIME ."/ctags.cnf<cr>"

" => Fugitive {{{2
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>

" Auto-clean fugitive buffers - http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
autocmd BufReadPost fugitive://* set bufhidden=delete

" Add current branch to statusline (slows down hjkl A LOT)
" set statusline+=\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P

" => Mru {{{2
nnoremap <leader>m :MRU<cr>

" Remember 1000 most recently used file names
let MRU_Max_Entries = 1000

" Exclude files using patters
let MRU_Exclude_Files = '\v\.(exe|so|dll|dcu|\~\w*)$|\v[\/]\.(git|hg|svn|dcu|\~\w*)$'

" Change the default window height
let MRU_Window_Height = 15

" => Load local settings {{{2
if has('unix') || has('macunix')
  let localvimrc = $HOME . '/.vimrc.local'
else
  let localvimrc = $VIM . '/_vimrc.local'
  if has('win32')
    " MS-Windows
    if $USERPROFILE != ''
      let localvimrc = $USERPROFILE . '\_vimrc.local'
    endif

    " Open Windows explorer with current buffer selected
    nnoremap <F11> :!start explorer /select,%:p<cr>
  endif

  " ssh still required?
  let g:netrw_scp_cmd = '"c:\Program Files (x86)\PuTTY\pscp.exe" -q -batch'
  let g:netrw_sftp_cmd= '"c:\Program Files (x86)\PuTTY\psftp.exe"'
endif

if filereadable(glob(localvimrc))
  :exec ":source " . g:localvimrc

  " Fast editing of the local _vimrc.local
  execute ":noremap <leader>el :e! " . g:localvimrc ."<cr>"
endif

" Should be in principle in _vimrc.local but as I carry the "my" folder with me everywhere,
" I know "I" always want this without having to add it to each local vimrc
if filereadable(expand('$VIM/../Windbg_snippets/Windbg Quick Reference.txt'))
  " Fast editing of the WinDbg Quickreference
  map <leader>ewq :e! $VIM/../Windbg_snippets/Windbg Quick Reference.txt<cr>
endif

if filereadable(expand('$VIM/../Windbg_snippets/Windbg_Readme.txt'))
  " Fast editing of the WinDbg Readme
  map <leader>ewr :e! $VIM/../Windbg_snippets/Windbg_Readme.txt<cr>
endif

if filereadable(expand('$VIM/../debuggers/cmdtree.txt'))
  " Fast editing of the cmdtree
  map <leader>ewc :e! $VIM/../debuggers/cmdtree.txt<cr>
endif

" => Maximize window on startup{{{2
if has('gui_running') && has('win32')
  set guioptions-=T  " Exclude Toolbar
  set guioptions-=m  " Excluse Menu bar
  set guioptions-=r  " Exclude Right-hand scrollbar
  set guioptions-=R  " Exclude Right-hand scrollbar
  set guioptions-=l  " Exclude Left-hand scrollbar
  set guioptions-=L  " Exclude Left-hand scrollbar
  set guioptions-=b  " Exclude Bottom scrollbar
  au GUIEnter * simalt ~x "Maximize window
endif

" => Switch between Powershell and plain cmd. {{{2
"    Note that when using Powershell fugitive and dbext don't work therefore the default is cmd
if has("win32")
  nnoremap <leader>cmd :set shell=cmd shellcmdflag=/c shellquote= shellxquote=(<cr>
  nnoremap <leader>cmdp :set shell=powershell shellcmdflag=-c shellquote=\" shellxquote=<cr>
endif

" => Execute current line with current shell. {{{2
nnoremap <F8> :exec '!'.getline('.')<cr>
