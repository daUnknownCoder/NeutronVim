return {
  -- Asynchronous highlight of HEX colors
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      local colorizer_status_ok, colorizer = pcall(require, "colorizer")
      if not colorizer_status_ok then
        print("colorizer not found!")
      end
      colorizer.setup({
        user_default_options = {
          css = true,
        },
      })
    end,
    lazy = true,
  },
  -- Neovim UI component library
  { "MunifTanjim/nui.nvim", lazy = true },
  -- Popup menu
  { "nvim-lua/popup.nvim", lazy = true },
  -- Very useless but a good stress buster
  {
    "eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
      { "<leader>mc", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make It Rain" },
    },
  },
  -- TMUX type navigation
  {
    "christoomey/vim-tmux-navigator",
    lazy = true,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "TmuxNavigateLeft" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>", desc = "TmuxNavigateDown" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>", desc = "TmuxNavigateUp" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "TmuxNavigateRight" },
    },
  },
  -- UI Component Library
  { "nvim-lua/plenary.nvim", lazy = true },
  -- Read/Write to files with root access
  {
    "lambdalisue/suda.vim",
    lazy = true,
    keys = {
      { "<leader>mw", "<cmd>SudaWrite<CR>", desc = "SudaWrite" },
      { "<leader>mr", "<cmd>SudaRead<CR>", desc = "SudaRead" },
    },
  },
  -- Generate dummy text
  {
    "derektata/lorem.nvim",
    lazy = true,
    config = function()
      local lorem_status_ok, lorem = pcall(require, "lorem")
      if not lorem_status_ok then
        print("lorem not found!")
      end
      lorem.setup({
        sentenceLength = "mixedShort",
        comma = 1,
      })
    end,
    keys = {
      { "<leader>ml", "<cmd>LoremIpsum<CR>", desc = "Lorem Ipsum" },
    },
  },
  -- Replace vim.ui.[input/attach]
  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  -- Maximize or Minimize an open buffer while working in splits
  {
    "szw/vim-maximizer",
    lazy = true,
    keys = {
      { "<leader>mt", "<cmd>MaximizerToggle<CR>", desc = "MaximizerToggle" },
    },
  },
  -- Quick [un/c]ommenting using 'gcc'
  {
    "numToStr/Comment.nvim",
    config = true,
    event = { "BufRead", "BufNewFile" },
  },
  -- Illuminating equivalent words in current buffer under the cursor
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    opts = {
      delay = 500,
      large_file_cutoff = 5000,
    },
    config = function(_, opts)
      local status_ok, illuminate = pcall(require, "illuminate")
      if not status_ok then
        print("illuminate not found!")
      end
      illuminate.configure(opts)
    end,
  },
  -- Surrounding brackets in nvim
  {
    "echasnovski/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    version = "*",
    config = function()
      local status_ok, surround = pcall(require, "mini.surround")
      if not status_ok then
        print("mini.surround not found!")
      end
      surround.setup({
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
      })
    end,
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
        -- luacheck: ignore 113
        vim.keymap.set({ "n", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true, desc = "Scroll " .. scroll })
      end

      local animate_status_ok, animate = pcall(require, "mini.animate")
      if not animate_status_ok then
        print("mini.animate not found!")
      end
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
  -- nvim-web-devicons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  -- Markdown files editing preview
  {
    "iamcco/markdown-preview.nvim",
    version = "0.0.10",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<CR>", desc = "MarkdownPreview" },
    },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      local install_path = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
      local file_path = install_path .. "/yarn.lock"

      -- Check if the file exists
      local f = io.open(file_path, "r")
      if f ~= nil then
        io.close(f)
        -- Delete the file
        os.remove(file_path)
      end
      vim.g.mkdp_auto_close = 0
    end,
  },
}
