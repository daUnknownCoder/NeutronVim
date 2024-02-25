return {
  "kevinhwang91/nvim-ufo",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  keys = {
    { "<leader>uU", "<cmd>lua require('ufo').openAllFolds()<CR>", desc = "Open all folds" },
    { "<leader>uu", "<cmd>lua require('ufo').closeAllFolds()<CR>", desc = "Close all folds" },
    { "<leader>up", "<cmd>lua require('ufo').peekFoldedLinesUnderCursor()<CR>", desc = "Peek fold under cursor" },
  },
  dependencies = {
    { "kevinhwang91/promise-async" },
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
            { text = { "%s" }, click = "v:lua.ScSa" },
            { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
          },
        })
      end,
    },
  },
  config = function()
    local ufo_status_ok, ufo = pcall(require, "ufo")
    if not ufo_status_ok then
      print("ufo not found!")
    end

    vim.opt.signcolumn = "yes"
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:►]]
    ufo.setup({
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    })
  end,
}
