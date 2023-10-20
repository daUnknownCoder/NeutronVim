return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  lazy = true,
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format({ lsp_fallback = true, async = false })
      end,
      desc = "Format file",
    },
  },
  config = function()
    local conform_status_ok, conform = pcall(require, "conform")
    if not conform_status_ok then
      print("Conform not found!")
    end
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier", "prettierd" },
        css = { "prettier", "prettierd" },
        html = { "prettier", "prettierd" },
        json = { "prettier", "prettierd" },
        yaml = { "prettier", "prettierd" },
        markdown = { "prettier", "prettierd" },
        lua = { "stylua" },
        python = { "ruff", "black" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      },
    })
    local slow_format_filetypes = { "markdown" }
    require("conform").setup({
      format_on_save = function(bufnr)
        if slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 200, lsp_fallback = true }, on_format
      end,

      format_after_save = function(bufnr)
        if not slow_format_filetypes[vim.bo[bufnr].filetype] then
          return
        end
        return { lsp_fallback = true }
      end,
    })
  end,
}
