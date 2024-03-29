return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufEnter", "BufNewFile" },
    lazy = true,
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        event = { "BufReadPost", "BufNewFile" },
        lazy = true,
      },
      {
        "antosha417/nvim-lsp-file-operations",
        event = { "BufReadPost", "BufNewFile" },
        lazy = true,
        config = true,
      },
      {
        "ray-x/lsp_signature.nvim",
        lazy = true,
        event = "InsertEnter",
      },
    },
    config = function()
      local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
      if not lspconfig_status_ok then
        print("lspconfig not found!")
      end
      local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if not cmp_nvim_lsp_status_ok then
        print("cmp_nvim_lsp not found!")
      end
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      local keymap = vim.keymap.set
      -- luacheck: ignore 212
      local on_attach = function(client, bufnr)
        if client then
          keymap(
            "n",
            "\\f",
            "<cmd>Lspsaga finder ref+def+imp+tyd<CR>",
            { noremap = true, silent = true, desc = "LSP Finder [Ref, Def, Imp, Tyd] " }
          )
          keymap(
            "n",
            "[d",
            "<cmd>Lspsaga diagnostic_jump_prev<CR>",
            { noremap = true, silent = true, desc = "Diagnostic Jump Prev" }
          )
          keymap(
            "n",
            "]d",
            "<cmd>Lspsaga diagnostic_jump_next<CR>",
            { noremap = true, silent = true, desc = "Diagnostic Jump Next" }
          )
          require("lsp_signature").on_attach({
            bind = true,
            debug = true,
            floating_window = true,
            floating_window_above_cur_line = true,
            hint_enable = true,
            fix_pos = false,
            -- floating_window_above_first = true,
            log_path = vim.fn.expand("$HOME") .. "/tmp/sig.log",
            padding = " ",
            handler_opts = {
              border = "rounded",
            },
          }, bufnr)
        end
      end
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local signs = {
        Error = icons.diagnostics.Error,
        Warn = icons.diagnostics.Warning,
        Hint = icons.diagnostics.Hint,
        Info = icons.diagnostics.Info,
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = true,
        float = {
          show_header = true,
          enabled = false,
          header = {
            icons.ui.Bug .. " Diagnostics",
          },
          source = "always",
          border = "rounded",
          focusable = false,
        },
        update_in_insert = false,
        signs = true,
        underline = true,
        severity_sort = true,
      })
      lspconfig["rust_analyzer"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = {
          "rustup",
          "run",
          "stable",
          "rust-analyzer",
        },
      })
      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["tsserver"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["eslint"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["cmake"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["bashls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["marksman"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            completion = { keywordSnippet = "Disable" },
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
    end,
  },
}
