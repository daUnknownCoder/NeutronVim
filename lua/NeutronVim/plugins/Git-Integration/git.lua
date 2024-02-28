return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    { ";j", "<cmd>lua require('gitsigns').next_hunk()<CR>", desc = "Next Hunk" },
    { ";k", "<cmd>lua require('gitsigns').prev_hunk()<CR>", desc = "Prev Hunk" },
    { ";p", "<cmd>lua require('gitsigns').preview_hunk()<CR>", desc = "Preview Hunk" },
    { ";s", "<cmd>lua require('gitsigns').stage_hunk()<CR>", desc = "Stage Hunk" },
    {
      ";s",
      "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>",
      desc = "Stage Hunk",
      mode = "v",
    },
    { ";u", "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", desc = "Undo Stage Hunk" },
    { ";r", "<cmd>lua require('gitsigns').reset_hunk()<CR>", desc = "Reset Hunk" },
    {
      ";r",
      "<cmd>lua require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })<CR>",
      mode = "v",
      desc = "Reset Hunk",
    },
  },
  ft = { "gitcommit", "diff" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
      callback = function()
        vim.fn.system("git -C " .. '"' .. vim.fn.expand("%:p:h") .. '"' .. " rev-parse")
        if vim.v.shell_error == 0 then
          vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
          vim.schedule(function()
            require("lazy").load({ plugins = { "gitsigns.nvim" } })
          end)
        end
      end,
    })
  end,
  config = function()
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    local gitsigns_status_ok, gitsigns = pcall(require, "gitsigns")
    if not gitsigns_status_ok then
      print("Gitsigns not found!")
    end
    gitsigns.setup({
      signs = {
        add = { text = icons.kind.Event },
        change = { text = icons.ui.Pencil },
        delete = { text = icons.ui.Trash },
        topdelete = { text = icons.ui.Top },
        changedelete = { text = icons.ui.Close },
        untracked = { text = icons.ui.NewFile },
      },
      signcolumn = true,
      numhl = true,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = " <author>, <author_time:%R | %x> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })
  end,
}
