return {
  "echasnovski/mini.pairs",
  version = "*",
  lazy = true,
  event = "InsertEnter",
  config = function()
    local mini_pairs_status_ok, pairs = pcall(require, "mini.pairs")
    if not mini_pairs_status_ok then
      print("mini.pairs not found!")
    end
    pairs.setup({
      modes = { command = true },
      mappings = {
        ["<"] = { action = "open", pair = "<>", neigh_pattern = "[^\\]." },
        [">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },
      },
    })
  end,
}
