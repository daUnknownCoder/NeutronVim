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
local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
if not icons_ok then
  print("Unable to import icons!")
end

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
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
