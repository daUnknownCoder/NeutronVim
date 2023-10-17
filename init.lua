for _, source in ipairs({
  "NeutronVim.lazy",
  "NeutronVim.core.remaps",
  "NeutronVim.core.opts",
  "NeutronVim.core.autocmd",
  "NeutronVim.core.icons",
}) do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("Error loading " .. source .. "\n\n" .. fault)
  end
end

vim.opt.background = "dark"

vim.cmd([[highlight Keyword gui=italic guifg=#F08753]])
vim.cmd([[highlight Visual gui=nocombine guifg=#EA3535]])
vim.cmd([[highlight Comment gui=italic,underline guifg=#a1afaf]])
vim.cmd([[highlight Normal gui=nocombine guifg=Cyan]])
vim.cmd([[highlight Number gui=italic guifg=#f7768e]])
vim.cmd([[highlight String gui=italic guifg=#69ff00]])
vim.cmd([[highlight @variable gui=nocombine guifg=#bab86c]])
vim.cmd([[highlight @field gui=italic guifg=#2ac3de]])
vim.cmd([[highlight @property gui=italic guifg=lightgreen]])
vim.cmd([[highlight Special gui=italic guifg=gold]])
vim.cmd([[highlight Function gui=italic guifg=orange]])
vim.cmd([[highlight NvimTreeIndentMarker guifg=#61afef]])
vim.cmd([[filetype plugin indent on
  syntax on]])
