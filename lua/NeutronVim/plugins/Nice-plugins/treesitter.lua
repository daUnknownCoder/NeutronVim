return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    version = false,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "vimdoc", "javascript", "c", "lua", "python", "query", "json", "vim", "regex", "markdown_inline", "bash", "hypr" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        },
      }
    end,
  },
  {
    'nvim-treesitter/playground',
    keys = {
      { "<leader>pl", "<cmd>TSPlaygroundToggle<CR>" },
    },
    cmd = "TSPlaygroundToggle",
    lazy = true,
  },
  {
    "luckasRanarison/tree-sitter-hypr",
    init = function()
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      ---@diagnostic disable-next-line: inject-field
      parser_config.hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        ft = { "hypr" },
      }
    end,
  }
}
