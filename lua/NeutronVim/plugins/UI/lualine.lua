return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  opts = function()
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    return {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        disabled_filetypes = { "dashboard", "alpha", "NvimTree", "TelescopePrompt" },
        section_separators = { left = "", right = "" },
        component_separators = { left = " ", right = " " },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = icons.ui.Vim,
            separator = { left = "" },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_b = { { "branch", icon = icons.git.Branch, padding = { left = 2, right = 1 } } },
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
          {
            "filename",
            symbols = { modified = " " .. icons.ui.Pencil, readonly = " " .. icons.ui.Lock, unnamed = " [None] " },
            path = 0,
          },
          {
            function()
              local lint_progress = function()
                local linters = require("lint").get_running()
                if #linters == 0 then
                  return "󰦕 Linting completed"
                end
                return "󱉶 Linting with '" .. table.concat(linters, ", ") .. "' in progress"
              end
              return lint_progress()
            end,
          },
          {
            function()
              return "%="
            end,
          },
          {
            function()
              local status_string = vim.api.nvim_call_function("codeium#GetStatusString", {})
              return status_string
            end,
          },
          {
            function()
              local msg = "No Active Lsp"
              local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
              local clients = vim.lsp.get_active_clients()
              if next(clients) == nil then
                return msg
              end
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  return client.name
                end
              end
              return msg
            end,
            icon = icons.ui.TripleGear .. "LSP:",
            color = { fg = "#ffffff" },
            separator = { left = "" },
          },
        },
        lualine_x = {
          {
            function()
              return "%="
            end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.Add .. " ",
              modified = icons.git.Mod .. " ",
              removed = icons.git.Remove .. " ",
            },
            diff_color = {
              added = { fg = "#50fa7b" },
              modified = { fg = "#f1fa8c" },
              removed = { fg = "#ff5555" },
            },
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = { fg = "#ff9e64" } },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 2 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%X")
            end,
            separator = { right = "" },
          },
        },
      },
      extensions = { "lazy" },
    }
  end,
}
