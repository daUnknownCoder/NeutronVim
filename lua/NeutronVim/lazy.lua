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

require("lazy").setup({
  -- UI Enhancement
  { import = "NeutronVim.plugins.ui" },

  -- File Managers
  { import = "NeutronVim.plugins.file-management" },

  -- Autocompletion
  { import = "NeutronVim.plugins.cmp" },

  -- LSP
  { import = "NeutronVim.plugins.lsp" },

  -- Required by NeutronVim
  { import = "NeutronVim.plugins.imp" },

  -- Terminal
  { import = "NeutronVim.plugins.terminal" },

  -- Git
  { import = "NeutronVim.plugins.git" },
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
      notify = false,
    },
  })
