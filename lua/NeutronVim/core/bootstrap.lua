vim.g.mapleader = " "
local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
if not icons_ok then
  print("Unable to import icons!")
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  vim.print("Installing " .. icons.ui.Sleep .. "lazy.nvim & " .. icons.ui.Code .. "plugins")
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

require("lazy").setup({
  -- UI Enhancement
  { import = "NeutronVim.plugins.UI" },

  -- Formatting
  { import = "NeutronVim.plugins.Formatting" },

  -- Linting
  { import = "NeutronVim.plugins.Linting" },

  -- Editing Related
  { import = "NeutronVim.plugins.Editor" },

  -- Coding Related
  { import = "NeutronVim.plugins.Coding" },

  -- LSP
  { import = "NeutronVim.plugins.LSP" },

  -- Utilities for NeutronVim
  { import = "NeutronVim.plugins.Utils" },

  -- Git
  { import = "NeutronVim.plugins.Git-Integration" },

  -- Debugging
  { import = "NeutronVim.plugins.Debugging" },
}, {
  install = {
    colorscheme = { "tokyonight-night" },
  },
  defaults = {
    lazy = true,
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
    ui = {
      icons = {
        ft = "",
      },
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})