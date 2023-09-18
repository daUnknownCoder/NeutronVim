return {
  'nvim-telescope/telescope.nvim',
  event = "VeryLazy",
  tag = '0.1.2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
          }
        }
      }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("lazygit")
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', 'ff', builtin.find_files, { desc = "Find Files Fuzzily" })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git integration ?" })
    vim.keymap.set('n', '<leader>po', builtin.oldfiles, { desc = "Find Recent Files Fuzzily" })
    vim.keymap.set('n', 'co', '<cmd>Telescope colorscheme<CR>', { desc = "Choose Colorschemes" })
    vim.keymap.set('n', ' b', '<cmd>Telescope buffers<CR>', { desc = "Easily Find and Switch Buffers"})
    vim.keymap.set('n', 'fg', "<cmd>Telescope live_grep<CR>", { desc = "Find String in Project" })
    vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help!"})
  end
}
