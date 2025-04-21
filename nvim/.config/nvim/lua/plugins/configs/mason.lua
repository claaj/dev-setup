local mason = require("mason")
local mason_tool_installer = require("mason-tool-installer")

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
  mason_lspconfig = require("mason-lspconfig")
end

mason.setup({
  ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "clangd",
    "cmake",
    "jsonls",
    "lua_ls",
    "marksman",
    "pyright",
    "rust_analyzer",
    "tinymist",
    "yamlls",
    "zls",
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
