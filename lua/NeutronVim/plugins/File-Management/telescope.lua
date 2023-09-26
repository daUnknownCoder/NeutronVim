return {
	{
		"nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    lazy = true,
		dependencies = {
			{ "xiyaowong/telescope-emoji.nvim", lazy = true, cmd = "Telescope emoji" },
			{ "AckslD/nvim-neoclip.lua", lazy = true, cmd = "Telescope neoclip" },
		},
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local icons = require("NeutronVim.core.icons")

      require('neoclip').setup()
      telescope.setup({
        defaults = {
          entry_prefix = icons.ui.ArrowDownandRight,
          selection_caret = icons.ui.Plug,
          prompt_prefix = icons.ui.Telescope,
          initial_mode = "insert",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.5,
              results_width = 0.5,
            },
            vertical = {
              mirror = false,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = { "node_modules" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
        },
      })
      telescope.load_extension("emoji")
      telescope.load_extension('neoclip')
      local keymap = vim.keymap.set
      keymap('n', 'ff', "<cmd>Telescope find_files<CR>", { desc = "Find Files Fuzzily" })
      keymap('n', 'fp', "<cmd>Telescope git_files<CR>", { desc = "Git integration ?" })
      keymap('n', '<leader>po', "<cmd>Telescope oldfiles<CR>", { desc = "Find Recent Files Fuzzily" })
      keymap('n', 'co', '<cmd>Telescope colorscheme<CR>', { desc = "Choose Colorschemes" })
      keymap('n', '<Tab>', '<cmd>Telescope buffers<CR>', { desc = "Easily Find and Switch Buffers"})
      keymap('n', 'fg', "<cmd>Telescope live_grep<CR>", { desc = "Find String in Project" })
      keymap('n', 'fe', '<cmd>Telescope emoji<CR>', { desc = "Emoji search - copy - paste" })
      keymap('n', 'fp', '<cmd>Telescope neoclip<CR>', { desc = "Yank Helper" })
    end
	},
}
