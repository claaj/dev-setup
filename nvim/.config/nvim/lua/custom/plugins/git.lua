return {
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "NeogitOrg/neogit",
    keys = {
      {
        "<leader>gg",
        function()
          vim.cmd.Neogit()
        end,
        desc = "Open Neogit",
      },
    },
    config = function()
      local neogit = require("neogit")
      neogit.setup({})

      if vim.g.base46_cache then
        pcall(dofile, vim.g.base46_cache .. "git")
        pcall(dofile, vim.g.base46_cache .. "neogit")
      end
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
