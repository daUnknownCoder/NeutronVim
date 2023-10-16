return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
  },
  event = "VeryLazy",
  lazy = false,
  cmd = "Oil",
  keys = {
    { "<leader>o", "<cmd>Oil<CR>", desc = "Oil" },
  },
}
