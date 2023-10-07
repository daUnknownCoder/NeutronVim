return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    version = false,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "vimdoc",
          "javascript",
          "c",
          "lua",
          "python",
          "query",
          "json",
          "vim",
          "regex",
          "markdown_inline",
          "bash",
          "toml",
          "html",
          "css"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = false,
            node_decremental = "<bs>"
          }
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
              ["ao"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
            }
          }
        }
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
    "nvim-treesitter/nvim-treesitter-textobjects", lazy = true, event = { "BufReadPost", "BufNewFile" },
    config = function()
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
              ["ao"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },
              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
              ["am"] = { query = "@function.outer", desc = "Select outer part of a function" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a function" },
              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            }
          }
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]i"] = "@conditional.outer",
            ["]l"] = "@loop.outer",
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "fold", desc = "Next fold" },
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]C"] = "@class.outer",
            ["]I"] = "@conditional.outer",
            ["]L"] = "@loop.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[i"] = "@conditional.outer",
            ["[l"] = "@loop.outer",
            ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
            ["[z"] = { query = "@fold", query_group = "fold", desc = "Previous fold" },
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[C"] = "@class.outer",
            ["[I"] = "@conditional.outer",
            ["[L"] = "@loop.outer",
          },
        }
      }
    end
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
