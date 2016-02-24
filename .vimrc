filetype plugin on
execute pathogen#infect()

set nocompatible
if has("vms")
	set nobackup
else
	set backup
endif
set backupdir=~/.vim/backup
set cpo=aABceFs$
set cm=blowfish
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set ignorecase
set smartcase
set cursorline
set ls=2
set nu
set scrolloff=5
set background=dark
set t_Co=256
set tabstop=4 shiftwidth=4 expandtab

"Lifted from mcj -20160224
set laststatus=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_exit_checks=1
let g:syntastic_enable_perl_checker=1
let g:syntastic_aggregate_errors=1
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\%04B\ %4l,%02c%2V\ %P%*
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"end lifted bits

colorscheme jellybeans
"colorscheme monokai

if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

let g:jellybeans_termtrans=1
"let g:monokai_termtrans=1

hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE

