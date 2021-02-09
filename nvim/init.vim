syntax enable

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


" -------------------------------
"  GO LANG
"
filetype plugin on
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"

autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" MAPs

nmap <leader>b :FufBuffer<CR>
nmap <leader>c :set cursorcolumn!<CR>
nmap <leader>d :FufDir<CR>
nmap <leader>e :NERDTree<CR>
nmap <leader>f :FufFile<CR>
nmap <leader>h :set hls!<CR>
nmap <leader>l :set list!<CR>
nmap <leader>n :set nu!<CR>
nmap <leader>p :set paste!<CR>
nmap <leader>t :set et!<CR>
nnoremap <Leader>s :update<CR>
imap <c-u> <esc> Ui
      
set listchars=tab:▸\ ,eol:¬ 

if exists('+colorcolumn')
  set colorcolumn=120
endif
