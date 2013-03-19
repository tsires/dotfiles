" Options
set nocompatible
"  Backups
set nobackup					" keep a backup file
"set backupdir=./.backup,~/.backup		" don't litter the filesystem with backups
"set backupskip=					" allow backups anywhere
"  Editing
set backspace=start,indent,eol
"  Indenting
set autoindent					" turn on autoindent
"set preserveindent				" hopefully will keep indents clean?
"  Interface
set completeopt=menu,menuone,longest,preview	" completion will behave more like the shell
set incsearch					" do incremental searching
set mouse=a					" enable mouse
set ruler					" show the cursor position all the time
set shortmess=ilmxI				" plenty of space
set showcmd					" display incomplete commands
set showtabline=2				" always show tab line
set title					" use title (for screen hstatus)
set timeoutlen=250				" lowered from 1000ms to 250ms, to be more responsive
"  Other settings
set history=200					" keep 200 lines of command line history
"  Format strings
set titlestring=%([%M%R%W]\ %)%f%(\ %y%)
"  Terminal settings
if $term != 'linux'
  set t_ts=]2; t_fs=			" to set status line
endif

syntax on
if &t_Co == 256
  colorscheme BusyBee
else
  colorscheme murphy
endif

" Autocommands
filetype plugin indent on
autocmd FileType text setlocal textwidth=78
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Mapped keys
inoremap <C-U> <C-G>u<C-U>
"  Since I usually just do this by accident...
nnoremap wq :wq
nnoremap q :q
"  And, double q to actually start/stop recording
nnoremap qq q

