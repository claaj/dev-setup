-- return {
-- 	"RRethy/base16-nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		require("base16-colorscheme").with_config({
-- 			telescope = true,
-- 			indentblankline = true,
-- 			notify = true,
-- 			ts_rainbow = true,
-- 			cmp = true,
-- 			illuminate = true,
-- 			dapui = true,
-- 		})
-- 		vim.cmd("colorscheme base16-tomorrow-night")
-- 	end,
-- }

return {

	"EdenEast/nightfox.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		vim.cmd("colorscheme carbonfox")
	end,
}
--
-- return {
-- 	{
-- 		"doom-tomorrow-night",
-- 		dir = vim.fn.stdpath("config") .. "/lua/plugins/colors/doom-tomorrow-night",
-- 		lazy = false, -- El tema debe cargarse inmediatamente
-- 		priority = 1000, -- Alta prioridad para cargar antes que otros plugins
-- 		config = function()
-- 			-- Asegurar soporte para colores
-- 			if vim.fn.has("termguicolors") == 1 then
-- 				vim.opt.termguicolors = true
-- 			end
--
-- 			-- Cargar el tema
-- 			vim.cmd("colorscheme doom-tomorrow-night")
-- 		end,
-- 	},
-- }
