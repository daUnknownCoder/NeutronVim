return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "antosha417/nvim-lsp-file-operations",
        config = true,
        event = "LspAttach"
      },
      {
        "hrsh7th/cmp-nvim-lsp",
        event = "LspAttach"
      },
      {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
        event = "LspAttach",
      },
      {
        "folke/trouble.nvim",
        event = "LspAttach",
      },
      {
        'filipdutescu/renamer.nvim',
        branch = 'master',
      },
      {
        'wiliamks/nice-reference.nvim',
        event = "LspAttach",
      },
      {
        'rmagatti/goto-preview',
        event = "LspAttach",
      },
      {
        "lewis6991/hover.nvim",
        event = "LspAttach",
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
      },
      {
        'ray-x/navigator.lua',
        dependencies = {
          { 'ray-x/guihua.lua', build = 'cd lua/fzy && make', event = "LspAttach" },
        },
        event = "LspAttach",
      },
      {
        'folke/neodev.nvim',
        event = "VeryLazy",
      },
      {
        "folke/neoconf.nvim",
        event = "VeryLazy",
      }
    },
    config = function()
      require("neodev").setup()
      require("neoconf").setup()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local icons = require("NeutronVim.core.icons")
      local M = {}
      M.icons = {
        Array = " ",
        Boolean = " ",
        Class = "ﴯ",
        Color = "",
        Constant = "",
        Constructor = ' ',
        Copilot = " ",
        Enum = "",
        EnumMember = " ",
        Event = " ",
        Field = ' ',
        File = "",
        Folder = " ",
        Function = "",
        Interface = ' ',
        Key = " ",
        Keyword = "",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = "ﰠ",
        Reference = ' ',
        Snippet = ' ',
        String = " ",
        Struct = ' ',
        Text = ' ',
        TypeParameter = " ",
        Unit = "",
        Value = "",
        Variable = "󰀫",
      }
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
      local buffer_mappings = vim.api.nvim_buf_set_keymap
      local keymap = vim.keymap.set
      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(client, bufnr)
        local keymap_opts = { noremap = true, silent = true }
        print("LSP Attached to buffer.")
        keymap("n", "gf", "<cmd>NiceReference<CR>", keymap_opts)
        buffer_mappings(0, "n", "<leader>ca", "<cmd>CodeActionMenu<CR>", keymap_opts)
        buffer_mappings(0, "n", "gr", "<cmd>lua require('renamer').rename()<cr>", keymap_opts)
        buffer_mappings(0, "n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", keymap_opts)
        buffer_mappings(0, "n", "gD", "<cmd>lua require('goto-preview').close_all_win()<cr>", keymap_opts)
        keymap({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, keymap_opts)
        keymap("n", "<leader>d", vim.diagnostic.open_float, keymap_opts)
        keymap("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
        keymap("n", "]d", vim.diagnostic.goto_next, keymap_opts)
        keymap("n", "K", require("hover").hover, keymap_opts)
        keymap("n", " K", require("hover").hover_select, keymap_opts)
        keymap("n", "td", "<cmd>Telescope diagnostics<CR>", keymap_opts)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_command [[augroup Format]]
          vim.api.nvim_command [[autocmd! * <buffer>]]
          vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
          vim.api.nvim_command [[augroup END]]
        end
        if client.resolved_capabilities.document_highlight then
          vim.cmd [[ hi! LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow ]]
          vim.cmd [[ hi! LspReferenceText cterm=bold ctermbg=red guibg=LightYellow ]]
          vim.cmd [[hi! LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow ]]
          vim.api.nvim_create_augroup('lsp_document_highlight', {
            clear = false
          })
          vim.api.nvim_clear_autocmds({
            buffer = bufnr,
            group = 'lsp_document_highlight',
          })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            group = 'lsp_document_highlight',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
        vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
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
      function M.setup()
        local kinds = vim.lsp.protocol.CompletionItemKind
        for i, kind in ipairs(kinds) do
          kinds[i] = M.icons[kind] or kind
        end
      end
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
      })

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
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
      ---@diagnostic disable-next-line: unused-local
      function PrintDiagnostics(opts, bufnr, line_nr, client_id)
        opts = opts or { ['lnum'] = line_nr }
        bufnr = bufnr or 0
        line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

        local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
        if vim.tbl_isempty(line_diagnostics) then return end

        local diagnostic_message = ""
        for i, diagnostic in ipairs(line_diagnostics) do
          diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
          print(diagnostic_message)
          if i ~= #line_diagnostics then
            diagnostic_message = diagnostic_message .. "\n"
          end
        end
        vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
      end

      vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]
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
    end,
  },
}
