return {
  {
    "folke/noice.nvim",
    lazy = false,
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
        hover = {
          enabled = false,
        }
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
          cmdline = { pattern = "^:", icon = "󰞷", lang = "vim" },
        },
      },
    },
  },
}
