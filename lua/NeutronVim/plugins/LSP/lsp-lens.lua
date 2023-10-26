return {
  "VidocqH/lsp-lens.nvim",
  lazy = true,
  event = "LspAttach",
  opts = {
    enable = true,
    include_declaration = true,
    sections = {
      definitions = true,
    },
  },
}
