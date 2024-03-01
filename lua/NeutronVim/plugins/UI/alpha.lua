return {
  "goolord/alpha-nvim",
  cmd = "Alpha",
  event = { "VimEnter" },
  lazy = false,
  opts = function()
    local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
    if not icons_ok then
      print("Unable to import icons!")
    end
    local dashboard_status_ok, dashboard = pcall(require, "alpha.themes.dashboard")
    if not dashboard_status_ok then
      print("alpha.dashboard not found!")
    end
    dashboard.section.header.val = {
"███╗   ██╗███████╗██╗   ██╗████████╗██████╗  ██████╗ ███╗   ██╗",
"████╗  ██║██╔════╝██║   ██║╚══██╔══╝██╔══██╗██╔═══██╗████╗  ██║",
"██╔██╗ ██║█████╗  ██║   ██║   ██║   ██████╔╝██║   ██║██╔██╗ ██║",
"██║╚██╗██║██╔══╝  ██║   ██║   ██║   ██╔══██╗██║   ██║██║╚██╗██║",
"██║ ╚████║███████╗╚██████╔╝   ██║   ██║  ██║╚██████╔╝██║ ╚████║",
"╚═╝  ╚═══╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝",
      " ",
"                   ██╗   ██╗██╗███╗   ███╗                        ",
"                   ██║   ██║██║████╗ ████║                        ",
"                   ██║   ██║██║██╔████╔██║                        ",
"                   ╚██╗ ██╔╝██║██║╚██╔╝██║                        ",
"                    ╚████╔╝ ██║██║ ╚═╝ ██║                        ",
"                     ╚═══╝  ╚═╝╚═╝     ╚═╝                        ",
    }
    dashboard.section.buttons.val = {
      dashboard.button("f", icons.ui.Rocket .. " Find file", ":Telescope find_files <CR>"),
      dashboard.button("e", icons.ui.GitHub .. " Find edited Git files", ":Telescope git_status <CR>"),
      dashboard.button("n", icons.ui.Project .. " File Manager [Nvim-Tree]", ":NvimTreeFindFileToggle <CR>"),
      dashboard.button("N", icons.ui.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("r", icons.ui.History .. " Recent files", ":Telescope oldfiles <CR>"),
      dashboard.button("g", icons.kind.Text .. " Find text", ":Telescope live_grep <CR>"),
      dashboard.button("l", icons.ui.Sleep .. " Lazy", ":Lazy <CR>"),
      dashboard.button("q", icons.ui.SignIn .. " Quit", ":qa <CR>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.config.layout = {
      { type = "padding", val = vim.fn.max { 1, vim.fn.floor(vim.fn.winheight(0) * 0.08) } },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }
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
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        local version = icons.type.Number
          .. "v"
          .. vim.version().major
          .. "."
          .. vim.version().minor
          .. "."
          .. vim.version().patch
        local plugins = "NeutronVim has loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. icons.ui.Electric
          .. ms
          .. "ms"
        local footer = version .. " -> " .. plugins
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
