local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
  { import = "NeutronVim.plugins" },
  { import = "NeutronVim.plugins.ui" },
  { import = "NeutronVim.plugins.file-management" },
  { import = "NeutronVim.plugins.cmp-lsp" },
  { import = "NeutronVim.plugins.git" },
  -- { import = "NeutronVim.plugins.lsp"},
}, {
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
