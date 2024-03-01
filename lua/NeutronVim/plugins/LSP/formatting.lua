return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  lazy = true,
  keys = {
    {
      "<leader>mf",
      "<cmd>lua require('conform').format({lsp_fallback = true,async = false, timeout_ms = 500})<CR>",
      mode = { "n", "v" },
      desc = "Format",
    },
  },

  config = function()
    local conform_status_ok, conform = pcall(require, "conform")
    if not conform_status_ok then
      print("conform not found!")
    end
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        html = { "prettierd" },
        css = { "prettierd" },
        svelte = { "prettierd" },
        lua = { "stylua" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        rust = { "rustfmt" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        cmake = { "cmake_format" },
        ["*"] = { "codespell" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        bash = { "shfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = true,
      },
    })
  end,
}
