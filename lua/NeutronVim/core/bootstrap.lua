vim.g.mapleader = " "
local icons_ok, icons = pcall(require, "NeutronVim.core.icons")
if not icons_ok then
  print("Unable to import icons!")
end

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
  if vim.api.nvim_get_vvar "shell_error" ~= 0 then
    vim.api.nvim_err_writeln("Error cloning lazy.nvim repository...\n\n")
  end
  vim.opt.cmdheight = 1
  vim.notify "Please wait while plugins are installed..."
  vim.api.nvim_create_autocmd("User", {
    desc = "Load Mason and Treesitter after Lazy installs plugins",
    once = true,
    pattern = "LazyInstall",
    callback = function()
      vim.cmd.bw()
      vim.tbl_map(function(module) pcall(require, module) end, { "nvim-treesitter", "mason" })
      vim.notify "Mason is installing packages if configured, check status with `:Mason`"
    end,
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
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "gzip",
        "zip",
        "zipPlugin",
        "tar",
        "tarPlugin",
        "getscript",
        "getscriptPlugin",
        "vimball",
        "vimballPlugin",
        "2html_plugin",
        "logipat",
        "rrhelper",
        "spellfile_plugin",
        "matchit",
        "matchparen",
        "tohtml",
        "tutor",
        "rplugin",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})
