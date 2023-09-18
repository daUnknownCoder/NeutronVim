return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = "BufEnter",
  dependencies = {
    "luckasRanarison/tree-sitter-hypr",
    { 
      'nvim-treesitter/playground',
      config = function()
        vim.keymap.set("n", "<leader>pl", "<cmd>TSPlaygroundToggle<CR>")
      end,
    },
  },
  config = function()
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
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.hypr = {
      install_info = {
        url = "https://github.com/luckasRanarison/tree-sitter-hypr",
        files = { "src/parser.c" },
        branch = "master",
      },
      filetype = "hypr",
    }
  end,
}
