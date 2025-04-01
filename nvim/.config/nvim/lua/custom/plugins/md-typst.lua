return {
  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    dependencies = {
      "nvim-telescope/telescope.nvim"
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    ft = "markdown",
  },
  {
    "marnym/typst-watch.nvim",
    opts = {},    -- specify options here
    ft = "typst", -- for lazy loading
  },
}
