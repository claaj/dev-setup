local M = {}

M.base46 = {
  theme = "darcula-dark",
  hl_override = {
    NvDashAscii = {
      bg = "NONE",
      fg = "red",
    },
  },
  integrations = {
    "neogit",
    "mason",
    "telescope",
    "nvimtree",
    "whichkey",
    "diffview",
    "devicons",
    "lsp",
    "treesitter",
    "syntax",
  },
}

M.ui = {
  tabufline = {
    enabled = false,
  },

  term = {
    base46_colors = true,
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  -- telescope = { style = "borderless" },

  statusline = {
    enabled = true,
    theme = "minimal",
  },

  cmp = {
    style = "flat_dark",
  },

  lsp = { signature = false },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "                     @@@  @@@@@@@@                     ",
    "               @@@@@@@@@  @@@@@@@@@@@@                 ",
    "           @@@@@@@@@@@@@  @@@@@@@@@@@@@  @@@           ",
    "        @@@@@@@@@@        @@@@@   @@@@@  @@@@@@        ",
    "      @@@@@@@@    @@@@@@  @@@@@   @@@@@  @@@@@@@@      ",
    "    @@@@@@@   @@@@@@@@@@  @@@@@   @@@@@  @@@@@@@@@@    ",
    "   @@@@@@   @@@@@@@@@@@@  @@@@@   @@@@@  @@@@@@@@@@@   ",
    "  @@@@@@   @@@@@@  @@@@@  @@@@@   @@@@@  @@@@@ @@@@@@  ",
    " @@@@@@  @@@@@@@   @@@@@  @@@@@   @@@@@  @@@@@  @@@@@@ ",
    "@@@@@@   @@@@@     @@@@@  @@@@@   @@@@@  @@@@@   @@@@@ ",
    "@@@@@@  @@@@@@@@@@@@@@@@  @@@@@   @@@@@  @@@@@   @@@@@@",
    "@@@@@@  @@@@@@@@@@@@@@@@  @@@@@   @@@@@  @@@@@   @@@@@@",
    "@@@@@@  @@@@@@@@@@@@@@@@  @@@@@   @@@@@  @@@@@   @@@@@@",
    "@@@@@@   @@@@@     @@@@@  @@@@@   @@@@@  @@@@@  @@@@@@ ",
    " @@@@@@  @@@@@@@   @@@@@  @@@@@   @@@@@  @@@@@ @@@@@@  ",
    "  @@@@@@   @@@@@@  @@@@@  @@@@@@@@@@@@   @@@@@@@@@@@   ",
    "   @@@@@@   @@@@@  @@@@@  @@@@@@@@@      @@@@@@@@@     ",
    "    @@@@@@@    @@  @@@@@  @@@@@@@@@@     @@@@@         ",
    "      @@@@@@@@     @@@@@  @@@@@ @@@@@    @@@@@         ",
    "        @@@@@@@@@@        @@@@@  @@@@@   @@@@@         ",
    "           @@@@@@@@@@@@@  @@@@@   @@@@@  @@@           ",
    "               @@@@@@@@@  @@@@@    @@@@@               ",
    "                     @@@  @@@@@                        ",
    "                                                       ",
  },

  buttons = {
    { txt = "─", hl = "NvDashAscii", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashAscii",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashAscii", no_gap = true, rep = true },
  },
}

return M
