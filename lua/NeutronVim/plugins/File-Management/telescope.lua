return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    lazy = true,
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find Files Fuzzily" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Find Text" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "<leader>fo", "<cmd>Telescope colorscheme<CR>", desc = "Choose Colorschemes" },
      { "<leader>fe", "<cmd>Telescope emoji<CR>", desc = "Emoji search - copy - paste" },
    },
    dependencies = {
      { "xiyaowong/telescope-emoji.nvim", lazy = true, cmd = "Telescope emoji" },
    },
    config = function()
      local telescope_status_ok, telescope = pcall(require, "telescope")
      if not telescope_status_ok then
        print("Telescope not found!")
      end
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      telescope.setup({
        defaults = {
          entry_prefix = icons.ui.ArrowDownandRight,
          selection_caret = icons.ui.Plug,
          prompt_prefix = icons.ui.Telescope,
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.5,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.8,
            preview_cutoff = 120,
          },
        },
      })
      telescope.load_extension("emoji")
    end,
  },
}
