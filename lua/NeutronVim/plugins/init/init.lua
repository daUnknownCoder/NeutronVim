return {
  -- Asynchronous highlight for all color type value [Hex, name, etc]
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
  -- Very useless but a good stress buster
  {
    'eandrju/cellular-automaton.nvim',
    event = "VeryLazy",
  },
  -- TMUX type navigation
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },
  -- Read/Write to files with root access
  {
    "lambdalisue/suda.vim",
    event = "VeryLazy",
  },
  -- Generate dummy text
  {
    "derektata/lorem.nvim",
    event = "VeryLazy",
    config = function()
      local lorem = require("lorem")
      lorem.setup({
        sentenceLength = "mixedShort",
        comma = 1,
      })
    end,
  },
  -- Replace vim.ui.[input/attach]
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      select = { backend = { "telescope", "builtin" } },
    },
    config = function()
      require("dressing").setup()
    end,
  },
  -- Maximize or Minimize an open buffer while working in splits
  {
    "szw/vim-maximizer",
    event = "VeryLazy",
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>" },
    },
  },
  -- Quick [un/c]ommenting using 'gcc'
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  -- Autopairing brackets and inverted commas
  {
    'm4xshen/autoclose.nvim',
    event = "InsertEnter",
    config = function()
      require("autoclose").setup()
    end,
  },
  -- Surrounding brackets in nvim
  {
    "kylechui/nvim-surround",
    event = "BufEnter",
    config = function()
      require("nvim-surround").setup()
    end
  },
}
