return {
	"tpope/vim-sleuth",

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			indent = {
				char = "▏",
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"windwp/nvim-autopairs",
		opts = {},
	},
}
