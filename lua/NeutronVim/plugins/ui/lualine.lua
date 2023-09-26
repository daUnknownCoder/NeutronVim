return {
  'nvim-lualine/lualine.nvim',
  event = "BufWinEnter",
  lazy = true,
  opts = function()
    local icons = require("NeutronVim.core.icons")
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "nvim-tree" } },
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
              Error = " ",
              Warn = " ",
              Hint = " ",
              Info = " ",
            },
          },
          {
            "diff",
            symbols = {
              added = " ",
              modified = " ",
              removed = " ",
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", symbols = { modified = " ✎ ", readonly = "  ", unnamed = " [None] " }, path = 0 },
        },
        lualine_x = {
          {
            ---@diagnostic disable-next-line: undefined-field
            require("noice").api.status.command.get,
            ---@diagnostic disable-next-line: undefined-field
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            ---@diagnostic disable-next-line: undefined-field
            require("noice").api.status.mode.get,
            ---@diagnostic disable-next-line: undefined-field
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
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
      extensions = { "nvim-tree", "lazy" },
    }
  end
}
