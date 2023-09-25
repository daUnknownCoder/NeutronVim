return {
  {
    "folke/noice.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim", event = "VeryLazy" },
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false,
        },
        progress = {
          enabled = false,
        },
        message = {
          enabled = false,
        },
      },
      presets = {
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      routes = {
        {
          filter = {
            event = "notify",
            min_height = 15
          },
          view = 'split'
        },
      },
      cmdline = {
        format = {
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {},
        },
      },
    },
  },
}
