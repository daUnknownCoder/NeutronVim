return {
  {
    "filipdutescu/renamer.nvim",
    branch = "master",
    keys = {
      { "\\r", "<cmd>lua require('renamer').rename()<cr>", desc = "Renamer" },
    },
    lazy = true,
    config = function()
      local renamer_status_ok, renamer = pcall(require, "renamer")
      if not renamer_status_ok then
        print("renamer not found!")
      end
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      ---@diagnostic disable-next-line: missing-fields
      renamer.setup({
        title = icons.ui.Electric .. "Rename " .. icons.ui.Electric,
      })
    end,
  },
}
