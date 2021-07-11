local wk = require("which-key")
local mappings = {
  q = { ":q<cr>", "Quit" },
  w = { ":w<cr>", "Save" },
  x = { ":bdelete<cr>", "Close" },
  e = { ":NERDTreeToggle<cr>", "Open file explorer"},
  n = { ":NERDTreeFocus<cr>", "Focus file explorer"},
  f = { "<cmd>Telescope find_files<cr>", "Find Files" },
  g = { "<cmd>Telescope live_grep<cr>", "Live grep" }, 
  t = {
    name = "Telescoper git",
    s = { "<cmd>Telescope git_status<cr>", "Git status" }, 
    c = { "<cmd>Telescope git_commits<cr>", "Git commits" }, 
  }
}
local opts = {prefix = '<leader>'}

wk.register(mappings, opts)

-- wk.register({
-- ["<leader>e"] = { ":NvimTreeToggle<cr>", "Open file explorer"}
-- })
