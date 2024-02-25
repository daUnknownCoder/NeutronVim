return {
  "lewis6991/hover.nvim",
  lazy = true,
  keys = {
    { "\\h", "<cmd>lua require('hover').hover()<CR>", desc = "Hover" },
    { "\\H", "<cmd>lua require('hover').hover_select()<CR>", desc = "Hover Select" },
    { "\\kj", "<cmd>lua require('hover').hover_switch('previous')<CR>", desc = "Hover (Previous Source)" },
    { "\\kk", "<cmd>lua require('hover').hover_switch('next')<CR>", desc = "Hover (Next Source)" },
    { "<MouseMove>", "<cmd>lua require('hover').hover_mouse()<CR>", desc = "Hover (Mouse)" },
  },
  config = function()
    vim.o.mousemoveevent = true
    local hover_status_ok, hover = pcall(require, "hover")
    if not hover_status_ok then
      print("hover not found!")
    end
    hover.setup({
      init = function()
        require("hover.providers.lsp")
        require("hover.providers.gh")
        require("hover.providers.gh_user")
        require("hover.providers.man")
      end,
      preview_opts = {
        border = "rounded",
      },
      preview_window = true,
      title = true,
      mouse_providers = {
        "LSP",
      },
      mouse_delay = 1000,
    })
  end,
}
