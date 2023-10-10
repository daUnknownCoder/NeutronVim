return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    lazy = true,
    keys = {
      { "ff", "<cmd>Telescope find_files<CR>", desc = "Find Files Fuzzily" },
      { "fg", "<cmd>Telescope live_grep<CR>", desc = "Find Text" },
      { "fb", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "fo", "<cmd>Telescope oldfiles<CR>", desc = "Find Recent Files Fuzzily" },
      { "fh", "<cmd>Telescope help_tags<CR>", desc = "Find Help" },
      { "co", "<cmd>Telescope colorscheme<CR>", desc = "Choose Colorschemes" },
      { "fe", "<cmd>Telescope emoji<CR>", desc = "Emoji search - copy - paste" },
    },
    dependencies = {
      { "xiyaowong/telescope-emoji.nvim", lazy = true, cmd = "Telescope emoji" },
    },
    config = function()
      local telescope = require("telescope")
      local icons = require("NeutronVim.core.icons")

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
