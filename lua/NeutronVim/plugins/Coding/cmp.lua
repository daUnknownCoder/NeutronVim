return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        lazy = true,
        event = "InsertCharPre",
      },
    },
    opts = {
      history = true,
      enable_autosnippets = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      region_check_events = "CursorMoved",
    },
    config = function(_, opts)
      local luasnip_status_ok, luasnip = pcall(require, "luasnip")
      if not luasnip_status_ok then
        print("Luasnip not found!")
      end
      if opts then
        luasnip.config.setup(opts)
      end
      vim.tbl_map(function(type)
        require("luasnip.loaders.from_" .. type).lazy_load()
      end, { "vscode", "snipmate", "lua" })
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "lua/NeutronVim/snippets/" },
      })
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { "lua/NeutronVim/snippets/" },
      })
    end,
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "saadparwaiz1/cmp_luasnip", lazy = true },
      { "hrsh7th/cmp-buffer", lazy = true },
      { "FelipeLema/cmp-async-path", lazy = true },
      { "hrsh7th/cmp-cmdline", lazy = true },
      { "dmitmel/cmp-cmdline-history", lazy = true },
      { "petertriho/cmp-git", lazy = true },
      { "hrsh7th/cmp-emoji", lazy = true },
      { "hrsh7th/cmp-calc", lazy = true },
      { "ray-x/cmp-treesitter", lazy = true },
      { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
      { "rcarriga/cmp-dap", lazy = true },
      { "lukas-reineke/cmp-rg", lazy = true },
      {
        "Exafunction/codeium.vim",
        lazy = true,
        event = "BufEnter",
      },
      lazy = true,
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if not cmp_status_ok then
        print("CMP not found!")
      end
      local snip_status_ok, luasnip = pcall(require, "luasnip")
      if not snip_status_ok then
        print("Luasnip not found!")
      end
      local git_status_ok, cmp_git = pcall(require, "cmp_git")
      if not git_status_ok then
        print("cmp_git not found!")
      end
      cmp_git.setup()
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      vim.g.codeium_disable_bindings = 1
      vim.keymap.set("i", "<C-a>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-f>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-b>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      local kind_icons = icons.kind
      local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
      end
      local function has_words_before()
        local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local check_back_space = function()
        local col = vim.fn.col(".") - 1
        if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
          return true
        else
          return false
        end
      end
      vim.api.nvim_set_hl(0, "NeutronCmpNormal", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "NeutronCmpBorder", { fg = "lightblue", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "silver", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "lime", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#ff3e00", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable", { bg = "NONE", fg = "salmon" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction", { bg = "NONE", fg = "deepskyblue" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "pink", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "yellow", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "lightgreen", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { bg = "NONE", fg = "orange" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#D4A959", bg = "NONE" })
      vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { bg = "NONE", strikethrough = true, fg = "#808080" })
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NeutronCmpNormal,FloatBorder:NeutronCmpBorder,CursorLine:PmenuSel,Search:CmpItemAbbrMatchFuzzy",
      }
      ---@diagnostic disable-next-line: missing-fields, redundant-parameter
      cmp.setup({
        preselect = cmp.PreselectMode.None,
        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            item.kind = string.format("%s %s", kind_icons[item.kind], item.kind .. " " or "🚀 ")
            item.menu = "➥ "
              .. (
                ({
                  nvim_lsp = "｢LSP｣",
                  gh_issues = "｢Issues｣",
                  nvim_lua = "｢API｣",
                  buffer = "｢Buffer｣",
                  luasnip = "｢Snip｣",
                  treesitter = "｢Treesitter｣",
                  calc = "｢Calc｣",
                  emoji = "｢Emoji｣",
                  rg = "｢rg｣",
                  dap = "｢DAP｣",
                  async_path = "｢Path｣",
                  nvim_lsp_signature_help = "｢Signature｣",
                  cmdline = "｢Cmd｣",
                  cmdline_history = "｢History｣",
                })[entry.source.name] or "🚀 "
              )
            return item
          end,
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
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
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(_)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif check_back_space() then
              feedkey("  ", "i")
            elseif has_words_before() then
              cmp.complete()
            else
              feedkey("  ", "i")
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(_)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif check_back_space() then
              feedkey("  ", "i")
            else
              feedkey("  ", "i")
            end
          end, { "i", "s" }),
        },
        sources = cmp.config.sources({
          { name = "calc", priority_weight = 10 },
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
            max_item_count = 20,
            priority_weight = 1000,
          },
          { name = "luasnip", priority_weight = 750 },
          { name = "treesitter", priority_weight = 750 },
          { name = "nvim_lsp_signature_help", priority_weight = 500 },
          { name = "dap", priority_weight = 110 },
          { name = "git", priority_weight = 110 },
          {
            name = "rg",
            keyword_length = 5,
            max_item_count = 5,
            priority_weight = 60,
            option = {
              additional_arguments = "--smart-case --hidden",
            },
            entry_filter = function(entry)
              return not entry.exact
            end,
          },
          {
            name = "buffer",
            max_item_count = 5,
            priority_weight = 50,
            entry_filter = function(entry)
              return not entry.exact
            end,
          },
          { name = "nvim_lua", priority_weight = 500 },
          { name = "codeium", priority_weight = 500 },
          { name = "async_path", priority_weight = 250 },
          { name = "emoji", priority_weight = 200 },
        }),
      })
      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
          { name = "buffer" },
        }),
      })
      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
          { name = "cmdline_history" },
        },
      })
      ---@diagnostic disable-next-line: missing-fields, undefined-field
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
          { name = "cmdline" },
          { name = "cmdline_history" },
          { name = "buffer" },
        }),
        enabled = function()
          local disabled = {
            IncRename = true,
          }
          local cmd = vim.fn.getcmdline():match("%S+")
          return not disabled[cmd] or cmp.close()
        end,
      })
    end,
  },
}
