return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    return {
      options = {
        theme = "tokyonight",
        globalstatus = true,
        disabled_filetypes = { "dashboard", "alpha", "NvimTree", "minifiles", "TelescopePrompt" },
        section_separators = { left = "", right = "" },
        component_separators = { left = " ", right = " " },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "⌐■_■",
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
              local lint_ok, lint = pcall(require, "lint")
              if not lint_ok then return icons.ui.Error .. "No linter" end
              local linters = lint.get_running()
              if #linters == 0 then
                return "󰦕 Linting completed"
              end
              return "󱉶 Linter: " .. table.concat(linters, ", ")
            end,
            cond = function() return package.loaded["lint"] ~= nil end,
          },
          { function() return "%=" end },
          -- {
          --   function()
          --     local status_string = vim.api.nvim_call_function("codeium#GetStatusString", {})
          --     return status_string
          --   end,
          -- },
          {
            function()
              local buf_ft = vim.bo.filetype
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "No Active Lsp" end
              
              local active_client_name = "LSP"
              for _, client in ipairs(clients) do
                local filetypes = client.config.filetypes
                if filetypes and vim.iter(filetypes):contains(buf_ft) then
                  active_client_name = client.name
                  break
                end
              end

              local progress_msg = vim.lsp.status()
              if progress_msg and progress_msg ~= "" then
                local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                local ms = vim.uv.hrtime() / 1000000
                local frame = math.floor(ms / 120) % #spinners
                local current_spinner = spinners[frame + 1]
                return string.format("%s %s %s", active_client_name, current_spinner, progress_msg)
              end

              return active_client_name
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
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" },
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" },
            on_click = function()
              vim.cmd(":Lazy")
            end,
          },
        },
        lualine_y = {
          {
            function()
              local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
              local words = 0
              for i = 1, #lines do
                for _ in string.gmatch(lines[i], "%S+") do
                  words = words + 1
                end
              end
              local cursor = vim.api.nvim_win_get_cursor(0)
              local cur_line = cursor[1]
              local cur_col = cursor[2] + 1

              return string.format("%d words │ %d:%d", words, cur_line, cur_col)
            end,
            padding = { left = 0, right = 1 },
          },
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
      inactive_sections = {},
      extensions = { "lazy", "nvim-tree" },
    }
  end,
}
