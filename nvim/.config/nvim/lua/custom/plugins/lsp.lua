return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = false,
        severity_sort = true,
      })

      local keymap = vim.keymap -- for conciseness

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf, silent = true }

          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "grr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
          -- keymap.set("n", "grr", vim.lsp.buf.references, opts) -- show definition, references

          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

          opts.desc = "Smart rename"
          -- keymap.set("n", "grn", vim.lsp.buf.rename, opts)              -- smart rename
          keymap.set("n", "grn", require("nvchad.lsp.renamer"), opts) -- smart rename

          -- opts.desc = "Show buffer diagnostics"
          -- keymap.set("n", "grD", Snacks.picker.diagnostics_buffer(), opts) -- show  diagnostics for file

          opts.desc = "Show line diagnostics"
          keymap.set("n", "grd", vim.diagnostic.open_float, opts) -- show diagnostics for line

          opts.desc = "Go to previous diagnostic"
          keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

          opts.desc = "Go to next diagnostic"
          keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

          opts.desc = "Show documentation for what is under cursor"
          keymap.set("n", "K", function()
            vim.lsp.buf.hover({
              border = "rounded",
            })
          end
          , opts) -- show documentation for what is under cursor
        end,
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local server_capabilities = require("blink.cmp").get_lsp_capabilities()

      mason_lspconfig.setup_handlers({
        -- default handler for installed servers
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = server_capabilities,
          })
        end,
      })

      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--log=verbose",
          "--fallback-style=Google",
          "--compile-commands-dir=build",
        },
      })

      -- Disable semantic highlight
      for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
      end


      vim.cmd([[autocmd BufRead,BufNewFile *.json set filetype=jsonc]])

      dofile(vim.g.base46_cache .. "lsp")
    end,
  },
}
