return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  dependencies = {
    { "kdheepak/lazygit.nvim", event = "VeryLazy", lazy = true },
  },
  config = function()
    local icons = require("NeutronVim.core.icons")
    require('gitsigns').setup {
      signs = {
        add          = { text = icons.ui.Electric },
        change       = { text = icons.ui.Edge },
        delete       = { text = icons.ui.Trash },
        topdelete    = { text = icons.ui.Top },
        changedelete = { text = icons.ui.Close },
        untracked    = { text = icons.ui.Pencil },
      },
      signcolumn = true,
      numhl      = true,
      linehl     = false,
      word_diff  = false,
      watch_gitdir = {
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = ' <author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    }
  end,
}
