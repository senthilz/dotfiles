return {
	"nvimtools/none-ls.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		mason_null_ls.setup({
			ensure_installed = {
				"stylua",
				"prettier", -- markdown
				"shellcheck", -- sh script
				"golangci_lint",
			},
		})
		builtins = null_ls.builtins
		null_ls.setup({
			sources = {
				builtins.completion.spell,
				builtins.diagnostics.eslint, -- javascript formatting
				builtins.diagnostics.golangci_lint,
				builtins.formatting.prettier,
				builtins.formatting.shfmt, -- shell script formatting
				builtins.formatting.stylua, -- lua formatting
				builtins.diagnostics.shellcheck, -- shell script diagnostics
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
