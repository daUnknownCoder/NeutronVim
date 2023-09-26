return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = "NvimTreeFindFileToggle",
    lazy = true,
    config = function()
      local nvimtree = require("nvim-tree")
      local icons = require("NeutronVim.core.icons")
      vim.opt.termguicolors = true

      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.8

      nvimtree.setup({
        filters = { custom = { '*.tmp', "*.git" } },
        update_cwd = true,
        view = {
          relativenumber = true,
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
        renderer = {
          indent_markers = {
            enable = true,
            inline_arrows = true,
            icons = {
              corner = icons.ui.Corner,
              edge = icons.ui.Edge,
              item = icons.ui.Item,
              bottom = icons.ui.Bottom,
              none = icons.ui.None,
            },
          },
          highlight_modified = "all",
          icons = {
            glyphs = {
              folder = {
                arrow_closed = icons.ui.ArrowClosed,
                arrow_open = icons.ui.ArrowOpen,
              },
            },
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = icons.ui.Arrow,
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
          },
        },
        modified = {
          enable = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
        },
        diagnostics = {
          enable = true,
          show_on_open_dirs = true,
          icons = {
            hint = icons.diagnostics.Hint,
            info = icons.diagnostics.Info,
            warning = icons.diagnostics.Warning,
            error = icons.diagnostics.Error,
          },
        },
      })
      vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeFindFileToggle<CR>')
    end
  },
}
