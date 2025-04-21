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
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require "plugins.configs.mason"
    end
  },
  {
    "saghen/blink.cmp",
    version = "*",
    config = function()
      require "plugins.configs.completion"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason-lspconfig.nvim"
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
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "vscode"
    end
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
}
