return {
  "petertriho/nvim-scrollbar",
  lazy = true,
  event = { "BufRead", "BufNewFile" },
  opts = {
    handlers = {
      gitsigns = true,
      search = true,
    },
  },
  config = function()
    require("scrollbar").setup()
    require("scrollbar.handlers.gitsigns").setup()
  end,
}
