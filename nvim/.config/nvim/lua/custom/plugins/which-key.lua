return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    require("which-key").setup({})

    dofile(vim.g.base46_cache .. "whichkey")
  end,
}
