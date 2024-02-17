return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = true,
    event = { "BufEnter" },
    version = false,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not treesitter_status_ok then
        print("treesitter not found!")
      end
      ---@diagnostic disable-next-line: missing-fields
      treesitter.setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "diff",
          "html",
          "hyprlang",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "toml",
          "rust",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
      vim.filetype.add({
        pattern = { [".*/hyprland%.conf"] = "hyprlang" },
      })
    end,
  },
  {
    "nvim-treesitter/playground",
    keys = {
      { "<leader>mp", "<cmd>TSPlaygroundToggle<CR>", desc = "Toggle Playground" },
    },
    cmd = "TSPlaygroundToggle",
    lazy = true,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not treesitter_status_ok then
        print("treesitter not found!")
      end
      treesitter.setup({
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
            },
          },
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
        },
      })
    end,
  },
}
