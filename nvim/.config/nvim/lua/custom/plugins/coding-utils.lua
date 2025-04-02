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
    event = "InsertEnter",
    opts = {},
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
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
    },
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
  },

}
