return {
  "theprimeagen/harpoon",
  keys = {
    { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>" },
    { "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>" },
    { "<C-m>", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>" },
    { "<C-t>", "<cmd>lua require('harpoon.ui').nav_file(-1)<cr>" },
  },
  lazy = true,
}
