return {
  "2kabhishek/nerdy.nvim",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-telescope/telescope.nvim",
  },
  cmd = "Nerdy",
  lazy = true,
  keys = {
    {
      "<leader>ma",
      "<cmd>Nerdy<CR>",
      desc = "Find Nerd Glyphs through Nerdy",
    },
  },
}
