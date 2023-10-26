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
  -- UndoTree
  {
    'mbbill/undotree',
    lazy = true,
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndotreeToggle" },
    },
  },
  -- Neovim UI component library
  { "MunifTanjim/nui.nvim", lazy = true },
  -- Popup menu
  { "nvim-lua/popup.nvim",  lazy = true },
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
      { "<C-h>", "<cmd>TmuxNavigateLeft<CR>",  desc = "TmuxNavigateLeft" },
      { "<C-j>", "<cmd>TmuxNavigateDown<CR>",  desc = "TmuxNavigateDown" },
      { "<C-k>", "<cmd>TmuxNavigateUp<CR>",    desc = "TmuxNavigateUp" },
      { "<C-l>", "<cmd>TmuxNavigateRight<CR>", desc = "TmuxNavigateRight" },
    },
  },
  -- UI Component Library
  { "nvim-lua/plenary.nvim",       lazy = true },
  -- Read/Write to files with root access
  {
    "lambdalisue/suda.vim",
    lazy = true,
    keys = {
      { "<leader>mw", "<cmd>SudaWrite<CR>", desc = "SudaWrite" },
      { "<leader>mr", "<cmd>SudaRead<CR>",  desc = "SudaRead" },
    },
  },
  -- Maximize or Minimize an open buffer while working in splits
  {
    "szw/vim-maximizer",
    lazy = true,
    keys = {
      { "<leader>mm", "<cmd>MaximizerToggle<CR>", desc = "MaximizerToggle" },
    },
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
  -- Useless but looks good :D
  {
    "echasnovski/mini.animate",
    event = { "BufReadPost", "BufNewFile" },
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
  -- search/replace in multiple files
  {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
    },
  },
}
