-- luacheck: ignore vim
return {
  "rcarriga/nvim-notify",
  keys = {
    -- luacheck: ignore vim
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  lazy = true,
  config = function()
    vim.opt.termguicolors = true
    vim.notify = require("notify")
    local notify_status_ok, notify = pcall(require, "notify")
    if not notify_status_ok then
      print("notify not found!")
    end
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end

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
