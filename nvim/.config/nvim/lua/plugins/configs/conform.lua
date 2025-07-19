local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua --indent-type Spaces --indent-width 4" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
  },

  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },

})
