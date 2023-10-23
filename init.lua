vim.defer_fn(function()
  for _, source in ipairs({
    "remaps",
    "autocmd",
    "icons",
    "global",
    "health",
    "log",
  }) do
    local status_ok, fault = pcall(require, "NeutronVim.core." .. source)
    if not status_ok then
      vim.api.nvim_err_writeln("Error loading " .. source .. "\n\n" .. fault)
    end
  end
end, 0)
require("NeutronVim.core.bootstrap")
require("NeutronVim.core.opts")

vim.cmd([[autocmd VimEnter * colorscheme tokyonight]])

vim.opt.background = "dark"

vim.cmd([[autocmd VimEnter * highlight Keyword gui=italic guifg=#F08753]])
vim.cmd([[autocmd VimEnter * highlight Visual gui=nocombine guifg=#EA3535]])
vim.cmd([[autocmd VimEnter * highlight Comment gui=italic,underline guifg=#a1afaf]])
vim.cmd([[autocmd VimEnter * highlight Normal gui=nocombine guifg=Cyan]])
vim.cmd([[autocmd VimEnter * highlight Number gui=italic guifg=#f7768e]])
vim.cmd([[autocmd VimEnter * highlight String gui=italic guifg=#69ff00]])
vim.cmd([[autocmd VimEnter * highlight @variable gui=nocombine guifg=#7fe1aa]])
vim.cmd([[autocmd VimEnter * highlight @field gui=italic guifg=#2ac3de]])
vim.cmd([[autocmd VimEnter * highlight @property gui=italic guifg=lightgreen]])
vim.cmd([[autocmd VimEnter * highlight Special gui=italic guifg=gold]])
vim.cmd([[autocmd VimEnter * highlight Function gui=italic guifg=orange]])
vim.cmd([[autocmd VimEnter * highlight NvimTreeIndentMarker guifg=#61afef]])
vim.cmd([[autocmd VimEnter * filetype plugin indent on]])
vim.cmd([[autocmd VimEnter * syntax on]])
