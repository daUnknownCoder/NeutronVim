return {
  "williamboman/mason.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  dependencies = {
    { "williamboman/mason-lspconfig.nvim", cmd = { "LspInstall", "LspUninstall" } },
    { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  },
  opts = {
    ensure_installed = {},
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
    local mason_tool_installer_status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
    if not mason_tool_installer_status_ok then
      print("mason-tool-installer not found!")
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
        "marksman",
        "eslint",
        "clangd",
        "cmake",
        "bashls",
      },
      automatic_installation = true,
    })
    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd",
        "eslint_d",
        "stylua",
        "black",
        "isort",
        "pylint",
        "luacheck",
        "ruff",
        "rustfmt",
        "clang-format",
        "cmakelang",
        "codespell",
        "shfmt",
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 5000,
    })
  end,
}
