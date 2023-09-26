return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        event = "InsertEnter",
      }
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end
      vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
    end,
    event = "InsertEnter",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
      { "hrsh7th/cmp-buffer", event = "InsertEnter" },
      { "hrsh7th/cmp-nvim-lua", event = "InsertEnter" },
      { "octaltree/cmp-look", event = "InsertEnter" },
      { "hrsh7th/cmp-path", event = "InsertEnter" },
      { "hrsh7th/cmp-emoji", event = "InsertEnter" },
      { "ray-x/cmp-treesitter", event = "InsertEnter" },
      { "hrsh7th/cmp-cmdline", event = "InsertEnter" },
      { "hrsh7th/cmp-calc", event = "InsertEnter" },
      { "f3fora/cmp-spell", event = "InsertEnter" },
      { "hrsh7th/cmp-nvim-lsp-signature-help", event = "InsertEnter" },
      {
        'Exafunction/codeium.vim',
        event = "InsertEnter",
      }
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      local icons = require('NeutronVim.core.icons')
      local kind_icons = icons.kind
      local set = vim.keymap.set
      if not snip_status_ok then return end
      vim.api.nvim_set_hl(0, "NeutronCmpNormal", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpBorder", { fg = "lightblue", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpCursorLine", { fg = "gold", bg = "NONE", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "gold", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ff3e00", bg = "NONE" })
      local border_opts = {
        border = { "●", "─", "●", "│", "●", "─", "●", "│" },
        winhighlight = "Normal:NeutronCmpNormal,FloatBorder:NeutronCmpBorder,CursorLine:Special,Search:CmpItemAbbrMatchFuzzy",
      }
      local function has_words_before()
        local line, col = (table.unpack)(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      set( 'i', '<C-a>', function () return vim.fn['codeium#Accept']() end, { expr = true } )
      set( 'i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true } )
      set( 'i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true } )
      set( 'i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true } )
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = "➥ " .. (({
              nvim_lsp = "｢LSP｣",
              spell = "｢Spell｣",
              buffer = "｢Buffer｣",
              luasnip = "｢Snip｣",
              treesitter = "｢Treesitter｣",
              calc = "｢Calc｣",
              nvim_lua = "｢Lua｣",
              look = "｢Look｣",
              emoji = "｢Emoji｣",
              path = "｢Path｣",
              nvim_lsp_signature_help = "｢Signature｣",
              cmdline = "｢Cmd｣",
            })[entry.source.name] or "🚀 ")
            return vim_item
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
            elseif has_words_before() then
              cmp.complete()
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
          { name = "path", priority = 250 },
          { name = "emoji", priority = 200 },
          {
            name = 'spell',
            option = {
              keep_all_entries = false,
              enable_in_context = function()
                return true
              end,
            },
            priority = 100,
          },
          { name = 'calc', priority = 100 },
        },
      })
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
          { name = 'buffer' },
          })
      })
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
          })
      })

      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end,
  },
}
