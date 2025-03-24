return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness
		local builtin = require("telescope.builtin")

		keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files in cwd" })
		keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Find recent files" })
		keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep in current file" })
		keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Current buffers" })
		keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find diagnostics" })
		keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find word under cursor" })

		keymap.set("n", "<leader>bs", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				previewer = false,
			}))
		end, { desc = "Search in current buffer" })

		keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })
		keymap.set("n", "<leader>km", builtin.keymaps, { desc = "Find keymaps" })

		keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
		keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
		keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })

		dofile(vim.g.base46_cache .. "telescope")
	end,
}
