return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-w>", ";", "\\", "v", "g", "f" },
  event = { "VimEnter" },
  cmd = "WhichKey",
  lazy = true,
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 0
    local wk_status_ok, wk = pcall(require, "which-key")
    if not wk_status_ok then
      print("which-key not found!")
    end
    wk.register({
      ["f"] = {
        name = "+Telescope",
      },
      ["<leader>y"] = {
        name = "+Yank",
        mode = { "n", "v" },
      },
      ["\\"] = {
        name = "+LSP",
      },
      ["<leader>m"] = {
        name = "+Miscellaneous",
        mode = { "n", "v" },
      },
      ["s"] = {
        name = "+Search [Flash] ",
        mode = { "n", "v" },
      },
      ["<leader>u"] = {
        name = "+Foldings [UFO] ",
      },
      ["<leader>w"] = {
        name = "+Window Management",
      },
      ["gc"] = {
        name = "+Comment linewise",
      },
      ["gb"] = {
        name = "+Comment blockwise",
      },
      ["gs"] = {
        name = "+Surround",
      },
      [";l"] = {
        name = "+Git",
      },
    })
  end,
}
