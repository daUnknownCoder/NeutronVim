-- NeutronVim Plugin Management

require("NeutronVim.lazy")

-- NeutronVim required files
require("NeutronVim.core.remaps")
require("NeutronVim.core.opts")
require("NeutronVim.core.init")
require("NeutronVim.core.icons")

vim.opt.background = "dark"

vim.cmd [[highlight Keyword gui=italic guifg=#F08753]]
vim.cmd [[highlight Visual gui=nocombine guifg=#EA3535]]
vim.cmd [[highlight Comment gui=italic,undercurl guifg=#a1afaf]]
vim.cmd [[highlight Normal gui=nocombine guifg=Cyan]]
vim.cmd [[highlight Number gui=italic guifg=#f7768e]]
vim.cmd [[highlight String gui=italic guifg=#69ff00]]
vim.cmd [[highlight @variable gui=nocombine guifg=#bab86c]]
vim.cmd [[highlight @field gui=italic guifg=#2ac3de]]
vim.cmd [[highlight Special gui=italic guifg=gold]]
vim.cmd [[highlight Function gui=italic guifg=orange]]
vim.cmd [[highlight NvimTreeIndentMarker guifg=#61afef]]
vim.cmd [[filetype plugin indent on
  syntax on]]
vim.cmd [[autocmd BufRead,BufNewFile ~/.config/hypr/* TSBufEnable highlight]]
