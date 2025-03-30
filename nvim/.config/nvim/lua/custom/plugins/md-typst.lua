return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
		ft = "markdown",
	},
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "0.3.*",
		build = function()
			require("typst-preview").update()
		end,
	},
}
