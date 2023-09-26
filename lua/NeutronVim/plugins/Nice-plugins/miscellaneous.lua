return {
  -- Asynchronous highlight of HEX colors
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        user_default_options = {
          css = true,
        }
      })
    end,
    lazy = true,
  },
  -- Very useless but a good stress buster
  {
    'eandrju/cellular-automaton.nvim',
    lazy = true,
    keys = {
      { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>" },
    },
  },
  -- TMUX type navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = true,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>" },
    }
  },
  -- UI Component Library
  { "nvim-lua/plenary.nvim", event = "VeryLazy", lazy = true },
  -- Read/Write to files with root access
  {
    "lambdalisue/suda.vim",
    lazy = true,
    keys = {
      { "<leader>wr", "<cmd>SudaWrite<CR>" },
      { "<leader>re", "<cmd>SudaRead<CR>" },
    }
  },
  -- Generate dummy text
  {
    "derektata/lorem.nvim",
    lazy = true,
    config = function()
      local lorem = require("lorem")
      lorem.setup({
        sentenceLength = "mixedShort",
        comma = 1,
      })
    end,
    keys = {
      { "<leader>ld", "<cmd>LoremIpsum<CR>" },
    }
  },
  -- Replace vim.ui.[input/attach]
  {
    "stevearc/dressing.nvim",
    event = "BufReadPost",
    lazy = true,
    opts = {
      select = { backend = { "telescope", "builtin" } },
    },
    config = function(_, opts)
      require("dressing").setup(opts)
    end,
  },
  -- Maximize or Minimize an open buffer while working in splits
  {
    "szw/vim-maximizer",
    lazy = true,
    keys = {
      { "<leader>sm", "<cmd>MaximizerToggle<CR>" },
    },
  },
  -- Quick [un/c]ommenting using 'gcc'
  {
    "numToStr/Comment.nvim",
    lazy = true,
    config = true,
    keys = {
      { "gcc", "<cmd>CommentToggle<CR>" },
    }
  },
  -- Autopairing brackets and inverted commas
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    lazy = true,
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  -- Illuminating equivalent words in current buffer under the cursor
  {
    "RRethy/vim-illuminate",
    event = "LspAttach",
    lazy = true,
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
      vim.keymap.set("n", "<a-p>", function()
        require("illuminate").goto_next_reference()
      end)
      vim.keymap.set("n", "<a-n>", function()
        require("illuminate").goto_prev_reference()
      end)
    end,
  },
  -- Surrounding brackets in nvim
  {
    'echasnovski/mini.surround',
    event = "BufReadPost",
    lazy = true,
    version = '*',
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = 'aa',
          delete = 'ad',
          highlight = 'ah',
          replace = 'ar',
          update_n_lines = 'an',
        }
      })
    end
  },
  -- Useless but looks good :D
  {
    "echasnovski/mini.animate",
    event = "BufReadPost",
    lazy = true,
    opts = function()
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require("mini.animate")
      return {
        resize = {
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
          subscroll = animate.gen_subscroll.equal({
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          }),
        },
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    lazy = true,
    config = function()
      local icons = require("NeutronVim.core.icons")
      require("fidget").setup({
        text = {
          spinner = "dots",
          done = icons.ui.Tick,
        },
        timer = {
          spinner_rate = 150,
          fidget_decay = 1000,
          task_decay = 1000,
        },
        window = {
          blend = 0,
          border = "rounded",
        },
        fmt = {
          fidget = function(fidget_name, spinner)
            return string.format("%s %s", spinner, fidget_name)
          end,
          task = function(task_name, message, percentage)
            return string.format(
              "%s%s [%s]",
              message,
              percentage and string.format(" (%s%%)", percentage) or "",
              task_name
            )
          end,
        },
      })
    end
  },
  -- nvim-web-devicons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- Markdown files editing preview
  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    keys = {
      { "<leader>md", "<cmd>MarkdownPreviewToggle<CR>" },
    },
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes =
      { "markdown" }
    end,
    ft = { "markdown" },
  },
}
