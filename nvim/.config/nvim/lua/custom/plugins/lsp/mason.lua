return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"rshkarin/mason-nvim-lint",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")
		local mason_nvim_lint = require("mason-nvim-lint")

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
				"lua_ls",
				"clangd",
				"rust_analyzer",
				"pyright",
				"zls",
				"marksman",
				"jsonls",
				"bashls",
				"cmake",
				"typst_lsp",
				"yamlls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier",
				"stylua",
				"isort",
				"black",
				"clang-format",
			},
		})

		-- mason_nvim_lint.setup({
		-- 	ensure_installed = {
		-- 		"cpplint",
		-- 	},
		-- 	automatic_installation = true,
		-- })
	end,
}
