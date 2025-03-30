return {
	"nvim-lua/plenary.nvim",
	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"nvchad/ui",
		config = function()
			require("nvchad")

			vim.api.nvim_set_keymap(
				"n",
				"<leader>tt",
				'<cmd>lua require("nvchad.themes").open({ style = "flat" })<cr>',
				{
					noremap = true,
					silent = true,
					desc = "Select NVCHAD themes",
				}
			)
		end,
	},

	{
		"nvchad/base46",
		lazy = true,
		build = function()
			require("base46").load_all_highlights()
			dofile(vim.g.base46_cache .. "syntax")
		end,
	},

	"nvchad/volt", -- optional, needed for theme switcher
}
