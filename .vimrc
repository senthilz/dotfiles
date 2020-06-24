set encoding=utf-8
set nocompatible

set rtp+=~/.vim/bundle/
call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf'
Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'
Plug 'hashivim/vim-terraform'
Plug 'mattn/emmet-vim' 		" HTML
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons' " with icon
Plug 'tpope/vim-fugitive'	" git warpper
Plug 'w0rp/ale'                 " syntax checking and semantic errors

Plug 'NLKNguyen/papercolor-theme'
call plug#end()

let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeShowHidden = 1
"let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" setup PLug one time 
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"

" KEY MAPS
" go-vim
" map <C-n> :cnext<CR>
" map <C-m> :cprevious<CR>
" nnoremap <leader>a :cclose<CR>
filetype plugin on
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)

" global in normal mode
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
set autowrite
set omnifunc=syntaxcomplete#Complete
set laststatus=2

if exists('+colorcolumn')
  set colorcolumn=120
endif
