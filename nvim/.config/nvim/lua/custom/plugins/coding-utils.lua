return {
	"tpope/vim-sleuth",

	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			chunk = {
				enable = false,
			},
			indent = {
				enable = true,
			},
		},
	},

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"windwp/nvim-autopairs",
		opts = {
			disable_filetype = { "TelescopePrompt", "vim" }, -- Desactivar en ciertos tipos de archivos
			enable_check_bracket_line = true, -- Verificar si hay texto después del paréntesis de apertura
			ignored_next_char = "[%w%.]", -- Ignorar si el siguiente carácter es una letra o un punto
		},
	},
}
