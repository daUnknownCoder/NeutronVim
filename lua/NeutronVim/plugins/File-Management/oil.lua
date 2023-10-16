return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
  },
  event = "VeryLazy",
  lazy = false,
  cmd = "Oil",
  keys = {
    { "<leader>mo", "<cmd>Oil<CR>", desc = "Oil" },
  },
}
