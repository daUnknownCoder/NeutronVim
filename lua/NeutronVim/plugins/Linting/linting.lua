-- luacheck: ignore vim
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile" },
  lazy = true,
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      python = { "mypy" },
      lua = { "luacheck" },
    }
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "BufNewFile", "TextChanged" }, {
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
