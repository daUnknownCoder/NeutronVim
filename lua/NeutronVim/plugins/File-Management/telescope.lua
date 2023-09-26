return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
    lazy = true,
		dependencies = {
			{ "xiyaowong/telescope-emoji.nvim", event = "VeryLazy", lazy = true },
			{ 'nvim-lua/popup.nvim', event = "VeryLazy", lazy = true },
			{
				"AckslD/nvim-neoclip.lua",
				event = "VeryLazy",
        lazy = true,
			},
		},
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local icons = require("NeutronVim.core.icons")

      require('neoclip').setup()
      telescope.setup({
        defaults = {
          prompt_prefix = icons.ui.Telescope,
          selection_caret = icons.ui.Plug,
        },
      })
      telescope.load_extension("emoji")
      telescope.load_extension('neoclip')
      local builtin = require('telescope.builtin')
      local keymap = vim.keymap.set
      keymap('n', 'ff', builtin.find_files, { desc = "Find Files Fuzzily" })
      keymap('n', 'fp', builtin.git_files, { desc = "Git integration ?" })
      keymap('n', '<leader>po', builtin.oldfiles, { desc = "Find Recent Files Fuzzily" })
      keymap('n', 'co', '<cmd>Telescope colorscheme<CR>', { desc = "Choose Colorschemes" })
      keymap('n', '<Tab>', '<cmd>Telescope buffers<CR>', { desc = "Easily Find and Switch Buffers"})
      keymap('n', 'fg', "<cmd>Telescope live_grep<CR>", { desc = "Find String in Project" })
      keymap('n', '<leader>vh', builtin.help_tags, { desc = "Help!"})
      keymap('n', 'fe', '<cmd>Telescope emoji<CR>', { desc = "Emoji search - copy - paste" })
      keymap('n', 'fp', '<cmd>Telescope neoclip<CR>', { desc = "Yank Helper" })
    end
	},
}
