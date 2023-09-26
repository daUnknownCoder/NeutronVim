return {
  "utilyre/barbecue.nvim",
  events = "LspAttach",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    local barbecue = require("barbecue")

    vim.opt.updatetime = 500

    barbecue.setup({
      create_autocmd = false,
    })

    vim.api.nvim_create_autocmd({
      "WinScrolled",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufModifiedSet",
    },
    {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end
}
