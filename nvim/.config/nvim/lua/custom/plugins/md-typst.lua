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
    opts = {
      -- render_modes = true,
      heading = {
        sign = false,
        border = false,
        below = "",
        above = "",
        left_pad = 0,
        position = "left",
        icons = {
          "█ ",
          "██ ",
          "███ ",
          "████ ",
          "█████ ",
          "██████ ",
        },
      },
      overrides = {
        buftype = {
          nofile = {
            code = {
              border = "hide",
              style = "normal",
              render_modes = true,
              left_pad = 0,
              right_pad = 0
            },
          },
        },
      },
    },
    ft = { "markdown", "vimwiki" },
  },
  {
    "marnym/typst-watch.nvim",
    opts = {},    -- specify options here
    ft = "typst", -- for lazy loading
  },
}
