return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		},
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
		"windwp/nvim-autopairs", -- Integración de autopareo
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		-- Cargar snippets de VSCode (por ejemplo, friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Configurar nvim-autopairs
		require("nvim-autopairs").setup()

		-- Integrar nvim-autopairs con nvim-cmp
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- Configurar cómo nvim-cmp interactúa con el motor de snippets
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- sugerencia anterior
				["<C-j>"] = cmp.mapping.select_next_item(), -- siguiente sugerencia
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- mostrar sugerencias de autocompletado
				["<C-e>"] = cmp.mapping.abort(), -- cerrar ventana de autocompletado
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			-- Fuentes para autocompletado
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- texto dentro del buffer actual
				{ name = "path" }, -- rutas del sistema de archivos
			}),
			-- Configurar lspkind para pictogramas al estilo de VS Code en el menú de autocompletado
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
	end,
}
