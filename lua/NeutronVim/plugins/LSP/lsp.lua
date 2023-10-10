-- luacheck: ignore vim
return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    lazy = true,
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        lazy = true,
      },
      {
        "weilbith/nvim-code-action-menu",
        cmd = "CodeActionMenu",
        keys = {
          { "ca", "<cmd>CodeActionMenu<CR>", desc = "CodeActionMenu" },
        },
        lazy = true,
      },
      {
        "filipdutescu/renamer.nvim",
        branch = "master",
        keys = {
          { "gr", "<cmd>lua require('renamer').rename()<cr>", desc = "Renamer" },
        },
        lazy = true,
      },
      {
        "lewis6991/hover.nvim",
        lazy = true,
        keys = {
          { "K", "<cmd>lua require('hover').hover()<CR>", desc = "Hover" },
          { " K", "<cmd>lua require('hover').hover_select()<CR>", desc = "Hover Select" },
        },
      },
      {
        "ray-x/lsp_signature.nvim",
        lazy = true,
      },
      {
        "nvimdev/lspsaga.nvim",
        lazy = true,
        event = "LspAttach",
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local icons = require("NeutronVim.core.icons")
      require("lspsaga").setup({
        border = "rounded",
        outline = {
          layout = "float",
        },
      })
      require("lspsaga.symbol.winbar").get_bar()
      require("hover").setup({
        init = function()
          require("hover.providers.lsp")
          require("hover.providers.gh")
          require("hover.providers.gh_user")
          require("hover.providers.jira")
          require("hover.providers.man")
          require("hover.providers.dictionary")
        end,
        preview_opts = {
          border = "rounded",
        },
        preview_window = true,
        title = true,
      })
      vim.cmd([[let g:code_action_menu_window_border = 'rounded']])
      ---@diagnostic disable-next-line: missing-fields
      require("renamer").setup({
        title = icons.ui.Electric .. "Rename " .. icons.ui.Electric,
      })
      local keymap = vim.keymap.set
      -- luacheck: ignore 212
      local on_attach = function(client, bufnr)
        local keymap_opts = { noremap = true, silent = true }
        print("LSP Attached to buffer.")
        keymap("n", "go", "<cmd>Lspsaga outline<CR>", keymap_opts)
        keymap("n", "gf", "<cmd>Lspsaga finder ref+def+imp+tyd<CR>", keymap_opts)
        keymap({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, keymap_opts)
        keymap("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)
        keymap("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
        keymap("n", "]d", vim.diagnostic.goto_next, keymap_opts)
        keymap("n", "td", "<cmd>Telescope diagnostics<CR>", keymap_opts)
        require("lsp_signature").on_attach({
          bind = true,
          padding = "",
          handler_opts = {
            border = "rounded",
          },
        }, bufnr)
      end
      vim.cmd([[
      set signcolumn=yes
      autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
             ]])
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
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        focusable = false,
        relative = "cursor",
      })
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          prefix = icons.ui.CircleSmall,
          source = "always",
        },
        float = {
          show_header = true,
          enabled = true,
          header = {
            icons.ui.Bug .. " Diagnostics",
          },
          source = "always",
          border = "rounded",
          focusable = false,
        },
        update_in_insert = true,
        signs = true,
        underline = true,
        severity_sort = false,
      })
      lspconfig["rust_analyzer"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
        filetypes = { "rust" },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      })
      lspconfig["html"].setup({
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
      lspconfig["gopls"].setup({
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
