return {
  'theprimeagen/harpoon',
  event = "BufWinEnter",
  lazy = true,
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    vim.keymap.set("n", "<leader>a", function() mark.add_file() end)
    vim.keymap.set("n", "<C-e>", function() ui.toggle_quick_menu() end)
    vim.keymap.set("n", "<C-h>", function() ui.nav_next() end)
    vim.keymap.set("n", "<C-t>", function() ui.nav_prev() end)
  end,
}
