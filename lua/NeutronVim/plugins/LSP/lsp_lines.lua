return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    local lsplines_status_ok, lsplines = pcall(require, "lsp_lines")
    if not lsplines_status_ok then
      print("lsp_lines not found!")
    end
    lsplines.setup({})
    vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
    vim.diagnostic.config({ virtual_lines = false }, require("lazy.core.config").ns)
  end,
}
