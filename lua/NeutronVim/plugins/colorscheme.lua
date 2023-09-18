return {
  "folke/tokyonight.nvim",
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      transparent = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      }
    })
    function transparent_bg(color) 
      color = color or "tokyonight"
      vim.cmd.colorscheme(color)

      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    end
    transparent_bg()
  end
}
