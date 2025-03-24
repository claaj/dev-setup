return {
	"tpope/vim-sleuth",

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"windwp/nvim-autopairs",
		opts = {
			enable_check_bracket_line = true, -- Verificar si hay texto después del paréntesis de apertura
			ignored_next_char = "[%w%.]", -- Ignorar si el siguiente carácter es una letra o un punto
		},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				signs = true, -- Mostrar iconos en la columna de signos
				highlight = {
					keyword = "bg", -- Resaltar palabras clave (TODO, FIXME, etc.)
					after = "fg", -- Resaltar el texto después de la palabra clave
				},
				colors = {
					error = { "DiagnosticError" }, -- Color para errores
					warning = { "DiagnosticWarn" }, -- Color para advertencias
					info = { "DiagnosticInfo" }, -- Color para información
					hint = { "DiagnosticHint" }, -- Color para sugerencias
				},
			})
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = false },
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = false },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = false },
			scroll = { enabled = true },
			statuscolumn = { enabled = false },
			words = { enabled = false },
		},
	},

	{
		"Chaitanyabsprip/fastaction.nvim",
		config = function()
			require("fastaction").setup({})
			vim.keymap.set(
				{ "n", "x" },
				"gra",
				'<cmd>lua require("fastaction").code_action()<CR>',
				{ buffer = bufnr, desc = "Show available code actions" }
			)
		end,
	},
}
