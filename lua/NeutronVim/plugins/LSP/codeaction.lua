return {
  {
    "aznhe21/actions-preview.nvim",
    keys = {
      { "\\a", "<cmd>lua require('actions-preview').code_actions()<CR>", desc = "CodeActionMenu" },
      { "\\A", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", desc = "Range Code Action" },
    },
    lazy = true,
    event = "LspAttach",
    config = function()
      require("actions-preview").setup({
        telescope = {
          sorting_strategy = "ascending",
          layout_strategy = "vertical",
          layout_config = {
            width = 0.8,
            height = 0.9,
            prompt_position = "top",
            preview_cutoff = 20,
            preview_height = function(_, _, max_lines)
              return max_lines - 15
            end,
          },
        },
      })
    end,
  },
}
