vim.cmd('filetype plugin indent on')
local o = vim.opt

local o = vim.opt
local wo = vim.wo
local fn = vim.fn

-- Encoding
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.fileencodings = "utf-8"

-- tabs
o.tabstop = 2 -- how many columns a tab counts for
o.softtabstop=2 
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.expandtab = true -- convert tabs to spaces
o.smartindent = true -- make indenting smarter again

-- searching
o.hlsearch = true -- highlight all matches on previous search pattern
o.incsearch = true
o.ignorecase = false -- ignore case in search patterns
o.smartcase = false

o.autoindent = true
o.backup = false -- creates a backup file
o.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
o.cmdheight = 2 -- space for displaying messages/commands
o.conceallevel = 0 -- so that `` is visible in markdown files
-- o.cursorline = true -- highlight the current line
o.dir = fn.stdpath("data") .. "/swp" -- swap file directory
o.foldenable = false -- disable folding; enable with zi
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldmethod = "expr"
o.hidden = true
o.history = 500 -- Use the 'history' option to set the number of lines from command mode that are remembered.
o.laststatus = 2
o.lazyredraw = true -- do not redraw screen while running macros
o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
o.number = true
o.relativenumber = false
o.scrolloff = 3 -- Minimal number of screen lines to keep above and below the cursor
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = 2 -- always show tabs
o.sidescrolloff = 5 -- The minimal number of columns to scroll horizontally
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = true -- enable/disable swap file creation
o.termguicolors = true -- set term gui colors (most terminals support this)
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 100 -- Time in milliseconds to wait for a key code sequence to complete
o.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
o.autochdir = true
o.updatetime = 300 -- faster completion
o.whichwrap = 'b,s,<,>,[,],h,l'
o.wildmode = "full"
wo.colorcolumn = "99999"
wo.number = true
wo.signcolumn = "yes"
o.updatetime = 300 -- faster completion
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete
o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion
