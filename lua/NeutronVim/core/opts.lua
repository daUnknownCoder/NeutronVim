local options = {
  autoindent = true,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  showtabline = 1,
  showmatch = true,
  ruler = false,
  cul = true,
  cmdheight = 1,
  scrolloff = 3,
  mouse = "a",

  number = true,
  relativenumber = true,
  numberwidth = 4,
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,
  spell = true,
  spelllang = { "en_us" },

  splitbelow = true,
  splitright = true,

  termguicolors = true,
  hidden = true,
  signcolumn = "yes",
  showmode = false,
  errorbells = false,
  wrap = false,
  cursorline = true,
  completeopt = { "menuone", "noselect", "noinsert" },

  backup = false,
  writebackup = false,
  swapfile = false,
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  undofile = true,
  backspace = "indent,eol,start",

  updatetime = 50,

  clipboard = "unnamedplus",
  shell = "/bin/bash",
  lazyredraw = false,
}

-- Make cursor blink
vim.opt.guicursor = {
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

vim.opt.iskeyword:append("-")
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.shortmess:append("asI")
vim.opt.shadafile = "NONE"
vim.o.termguicolors = true
vim.g.markdown_recommended_style = 0

for option, value in pairs(options) do
  vim.opt[option] = value
end

vim.cmd([[autocmd VimEnter * colorscheme tokyonight]])
