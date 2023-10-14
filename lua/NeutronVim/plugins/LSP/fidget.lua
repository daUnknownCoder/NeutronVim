return {
  "j-hui/fidget.nvim",
  tag = "legacy",
  event = "LspAttach",
  config = function()
    local icons = require("NeutronVim.core.icons")
    require("fidget").setup({
      text = {
        spinner = {
          "⣷",
          "⣯",
          "⣟",
          "⡿",
          "⢿",
          "⣻",
          "⣽",
          "⣾",
        },
        done = icons.ui.Electric,
        commenced = icons.ui.CircleSmallEmpty,
        completed = icons.ui.CircleSmall,
      },
      timer = {
        spinner_rate = 100,
        fidget_decay = 1000,
        task_decay = 3000,
      },
      window = {
        relative = "editor",
        blend = 0,
        border = "rounded",
      },
      debug = {
        logging = true,
        strict = true,
      },
    })
  end,
}
