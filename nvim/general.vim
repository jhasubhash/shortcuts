" COMMON
set number relativenumber
set background=dark
set tabstop=4 softtabstop=4
set shiftwidth=4
"set extendtab
"set samrtindent
set nohlsearch
set scrolloff=8
set ignorecase
set smartcase

set termguicolors

"navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" open new split panes to right and below
set splitright
set splitbelow

"COC Menu color fix
"highlight Pmenu ctermbg=black guibg=black


