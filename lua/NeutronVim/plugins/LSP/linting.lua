return {
  "daUnknownCoder/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  keys = {
    { "<leader>mt", "<cmd>lua require('lint').try_lint()<cr>", desc = "Lint" },
  },
  config = function()
    local linter_status_ok, lint = pcall(require, "lint")
    if not linter_status_ok then
      print("nvim-lint not found!")
    end
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      lua = { "luacheck" },
      python = { "pylint" },
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
