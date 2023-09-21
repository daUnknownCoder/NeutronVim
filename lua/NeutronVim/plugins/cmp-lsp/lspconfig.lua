return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/nvim-cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    "kkharji/lspsaga.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local saga = require("lspsaga")
    saga.setup()
    local map = vim.api.nvim_buf_set_keymap
    local keymap = vim.keymap.set
    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
      keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
      keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
      map(0, "n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", {silent = true, noremap = true})
      map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
      map(0, "n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
      keymap("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
      keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
      keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
      map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
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
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end
}
