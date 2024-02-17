return {
  "nvimdev/lspsaga.nvim",
  lazy = true,
  event = "LspAttach",
  config = function()
    local saga_status_ok, saga = pcall(require, "lspsaga")
    if not saga_status_ok then
      print("lspsaga not found!")
    end
    saga.setup({
      border = "rounded",
      outline = {
        layout = "float",
      },
      lightbulb = {
        enable = true,
      },
      symbol_in_winbar = {
        enable = false,
      },
    })
  end,
}
