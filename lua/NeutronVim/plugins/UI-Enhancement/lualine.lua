return {
  'nvim-lualine/lualine.nvim',
  event = "VimEnter",
  lazy = true,
  opts = function()
    local icons = require("NeutronVim.core.icons")
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          {
            'branch',
            icon = icons.git.Branch,
            fmt = function(str)
              return str:sub(1, 16)
            end,
          },
        },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              Error = icons.diagnostics.Error .. " ",
              Warn = icons.diagnostics.Warning .. " ",
              Hint = icons.diagnostics.Hint .. " ",
              Info = icons.diagnostics.Info .. " ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", symbols = { modified = " " .. icons.ui.Pencil, readonly = " " .. icons.ui.Lock, unnamed = " [None] " }, path = 0 },
        },
        lualine_x = {
          {
            "diff",
            symbols = {
              added = icons.git.Add .. " ",
              modified = icons.git.Mod .. " ",
              removed = icons.git.Remove .. " ",
            },
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = { fg = "#ff9e64" } },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "lazy" },
    }
  end
}
