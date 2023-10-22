return {
  "wfxr/minimap.vim",
  lazy = true,
  cmd = { "Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh" },
  config = function()
    vim.cmd([[let g:minimap_width = 20
              let g:minimap_auto_start = 1
              let g:minimap_auto_start_win_enter = 1]])
  end,
}
