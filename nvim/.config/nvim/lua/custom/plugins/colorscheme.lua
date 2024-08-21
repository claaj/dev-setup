-- return {
--     "HoNamDuong/hybrid.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function()
--       vim.cmd.colorscheme("hybrid")
--     end,
-- }

return {
	"RRethy/base16-nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("base16-colorscheme").with_config({
			telescope = true,
			indentblankline = true,
			notify = true,
			ts_rainbow = true,
			cmp = true,
			illuminate = true,
			dapui = true,
		})
		vim.cmd("colorscheme base16-tomorrow-night")
	end,
}

-- return {
-- 	priority = 1000,
-- 	"olimorris/onedarkpro.nvim",
-- 	config = function()
-- 		require("onedarkpro").setup({
-- 			colors = {
-- 				onedark = {
-- 					bg = "#1d1f21",
-- 					fg = "#c5c8c6",
-- 					red = "#cc6666",
-- 					orange = "#de935f",
-- 					yellow = "#f0c674",
-- 					green = "#b5db68",
-- 					cyan = "#8abeb7",
-- 					blue = "#81a2be",
-- 					purple = "#b294bb",
-- 					white = "#fafafa",
-- 					black = "#161719",
-- 					gray = "#5a5b5a",
-- 					highlight = "#161719",
-- 					cursorline = "#161719",
-- 					bg_statusline = "#161719",
-- 					comment = "#5a5b5a",
-- 					line_number = "#5a5b5a",
-- 				},
--
-- 				onelight = {
-- 					bg = "#ffffff",
-- 					fg = "#4d4d4c",
-- 					red = "#c82829",
-- 					orange = "#f5871f",
-- 					yellow = "#c29700",
-- 					green = "#718c00",
-- 					cyan = "#8abeb7",
-- 					blue = "#4271ae",
-- 					purple = "#8959a8",
-- 					white = "#fafafa",
-- 					black = "#1d1f21",
-- 					gray = "#8e908c",
-- 					highlight = "#f2f2f2",
-- 					cursorline = "#f2f2f2",
-- 					comment = "#8e908c",
-- 					line_number = "#8e908c",
-- 				},
-- 			},
--
-- 			options = {
-- 				cursorline = true,
-- 			},
--
-- 			styles = {
-- 				comments = "italic",
-- 				keywords = "bold,italic",
-- 				strings = "italic",
-- 			},
-- 		})
-- 		vim.cmd("colorscheme onedark")
-- 	end,
-- }
