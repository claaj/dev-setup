return {
  {
    'echasnovski/mini.nvim',
    lazy = false,
    priority = 999,
    branch = "main",
    config = function()
      require "plugins.configs.mini"
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPre", "BufNewFile" },
    build = ':TSUpdate',
    config = function()
      require("plugins.configs.treesitter")
    end
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    config = function()
      require "plugins.configs.snacks"
    end
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "plugins.configs.conform"
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        config = function()
          require "plugins.configs.mason"
        end
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    }
  },
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    config = function()
      require "plugins.configs.completion"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason-lspconfig.nvim"
    },
    config = function()
      require "plugins.configs.lsp"
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd.Neogit()
        end,
        desc = "Open Neogit",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signcolumn = true,
    }
  },
  {
    "wtfox/jellybeans.nvim",
    lazy = false,
    priority = 1000,
    opts = { italics = false },
  },
  {
    "marnym/typst-watch.nvim",
    ft = "typst",
    opts = {},
  },
  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "markdown", "vimwiki" },
    config = function()
      require "plugins.configs.markdown"
    end
  }
}
