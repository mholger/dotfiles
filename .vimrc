filetype plugin on
execute pathogen#infect()

set nocompatible
set modelines=5

"if has("vms")
	set nobackup
"else
"	set backup
"endif
set backupdir=~/.vim/backup
set cpo=aABceFs$
"set cm=blowfish
set noswapfile
set history=50
set ruler
set showcmd
set incsearch
set ignorecase
set smartcase
set cursorline
set cursorcolumn
set ls=2
set nu
set rnu
set scrolloff=5
"set background=dark
set t_Co=256
set tabstop=4 shiftwidth=4 expandtab

"Lifted from mcj -20160224
set laststatus=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
let g:syntastic_exit_checks=1
let g:syntastic_enable_perl_checker=1
let g:syntastic_aggregate_errors=1
"set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\%04B\ %4l,%02c%2V\ %P%*
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"end lifted bits

"colorscheme nord
"colorscheme jellybeans
"colorscheme monokai
colorscheme synthwave

"if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
"endif

let g:nord_termtrans=1
let g:nord_bold_vertical_split_line = 1
let g:nord_cursor_line_number_background = 1
"let g:nord_comment_brightness = 12
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

"let g:jellybeans_termtrans=1
"let g:monokai_termtrans=1
let g:synthwave_termtrans=1

hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE

" After hyper.is fixes 256 color mode
set termguicolors
"hi CursorLine ctermbg=0

"autocmd vimenter * NERDTree

" I do not like this, but C-H is br0ke for whatever reason
"#nnoremap <C-J> <C-W><C-H>
"nnoremap <C-K> <C-W><C-J>
"nnoremap <C-I> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>

" New splits should open to the right or below the active split;
" not sure why the default behavior is wrong, but ... it is. ;)
set splitbelow
set splitright

highlight CursorColumn guibg=#2f2f4f
highlight CursorLine guibg=#2a2a40
