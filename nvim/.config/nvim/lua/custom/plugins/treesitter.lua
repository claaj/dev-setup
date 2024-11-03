return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			highlight = {
				enable = true,
			},

			indent = { enable = true, disable = { "python" } },

			auto_install = true,

			ensure_installed = {
				"json",
				"lua",
				"c",
				"rust",
				"python",
				"bash",
				"cpp",
				"gitignore",
				"markdown",
				"markdown_inline",
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
					keymaps = {
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						["]m"] = "@function.outer",
						["]]"] = "@class.outer",
					},
					goto_next_end = {
						["]M"] = "@function.outer",
						["]["] = "@class.outer",
					},
					goto_previous_start = {
						["[m"] = "@function.outer",
						["[["] = "@class.outer",
					},
					goto_previous_end = {
						["[M"] = "@function.outer",
						["[]"] = "@class.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
