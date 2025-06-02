local lspconfig = require("lspconfig")

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
  require("mason").setup({})
  mason_lspconfig = require("mason-lspconfig")
end

local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }
    keymap.set('n', 'grr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    keymap.set('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    keymap.set('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
    keymap.set({ 'i', 's' }, '<C-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    opts.desc = "Go to definition"
    keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

    keymap.set('n', 'grt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    keymap.set('n', 'grd', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)

    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = "Smart rename"
    keymap.set('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

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

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = "󰌵 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
})

vim.lsp.config('clangd', {
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
