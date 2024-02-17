return {
  "gorbit99/codewindow.nvim",
  config = function()
    local codewindow_status_ok, codewindow = pcall(require, "codewindow")
    if not codewindow_status_ok then
      print("codewindow not found!")
    end
    codewindow.setup({
      auto_enable = true,
      width_multiplier = 5,
    })
  end,
}
