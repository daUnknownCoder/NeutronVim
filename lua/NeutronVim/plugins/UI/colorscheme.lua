return {
  "folke/tokyonight.nvim",
  config = function()
    local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")
    if not tokyonight_status_ok then
      print("tokyonight not found!")
    end
    tokyonight.setup({
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      vim.cmd([[colorscheme tokyonight]]),
    })
  end,
}
