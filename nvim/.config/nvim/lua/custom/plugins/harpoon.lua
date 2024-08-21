return {
	"theprimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{
			"<leader>aa",
			function()
				require("harpoon"):list():add()
			end,
			desc = "harpoon file",
		},
		{
			"<leader>aA",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "harpoon quick menu",
		},
		{
			"<leader>a1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "harpoon to file 1",
		},
		{
			"<leader>a2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "harpoon to file 2",
		},
		{
			"<leader>a3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "harpoon to file 3",
		},
		{
			"<leader>a4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "harpoon to file 4",
		},
		{
			"<leader>a5",
			function()
				require("harpoon"):list():select(5)
			end,
			desc = "harpoon to file 5",
		},
		{
			"<leader>ar1",
			function()
				require("harpoon"):list():remove_at(1)
			end,
			desc = "remove harpoon to file 1",
		},
		{
			"<leader>ar2",
			function()
				require("harpoon"):list():remove_at(2)
			end,
			desc = "remove harpoon to file 2",
		},
		{
			"<leader>ar3",
			function()
				require("harpoon"):list():remove_at(3)
			end,
			desc = "remove harpoon to file 3",
		},
		{
			"<leader>ar4",
			function()
				require("harpoon"):list():remove_at(4)
			end,
			desc = "remove harpoon to file 4",
		},
		{
			"<leader>ar5",
			function()
				require("harpoon"):list():remove_at(5)
			end,
			desc = "remove harpoon to file 5",
		},
	},
}
