return {
  "rcarriga/nvim-notify",
  event = "BufReadPre",
  config = function()
    vim.opt.termguicolors = true
    vim.notify = require("notify")
    local notify = require("notify")

    notify.setup({
      minimum_width = 50,
      background_colour = "#1d2021",
      render = "default",
      stages = "fade",
      timeout = 2000,
      fps = 60,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    })

    local severity = {
      "error",
      "warn",
      "info",
    }
    vim.lsp.handlers["window/showMessage"] = function(method, params)
      vim.notify(method.message, severity[params.type])
    end
  end,
}
