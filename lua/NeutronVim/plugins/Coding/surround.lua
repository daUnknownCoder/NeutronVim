return {
  "echasnovski/mini.surround",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  version = "*",
  config = function()
    local status_ok, surround = pcall(require, "mini.surround")
    if not status_ok then
      print("mini.surround not found!")
    end
    surround.setup({
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    })
  end,
}
