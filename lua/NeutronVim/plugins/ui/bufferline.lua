return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "BufReadPre",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "L", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "H", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<A-l>", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Right" },
    { "<A-h>", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Left" },
  },
  config = function()
    local bufferline_status_ok, bufferline = pcall(require, "bufferline")
    if not bufferline_status_ok then
      print("Bufferline not found!")
    end
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#FFFFFF", italic = true, sp = "#FFFFFF" })
        vim.api.nvim_set_hl(0, "BufferLineNumbersSelected", { fg = "#FFFFFF", bold = true })
        vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#FF6467", italic = true })

        local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
        if not devicons_ok then return end

        local grey_color = "#565f89" 
        local current_ft = vim.bo.filetype
        local is_in_sidebar = (current_ft == "NvimTree" or current_ft == "minifiles" or current_ft == "alpha" or current_ft == "lazy")
        local active_ext = not is_in_sidebar and vim.fn.expand("%:e") or ""

        for _, icon_data in pairs(devicons.get_icons()) do
          local name = icon_data.name
          local hl_inactive = "BufferLineDevIcon" .. name .. "Inactive"
          local hl_active = "BufferLineDevIcon" .. name

          vim.api.nvim_set_hl(0, hl_inactive, { fg = grey_color })
          if is_in_sidebar then
            vim.api.nvim_set_hl(0, hl_active, { fg = grey_color })
          else
            if name == active_ext then
              vim.api.nvim_set_hl(0, hl_active, { fg = icon_data.color })
            else
              local native_color = vim.api.nvim_get_hl(0, { name = "DevIcon" .. name })
              if icon_data.color == native_color.fg then
                vim.api.nvim_set_hl(0, hl_active, { fg = icon_data.color })
              else
                vim.api.nvim_set_hl(0, hl_active, { fg = grey_color })
              end
            end
          end
        end
        
        vim.cmd("redrawtabline")
      end,
    })
    vim.cmd("doautocmd ColorScheme")

    vim.opt.termguicolors = true

    bufferline.setup({
      options = {
        separator_style = "slant",
        close_command = "bp|sp|bn|bd! %d",
        right_mouse_command = "bp|sp|bn|bd! %d",
        left_mouse_command = "buffer %d",
        buffer_close_icon = icons.ui.Close,
        modified_icon = icons.ui.Circle,
        close_icon = icons.ui.Close,
        show_close_icon = false,
        custom_filter = function(buf_number, buf_numbers)
          if not vim.api.nvim_buf_is_valid(buf_number) or not vim.bo[buf_number].buflisted then
            return false
          end
          local tabpage = vim.api.nvim_get_current_tabpage()
          local win_list = vim.api.nvim_tabpage_list_wins(tabpage)
          local displayed_buffers = {}
          for _, win in ipairs(win_list) do
            local buf = vim.api.nvim_win_get_buf(win)
            displayed_buffers[buf] = true
          end
          if displayed_buffers[buf_number] then
            return true
          end
          return true
        end,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          if context.buffer:current() then
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and ""
              or e == "warning" and "" or e == "info" and "" or "󰌶"
              s = s .. n .. sym
            end
          else
            s = ""
          end
          return s
        end,
        -- diagnostics_indicator = function(_, _, diag)
        --   local ret = (diag.error and icons.diagnostics.Error .. " " .. diag.error .. " " or "")
        --   .. (diag.warning and icons.diagnostics.Warning .. " " .. diag.warning or "")
        --   return vim.trim(ret)
        -- end,
        offsets = {
          {
            filetype = "NvimTree",
            text = icons.documents.Folder .. "Nvim Tree",
            highlight = "Directory",
            text_align = "center",
            separator = icons.ui.PowerlineRightRound
          }
        },
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon or "" .. " ", hl
        end,
        show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
        always_show_bufferline = true,
        buffer_close_icon = icons.ui.Close,
        close_icon = icons.ui.Close,
        modified_icon = icons.git.Mod,
        left_trunc_marker = "«",
        right_trunc_marker = "»",
        show_buffer_icons = true,
        numbers = function(opts)
          return string.format("[%s]", opts.ordinal)
        end,
        max_name_length = 25,
        -- style_preset = {
        --   require("bufferline").style_preset.no_italic,
        --   require("bufferline").style_preset.no_bold,
        -- },
        name_formatter = function(buf)
          local name = buf.name
          if name == "[No Name]" then
            return "[Unnamed]"
          else
            return name
          end
        end,
        custom_areas = {
          left = function()
            local left_side = {}
            table.insert(left_side, { text = "    ", fg = "#95c561" })
            return left_side
          end,
          right = function()
            local right_side = {}
            local cached_size = "0.0 B"
            local last_file = ""
            local function format_file_size(file)
              local file = vim.fn.expand("%:p")
              if file == "" then return "Unsaved" end
              if file == last_file then return cached_size end -- Return cached size instantly without disk reading
              
              last_file = file
              local size = vim.fn.getfsize(file)
              if size <= 0 then 
                cached_size = "0.0 B"
                return cached_size
              end
              
              local suffixes = { " B", " KB", " MB", " GB" }
              local i = 1
              while size > 1024 and i < #suffixes do
                size = size / 1024
                i = i + 1
              end
              cached_size = string.format("%.1f%s", size, suffixes[i])
              return cached_size
            end

            local file = vim.fn.expand("%:p")
            if string.len(file) == 0 then
              table.insert(right_side, { text = "", fg = "orange" })
            else
              table.insert(right_side, { text = icons.ui.PowerlineLeftRound, fg = "#3b4261" })
              table.insert(right_side, { text = format_file_size(file), fg = "#A684FF", bg = "#3b4261" })
              table.insert(right_side, { text = icons.ui.PowerlineRightRound, fg = "#3b4261" })
            end

            return right_side
          end,
        },
        custom_filter = function(buf_number, _)
          if not vim.api.nvim_buf_is_valid(buf_number) or not vim.bo[buf_number].buflisted then
            return false
          end
          local tabpage = vim.api.nvim_get_current_tabpage()
          local win_list = vim.api.nvim_tabpage_list_wins(tabpage)
          local displayed_buffers = {}
          for _, win in ipairs(win_list) do
            displayed_buffers[vim.api.nvim_win_get_buf(win)] = true
          end
          return displayed_buffers[buf_number] or true
        end,
        highlights = {
          buffer_selected = {
            bold = false,
            italic = true,
            fg = "orange",
          },
          tab_selected = {
            bold = true,
            italic = true,
          },
          fill = {
            bold = false,
            italic = true,
            fg = "orange",
          }
        },
      },
    })
  end
}
