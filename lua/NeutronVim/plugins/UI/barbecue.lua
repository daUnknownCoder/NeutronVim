return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  lazy = true,
  event = "LspAttach",
  config = function()
    local barbecue_status_ok, barbecue = pcall(require, "barbecue")
    if not barbecue_status_ok then
      print("barbecue not found!")
    end
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    barbecue.setup({
      create_autocmd = false,
      show_modified = true,
      kinds = icons.kind,
      symbols = {
        separator = icons.ui.ArrowClosed,
      },
    })
    vim.api.nvim_create_autocmd({
      "WinScrolled",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end
}
