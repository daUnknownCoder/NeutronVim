return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    lazy = true,
    dependencies = {
      { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
      { "windwp/nvim-ts-autotag", event = "VeryLazy" },
      {
        'nvim-treesitter/playground',
        keys = {
          { "<leader>pl", "<cmd>TSPlaygroundToggle<CR>" },
        },
        event = "VeryLazy",
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vimdoc", "javascript", "c", "lua", "python", "query" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        },
        autotag = {
          enable = true
        },
      }
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "luckasRanarison/tree-sitter-hypr",
    config = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      ---@diagnostic disable-next-line: inject-field
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
    end,
    lazy = true,
    ft = "hypr",
  }
}
