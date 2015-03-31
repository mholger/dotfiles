execute pathogen#infect()

set nocompatible
if has("vms")
	set nobcakup
else
	set backup
endif
set backupdir=~/.vim/backup
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set ignorecase
set smartcase
"set cursorline
set ls=2
set nu
set scrolloff=5
set background=dark
"set t_Co=256
set tabstop=4 shiftwidth=4 expandtab

"colorscheme jellybeans
"colorscheme monokai

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

let g:monokai_termtrans=1

hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE

