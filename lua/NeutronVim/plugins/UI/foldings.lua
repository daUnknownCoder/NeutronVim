-- luacheck: ignore 112 and 113
return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  dependencies = "kevinhwang91/promise-async",
  config = function()
    local ufo_status_ok, ufo = pcall(require, "ufo")
    if not ufo_status_ok then
      print("ufo not found!")
    end

    vim.o.foldcolumn = "5"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:►]]
    vim.keymap.set("n", "<leader>qa", ufo.openAllFolds)
    vim.keymap.set("n", "<leader>q", ufo.closeAllFolds)
    vim.keymap.set("n", " k", ufo.peekFoldedLinesUnderCursor)
    ufo.setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end,
}
