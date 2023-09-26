return {
	{
		"nvim-telescope/telescope.nvim",
		event = "VeryLazy",
    lazy = true,
		dependencies = {
			{ "nvim-lua/plenary.nvim", event = "VeryLazy", lazy = true },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
				event = "VeryLazy",
        lazy = true,
			},
			{ "xiyaowong/telescope-emoji.nvim", event = "VeryLazy", lazy = true },
			{ 'nvim-lua/popup.nvim', event = "VeryLazy", lazy = true },
			{ 'nvim-telescope/telescope-media-files.nvim', event = "VeryLazy", lazy = true },
			{ 'ibhagwan/fzf-lua', event = "VeryLazy", lazy = true },
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
          mappings = {
            i = {
              ["<C-q>"] = function()
                actions.send_selected_to_qflist()
                ---@diagnostic disable-next-line: missing-parameter
                actions.open_qflist()
              end,
            },
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("lazygit")
      telescope.load_extension("emoji")
      telescope.load_extension('media_files')
      telescope.load_extension('neoclip')
      telescope.load_extension("lazygit")
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
