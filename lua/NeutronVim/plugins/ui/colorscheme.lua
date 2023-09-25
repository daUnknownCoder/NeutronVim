return {
  "folke/tokyonight.nvim",
  lazy = false,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      vim.cmd [[colorscheme tokyonight-night]]
    })
  end
}
