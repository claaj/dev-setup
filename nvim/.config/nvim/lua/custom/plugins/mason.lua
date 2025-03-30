return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
		},
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

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
				"tinymist",
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

		dofile(vim.g.base46_cache .. "mason")
	end,
}
