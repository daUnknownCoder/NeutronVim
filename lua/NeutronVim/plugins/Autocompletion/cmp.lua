return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "FelipeLema/cmp-async-path", lazy = true },
      { "hrsh7th/cmp-emoji", lazy = true },
      { "ray-x/cmp-treesitter", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
      { 'Exafunction/codeium.vim', lazy = true },
      { "echasnovski/mini.pairs", version = "*", lazy = true },
      lazy = true
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local snip_status_ok, luasnip = pcall(require, "NeutronVim.plugins.Autocompletion.snippets")
      local icons = require('NeutronVim.core.icons')
      local kind_icons = icons.kind
      local set = vim.keymap.set
      require("mini.pairs").setup()
      if not snip_status_ok then return end
      vim.api.nvim_set_hl(0, "NeutronCmpNormal", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpBorder", { fg = "lightblue", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpCursorLine", { fg = "gold", bg = "NONE", italic = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "lime", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ff3e00", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "pink", bg = "NONE" })
      local border_opts = {
        border = { "●", "─", "●", "│", "●", "─", "●", "│" },
        winhighlight = "Normal:NeutronCmpNormal,FloatBorder:NeutronCmpBorder,CursorLine:NeutronCmpCursorLine,Search:CmpItemAbbrMatchFuzzy",
      }
      set( 'i', '<C-a>', function () return vim.fn['codeium#Accept']() end, { expr = true } )
      set( 'i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true } )
      set( 'i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true } )
      set( 'i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true } )
      ---@diagnostic disable-next-line: missing-fields, redundant-parameter
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item.kind = string.format("%s %s", kind_icons[item.kind], item.kind .. " ")
            item.menu = "➥ " .. (({
              nvim_lsp = "｢LSP｣",
              buffer = "｢Buffer｣",
              luasnip = "｢Snip｣",
              treesitter = "｢Treesitter｣",
              calc = "｢Calc｣",
              emoji = "｢Emoji｣",
              async_path = "｢Path｣",
              nvim_lsp_signature_help = "｢Signature｣",
              cmdline = "｢Cmd｣",
            })[entry.source.name] or "🚀 ")
            return item
          end,
        },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        duplicates = {
          nvim_lsp = 1,
          luasnip = 1,
          cmp_tabnine = 1,
          buffer = 1,
          path = 1,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        ---@diagnostic disable-next-line: missing-fields
        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = false,
          disallow_partial_matching = false,
        },
        mapping = {
          ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
          ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
          ["<CR>"] = cmp.mapping.confirm { select = false },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources {
          {
            name = "nvim_lsp",
            entry_filter = function(entry, context)
              local kind = entry:get_kind()
              local line = context.cursor_line
              local col = context.cursor.col
              local char_before_cursor = string.sub(line, col - 1, col)
              if char_before_cursor == "." then
                if kind == 2 or kind == 5 then
                  return true
                else
                  return false
                end
              elseif string.match(line, "^%s*%w*$") then
                if kind == 2 or kind == 5 then
                  return true
                else
                  return false
                end
              end
              return true
            end,
            priority = 1000,
          },
          { name = "luasnip", priority = 750 },
          { name = "treesitter", priority = 750 },
          { name = 'nvim_lsp_signature_help', priority = 500 },
          { name = "buffer", priority = 500 },
          { name = "nvim_lua", priority = 500 },
          { name = "async_path", priority = 250 },
          { name = "emoji", priority = 200 },
        }
      })
      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'buffer' },
          })
      })
      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
          })
      })

      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end,
  },
}
