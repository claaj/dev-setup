local now, later = MiniDeps.now, MiniDeps.later

now(function()
  require("mini.basics").setup({
    options = { basic = false },
    mappings = {
      -- Create `<C-hjkl>` mappings for window navigation
      windows = true,
      -- Create `<M-hjkl>` mappings for navigation in Insert and Command modes
      move_with_alt = true,
    },
  })
end)

now(function()
  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require("mini.icons").setup({
    { style = "glyph" },
    use_file_extension = function(ext, _)
      return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)])
    end,
  })

  -- Mock 'nvim-tree/nvim-web-devicons' for plugins without 'mini.icons' support.
  -- Not needed for 'mini.nvim' or MiniMax, but might be useful for others.
  later(MiniIcons.mock_nvim_web_devicons)

  -- Add LSP kind icons. Useful for 'mini.completion'.
  later(MiniIcons.tweak_lsp_kind)
end)

now(function()
  require("mini.notify").setup()
end)

now(function()
  local starter = require("mini.starter")
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
    header = " Neovim "
        .. string.format("%s.%s.%s", vim.version().major, vim.version().minor, vim.version().patch),
    footer = "",
    content_hooks = {
      starter.gen_hook.adding_bullet("- "),
      starter.gen_hook.aligning("center", "center"),
    },
  })
end)

now(function()
  -- Enable directory/file preview
  require("mini.files").setup({
    -- windows = { preview = true },
    mappings = {
      close = "<Esc>",
      go_in = "<Right>",
      go_out = "<Left>",
      synchronize = "=",
    },
  })

  -- Add common bookmarks for every explorer. Example usage inside explorer:
  -- - `'c` to navigate into your config directory
  -- - `g?` to see available bookmarks
  local add_marks = function()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
    local minideps_plugins = vim.fn.stdpath("data") .. "/site/pack/deps/opt"
    MiniFiles.set_bookmark("p", minideps_plugins, { desc = "Plugins" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
  end
  _G.Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
end)

later(function()
  require("mini.extra").setup()
end)

later(function()
  require("mini.bufremove").setup()
end)

later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    window = { delay = 100 },
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "i", keys = "<C-x>" },
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
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
end)

-- later(function() require('mini.cmdline').setup() end)

later(function()
  require("mini.comment").setup()
end)

-- later(function()
--   -- Customize post-processing of LSP responses for a better user experience.
--   -- Don't show 'Text' suggestions (usually noisy) and show snippets last.
--   local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
--   local process_items = function(items, base)
--     return MiniCompletion.default_process_items(items, base, process_items_opts)
--   end
--   require('mini.completion').setup({
--     lsp_completion = {
--       -- Without this config autocompletion is set up through `:h 'completefunc'`.
--       -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
--       -- (sets up only when needed) and makes it possible to use `<C-u>`.
--       source_func = 'omnifunc',
--       auto_setup = false,
--       process_items = process_items,
--     },
--   })
--
--   -- Set 'omnifunc' for LSP completion only when needed.
--   local on_attach = function(ev)
--     vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
--   end
--   _G.Config.new_autocmd('LspAttach', nil, on_attach, "Set 'omnifunc'")
--
--   -- Advertise to servers that Neovim now supports certain set of completion and
--   -- signature features through 'mini.completion'.
--   vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
-- end)

later(function()
  require("mini.diff").setup({ view = { style = "sign" } })
end)

later(function()
  require("mini.git").setup()
end)

later(function()
  local hipatterns = require("mini.hipatterns")
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup({
    highlighters = {
      -- Highlight a fixed set of common words. Will be highlighted in any place,
      -- not like "only in comments".
      fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),

      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function()
  require("mini.indentscope").setup({
    draw = {
      delay = 0,
      animation = nil,
    },
    options = { try_as_border = true },
    symbol = "│",
  })
end)

later(function()
  require("mini.keymap").setup()
  -- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
  MiniKeymap.map_multistep("i", "<Tab>", { "pmenu_next" })
  MiniKeymap.map_multistep("i", "<S-Tab>", { "pmenu_prev" })
  -- On `<CR>` try to accept current completion item, fall back to accounting
  -- for pairs from 'mini.pairs'
  MiniKeymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
  -- On `<BS>` just try to account for pairs from 'mini.pairs'
  MiniKeymap.map_multistep("i", "<BS>", { "minipairs_bs" })
end)

later(function()
  -- Create pairs not only in Insert, but also in Command line mode
  require("mini.pairs").setup({ modes = { command = true } })
end)

later(function()
  require("mini.pick").setup({
    window = {
      config = function()
        local h, w = math.floor(0.618 * vim.o.lines), math.floor(0.618 * vim.o.columns)
        return {
          anchor = "NW",
          height = h,
          width = w,
          row = math.floor((vim.o.lines - h) / 2),
          col = math.floor((vim.o.columns - w) / 2),
        }
      end,
    },
  })

  vim.ui.select = MiniPick.ui_select
end)

later(function()
  require("mini.notify").setup({
    lsp_progress = { enable = false },
  })
  vim.notify = require("mini.notify").make_notify({})
end)

later(function()
  require("mini.surround").setup()
end)
