vim.g.mapleader = " "

local keymap = vim.keymap
-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

local api = vim.api
api.nvim_set_keymap('n', '<Leader>t', '', {
    noremap = true,
    callback = function()
      local date = os.date('*t')
      local time = os.date("*t")
      print(os.date("%A, %m %B %Y | "), ("%02d:%02d:%02d"):format(time.hour, time.min, time.sec))
    end,
    -- Since Lua function don't have a useful string representation, you can use the "desc" option to document your mapping
    desc = 'prints current date and time',
})
