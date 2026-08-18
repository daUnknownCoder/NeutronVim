return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { enabled = false },
      progress = { enabled = false },
      message = { enabled = false },
      hover = { enabled = false },
    },
    presets = {
      long_message_to_split = true,
      lsp_doc_border = true,
      bottom_search = true,
    },
    messages = {
      enabled = true,
      view = "notify",
      view_error = "notify",
      view_warn = "notify",
      view_history = "messages",
      view_search = "virtualtext",
    },
    routes = {
      {
        filter = { event = "notify", min_height = 10 },
        view = "split",
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = "E490: No fold found" },
            { find = "Already at oldest change" },
            { find = "Already at newest change" },
            { find = "; after #%d+" },
            { find = "; before #%d+" },
            { find = "#%d+ fewer lines" },
            { find = "lsp_signature? handler RPC" },
            { find = "^%s*at process.processTicksAndRejections" },
            { find = "^[/?]." },
            { find = "^:!make" },
            { find = "^%(%d+ of %d+%):" },
            { find = "E211: File .* no longer available" },
          },
        },
        opts = { skip = true },
      },
      { 
        filter = { event = "notify", find = "No code actions available" }, 
        opts = { skip = true } 
      },
      {
        filter = {
          event = "msg_show",
          any = {
            { find = ".*Pattern not found.*$" },
            { find = "%d+L, %d+B" },
            { find = "%d+B written$" },
            { find = "%d+L, %d+B$" },
            { find = "%-%-No lines in buffer%-%-" },
            { find = "^E486: Pattern not found" },
            { find = "^Word .*%.add$" },
            { find = "^%[nvim%-treesitter%]" },
            { find = "'modifiable' is off" },
          },
        },
        opts = { skip = true },
      },
      {
        filter = {
          event = "notify",
          cond = function(msg)
            local title = msg.opts and msg.opts.title or ""
            return title:find("mason") or title:find("treesitter")
          end,
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
        win_options = { winblend = 0 },
      },
      cmdline_popup = {
        position = {
          row = "15%",
          col = "50%",
        },
        size = {
          width = "60%",
          height = "auto",
        },
        border = { style = "single" },
        filter_options = {},
        win_options = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    },
  },
}
