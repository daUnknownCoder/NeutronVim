return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      lazy = true,
      event = "InsertCharPre",
    }
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
    region_check_events = "CursorMoved",
  },
  config = function(_, opts)
    if opts then require("luasnip").config.setup(opts) end
    vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
  end,
  lazy = true,
  event = "InsertCharPre",
}
