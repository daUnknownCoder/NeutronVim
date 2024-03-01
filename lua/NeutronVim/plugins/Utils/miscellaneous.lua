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
    "mbbill/undotree",
    lazy = true,
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "UndotreeToggle" },
    },
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
    "echasnovski/mini.cursorword",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    opts = {
      delay = 500,
    },
    config = function(_, opts)
      local status_ok, curword = pcall(require, "mini.cursorword")
      if not status_ok then
        print("cursorword not found!")
      end
      curword.setup(opts)
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
  -- Yuck File Syntaxing
  {
    "elkowar/yuck.vim",
    dependencies = { "gpanders/nvim-parinfer" },
    lazy = true,
    filetype = "yuck",
  },
  -- Beautiful CodeSnippet Viewing
  {
    "mistricky/codesnap.nvim",
    build = "make",
    lazy = true,
    cmd = "CodeSnapPreviewOn",
    config = function()
      local home_dir = os.getenv("HOME") -- Get the home directory
      local bufnr = vim.fn.bufnr("%")

      -- Get the full path of the current file
      local current_file_path = vim.api.nvim_buf_get_name(bufnr)
      local relative_file_path = current_file_path:gsub(home_dir, "~") -- Replace home directory with ~

      -- Split the path into directory components
      local components = {}
      for component in relative_file_path:gmatch("[^/]+") do
        table.insert(components, component)
      end

      -- Check if the length of the path exceeds 50 characters
      local path_length = #relative_file_path
      local max_length = 50
      if path_length > max_length then
        -- Truncate directory components except for the last one
        local truncated_path = ""
        for i, component in ipairs(components) do
          local max_component_length = component:sub(1, 1) == "." and 2 or 1 -- Set max_length based on whether directory starts with '.'
          if i == #components then
            truncated_path = truncated_path .. "/" .. component
          else
            truncated_path = truncated_path .. "/" .. component:sub(1, max_component_length)
          end
        end
        relative_file_path = truncated_path:sub(2) -- Remove leading '/'
      end

      -- Set up the watermark
      require("codesnap").setup({
        mac_window_bar = true,
        opacity = true,
        watermark = relative_file_path,
      })
    end,
  },
}
