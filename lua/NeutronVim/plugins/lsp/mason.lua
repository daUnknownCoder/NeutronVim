return {
  "williamboman/mason.nvim",
  event = "VeryLazy",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", event = "VeryLazy" },
  },
  config = function()
    local icons = require("NeutronVim.core.icons")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = icons.ui.Check,
          package_uninstalled = icons.ui.Close,
          package_pending = icons.ui.Electric,
        }
      }
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "lua_ls",
        "pyright",
      },
      automatic_installation = true,
    })
  end
}
