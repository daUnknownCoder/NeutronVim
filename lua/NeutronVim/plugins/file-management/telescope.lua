return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    tag = '0.1.2',
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
      "nvim-tree/nvim-web-devicons",
      "xiyaowong/telescope-emoji.nvim",
      'nvim-lua/popup.nvim',
      'nvim-telescope/telescope-media-files.nvim',
      'ibhagwan/fzf-lua',
      {
        "AckslD/nvim-neoclip.lua",
        config = function()
          require('neoclip').setup()
        end,
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = '🔭 ',
          selection_caret = '🔬 ',
          mappings = {
            i = {
              ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("lazygit")
      telescope.load_extension("emoji")
      telescope.load_extension('media_files')
      telescope.load_extension('neoclip')
      local builtin = require('telescope.builtin')
      local keymap = vim.keymap.set
      keymap('n', 'ff', builtin.find_files, { desc = "Find Files Fuzzily" })
      keymap('n', '<C-p>', builtin.git_files, { desc = "Git integration ?" })
      keymap('n', '<leader>po', builtin.oldfiles, { desc = "Find Recent Files Fuzzily" })
      keymap('n', 'co', '<cmd>Telescope colorscheme<CR>', { desc = "Choose Colorschemes" })
      keymap('n', '<Tab>', '<cmd>Telescope buffers<CR>', { desc = "Easily Find and Switch Buffers"})
      keymap('n', 'fg', "<cmd>Telescope live_grep<CR>", { desc = "Find String in Project" })
      keymap('n', '<leader>vh', builtin.help_tags, { desc = "Help!"})
      keymap('n', 'fe', '<cmd>Telescope emoji<CR>', { desc = "Emoji search - copy - paste" })
      keymap('n', 'fm', '<cmd>Telescope media_files<CR>', { desc = "Preview media files" })
    end
  },
}
