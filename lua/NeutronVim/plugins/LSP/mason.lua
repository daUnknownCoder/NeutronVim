return {
  "williamboman/mason.nvim",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", event = "BufRead" },
  },
  opts = {
    ensure_installed = {
      "black",
      "mypy",
      "ruff",
      "eslint_d",
      "luacheck",
      "prettier",
      "stylua",
    },
  },
  config = function()
    local icons = require("NeutronVim.core.icons")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        icons = {
          package_installed = icons.ui.Check,
          package_uninstalled = icons.ui.Uncheck,
          package_pending = icons.ui.Electric,
        },
      },
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
  end,
}
