return {
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    keys = {
      { "\\a", "<cmd>CodeActionMenu<CR>", desc = "CodeActionMenu" },
    },
    lazy = true,
    config = function()
      vim.cmd([[let g:code_action_menu_window_border = 'rounded']])
    end,
  },
}
