return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>mn",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  event = "VeryLazy",
  opts = {
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  lazy = true,
  config = function()
    vim.opt.termguicolors = true
    local notify_status_ok, notify = pcall(require, "notify")
    if not notify_status_ok then
      print("notify not found!")
    end
    vim.notify = require("notify")
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end

    ---@diagnostic disable-next-line: missing-fields
    notify.setup({
      minimum_width = 50,
      background_colour = "#1d2021",
      render = "default",
      stages = "fade_in_slide_out",
      timeout = 2000,
      fps = 60,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      icons = {
        DEBUG = icons.ui.Bug,
        ERROR = icons.diagnostics.Error,
        INFO = icons.diagnostics.Information,
        TRACE = icons.ui.Bookmark,
        WARN = icons.diagnostics.Warning,
      },
    })

    local severity = {
      "error",
      "warn",
      "info",
    }
    vim.lsp.handlers["window/showMessage"] = function(_, result, ctx)
      if not result or not result.message then return end
      
      local levels = { "error", "warn", "info", "log" }
      local log_level = levels[result.type] or "info"
      local client_name = vim.lsp.get_client_by_id(ctx.client_id).name or "LSP"

      vim.notify(result.message, log_level, {
        title = client_name,
      })
    end
  end,
}
