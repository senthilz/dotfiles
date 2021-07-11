require('telescope').setup({
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },
  defaults = {
    layout_config = {
      vertical = { width = 0.5 }
      -- other layout configuration here
    },
    -- other defaults configuration here
  },
  -- other configuration values here
})
