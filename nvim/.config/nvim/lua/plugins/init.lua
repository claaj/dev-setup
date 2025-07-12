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
    opts = {
      ensure_installed = {
        "bashls",
        "clangd",
        "cmake",
        "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "rust_analyzer",
        "tinymist",
        "yamlls",
        "zls",
      },
    },
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
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ft", ":NvimTreeToggle<CR>", desc = "Toggle tree" },
    },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "gsr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    "amitds1997/remote-nvim.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- For standard functions
      "MunifTanjim/nui.nvim",          -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  }
}
