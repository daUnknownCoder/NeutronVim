return {
  "hinell/lsp-timeout.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  init = function()
    vim.g["lsp-timeout-config"] = {
      stopTimeout = 1000 * 60 * 5,
      startTimeout = 1000 * 10,
      silent = false,
    }
  end,
}
