require("render-markdown").setup({
  completions = { blink = { enabled = true }, lsp = { enabled = true } },
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
})
