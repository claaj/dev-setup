local mason = require("mason")
local mason_tool_installer = require("mason-tool-installer")

mason.setup({
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
})
mason_tool_installer.setup({
  ensure_installed = {
    "prettier",
    "black",
    "clang-format",
    "isort",
    "stylua",
  },
})
