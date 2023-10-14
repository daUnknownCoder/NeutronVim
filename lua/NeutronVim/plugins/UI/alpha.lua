return {
  {
    "goolord/alpha-nvim",
    cmd = "Alpha",
    event = { "VimEnter" },
    lazy = true,
    opts = function()
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      local dashboard_status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
      if not dashboard_status_ok then
        print("alpha.dashboard not found!")
      end
      local logo = [[
       ███╗   ██╗███████╗██╗   ██╗████████╗██████╗  ██████╗ ███╗   ██╗
       ████╗  ██║██╔════╝██║   ██║╚══██╔══╝██╔══██╗██╔═══██╗████╗  ██║
       ██╔██╗ ██║█████╗  ██║   ██║   ██║   ██████╔╝██║   ██║██╔██╗ ██║
       ██║╚██╗██║██╔══╝  ██║   ██║   ██║   ██╔══██╗██║   ██║██║╚██╗██║
       ██║ ╚████║███████╗╚██████╔╝   ██║   ██║  ██║╚██████╔╝██║ ╚████║
       ╚═╝  ╚═══╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                          ██╗   ██╗██╗███╗   ███╗
                          ██║   ██║██║████╗ ████║
                          ██║   ██║██║██╔████╔██║
                          ╚██╗ ██╔╝██║██║╚██╔╝██║
                           ╚████╔╝ ██║██║ ╚═╝ ██║
                            ╚═══╝  ╚═╝╚═╝     ╚═╝]]
      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", icons.ui.Rocket .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", icons.ui.Project .. " File Manager [Nvim-Tree]", ":NvimTreeFindFileToggle <CR>"),
        dashboard.button("N", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", icons.ui.OldFiles .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", icons.kind.Text .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("l", icons.ui.Sleep .. " Lazy", ":Lazy<CR>"),
        dashboard.button("L", icons.git.Branch .. "  LazyGit", ":LazyGit<CR>"),
        dashboard.button("q", icons.ui.SignIn .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
      if not icons_ok then
        print("Unable to import icons!")
      end
      local alpha_status_ok, alpha = pcall(require, "alpha")
      if not alpha_status_ok then
        print("Alpha not found!")
      end
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      alpha.setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "NeutronVim ha"
            .. icons.ui.Sleep
            .. " loaded "
            .. stats.count
            .. " plugins in "
            .. icons.ui.Electric
            .. ms
            .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
