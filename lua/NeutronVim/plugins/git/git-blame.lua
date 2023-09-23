return {
  'f-person/git-blame.nvim',
  config = function()
    require('gitblame').setup {
      enabled = true,
      vim.cmd [[let g:gitblame_date_format = '%r']]
    }
  end
}
