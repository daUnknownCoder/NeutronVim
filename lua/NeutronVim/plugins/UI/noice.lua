return {
  "folke/noice.nvim",
  event = "VeryLazy",
  lazy = true,
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
      },
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
      bottom_search = true,
    },
    routes = {
      {
        filter = {
          event = "notify",
          min_height = 10,
        },
        view = "split",
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "%d+L, %d+B" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
          },
        },
        view = "mini",
      },
    },
    cmdline = {
      format = {
        cmdline = { pattern = "^:", icon = "󰞷", lang = "vim" },
      },
    },
    views = {
      mini = {
        win_options = {
          winblend = 0,
        },
      },
    },
  },
}
