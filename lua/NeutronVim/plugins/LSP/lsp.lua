return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPost",
    lazy = true,
    dependencies = {
      {
        "antosha417/nvim-lsp-file-operations",
        config = true,
        event = "LspAttach",
        lazy = true,
      },
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
        },
        cmd = "Navbuddy",
        lazy = true,
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        event = "InsertEnter",
        lazy = true,
      },
      {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        lazy = true,
      },
      {
        "folke/trouble.nvim",
        cmd = "Trouble",
        lazy = true,
      },
      {
        'filipdutescu/renamer.nvim',
        branch = 'master',
        event = "LspAttach",
        lazy = true,
      },
      {
        'wiliamks/nice-reference.nvim',
        cmd = "NiceReference",
        lazy = true,
      },
      {
        'rmagatti/goto-preview',
        event = "LspAttach",
        lazy = true,
      },
      {
        "lewis6991/hover.nvim",
        event = "LspAttach",
        lazy = true,
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        lazy = true,
      },
      {
        'folke/neodev.nvim',
        event = "LspAttach",
        lazy = true,
      },
      {
        "folke/neoconf.nvim",
        cmd = "Neoconf",
        event = "LspAttach",
        lazy = true,
      }
    },
    config = function()
      require("neodev").setup()
      require("neoconf").setup()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local navbuddy = require("nvim-navbuddy")
      local actions = require("nvim-navbuddy.actions")
      local icons = require("NeutronVim.core.icons")
      require("hover").setup {
        init = function()
          require("hover.providers.lsp")
          require('hover.providers.gh')
          require('hover.providers.gh_user')
          require('hover.providers.jira')
          require('hover.providers.man')
          require('hover.providers.dictionary')
        end,
        preview_opts = {
          border = 'rounded',
        },
        preview_window = true,
        title = true
      }
      require('goto-preview').setup {}
      vim.cmd [[let g:code_action_menu_window_border = 'rounded']]
      ---@diagnostic disable-next-line: missing-fields
      require("renamer").setup({
        title = icons.ui.Electric .. "Rename " .. icons.ui.Electric,
      })
      require("trouble").setup()
      local keymap = vim.keymap.set
      local on_attach = function(client, bufnr)
        local keymap_opts = { noremap = true, silent = true }
        print("LSP Attached to buffer.")
        navbuddy.attach(client, bufnr)
        keymap("n", "gf", "<cmd>NiceReference<CR>", keymap_opts)
        keymap("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", keymap_opts)
        keymap("n", "gr", "<cmd>lua require('renamer').rename()<cr>", keymap_opts)
        keymap("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", keymap_opts)
        keymap("n", "gD", "<cmd>lua require('goto-preview').close_all_win()<cr>", keymap_opts)
        keymap({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, keymap_opts)
        keymap("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)
        keymap("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
        keymap("n", "]d", vim.diagnostic.goto_next, keymap_opts)
        keymap("n", "K", require("hover").hover, keymap_opts)
        keymap("n", " K", require("hover").hover_select, keymap_opts)
        keymap("n", "td", "<cmd>Telescope diagnostics<CR>", keymap_opts)
        keymap("n", "<leader>n", "<cmd>Navbuddy<CR>", keymap_opts)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_command [[augroup Format]]
          vim.api.nvim_command [[autocmd! * <buffer>]]
          vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
          vim.api.nvim_command [[augroup END]]
        end
        require("lsp_signature").on_attach({
          bind = true,
          padding = "",
          handler_opts = {
            border = "rounded",
          }
        }, bufnr)
      end
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local signs = {
        Error = icons.diagnostics.Error,
        Warn = icons.diagnostics.Warning,
        Hint = icons.diagnostics.Hint,
        Info = icons.diagnostics.Info
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded",
          focusable = false,
          relative = "cursor",
        }
      )
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          prefix = icons.ui.CircleSmall,
          source = 'always',
        },
        float = {
          show_header = true,
          enabled = true,
          header = {
            icons.ui.Bug .. " Diagnostics",
          },
          source = 'always',
          border = 'rounded',
          focusable = false,
        },
        update_in_insert = true,
        signs = true,
        underline = true,
        severity_sort = false,
      })
      lspconfig["html"].setup({
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
      navbuddy.setup({
        window = {
          border = "rounded",
          size = "75%",
          right = {
            preview = "always",
          },
          use_default_mappings = false,
          mappings = {
            ["<esc>"] = actions.close(),
            ["q"] = actions.close(),
            ["j"] = actions.next_sibling(),
            ["<Down>"] = actions.next_sibling(),
            ["k"] = actions.previous_sibling(),
            ["<Up>"] = actions.next_sibling(),
            ["h"] = actions.parent(),
            ["<Left>"] = actions.next_sibling(),
            ["l"] = actions.children(),
            ["<Right>"] = actions.next_sibling(),
            ["0"] = actions.root(),
            ["v"] = actions.visual_name(),
            ["V"] = actions.visual_scope(),
            ["y"] = actions.yank_name(),
            ["Y"] = actions.yank_scope(),
            ["i"] = actions.insert_name(),
            ["I"] = actions.insert_scope(),
            ["a"] = actions.append_name(),
            ["A"] = actions.append_scope(),
            ["r"] = actions.rename(),
            ["d"] = actions.delete(),
            ["c"] = actions.comment(),
            ["<enter>"] = actions.select(),
            ["o"] = actions.select(),
            ["J"] = actions.move_down(),
            ["K"] = actions.move_up(),
          },
        },
      })
    end,
  },
}
