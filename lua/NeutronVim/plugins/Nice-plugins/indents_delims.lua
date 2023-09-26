return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    lazy = true,
    config = function(_, opts)
      local indents = require("indent_blankline")

      vim.opt.termguicolors = true
      vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent2 guifg=darkyellow gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent3 guifg=lime gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent4 guifg=orange gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
      vim.cmd [[highlight IndentBlanklineIndent6 guifg=violet gui=nocombine]]

      vim.opt.list = true
      vim.opt.listchars:append "space: "
      vim.opt.listchars:append "eol: "
      vim.cmd [[let g:indent_blankline_char = '│']]

      indents.setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      }
    end,
    opts = {
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "Trouble",
        "NvimTree",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = "BufReadPost",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          ---@diagnostic disable-next-line: inject-field
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
}
