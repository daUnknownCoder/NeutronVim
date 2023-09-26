return {
  "rcarriga/nvim-notify",
  event = "BufReadPost",
  lazy = true,
  config = function()
    vim.opt.termguicolors = true
    vim.notify = require("notify")
    local notify = require("notify")
    local icons = require("NeutronVim.core.icons")

    ---@diagnostic disable-next-line: missing-fields
    notify.setup({
      minimum_width = 50,
      background_colour = "#1d2021",
      render = "default",
      stages = "fade",
      timeout = 2000,
      fps = 30,
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
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.handlers["window/showMessage"] = function(method, params)
      vim.notify(method.message, severity[params.type])
    end
  end,
}
