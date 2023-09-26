return {
  "akinsho/toggleterm.nvim",
  event = "BufReadPost",
  lazy = true,
  keys = {
    { "<leader>\\", "<cmd>ToggleTerm<CR>" },
  },
  config = function()
    local toggleterm = require("toggleterm")
    toggleterm.setup({
      size = 13,
      shade_filetypes = {},
      shade_terminal = true,
      shading_factor = 1,
      start_in_insert = true,
      persist_size = true,
      direction = "float",
      autochdir = true,
    })
  end,
}
