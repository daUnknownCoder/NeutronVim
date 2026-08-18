return {
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- Must be false for your active theme so it loads on boot
    priority = 1000, -- Ensures it loads before all other plugins
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, c)
        hl.Normal = { fg = "Cyan", bg = c.bg } 
        hl.NormalNC = { fg = "Cyan", bg = c.bg }
        hl.EndOfBuffer = { fg = c.fg_gutter, bg = c.bg }

        -- Status bar color fixes
        hl.StatusLine = { italic = true, fg = c.fg, bg = c.bg_statusline }
        hl.StatusLineNC = { italic = true, fg = c.fg_sidebar, bg = c.bg_statusline }

        -- Syntax overrides
        hl.Keyword = { italic = true, fg = "#F08753" }
        hl.Visual = { fg = "#EA3535" }
        hl.Comment = { italic = true, underline = true, fg = "#a1afaf" }
        hl.Number = { italic = true, fg = "#f7768e" }
        hl.String = { italic = true, fg = "#69ff00" }
        hl["@variable"] = { fg = "#7fe1aa" }
        hl["@field"] = { italic = true, fg = "#2ac3de" }
        hl["@property"] = { italic = true, fg = "lightgreen" }
        hl.Special = { italic = true, fg = "gold" }
        hl.Function = { italic = true, fg = "orange" }
        hl.NvimTreeIndentMarker = { fg = "#61afef" }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      
      vim.opt.background = "dark"
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },

  {
    "navarasu/onedark.nvim",
    lazy = true,
    cmd = "ColorschemeOnedark", -- Prevents execution until explicitly called
    config = function()
      require("onedark").setup({ style = "darker" })
    end,
  },

  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
}
