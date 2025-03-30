return {
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VeryLazy",
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
}
