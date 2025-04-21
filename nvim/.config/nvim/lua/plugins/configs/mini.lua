-- Mini plugins config

-- Icons
require('mini.icons').setup({ style = 'glyph' })

-- See :help MiniAi-textobject-builtin
require('mini.ai').setup({ n_lines = 500 })

-- See :help MiniComment.config
require('mini.comment').setup({})

-- See :help MiniSurround.config
require('mini.surround').setup({})

-- See :help MiniExtra
require('mini.extra').setup({})

require('mini.colors').setup({})

-- See :help MiniSnippets.config
require('mini.snippets').setup({})

-- See :help MiniOperators.config
require('mini.operators').setup({})

-- See :help MiniMove.config
require('mini.move').setup({})

-- See :help MiniPairs.config
require('mini.pairs').setup({})

-- See :help MiniDiff.config
require('mini.diff').setup({ view = { style = 'sign' } })

-- See :help MiniGit.config
-- Doesnt work on Ubuntu
-- require('mini.git').setup({})

-- See :help MiniNotify.config
require('mini.notify').setup({
  lsp_progress = { enable = false },
})

-- See :help MiniNotify.make_notify()
vim.notify = require('mini.notify').make_notify({})

-- See :help MiniBufremove.config
require('mini.bufremove').setup({})
-- Close buffer and preserve window layout
vim.keymap.set('n', '<leader>bk', '<cmd>lua pcall(MiniBufremove.delete)<cr>', { desc = 'Close buffer' })

-- See :help MiniFiles.config
local mini_files = require('mini.files')
mini_files.setup({
  mappings = {
    close       = '<Esc>',
    go_in       = '<Right>',
    go_out      = '<Left>',
    synchronize = '=',
  },
})
-- Toggle file explorer
vim.keymap.set('n', '<leader>ft', function()
  if mini_files.close() then
    return
  end
  mini_files.open()
end, { desc = 'File explorer' })

-- See :help MiniPick.config
require('mini.pick').setup({})
-- See available pickers
-- :help MiniPick.builtin
-- :help MiniExtra.pickers
vim.keymap.set('n', '<leader>fr', '<cmd>Pick oldfiles<cr>', { desc = 'Search file history' })
vim.keymap.set('n', '<leader>bb', '<cmd>Pick buffers<cr>', { desc = 'Search open files' })
vim.keymap.set('n', '<leader>ff', '<cmd>Pick files<cr>', { desc = 'Search all files' })
vim.keymap.set('n', '<leader>fg', '<cmd>Pick grep_live<cr>', { desc = 'Search in project' })
vim.keymap.set('n', '<leader>fd', '<cmd>Pick diagnostic<cr>', { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>fs', '<cmd>Pick buf_lines<cr>', { desc = 'Buffer local search' })
vim.ui.select = MiniPick.ui_select

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
    todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
    note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local starter = require('mini.starter')

vim.api.nvim_set_hl(0, 'MiniStarterHeader', { fg = "#da291c", bold = true })

local header = {
  "            @@@@  @@@@@              ",
  "        @@@@@@@@  @@@@@@@@  @@       ",
  "     @@@@         @@@  @@@  @@@@     ",
  "   @@@@    @@@@@  @@@  @@@  @@@@@@   ",
  "  @@@    @@@ @@@  @@@  @@@  @@@ @@@  ",
  " @@@   @@@   @@@  @@@  @@@  @@@  @@@ ",
  "@@@   @@@    @@@  @@@  @@@  @@@   @@@",
  "@@@  @@@@@@@@@@@  @@@  @@@  @@@   @@@",
  "@@@  @@@@    @@@  @@@  @@@  @@@   @@@",
  " @@@  @@@@   @@@  @@@@@@@@  @@@ @@@@ ",
  " @@@@   @@@  @@@  @@@@@@    @@@@@@   ",
  "   @@@@      @@@  @@@ @@@   @@@      ",
  "     @@@@         @@@  @@@  @@@      ",
  "        @@@@@@@@  @@@   @@@ @@       ",
  "            @@@@  @@@                ",
}

local header_string = table.concat(header, "\n")

starter.setup({
  items = {
    { name = "Create new file", action = ":enew",                 section = "Files" },
    { name = "Find files",      action = ":Pick files",           section = "Files" },
    { name = "Open MiniFiles",  action = ":lua MiniFiles.open()", section = "Files" },
    { name = "Recent Files",    action = ":Pick oldfiles",        section = "Files" },
    { name = "Quit",            action = ":qa!",                  section = "Files" },
    { name = "Lazy",            action = ":Lazy",                 section = "Tools" },
    { name = "Mason",           action = ":Mason",                section = "Tools" },
    { name = "Neogit",          action = ":Neogit",               section = "Tools" },
  },
  header = header_string,
  footer = "",
  content_hooks = {
    starter.gen_hook.adding_bullet("- "),
    starter.gen_hook.aligning("center", "center")
  },
})

local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
