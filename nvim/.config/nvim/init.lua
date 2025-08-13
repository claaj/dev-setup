-- Tiny nvim config -

--- Plugins ---
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/tpope/vim-fugitive" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/WTFox/jellybeans.nvim" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
})

require('mini.icons').setup({ style = 'glyph' })
require("mini.pick").setup()
require('mini.colors').setup({})
require('mini.pairs').setup({})
require('mini.diff').setup({ view = { style = 'sign' } })
require('mini.git').setup({})
require('mini.bufremove').setup({})
require("mini.statusline").setup()
require('mini.notify').setup({
  lsp_progress = { enable = false },
})
local mini_files = require('mini.files')
mini_files.setup({
  mappings = {
    close       = '<Esc>',
    go_in       = '<Right>',
    go_out      = '<Left>',
    synchronize = '=',
  },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})

require("blink.cmp").setup({
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  keymap = {
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
    ["<C-n>"] = { "select_next", "fallback_to_mappings" },

    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },

    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },

  signature = {
    enabled = true,
    window = {
      show_documentation = true,
    },
    trigger = {
      show_on_trigger_character = false,
      show_on_insert_on_trigger_character = false,
    },
  },

  cmdline = {
    enabled = true,
    keymap = { preset = "cmdline" },
    completion = {
      trigger = {
        show_on_blocked_trigger_characters = {},
        show_on_x_blocked_trigger_characters = {},
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
      menu = { auto_show = true },
      ghost_text = { enabled = false },
    },
  },

  fuzzy = { implementation = "lua" },
})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    use_languagetree = true,
  },

  indent = { enable = true, disable = { "python" } },

  auto_install = true,

  ensure_installed = {
    "json",
    "lua",
    "c",
    "rust",
    "python",
    "bash",
    "cpp",
    "gitignore",
    "markdown",
    "markdown_inline",
    "comment",
    "printf",
    "diff",
    "ini",
    "toml"
  }
})

-- Leader
vim.g.mapleader = " "
vim.g.bufferleader = " "

-- Options --
local opt = vim.opt
opt.mouse = ""
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4
opt.signcolumn = "yes"
opt.winborder = "rounded"
opt.clipboard = ""

vim.notify = require('mini.notify').make_notify({})
vim.ui.select = MiniPick.ui_select

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- Keymaps
local keymap = vim.keymap
keymap.set({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to clipboard' })
keymap.set({ 'n', 'x' }, 'gp', '"+p', { desc = 'Paste clipboard content' })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>n", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sk", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<leader>qq", "<cmd>:q<CR>", { desc = "Quit" })
keymap.set('n', '<leader>ff', ":Pick files<CR>")
keymap.set('n', '<leader>bb', ":Pick buffers<CR>")
keymap.set('n', '<leader>gg', ":G<CR>")
keymap.set('n', '<leader>bk', '<cmd>lua pcall(MiniBufremove.delete)<cr>', { desc = 'Close buffer' })
keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>')
keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>')
keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>')
keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>')
keymap.set('n', '<leader>ft', function()
  if mini_files.close() then
    return
  end
  mini_files.open()
end, { desc = 'File explorer' })



-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    keymap.set("n", "grd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
    keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "Go to definition" })
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
    "--fallback-style=Google",
    "--compile-commands-dir=build",
  },
})

vim.cmd([[autocmd BufRead,BufNewFile *.json set filetype=jsonc]])

-- UI
vim.cmd [[ colorscheme jellybeans ]]
