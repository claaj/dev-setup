return {
  {
    "numToStr/Comment.nvim",
    opts = {
      toggler = {
        line = "gcc",
        block = "gbc",
      },
    },
    keys = {
      { "gcc", desc = "Toggle Line Comment (Loads Comment.nvim)" },
      { "gbc", desc = "Toggle Block Comment (Loads Comment.nvim)" },
    },
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      enable_check_bracket_line = true, -- Verificar si hay texto después del paréntesis de apertura
      ignored_next_char = "[%w%.]",     -- Ignorar si el siguiente carácter es una letra o un punto
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup({
        signs = true,     -- Mostrar iconos en la columna de signos
        highlight = {
          keyword = "bg", -- Resaltar palabras clave (TODO, FIXME, etc.)
          after = "fg",   -- Resaltar el texto después de la palabra clave
        },
        colors = {
          error = { "DiagnosticError" },  -- Color para errores
          warning = { "DiagnosticWarn" }, -- Color para advertencias
          info = { "DiagnosticInfo" },    -- Color para información
          hint = { "DiagnosticHint" },    -- Color para sugerencias
        },
      })
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = false },
      picker = { enabled = true },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = true },
    },
  }
}
