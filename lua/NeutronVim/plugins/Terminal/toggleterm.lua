return {
  "akinsho/toggleterm.nvim",
  lazy = true,
  keys = {
    { "<leader>m\\", "<cmd>ToggleTerm<CR>", desc = "ToggleTerm" },
  },
  cmd = "ToggleTerm",
  config = function()
    local toggleterm_status_ok, toggleterm = pcall(require, "toggleterm")
    if not toggleterm_status_ok then
      print("toggleterm not found!")
    end
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
