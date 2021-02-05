call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Valloric/YouCompleteMe'
" Plug 'jiangmiao/auto-pairs'
" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" Plug 'kien/ctrlp.vim'
"colorschemes
Plug 'morhetz/gruvbox'
" 
call plug#end()

syntax on
let g:mapleader=','
colorscheme gruvbox
set background=dark
set number
set expandtab
set tabstop=2

set hlsearch
set incsearch

"mappings

map <C-n> :NERDTreeToggle<CR>
nmap =j :%!python -m json.tool<CR>
