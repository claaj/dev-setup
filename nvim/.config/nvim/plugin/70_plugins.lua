local add, later, now = MiniDeps.add, MiniDeps.later, MiniDeps.now
local now_if_args = _G.Config.now_if_args

now_if_args(function()
	add({
		source = "mason-org/mason-lspconfig.nvim",
		depends = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
	})

	require("mason").setup()
	require("mason-lspconfig").setup()
end)

later(function()
	add("stevearc/conform.nvim")

	require("conform").setup({
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	})
end)

later(function()
	add("rafamadriz/friendly-snippets")
end)

later(function()
	add({
		source = "NeogitOrg/neogit",
		depends = { "nvim-lua/plenary.nvim" },
	})
end)

now(function()
	add("christoomey/vim-tmux-navigator")

	vim.g.tmux_navigator_no_mappings = 1
	vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
	vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
	vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
	vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
	vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")
end)

now_if_args(function()
	add("WTFox/jellybeans.nvim")
	vim.cmd("colorscheme jellybeans")
end)

now_if_args(function()
	add("saghen/blink.cmp")
	require("blink.cmp").setup({
		sources = { default = { "lsp", "path", "snippets", "buffer" } },
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
		},
		signature = {
			enabled = true,
			window = { show_documentation = true },
			trigger = { show_on_trigger_character = false, show_on_insert_on_trigger_character = false },
		},
		fuzzy = { implementation = "lua" },
	})
end)

now_if_args(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		checkout = "master",
		monitor = "main",
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})

	require("nvim-treesitter.configs").setup({
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
			use_languagetree = true,
		},
		indent = { enable = true, disable = { "python" } },
		auto_install = true,
		ensure_installed = {
			"json",
			"lua",
			"c",
			"rust",
			"python",
			"bash",
			"cpp",
			"gitignore",
			"markdown",
			"markdown_inline",
			"comment",
			"printf",
			"diff",
			"ini",
			"toml",
			"just",
			"make",
			"cmake",
		},
	})
end)

vim.lsp.config("clangd", {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--fallback-style=Google",
		"--compile-commands-dir=build",
	},
})
