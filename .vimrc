set encoding=utf-8
set nocompatible

set rtp+=~/.vim/bundle/
call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'mattn/emmet-vim' 		" HTML
"Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'	" git warpper
"Plug 'vim-airline/vim-airline'
Plug 'w0rp/ale'                 " syntax checking and semantic errors

" setup PLug
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
"
call plug#end()
" KEY MAPS
nmap <leader>c :set cursorcolumn!<CR>
nmap <leader>l :set list!<CR>
nmap <leader>h :set hls!<CR>
nmap <leader>n :set nu!<CR>
nmap <leader>t :set et!<CR>
nmap <leader>p :set paste!<CR>
nmap <leader>w :set wrap!<CR>
nmap <leader>f :FufFile<CR>
nmap <leader>d :FufDir<CR>
nmap <leader>b :FufBuffer<CR>
nmap <leader>e :NERDTree<CR>

set listchars=tab:▸\ ,eol:¬ 
"
" press ctrl-v u25b8 for arrow sign only border 
"set listchars=tab:▷\ ,eol:¬ 

set autoindent
set smarttab
set nu
set expandtab
set ruler "for row/column number
set sts=2
set ts=2
set sw=2
set si
set hls

if exists('+colorcolumn')
  set colorcolumn=120
endif


" plugin variables
" 	NERDTree
let g:NERDTreeNodeDelimiter = "\u00a0"

" fzf
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = 'right:60%'

