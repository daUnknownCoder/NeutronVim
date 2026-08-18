return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFileToggle" },
    keys = {
      { "<C-n>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTree" },
    },
    config = function()
      local nvimtree_status_ok, nvimtree = pcall(require, "nvim-tree")
      if not nvimtree_status_ok then
        print("NvimTree not found!")
      end
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end

      vim.opt.termguicolors = true

      local HEIGHT_RATIO = 0.8
      local WIDTH_RATIO = 0.8

      nvimtree.setup({
        filters = { custom = { "*.tmp", "*.git" } },
        disable_netrw = false,
        hijack_netrw = false,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
        hijack_cursor = true,
        update_cwd = true,
        view = {
          relativenumber = true,
          float = {
            enable = false,
          --   open_win_config = function()
          --     local screen_w = vim.opt.columns:get()
          --     local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
          --     local window_w = screen_w * WIDTH_RATIO
          --     local window_h = screen_h * HEIGHT_RATIO
          --     local window_w_int = math.floor(window_w)
          --     local window_h_int = math.floor(window_h)
          --     local center_x = (screen_w - window_w) / 2
          --     local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          --     return {
          --       border = "rounded",
          --       relative = "editor",
          --       row = center_y,
          --       col = center_x,
          --       width = window_w_int,
          --       height = window_h_int,
          --     }
            -- end,
          },
          -- width = function()
          --   return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          -- end,
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
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    keys = {
      {
        "<leader>q",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Open Mini Files (Current File)",
      },
      {
        "<leader>Q",
        function()
          require("mini.files").open(vim.uv.cwd(), true)
        end,
        desc = "Open Mini Files (Workspace Root)",
      },
    },
    event = "BufEnter",
    config = function()
      local minifiles = require("mini.files")

      minifiles.setup({
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 30,
          width_preview = 45,
        },
        options = {
          use_as_default_explorer = true,
        },
      })

      local current_target = vim.fn.expand("%:p")
      if vim.fn.isdirectory(current_target) == 1 then
        local buf = vim.api.nvim_get_current_buf()
        minifiles.open(current_target, false)
        vim.api.nvim_buf_delete(buf, { force = true })
      end
      local show_dotfiles = true
      local filter_show = function(fs_entry) return true end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
      end
      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id
          vim.api.nvim_win_set_config(win_id, { border = "rounded" })
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id

          vim.keymap.set("n", "<Right>", function()
            require("mini.files").go_in({})
          end, { buffer = buf_id, desc = "Go In / Open File" })
          vim.keymap.set("n", "<CR>", function()
            require("mini.files").go_in({})
          end, { buffer = buf_id, desc = "Go In / Open File" })
          vim.keymap.set("n", "<Left>", function()
            require("mini.files").go_out()
          end, { buffer = buf_id, desc = "Go Out / Parent Folder" })
          vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
        end,
      })
    end,
  },
}
