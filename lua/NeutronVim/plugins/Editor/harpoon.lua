return {
  "theprimeagen/harpoon",
  keys = {
    { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon" },
    { "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon UI" },
    { "<C-m>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", desc = "Next File [Harpoon] " },
    { "<C-t>", "<cmd>lua require('harpoon.ui').nav_file(-1)<cr>", desc = "Previous File [Harpoon] " },
  },
  lazy = true,
}
