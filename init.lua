require("NeutronVim.core.opts")
require("NeutronVim.core.bootstrap")
require("NeutronVim.core.health")
require("NeutronVim.core.autocmd")
local modules = {
  "NeutronVim.core.remaps",
  "NeutronVim.core.icons",
  "NeutronVim.core.global",
  "NeutronVim.core.log",
}
local async
async = vim.loop.new_async(vim.schedule_wrap(function()
  for i = 1, #modules, 1 do
    local ok, res = xpcall(require, debug.traceback, modules[i])
    if not ok then
      print("Error loading module : " .. modules[i])
      print(res)
    end
  end
  async:close()
end))
async:send()

vim.opt.background = "dark"
vim.cmd([[colorscheme tokyonight]])

vim.cmd([[highlight Keyword gui=italic guifg=#F08753]])
vim.cmd([[highlight Visual gui=nocombine guifg=#EA3535]])
vim.cmd([[highlight Comment gui=italic,underline guifg=#a1afaf]])
vim.cmd([[highlight Normal gui=nocombine guifg=Cyan]])
vim.cmd([[highlight Number gui=italic guifg=#f7768e]])
vim.cmd([[highlight String gui=italic guifg=#69ff00]])
vim.cmd([[highlight @variable gui=nocombine guifg=#bab86c]])
vim.cmd([[highlight @field gui=italic guifg=#2ac3de]])
vim.cmd([[highlight @property gui=italic guifg=lightgreen]])
vim.cmd([[highlight NvimTreeIndentMarker guifg=#61afef]])
vim.cmd([[highlight Special gui=italic guifg=gold]])
vim.cmd([[highlight Function gui=italic guifg=orange]])
vim.cmd([[filetype plugin indent on]])
vim.cmd([[syntax on]])
