return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    { "antosha417/nvim-lsp-file-operations", config = true },
    "kkharji/lspsaga.nvim",
    { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
    {
      'weilbith/nvim-code-action-menu',
      cmd = 'CodeActionMenu',
    },
    {
      'VidocqH/lsp-lens.nvim'
    },
    {
      "chrisgrieser/nvim-dr-lsp"
    },
    {
      "folke/trouble.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
    },
  },
  config = function()
    local idk = vim.keymap
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local lspsaga = require("lspsaga")
    lspsaga.setup({
      rename_prompt_prefix = '⚡',
    })
    require("trouble").setup()
    require'lsp-lens'.setup()
    local buf_map = vim.api.nvim_buf_set_keymap
    local keymap = vim.keymap.set
    local on_attach = function(client, bufnr)
      local opt1 = { noremap = true, silent = true, buffer = bufnr }
      local opt2 = { noremap = true, silent = true }
      print("LSP Attached to buffer.");
      keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opt1)
      buf_map(0, "n", "<leader>ca", "<cmd>CodeActionMenu<CR>", opt2)
      buf_map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", opt2)
      buf_map(0, "n", "gd", "<cmd>Lspsaga preview_definition<cr>", opt2)
      buf_map(0, "n", "gs", "<cmd>Lspsaga signature_help<cr>", opt2)
      keymap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opt2)
      keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt2)
      keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt2)
      keymap("n", "<C-f>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>")
      keymap("n", "<C-b>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>")
      buf_map(0, "n", "K", "<cmd>Lspsaga hover_doc<cr>", opt1)
    end
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = "", Warn = "", Hint = "", Info = "" }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    lspconfig["html"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig["cssls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
          completion = { keywordSnippet = "Disable", },
          diagnostics = {
            globals = { "vim", "describe", "it", "before_each", "after_each" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end
}
