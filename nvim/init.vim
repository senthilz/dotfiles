syntax enable

set splitright
set splitbelow
set autoindent
set smarttab
set nu rnu
set expandtab
set sts=2
set ts=2
set sw=2
set si
set hls
set autowrite
set omnifunc=syntaxcomplete#Complete
set laststatus=2
set cmdheight=2


" -------------------------------
"  GO LANG
"
filetype plugin on
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1   

let g:go_fmt_command = "goimports"
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:airline#extensions#ale#enabled = 1

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

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

