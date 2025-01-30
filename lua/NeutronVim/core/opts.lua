local opts = {
	General = {
		exrc = true,
		spell = false,
		wrap = false,
		linebreak = true,
		ruler = false,
		conceallevel = 0,
		timeoutlen = 500,
		updatetime = 500,
		-- updatetime = 1500 -- 500?,
		-- conceallevel = 0 -- 2?,
		wildignore = { "*.pyc,__pycache__,node_modules,*.lock,package%-lock%.json,target" },
	},
	Backup = { backup = false, writebackup = false, swapfile = false },
	Layout = {
		scrolloff = 999,
		splitright = true,
		splitbelow = true,
		pumheight = 10,
		incsearch = true,
		showmode = false,
		showtabline = 2,
		laststatus = 3,
	},
	Edit = {
		completeopt = "menu,menuone,noselect,popup",
		virtualedit = "block",
		ignorecase = true,
		clipboard = "unnamedplus",
		iskeyword = vim.o.iskeyword .. ",-",
	},
	-- Fold = {
	-- 	foldmethod = "expr",
	-- 	foldlevelstart = 99,
	-- 	foldexpr = "v:lua.vim.treesitter.foldexpr()",
	-- 	foldtext = 'v:lua.require("essentials").simple_fold()',
	-- },
	UI = {
		pumblend = 30,
		inccommand = "split",
		termguicolors = true,
		number = true,
		relativenumber = true,
		signcolumn = "yes:2",
		showmatch = true,
		background = "dark",
		cursorline = true,
		-- guifont = "JetBrainsMono Nerd Font:h10:b",
		shortmess = "lroOstTWICS",
		-- fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" },
	},
	Tabspace = {
		shiftwidth = 2,
		tabstop = 2,
		softtabstop = 2,
		expandtab = true,
		smartindent = true,
		breakindent = true,
		autoindent = true,
		preserveindent = true,
		smarttab = true,
	},
	Extra = {
		mouse = "a",
		mousescroll = "ver:1,hor:0",
		numberwidth = 4,
		-- BUG: wth? commenting works?
		-- hlsearch = true,
		smartcase = true,
		hidden = true,
		errorbells = false,
		cursorline = true,
		shada = "!,'1000,<50,s10,h",
		-- All nvim edits at one place
		undodir = os.getenv("HOME") .. "/.vim/undodir",
		undofile = true,
		backspace = "indent,eol,start",
		shell = os.getenv("SHELL") or "/usr/bin/bash",
		lazyredraw = false,
		mousemoveevent = true,
		guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
		colorcolumn = "100",
		splitkeep = "screen",
		sessionoptions = "buffers,curdir,folds,tabpages,winpos,winsize",
		sidescrolloff = 8,
	},
}

vim.g.markdown_recommended_style = 0
vim.g.python3_host_prog = "/usr/bin/python"
vim.g.gruvbox_material_better_performance = 1
vim.g.url_regex =
	"\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"

for _, section in pairs(opts) do
	for k, v in pairs(section) do
		vim.opt[k] = v
	end
end
