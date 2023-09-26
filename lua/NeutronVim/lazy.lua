local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
local icons = require("NeutronVim.core.icons")

require("lazy").setup({
  -- UI Enhancement
  { import = "NeutronVim.plugins.UI-Enhancement" },

  -- File Managers
  { import = "NeutronVim.plugins.File-Management" },

  -- Autocompletion
  { import = "NeutronVim.plugins.Autocompletion" },

  -- LSP
  { import = "NeutronVim.plugins.LSP" },

  -- Nice Plugins for NeutronVim
  { import = "NeutronVim.plugins.Nice-plugins" },

  -- Terminal
  { import = "NeutronVim.plugins.Terminal" },

  -- Git
  { import = "NeutronVim.plugins.Git-Integration" },
},
  {
    install = {
      colorscheme = { "tokyonight-night" },
    },
    checker = {
      enabled = true,
      notify = false,
    },
    change_detection = {
      notify = true,
    },
    ui = {
      border = "rounded",
      title = " " .. icons.ui.Electric .. "La" .. icons.ui.Sleep .. "y " .. icons.ui.Electric,
    },
  })
