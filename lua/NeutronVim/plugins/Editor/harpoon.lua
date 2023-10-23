return {
  "theprimeagen/harpoon",
  keys = {
    { "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Add File to Harpoon" },
    { "<C-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", desc = "Harpoon UI" },
    { "]]", [[lua require("harpoon.ui").nav_next()]], mode = { "n", "x" } },
    { "[[", [[lua require("harpoon.ui").nav_prev()]], mode = { "n", "x" } },
  },
  lazy = true,
}
