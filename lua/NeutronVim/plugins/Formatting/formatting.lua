-- luacheck: ignore 113
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  config = function()
    local conform_status_ok, conform = pcall(require, "conform")
    if not conform_status_ok then
      print("Conform not found!")
    end
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        python = { "ruff", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file" })
  end,
}
