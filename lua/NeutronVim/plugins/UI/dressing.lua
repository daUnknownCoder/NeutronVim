return {
  "stevearc/dressing.nvim",
  lazy = true,
  opts = {
    select = { backend = { "telescope", "builtin" } },
  },
  config = function(_, opts)
    local status_ok, dressing = pcall(require, "dressing")
    if not status_ok then
      print("dressing not found!")
    end
    dressing.setup(opts, {
      input = {
        get_config = function()
          if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
            return { enabled = false }
          end
        end,
      },
    })
  end,
}
