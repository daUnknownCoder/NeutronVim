return {
  'kevinhwang91/nvim-ufo',
  event = "VeryLazy",
  dependencies = 'kevinhwang91/promise-async',
  config = function()
    local ufo = require("ufo")

    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:►]]
    vim.keymap.set('n', '<leader>qa', ufo.openAllFolds)
    vim.keymap.set('n', '<leader>q', ufo.closeAllFolds)
    ufo.setup({
      provider_selector = function()
        return { 'treesitter', 'indent' }
      end
    })
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }
    -- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
    -- for _, ls in ipairs(language_servers) do
    --   require('lspconfig')[ls].setup({
    --     capabilities = capabilities
    --     -- you can add other fields for setting up lsp server in this table
    --   })
    -- end
  end,
}
