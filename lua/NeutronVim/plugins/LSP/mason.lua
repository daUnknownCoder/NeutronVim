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
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    local mason_status_ok, mason = pcall(require, "mason")
    if not mason_status_ok then
      print("mason not found!")
    end
    local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lspconfig_status_ok then
      print("mason-lspconfig not found!")
    end

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
