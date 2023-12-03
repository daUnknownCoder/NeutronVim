return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  config = function()
    local none_ls_status_ok, none_ls = pcall(require, "null-ls")
    if not none_ls_status_ok then
      print("none-ls not found!")
    end
    local formatting = none_ls.builtins.formatting
    local diagnostics = none_ls.builtins.diagnostics
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    none_ls.setup({
      sources = {
        formatting.black,
        formatting.isort,
        formatting.prettierd,
        formatting.stylua,
        diagnostics.eslint_d,
        diagnostics.ruff,
        diagnostics.luacheck,
      },
      -- Format on save
      on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                filter = function(client)
                  return client.name == "none-LS"
                end,
                bufnr = bufnr,
              })
            end,
          })
        end
      end,
    })
  end,
}
