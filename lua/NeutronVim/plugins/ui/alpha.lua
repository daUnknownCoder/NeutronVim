return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
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
                            ╚═══╝  ╚═╝╚═╝     ╚═╝                     
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>", { silent = true } ),
        dashboard.button("n", " " .. " File Manager [Nvim-Tree]", ":NvimTreeFindFileToggle <CR>", { silent = true } ),
        dashboard.button("N", " " .. " New file", ":ene <BAR> startinsert <CR>", { silent = true } ),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>", { silent = true } ),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>", { silent = true } ),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>", { silent = true } ),
        dashboard.button("q", " " .. " Quit", ":qa<CR>", { silent = true } ),
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
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "NeutronVim ha..󰒲 ... loaded " .. stats.count .. " plugins in ⚡" .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
