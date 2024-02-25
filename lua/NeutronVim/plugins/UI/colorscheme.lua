return {
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)

      -- Dark
      vim.opt.background = "dark"
      vim.cmd([[autocmd VimEnter * colorscheme tokyonight-night]])
      -- vim.cmd([[autocmd VimEnter * colorscheme tokyonight-storm]])
      -- vim.cmd([[autocmd VimEnter * colorscheme tokyonight-moon]])

      -- Light
      -- vim.opt.background = "light"
      -- vim.cmd([[autocmd VimEnter * colorscheme tokyonight-day]])
    end,
  },
  {
    "navarasu/onedark.nvim",
    event = "VeryLazy",
    lazy = false,
    priority = 1000,
    config = function()
      -- Dark
      vim.opt.background = "dark"
      require("onedark").setup({
        -- style = "dark",
        style = "darker",
        -- style = "cool",
        -- style = "deep",
        -- style = "warm",
        -- style = "warmer",
      })

      -- Light
      -- vim.opt.background = "light"
      -- require("onedark").setup({
      --   style = "light",
      -- })

      -- require("onedark").load()
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    event = "VeryLazy",
    lazy = false,
    priority = 1000,
    config = function()
      -- Dark
      vim.opt.background = "dark"
      -- vim.cmd([[autocmd VimEnter * colorscheme carbonfox]])
      -- vim.cmd([[autocmd VimEnter * colorscheme nightfox]])
      -- vim.cmd([[autocmd VimEnter * colorscheme terafox]])
      -- vim.cmd([[autocmd VimEnter * colorscheme nordfox]])
      -- vim.cmd([[autocmd VimEnter * colorscheme duskfox]])

      -- Light
      -- vim.opt.background = "light"
      -- vim.cmd([[autocmd VimEnter * colorscheme dawnfox]])
      -- vim.cmd([[autocmd VimEnter * colorscheme dayfox]])
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    event = "VeryLazy",
    config = function()
      -- Dark
      vim.opt.background = "dark"
      -- vim.cmd([[autocmd VimEnter * colorscheme catppuccin-frappe]])
      -- vim.cmd([[autocmd VimEnter * colorscheme catppuccin-macchiato]])
      -- vim.cmd([[autocmd VimEnter * colorscheme catppuccin-mocha]])

      -- Light
      -- vim.opt.background = "light"
      -- vim.cmd([[autocmd VimEnter * colorscheme catppuccin-latte]])
    end,
  },
}
