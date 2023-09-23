return {
  'f-person/git-blame.nvim',
  config = function()
    require('gitblame').setup {
      enabled = true,
      vim.cmd [[let g:gitblame_date_format = '%r']],
      vim.cmd [[let g:gitblame_message_when_not_committed = "    This ain't committed yet, What are u doin... "]],
    }
  end
}
