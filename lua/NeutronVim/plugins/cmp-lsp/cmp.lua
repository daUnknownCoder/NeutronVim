return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      if opts then require("luasnip").config.setup(opts) end
      vim.tbl_map(function(type) require("luasnip.loaders.from_" .. type).lazy_load() end, { "vscode", "snipmate", "lua" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
    },
    event = "InsertEnter",
    opts = function()
      local cmp = require "cmp"
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      local lspkind = require("lspkind")
      lspkind.init({
        mode = "symbol_text",
        symbol_map = {
          Array = " ",
          Boolean = " ",
          Class = "ﴯ",
          Color = "",
          Constant = "",
          Constructor = "",
          Copilot = " ",
          Enum = "",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = "",
          Folder = " ",
          Function = "",
          Interface = " ",
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
          Reference = " ",
          Snippet = "",
          String = " ",
          Struct = " ",
          Text = "󰉿",
          TypeParameter = " ",
          Unit = "",
          Value = "",
          Variable = "󰀫",
        }
      })
      if not snip_status_ok then return end
      vim.api.nvim_set_hl(0, "NeutronCmpNormal", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpBorder", { fg = "lightblue", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpCursorLine", { fg = "gold", bg = "NONE", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "gold", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "red", bg = "NONE" })
      local border_opts = {
        border = { "●", "─", "●", "│", "●", "─", "●", "│" },
        winhighlight = "Normal:NeutronCmpNormal,FloatBorder:NeutronCmpBorder,CursorLine:Special,Search:CmpItemAbbrMatchFuzzy",
      }
      local function has_words_before()
        local line, col = (table.unpack)(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
      end
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = lspkind.presets.default[vim_item.kind]
            vim_item.menu = "➥ " .. (({
              nvim_lsp = "[LSP]",
              spell = "[Spell]",
              buffer = "[Text]",
              luasnip = "[Snip]",
              treesitter = "[Treesitter]",
              calc = "[Calc]",
              path = "[Path]",
              nvim_lsp_signature_help = "[Signature]",
              cmdline = "[Cmd]",
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
        matching = {
          disallow_fuzzy_matching = false,
          disallow_fullfuzzy_matching = false,
          disallow_partial_fuzzy_matching = false,
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
          { name = 'nvim_lsp_signature_help', priority = 500 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
          { name = 'calc', priority = 100 },
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
        },
      })
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
        })
      })
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' },
        }
      })
    end,
  },
}
