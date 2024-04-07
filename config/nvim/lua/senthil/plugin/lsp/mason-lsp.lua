return {
	"williamboman/mason.nvim",

	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		local mason = require("mason") -- import mason
		local mason_lspconfig = require("mason-lspconfig")
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			ensure_installed = {
				"html",
				"gopls",
			},
			automatic_installation = true,
		})
	end,
}
