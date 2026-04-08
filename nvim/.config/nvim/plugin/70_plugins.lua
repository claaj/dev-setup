local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

add({ 'https://github.com/stevearc/conform.nvim' })

require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  },
})

add({ 'https://github.com/rafamadriz/friendly-snippets' })

add({ "https://github.com/neogitorg/neogit", "https://github.com/nvim-lua/plenary.nvim" })

add({ "https://github.com/christoomey/vim-tmux-navigator" })

vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")

add({ "https://github.com/wtfox/jellybeans.nvim" })
vim.cmd("colorscheme jellybeans")

add({ "https://github.com/saghen/blink.cmp" })
require("blink.cmp").setup({
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
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
    window = { show_documentation = true },
    trigger = { show_on_trigger_character = false, show_on_insert_on_trigger_character = false },
  },
  fuzzy = { implementation = "lua" },
})

add({ 'https://github.com/neovim/nvim-lspconfig' })

local servers = {
  "basedpyright",
  "ruff",
  "clangd",
  "neocmake",
  "ts_ls",
  "eslint",
  "lua_ls",
  "rust_analyzer",
  "zls",
  "tinymist",
  "marksman",
  "nil_ls",
}

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--fallback-style=Google",
    "--compile-commands-dir=build",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders=1",
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = { typeCheckingMode = "basic" },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client)
    client.server_capabilities.hoverProvider = false
  end,
  init_options = {
    settings = {
      lineLength = 88,
      logLevel = "warn",
    },
  },
})

vim.lsp.config("ts_ls", {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

vim.lsp.config("eslint", {
  settings = {
    workingDirectories = { mode = "auto" },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      cargo = { allFeatures = true },
      procMacro = { enable = true },
      inlayHints = {
        chainingHints = { enable = true },
        closingBraceHints = { enable = true },
        parameterHints = { enable = true },
        typeHints = { enable = true },
      },
    },
  },
})

vim.lsp.config("tinymist", {
  settings = {
    formatterMode = "typstfmt",
    exportPdf = "onSave",
  },
})

for _, server in ipairs(servers) do
  local cmd = vim.lsp.config[server].cmd
  if cmd and vim.fn.executable(cmd[1]) == 1 then
    vim.lsp.enable(server)
  end
end

-- MINIMAX TS CONFIG
local ts_update = function() vim.cmd('TSUpdate') end
-- Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
})

local languages = {
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
  "toml",
  "just",
  "make",
  "cmake",
}
local isnt_installed = function(lang)
  return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
end
local to_install = vim.tbl_filter(isnt_installed, languages)
if #to_install > 0 then require('nvim-treesitter').install(to_install) end

local filetypes = {}
for _, lang in ipairs(languages) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end
local ts_start = function(ev) vim.treesitter.start(ev.buf) end
Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
