"setup vim-plug {{{

  "Note: install vim-plug if not present
  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
  endif

  "Note: Skip initialization for vim-tiny or vim-small.
  if !1 | finish | endif
  if has('vim_starting')
    set nocompatible               " Be iMproved
    " Required:
    call plug#begin()
  endif

"}}}


set encoding=utf-8
call plug#begin("~/.vim/plugged")
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree' 		" File explorer
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'dracula/vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons' " with icon
call plug#end()

filetype plugin on
" vim-go config
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0


if (has("termguicolors"))
   set termguicolors
endif
syntax enable
colorscheme dracula


let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeShowHidden = 1
"let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nmap <leader>e :NERDTreeToggle<CR>

" Better display of messages
set cmdheight=2
" Always show signcolumn
set signcolumn=yes


set listchars=tab:▸\ ,eol:¬ 
" Intergrated Teerminal
" open new split panes to right and below
set splitright
set splitbelow
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
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>



" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" FZF
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" go-vim


