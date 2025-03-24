return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",

	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	{
		"NeogitOrg/neogit",
		config = function()
			local neogit = require("neogit")

			neogit.setup({})
			dofile(vim.g.base46_cache .. "git")
			dofile(vim.g.base46_cache .. "neogit")
			dofile(vim.g.base46_cache .. "diffview")

			vim.keymap.set("n", "<leader>gg", "<cmd>:Neogit<CR>", { desc = "Open Neogit" })
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"sindrets/diffview.nvim", -- optional - Diff integration
		},
	},
}
