set encoding=utf-8
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'w0rp/ale'
Plugin 'mattn/emmet-vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'FuzzyFinder'
Plugin 'hashivim/vim-terraform'
Plugin 'fatih/vim-go'
Plugin 'beautify-web/js-beautify'
call vundle#end()

" Fix for ^G appearing in the dir list 
" https://github.com/scrooloose/nerdtree/issues/928
let g:NERDTreeNodeDelimiter = "\u00a0"

" https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <silent> <Leader>v :NERDTreeFind<CR>

filetype plugin indent on


" perltidy - http://www.perlmonks.org/?node_id=540167
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _t :!perltidy -q<Enter>

" dont use Q for Ex mode
map Q :q

"nnoremap <Up> :echomsg "use k"<cr>
"nnoremap <Down> :echomsg "use j"<cr>
"nnoremap <Left> :echomsg "use h"<cr>
"nnoremap <Right> :echomsg "use l"<cr>
" check syntax with Ctrl + L
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

"  To save file without hitting escape key 
"
imap <c-s> <c-o><c-s><CR>

" Insert mode keys
"
imap <F2> use Data::Dumper;
imap <F4> USE dumper;'<pre>'; dumper.dump(  );'</pre>';STOP;


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

" -------------------------------------
"Following short cut keys will work with Crtl+starting alphabet of the function
"nmap <silent> <C-h> <Esc>:call ToggleHLSearch()<CR>
"nmap <silent> <C-n> <Esc>:set nu!<CR>
" press ctrl-v u00ac for knot sign
" press ctrl-v u25b8 for arrow sign
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

syntax on
"autocmd FileType perl set smartindent

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* SetTab call SetTab()
function! SetTab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call ShowTabs()
endfunction
 
function! ShowTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction

" terraform
let g:terraform_fmt_on_save=1
let g:terraform_align=1
let g:terraform_fold_sections=1

function ShowTFvars()
  echohl ModeMsg
  echo ' terraform algin set to 'g:terraform_fmt_on_save 
endfunction

function ToggleTFfmt()
  echohl ModeMsg
  if g:terraform_fmt_on_save==1
    let &g:terraform_align=0
    let g:terraform_fmt_on_save=0
    let g:terraform_fmt_on_save=0
  else
    let g:terraform_align=1
    let g:terraform_fmt_on_save=1
    let g:terraform_fmt_on_save=1
  endif

  call ShowTFvars()
endfunction
" Focus main window, not NERDTree
"augroup NERD
"  autocmd!
"  autocmd VimEnter * NERDTree
"  autocmd VimEnter * wincmd p
"augroup END

" For serious
let NERDTreeShowHidden=1


let g:ale_completion_enabled = 1
"show errors or warnings in my statusline
let g:airline#extensions#ale#enabled = 1

function Setlinenum()
  echom "Done"
endfunction

set clipboard=unnamed
