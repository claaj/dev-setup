--  ############################### SIMPLE NVIM CONFIG ############################### --

-- ################################ PLUGINS ################################ --
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/christoomey/vim-tmux-navigator" },
  { src = "https://github.com/WTFox/jellybeans.nvim" },
})

require("mini.icons").setup({ style = "glyph" })

require("mini.surround").setup()

require("mini.pairs").setup()

require("mini.diff").setup({ view = { style = "sign" } })

require("mini.git").setup()

require("mini.notify").setup({
  lsp_progress = { enable = false },
})

require("mini.pick").setup({
  window = {
    config = function()
      local h, w = math.floor(0.618 * vim.o.lines), math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = h,
        width = w,
        row = math.floor((vim.o.lines - h) / 2),
        col = math.floor((vim.o.columns - w) /
          2)
      }
    end
  }
})

require("mini.extra").setup()

require("mini.files").setup({
  mappings = {
    close       = "<Esc>",
    go_in       = "<Right>",
    go_out      = "<Left>",
    synchronize = "=",
  },
})

require("mini.indentscope").setup({
  draw = {
    delay = 0,
    animation = nil,
  },
  options = { try_as_border = true },
  symbol = "│"
})

require("mini.hipatterns").setup({
  highlighters = {
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  }
})

local miniclue = require('mini.clue')
miniclue.setup({
  window = { delay = 100 },
  triggers = {
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },
    { mode = 'i', keys = '<C-x>' },
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require("mason").setup()

require("mason-lspconfig").setup()

require("conform").setup({
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  }
})

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
    trigger = { show_on_trigger_character = false, show_on_insert_on_trigger_character = false }
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
    "toml",
    "just",
    "make",
    "cmake",
  }
})

-- #################################### OPTIONS ################################# --
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

-- ################################### KEYMAPS ################################# --
vim.g.mapleader = " "
vim.g.bufferleader = " "
local keymap = vim.keymap
keymap.set({ "n", "x" }, '<leader>y', '"+y', { desc = "Yank to clipboard" })
keymap.set({ "n", "x" }, '<leader>p', '"+p', { desc = "Paste from clipboard" })
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>N", ":nohl<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set('n', '<leader>f', ":Pick files<CR>", { desc = "Open file picker" })
keymap.set('n', '<leader>b', ":Pick buffers<CR>", { desc = "Open buffer picker" })
keymap.set('n', '<leader>s', ":Pick lsp scope='document_symbol'<CR>", { desc = "Open symbols picker" })
keymap.set('n', '<leader>S', ":Pick lsp scope='workspace_symbol'<CR>", { desc = "Open workspace symbols picker" })
keymap.set('n', '<leader>h', ":Pick lsp scope='references'<CR>", { desc = "Select symbols references" })
keymap.set('n', '<leader>g', ":Neogit<CR>", { desc = "Open neogit" })
keymap.set('n', '<leader>d', ":Pick diagnostic<CR>", { desc = "Open diagnostic picker" })
keymap.set('n', '<leader>n', ":Pick hipatterns<CR>", { desc = "Open hipatterns picker" })
keymap.set('n', '<leader>c', ":normal gcc<CR>", { desc = "Comment/Uncomment" })
keymap.set('n', '<leader>r', ":normal grn<CR>", { desc = "Rename symbol" })
keymap.set('n', '<leader>a', ":normal gra<CR>", { desc = "Perform code action" })
keymap.set('n', '<leader>k', ":normal K<CR>", { desc = "Show docs for item under cursor" })
keymap.set('n', '<leader>/', ":Pick grep_live<CR>", { desc = "Search in current workspace" })
keymap.set('n', '<leader>U', ":lua vim.pack.update()<CR>", { desc = "Update plugins" })
keymap.set('n', '<C-h>', '<Cmd>TmuxNavigateLeft<CR>', { desc = "Move to left pane" })
keymap.set('n', '<C-j>', '<Cmd>TmuxNavigateDown<CR>', { desc = "Move to down pane" })
keymap.set('n', '<C-k>', '<Cmd>TmuxNavigateUp<CR>', { desc = "Move to up pane" })
keymap.set('n', '<C-l>', '<Cmd>TmuxNavigateRight<CR>', { desc = "Move to right pane" })
keymap.set('n', '<leader>e', function() return MiniFiles.close() or MiniFiles.open() end, { desc = 'File explorer' })
keymap.set('n', '<leader>x', function() return vim.cmd(vim.fn.winnr('$') > 1 and 'close' or 'bdelete') end,
  { desc = 'Close split or buffer' })

-- ################################# LSP ############################# --
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function()
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
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
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

-- ######################### STATUSLINE ######################### --

_G.M = function()
  local m = vim.api.nvim_get_mode().mode; return ({ n = 'NOR', i = 'INS', v = 'VIS', V = 'V-L', ["\22"] = 'V-B', c = 'CMD', R = 'REP', s = 'SEL', t = 'TER' })
      [m] or m
end
_G.DE = function()
  local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }); return n > 0 and tostring(n) or ''
end
_G.DW = function()
  local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }); return n > 0 and tostring(n) or ''
end
_G.DH = function()
  local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }); return n > 0 and tostring(n) or ''
end
_G.LSP = function()
  local c = vim.lsp.get_clients({ buf = 0 })[1]; return c and c.name or ''
end
_G.GIT_BRANCH = function()
  local s = vim.b.minigit_summary or {}
  local name = s.head_name
  if name == 'HEAD' and s.head then
    name = string.sub(s.head, 1, 7) -- detached HEAD
  end
  return (name and name ~= '') and ('  ' .. name) or ''
end

vim.o.statusline =
    " %{v:lua.M()}  %<%f%{&modified?' ':''}%{&readonly?' ':''}" ..
    " %{v:lua.GIT_BRANCH()} %=" ..
    "%#DiagnosticHint#%{v:lua.DH()!=''?' ':''}%*%{v:lua.DH()} " ..
    "%#DiagnosticWarn#%{v:lua.DW()!=''?' ':''}%*%{v:lua.DW()} " ..
    "%#DiagnosticError#%{v:lua.DE()!=''?' ':''}%*%{v:lua.DE()} " ..
    " %{v:lua.LSP()} " ..
    " %l:%c "

-- ################################## UI ############################# --
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.ui.select = MiniPick.ui_select

vim.notify = require("mini.notify").make_notify({})

local starter = require('mini.starter')
starter.setup({
  items = {
    { name = "Create new file", action = ":enew",                 section = "" },
    { name = "File picker",     action = ":Pick files",           section = "" },
    { name = "Explorer",        action = ":lua MiniFiles.open()", section = "" },
    { name = "Recent Files",    action = ":Pick oldfiles",        section = "" },
    { name = "Mason",           action = ":Mason",                section = "" },
    { name = "Git",             action = ":Neogit",               section = "" },
    { name = "Quit",            action = ":qa!",                  section = "" },
  },
  header = " Neovim " .. tostring(vim.version()),
  footer = "",
  content_hooks = {
    starter.gen_hook.adding_bullet("- "),
    starter.gen_hook.aligning("center", "center")
  },
})

vim.cmd [[ colorscheme jellybeans ]]
