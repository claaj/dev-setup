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
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
		config = function()
			local function text_format(symbol)
				local fragments = {}

				-- Indicator that shows if there are any other symbols in the same line
				local stacked_functions = symbol.stacked_count > 0 and (" | +%s"):format(symbol.stacked_count) or ""

				if symbol.references then
					local usage = symbol.references <= 1 and "usage" or "usages"
					local num = symbol.references == 0 and "no" or symbol.references
					table.insert(fragments, ("%s %s"):format(num, usage))
				end

				if symbol.definition then
					table.insert(fragments, symbol.definition .. " defs")
				end

				if symbol.implementation then
					table.insert(fragments, symbol.implementation .. " impls")
				end

				return table.concat(fragments, ", ") .. stacked_functions
			end

			require("symbol-usage").setup({
				text_format = text_format,
			})
		end,
	},
}
