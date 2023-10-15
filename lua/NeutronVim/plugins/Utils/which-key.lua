return {
  "folke/which-key.nvim",
  event = { "BufRead", "BufNewFile" },
  lazy = true,
  config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 0
    local wk_status_ok, wk = pcall(require, "which-key")
    if not wk_status_ok then
      print("which-key not found!")
    end
    wk.register({
      ["<leader>f"] = {
        name = "+Telescope",
      },
      ["<leader>y"] = {
        name = "+Yank",
        mode = { "n", "v" },
      },
      ["<leader>g"] = {
        name = "+LSP",
      },
      ["<leader>m"] = {
        name = "+Miscellaneous",
        mode = { "n", "v" },
      },
      ["<leader>s"] = {
        name = "+Search [Flash] ",
        mode = { "n", "v" },
      },
      ["<leader>u"] = {
        name = "+Foldings [UFO] ",
      },
      ["<leader>w"] = {
        name = "+Window Management",
      },
      ["g"] = {
        name = "+Comment",
      },
      ["<leader>l"] = {
        name = "+Git",
      },
      ["s"] = {
        name = "+Surround",
      },
    })
  end,
}
