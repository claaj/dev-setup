-- return {
--
-- 	"EdenEast/nightfox.nvim",
-- 	priority = 1000,
-- 	lazy = false,
-- 	config = function()
-- 		vim.cmd("colorscheme carbonfox")
-- 	end,
-- }

return {
	{
		"oonamo/ef-themes.nvim",
		priority = 1000,
		opts = {},
		config = function()
			vim.cmd("colorscheme ef-dark")
		end,
	},
}
