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
        "dgagn/diagflow.nvim",
        lazy = true,
        event = "LspAttach",
        opts = {
          format = function(diagnostic)
            return "[LSP] " .. diagnostic.message
          end,
        },
      },
      {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        event = "LspAttach",
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
      local saga_status_ok, saga = pcall(require, "lspsaga")
      if not saga_status_ok then
        print("lspsaga not found!")
      end
      local hover_status_ok, hover = pcall(require, "hover")
      if not hover_status_ok then
        print("hover not found!")
      end
      local renamer_status_ok, renamer = pcall(require, "renamer")
      if not renamer_status_ok then
        print("renamer not found!")
      end
      saga.setup({
        border = "rounded",
        outline = {
          layout = "float",
        },
        lightbulb = {
          enable = false,
        },
      })
      require("lspsaga.symbol.winbar").get_bar()
      hover.setup({
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
      renamer.setup({
        title = icons.ui.Electric .. "Rename " .. icons.ui.Electric,
      })
      local keymap = vim.keymap.set
      -- luacheck: ignore 212
      local on_attach = function(client, bufnr)
        local keyopts = { noremap = true, silent = true }
        print("LSP Attached to buffer.")
        keymap("n", "go", "<cmd>Lspsaga outline<CR>", keyopts)
        keymap("n", "gf", "<cmd>Lspsaga finder ref+def+imp+tyd<CR>", keyopts)
        keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", keyopts)
        keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", keyopts)
        keymap({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, keyopts)
        keymap("n", "td", "<cmd>Telescope diagnostics<CR>", keyopts)
        require("lsp_signature").on_attach({
          bind = true,
          debug = true,
          hint_enable = true,
          padding = " ",
          handler_opts = {
            border = "rounded",
          },
        }, bufnr)
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
      require("lsp_lines").setup()
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
        update_in_insert = true,
        signs = true,
        underline = true,
        severity_sort = false,
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
