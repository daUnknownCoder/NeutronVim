return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
  },
  config = true,
  cmd = "Neogit",
  lazy = true,
  keys = {
    { ";g", "<cmd>Neogit<CR>", desc = "Neogit" },
  },
}
