return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  config = function()
    local lint_status_ok, lint = pcall(require, "lint")
    if not lint_status_ok then
      print("nvim-lint not found!")
    end
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      python = { "mypy" },
      lua = { "luacheck" },
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufNewFile", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Lint current file" })
  end,
}
